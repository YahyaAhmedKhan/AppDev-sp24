import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/model.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
          centerTitle: true,
          leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
          backgroundColor: Colors.cyan[400],
        ),
        body: FutureBuilder(
          future: fetchProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return Wrap(children: [
                            ListTile(
                              leading: Image.network(
                                  snapshot.data![index].imageLink!),
                              title: Text(
                                snapshot.data![index].name!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle:
                                  Text(snapshot.data![index].description!),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                      'Brand: ${snapshot.data![index].brand}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                      'Price: \$${snapshot.data![index].price}'),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                      'Product Type: ${snapshot.data![index].productType!}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                      'Price: \$${snapshot.data![index].price}'),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children:
                                  snapshot.data![index].productColors!.map(
                                (clr) {
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Color(
                                          _getColorFromHex(clr.hexValue!)),
                                    ),
                                  );
                                },
                              ).toList(),
                            )
                          ]);
                        },
                      );
                    },
                    child: Center(
                      child: Card(
                        elevation: 2.0,
                        color: Colors.white,
                        child: ListTile(
                          leading:
                              Image.network(snapshot.data![index].imageLink!),
                          title: Text(snapshot.data![index].name!),
                          trailing: Text("\$${snapshot.data![index].price!}"),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Error fetching data"),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<APIDataModel>> fetchProducts() async {
    final response = await http.get((Uri.parse(
        'https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline')));

    if (response.statusCode == 200) {
      var parsedListJson = json.decode(response.body);

      List<APIDataModel> itemsList = List<APIDataModel>.from(parsedListJson
          .map<APIDataModel>((dynamic user) => APIDataModel.fromJson(user)));
      // ProdList =
      // print(itemsList);
      return itemsList;
    } else {
      throw Exception();
    }
  }
}
