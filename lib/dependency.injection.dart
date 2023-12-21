import 'package:get_it/get_it.dart';
import 'package:ralert/data/data_sources/local/motion_datasource/abstract.dart';
import 'package:ralert/data/data_sources/local/motion_datasource/implementation.dart';
import 'package:ralert/data/data_sources/remote/admin_datasource/abstract.dart';
import 'package:ralert/data/data_sources/remote/admin_datasource/implementation.dart';
import 'package:ralert/data/data_sources/remote/emergency_datasource/abstract.dart';
import 'package:ralert/data/data_sources/remote/emergency_datasource/implementation.dart';
import 'package:ralert/data/data_sources/remote/storage_datasource/abstract.dart';
import 'package:ralert/data/data_sources/remote/storage_datasource/implementation.dart';
import 'package:ralert/data/data_sources/remote/user_datasource/abstract.dart';
import 'package:ralert/data/data_sources/remote/user_datasource/implementation.dart';
import 'package:ralert/data/data_sources/remote/verification_datasource/abstract.dart';
import 'package:ralert/data/data_sources/remote/verification_datasource/implemention.dart';
import 'package:ralert/data/repository/admin.impl.dart';
import 'package:ralert/data/repository/emergency.impl.dart';
import 'package:ralert/data/repository/motion.impl.dart';
import 'package:ralert/data/repository/storage.impl.dart';
import 'package:ralert/data/repository/user.impl.dart';
import 'package:ralert/data/repository/verification.impl.dart';
import 'package:ralert/domain/repository/admin.repo.abstract.dart';
import 'package:ralert/domain/repository/emergency.repo.abstract.dart';
import 'package:ralert/domain/repository/motion.repo.abstract.dart';
import 'package:ralert/domain/repository/storage.repo.abstract.dart';
import 'package:ralert/domain/repository/user.repo.abstract.dart';
import 'package:ralert/domain/repository/verification.repo.abstract.dart';
import 'package:ralert/domain/usecase/admin/admin.dart';
import 'package:ralert/domain/usecase/auth/get_user.dart';
import 'package:ralert/domain/usecase/auth/login.dart';
import 'package:ralert/domain/usecase/auth/register.dart';
import 'package:ralert/domain/usecase/auth/usercheck.dart';
import 'package:ralert/domain/usecase/emergency/emergency.dart';
import 'package:ralert/domain/usecase/emergency/emergency.live.dart';
import 'package:ralert/domain/usecase/emergency/emergency.radar.dart';
import 'package:ralert/domain/usecase/emergency_list/emergency_list.dart';
import 'package:ralert/domain/usecase/motion/get_motion.dart';
import 'package:ralert/domain/usecase/profile/edit.medical.info.dart';
import 'package:ralert/domain/usecase/profile/edit.profile.dart';
import 'package:ralert/domain/usecase/storage_image/storage.image.dart';
import 'package:ralert/domain/usecase/verification/verification.dart';
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

final sl = GetIt.instance;

Future<void> initializeDependencies() async {

  /* BLOC CUBITS */
  sl.registerFactory(() => UsercheckCubit(sl()));
  sl.registerFactory(() => GetselfCubit(sl()));
  sl.registerFactory(() => AuthCubit(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => LatLngCubit());
  sl.registerFactory(() => GenderCubit());
  sl.registerFactory(() => EmergencyCubit(sl(), sl(), sl()));
  sl.registerFactory(() => MotionCubit(sl()));
  sl.registerFactory(() => RadarCubit(sl()));
  sl.registerFactory(() => GeocodingCubit());
  sl.registerFactory(() => EmergencyLiveCubit(sl()));
  sl.registerFactory(() => EditProfileCubit(sl()));
  sl.registerFactory(() => MedicalInfoCubit(sl()));
  sl.registerFactory(() => EmergencyListCubit(sl()));
  sl.registerFactory(() => StorageImageCubit(sl()));
  sl.registerFactory(() => VerificationProcessCubit());
  sl.registerFactory(() => VerificationCubit(sl()));
  sl.registerFactory(() => AdminCubit(sl(), sl()));

  /* USECASES SERVICE LOCATORS */
  sl.registerLazySingleton(() => Login(repo: sl()));
  sl.registerLazySingleton(() => Register(repo: sl()));
  sl.registerLazySingleton(() => Usercheck(repo: sl()));
  sl.registerLazySingleton(() => GetUser(repo: sl()));
  sl.registerLazySingleton(() => GetSelfUser(repo: sl()));
  sl.registerLazySingleton(() => Emergency(repo: sl()));
  sl.registerLazySingleton(() => Motion(repo: sl()));
  sl.registerLazySingleton(() => EmergencyRadar(repo: sl()));
  sl.registerLazySingleton(() => EmergencyLive(repo: sl()));
  sl.registerLazySingleton(() => UpdateProfile(repo: sl()));
  sl.registerLazySingleton(() => MedicalInfo(repo: sl()));
  sl.registerLazySingleton(() => EmergencyList(repo: sl()));
  sl.registerLazySingleton(() => StorageImage(repo: sl()));
  sl.registerLazySingleton(() => Verification(repo: sl()));
  sl.registerLazySingleton(() => Admin(repo: sl()));

  /* AUTH SERVICE LOCATORS */
  sl.registerLazySingleton<UserRepositoryImpl>(() => UserRepositoryImpl(remote: sl()));
  sl.registerLazySingleton<IUserRepository>(() => UserRepositoryImpl(remote: sl()));
  sl.registerLazySingleton<IUserRemoteDatasource>(() => UserRemoteDatasource());

  /* EMERGENCY SERVICE LOCATORS */
  sl.registerLazySingleton<IEmergencyRepository>(() => EmergencyRepositoryImpl(remote: sl()));
  sl.registerLazySingleton<IEmergencyRemoteDatasource>(() => EmergencyRemoteDatasource());

  /* MOTION DATA */
  sl.registerLazySingleton<IMotionRepository>(() => MotionRepositoryImpl(source: sl()));
  sl.registerLazySingleton<IMotionLocalDatasource>(() => MotionLocalDatasource());

  /* STORAGE IMAGE LOCATORS */
  sl.registerLazySingleton<StorageImageRepositoryImpl>(() => StorageImageRepositoryImpl(remote: sl()));
  sl.registerLazySingleton<IStorageImageRepository>(() => StorageImageRepositoryImpl(remote: sl()));
  sl.registerLazySingleton<IStorageImageRemoteDatasource>(() => StorageImageRemoteDatasource());
  
  /* VERIFICATION LOCATORS */
  sl.registerLazySingleton<VerificationRepositoryImpl>(() => VerificationRepositoryImpl(remote: sl()));
  sl.registerLazySingleton<IVerificationRepository>(() => VerificationRepositoryImpl(remote: sl()));
  sl.registerLazySingleton<IVerificationRemoteDatasource>(() => VerificationRemoteDatasource());

  /* ADMIN LOCATORS */
  sl.registerLazySingleton<AdminRepositoryImpl>(() => AdminRepositoryImpl(remote: sl()));
  sl.registerLazySingleton<IAdminRepository>(() => AdminRepositoryImpl(remote: sl()));
  sl.registerLazySingleton<IAdminRemoteDatasource>(() => AdminRemoteDatasource());

}