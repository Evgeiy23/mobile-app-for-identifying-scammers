import 'package:flutter/material.dart';
import 'dart:math';

class NeuralNetworkScreen extends StatefulWidget {
  const NeuralNetworkScreen({super.key});

  @override
  State<NeuralNetworkScreen> createState() => _NeuralNetworkScreenState();
}

class _NeuralNetworkScreenState extends State<NeuralNetworkScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  bool _isLoading = false;
  String _result = '';

  Future<void> _checkMessage() async {
    setState(() {
      _isLoading = true;
    });

    // Имитируем задержку и выдумываем вероятность
    await Future.delayed(const Duration(seconds: 1));
    final probability = Random().nextDouble();

    if (probability > 0.6) {
      _result =
          'Fraudster (probability ${probability.toStringAsFixed(2)})';
    } else if (probability < 0.4) {
      _result =
          'Not a fraudster (probability ${probability.toStringAsFixed(2)})';
    } else {
      _result =
          'Undetermined (probability ${probability.toStringAsFixed(2)})';
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Neural Network Check'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Enter a message to check',
                ),
                maxLines: 3,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 16),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        await _checkMessage();
                      }
                    },
                    child: const Text('Check'),
                  ),
            const SizedBox(height: 16),
            Text(
              _result,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
