import 'package:basic_todo_app/model/ToDoNotes.dart';
import 'package:basic_todo_app/services/todoService.dart';
import 'package:flutter/material.dart';
class EditTodo extends StatefulWidget {
  final ToDoNotes todo;
  const EditTodo({Key? key,required this.todo}) : super(key: key);

  @override
  State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  var _notesToDoController = TextEditingController();
  bool _validateToDo = false;
  var _todoService = TodoService();

  @override
  void initState() {
    setState(() {
      _notesToDoController.text = widget.todo.todo_list??'';
    });
    super.initState();
  }

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
              const Text('Edit ToDo',
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
                          _Todonotes.id = widget.todo.id;
                          _Todonotes.todo_list = _notesToDoController.text;
                          var result = await _todoService.UpdateTodo(_Todonotes);
                          Navigator.pop(context,result);}

                      }, child: const Text('Update'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
