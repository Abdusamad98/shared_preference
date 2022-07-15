import 'package:ahred_preference/local_data/storage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var myString = '';

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    await StorageRepository.getInstance();
    setState(() {
      myString = StorageRepository.getString("word");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SharedPreferences Demo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Text(
              myString,
              style: TextStyle(fontSize: 48),
            ),
          ),
          Center(
            child: TextFormField(
              cursorHeight: 30,
              cursorColor: Colors.black,
              cursorWidth: 3,
              style: TextStyle(fontSize: 28),
              onChanged: (value) async {
                await StorageRepository.putString(key: "word", value: value);
                setState(() {
                  myString = StorageRepository.getString("word");
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
