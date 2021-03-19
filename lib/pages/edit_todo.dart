import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/todos.dart';
import 'package:todo_app/providers/todo_list_provider.dart';
import 'package:todo_app/widgets/todo_form_widget.dart';

class EditTodo extends StatefulWidget {
  final Todo todo;
  EditTodo({this.todo});
  @override
  _EditTodoState createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  final _formKey = GlobalKey<FormState>();
  String title;
  String description;

  @override
  void initState() {
    super.initState();
    title = widget.todo.title;
    description = widget.todo.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Todo'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: TodoFormWidget(
              title: title,
              description: description,
              onChangedTitle: (title) => setState(() => this.title = title),
              onChangedDescription: (description) =>
                  setState(() => this.description = description),
              onSavedTodo: () {
                if (_formKey.currentState.validate()) {
                  final provider =
                      Provider.of<TodoListProvide>(context, listen: false);
                  provider.updateTodo(widget.todo, title, description);
                  Navigator.pop(context);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
