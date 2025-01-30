import 'package:http/http.dart' as http;

class ApiService {
  Future<void> fetchQuestions() async {
    final response =
        await http.get(Uri.parse("https://api.jsonserve.com/Uw5CrX"));

        if (response.statusCode == 200){
          
        }
  }
}
