import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/providers/todo_list_provider.dart';
import 'package:todo_app/widgets/todo_widget.dart';

class TodoListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoListProvide>(context);
    final todos = provider.todos;
    return todos.isEmpty
        ? Container(
            child: Text(
              'No Task',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kDarkTeal,
              ),
            ),
            alignment: Alignment.center,
          )
        : ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(16),
            separatorBuilder: (context, index) => Container(
              height: 10,
            ),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return TodoWidget(todo: todo);
            },
          );
  }
}
