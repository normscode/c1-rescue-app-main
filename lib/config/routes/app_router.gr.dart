// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i27;
import 'package:flutter/material.dart' as _i28;
import 'package:ralert/presentation/screen/admin/admin_incidents.dart' as _i2;
import 'package:ralert/presentation/screen/admin/admintools.screen.dart' as _i3;
import 'package:ralert/presentation/screen/admin/user.list.dart' as _i21;
import 'package:ralert/presentation/screen/admin/user.pending.verification.screen.dart'
    as _i23;
import 'package:ralert/presentation/screen/admin/user.verification.screen.dart'
    as _i24;
import 'package:ralert/presentation/screen/auth/auth.manager.dart' as _i5;
import 'package:ralert/presentation/screen/auth/login.screen.dart' as _i11;
import 'package:ralert/presentation/screen/auth/signup.screen.dart' as _i18;
import 'package:ralert/presentation/screen/auth/terms.screen.dart' as _i19;
import 'package:ralert/presentation/screen/main/main.screen.dart' as _i12;
import 'package:ralert/presentation/screen/main/profile/medicalinfo.screen.dart'
    as _i13;
import 'package:ralert/presentation/screen/main/profile/profile.screen.dart'
    as _i15;
import 'package:ralert/presentation/screen/main/profile/updateprofile.screen.dart'
    as _i20;
import 'package:ralert/presentation/screen/main/profile/wizard/addtolist.screen.dart'
    as _i1;
import 'package:ralert/presentation/screen/main/rescuer/emergency.list.screen.dart'
    as _i7;
import 'package:ralert/presentation/screen/main/rescuer/incident.screen.dart'
    as _i9;
import 'package:ralert/presentation/screen/main/rescuer/incident.view.screen.dart'
    as _i10;
import 'package:ralert/presentation/screen/main/rescuer/rescuer.map.screen.dart'
    as _i16;
import 'package:ralert/presentation/screen/main/user/help.screen.dart' as _i8;
import 'package:ralert/presentation/screen/main/user/sos.screen.dart' as _i17;
import 'package:ralert/presentation/screen/main/user/user.map.screen.dart'
    as _i22;
import 'package:ralert/presentation/screen/onboarding/almost_there.dart' as _i4;
import 'package:ralert/presentation/screen/onboarding/onboarding_screens.dart'
    as _i14;
import 'package:ralert/presentation/screen/onboarding/welcome.dart' as _i26;
import 'package:ralert/presentation/screen/verification/camera.screen.dart'
    as _i6;
import 'package:ralert/presentation/screen/verification/verification.process.screen.dart'
    as _i25;

abstract class $AppRouter extends _i27.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i27.PageFactory> pagesMap = {
    AddToListRoute.name: (routeData) {
      final args = routeData.argsAs<AddToListRouteArgs>();
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AddToListScreen(
          args.editType,
          key: args.key,
        ),
      );
    },
    AdminIncidentListRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AdminIncidentListScreen(),
      );
    },
    AdminRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.AdminScreen(),
      );
    },
    AlmostThereRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.AlmostThereScreen(),
      );
    },
    AuthManagerRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.AuthManagerScreen(),
      );
    },
    CameraRoute.name: (routeData) {
      final args = routeData.argsAs<CameraRouteArgs>();
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.CameraScreen(
          args.captureType,
          key: args.key,
        ),
      );
    },
    EmergenciesListRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.EmergenciesListScreen(),
      );
    },
    HelpRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.HelpScreen(),
      );
    },
    IncidentRoute.name: (routeData) {
      final args = routeData.argsAs<IncidentRouteArgs>();
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.IncidentScreen(
          args.data,
          key: args.key,
        ),
      );
    },
    IncidentViewRoute.name: (routeData) {
      final args = routeData.argsAs<IncidentViewRouteArgs>();
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.IncidentViewScreen(
          args.data,
          key: args.key,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.LoginScreen(),
      );
    },
    MainRoute.name: (routeData) {
      final args = routeData.argsAs<MainRouteArgs>();
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.MainScreen(
          key: args.key,
          userType: args.userType,
        ),
      );
    },
    MedicalInfoRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.MedicalInfoScreen(),
      );
    },
    OnboardingRoutes.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.OnboardingScreens(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.ProfileScreen(),
      );
    },
    RescuerMapRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.RescuerMapScreen(),
      );
    },
    SOSRoute.name: (routeData) {
      final args =
          routeData.argsAs<SOSRouteArgs>(orElse: () => const SOSRouteArgs());
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.SOSScreen(
          key: args.key,
          alertSent: args.alertSent,
          startingDuration: args.startingDuration,
          fromCarCrash: args.fromCarCrash,
        ),
      );
    },
    SignUpRoute.name: (routeData) {
      final args = routeData.argsAs<SignUpRouteArgs>();
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.SignUpScreen(
          key: args.key,
          userType: args.userType,
        ),
      );
    },
    TermsAndConditionsRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.TermsAndConditionsScreen(),
      );
    },
    UpdateProfileRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.UpdateProfileScreen(),
      );
    },
    UserListRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i21.UserListScreen(),
      );
    },
    UserMapRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i22.UserMapScreen(),
      );
    },
    UserPendingVerificationRoute.name: (routeData) {
      final args = routeData.argsAs<UserPendingVerificationRouteArgs>();
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i23.UserPendingVerificationScreen(
          args.pending,
          key: args.key,
        ),
      );
    },
    UserVerificationRoute.name: (routeData) {
      final args = routeData.argsAs<UserVerificationRouteArgs>();
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i24.UserVerificationScreen(
          args.verification,
          args.user,
          key: args.key,
        ),
      );
    },
    VerificationProcessRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i25.VerificationProcessScreen(),
      );
    },
    WelcomeRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i26.WelcomeScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddToListScreen]
