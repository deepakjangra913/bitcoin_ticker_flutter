import 'dart:convert';

import 'package:http/http.dart' as http;

const apiKey = "CG-xpapGQdm4jbUwfviMx75wqd3";

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Future getData() async {
    final response = await http.get(
      Uri.parse('$url&x_cg_demo_api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    } else {
      print(response.statusCode);
    }
  }
}
