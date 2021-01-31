import 'package:flutter/material.dart';
import 'package:lab2_/user.dart';
 
class NewBookScreen extends StatefulWidget {

  final User user;

  const NewBookScreen({Key key, this.user}) : super(key: key);
  @override
  _NewBookScreenState createState() => _NewBookScreenState();
}

class _NewBookScreenState extends State<NewBookScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: Text('Hello World'),
          ),
        ),
      ),
    );
  }
}