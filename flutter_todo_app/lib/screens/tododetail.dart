import 'package:flutter/material.dart';
import 'package:flutter_todo_app/model/todo.dart';

class TodoDetail extends StatefulWidget {
  final Todo todo;
  TodoDetail(this.todo);
  @override
  State<StatefulWidget> createState() {
    return _TodoDetailState(todo);
  }
}

class _TodoDetailState extends State<TodoDetail> {
  final _priorities = ['low', 'medium', 'high'];
  Todo todo;
  _TodoDetailState(this.todo);
  String _priority = "low";
  TextEditingController titleController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = todo.title;
    descriptionController.text = todo.description;

    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                      labelText: "Title",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                      labelText: "Description",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: DropdownButton<String>(
                      onChanged: null,
                      value: _priority,
                      items: _priorities
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList()),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
