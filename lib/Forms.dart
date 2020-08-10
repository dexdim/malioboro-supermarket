import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'Cart.dart';
import 'ScopeManage.dart';

class Forms extends StatefulWidget {
  static final String route = 'Form-route';

  @override
  State<StatefulWidget> createState() {
    return FormsState();
  }
}

class FormsState extends State<Forms> {
  final formKey = GlobalKey<FormState>();
  final namaController = TextEditingController();
  final nomorhpController = TextEditingController();
  String namapemesan;
  String nomorhp;

  @override
  void dispose() {
    namaController.dispose();
    nomorhpController.dispose();
    super.dispose();
  }

  Widget button(String title) {
    return ScopedModelDescendant<AppModel>(builder: (context, child, model) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(
                color: Colors.orange[200],
                width: 1,
              ),
            ),
            color: Colors.white,
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 100,
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            onPressed: () {
              if (formKey.currentState.validate()) {
                var finalprint = '';
                printItem(Data d) {
                  finalprint +=
                      '\nNama barang : ${d.nama}\nHarga satuan : Rp ${d.harga}\nKode barcode : ${d.deskripsi}\nJumlah : ${d.counter} , Harga subtotal : Rp ${d.subtotal}\n';
                }

                finalprint += 'Halo Supermarket Malioboro Mall\n';
                finalprint += 'Berikut adalah daftar belanja dari,\n';
                finalprint += 'Nama pemesan: ${namaController.text}\n';
                finalprint += 'Nomor handphone: ${nomorhpController.text}';
                finalprint += '\n=================\n\n';
                model.cartListing.map((d) => printItem(d)).toString();
                finalprint +=
                    '\n\n=================\nHarga total : Rp ${CartState.totalHarga}';
                finalprint +=
                    '\n\nMohon untuk cek ketersediaan stocknya. Terima kasih.';

                FlutterOpenWhatsapp.sendSingleMessage(
                    '6282138020366', '${finalprint.toString()}');
              }
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.orange[100],
          )
        ],
      );
    });
  }

  Widget header() {
    return Container(
        width: MediaQuery.of(context).size.width / 1.3,
        child: Text(
          'Silakan anda bisa mengisi form dibawah ini untuk melengkapi proses pemesanan di Malioboro Mall Supermarket',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ));
  }

  Widget formField(String title, controller) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.3,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 50,
              child: TextFormField(
                controller: controller,
                onSaved: (value) => title = value,
                style: TextStyle(color: Colors.grey[850], fontSize: 16),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: title,
                  labelStyle: TextStyle(color: Colors.grey[850]),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.grey,
                  )),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.deepOrangeAccent,
                  )),
                  filled: true,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Kolom $title masih kosong, harap isi dengan benar!';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 10),
          ]),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form pemesanan'),
        elevation: 5,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: formKey,
          autovalidate: true,
          child: Column(children: <Widget>[
            SizedBox(height: 100),
            header(),
            SizedBox(height: 30),
            formField('Nama', namaController),
            formField('Nomor Handphone', nomorhpController)
          ]),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(height: 70, child: button('ORDER VIA WHATSAPP')),
      ),
    );
  }
}
