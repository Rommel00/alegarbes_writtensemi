class ToDoNotes
{
  int? id;
  String? todo_list;

  userMap(){
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['todo_list'] = todo_list!;
    return mapping;
  }

}