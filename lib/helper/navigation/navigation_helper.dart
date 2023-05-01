import 'package:flutter/material.dart';
import 'package:users_app/core/constants/routes/routes.dart';
import 'package:users_app/view/user/user_list/user_list_view.dart';

import '../../core/constants/routes/route_effect.dart';
import 'builder.dart';

class NavigationHelper {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Future push(
      {required Widget screen,
      required AppRouteEffect effect,
      Function(dynamic? value)? callback}) async {
    PageRouteTransitionBuilder builder = PageRouteTransitionBuilder(
      page: screen,
      effect: effect,
      settings: RouteSettings(name: screen.runtimeType.toString()),
    );
    print(screen.runtimeType.toString());
    await Navigator.of(navigatorKey.currentContext!)
        .push(builder)
        .then((value) {
      if (callback != null) callback(value);
    });
  }

  static pushWithName(
      {required String? screenName,
      required AppRouteEffect effect,
      Function(dynamic? value)? callback}) {
    var screen = AppRouteWidgetExtension(screenName).getScreen;

    PageRouteTransitionBuilder builder = PageRouteTransitionBuilder(
      page: screen,
      effect: effect,
      settings: RouteSettings(name: screen.runtimeType.toString()),
    );
    print(screen.runtimeType.toString());
    Navigator.of(navigatorKey.currentContext!).push(builder).then((value) {
      if (callback != null) callback(value);
    });
  }

  static pushScreenWithoutEffect(
      {required Widget screen,
      Function(dynamic? value)? callback,
      String? routeName}) {
    PageRouteTransitionBuilder builder = PageRouteTransitionBuilder(
      page: screen,
      settings: RouteSettings(name: screen.runtimeType.toString()),
    );
    Navigator.of(navigatorKey.currentContext!).push(builder).then((value) {
      if (callback != null) callback(value);
    });
  }

  static pushAndRemoveUntil(
      {required Widget screen,
      required AppRouteEffect effect,
      Function(dynamic? value)? callback}) {
    PageRouteTransitionBuilder builder = PageRouteTransitionBuilder(
      page: screen,
      effect: effect,
      settings: RouteSettings(name: screen.runtimeType.toString()),
    );

    Navigator.of(navigatorKey.currentContext!)
        .pushAndRemoveUntil(builder, (_) => false)
        .then((value) {
      if (callback != null) callback(value);
    });
  }

  static pop({dynamic? value}) {
    if (Navigator.of(navigatorKey.currentContext!).canPop()) {
      Navigator.of(navigatorKey.currentContext!).pop(value);
    } else {
      NavigationHelper.pushAndRemoveUntil(
          screen: const UserListView(), effect: AppRouteEffect.leftToRight);
    }
  }
}
