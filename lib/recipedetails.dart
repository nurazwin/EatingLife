import 'package:flutter/material.dart';
import 'package:lab2_/user.dart';

import 'food.dart';

class RecipeScreenDetails extends StatefulWidget {
  final Food food;
  final User user;


  const RecipeScreenDetails({Key key, this.food, this.user}) : super(key: key);

  @override
  _RecipeScreenDetailsState createState() => _RecipeScreenDetailsState();
}

class _RecipeScreenDetailsState extends State<RecipeScreenDetails> {
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