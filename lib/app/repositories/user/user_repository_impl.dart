// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_list/app/exception/auth_exceptions.dart';
import 'package:to_do_list/app/repositories/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  FirebaseAuth _firebaseAuth;

  UserRepositoryImpl({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e, s) {
      // ignore: avoid_print
      print(e);
      print(s);
      // email-already-exists
      if (e.code == 'email-already-in-user') {
        final loginTypes =
            await _firebaseAuth.fetchSignInMethodsForEmail(email);
        if (loginTypes.contains('password')) {
          throw AuthExceptions(
            msg: 'Email já utilizado por favor escolha outro email.',
          );
        } else {
          throw AuthExceptions(
            msg:
                'Você se cadastrou pelo Google, por favor utilize-o para entrar.',
          );
        }
      } else {
        throw AuthExceptions(
          msg: e.message ?? 'Erro ao registrar usuário.',
        );
      }
    }
  }
}
