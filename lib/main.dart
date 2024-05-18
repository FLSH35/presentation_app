import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Guessing Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NumberGuessingGame(),
    );
  }
}

class NumberGuessingGame extends StatefulWidget {
  @override
  _NumberGuessingGameState createState() => _NumberGuessingGameState();
}

class _NumberGuessingGameState extends State<NumberGuessingGame> {
  final _random = Random();
  late int _targetNumber;
  final TextEditingController _controller = TextEditingController();
  String _feedback = '';
  bool _gameOver = false;

  @override
  void initState() {
    super.initState();
    _startNewGame();
  }

  void _startNewGame() {
    _targetNumber = _random.nextInt(100) + 1;
    _feedback = '';
    _controller.clear();
    _gameOver = false;
  }

  void _checkGuess() {
    if (_controller.text.isEmpty) return;

    final guess = int.tryParse(_controller.text);
    if (guess == null) {
      setState(() {
        _feedback = 'Please enter a valid number.';
      });
      return;
    }

    setState(() {
      if (guess < _targetNumber) {
        _feedback = 'Too low!';
      } else if (guess > _targetNumber) {
        _feedback = 'Too high!';
      } else {
        _feedback = 'You guessed it!';
        _gameOver = true;
      }
    });
  }

  void _resetGame() {
    setState(() {
      _startNewGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Guessing Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'I\'m thinking of a number between 1 and 100.',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your guess',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _gameOver ? null : _checkGuess,
              child: Text('Guess'),
            ),
            SizedBox(height: 20),
            Text(
              _feedback,
              style: TextStyle(fontSize: 24, color: Colors.red),
            ),
            if (_gameOver)
              Column(
                children: [
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _resetGame,
                    child: Text('Play Again'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
