import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:test_app/models/product_model.dart';

import 'package:http/http.dart' as http;
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan.shade800),
        useMaterial3: true,
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
  Future<List<Products>> fetchProducts() async {
    final response =
        await http.get(Uri.parse("https://dummyjson.com/products"));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)["products"];

      return data.map((json) => Products.fromJson(json)).toList();
    } else {
      throw Exception("Failed to get data");
    }
  }

  @override
  void initState() {
    super.initState();
    print(fetchProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: fetchProducts(),
          builder: (context, snapshot) {
            print(snapshot.data);
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  List<Products> productList = snapshot.data!;
                  return AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 10,
                        child: Column(
                          children: [
                            AspectRatio(
                                aspectRatio: 4 / 1.5,
                                child: Image.network(
                                  productList[index].thumbnail!,
                                  fit: BoxFit.cover,
                                )),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 20,
                                bottom: 8,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(productList[index].title,
                                          style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "${productList[index].price} USD",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(width: 8),
                                          IconButton(
                                            onPressed: () {
                                              showBottomSheet(
                                                  elevation: 20,
                                                  context: context,
                                                  builder: (context) {
                                                    Products prod =
                                                        productList[index];
                                                    return Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        AspectRatio(
                                                          aspectRatio: 4 / 2,
                                                          child:
                                                              ListView.builder(
                                                                  scrollDirection:
                                                                      Axis
                                                                          .horizontal,
                                                                  shrinkWrap:
                                                                      true,
                                                                  itemCount: prod
                                                                      .images
                                                                      .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              8),
                                                                      child: Image
                                                                          .network(
                                                                              prod.images[index]),
                                                                    );
                                                                  }),
                                                        ),
                                                        Column(
                                                          children: [
                                                            Text(prod.title),
                                                            Text(prod
                                                                .description!),
                                                            Text(
                                                                "\$ ${prod.price}"),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Icon(Icons
                                                                        .star)
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                        "${prod.discountPercentage} %"),
                                                                    Icon(
                                                                      Icons
                                                                          .discount,
                                                                    )
                                                                  ],
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    );
                                                  });
                                            },
                                            icon: const Icon(
                                                Icons.remove_red_eye_sharp),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      productList[index].description!,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Login"),
        centerTitle: true,
      ),
    );
  }
}
