import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:test_app/models/model.dart';

import 'package:http/http.dart' as http;

// import 'home_page.dart';
// import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 126, 162, 245)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  Future<List<APIDataModel>> fetchProducts() async {
    final response = await http.get(Uri.parse(
        "https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline"));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List<APIDataModel> productList =
          data.map((e) => APIDataModel.fromJson(e)).toList();
      return productList;
    } else {
      throw Exception("failed to get data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Products",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.menu),
          color: Colors.white,
          onPressed: () {},
        ),
      ),
      body: FutureBuilder(
        future: fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<APIDataModel> products = snapshot.data!;

            // print(snapshot.data);
            return ListView.builder(
              itemBuilder: (context, index) {
                APIDataModel prod = products[index];
                return Card(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        height: 80,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20.0),
                                          child: Image.network(prod.imageLink!),
                                        )),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 20,
                                          left: 10,
                                          right: 10,
                                        ),
                                        child: Text(
                                          prod.description!,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 6),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              child: Image.network(prod.imageLink!),
                              height: 50,
                            ),
                          ),
                          Expanded(
                            flex: 8,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  height: 50,
                                  child: Text(
                                    prod.name!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Center(child: Text("\$ ${prod.price!}")),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
