import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/model/todos.dart';
import 'package:todo_app/providers/todo_list_provider.dart';
import 'package:todo_app/widgets/todo_form_widget.dart';

class AddTodoWidget extends StatefulWidget {
  @override
  _AddTodoWidgetState createState() => _AddTodoWidgetState();
}

class _AddTodoWidgetState extends State<AddTodoWidget> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'New Todo',
              style: TextStyle(
                color: kDarkTeal,
              ),
            ),
            TodoFormWidget(
              onChangedTitle: (title) => setState(() => this.title = title),
              onChangedDescription: (description) =>
                  setState(() => this.description = description),
              onSavedTodo: () {
                //addTodo(todo);
                if (_formKey.currentState.validate()) {
                  final todo = Todo(
                      id: DateTime.now().toString(),
                      createdTime: DateTime.now(),
                      title: title,
                      description: description);
                  final provider =
                      Provider.of<TodoListProvide>(context, listen: false);
                  provider.addTodo(todo);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
