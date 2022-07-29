import 'package:http/http.dart' as http;

class BaseAPI {
  static Future apiGet<T>({required String url}) async {
    final res = await http.get(Uri.parse(url));
    return res;
  }
}
