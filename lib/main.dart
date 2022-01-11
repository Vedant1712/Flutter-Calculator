import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

String ans = "";
String history = "";

void main() {
  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: mycalc(),
    );
  }
}

class mycalc extends StatefulWidget {

  @override
  _State createState() => _State();
}

class _State extends State<mycalc> {

  void numClick(String text){
    setState(() {
      ans = ans + text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Container(
              color: Colors.grey.shade900,
              child: Text(
                  history,
                  style: TextStyle(
                      fontSize: 20.0,
                    letterSpacing: 2.0,
                    color: Colors.grey.shade500
                  ),
              ),
              alignment: const Alignment(0.5, 0.5),
              height: 100.0,
              width: double.infinity,
            ),
            Container(
              color: Colors.grey.shade900,
              child: Text(
                ans,
                style: TextStyle(
                    fontSize: 50.0,
                    letterSpacing: 2.0
                ),
              ),
              alignment: const Alignment(0.5, 0.0),
              height: 100.0,
              width: double.infinity,
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(child: TextButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(Colors.grey.shade900)
                          ),
                          onPressed: () {
                            setState(() {
                              ans = "";
                              history = "";
                            });
                          },
                          child: const Text(
                            "AC",
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.white
                            ),
                          ),
                        )),
                        Expanded(child: TextButton(
                          style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(Colors.grey.shade900)
                          ),
                          onPressed: () {
                            setState(() {
                              ans = ans.substring(0, ans.length - 1);
                            });
                          },
                          child: const Text(
                            "DEL",
                            style: TextStyle(
                                fontSize: 30.0,
                                color: Colors.white
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(child: numbers(
                          text: "1",
                          callback: numClick,
                        )),
                        Expanded(child: numbers(
                          text: "2",
                          callback: numClick,
                        )),
                        Expanded(child: numbers(
                          text: "3",
                          callback: numClick,
                        )),
                        Expanded(child: operands(
                          text: "/",
                          callback: numClick,
                        )),
                      ],
                    )
                  ),
                  Expanded(
                      child: Row(
                        children: [
                          Expanded(child: numbers(
                            text: "4",
                            callback: numClick,
                          )),
                          Expanded(child: numbers(
                            text: "5",
                            callback: numClick,
                          )),
                          Expanded(child: numbers(
                            text: "6",
                            callback: numClick,
                          )),
                          Expanded(child: operands(
                            text: "*",
                            callback: numClick,
                          )),
                        ],
                      )
                  ),
                  Expanded(
                      child: Row(
                        children: [
                          Expanded(child: numbers(
                            text: "7",
                            callback: numClick,
                          )),
                          Expanded(child: numbers(
                            text: "8",
                            callback: numClick,
                          )),
                          Expanded(child: numbers(
                            text: "9",
                            callback: numClick,
                          )),
                          Expanded(child: operands(
                            text: "+",
                            callback: numClick,
                          )),
                        ],
                      )
                  ),
                  Expanded(
                      child: Row(
                        children: [
                          Expanded(child: numbers(
                            text: ".",
                            callback: numClick,
                          )),
                          Expanded(child: numbers(
                            text: "0",
                            callback: numClick,
                          )),
                          Expanded(child: TextButton(
                            style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(Colors.red.shade700),
                              backgroundColor: MaterialStateProperty.all(Colors.red),
                              shape: MaterialStateProperty.all<CircleBorder>(
                                const CircleBorder()
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                Parser p = Parser();
                                Expression exp = p.parse(ans);
                                ContextModel cm = ContextModel();

                                history = ans;
                                ans = exp.evaluate(EvaluationType.REAL, cm).toString();
                              });
                            },
                            child: const Text(
                              "=",
                              style: TextStyle(
                                  fontSize: 40.0,
                                  color: Colors.white
                              ),
                            ),
                          )),
                          Expanded(child: operands(
                            text: "-",
                            callback: numClick,
                          )),
                        ],
                      )
                  )
                ],
              )
            )
          ],
        )
      ),
    );
  }
}

class operands extends StatelessWidget {

  final String text;
  final Function callback;
  const operands({Key key, this.text, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.grey.shade800),
        backgroundColor: MaterialStateProperty.all(Colors.grey.shade900),
        shape: MaterialStateProperty.all(const CircleBorder())
      ),
      onPressed: () {
        callback(text);
      },
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 40.0,
            color: Colors.white
        ),
      ),
    );
  }
}


class numbers extends StatelessWidget {

  final String text;
  final Function callback;
  const numbers({Key key, this.text, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.grey.shade900),
      ),
      onPressed: () {
        callback(text);
      },
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 30.0,
            color: Colors.white
        ),
      ),
    );
  }
}


