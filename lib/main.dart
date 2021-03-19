import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/todo_list_provider.dart';
import 'pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static String title = 'Todo App';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoListProvide(),
      child: MaterialApp(
        title: title,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.lime[50],
          primaryColor: Color(0xFF99d98c),
        ),
        home: HomePage(),
      ),
    );
  }
}
