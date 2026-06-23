import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = "CG-xpapGQdm4jbUwfviMx75wqd3";

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Future getData() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    } else {
      print(response.statusCode);
    }
  }
}
