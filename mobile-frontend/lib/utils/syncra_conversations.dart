import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String?> textBasedConversation(String userInput) async {
  //creating variables for the API request
  final url = Uri.parse('https://api-syncra.onrender.com/api/ai/text');
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({'userInput': userInput});

  //Hitting the API endpoint and getting the response
  final res = await http.post(url, headers: headers, body: body);

  //Checking the response status code
  if (res.statusCode == 200) {
    //Decoding the response body
    final decodeRes = jsonDecode(res.body) as Map<String, dynamic>;

    //Checking if the response status is success
    if (decodeRes['status'] == 'success') {
      //Returning the message from the response
      return decodeRes['message'];
    } else {
      //Throwing an exception if the status is not success
      throw Exception('Error: ${decodeRes['message']}');
    }
  }
  return null;
}

void imageBasedConversation(String userInput) {}
