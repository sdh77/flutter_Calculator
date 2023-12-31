// ignore_for_file: camel_case_types

import 'package:calculator/screen/KeyPad.dart';
import 'package:flutter/material.dart';

class calc extends StatefulWidget {
  const calc({
    super.key,
  });

  @override
  State<calc> createState() => calcState();

  static calcState? changeValue(BuildContext context) =>
      context.findAncestorStateOfType<calcState>();
}

class calcState extends State<calc> {
  double calcValue = 0;
  double beforeValue = 0;
  String inputValue = "";
  String calcText = "";
  bool stateDouble = false;
  bool stateBefore = false;
  set string(String value) => setState(() => inputValue = value);

  @override
  Widget build(BuildContext context) {
    const Color calcBtnBg = Color.fromRGBO(252, 158, 12, 1);

    const Color topBtnBg = Color.fromRGBO(107, 107, 107, 1);

    const Color numBtnBg = Color.fromRGBO(133, 133, 133, 1);
    if (double.tryParse(inputValue) != null) {
      if (calcValue == 0) {
        calcValue = double.parse(inputValue);
        stateBefore = false;
      } else {
        calcValue = calcValue * 10 + double.parse(inputValue);
      }
    } else if (inputValue == "AC") {
      calcValue = 0;
      beforeValue = 0;
      stateBefore = false;
      stateDouble = false;
    } else {
      if (beforeValue == 0) {
        beforeValue = calcValue;
        calcValue = 0;
        stateBefore = true;
        if (inputValue == "%") {
          beforeValue = beforeValue / 100;
        } else if (inputValue == "±") {
          beforeValue = -beforeValue;
        }
      } else {
        if (calcText == "÷") {
          if (calcValue == 0) {
            calcValue = 00000;
          } else {
            beforeValue = beforeValue / calcValue;
          }
          stateDouble = true;
        } else if (calcText == "+") {
          beforeValue = beforeValue + calcValue;
        } else if (calcText == "-") {
          beforeValue = beforeValue - calcValue;
        } else if (calcText == "×") {
          beforeValue = beforeValue * calcValue;
        } else if (inputValue == "%") {
          beforeValue = beforeValue / 100;
          stateDouble = true;
        } else if (inputValue == "±") {
          print(stateBefore);
          stateBefore ? beforeValue = -beforeValue : calcValue = -calcValue;
        }

        calcText = inputValue;
        calcValue = 0;
        stateBefore = true;
      }
      print(stateBefore);
    }
    print(beforeValue.toInt());
    print(calcValue);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Padding(
                padding: const EdgeInsets.all(30),
                child: Container(
                  alignment: Alignment.topRight,
                  child: Text(
                    stateBefore
                        ? stateDouble
                            ? beforeValue.toStringAsFixed(2)
                            : beforeValue.toStringAsFixed(0)
                        : stateDouble
                            ? calcValue.toStringAsFixed(2)
                            : calcValue.toStringAsFixed(0),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
            ]),
          ),
          const onceRow(
            bgList: [topBtnBg, topBtnBg, topBtnBg, calcBtnBg],
            textList: ["AC", "±", "%", "÷"],
            isLastLine: false,
          ),
          const onceRow(
            bgList: [numBtnBg, numBtnBg, numBtnBg, calcBtnBg],
            textList: ["7", "8", "9", "×"],
            isLastLine: false,
          ),
          const onceRow(
            bgList: [numBtnBg, numBtnBg, numBtnBg, calcBtnBg],
            textList: ["4", "5", "6", "-"],
            isLastLine: false,
          ),
          const onceRow(
            bgList: [numBtnBg, numBtnBg, numBtnBg, calcBtnBg],
            textList: ["1", "2", "3", "+"],
            isLastLine: false,
          ),
          const onceRow(
            bgList: [numBtnBg, numBtnBg, calcBtnBg],
            textList: ["0", ".", "="],
            isLastLine: true,
          ),
        ],
      ),
    );
  }
}

class onceRow extends StatelessWidget {
  const onceRow({
    super.key,
    required this.textList,
    required this.bgList,
    required this.isLastLine,
  });

  final List textList;
  final List bgList;
  final bool isLastLine;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: Row(
        children: [
          KeyPad(
            bgColor: bgList[0],
            keyPadText: textList[0],
            isZero: isLastLine,
          ),
          KeyPad(
            bgColor: bgList[1],
            keyPadText: textList[1],
            isZero: false,
          ),
          KeyPad(
            bgColor: bgList[2],
            keyPadText: textList[2],
            isZero: false,
          ),
          if (!isLastLine)
            KeyPad(
              bgColor: bgList[3],
              keyPadText: textList[3],
              isZero: false,
            ),
        ],
      ),
    );
  }
}
