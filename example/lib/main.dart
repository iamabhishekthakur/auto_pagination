import 'package:auto_pagination/auto_pagination.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auto Pagination Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Example all for auto pagination"),
      ),
      body: AutoPagination(
        previousButton: const CircleAvatar(
          child: Icon(Icons.preview),
        ),
        items: [
          "random1",
          "random2",
          "random3",
          "random4",
          "random5",
          "random6",
          "random7",
          "random8",
          "random9",
          "random10",
          "random11",
          "random12",
          "random13",
          "random14",
        ]
            .map(
              (e) => Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(e),
              ),
            )
            .toList(),
      ),
    );
  }
}
