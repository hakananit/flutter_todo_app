import 'package:flutter/material.dart';
import 'package:flutter_todo_app/model/todo.dart';
import 'package:flutter_todo_app/screens/tododetail.dart';
import 'package:flutter_todo_app/util/dbhelper.dart';

class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TodoListState();
  }
}

class _TodoListState extends State<TodoList> {
  DbHelper dbHelper = new DbHelper();
  List<Todo> todos;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (todos == null) {
      todos = List<Todo>();
      getData();
    }
    return Scaffold(
      body: todoListItems(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail(Todo('', 3, ''));
        },
        tooltip: "add todo",
        child: Icon(Icons.add),
      ),
    );
  }

  ListView todoListItems() {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
              color: Colors.white,
              elevation: .2,
              child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: getColor(this.todos[position].priority),
                    child: Text(this.todos[position].priority.toString()),
                  ),
                  title: Text(this.todos[position].title),
                  subtitle: Text(this.todos[position].date),
                  onTap: () {
                    navigateToDetail(this.todos[position]);
                  }));
        });
  }

  Color getColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.green;
        break;
      case 2:
        return Colors.purple;
        break;
      case 3:
        return Colors.red;
        break;
      default:
    }
  }

  void getData() {
    final dbFuture = dbHelper.initializeDb();
    dbFuture.then((value) {
      final futureTodos = dbHelper.getTodos();
      futureTodos.then((todos) {
        count = todos.length;
        for (var i = 0; i < count; i++) {
          todos.add(Todo.fromObject(todos[i]));
          debugPrint(todos[i].title);
        }
        setState(() {
          count = count;
          todos = todos;
        });
      });
    });
  }

  void navigateToDetail(Todo todo) async {
    bool result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => TodoDetail(todo)));

    if (result) {
      getData();
    }
  }
}
