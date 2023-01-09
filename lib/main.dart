import 'package:basic_todo_app/screens/EditToDo.dart';
import 'package:basic_todo_app/screens/addTodo.dart';
import 'package:basic_todo_app/services/todoService.dart';
import 'package:flutter/material.dart';
import 'package:basic_todo_app/model/ToDoNotes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<ToDoNotes> _todoList;
  final _todoService = TodoService();

  getAllToDo() async {
    var list_todo = await _todoService.readTodoList();
    _todoList = <ToDoNotes>[];

    list_todo.forEach((todo){
    setState(() {
      var todoModel = ToDoNotes();
      todoModel.id = todo['id'];
      todoModel.todo_list = todo['todo_list'];
      _todoList.add(todoModel);
    });
    });
  }

  @override
  void initState() {
    getAllToDo();
    super.initState();
  }

  _showSuccessSnackBar(String message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  _deleteFormDialog(BuildContext context,todoId)
  {
    return showDialog(context: context, builder: (param){
      return AlertDialog(
        title: const Text('Are you sure to DELETE?',style: TextStyle(color: Colors.blue, fontSize: 20),),
        actions: [
          TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.red),
              onPressed: () async {
                var result = await _todoService.DeleteToDo(todoId);
                if(result!=null){
                  Navigator.pop(context);
                  getAllToDo();
                  _showSuccessSnackBar('ToDo Deleted');
                }
              },
              child: const Text('Delete')),
          TextButton(
              style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.blue),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'))
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Basic ToDo App by ALEGARBES"),
      ),
      body: ListView.builder(
          itemCount: _todoList.length, itemBuilder: (context, index){
            return Card(
              child: ListTile(
                leading: Icon(Icons.event_note),
                title: Text(_todoList[index].todo_list ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context, MaterialPageRoute(builder: (context) =>EditTodo(todo:_todoList[index],))).then((data){
                            if(data!=null){
                              getAllToDo();
                              _showSuccessSnackBar('ToDo Updated');
                            }
                          });
                        },
                        icon: const Icon(Icons.edit,color: Colors.blue,)),
                    IconButton(
                        onPressed: () {
                          _deleteFormDialog(context,_todoList[index].id);
                        },
                        icon: const Icon(Icons.delete,color: Colors.red,))
                  ],
                ),
              ),
            );

          }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
              context, MaterialPageRoute(builder: (context)=>AddToD0())).then((data){
                if(data!=null){
                  getAllToDo();
                  _showSuccessSnackBar('New ToDo Added');
                }

          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

