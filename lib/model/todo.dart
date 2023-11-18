import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ToDo {
  String id;
  String title;
  bool isDone;

  ToDo({
    required this.id,
    required this.title,
    this.isDone = false,
  });

  // Convert a ToDo item to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isDone': isDone,
    };
  }

  // Convert a Map to a ToDo item
  static ToDo fromMap(Map<String, dynamic> map) {
    return ToDo(
      id: map['id'],
      title: map['title'],
      isDone: map['isDone'],
    );
  }
}


class ToDoList {
  List<ToDo> _todos;

  ToDoList() : _todos = [];

  // Load the to-do list from local storage
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final todoListString = prefs.getString('todoList');
    if (todoListString != null) {
      final todoListMap = jsonDecode(todoListString) as List;
      _todos = todoListMap.map((todoMap) => ToDo.fromMap(todoMap)).toList();
    }
  }

  // Save the to-do list to local storage
  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    final todoListString = jsonEncode(_todos.map((todo) => todo.toMap()).toList());
    await prefs.setString('todoList', todoListString);
  }

  // Add a to-do item
  void add(ToDo todo) {
    _todos.add(todo);
    save();
  }

  // Remove a to-do item
  void remove(ToDo todo) {
    _todos.remove(todo);
    save();
  }
  List<ToDo> where(bool Function(ToDo) test) {
    return _todos.where(test).toList();
  }

  // Remove items from the to-do list
  void removeWhere(bool Function(ToDo) test) {
    _todos.removeWhere(test);
    save();
  }

  // Get the list of to-do items
  List<ToDo> get todos => _todos;
}