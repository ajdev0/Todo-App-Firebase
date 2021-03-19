import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/model/todos.dart';
import 'package:todo_app/pages/edit_todo.dart';
import 'package:todo_app/providers/todo_list_provider.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;
  const TodoWidget({
    @required this.todo,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            key: Key(todo.id),
            actions: [
              IconSlideAction(
                color: Colors.green[400],
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditTodo(todo: todo)));
                },
                caption: 'Edit',
                icon: Icons.edit,
              ),
            ],
            secondaryActions: [
              IconSlideAction(
                color: Colors.red[900],
                onTap: () {
                  final provider =
                      Provider.of<TodoListProvide>(context, listen: false);
                  provider.deleteTodo(todo);
                },
                caption: 'Delete',
                icon: Icons.delete,
              ),
            ],
            child: buildTodo(context),
          ),
        ));
  }

  Widget buildTodo(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Row(
        children: [
          Checkbox(
            activeColor: Theme.of(context).primaryColor,
            checkColor: Colors.white,
            value: todo.isDone,
            onChanged: (_) {
              final provider =
                  Provider.of<TodoListProvide>(context, listen: false);
              final isDone = provider.toggleTodoStatus(todo);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content:
                        Text((isDone) ? 'Task Completed' : 'Task Incomplete')),
              );
            },
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                todo.title,
                style: TextStyle(
                  color: kDarkTeal,
                  fontSize: 24,
                ),
              ),
              if (todo.description.isNotEmpty) Text(todo.description),
            ],
          )
        ],
      ),
    );
  }
}
