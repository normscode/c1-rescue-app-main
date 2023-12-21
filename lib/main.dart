import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ralert/config/routes/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ralert/config/theme/theme.dart';
import 'package:ralert/dependency.injection.dart';
import 'package:ralert/presentation/state/admin/admin_cubit.dart';
import 'package:ralert/presentation/state/auth/auth_cubit.dart';
import 'package:ralert/presentation/state/common/common_cubit.dart';
import 'package:ralert/presentation/state/edit_profile/edit_profile_cubit.dart';
import 'package:ralert/presentation/state/emergency/emergency_cubit.dart';
import 'package:ralert/presentation/state/emergency_list/emergency_list_cubit.dart';
import 'package:ralert/presentation/state/emergency_live/emergency_live_cubit.dart';
import 'package:ralert/presentation/state/getself/getself_cubit.dart';
import 'package:ralert/presentation/state/medical_info/medical_info_cubit.dart';
import 'package:ralert/presentation/state/motion/motion_cubit.dart';
import 'package:ralert/presentation/state/radar/radar_cubit.dart';
import 'package:ralert/presentation/state/storage_image/storage_image_cubit.dart';
import 'package:ralert/presentation/state/usercheck/usercheck_cubit.dart';
import 'package:ralert/presentation/state/verification/verification_cubit.dart';
import 'package:ralert/presentation/state/verification_process/verification_process_cubit.dart';
import 'package:ralert/services/services.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initializeDependencies();
  initializeServices();
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});
  
  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<UsercheckCubit>()..onUsercheck()),
        BlocProvider(create: (context) => sl<MotionCubit>()),
        BlocProvider(create: (context) => sl<AuthCubit>()),
        BlocProvider(create: (context) => sl<GetselfCubit>()),
        BlocProvider(create: (context) => sl<LatLngCubit>()),
        BlocProvider(create: (context) => sl<GenderCubit>()),
        BlocProvider(create: (context) => sl<EmergencyCubit>()),
        BlocProvider(create: (context) => sl<RadarCubit>()),
        BlocProvider(create: (context) => sl<GeocodingCubit>()),
        BlocProvider(create: (context) => sl<EmergencyLiveCubit>()),
        BlocProvider(create: (context) => sl<EditProfileCubit>()),
        BlocProvider(create: (context) => sl<MedicalInfoCubit>()),
        BlocProvider(create: (context) => sl<EmergencyListCubit>()),
        BlocProvider(create: (context) => sl<StorageImageCubit>()),
        BlocProvider(create: (context) => sl<VerificationProcessCubit>()),
        BlocProvider(create: (context) => sl<VerificationCubit>()),
        BlocProvider(create: (context) => sl<AdminCubit>()),
      ],
      child: MaterialApp.router(
        title: "Ralert",
        routerConfig: appRouter.config(),
        debugShowCheckedModeBanner: false,
        theme: TAppTheme.lightTheme,
        themeMode: ThemeMode.system,
        builder: EasyLoading.init(),
      )
    );
  }
}