import 'package:flutter/material.dart';

void main() => runApp(new TodoDemoListApp());

class TodoDemoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My bucket List',
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> todoItemsArrayList = [];

  void todoItemListAdd(String task) {
    if (task.length > 0) {
      setState(() => todoItemsArrayList.add(task));
    }
  }

  void deleteTodoListItem(int index) {
    setState(() => todoItemsArrayList.removeAt(index));
  }

  void onTapDeleteTodoItem(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('당신은 "${todoItemsArrayList[index]}" 이란 버킷리스트를 완료하셨나요?'),
          actions: <Widget>[
            TextButton(
              child: Text('아니요'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('완료했습니다!'),
              onPressed: () {
                deleteTodoListItem(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget appBarBuildTodoList() {
    return ListView.builder(
      itemCount: todoItemsArrayList.length,
      itemBuilder: (context, index) {
        return buildSingleTodoItem(todoItemsArrayList[index], index);
      },
    );
  }

  Widget buildSingleTodoItem(String todoText, int index) {
    return ListTile(
      title: Text(todoText),
      onTap: () => onTapDeleteTodoItem(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo List')),
      body: appBarBuildTodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => newAddTodoScreen(context),
        tooltip: 'Do Add task',
        child: Icon(Icons.add),
      ),
    );
  }

  void newAddTodoScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(title: Text('Add a new task')),
            body: TextField(
              autofocus: true,
              onSubmitted: (val) {
                todoItemListAdd(val);
                Navigator.pop(context); // Close the add todo screen
              },
              decoration: InputDecoration(
                hintText: 'Enter list to do...',
                contentPadding: const EdgeInsets.all(16.0),
              ),
            ),
          );
        },
      ),
    );
  }
}
