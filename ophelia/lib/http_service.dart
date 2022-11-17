import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpService {
  final String stockURL = "http://192.168.86.42:8080/getFullProjecJson";

  Future<String> fetchAlbum() async {
    final response = await http
        .get(Uri.parse('http://192.168.86.42:8080/getFullProjecJson'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
