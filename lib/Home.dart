import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
//import 'package:search_widget/search_widget.dart';
import 'Cart.dart';
import 'ScopeManage.dart';
import 'Details.dart';

class Home extends StatefulWidget {
  final AppModel appModel;
  static final String route = 'Home-route';

  Home({this.appModel});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  Widget gridGenerate(List<Data> data, aspectRatio) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: aspectRatio),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: EdgeInsets.all(5.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Details(detail: data[index])));
                },
                child: Container(
                    height: 300.0,
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.orange[200])),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Image(
                            image: NetworkImage(
                                'http://www.malmalioboro.co.id/${data[index].gambar}'),
                            fit: BoxFit.fill,
                          ),
                        )),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            '${data[index].nama}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Column(children: <Widget>[
                            Divider(color: Colors.black),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  'Rp ${data[index].harga}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ],
                    )),
              ));
        },
        itemCount: data.length,
      ),
    );
  }

  Widget cartButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Cart()));
      },
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
            child: Icon(
              Icons.shopping_cart,
              size: 25,
            ),
          ),
          Positioned(
            top: 5,
            left: 25,
            child: ScopedModelDescendant<AppModel>(
              builder: (context, child, model) {
                return Container(
                  //padding: EdgeInsets.all(1),
                  decoration: new BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 15,
                    minHeight: 15,
                  ),
                  child: Text(
                    (model.cartListing.length > 0)
                        ? model.cartListing.length.toString()
                        : '0',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.orangeAccent,
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 3;

    // TODO: implement build
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'SUPERMARKET MALIOBORO MALL',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          actions: <Widget>[
            Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 15, right: 20, left: 15),
                  child: InkResponse(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Cart()));
                    },
                    child: Icon(
                      Icons.shopping_cart,
                      size: 25,
                      color: Colors.orangeAccent,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 15,
                  child: ScopedModelDescendant<AppModel>(
                    builder: (context, child, model) {
                      return Container(
                        //padding: EdgeInsets.all(1),
                        decoration: new BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 15,
                          minHeight: 15,
                        ),
                        child: Text(
                          (model.cartListing.length > 0)
                              ? model.cartListing.length.toString()
                              : '0',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        body: ScopedModelDescendant<AppModel>(builder: (context, child, model) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            spreadRadius: 5)
                      ],
                    ),
                    height: 0,
                    child: null),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: gridGenerate(
                        model.itemListing, (itemWidth / itemHeight)),
                  ),
                ),
              ]);
        }),
        //floatingActionButton: cartButton(),
        bottomNavigationBar: BottomAppBar(
            elevation: 1,
            child: Container(
              height: 5,
            )),
      ),
    );
  }
}
