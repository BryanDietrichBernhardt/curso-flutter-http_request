import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {
  //                       // url       // route     // params
  final uri = Uri.http('www.example.com', '/api', {'q': 'flutter'});
  print(uri);

  final future = http.get(uri);
  String responseData = "";

  await future.then(
    (response) {
      if (response.statusCode == 200) {
        responseData = "Página carreagada com sucesso.";
        print(response.body);
      }
      if (response.statusCode == 301) {
        responseData = "Página movida permanentemente.";
      }
      if (response.statusCode == 404) {
        responseData = "Página não encontrada.";
      }
      if (response.statusCode == 500) {
        responseData = "Erro interno do servidor.";
      }
    },
  );

  future.catchError((error) => print(error));
  future.whenComplete(() => print('Future completo!'));

  Future<void> showHtml() async {
    print(responseData);
  }

  showHtml();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(
        title: 'Req HTTP',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
      ),
      body: const Center(),
    );
  }
}
