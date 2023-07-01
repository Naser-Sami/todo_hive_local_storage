import 'package:hive/hive.dart';

class TodoDatabase {
  List todoList = [];

  // reference the box
  final _myBox = Hive.box('myBox');

  // run this method if this is the 1st time ever opening this app
  void createInitialData() {
    todoList = [
      ['Click on checkbox to finish the task', false],
      ['Swipe left to delete the task', false],
      ['Do Exercise 🏋🏻', false],
    ];
  }

  // load the data from database
  void loadData() {
    todoList = _myBox.get('TODO_LIST');
  }

  // update the database
  void updateDatabase() {
    _myBox.put('TODO_LIST', todoList);
  }
}
