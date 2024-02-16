import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'buttons.dart';

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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: false,
          textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.white),
              bodyMedium: TextStyle(color: Colors.white),
              bodySmall: TextStyle(color: Colors.white)),
          scaffoldBackgroundColor: Colors.black),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  String display = "0";

  double? op1 = 0;
  double? op2 = 0;
  String? operation = "+";

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void clear() {
    setState(() {
      widget.display = "0";
      widget.op1 = null;
      widget.op2 = null;
      widget.operation = null;
    });
  }

//null? op1 type : (no op ? op1 type: op2 type)
  void numberPressed(int number) {
    if (widget.display.length < 16) {
      if (widget.operation == null) {
        widget.op2 = widget.op2! * 10 + number;
        setState(() {
          widget.display = widget.op2.toString();
        });
      } else {
        // updateResult(widget.op1, widget.op2, widget.operation!);
        setState(() {
          widget.display = number.toString();
          widget.operation = "+";
        });
      }
    }
  }

  void updateResult(double op1, double op2, String op) {
    switch (op) {
      case "+":
        op1 = op1 + op2;
        break;
      case "-":
        op1 = op1 - op2;
        break;
      case "x":
        op1 = op1 * op2;
        break;
      case "/":
        op1 = op1 / op2;
        break;
    }
  }

  handleOperationPress(String op) {
    if (widget.operation == null) {
      widget.op2 = null;
      widget.op1 = double.parse(widget.display);
    }
    // else if ()
  }

// if temp null, set temp
// if temp not null and op null, update temp

  void handleNumberPress(int number) {
    if (widget.display.length < 16) {
      if (widget.operation == null) {
        setState(() {
          widget.display += number.toString();
        });
      } else {
        setState(() {
          widget.display = number.toString();
          widget.operation = "+";
        });
      }
    }
  }

// if temp null, do nothing
// if temp not null and op null,c
  void handleOpertationPress(String op) {}

  void backspace() {
    // if (widget.display.length == 1) {
    //   setState(() {
    //     widget.display = "0";
    //   });
    // }
    if (widget.display.length > 0) {
      setState(() {
        widget.display = widget.display.substring(0, widget.display.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GestureDetector(
            onHorizontalDragEnd: (details) {
              if (details.primaryVelocity! > 0) {
                backspace();
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: SizedBox(
                height: 100,
                width: double.infinity,
                child: AutoSizeText(
                  widget.display,
                  // style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                  ),
                  maxLines: 1,
                  stepGranularity: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ExtraButton(
                          label: "AC",
                          onPressed: () {
                            clear();
                          }),
                      ExtraButton(label: "±", onPressed: () {}),
                      ExtraButton(label: "%", onPressed: () {}),
                      OpButton(
                          label: "/",
                          onPressed: () {
                            handleOperationPress("/");
                          })
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      NumberButton(
                          label: "7",
                          onPressed: () {
                            numberPressed(7);
                          }),
                      NumberButton(
                          label: "8",
                          onPressed: () {
                            numberPressed(8);
                          }),
                      NumberButton(
                          label: "9",
                          onPressed: () {
                            numberPressed(9);
                          }),
                      OpButton(
                          label: "x",
                          onPressed: () {
                            handleOperationPress("x");
                          })
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      NumberButton(
                          label: "4",
                          onPressed: () {
                            numberPressed(4);
                          }),
                      NumberButton(
                          label: "5",
                          onPressed: () {
                            numberPressed(5);
                          }),
                      NumberButton(
                          label: "6",
                          onPressed: () {
                            numberPressed(6);
                          }),
                      OpButton(
                          label: "-",
                          onPressed: () {
                            handleOperationPress("-");
                          })
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      NumberButton(
                          label: "1",
                          onPressed: () {
                            numberPressed(1);
                          }),
                      NumberButton(
                          label: "2",
                          onPressed: () {
                            numberPressed(2);
                          }),
                      NumberButton(
                          label: "3",
                          onPressed: () {
                            numberPressed(3);
                          }),
                      OpButton(
                          label: "+",
                          onPressed: () {
                            handleOperationPress("+");
                          })
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      NumberButton(
                        label: "0",
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade800,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(70),
                          ),
                          padding: EdgeInsets.all(20),
                          fixedSize: Size(
                              MediaQuery.sizeOf(context).width * 2.4 * 0.7 / 4,
                              MediaQuery.sizeOf(context).width * 0.7 / 4),
                          textStyle: const TextStyle(
                            fontSize: 35,
                          ),
                        ),
                      ),
                      NumberButton(label: ".", onPressed: () {}),
                      OpButton(
                        label: "=",
                        onPressed: () {},
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
