import 'package:flutter/material.dart';
import 'package:lab2_/user.dart';
import 'book.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class BookScreenDetail extends StatefulWidget {
  final Book book;
  final User user;

  const BookScreenDetail({Key key, this.book, this.user}) : super(key: key);

  @override
  _BookScreenDetailState createState() => _BookScreenDetailState();
}

class _BookScreenDetailState extends State<BookScreenDetail> {
  double screenHeight = 0.00, screenWidth = 0.00;
  List recipeList;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.booktitle),
      ),
      body: Container(
          child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: (screenWidth / screenHeight) / 0.62,
        children: List.generate(recipeList.length, (index) {
          return Padding(
              padding: EdgeInsets.all(2),
              child: Card(
                  child: InkWell(
                onTap: () => _loadRecipeDetails(index),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          height: screenHeight / 5,
                          width: screenWidth / 1.2,
                          child: CachedNetworkImage(
                            imageUrl:
                                "http://amongusss.com/EatingLife/bookimages/${widget.book.bookimage}.jpg",
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                new CircularProgressIndicator(),
                            errorWidget: (context, url, error) => new Icon(
                              Icons.broken_image,
                              size: screenWidth / 2,
                            ),
                          )),
                      SizedBox(height: 5),
                      Text(
                        recipeList[index]['recipename'],
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              )));
        }),
      )),
      // ),
    );
  }

  _loadRecipeDetails(int index) {}
}
