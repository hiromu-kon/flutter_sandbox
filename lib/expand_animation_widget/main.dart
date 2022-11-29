import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

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
    final autoScrollController = AutoScrollController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ListView.builder(
        controller: autoScrollController,
        itemCount: 10,
        itemBuilder: ((context, index) => AutoScrollTag(
              child: ItemWidget(
                scrollController: autoScrollController,
                index: index,
              ),
              key: ValueKey(index),
              controller: autoScrollController,
              index: index,
            )),
      ),
    );
  }
}

class ItemWidget extends HookConsumerWidget {
  const ItemWidget(
      {Key? key, required this.scrollController, required this.index})
      : super(key: key);
  final AutoScrollController scrollController;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = useState<double>(0);

    final animatedController = useAnimationController(
      duration: Duration(milliseconds: 300),
    );

    final isAnimated = useState(false);
    return Column(
      children: [
        ColoredBox(
          color: Colors.red,
          child: ListTile(
            title: const Text('Hiromu Kondo'),
            trailing: IconButton(
              onPressed: () {
                isAnimated.value = !isAnimated.value;
                height.value != 0.0 ? height.value = 0.0 : height.value = 100;
                isAnimated.value
                    ? animatedController.forward()
                    : animatedController.reverse();
                scrollController.scrollToIndex(index);
              },
              icon: AnimatedIcon(
                  icon: AnimatedIcons.add_event, progress: animatedController),
              // icon: Icon(height.value == 0 ? Icons.add : Icons.remove),
            ),
            leading: const CircleAvatar(),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: height.value,
          child: const Text('Business: Engineer'),
        ),
      ],
    );
  }
}
