import 'package:flutter/material.dart';
import 'package:to_do_list/app/core/ui/theme_extensions.dart';

class TodoListLogo2 extends StatelessWidget {
  const TodoListLogo2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/logo.png',
          height: 200,
        ),
        Text(
          'Todo List',
          style: context.textTheme.headlineMedium,
        ),
      ],
    );
  }
}
