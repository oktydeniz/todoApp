import 'package:flutter/material.dart';
import 'package:todo_app/todo_add.dart';
import 'package:todo_app/todo_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({Key? key}) : super(key: key);

  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  var todoTitle = [];
  var todoContent = [];
  var todoIsDone = [];
  getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      todoTitle = sharedPreferences.getStringList('todoTitle') ?? [];
      todoContent = sharedPreferences.getStringList('todoContent') ?? [];
      todoIsDone = sharedPreferences.getStringList('todoIsDone') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    //  function is added to this field, it will work again every time
    //  thepage is opened to
    //   getData()
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ToDoAdd()));
        },
        backgroundColor: Colors.orange[900],
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.orange[900],
        title: Text("ToDo List"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                getData();
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ToDoDetail(
                      todoTitle[index],
                      todoContent[index],
                      todoIsDone[index],
                    ),
                  ),
                );
              },
              title: Text(todoTitle[index]),
              subtitle: Text(todoContent[index].split(' ')[0] + "..."),
              trailing: GestureDetector(
                onTap: () async {
                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  setState(() {
                    final todoIsDoneFinal =
                        sharedPreferences.getStringList('todoIsDone') ?? [];
                    todoIsDoneFinal[index] == "true"
                        ? todoIsDoneFinal[index] = "false"
                        : todoIsDoneFinal[index] = "true";

                    sharedPreferences.setStringList(
                        'todoIsDone', todoIsDoneFinal);
                    todoIsDone[index] == "true"
                        ? todoIsDone[index] = "false"
                        : todoIsDone[index] = "true";
                  });
                },
                child: Card(
                  child: Container(
                    child: Icon(
                        todoIsDone[index] == "true" ? Icons.done : Icons.cancel,
                        color: todoIsDone[index] == "true"
                            ? Colors.green
                            : Colors.red,
                        size: 30),
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: todoTitle.length,
      ),
    );
  }

  @override
  void initState() {
    // when page open -> start
    super.initState();
    getData();
  }

  @override
  void dispose() {
    // when page close -> start
    super.dispose();
  }
}
