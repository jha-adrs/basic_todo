import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/model/todo.dart';
import 'package:flutter_application_1/widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _todosList = ToDoList();
  final _toDoController = TextEditingController();
  List<ToDo> filteredList = [];

  @override
  void initState() {
    super.initState();
    _todosList.load().then((_) {
      setState(() {
        filteredList = _todosList.todos;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  searchBox(),
                  Expanded(
                      child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50, bottom: 20),
                        child: const Text(
                          'Your ToDo List',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      for (ToDo todoo in filteredList.reversed)
                        TodoItem(
                          todo: todoo,
                          onToDoChanged: _handleToDoChanged,
                          onToDoDeleted: _handleToDoDeleted,
                        ),
                    ],
                  ))
                ],
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [Expanded(child: addItem())],
            ),
          )
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Icon(Icons.menu, color: tdBlack, size: 30),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('planet_0.png')),
        )
      ]),
    );
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) {
          _searchToDoItem(value);
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  Widget addItem() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 0.0),
            blurRadius: 10.0,
            spreadRadius: 0.0,
          ),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _toDoController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Add ToDo',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              // Handle the add button tap
              
              _addToDoItem(_toDoController.text);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                color: tdBlue, // Customize the color as needed
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleToDoChanged(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _handleToDoDeleted(String id) {
    setState(() {
      _todosList.removeWhere((element) => element.id == id);
    });
  }

  void _addToDoItem(String title) {
    if (title.isEmpty) {
      return;
    }else{
      setState(() {
      _todosList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        isDone: false,
      ));
    });
    }

    
    _toDoController.clear();
  }

  void _searchToDoItem(String title) {
    List<ToDo> results = [];
    final trimmedTitle = title.trim();
    if (trimmedTitle.isEmpty) {
      results = _todosList.todos;
    } else {
      results = _todosList
          .where((element) =>
              element.title!.toLowerCase().contains(trimmedTitle.toLowerCase()))
          .toList();
    }
    setState(() {
      filteredList = results;
    });
  }
}
