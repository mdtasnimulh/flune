import 'package:dartz/dartz.dart';
import 'package:flune/core/usecase/usecase.dart';
import 'package:flune/data/models/auth/sign_in_user_req.dart';
import 'package:flune/domain/repository/auth/auth.dart';
import 'package:flune/service_locator.dart';

class SignInUseCase implements UseCase<Either,SignInUserReq>{

  @override
  Future<Either> call({SignInUserReq ? params}) async {
    return serviceLocator<AuthRepository>().signIn(params!);
  }

}