import 'package:flutter/material.dart';
import 'package:lab2_/book.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List booklist;
  double screenHeight, screenWidth;
  String titlecenter = "Loading Book...";

 @override
  void initState() {
    super.initState();
    _loadBook();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Available Book'),
      ),
      body: Column(
        children: [
          booklist == null
              ? Flexible(
                  child: Container(
                      child: Center(
                          child: Text(
                  titlecenter,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ))))
              : Flexible(
                  child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: (screenWidth / screenHeight) / 0.8,
                  children: List.generate(booklist.length, (index) {
                    return Padding(
                        padding: EdgeInsets.all(1),
                        child: Card(
                          child: InkWell(
                            onTap: () => _loadBookDetail(index),
                            child: Column(
                              children: [
                                Container(
                                    height: screenHeight / 3.8,
                                    width: screenWidth / 1.2,
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "http://amongusss.com/EatingLife/images/bookimages/${booklist[index]['bookimage']}.jpg",
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          new CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          new Icon(
                                        Icons.broken_image,
                                        size: screenWidth / 2,
                                      ),
                                    )),
                                SizedBox(height: 5),
                                Text(
                                  booklist[index]['booktitle'],
                                  style: TextStyle(
                                      fontSize: 16,
                                     fontWeight: FontWeight.bold),
                                ),
                                Text(booklist[index]['bookwritter']),
                                Text(booklist[index]['booktype']),
                              ],
                            ),
                          ),
                        ));
                  }),
                ))
        ],
      ),
    ));
  }

  void _loadBook() {
    http.post("https://amongusss.com/EatingLife/php/load_book.php",
        body: {
          "type": "food",
        }).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        booklist = null;
        setState(() {
          titlecenter = "No Book Found";
        });
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          booklist = jsondata["book"];
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  _loadBookDetail(int index) {
    print(booklist[index]['booktitle']);
    Book book = new Book(
        bookid: booklist[index]['bookid'],
        booktitle: booklist[index]['booktitle'],
        bookwritter: booklist[index]['bookwritter'],
        booktype: booklist[index]['booktype'],
        bookimage: booklist[index]['bookimage']);

      
  }
}
