import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_app/core/constants/extensions/sized_box/sized_box_extension.dart';
import 'package:users_app/core/widgets/custom_icon_button/custom_icon_button.dart';
import 'package:users_app/core/widgets/custom_progress_indicator/custom_progress_indicator_widget.dart';
import 'package:users_app/core/widgets/popup/popup.dart';
import 'package:users_app/core/widgets/search_bar/search_bar_widget.dart';
import 'package:users_app/service/user/user_image_service.dart';

import 'package:users_app/view/user/user_list/widgets/app_bar_actions/person_list_view_app_bar_actions.dart';

import '../../../core/constants/colors.dart';
import '../../../core/init/locator.dart';
import '../../../core/widgets/appbar/app_bar_widget.dart';
import '../../../core/widgets/card/custom_card_widget.dart';
import '../../../cubit/search_active/search_active_cubit.dart';
import '../../../cubit/user/user_list/user_list_cubit.dart';
import '../../../helper/device_screen_info/device_screen_info.dart';
import '../../../model/user/user.dart';

class UserListView extends StatefulWidget {
  const UserListView({super.key});

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _userSearchTextController = TextEditingController();
  bool isSearchActive = false;
  late FocusNode _searchBarFocusNode;
  final _userImageService = getIt<UserImageService>();
  @override
  void initState() {
    super.initState();
    _searchBarFocusNode = FocusNode();
    context.read<UserListCubit>().getuserList();
  }

  @override
  void dispose() {
    _searchBarFocusNode.dispose();
    super.dispose();
  }

  _buildAppBar(BuildContext context) {
    return appBarWidget(AppBar().preferredSize.height, context, 'Kullanıcılar',
        _scaffoldKey, userListViewAppBarActions(context: context), null);
  }

  _userCard(User user) {
    return FutureBuilder(
      future: getUserImage(user.id!),
      builder: (context, userImageSnapShot) {
        return InkWell(
          onTap: () {
            _searchBarFocusNode.unfocus();
            _onTapUser(user: user, userImageUrl: userImageSnapShot.data);
          },
          child: CustomCardWidget(
            cardHeader: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Tooltip(
                      message: 'Company',
                      child: Text(
                        user.company?.name ?? '',
                        style:
                            Theme.of(context).textTheme.copyWith().bodyMedium,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ],
            cardBody: [
              Expanded(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(userImageSnapShot.data ??
                        "https://picsum.photos/id/2/5000/3333"),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DeviceInfo.height(1).sbxh,
                      Tooltip(
                        message: 'Name',
                        child: Text(
                          user.name ?? '',
                          style:
                              Theme.of(context).textTheme.copyWith().bodyLarge,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      DeviceInfo.height(1).sbxh,
                      Tooltip(
                        message: 'Username',
                        child: Text(
                          user.username ?? '',
                          style:
                              Theme.of(context).textTheme.copyWith().bodyMedium,
                        ),
                      ),
                      DeviceInfo.height(1).sbxh,
                    ],
                  ),
                ),
              ),
            ],
            cardFooter: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                      color: Colors.grey.shade500,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Tooltip(
                            message: 'Email',
                            child: Text(
                              user.email ?? '',
                              overflow: TextOverflow.ellipsis,
                            )),
                        CustomIconButton(
                            message: 'Show Detail',
                            callBack: () {},
                            icon: const Icon(
                              Icons.keyboard_arrow_right_sharp,
                              color: AppColors.ksecondaryColor,
                            )),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  _onTapUser({required User user, required String userImageUrl}) {
    AppPopup.showInfo(
        buttonText: 'Kapat',
        isUseWitOutMargin: true,
        child: _userDetail(userDetail: user, userImageUrl: userImageUrl));
  }

  Widget _userDetail({required User userDetail, required String userImageUrl}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CircleAvatar(
          radius: 50.0,
          backgroundImage: NetworkImage(userImageUrl),
          backgroundColor: Colors.transparent,
        ),
        Text(
          userDetail.name ?? '',
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          userDetail.username ?? '',
          textAlign: TextAlign.center,
        ),
        DeviceInfo.height(1).sbxh,
        Divider(color: Colors.grey.shade500),
        DeviceInfo.height(1).sbxh,
        _userInformationRow(suffixText: 'Email:', prefixText: userDetail.email),
        _userInformationRow(
            suffixText: 'Telefon:', prefixText: userDetail.phone),
        _userInformationRow(
            suffixText: 'Adres:', prefixText: userDetail.address?.street),
        _userInformationRow(
            suffixText: 'Şehir:', prefixText: userDetail.address?.city),
        _userInformationRow(
            suffixText: 'Konum:',
            prefixText:
                '${userDetail.address?.geo?.lat} / ${userDetail.address?.geo?.lng}'),
      ],
    );
  }

  Widget _userInformationRow({required suffixText, required prefixText}) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(suffixText),
        DeviceInfo.height(3).sbxh,
        Text(
          prefixText,
        ),
      ],
    );
  }

  Future getUserImage(int userId) async {
    var userImageResponse =
        await _userImageService.getUserImage(userId: userId);
    return userImageResponse?.downloadUrl ?? '';
  }

  get _userList {
    return BlocBuilder<UserListCubit, UserListState>(
      builder: (context, userCubitState) {
        if (userCubitState is UserListInitialState) {
          context.read<UserListCubit>().getuserList();
        } else if (userCubitState is UserListLoadingState) {
          return const Center(child: CustomProgressIndicatorWidget());
        } else if (userCubitState is UserListLoadedState) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: userCubitState.userList.length,
            physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics()),
            itemBuilder: (context, index) {
              return _userCard(userCubitState.userList[index]);
            },
          );
        } else if (userCubitState is UserListErrorState) {
          return Center(
            child: Text(userCubitState.errorMessage),
          );
        }
        return const SizedBox();
      },
    );
  }

  get _searchBar {
    return BlocBuilder<SearchActiveCubit, bool>(
      builder: (context, searchState) {
        return SearchBarWidget(
          autoFocus: false,
          focusNode: _searchBarFocusNode,
          buttonColor: AppColors.kprimaryColor,
          borderColor: Colors.grey.shade500,
          inActiveBorderColor: AppColors.kprimaryColor,
          backgroundColor: Colors.white.withOpacity(0),
          searchText: _userSearchTextController.text,
          controller: _userSearchTextController,
          isSecondarySearcBar: true,
          isSearchActive: searchState,
          onChanged: (text) => searchUser(text),
          onSubmitted: (text) => searchUser(text),
          onPressButton: () {
            if (searchState == true) {
              _searchBarFocusNode.unfocus();
              context.read<SearchActiveCubit>().changeState(false);
              context.read<UserListCubit>().searchUser(searchText: '');
              _userSearchTextController.clear();
            } else {
              _searchBarFocusNode.requestFocus();
              context.read<SearchActiveCubit>().changeState(true);
            }
          },
          onTap: () {
            context.read<SearchActiveCubit>().changeState(true);
          },
        );
      },
    );
  }

  void searchUser(String text) async {
    log('Search Employee Text $text');

    context.read<UserListCubit>().searchUser(searchText: text);

    if (text.isNotEmpty) {
      context.read<SearchActiveCubit>().changeState(true);
    } else {
      context.read<SearchActiveCubit>().changeState(false);
    }
  }

  get _body {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        DeviceInfo.height(2).sbxh,
        _searchBar,
        DeviceInfo.height(2).sbxh,
        Expanded(
          child: _userList,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _body,
    );
  }
}
