import 'package:flutter/material.dart';
import 'package:lab2_/book.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'book.dart';
import 'bookdetails.dart';
import 'newbookscreen.dart';
import 'package:lab2_/user.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List bookList;
  double screenHeight, screenWidth;
  bool _visible = false;
  String titlecenter = "Loading Book...";
  TextEditingController _foodnamecontroller = TextEditingController();

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
        title: Text('Eating Life'),
        actions: <Widget>[
          SizedBox(width: 5),
          Flexible(
            child: IconButton(
              icon: Icon(Icons.refresh),
              iconSize: 24,
              onPressed: () {
                _loadBook();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _newBookScreen();
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.yellow,
      ),
      body: Column(
        children: [
          bookList == null
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
                  children: List.generate(bookList.length, (index) {
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
                                          "http://amongusss.com/EatingLife/bookimage/${bookList[index]['bookimage']}.jpg",
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
                                  bookList[index]['booktitle'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(bookList[index]['bookwritter']),
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
    http.post("http://amongusss.com/EatingLife/php/load_book.php", body: {
      "type": "food",
    }).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        bookList = null;
        setState(() {
          titlecenter = "No Book Found";
        });
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          bookList = jsondata["book"];
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  _loadBookDetail(int index) {
    print(bookList[index]['booktitle']);
    Book book = new Book(
        bookid: bookList[index]['bookid'],
        booktitle: bookList[index]['booktitle'],
        bookwritter: bookList[index]['bookwritter'],
        booktype: bookList[index]['booktype'],
        bookimage: bookList[index]['bookimage']);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => BookScreenDetail(
                  book: book,
                )));
  }

  Future<void> _newBookScreen() async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => NewBookScreen()));
  }
}
