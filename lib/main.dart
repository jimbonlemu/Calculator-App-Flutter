import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

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
  String onScreenText = '';
  Parser parser = Parser();
  ContextModel contextModel = ContextModel();

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
                    clearScreen();
                  });
                },
                backgroundColor: Colors.grey[400]!,
                foregroundColor: colorDark,
                text: 'C',
              ),
              CalculatorButton(
                onTapped: () {
                  setState(() {
                    showText('+/-');
                  });
                },
                backgroundColor: Colors.grey[400]!,
                foregroundColor: colorDark,
                text: '+/-',
              ),
              CalculatorButton(
                onTapped: () {
                  setState(() {
                    showText('%');
                  });
                },
                backgroundColor: Colors.grey[400]!,
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
                  showText('7');
                },
                backgroundColor: colorLight,
                foregroundColor: colorDark,
                text: '7',
              ),
              CalculatorButton(
                onTapped: () {
                  showText('8');
                },
                backgroundColor: colorLight,
                foregroundColor: colorDark,
                text: '8',
              ),
              CalculatorButton(
                onTapped: () {
                  showText('9');
                },
                backgroundColor: colorLight,
                foregroundColor: colorDark,
                text: '9',
              ),
              CalculatorButton(
                onTapped: () {
                  setState(() {
                    showText('/');
                  });
                },
                backgroundColor: colorDark,
                foregroundColor: colorLight,
                text: '/',
              ),
              CalculatorButton(
                onTapped: () {
                  showText('4');
                },
                backgroundColor: colorLight,
                foregroundColor: colorDark,
                text: '4',
              ),
              CalculatorButton(
                onTapped: () {
                  showText('5');
                },
                backgroundColor: colorLight,
                foregroundColor: colorDark,
                text: '5',
              ),
              CalculatorButton(
                onTapped: () {
                  showText('6');
                },
                backgroundColor: colorLight,
                foregroundColor: colorDark,
                text: '6',
              ),
              CalculatorButton(
                onTapped: () {
                  setState(() {
                    showText('*');
                  });
                },
                backgroundColor: colorDark,
                foregroundColor: colorLight,
                text: 'x',
              ),
              CalculatorButton(
                onTapped: () {
                  showText('1');
                },
                backgroundColor: colorLight,
                foregroundColor: colorDark,
                text: '1',
              ),
              CalculatorButton(
                onTapped: () {
                  showText('2');
                },
                backgroundColor: colorLight,
                foregroundColor: colorDark,
                text: '2',
              ),
              CalculatorButton(
                onTapped: () {
                  showText('3');
                },
                backgroundColor: colorLight,
                foregroundColor: colorDark,
                text: '3',
              ),
              CalculatorButton(
                onTapped: () {
                  setState(() {
                    showText('-');
                  });
                },
                backgroundColor: colorDark,
                foregroundColor: colorLight,
                text: '-',
              ),
              CalculatorButton(
                onTapped: () {
                  showText('0');
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
                onTapped: () {
                  setState(() {
                    calculateResult();
                  });
                },
                backgroundColor: Colors.grey[400]!,
                foregroundColor: colorDark,
                text: '=',
              ),
              CalculatorButton(
                onTapped: () {
                  setState(() {
                    showText('+');
                  });
                },
                backgroundColor: colorDark,
                foregroundColor: colorLight,
                text: '+',
              ),
            ],
          ),
        ],
      ),
    );
  }

  void calculateResult() {
    try {
      Expression expression = parser.parse(onScreenText);
      double result = expression.evaluate(EvaluationType.REAL, contextModel);

      if (onScreenText.contains('%')) {
        double percentage = result / 100;
        setState(() {
          onScreenText = percentage.toString();
        });
      } else if (onScreenText.contains('+/-')) {
        setState(() {
          onScreenText = (-result).toString();
        });
      } else {
        int resultAsInt = result.toInt();
        setState(() {
          onScreenText = resultAsInt.toString();
        });
      }
    } catch (e) {
      setState(() {
        onScreenText = 'Error';
      });
    }
  }

  void clearScreen() {
    setState(() {
      onScreenText = '';
    });
  }

  void showText(String number) {
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
