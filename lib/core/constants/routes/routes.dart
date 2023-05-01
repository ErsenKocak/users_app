import 'package:flutter/material.dart';
import 'package:users_app/view/user/user_list/user_list_view.dart';

import 'routes_name.dart';

var appRoutes = {
  AppRoutesNames.userListView: (context) => (const UserListView()),
};

extension AppRouteWidgetExtension on String? {
  Widget get getScreen {
    switch (this) {
      case AppRoutesNames.userListView:
        return const UserListView();

      default:
        return const UserListView();
    }
  }
}
