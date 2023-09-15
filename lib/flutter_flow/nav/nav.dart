import 'dart:async';

import 'package:crowds/pages/about_us_page/about_us_page.dart';
import 'package:crowds/pages/create_profile_page/create_profile_page.dart';
import 'package:crowds/pages/forgot_password_page/forgot_password_page.dart';
import 'package:crowds/pages/login_page/login_page.dart';
import 'package:crowds/pages/profile_created_page/profile_created_page.dart';
import 'package:crowds/pages/profile_page/profile_page.dart';
import 'package:crowds/pages/register_page/register_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import '/backend/backend.dart';

import '../../auth/base_auth_user_provider.dart';

import '/index.dart';
import '/main.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'serialization_util.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;

  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;

  bool get loggedIn => user?.loggedIn ?? false;

  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;

  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;

  bool hasRedirect() => _redirectLocation != null;

  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;

  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      errorBuilder: (context, state) => StartPageWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => StartPageWidget(),
        ),
        FFRoute(
          name: 'StartPage',
          path: '/startPage',
          builder: (context, params) => StartPageWidget(),
        ),
        FFRoute(
          name: 'AboutUs',
          path: '/aboutUs',
          builder: (context, params) => AboutUsPage(),
        ),
        FFRoute(
          name: 'OnboardingPage',
          path: '/onboardingPage',
          builder: (context, params) => OnboardingPageWidget(),
        ),
        FFRoute(
          name: 'HomePage',
          path: '/homePage',
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'HomePage')
              : HomePageWidget(),
        ),
        FFRoute(
          name: 'CreateQuestion',
          path: '/createQuestion',
          builder: (context, params) => CreateQuestionWidget(),
        ),
        FFRoute(
          name: 'AnsweringQuestion',
          path: '/answeringQuestion',
          builder: (context, params) => AnsweringQuestionWidget(
            id: params.getParam('id', ParamType.String),
            titleReceived: params.getParam('titleReceived', ParamType.String),
            questionPrice: params.getParam('price', ParamType.double),
            questionReceived:
                params.getParam('questionReceived', ParamType.String),
          ),
        ),
        FFRoute(
          name: 'CreateQuestion_multi-select',
          path: '/createQuestionMultiSelect',
          asyncParams: {
            'gameRecord': getDoc(['games'], GamesRecord.fromSnapshot),
          },
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'CreateQuestion_multi-select')
              : CreateQuestionMultiSelectWidget(
                  gameRecord: params.getParam('gameRecord', ParamType.Document),
                  categoryOffset:
                      params.getParam('categoryOffset', ParamType.int),
                ),
        ),
        FFRoute(
          name: 'LoginPage',
          path: '/loginPage',
          builder: (context, params) => LoginPage(),
        ),
        FFRoute(
          name: 'RegisterPage',
          path: '/registerPage',
          builder: (context, params) => RegisterPage(),
        ),
        FFRoute(
          name: 'ForgotPasswordPage',
          path: '/forgotPasswordPage',
          builder: (context, params) => ForgotPasswordPage(),
        ),
        FFRoute(
          name: 'CreateProfilePage',
          path: '/createProfilePage',
          builder: (context, params) => CreateProfilePage(),
        ),
        FFRoute(
          name: 'ProfileCreatedPage',
          path: '/profileCreatedPage',
          builder: (context, params) => ProfileCreatedPage(),
        ),
        FFRoute(
          name: 'ProfilePage',
          path: '/profilePage',
          builder: (context, params) => ProfilePage(),
        ),
        FFRoute(
          name: 'AnsweringQuestionSuccessfully',
          path: '/answeringQuestionSuccessfully',
          builder: (context, params) => AnsweringQuestionSuccessfullyWidget(
            gameRef: params.getParam(
                'gameRef', ParamType.DocumentReference, false, ['games']),
          ),
        ),
        FFRoute(
          name: 'ListQuestions',
          path: '/listQuestions',
          builder: (context, params) => ListQuestionsWidget(
            gameCode: params.getParam('gameCode', ParamType.int),
          ),
        ),
        FFRoute(
          name: 'CreateQuestion_single-select',
          path: '/createQuestionSingleSelect',
          asyncParams: {
            'gameRecord': getDoc(['games'], GamesRecord.fromSnapshot),
          },
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'CreateQuestion_single-select')
              : CreateQuestionSingleSelectWidget(
                  gameRecord: params.getParam('gameRecord', ParamType.Document),
                  categoryOffset:
                      params.getParam('categoryOffset', ParamType.int),
                ),
        ),
        FFRoute(
          name: 'CreateQuestionIndividually',
          path: '/createQuestionIndividually',
          builder: (context, params) => CreateQuestionIndividuallyWidget(
            typeReceived: params.getParam('typeReceived',
                ParamType.DocumentReference, false, ['questionType']),
          ),
        ),
        FFRoute(
          name: 'CreateQuestion_typeCopy',
          path: '/createQuestionTypeCopy',
          builder: (context, params) => CreateQuestionTypeCopyWidget(
            typeReceived: params.getParam('typeReceived',
                ParamType.DocumentReference, false, ['questionType']),
          ),
        ),
        FFRoute(
          name: 'CreateQuestionSuccessfully',
          path: '/createQuestionSuccessfully',
          builder: (context, params) => CreateQuestionSuccessfullyWidget(
            typeReceived: params.getParam('typeReceived',
                ParamType.DocumentReference, false, ['questionType']),
            title: params.getParam('title', ParamType.String),
            time: params.getParam('time', ParamType.String),
          ),
        ),
        FFRoute(
          name: 'HowDoesItWork',
          path: '/howDoesItWork',
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'HowDoesItWork')
              : HowDoesItWorkWidget(),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;

  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);

  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();

  void clearRedirectLocation() => appState.clearRedirectLocation();

  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};

  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(queryParameters)
    ..addAll(extraMap);

  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.extraMap.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));

  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;

  bool get hasFutures => state.allParams.entries.any(isAsyncParam);

  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, [
    bool isList = false,
    List<String>? collectionNamePath,
  ]) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(param, type, isList,
        collectionNamePath: collectionNamePath);
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.location);
            return '/startPage';
          }
          return null;
        },
        pageBuilder: (context, state) {
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Center(
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        FlutterFlowTheme.of(context).primary,
                      ),
                    ),
                  ),
                )
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder: PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).transitionsBuilder,
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}
