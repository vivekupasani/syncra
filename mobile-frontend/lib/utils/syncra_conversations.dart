import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:syncra/models/content.dart';

final baseUrl = "https://api-syncra.onrender.com/";
// final baseUrl = "http://localhost:8080/";

Future<Content> textBasedConversation(String userInput) async {
  //creating variables for the API request
  final url = Uri.parse('${baseUrl}api/ai/text');
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

      return Content.fromJson(decodeRes);
    } else {
      //Throwing an exception if the status is not success
      throw Exception('Error: ${decodeRes['message']}');
    }
  } else {
    throw Exception('Error');
  }
}

Future<Content> imageBasedConversation(String userInput) async {
  //creating variables for the API request
  final url = Uri.parse('${baseUrl}api/ai/image');
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({'userInput': userInput});

  final res = await http.post(url, headers: headers, body: body);

  if (res.statusCode == 200) {
    final decodeRes = jsonDecode(res.body) as Map<String, dynamic>;

    if (decodeRes['status'] == 'success') {
      //Returning the message from the response
      return Content.fromJson(decodeRes);
    } else {
      //Throwing an exception if the status is not success
      throw Exception('Error: ${decodeRes['message']}');
    }
  } else {
    throw Exception(res.body);
  }
}
