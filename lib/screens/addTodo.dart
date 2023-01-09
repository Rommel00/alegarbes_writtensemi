import 'package:basic_todo_app/model/ToDoNotes.dart';
import 'package:basic_todo_app/services/todoService.dart';
import 'package:flutter/material.dart';

class AddToD0 extends StatefulWidget {
  const AddToD0({Key? key}) : super(key: key);

  @override
  State<AddToD0> createState() => _AddToD0State();
}

class _AddToD0State extends State<AddToD0> {
  var _notesToDoController = TextEditingController();
  bool _validateToDo = false;
  var _todoService = TodoService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Basic ToDo App"),),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Create New ToDo',
                style: TextStyle(
                    fontSize:20,
                    color: Colors.blue,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _notesToDoController,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'What To Do?',
                  errorText: _validateToDo ? 'ToDo Value Can\'t Be Empty' : null,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.blue,
                      textStyle: const TextStyle(fontSize: 15)
                    ),
                      onPressed: () async {
                      setState(() {
                        _notesToDoController.text.isEmpty?_validateToDo=true:_validateToDo=false;

                      });
                      if(_validateToDo==false){
                        //print
                        var _Todonotes = ToDoNotes();
                        _Todonotes.todo_list = _notesToDoController.text;
                        var result = await _todoService.SaveTodo(_Todonotes);
                        Navigator.pop(context,result);
                      }
                      }, child: const Text('Done'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
