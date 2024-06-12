
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shops/auth/models/user_model.dart';

abstract class UserRepo {
  Stream<User?> get user;
  Future<UserModel> signUp({required  UserModel myUser, required String password});

  Future<void> setUserData(UserModel user);
  Future<void> logIn({required String email, required String password});

  Future<void> logOut();
}