import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hide Bottom Navigation Bar'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: ListView(
          controller: scrollController,
          children: [
            Container(
              height: 400,
              color: Colors.red,
            ),
            Container(
              height: 400,
              color: Colors.yellow,
            ),
            Container(
              height: 400,
              color: Colors.blue,
            ),
            Container(
              height: 400,
              color: Colors.purple,
            ),
            Container(
              height: 400,
              color: Colors.orange,
            ),
            Container(
              height: 400,
              color: Colors.pink,
            ),
          ],
        ),
      ),
      bottomNavigationBar: AnimatedBuilder(
        animation: scrollController,
        builder: (context, child) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: scrollController.position.userScrollDirection ==
                  ScrollDirection.reverse
              ? 0
              : 100,
          child: child,
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.amber[200],
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.child_friendly),
              label: 'Child',
            ),
          ],
        ),
      ),
    );
  }
}
