import 'package:hive/hive.dart';
import 'package:study_easy/modules/todolist/model/todo.dart';
import 'package:get/get.dart';

class TodoController extends GetxController {
  var todoBox = Hive.box<Todo>('todo').obs;

  final RxList<Todo> listTask = RxList<Todo>();

  TodoController(){
    getItems();
  }

  getItems() {
    listTask.value = [];
    for (int i = 0; i < todoBox.value.values.length; i++) {
      if (todoBox.value.getAt(i) != null) listTask.add(todoBox.value.getAt(i)!);
    }
  }

  addTodo(Todo todoList) async {
    listTask.insert(0, todoList);
    await todoBox.value.add(todoList);
    getItems();
  }

  deleteTodo(Todo todoList) async {
    int index = listTask.indexOf(todoList);
    listTask.removeAt(index);
    await todoBox.value.deleteAt(index);
  }
}
