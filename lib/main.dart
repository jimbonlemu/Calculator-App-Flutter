import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String onScreenText = '0';

  @override
  Widget build(BuildContext context) {
    final colorLight = Theme.of(context).primaryColorLight;
    final colorDark = Theme.of(context).primaryColorDark;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Theme.of(context).primaryColor,
              alignment: Alignment.centerRight,
              child: Text(
                onScreenText,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
          GridView.count(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            crossAxisCount: 4,
            children: <Widget>[
              CalculatorButton(
                onTapped: () {
                  setState(() {
                    onScreenText = '0';
                  });
                },
                backgroundColor: colorLight,
                foregroundColor: colorDark,
                text: 'C',
              ),
              CalculatorButton(
                backgroundColor: colorLight,
                foregroundColor: colorDark,
                text: '+/-',
              ),
              CalculatorButton(
                backgroundColor: colorLight,
                foregroundColor: colorDark,
                text: '%',
              ),
              CalculatorButton(
                onTapped: () {
                  setState(() {
                    if (onScreenText == '0' ||
                        onScreenText == '' ||
                        onScreenText.length == 1) {
                      onScreenText = '0';
                    } else {
                      onScreenText =
                          onScreenText.substring(0, onScreenText.length - 1);
                    }
                  });
                },
                backgroundColor: colorDark,
                foregroundColor: colorLight,
                icon: Icon(
                  Icons.backspace,
                  color: colorLight,
                ),
              ),
              CalculatorButton(
                onTapped: () {
                  numberPressed(7);
                },
                backgroundColor: colorLight,
                foregroundColor: colorDark,
                text: '7',
              ),
              CalculatorButton(
                onTapped: () {
                  numberPressed(8);
                },
                backgroundColor: colorLight,
                foregroundColor: colorDark,
                text: '8',
              ),
              CalculatorButton(
                onTapped: () {
                  numberPressed(9);
                },
                backgroundColor: colorLight,
                foregroundColor: colorDark,
                text: '9',
              ),
              CalculatorButton(
                backgroundColor: colorDark,
                foregroundColor: colorLight,
                text: '/',
              ),
              CalculatorButton(
                onTapped: () {
                  numberPressed(4);
                },
                backgroundColor: colorLight,
                foregroundColor: colorDark,
                text: '4',
              ),
              CalculatorButton(
                onTapped: () {
                  numberPressed(5);
                },
                backgroundColor: colorLight,
                foregroundColor: colorDark,
                text: '5',
              ),
              CalculatorButton(
                onTapped: () {
                  numberPressed(6);
                },
                backgroundColor: colorLight,
                foregroundColor: colorDark,
                text: '6',
              ),
              CalculatorButton(
                backgroundColor: colorDark,
                foregroundColor: colorLight,
                text: 'x',
              ),
              CalculatorButton(
                onTapped: () {
                  numberPressed(1);
                },
                backgroundColor: colorLight,
                foregroundColor: colorDark,
                text: '1',
              ),
              CalculatorButton(
                onTapped: () {
                  numberPressed(2);
                },
                backgroundColor: colorLight,
                foregroundColor: colorDark,
                text: '2',
              ),
              CalculatorButton(
                onTapped: () {
                  numberPressed(3);
                },
                backgroundColor: colorLight,
                foregroundColor: colorDark,
                text: '3',
              ),
              CalculatorButton(
                backgroundColor: colorDark,
                foregroundColor: colorLight,
                text: '-',
              ),
              CalculatorButton(
                onTapped: () {
                  numberPressed(0);
                },
                backgroundColor: colorLight,
                foregroundColor: colorDark,
                text: '0',
              ),
              CalculatorButton(
                onTapped: () {
                  setState(() {
                    if (!onScreenText.contains('.')) {
                      onScreenText = '$onScreenText.';
                    }
                  });
                },
                backgroundColor: colorLight,
                foregroundColor: colorDark,
                text: '.',
              ),
              CalculatorButton(
                backgroundColor: Colors.grey[400]!,
                foregroundColor: colorDark,
                text: '=',
              ),
              CalculatorButton(
                backgroundColor: colorDark,
                foregroundColor: colorLight,
                text: '=',
              ),
            ],
          ),
        ],
      ),
    );
  }

  void numberPressed(int number) {
    setState(() {
      if (onScreenText == '0') {
        onScreenText = '$number';
      } else {
        onScreenText = '$onScreenText$number';
      }
    });
  }
}

class CalculatorButton extends StatelessWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final String? text;
  final Icon? icon;
  final void Function()? onTapped;

  const CalculatorButton({
    super.key,
    required this.backgroundColor,
    required this.foregroundColor,
    this.onTapped,
    this.icon,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: Container(
        color: backgroundColor,
        child: Center(
          child: icon ??
              Text(
                text!,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: foregroundColor),
              ),
        ),
      ),
    );
  }
}
