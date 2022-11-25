// https://api.coingecko.com/api/v3/simple/price?ids=Bitcoin&vs_currencies=inr
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<double> getPrice(String id) async {
  try {
    var apiEnd =
        "https://api.coingecko.com/api/v3/simple/price?ids=$id&vs_currencies=inr";
    print(apiEnd);
    final Uri url = Uri.parse(apiEnd);
    var respone = await http.get(url);
    var json = jsonDecode(respone.body);
    print(id);
    var value = json[id]['inr'].toString();
    print(value);
    return double.parse(value);
  } catch (e) {
    print(e.toString());
    return 0.0;
  }
}
