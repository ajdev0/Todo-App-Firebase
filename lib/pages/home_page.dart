import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/api/firebase_api.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/model/todos.dart';
import 'package:todo_app/providers/todo_list_provider.dart';
import 'package:todo_app/widgets/add_todo_widget.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/widgets/todo_complete_list_widget.dart';
import 'package:todo_app/widgets/todo_list_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Todo todo;
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final tabs = [
      TodoListWidget(),
      TodoCompletedListWidget(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          MyApp.title,
          style: TextStyle(
            color: kDarkTeal,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        currentIndex: selectedIndex,
        onTap: (value) => setState(() {
          selectedIndex = value;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check),
            label: 'Todos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done),
            label: 'Completed',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Icon(Icons.add),
        backgroundColor: kDarkTeal,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddTodoWidget(),
            barrierDismissible: false,
          );
        },
      ),
      body: StreamBuilder<List<Todo>>(
        stream: FirebaseApi.readTodos(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.hasError) {
                return Text('somthing went wrong');
              } else {
                final todos = snapshot.data;
                final provider = Provider.of<TodoListProvide>(context);
                provider.setTodos(todos);
                return tabs[selectedIndex];
              }
          }
        },
      ),
    );
  }
}