class AddToListRoute extends _i27.PageRouteInfo<AddToListRouteArgs> {
  AddToListRoute({
    required String editType,
    _i28.Key? key,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          AddToListRoute.name,
          args: AddToListRouteArgs(
            editType: editType,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'AddToListRoute';

  static const _i27.PageInfo<AddToListRouteArgs> page =
      _i27.PageInfo<AddToListRouteArgs>(name);
}

class AddToListRouteArgs {
  const AddToListRouteArgs({
    required this.editType,
    this.key,
  });

  final String editType;

  final _i28.Key? key;

  @override
  String toString() {
    return 'AddToListRouteArgs{editType: $editType, key: $key}';
  }
}

/// generated route for
/// [_i2.AdminIncidentListScreen]
class AdminIncidentListRoute extends _i27.PageRouteInfo<void> {
  const AdminIncidentListRoute({List<_i27.PageRouteInfo>? children})
      : super(
          AdminIncidentListRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdminIncidentListRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i3.AdminScreen]
class AdminRoute extends _i27.PageRouteInfo<void> {
  const AdminRoute({List<_i27.PageRouteInfo>? children})
      : super(
          AdminRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdminRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i4.AlmostThereScreen]
class AlmostThereRoute extends _i27.PageRouteInfo<void> {
  const AlmostThereRoute({List<_i27.PageRouteInfo>? children})
      : super(
          AlmostThereRoute.name,
          initialChildren: children,
        );

  static const String name = 'AlmostThereRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i5.AuthManagerScreen]
class AuthManagerRoute extends _i27.PageRouteInfo<void> {
  const AuthManagerRoute({List<_i27.PageRouteInfo>? children})
      : super(
          AuthManagerRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthManagerRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i6.CameraScreen]
class CameraRoute extends _i27.PageRouteInfo<CameraRouteArgs> {
  CameraRoute({
    required String captureType,
    _i28.Key? key,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          CameraRoute.name,
          args: CameraRouteArgs(
            captureType: captureType,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'CameraRoute';

  static const _i27.PageInfo<CameraRouteArgs> page =
      _i27.PageInfo<CameraRouteArgs>(name);
}

class CameraRouteArgs {
  const CameraRouteArgs({
    required this.captureType,
    this.key,
  });

  final String captureType;

  final _i28.Key? key;

  @override
  String toString() {
    return 'CameraRouteArgs{captureType: $captureType, key: $key}';
  }
}

/// generated route for
/// [_i7.EmergenciesListScreen]
class EmergenciesListRoute extends _i27.PageRouteInfo<void> {
  const EmergenciesListRoute({List<_i27.PageRouteInfo>? children})
      : super(
          EmergenciesListRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmergenciesListRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i8.HelpScreen]
class HelpRoute extends _i27.PageRouteInfo<void> {
  const HelpRoute({List<_i27.PageRouteInfo>? children})
      : super(
          HelpRoute.name,
          initialChildren: children,
        );

  static const String name = 'HelpRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i9.IncidentScreen]
class IncidentRoute extends _i27.PageRouteInfo<IncidentRouteArgs> {
  IncidentRoute({
    required dynamic data,
    _i28.Key? key,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          IncidentRoute.name,
          args: IncidentRouteArgs(
            data: data,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'IncidentRoute';

  static const _i27.PageInfo<IncidentRouteArgs> page =
      _i27.PageInfo<IncidentRouteArgs>(name);
}

class IncidentRouteArgs {
  const IncidentRouteArgs({
    required this.data,
    this.key,
  });

  final dynamic data;

  final _i28.Key? key;

  @override
  String toString() {
    return 'IncidentRouteArgs{data: $data, key: $key}';
  }
}

/// generated route for
/// [_i10.IncidentViewScreen]
class IncidentViewRoute extends _i27.PageRouteInfo<IncidentViewRouteArgs> {
  IncidentViewRoute({
    required dynamic data,
    _i28.Key? key,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          IncidentViewRoute.name,
          args: IncidentViewRouteArgs(
            data: data,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'IncidentViewRoute';

  static const _i27.PageInfo<IncidentViewRouteArgs> page =
      _i27.PageInfo<IncidentViewRouteArgs>(name);
}

class IncidentViewRouteArgs {
  const IncidentViewRouteArgs({
    required this.data,
    this.key,
  });

  final dynamic data;

  final _i28.Key? key;

  @override
  String toString() {
    return 'IncidentViewRouteArgs{data: $data, key: $key}';
  }
}

/// generated route for
/// [_i11.LoginScreen]
class LoginRoute extends _i27.PageRouteInfo<void> {
  const LoginRoute({List<_i27.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i12.MainScreen]
class MainRoute extends _i27.PageRouteInfo<MainRouteArgs> {
  MainRoute({
    _i28.Key? key,
    required String userType,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          MainRoute.name,
          args: MainRouteArgs(
            key: key,
            userType: userType,
          ),
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const _i27.PageInfo<MainRouteArgs> page =
      _i27.PageInfo<MainRouteArgs>(name);
}

class MainRouteArgs {
  const MainRouteArgs({
    this.key,
    required this.userType,
  });

  final _i28.Key? key;

  final String userType;

  @override
  String toString() {
    return 'MainRouteArgs{key: $key, userType: $userType}';
  }
}

/// generated route for
/// [_i13.MedicalInfoScreen]
class MedicalInfoRoute extends _i27.PageRouteInfo<void> {
  const MedicalInfoRoute({List<_i27.PageRouteInfo>? children})
      : super(
          MedicalInfoRoute.name,
          initialChildren: children,
        );

  static const String name = 'MedicalInfoRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i14.OnboardingScreens]
class OnboardingRoutes extends _i27.PageRouteInfo<void> {
  const OnboardingRoutes({List<_i27.PageRouteInfo>? children})
      : super(
          OnboardingRoutes.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoutes';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i15.ProfileScreen]
class ProfileRoute extends _i27.PageRouteInfo<void> {
  const ProfileRoute({List<_i27.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i16.RescuerMapScreen]
class RescuerMapRoute extends _i27.PageRouteInfo<void> {
  const RescuerMapRoute({List<_i27.PageRouteInfo>? children})
      : super(
          RescuerMapRoute.name,
          initialChildren: children,
        );

  static const String name = 'RescuerMapRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i17.SOSScreen]
class SOSRoute extends _i27.PageRouteInfo<SOSRouteArgs> {
  SOSRoute({
    _i28.Key? key,
    bool? alertSent,
    int? startingDuration,
    bool? fromCarCrash,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          SOSRoute.name,
          args: SOSRouteArgs(
            key: key,
            alertSent: alertSent,
            startingDuration: startingDuration,
            fromCarCrash: fromCarCrash,
          ),
          initialChildren: children,
        );

  static const String name = 'SOSRoute';

  static const _i27.PageInfo<SOSRouteArgs> page =
      _i27.PageInfo<SOSRouteArgs>(name);
}

class SOSRouteArgs {
  const SOSRouteArgs({
    this.key,
    this.alertSent,
    this.startingDuration,
    this.fromCarCrash,
  });

  final _i28.Key? key;

  final bool? alertSent;

  final int? startingDuration;

  final bool? fromCarCrash;

  @override
  String toString() {
    return 'SOSRouteArgs{key: $key, alertSent: $alertSent, startingDuration: $startingDuration, fromCarCrash: $fromCarCrash}';
  }
}

/// generated route for
/// [_i18.SignUpScreen]
class SignUpRoute extends _i27.PageRouteInfo<SignUpRouteArgs> {
  SignUpRoute({
    _i28.Key? key,
    required String userType,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          SignUpRoute.name,
          args: SignUpRouteArgs(
            key: key,
            userType: userType,
          ),
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const _i27.PageInfo<SignUpRouteArgs> page =
      _i27.PageInfo<SignUpRouteArgs>(name);
}

class SignUpRouteArgs {
  const SignUpRouteArgs({
    this.key,
    required this.userType,
  });

  final _i28.Key? key;

  final String userType;

  @override
  String toString() {
    return 'SignUpRouteArgs{key: $key, userType: $userType}';
  }
}

/// generated route for
/// [_i19.TermsAndConditionsScreen]
class TermsAndConditionsRoute extends _i27.PageRouteInfo<void> {
  const TermsAndConditionsRoute({List<_i27.PageRouteInfo>? children})
      : super(
          TermsAndConditionsRoute.name,
          initialChildren: children,
        );

  static const String name = 'TermsAndConditionsRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i20.UpdateProfileScreen]
class UpdateProfileRoute extends _i27.PageRouteInfo<void> {
  const UpdateProfileRoute({List<_i27.PageRouteInfo>? children})
      : super(
          UpdateProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'UpdateProfileRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i21.UserListScreen]
class UserListRoute extends _i27.PageRouteInfo<void> {
  const UserListRoute({List<_i27.PageRouteInfo>? children})
      : super(
          UserListRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserListRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i22.UserMapScreen]
class UserMapRoute extends _i27.PageRouteInfo<void> {
  const UserMapRoute({List<_i27.PageRouteInfo>? children})
      : super(
          UserMapRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserMapRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i23.UserPendingVerificationScreen]
class UserPendingVerificationRoute
    extends _i27.PageRouteInfo<UserPendingVerificationRouteArgs> {
  UserPendingVerificationRoute({
    required List<dynamic> pending,
    _i28.Key? key,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          UserPendingVerificationRoute.name,
          args: UserPendingVerificationRouteArgs(
            pending: pending,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'UserPendingVerificationRoute';

  static const _i27.PageInfo<UserPendingVerificationRouteArgs> page =
      _i27.PageInfo<UserPendingVerificationRouteArgs>(name);
}

class UserPendingVerificationRouteArgs {
  const UserPendingVerificationRouteArgs({
    required this.pending,
    this.key,
  });

  final List<dynamic> pending;

  final _i28.Key? key;

  @override
  String toString() {
    return 'UserPendingVerificationRouteArgs{pending: $pending, key: $key}';
  }
}

/// generated route for
/// [_i24.UserVerificationScreen]
class UserVerificationRoute
    extends _i27.PageRouteInfo<UserVerificationRouteArgs> {
  UserVerificationRoute({
    required dynamic verification,
    required dynamic user,
    _i28.Key? key,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          UserVerificationRoute.name,
          args: UserVerificationRouteArgs(
            verification: verification,
            user: user,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'UserVerificationRoute';

  static const _i27.PageInfo<UserVerificationRouteArgs> page =
      _i27.PageInfo<UserVerificationRouteArgs>(name);
}

class UserVerificationRouteArgs {
  const UserVerificationRouteArgs({
    required this.verification,
    required this.user,
    this.key,
  });

  final dynamic verification;

  final dynamic user;

  final _i28.Key? key;

  @override
  String toString() {
    return 'UserVerificationRouteArgs{verification: $verification, user: $user, key: $key}';
  }
}

/// generated route for
/// [_i25.VerificationProcessScreen]
class VerificationProcessRoute extends _i27.PageRouteInfo<void> {
  const VerificationProcessRoute({List<_i27.PageRouteInfo>? children})
      : super(
          VerificationProcessRoute.name,
          initialChildren: children,
        );

  static const String name = 'VerificationProcessRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i26.WelcomeScreen]
class WelcomeRoute extends _i27.PageRouteInfo<void> {
  const WelcomeRoute({List<_i27.PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}
