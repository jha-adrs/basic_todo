import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/model/todo.dart';

class TodoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onToDoDeleted;

  const TodoItem({Key? key, required this.todo, required this.onToDoChanged, required this.onToDoDeleted}): super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: ListTile(
        onTap: () {
          print("Clicking");
          onToDoChanged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        leading:  Icon(
          todo.isDone? Icons.check_box: Icons.check_box_outline_blank,
          color: tdBlue,
        ),
        title: Text(
          todo.title ?? '',
          style: TextStyle(
            fontSize: 16,
            color: tdBlack,
            decoration: todo.isDone? TextDecoration.lineThrough: null,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          height: 35,
          width: 35,
          decoration: BoxDecoration(color: tdRed, borderRadius: BorderRadius.circular(5)),
          child: IconButton(
            onPressed: (){
              print("Deleting");
              onToDoDeleted(todo.id);
            },
            icon: Icon(Icons.delete),
            color: Colors.white,
            iconSize: 18,
          ),
        ),
      ),
    );
  }
}