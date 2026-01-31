import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:letterapp/helper/global.dart';

class APIs {
  // Returns the generated text from OpenAI
  static Future<String> getAnswer(String prompt) async {
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/responses'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $OPEN_AI_APIKEY',
        },
        body: jsonEncode({
          "model": "gpt-5-nano",
          "input": [
            {"role": "user", "content": prompt}
          ]
        }),
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);

        // Extract the generated text
        final generatedText =
            data['output']?[1]?['content']?[0]?['text'] ?? '';
        return generatedText;
      } else {
        print('OpenAI API Error: ${res.statusCode}');
        print(res.body);
        return 'Failed to generate text.';
      }
    } catch (e) {
      print('Exception: $e');
      return 'Error generating text.';
    }
  }
}
