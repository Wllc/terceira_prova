import 'package:http/http.dart' as http;

class HttpCliente{

  final client = http.Client();

  Future get({required String url}) async{
    return await client.get(Uri.parse(url));
  }
}