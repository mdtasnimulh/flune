import 'package:dartz/dartz.dart';
import 'package:flune/core/usecase/usecase.dart';
import 'package:flune/data/models/auth/create_user_req.dart';
import 'package:flune/domain/repository/auth/auth.dart';
import 'package:flune/service_locator.dart';

class SignupUseCase implements UseCase<Either,CreateUserReq>{

  @override
  Future<Either> call({CreateUserReq ? params}) async {
    return serviceLocator<AuthRepository>().signUp(params!);
  }

}