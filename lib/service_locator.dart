import 'package:flune/data/repoimpl/auth/auth_repository_impl.dart';
import 'package:flune/data/sources/auth/auth_firebase_service.dart';
import 'package:flune/domain/repository/auth/auth.dart';
import 'package:flune/domain/usecases/auth/sign_in_usecase.dart';
import 'package:flune/domain/usecases/auth/signup_usecase.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initializeDependencies() async {

  serviceLocator.registerSingleton<AuthFirebaseService>(
   AuthFirebaseServiceImpl()
  );

  serviceLocator.registerSingleton<AuthRepository>(
    AuthRepositoryImpl()
  );

  serviceLocator.registerSingleton<SignupUseCase>(
    SignupUseCase()
  );

  serviceLocator.registerSingleton<SignInUseCase>(
    SignInUseCase()
  );

}