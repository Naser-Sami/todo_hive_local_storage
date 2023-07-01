import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_hive_local_storage/data/database.dart';
import 'package:todo_hive_local_storage/utils/dialog_box.dart';
import 'package:todo_hive_local_storage/utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // instance of todo database
  TodoDatabase db = TodoDatabase();

  // reference the hive box
  final _myBox = Hive.box('myBox');

  // text controller
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // if this is the 1st time ever opening the app, then create default data
    if (_myBox.get('TODO_LIST') == null) {
      db.createInitialData();
    } else {
      // there's already data
      db.loadData();
    }

    super.initState();
  }

  // checkbox was taped
  void checkboxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });

    // update the db
    db.updateDatabase();
  }

  // save a new task
  void saveNewTask() {
    setState(() {
      db.todoList.add([_controller.text, false]);
      _controller.clear();
    });

    Navigator.of(context).pop();
    // update the db
    db.updateDatabase();
  }

  // create a new task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () {
              Navigator.of(context).pop();
              _controller.clear();
            },
          );
        });
  }

  // delete a task
  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });

    // update the db
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text("Todo"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: ListView.builder(
            itemCount: db.todoList.length,
            itemBuilder: (context, index) {
              return TodoTile(
                taskName: db.todoList[index][0],
                taskCompleted: db.todoList[index][1],
                onChanged: (value) => checkboxChanged(value, index),
                deleteFunction: (context) => deleteTask(index),
              );
            }),
      ),
    );
  }
}
