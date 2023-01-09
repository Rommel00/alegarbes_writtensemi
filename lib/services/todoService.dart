import 'package:basic_todo_app/db_helper/repository.dart';
import 'package:basic_todo_app/model/ToDoNotes.dart';

class TodoService
{
  late Repository _repository;
  TodoService(){
    _repository = Repository();
  }
  //save
  SaveTodo(ToDoNotes todoNotes) async{
    return await _repository.insertTodo('basic_todo', todoNotes.userMap());
  }
//read
  readTodoList() async {
    return await _repository.readTodo('basic_todo');
  }
//edit
  UpdateTodo(ToDoNotes todonotes) async{
    return await _repository.updateTodo('basic_todo', todonotes.userMap());
  }
//delete
  DeleteToDo(todoId) async{
    return await _repository.deleteTodo('basic_todo', todoId);
  }




}