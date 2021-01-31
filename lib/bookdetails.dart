import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lab2_/recipedetails.dart';
import 'package:lab2_/user.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'book.dart';
import 'food.dart';
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
  List foodlist;
  String titlecenter = "Loading Food...";
  String type = "Food";
  GlobalKey<RefreshIndicatorState> refreshKey;

  @override
  void initState() {
    super.initState();
    _loadFoods();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.booktitle),
      ),
      body: Column(children: [
        Container(
            height: screenHeight / 4.8,
            width: screenWidth / 0.3,
            child: CachedNetworkImage(
              imageUrl:
                  "http://amongusss.com/EatingLife/bookimage/${widget.book.bookimage}.jpg",
              fit: BoxFit.cover,
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) => new Icon(
                Icons.broken_image,
                size: screenWidth / 2,
              ),
            )),
        foodlist == null
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
                child: RefreshIndicator(
                    key: refreshKey,
                    color: Colors.yellow,
                    onRefresh: () async {
                      _loadFoods();
                    },
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: (screenWidth / screenHeight) / 0.62,
                      children: List.generate(foodlist.length, (index) {
                        return Padding(
                            padding: EdgeInsets.all(2),
                            child: Card(
                                child: InkWell(
                              onTap: () => _loadFoodDetails(index),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                        height: screenHeight / 5,
                                        width: screenWidth / 1.2,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "http://amongusss.com/EatingLife/bookimage/foodimage/${foodlist[index]['foodimage']}.jpg",
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
                                      foodlist[index]['foodname'],
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            )));
                      }),
                    )),
              )
      ]),
      // ),
    );
  }

  Future<void> _loadFoods() async {
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Loading...");
    await pr.show();
    http.post("https://amongusss.com/EatingLife/php/load_food.php", body: {
      "bookid": widget.book.bookid,
    }).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        foodlist = null;
        setState(() {
          titlecenter = "No Recipe Found";
        });
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          foodlist = jsondata["foods"];
        });
      }
    }).catchError((err) {
      print(err);
    });
    await pr.hide();
  }

  _loadFoodDetails(int index) {
    Food food = new Food(
      foodid: foodlist[index]['foodid'],
      foodname: foodlist[index]['foodname'],
      foodimage: foodlist[index]['foodimage'],
      description: foodlist[index]['description'],
      price: foodlist[index]['price'],
      bookid: widget.book.bookid
    );

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => RecipeScreenDetails(
                  food: food,
                )));
  }
}
