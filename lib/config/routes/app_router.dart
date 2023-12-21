import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
    CustomRoute(page: AuthManagerRoute.page, initial: true),
    CustomRoute(page: WelcomeRoute.page),
    CustomRoute(page: OnboardingRoutes.page),
    CustomRoute(page: AlmostThereRoute.page),
    CustomRoute(page: LoginRoute.page),
    CustomRoute(page: SignUpRoute.page),
    CustomRoute(page: MainRoute.page),
    CustomRoute(page: UserMapRoute.page),
    CustomRoute(page: SOSRoute.page),
    CustomRoute(page: IncidentRoute.page),
    CustomRoute(page: EmergenciesListRoute.page),
    CustomRoute(page: IncidentViewRoute.page),
    CustomRoute(page: AdminIncidentListRoute.page),
    CustomRoute(page: UserListRoute.page),
    CustomRoute(page: UpdateProfileRoute.page),
    CustomRoute(page: MedicalInfoRoute.page),
    CustomRoute(page: AddToListRoute.page),
    CustomRoute(page: VerificationProcessRoute.page),
    CustomRoute(page: CameraRoute.page),
    CustomRoute(page: UserPendingVerificationRoute.page),
    CustomRoute(page: UserVerificationRoute.page),
    CustomRoute(page: TermsAndConditionsRoute.page),
  ];
}