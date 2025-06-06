import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String?> textBasedConversation(String userInput) async {
  final url = Uri.parse('http://localhost:8080/api/ai/text');
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({'userInput': userInput});

  final res = await http.post(url, headers: headers, body: body);

  if (res.statusCode == 200) {
    final decodeRes = jsonDecode(res.body) as Map<String, dynamic>;
    if (decodeRes['status'] == 'success') {
      return decodeRes['message'];
    } else {
      throw Exception('Error: ${decodeRes['message']}');
    }
  }
}

void imageBasedConversation(String userInput) {}
