import 'dart:math';
import 'package:flutter/material.dart';
import 'package:decimal/decimal.dart';
//import 'package:decimal/intl.dart';

void main() {
  runApp(const CalcApp());
}

class CalcApp extends StatelessWidget {
  const CalcApp({Key ? key}) : super(key : key);
  @override
  Widget build(BuildContext context){
    return MaterialApp(
        title: 'Calculator',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(title: 'Calculator\nchristian.nwachioma@gmail.com'),
    );
  }
}
/* Calculator button constructor */
class myButton extends StatelessWidget {
  //const myButton({Key? key}) : super(key: key);
  const myButton({
    required this.bText,
    required this.callback,
    required this.size,
    //this.bHeight = MediaQuery.of(context).size.height*0.1,
    this.bColor = Colors.deepOrange,
    this.textColor = Colors.white,
  });
  final String bText;
  //final VoidCallback callback;
  final Function callback;
  //final double bHeight;
  final double size;
  final Color bColor;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Ink(
        width: MediaQuery.of(context).size.width*0.23,
        height: size,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.white10,
              offset: Offset(1,1),
              blurRadius: 2
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(size/5)),
          color: bColor,
        ),
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.elliptical(size/5, size/5))
          ),
          onTap: ()=>callback(bText), // functionality interface for each button
          child: Center(
            child: Text(bText,style: TextStyle(fontSize: 48,color:textColor)),
          ),
        ),
      ),
    );
  }
} /*Calculator button constructor ends */

/* This class begins by defining the functionality for each button.
   Next, it calls the button constructor to create each button
*/
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title; //Fields in a widget subclass are always marked "final"
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  String firstNum = '', secondNum = '';
  String hist = '', result = '', display = '', operation = '';
  void btnAction(String btn){ // Listens for key a keypad signal, and acts on it
    //print(btn);
    if(btn == '∙'){ btn = '.';}
    if(btn == 'AC'){
      firstNum = '';
      secondNum = '';
      hist = '';
      result = '';
      display = '';
    }else if(btn == '+' || btn == '-' || btn == '÷' || btn == '×' || btn == '%' || btn == '√'){
      firstNum = (display);
      result = '';
      operation = btn;
    }else if(btn == '='){
      secondNum = (display);
      if(operation == '+'){
        result = (Decimal.parse(firstNum) + Decimal.parse(secondNum) ).toString();
        //hist = firstNum.toString() + operation + secondNum.toString();
      }
      if(operation == '×'){
        result = (Decimal.parse(firstNum) * Decimal.parse(secondNum)).toString();
      }
      if(operation == '-'){
        result = (Decimal.parse(firstNum)-Decimal.parse(secondNum)).toString();
      }
      if(operation == '÷'){
        //if(secondNum == '0'){return;}
          result = (Decimal.parse(firstNum) / Decimal.parse(secondNum)).toString();
      }
      if(operation == '%'){
        result = (Decimal.parse(firstNum) / Decimal.parse('100')).toString();
      }
      if(operation == '√'){
        result = (sqrt(double.parse(secondNum))).toString();
      }
      hist = firstNum + operation + secondNum;
    }else{
      result = (display + btn);
    }
    if(btn == '⌫'){
      result = display.substring(0,display.length-1);
      if(result ==''){hist = '';}
    }
    setState(() {
      if(result == ''){
        if(secondNum == ''){
          display = firstNum;
        }else{
          display = secondNum;
        }
      }
      display = result;
    });
  } // END btnAction fcn
  @override
  // this widget creates the keypads using the myButton constructor
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      backgroundColor: const Color(0xFF28527a),
      body: Column(
        children:<Widget> [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(hist,style: const TextStyle(fontSize: 50.0)),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
            child: Text(display,style: const TextStyle(fontSize: 38.0)),
          ),
          const Expanded(
              child: Divider(),
          ),
          /* 1ST ROW*/
          Row(
            children: [
              myButton(
                bText: "AC",
                callback: btnAction,
                size:  90,
                bColor: Colors.deepOrange,
                textColor: Colors.brown,
                //callback: () {  },
              ),
              myButton(
                bText: "√",
                callback: btnAction,
                size: 90,
                bColor: Colors.grey,
                textColor: Colors.brown,
              ),
              myButton(
                bText: "%",
                callback: btnAction,
                size:  90,
                bColor: Colors.grey,
                textColor: Colors.brown,
              ),
              myButton(
                bText: "÷",
                callback: btnAction,
                size:  90,
                bColor: Colors.lightBlue,
                textColor: Colors.brown,
              )//√
            ],
          ),
          /* 2ND ROW */
          Row(
            children: [
              myButton(
                bText: "7",
                callback: btnAction,
                size:  90,
                bColor: Colors.grey,
                textColor: Colors.brown,
              ),
              myButton(
                bText: "8",
                callback: btnAction,
                size: 90,
                bColor: Colors.grey,
                textColor: Colors.brown,
              ),
              myButton(
                bText: "9",
                callback: btnAction,
                size:  90,
                bColor: Colors.grey,
                textColor: Colors.brown,
              ),
              myButton(
                bText: "×",
                callback: btnAction,
                size:  90,
                bColor: Colors.lightBlue,
                textColor: Colors.brown,
              )
            ],
          ),
          /* 3RD ROW */
          Row(
            children: [
              myButton(
                bText: "4",
                callback: btnAction,
                size:  90,
                bColor: Colors.grey,
                textColor: Colors.brown,
              ),
              myButton(
                bText: "5",
                callback: btnAction,
                size: 90,
                bColor: Colors.grey,
                textColor: Colors.brown,
              ),
              myButton(
                bText: "6",
                callback: btnAction,
                size:  90,
                bColor: Colors.grey,
                textColor: Colors.brown,
              ),
              myButton(
                bText: "-",
                callback: btnAction,
                size:  90,
                bColor: Colors.lightBlue,
                textColor: Colors.brown,
              )
            ],
          ),
          /* 4TH ROW*/
          Row(
            children: [
              myButton(
                bText: "1",
                callback: btnAction,
                size:  90,
                bColor: Colors.grey,
                textColor: Colors.brown,
              ),
              myButton(
                bText: "2",
                callback: btnAction,
                size: 90,
                bColor: Colors.grey,
                textColor: Colors.brown,
              ),
              myButton(
                bText: "3",
                callback: btnAction,
                size:  90,
                bColor: Colors.grey,
                textColor: Colors.brown,
              ),
              myButton(
                bText: "+",
                callback: btnAction,
                size:  90,
                bColor: Colors.lightBlue,
                textColor: Colors.brown,
              )
            ],
          ),
          /* 5TH ROW*/
          Row(
            children: [
              myButton(
                bText: "0",
                callback: btnAction,
                size:  90,
                bColor: Colors.grey,
                textColor: Colors.brown,
              ),
              myButton(
                bText: "∙",
                callback: btnAction,
                size: 90,
                bColor: Colors.black,
                textColor: Colors.white,
              ),
              myButton(
                bText: "⌫",
                callback: btnAction,
                size:  90,
                bColor: Colors.deepOrange,
                textColor: Colors.brown,
              ),
              myButton(
                bText: "=",
                callback: btnAction,
                size:  90,
                bColor: Colors.pinkAccent,
                textColor: Colors.brown,
              )
            ],
          )
        ],
      )
    );
  }
}