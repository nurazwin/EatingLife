import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lab2_/user.dart';
import 'food.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:progress_dialog/progress_dialog.dart';

class RecipeScreenDetails extends StatefulWidget {
  final Food food;

  const RecipeScreenDetails({Key key, this.food}) : super(key: key);

  @override
  _RecipeScreenDetailsState createState() => _RecipeScreenDetailsState();
}

class _RecipeScreenDetailsState extends State<RecipeScreenDetails> {
  double screenHeight = 0.00, screenWidth = 0.00;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.food.foodname),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    height: screenHeight / 2.5,
                    width: screenWidth / 0.5,
                    child: SingleChildScrollView(
                      child: CachedNetworkImage(
                        imageUrl:
                            "http://amongusss.com/EatingLife/bookimage/foodimage/${widget.food.foodimage}.jpg",
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            new CircularProgressIndicator(),
                        errorWidget: (context, url, error) => new Icon(
                          Icons.broken_image,
                          size: screenWidth / 2,
                        ),
                      ),
                    )),
                Divider(color: Colors.black),
                Text('Recipe',
                textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 6),
                Text(widget.food.description),
                Divider(color: Colors.black),   
              ],
            ),
          ),
        ),
      ),
      // ),
    );
  }
}
