import 'package:Avatar/sklep/providers/product.dart';
import 'package:flutter/material.dart';
import  './misje/sticker_view_general.dart';
import './sklep/providers/products.dart';
import 'package:Avatar/item.dart';
import 'DB_Reader.dart';
import 'client.dart';
import 'image_example.dart';
import 'missions_screen.dart';


var globalContext;

class Mission extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    globalContext = context;

    
    return MaterialApp(
      title: "Mission",
      home: HomeView(),
      debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.orange
        )
    );
  }
}

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {


  void _openAlert() async {
    String misja = await DBReader().missionTitle(i);

    return showDialog(
        context: this.context,
        builder: (context) {
          return AlertDialog(
            content: Text('$misja\nYou can open an example only once!', style: TextStyle(fontFamily: 'Arial', fontSize: 20)),
            actions: <Widget>[
              FlatButton(
                child: Text("Example"),
                onPressed: () {
                  ImageExample().openAlertImage(misja, context);
                },
              ),

              FlatButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
    );
  }




  //window with avatar and stickers
  FlutterSimpleStickerView _stickerView = FlutterSimpleStickerView(
    Container(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: new ExactAssetImage('assets/postac.png')
          )
      ),
    ),

    [
      for (Item item in Client().products ) Image.asset(item.path),
      for (Product item in Products().items ) Image.asset(item.path),

    ],
    panelBackgroundColor: Colors.orange,
  );


  @override
  Widget build(BuildContext context) {



    return Scaffold(
        appBar: AppBar(
            leading: Builder(
              builder: (BuildContext context) { //creating buttons
                return IconButton(
                    icon: Icon(Icons.arrow_back_ios_rounded ),
                    onPressed: (){
                      ImageExample().openExampleIncrement();
                      Navigator.pop(globalContext);
                      //  Navigator.of(context).maybePop();
                    }
                );
              },
            ),
            title: Text("General Mission", style: TextStyle(fontFamily: 'Comic Sans', fontSize: 30, fontStyle: FontStyle.italic, color: Colors.white,)),
            centerTitle: true,

            actions: <Widget>[

//information about mission goal
              new IconButton(
                icon: Icon(Icons.announcement),
                onPressed: () async {
                  _openAlert();
                },
              ),

            ]
        ),
        body: _stickerView);
  }
}

//_stickerView);
