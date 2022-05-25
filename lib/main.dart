import 'package:flutter/material.dart';
import 'package:staggered_view/staggered_screen.dart';

import 'global_enums.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyHomePage()));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> layouts = [
    "Staggered",
    "Masonry",
    "Quilted",
    "Woven",
    "Staired",
    "Aligned"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Layouts"),
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => StaggeredScreen(
                        selectedGrid: GridType.values[index],
                        title: layouts[index]))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: Text(layouts[index],
                        style: TextStyle(fontSize: 16, color: Colors.black))),
                const SizedBox(width: 20),
                const Icon(
                  Icons.navigate_next_rounded,
                  color: Colors.redAccent,
                  size: 30,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
