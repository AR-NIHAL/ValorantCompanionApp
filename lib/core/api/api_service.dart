import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final base = "https://valorant-api.com/v1";

  Future getAgents() async {
    final res = await http.get(Uri.parse("$base/agents"));
    return jsonDecode(res.body)["data"];
  }

  Future getWeapons() async {
    final res = await http.get(Uri.parse("$base/weapons"));
    return jsonDecode(res.body)["data"];
  }

  Future getMaps() async {
    final res = await http.get(Uri.parse("$base/maps"));
    return jsonDecode(res.body)["data"];
  }
}