import 'package:flutter/material.dart';
import 'package:to_do_list/app/core/database/sqlite_connection_factory.dart';

class SqliteAdmConnection with WidgetsBindingObserver {
  final conn = SqliteConnectionFactory();
  // observa o estado do ciclo de vida do aplicativo,
  // observa o que o usuario fez dentro da aplicação.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        conn.closeConn();
        break;
      case AppLifecycleState.paused:
        conn.closeConn();
        break;
      case AppLifecycleState.detached:
        conn.closeConn();
        break;
    }
  }
}
