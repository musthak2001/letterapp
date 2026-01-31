import 'package:flutter/material.dart';
import 'package:letterapp/api/apis.dart';

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Joke Generator')),
      body: const Center(child: ApiTestButton()),
    );
  }
}

class ApiTestButton extends StatefulWidget {
  const ApiTestButton({super.key});

  @override
  State<ApiTestButton> createState() => _ApiTestButtonState();
}

class _ApiTestButtonState extends State<ApiTestButton> {
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: () async {
            setState(() {
              result = 'Generating joke...';
            });

            // Prompt to generate a joke
            String prompt = 'Tell me a funny programming joke.';

            // Call API and get the text
            String joke = await APIs.getAnswer(prompt);

            setState(() {
              result = joke;
            });
          },
          child: const Text('Generate Joke'),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            result,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
