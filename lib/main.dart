import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(title: Text("Flutter Widgets")),
        body: WidgetsDemo(
          onThemeChanged: (bool isDark) {
            setState(() {
              isDarkTheme = isDark;
            });
          },
        ),
      ),
    );
  }
}

class WidgetsDemo extends StatefulWidget {
  final Function(bool) onThemeChanged;

  const WidgetsDemo({Key? key, required this.onThemeChanged}) : super(key: key);

  @override
  _WidgetsDemoState createState() => _WidgetsDemoState();
}

class _WidgetsDemoState extends State<WidgetsDemo> {
  int counter = 0;
  String userInput = "";
  bool isDarkTheme = false;
  List<int> numbers = [3, 7, 2, 8, 1, 4];
  String largestNumber = "";

  void findLargestNumber() {
    int largest = numbers.reduce((a, b) => a > b ? a : b);
    setState(() {
      largestNumber = largest.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        // 1. Button to increment a counter
        Text("Counter: $counter", style: TextStyle(fontSize: 18)),
        ElevatedButton(
          onPressed: () => setState(() => counter++),
          child: Text("Increment Counter"),
        ),
        Divider(),

        // 2. Function to find the largest number
        Text("Largest Number in List: $largestNumber", style: TextStyle(fontSize: 18)),
        ElevatedButton(
          onPressed: findLargestNumber,
          child: Text("Find Largest Number"),
        ),
        Divider(),

        // 3. Custom widget to display an image with title and description
        CustomImageWidget(
          imageAsset: 'assets/image/flutter.jpg',  // Changed from imageUrl to imageAsset
          title: 'Sample Image',
          description: 'This is a sample description below the image.',
        ),
        Divider(),

        // 4. Grid of colored boxes
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: List.generate(9, (index) {
            return Container(
              color: Colors.primaries[index % Colors.primaries.length],
              height: 50,
              width: 50,
            );
          }),
        ),
        Divider(),

        // 5. Widget to accept user input and display it in real-time
        TextField(
          decoration: InputDecoration(labelText: 'Enter text'),
          onChanged: (text) => setState(() => userInput = text),
        ),
        Text("You entered: $userInput", style: TextStyle(fontSize: 18)),
        Divider(),

        // 6. Theme toggler
        ElevatedButton(
          onPressed: () {
            setState(() {
              isDarkTheme = !isDarkTheme;
              widget.onThemeChanged(isDarkTheme);
            });
          },
          child: Text(isDarkTheme ? "Switch to Light Theme" : "Switch to Dark Theme"),
        ),
      ],
    );
  }
}

class CustomImageWidget extends StatelessWidget {
  final String imageAsset;  // Changed from imageUrl to imageAsset
  final String title;
  final String description;

  const CustomImageWidget({
    Key? key,
    required this.imageAsset,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(imageAsset),  // Changed from Image.network to Image.asset
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}