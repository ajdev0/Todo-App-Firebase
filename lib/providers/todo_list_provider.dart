import 'package:flutter/cupertino.dart';
import 'package:todo_app/model/todos.dart';
import 'package:todo_app/api/firebase_api.dart';

class TodoListProvide extends ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos.where((todo) => todo.isDone == false).toList();
  List<Todo> get todoCompleted =>
      _todos.where((todo) => todo.isDone == true).toList();

  void addTodo(Todo todo) {
    //_todos.add(todo);
    //notifyListeners();
    FirebaseApi.createTodo(todo);
  }

  void deleteTodo(Todo todo) {
    _todos.remove(todo);
    FirebaseApi.deleteTodo(todo);
  }

  void updateTodo(Todo todo, String title, String desctiption) {
    todo.title = title;
    todo.description = desctiption;

    FirebaseApi.updateTodo(todo);
  }

  bool toggleTodoStatus(Todo todo) {
    todo.isDone = !todo.isDone;
    FirebaseApi.updateTodo(todo);
    return todo.isDone;
  }

  void setTodos(List<Todo> todos) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _todos = todos;
        notifyListeners();
      });
}
