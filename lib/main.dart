import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:manage_product/Product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  Future getProductsData() async {
    var response = await http.get(Uri.https("dummyjson.com", "products"));

    var jsonData = jsonDecode(response.body);
    List<Product> products = [];

    for (var p in jsonData["products"]) {
      Product product = Product(
          p["id"], p["title"], p["description"], p["category"], p["thumbnail"]);
      products.add(product);
    }
    print(products.length);
    return products;
  }

  @override
  void initState() {}

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          child: Card(
        child: FutureBuilder(
          future: getProductsData(),
          builder: ((context, snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text('Loading...'),
                ),
              );
            } else {
              return listView(snapshot.data);
            }
          }),
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class listView extends StatelessWidget {
  List<dynamic> data;
  listView(this.data);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, i) {
          return cardProduct(data[i]);
          // return ListTile(
          //   title: Text(snapshot.data[i].title),
          //   subtitle: Text(snapshot.data[i].description),
          //   leading: CircleAvatar(
          //     backgroundImage:
          //         NetworkImage(snapshot.data[i].thumbnail),
          //   ),
          // );
        });
  }
}

class cardProduct extends StatelessWidget {
  Product p;
  cardProduct(this.p);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 50,
      shadowColor: Colors.black,
      color: Colors.greenAccent[100],
      child: SizedBox(
        width: 300,
        height: 500,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.green[500],
                radius: 108,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(p.thumbnail), //NetworkImage
                  radius: 100,
                ), //CircleAvatar
              ), //CircleAvatar
              const SizedBox(
                height: 10,
              ), //SizedBox
              Text(
                p.title,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.green[900],
                  fontWeight: FontWeight.w500,
                ), //Textstyle
              ), //Text
              const SizedBox(
                height: 10,
              ), //SizedBox
              Text(
                p.category,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.green,
                ), //Textstyle
              ), //Text
              const SizedBox(
                height: 10,
              ), //SizedBox
              SizedBox(
                width: 100,

                child: ElevatedButton(
                  onPressed: () => 'Null',
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green)),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: const [Icon(Icons.touch_app), Text('Click')],
                    ),
                  ),
                ),
                // RaisedButton is deprecated and should not be used
                // Use ElevatedButton instead

                // child: RaisedButton(
                //   onPressed: () => null,
                //   color: Colors.green,
                //   child: Padding(
                //     padding: const EdgeInsets.all(4.0),
                //     child: Row(
                //       children: const [
                //         Icon(Icons.touch_app),
                //         Text('Visit'),
                //       ],
                //     ), //Row
                //   ), //Padding
                // ), //RaisedButton
              ) //SizedBox
            ],
          ), //Column
        ), //Padding
      ), //SizedBox
    );
  }
}
