import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
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
  AppModel model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController searchQuery = TextEditingController();
  bool isSearching;
  String searchText = '';
  List<Data> searchList;
  List<Data> buildSearchList() {
    if (searchText.isEmpty) {
      return searchList = data;
    } else {
      searchList = data
          .where((element) =>
              element.nama.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
      print('${searchList.length} item found!');
      return searchList;
    }
  }

  Icon searchIcon = Icon(
    Icons.search,
    color: Colors.orangeAccent,
    size: 30,
  );

  Widget appBarTitle = Text(
    'SUPERMARKET MALIOBORO MALL',
    style: TextStyle(
      fontSize: 20,
    ),
  );

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

  Widget appBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 70,
      elevation: 1,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: appBarTitle,
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: InkResponse(
            child: searchIcon,
            onTap: () {
              if (this.searchIcon.icon == Icons.search) {
                this.searchIcon = Icon(
                  Icons.close,
                  color: Colors.orangeAccent,
                  size: 30,
                );
                this.appBarTitle = Container(
                  margin: EdgeInsets.only(right: 10),
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: TextField(
                    controller: searchQuery,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      hintText: 'Cari di sini...',
                      hintStyle: TextStyle(color: Colors.orangeAccent),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                    ),
                  ),
                );
                handleSearchStart();
              } else {
                handleSearchEnd();
              }
            },
          ),
        ),
      ],
    );
  }

  Widget gridGenerate(List<Data> data, aspectRatio) {
    return null;
  }

  void handleSearchStart() {
    setState(() {
      isSearching = true;
    });
  }

  void handleSearchEnd() {
    setState(() {
      this.searchIcon = Icon(
        Icons.search,
        color: Colors.orangeAccent,
        size: 30,
      );
      this.appBarTitle = Text(
        'SUPERMARKET MALIOBORO MALL',
        style: TextStyle(
          fontSize: 20,
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    isSearching = false;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight + 50) / 3.5;
    final double itemWidth = size.width / 3;
    final double aspectRatio = itemWidth / itemHeight;

    // TODO: implement build
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        key: scaffoldKey,
        appBar: appBar(context),
        body: ScopedModelDescendant<AppModel>(builder: (context, child, model) {
          searchList = model.itemListing;
          return Container(
              decoration: BoxDecoration(color: Colors.transparent),
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: aspectRatio),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Details(detail: searchList[index]),
                            ),
                          );
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  child: Image(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        'http://www.malmalioboro.co.id/${searchList[index].gambar}'),
                                  ),
                                ),
                              ),
                              Text(
                                '${searchList[index].nama}',
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
                                    children: <Widget>[
                                      Text(
                                        NumberFormat.currency(
                                          locale: 'id',
                                          name: 'Rp ',
                                          decimalDigits: 0,
                                        ).format(searchList[index].harga),
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: searchList.length,
                ),
              ));
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
