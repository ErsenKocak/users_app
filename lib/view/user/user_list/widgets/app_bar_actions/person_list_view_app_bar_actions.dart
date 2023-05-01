import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/custom_icon_button/custom_icon_button.dart';
import '../../../../../cubit/user/user_list/user_list_cubit.dart';

userListViewAppBarActions({required BuildContext context}) => [
      CustomIconButton(
        message: 'Yenile',
        icon: const Icon(Icons.refresh),
        callBack: () {
          context.read<UserListCubit>().getuserList();
        },
      )
    ];
