// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_list/app/exception/auth_exceptions.dart';
import 'package:to_do_list/app/repositories/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;

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
      // ignore: duplicate_ignore
    } on FirebaseAuthException catch (e, s) {
      //print(e);
      //print(s);
      //print('Cheguei aqui');
      // 'email-already-in-use'
      // 'email-already-exists'
      if (e.code == 'email-already-in-use') {
        final loginTypes =
            await _firebaseAuth.fetchSignInMethodsForEmail(email);

        if (loginTypes.contains(password)) {
          print('Password: $password');
          throw AuthException(
            msg: 'Email já utilizado por favor escolha outro email.',
          );
        } else {
          throw AuthException(
            msg:
                'Você se cadastrou pelo Google, por favor utilize-o para entrar.',
          );
        }
      } else {
        throw AuthException(
          msg: e.message ?? 'Erro ao registrar usuário.',
        );
      }
    }
  }
}
