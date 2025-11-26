import 'package:dartz/dartz.dart';
import 'package:flune/data/models/auth/create_user_req.dart';
import 'package:flune/data/sources/auth/auth_firebase_service.dart';
import 'package:flune/domain/repository/auth/auth.dart';

import '../../../service_locator.dart';

class AuthRepositoryImpl extends AuthRepository{
  @override
  Future<void> signIn() {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<Either> signUp(CreateUserReq createUserReq) async {
    return await serviceLocator<AuthFirebaseService>().signUp(createUserReq);
  }

}