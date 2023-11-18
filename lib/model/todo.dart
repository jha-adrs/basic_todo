import 'package:flutter/material.dart';

class ToDo {
  String? id;
  String? title;
  bool isDone;

  ToDo({
    required this.id,
    required this.title,
    this.isDone = false,
  });

  static List<ToDo> todoList(){
    return [
      ToDo(id: '01', title: 'Check S3 bucket',  isDone: false),
      ToDo(id: '02', title: 'Check S4 bucket',  isDone: true),
      ToDo(id: '03', title: 'Check S5 bucket', isDone: false),
      ToDo(id: '04', title: 'Check S6 bucket',  isDone: false),
      ToDo(id: '05', title: 'Check S7 bucket',  isDone: false),
      ToDo(id: '06', title: 'Check S8 bucket', isDone: false),
      ToDo(id: '07', title: 'Check S9 bucket',  isDone: false),
      ToDo(id: '08', title: 'Check S10 bucket',  isDone: false),
      ToDo(id: '09', title: 'Check S11 bucket',  isDone: false),
      ToDo(id: '10', title: 'Check S12 bucket',  isDone: false),
      ToDo(id: '11', title: 'Check S13 bucket',  isDone: false),
      ToDo(id: '12', title: 'Check S14 bucket',  isDone: false),
    ];
  }
}