import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'Cart.dart';
import 'ScopeManage.dart';
import 'Details.dart';

class Item {
  String nama;

  Item(this.nama);
}

class Home extends StatefulWidget {
  final AppModel appModel;
  static final String route = 'Home-route';

  Home({this.appModel});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  Icon searchIcon = Icon(
    Icons.search,
    color: Colors.orangeAccent,
  );
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController searchQuery = TextEditingController();
  List<Data> data;
  List<Data> searchList = List();

  bool isSearching;
  String searchText = '';
  HomeState() {
    searchQuery.addListener(() {
      if (searchQuery.text.isEmpty) {
        setState(() {
          isSearching = false;
          searchText = '';
        });
      }
    });
  }

  Widget gridGenerate(List<Data> data, aspectRatio) {
    return Padding(
      padding: EdgeInsets.all(5.0),
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
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.orange[200]),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Image(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'http://www.malmalioboro.co.id/${data[index].gambar}'),
                            ),
                          ),
                        ),
                        Text(
                          '${data[index].nama}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Column(children: <Widget>[
                            Divider(
                              color: Colors.orange[200],
                              thickness: 1,
                            ),
                            Row(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  NumberFormat.currency(
                                    locale: 'id',
                                    name: 'Rp ',
                                    decimalDigits: 0,
                                  ).format(data[index].harga),
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
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.orangeAccent,
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Cart()));
      },
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.shopping_cart,
              size: 30,
            ),
          ),
          Positioned(
            top: 5,
            left: 30,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight + 50) / 3.5;
    final double itemWidth = size.width / 3;

    // TODO: implement build
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        key: scaffoldKey,
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
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: InkResponse(
                onTap: () {},
                child: Icon(
                  Icons.search,
                  size: 30,
                  color: Colors.orangeAccent,
                ),
              ),
            ),
          ],
        ),
        body: ScopedModelDescendant<AppModel>(builder: (context, child, model) {
          return Container(
            decoration: BoxDecoration(color: Colors.white),
            child: gridGenerate(model.itemListing, (itemWidth / itemHeight)),
          );
        }),
        floatingActionButton: Container(
          margin: EdgeInsets.only(right: 5, bottom: 5),
          width: 70,
          height: 70,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black12, width: 3),
              shape: BoxShape.circle),
          child: cartButton(),
        ),
      ),
    );
  }
}
