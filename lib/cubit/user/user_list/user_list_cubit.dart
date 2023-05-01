import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:users_app/model/user/user.dart';
import 'package:users_app/service/user/user_service.dart';

import '../../../core/init/locator.dart';

part 'user_list_state.dart';

class UserListCubit extends Cubit<UserListState> {
  UserListCubit() : super(UserListInitialState());
  final _logger = getIt<Logger>();
  final _userService = getIt<UserService>();
  List<User> _allUserList = [];
  List<User> _searchedUserList = [];

  Future<void> getuserList() async {
    try {
      emit(UserListLoadingState());

      var response = await _userService.getUserList();

      if (response != null) {
        _allUserList = response;
        _allUserList.sort(
          (a, b) => a.name!.compareTo(b.name!),
        );
        _logger
            .w('User List Response -- ${_allUserList.map((e) => e.toJson())}');

        emit(UserListLoadedState(_allUserList));
      } else {
        emit(UserListErrorState(
            'Kullanıcı Liste Bilgileri Getirilemedi! Lütfen Tekrar Deneyin'));
      }
    } on DioError catch (error) {
      _logger.e('UserListCubit ERROR - > ${error.response}');
      emit(UserListErrorState(
          'List Bilgileri Getirilemedi! Lütfen Tekrar Deneyin'));
    }
  }

  searchUser({required String searchText}) {
    _searchedUserList.clear();
    if (searchText.isNotEmpty) {
      _allUserList.forEach((user) {
        if (user.username!
            .trim()
            .toLowerCase()
            .contains(searchText.trim().toLowerCase())) {
          _searchedUserList.add(user);
        }
      });
      _searchedUserList.sort(
        (a, b) => a.username!.compareTo(b.username!),
      );
      if (_searchedUserList.isEmpty) {
        emit(UserListErrorState('Aradığınız Kullanıcı Bulunamadı!'));
      } else {
        emit(UserListLoadedState(_searchedUserList));
      }
    } else {
      emit(UserListLoadedState(_allUserList));
    }
  }
}
