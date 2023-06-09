import 'package:flutter/material.dart';
import 'package:to_do_list/app/exception/auth_exceptions.dart';
import 'package:to_do_list/app/services/user/user_service.dart';

class RegisterController extends ChangeNotifier {
  final UserService _userService;
  String? error;
  bool success = false;

  RegisterController({required UserService userService})
      : _userService = userService;

  Future<void> registerUser(String email, String password) async {
    try {
      error = null;
      success = false;
      notifyListeners();

      print('Cheguei aqui.');
      final user = await _userService.register(email, password);
      print('Estou aqui.');
      if (user != null) {
        // Sucesso
        success = true;
      } else {
        // Erro
        error = 'Erro ao registrar usuário.';
      }
    } on AuthException catch (e) {
      error = e.msg;
    } finally {
      notifyListeners();
    }
  }
}
