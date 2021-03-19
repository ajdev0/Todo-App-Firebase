import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';

class TodoFormWidget extends StatelessWidget {
  final String title;
  final String description;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final VoidCallback onSavedTodo;
  const TodoFormWidget({
    this.title,
    this.description,
    @required this.onChangedTitle,
    @required this.onChangedDescription,
    @required this.onSavedTodo,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            initialValue: title,
            maxLines: 1,
            validator: (title) {
              if (title.isEmpty) {
                return 'This Field mustn\'t be empty';
              }
              return null;
            },
            decoration: InputDecoration(labelText: 'Title'),
            onChanged: onChangedTitle,
          ),
          TextFormField(
            initialValue: description,
            maxLines: 3,
            decoration: InputDecoration(labelText: 'Description'),
            onChanged: onChangedDescription,
          ),
          SizedBox(
            child: ElevatedButton(
              onPressed: onSavedTodo,
              child: Text('Save'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Color(0xFF006d77),
                ),
              ),
            ),
            width: double.infinity,
          )
        ],
      ),
    );
  }
}
