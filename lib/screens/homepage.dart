import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: FutureBuilder(
        future: _getFacts('https://catfact.ninja/fact'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Text(snapshot.data.toString());
          }
          return const CircularProgressIndicator();
        },
      ),
    ));
  }

  Future<String> _getFacts(String url) async {
    final response = await http.get(Uri.parse(url));
    return jsonDecode(response.body)['fact'];
  }
}

// https://catfact.ninja/fact


