import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/core/ui/theme_extensions.dart';
import 'package:to_do_list/app/core/validators/validators.dart';
//import 'package:to_do_list/app/core/validators/validator.dart';
import 'package:to_do_list/app/core/widgets/todo_list_field.dart';
import 'package:to_do_list/app/core/widgets/todo_list_logo2.dart';
import 'package:to_do_list/app/modules/auth/register/register_controller.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _confirmPasswordEC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    _confirmPasswordEC.dispose();
    //context.read<RegisterController>().removeListener(() {});
  }

  @override
  void initState() {
    super.initState();

    context.read<RegisterController>().addListener(
      () {
        var controller = context.read<RegisterController>();
        var success = controller.success;
        var error = controller.error;

        if (success) {
          Navigator.of(context).pop();
        } else if (error != null && error.isNotEmpty) {
          print('ERROR ME $error');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TO DO LIST',
              style: TextStyle(fontSize: 10, color: context.primaryColor),
            ),
            Text(
              'TELA DE CADASTRO',
              style: TextStyle(fontSize: 13, color: context.primaryColor),
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: ClipOval(
            // ignore: avoid_unnecessary_containers
            child: Container(
              color: context.primaryColor.withAlpha(20),
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.arrow_back_ios_outlined,
                size: 20,
                color: context.primaryColor,
              ),
            ),
          ),
        ),
      ),
      // ignore: avoid_unnecessary_containers
      body: ListView(
        children: [
          // ignore: sized_box_for_whitespace
          Container(
            height: MediaQuery.of(context).size.width * .5,
            child: const FittedBox(
              fit: BoxFit.fitHeight,
              child: TodoListLogo2(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TodoListField(
                    label: 'Email',
                    controller: _emailEC,
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required('Email é obrigatório.'),
                        Validatorless.email('Email inválido.')
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  TodoListField(
                    label: 'Senha',
                    controller: _passwordEC,
                    obscureText: true,
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required('A senha é obrigatória.'),
                        Validatorless.min(
                            6, 'A senha deve ter pelo menos 6 caracteres.'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  TodoListField(
                    label: 'Confirmar senha',
                    controller: _confirmPasswordEC,
                    obscureText: true,
                    validator: Validatorless.multiple([
                      Validatorless.required('Confirmar senha obrigatória'),
                      Validators.compare(_passwordEC, 'Senhas não batem'),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        final formValid =
                            _formKey.currentState?.validate() ?? false;
                        //print(formValid);
                        if (formValid) {
                          context
                              .read<RegisterController>()
                              .registerUser(_emailEC.text, _passwordEC.text);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text('Salvar'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
