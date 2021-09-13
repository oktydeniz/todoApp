import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToDoAdd extends StatelessWidget {
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController contentEditingController = TextEditingController();

  todoAdd() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final todoTitle = sharedPreferences.getStringList('todoTitle') ?? [];
    final todoContent = sharedPreferences.getStringList('todoContent') ?? [];
    final todoIsDone = sharedPreferences.getStringList('todoIsDone') ?? [];

    todoTitle.add(titleEditingController.text);
    todoContent.add(contentEditingController.text);
    todoIsDone.add("false");

    sharedPreferences.setStringList('todoTitle', todoTitle);
    sharedPreferences.setStringList('todoContent', todoContent);
    sharedPreferences.setStringList('todoIsDone', todoIsDone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange[900],
        onPressed: () {
          if (titleEditingController.text != "" &&
              contentEditingController.text != "") {
            todoAdd();
            Navigator.pop(context);
          }
        },
        child: Icon(Icons.done),
      ),
      appBar: AppBar(
        backgroundColor: Colors.orange[900],
        title: Text("Add ToDo"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextField(
                controller: titleEditingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal)),
                  labelText: "Title",
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextField(
                controller: contentEditingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal)),
                  labelText: "Content",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
