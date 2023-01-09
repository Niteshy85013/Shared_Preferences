import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Nothing App",
      initialRoute: "/",
      routes: {
        "/": (context) => const MyApp(),
      },
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controller = TextEditingController();
  String data = "";
  _setDataToGetPref(String text) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString("my_key", text);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _getDataFromSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? value = prefs.getString("my_key");
    if (value != null) {
      setState(() {
        data = value;
      });
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("SharedPeferences")),
        backgroundColor: const Color.fromRGBO(38, 38, 38, 0.4),
      ),
      body: Column(children: [
        TextFormField(
          controller: controller,
          textAlign: TextAlign.start,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
                borderSide: BorderSide(
                  color: Color.fromRGBO(38, 38, 38, 0.4),
                )),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              _setDataToGetPref(controller.text);
            },
            child: const Text("Store data")),
        ElevatedButton(
            onPressed: () {
              _getDataFromSharedPref();
            },
            child: const Text("Get data")),
        Text(data)
      ]),
    );
  }
}
