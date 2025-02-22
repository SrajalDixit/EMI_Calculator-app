import 'package:calculator/screens/HomePage.dart';
import 'package:calculator/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  //variables
  var input = "";
  var output = "";
  var operator = "";
  double inputSize = 50; // Initial size for input text
  Color inputColor = Colors.black; // Initial color for input text
  double outputSize = 30; // Initial size for output text
  Color outputColor = Colors.black.withOpacity(0.7);

  onButtonClick(value) {
    if (value == "AC") {
      input = "";
      output = "";
    } else if (value == "<-") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll('x', '*');
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        inputSize = 30; // Change input text size
        inputColor = Colors.black.withOpacity(0.7); // Change input text color
        outputSize = 50; // Change output text size
        outputColor = Colors.black;
        if (output.endsWith('.0')) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
      }
    } else {
      input = input + value;
      inputSize = 50; // Reset input text size
      inputColor = Colors.black; // Reset input text color
      outputSize = 30; // Reset output text size
      outputColor = Colors.black.withOpacity(0.7);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        ); // Replace the current screen with HomePage
        return false; // Prevent default back button behavior
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            //input output area
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      input,
                      style: TextStyle(
                        fontSize: inputSize,
                        color: inputColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      output,
                      style: TextStyle(
                        fontSize: outputSize,
                        color: outputColor,
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ),
      
            // Button area
            Row(
              children: [
                button(
                  text: "AC",
                  tColor: Colors.white,
                  buttonBGColor: orangeColor,
                ),
                button(
                  text: "<-",
                  tColor: Colors.white,
                  buttonBGColor: orangeColor,
                ),
                button(
                  text: "^",
                  tColor: Colors.white,
                  buttonBGColor: orangeColor,
                ),
                button(
                  text: "/",
                  tColor: Colors.white,
                  buttonBGColor: orangeColor,
                ),
              ],
            ),
            Row(
              children: [
                button(text: "9",buttonBGColor: Colors.grey,),
                button(text: "8",buttonBGColor: Colors.grey,),
                button(text: "7",buttonBGColor: Colors.grey,),
                button(
                  text: "x",
                  tColor: Colors.white,
                  buttonBGColor: orangeColor,
                ),
              ],
            ),
            Row(
              children: [
                button(text: "6",buttonBGColor: Colors.grey,),
                button(text: "5",buttonBGColor: Colors.grey,),
                button(text: "4",buttonBGColor: Colors.grey,),
                button(
                  text: "-",
                  tColor: Colors.white,
                  buttonBGColor: orangeColor,
                ),
              ],
            ),
            Row(
              children: [
                button(text: "3",buttonBGColor: Colors.grey,),
                button(text: "2",buttonBGColor: Colors.grey,),
                button(text: "1",buttonBGColor: Colors.grey,),
                button(
                  text: "+",
                  tColor: Colors.white,
                  buttonBGColor: orangeColor,
                ),
              ],
            ),
            Row(
              children: [
                button(
                  text: ".",
                  buttonBGColor: Colors.grey,
                ),
                button(
                  text: "0",
                  buttonBGColor: Colors.grey,
                ),
                button(
                  text: "%",
                  tColor: Colors.white,
                  buttonBGColor: orangeColor,
                ),
                button(
                  text: "=",
                  tColor: Colors.white,
                  buttonBGColor: orangeColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget button({required String text, Color tColor = Colors.black, Color buttonBGColor = Colors.white}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonBGColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            padding: const EdgeInsets.all(22),
          ),
          onPressed: () => onButtonClick(text),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: tColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
