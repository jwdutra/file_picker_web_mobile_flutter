import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'File Picker Flutter '),
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
  final FileUploader _controller = FileUploader();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                if (!kIsWeb) {
                  _controller.uploadFiles();
                } else {
                  const snackBar =
                      SnackBar(content: Text('Este não é um ambiente mobile!'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: const Text('Envio de arquivos por dispositivo móvel'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (kIsWeb) {
                  _controller.uploadFilesFromBytes();
                } else {
                  const snackBar =
                      SnackBar(content: Text('Este não é um ambiente web!'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: const Text('Envio de arquivos pela web'),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
