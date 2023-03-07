import 'dart:io';
import 'requests.dart';
import 'utils/constants.dart';


main() async {
  var address = serverAddress;
  Map<String, String> envVars = Platform.environment;
  var portEnv = envVars[port];
  var PORT = portEnv == null ? 3000 : int.parse(portEnv);

  var server = await HttpServer.bind(address, PORT);
  print(
       'Boxch server. http://localhost:${server.port}');


  server.listen((HttpRequest request) async {
    switch (request.uri.toString()) {
      case '/':
            start(request);
            break;
      case '/tokens':
            getTokens(request);
            break;
      case '/data_struct':
            dataStruct(request);
            break;
      default:
    }
  });
}
