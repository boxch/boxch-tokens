import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

start(HttpRequest request) async {
  await (request.response..write("Boxch server")).close();
}

getTokens(HttpRequest request) async {
  File('tokens.json')
    .readAsString()
    .then((fileContents) => json.decode(fileContents))
    .then((jsonData) async {
       await (request.response..write(json.encode(jsonData))).close();
    });
}

dataStruct(HttpRequest request) async {
  var response = await http.get(Uri.parse("https://cache.jup.ag/tokens"));
  List jsonDecode = json.decode(response.body);
  Map newStruct = {}; 

  var i = 1;
  for (var element in jsonDecode) {
    print("add $i token");
    newStruct.addAll({
      "${element['address']}": {
        "address": element['address'],
        "name": element['name'],
        "symbol": element['symbol'],
        "decimals": element['decimals'],
        "logoUrl": element['logoURI']
      }
    });
    i++;
  }
  var tokensJson = json.encode(newStruct);

  await (request.response..write(tokensJson)).close();
}
