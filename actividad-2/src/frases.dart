import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class ChuckNorrisJoke {
  final String joke;

  ChuckNorrisJoke(this.joke);

  factory ChuckNorrisJoke.fromJson(Map<String, dynamic> json) {
    return ChuckNorrisJoke(json['value'] as String);
  }
}

Future<ChuckNorrisJoke> consulta() async {
  var url = Uri.https('api.chucknorris.io', '/jokes/random', {'q': '{http}'});

  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    var joke = ChuckNorrisJoke.fromJson(jsonResponse);
    return joke;
  } else {
    throw Exception('Request failed with status: ${response.statusCode}.');
  }
}

void main(List<String> arguments) async {
  try {
    var joke = await consulta();
    print('Chuck Norris Joke: ${joke.joke}');
  } catch (e) {
    print('Error: $e');
  }
}
