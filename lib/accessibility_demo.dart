import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Accessible Image Widget
class AccessibleImage extends StatelessWidget {
  final String imageUrl;
  final String altText;
  final double? width;
  final double? height;
  final BoxFit fit;

  const AccessibleImage({
    Key? key,
    required this.imageUrl,
    required this.altText,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: altText,
      child: Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Semantics(
      label: 'Image not available: $altText',
      child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
    );
  }
}

/// Main App with Navigation for Views
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool showSemantics = false; // State for Semantics Debugger

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      showSemanticsDebugger: showSemantics, // ✅ Toggle Semantics Debugger
      home: HomePage(
        onToggleSemantics: () {
          setState(() {
            showSemantics = !showSemantics;
          });
        },
        showSemantics: showSemantics,
      ),
    );
  }
}

/// HomePage with Buttons to Switch Views
class HomePage extends StatefulWidget {
  final VoidCallback onToggleSemantics;
  final bool showSemantics;

  const HomePage({
    super.key,
    required this.onToggleSemantics,
    required this.showSemantics,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedView = 0; // 0 = Single, 1 = Grid, 2 = List

  List<Map<String, String>> images = [
    {'url': 'https://picsum.photos/200/300/', 'alt': 'Dynamic Placeholder Name'},
    {'url': 'https://picsum.photos/200/300/', 'alt': 'Dynamic Placeholder Name'},
    {'url': 'https://picsum.photos/200/300/', 'alt': 'Dynamic Placeholder Name'},
    {'url': 'https://picsum.photos/200/300/', 'alt': 'Dynamic Placeholder Name'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Toggle Views: Images')),
      body: Column(
        children: [
          /// Buttons to Switch Views
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton('Single View', 0),
              _buildButton('Grid View', 1),
              _buildButton('List View', 2),
              _buildSemanticsButton(), // ✅ Toggle Semantics Button
            ],
          ),

          const SizedBox(height: 10),

          /// Conditional View Rendering
          Expanded(
            child: selectedView == 0
                ? _buildSingleImage()
                : selectedView == 1
                ? _buildGridView()
                : _buildListView(),
          ),
        ],
      ),
    );
  }

  /// Single Image View
  Widget _buildSingleImage() {
    return const Center(
      child: AccessibleImage(
        imageUrl: 'https://picsum.photos/200/300/',
        altText: 'single_placeholder',
        width: 200,
        height: 150,
      ),
    );
  }

  /// Grid View
  Widget _buildGridView() {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return AccessibleImage(
          imageUrl: images[index]['url']!,
          altText: 'grid_${images[index]['alt']!}',
          width: 150,
          height: 150,
        );
      },
    );
  }

  /// List View
  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: AccessibleImage(
            imageUrl: images[index]['url']!,
            altText: 'list_${images[index]['alt']!}',
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }

  /// Button Widget to Change View
  Widget _buildButton(String text, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedView = index;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedView == index ? Colors.blue : Colors.grey,
          foregroundColor: Colors.white,
        ),
        child: Text(text),
      ),
    );
  }

  /// Semantics Debugger Toggle Button
  Widget _buildSemanticsButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: widget.onToggleSemantics,
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.showSemantics ? Colors.red : Colors.green,
          foregroundColor: Colors.white,
        ),
        child: Text(widget.showSemantics ? 'Disable Semantics' : 'Enable Semantics'),
      ),
    );
  }
}
