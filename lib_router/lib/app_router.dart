import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lib_router/app_bundle.dart';
import 'package:lib_router/redirect_interceptor.dart';

///
/// @date: 2022/4/8 12:03
/// @author: TangRen
/// @remark:
///
class AppRouter extends FluroRouter {
  static final appRouter = AppRouter();

  ///bundle and routeSettings only one
  ///Both can use bundle.=>>routeSettings.arguments=bundle
  @override
  Future navigateTo(BuildContext context, String path,
      {bool replace = false,
      bool clearStack = false,
      bool maintainState = true,
      bool rootNavigator = false,
      RedirectInterceptor? interceptor,
      Bundle? bundle,
      TransitionType? transition,
      Duration? transitionDuration,
      RouteTransitionsBuilder? transitionBuilder,
      RouteSettings? routeSettings}) {
    if (interceptor?.needRedirect() ?? false) {
      return interceptor!.navigateTo(context);
    }
    if (bundle != null) {
      routeSettings =
          RouteSettings(arguments: bundle, name: routeSettings?.name);
    }
    return super.navigateTo(context, path,
        replace: replace,
        clearStack: clearStack,
        maintainState: maintainState,
        rootNavigator: rootNavigator,
        transition: transition,
        transitionDuration: transitionDuration,
        transitionBuilder: transitionBuilder,
        routeSettings: routeSettings);
  }

  ///back home and clear other page
  ///example:Home ->A->B->C:popToHome ->Home
  void popToHome(BuildContext context) {
    popUntil(context, (route) => route.isFirst);
  }

  @override
  void pop<T>(BuildContext context, [T? result]) {
    if (canPop(context)) {
      super.pop(context, result);
    }
  }

  void popUntil(BuildContext context, RoutePredicate predicate) {
    Navigator.popUntil(context, predicate);
  }

  bool canPop(BuildContext context) {
    return Navigator.canPop(context);
  }
}
