import 'package:flutter/material.dart';
import 'package:flutter_todo_app/model/todo.dart';
import 'package:flutter_todo_app/util/dbhelper.dart';

final List<String> choices = const <String>['save', 'delete', 'back'];

DbHelper dbHelper = DbHelper();

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
        actions: [
          PopupMenuButton(
            itemBuilder: (itemBuilder) {
              return choices
                  .map((e) => PopupMenuItem(value: e, child: Text(e)))
                  .toList();
            },
            onSelected: select,
          )
        ],
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

  void select(String value) async {
    int result;
    switch (value) {
      case 'delete':
        Navigator.pop(context, true);
        result = await dbHelper.deleteTodo(todo.id);
        if (result != 0) {
          AlertDialog dialog =
              AlertDialog(title: Text("Delete"), content: Text("deleted."));
          showDialog(context: context, builder: (_) => dialog);
        }
        break;
      case 'save':
        save();
        break;
      case 'back':
        Navigator.pop(context, true);
        break;
      default:
    }
  }

  void save() {
    todo.date = DateTime.now().toString();
    dbHelper.insertTodo(todo);
  }
}
