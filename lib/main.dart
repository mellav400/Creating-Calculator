import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorScreen(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
      ),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String display = '0';

  void buttonPressed(String label) {
    setState(() {
      if (label == 'AC') {
        display = '0';
      } else if (label == '=') {
        // Logic for calculation here
      } else {
        if (display == '0') {
          display = label;
        } else {
          display += label;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            _buildDisplay(),
            Divider(color: Colors.white),
            _buildButtonGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildDisplay() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
      child: Text(
        display,
        style: TextStyle(color: Colors.white, fontSize: 80),
      ),
    );
  }

  Widget _buildButtonGrid() {
    return Column(
      children: [
        _buildButtonRow(['C', '+/-', '%', '÷']),
        _buildButtonRow(['7', '8', '9', '×']),
        _buildButtonRow(['4', '5', '6', '−']),
        _buildButtonRow(['1', '2', '3', '+']),
        _buildButtonRow(['0', ',', '='], isLastRow: true),
      ],
    );
  }

  Widget _buildButtonRow(List<String> labels, {bool isLastRow = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: labels.map((label) {
        return CalculatorButton(
          label: label,
          isZero: isLastRow && label == '0',
          onPressed: buttonPressed,
        );
      }).toList(),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String label;
  final bool isZero;
  final Function(String) onPressed;

  const CalculatorButton({
    Key? key,
    required this.label,
    this.isZero = false,
    required this.onPressed,
  }) : super(key: key);

  Color _getButtonColor() {
    if (['C', '+/-', '%'].contains(label)) {
      return Colors.grey[300]!;
    } else if (['÷', '×', '−', '+', '='].contains(label)) {
      return Colors.orange;
    } else {
      return Colors.grey[700]!;
    }
  }

  Color _getTextColor(String label) {
    return Color.fromARGB(255, 50, 50, 50); // Warna latar belakang tombol yang lebih gelap
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => onPressed(label),
        child: Container(
          width: isZero ? 160 : 80,
          height: 80,
          decoration: BoxDecoration(
            color: _getButtonColor(),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: _getTextColor(label),
                fontSize: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
