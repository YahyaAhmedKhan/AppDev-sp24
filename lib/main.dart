import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:test_app/models/album_model.dart';

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
  // Future<List<Album>> fetchAlbum() async {
  //   final response = await http
  //       .get(Uri.parse("https://jsonplaceholder.typicode.com/albums"));
  //   if (response.statusCode == 200) {
  //     final List<dynamic> data = json.decode(response.body);
  //     return data.map((json) => Album.fromJson(json)).toList();
  //   } else {
  //     throw Exception("Failed to load album");
  //   }
  // }

  // Future<List<Album>> fetchAlbum() async {
  //   late Future<List<Album>> futureAlbum;
  //   Uri uriObject = Uri.parse('https://jsonplaceholder.typicode.com/albums');

  //   final response = await get(uriObject);
  //   if (response.statusCode == 200) {
  //     List<dynamic> data = jsonDecode(response.body);
  //     // List<Album> itemsList = List<Album>.from(
  //   }
  // }

  Future<List<Album>> fetchAlbums() async {
    Uri uriObject = Uri.parse('https://jsonplaceholder.typicode.com/albums');
    final response = await http.get(uriObject);

    if (response.statusCode == 200) {
      List<dynamic> parseListJson = jsonDecode(response.body);

      //cant access by iterable through index
      List<Album> items = List<Album>.from(
        //map returns and interable
        parseListJson.map<Album>((dynamic user) => Album.fromjson(user)),
      );

      //.from is more optimized than .tolist()

      return items;
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: fetchAlbums(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    child: ListTile(
                      style: ListTileStyle.list,
                      onTap: () {},
                      title: Text(snapshot.data![index].title),
                      trailing: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) => Card(
                              child: SizedBox(
                                height: 100,
                                width: 20,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.delete),
                      ),
                      leading: CircleAvatar(
                        child: Text(snapshot.data![index].id.toString()),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              return Center(child: const CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: null,
        label: const Text("Login"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
