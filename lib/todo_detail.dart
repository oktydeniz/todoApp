import 'package:flutter/material.dart';

class ToDoDetail extends StatelessWidget {
  String title, content, isDone;

  ToDoDetail(this.title, this.content, this.isDone);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[900],
        title: Text("Todo Detail"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                title,
                style: TextStyle(
                    color: isDone == "true" ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    decoration: isDone == "true"
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  content,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: isDone == "true" ? Colors.green : Colors.red,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ),
          isDone == "true"
              ? Icon(
                  Icons.done,
                  color: Colors.green,
                  size: 300,
                )
              : Icon(
                  Icons.cancel_sharp,
                  color: Colors.red,
                  size: 300,
                ),
        ],
      ),
    );
  }
}
