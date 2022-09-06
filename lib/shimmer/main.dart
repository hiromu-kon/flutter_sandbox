import 'package:flutter/material.dart';
import 'package:flutter_sandbox/shimmer/shimmer.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shimmer Sample'),
      ),
      body: ref.watch(fetchfoodProvider).when(
            data: (food) => ListView.builder(
              itemCount: food.length,
              itemBuilder: (context, index) => buildFood(food[index]),
            ),
            error: (error, stack) => Center(
                child: Text(
              error.toString(),
            )),
            loading: () => ListView.builder(
              itemCount: 8,
              itemBuilder: (context, index) => buildFoodShimmer(),
            ),
          ),
    );
  }

  Widget buildFood(Food food) => ListTile(
        leading: CircleAvatar(
          radius: 32,
          backgroundImage: NetworkImage(food.urlImage),
        ),
        title: Text(
          food.title,
          style: const TextStyle(fontSize: 16),
        ),
        subtitle: Text(
          food.description,
          style: const TextStyle(fontSize: 14),
          maxLines: 1,
        ),
      );

  Widget buildFoodShimmer() => const ListTile(
        leading: ShimmerWidget.circular(width: 64, height: 64),
        title: ShimmerWidget.rectangular(
          height: 16,
        ),
        subtitle: ShimmerWidget.rectangular(height: 14),
      );
}

final fetchfoodProvider = FutureProvider<List<Food>>((ref) async {
  await Future.delayed(
    const Duration(seconds: 3),
  );
  return [
    Food(
      title: 'apple',
      urlImage:
          'https://images.unsplash.com/photo-1570913149827-d2ac84ab3f9a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
      description:
          'An apple is an edible fruit produced by an apple tree (Malus domestica).',
    ),
    Food(
      title: 'banana',
      urlImage:
          'https://images.unsplash.com/photo-1528825871115-3581a5387919?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8YmFuYW5hfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60',
      description:
          'A banana is an elongated, edible fruit - botanically a berry.',
    ),
    Food(
      title: 'peach',
      urlImage:
          'https://images.unsplash.com/photo-1629828874514-c1e5103f2150?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8cGVhY2h8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60',
      description:
          'The peach (Prunus persica) is a deciduous tree first domesticated and cultivated in Zhejiang province of Eastern China.',
    ),
    Food(
      title: 'grape',
      urlImage:
          'https://images.unsplash.com/photo-1601275868399-45bec4f4cd9d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8Z3JhcGV8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60',
      description:
          'A grape is a fruit, botanically a berry, of the deciduous woody vines of the flowering plant genus Vitis.',
    ),
    Food(
      title: 'lemon',
      urlImage:
          'https://images.unsplash.com/photo-1587496679742-bad502958fbf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8JUUzJTgyJThDJUUzJTgyJTgyJUUzJTgyJTkzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60',
      description:
          'The lemon (Citrus limon) is a species of small evergreen trees in the flowering plant family Rutaceae, native to Asia, primarily Northeast India (Assam), Northern Myanmar or China.',
    ),
    Food(
      title: 'orange',
      urlImage:
          'https://images.unsplash.com/photo-1580052614034-c55d20bfee3b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8b3JhbmdlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60',
      description:
          'An orange is a fruit of various citrus species in the family Rutaceae (see list of plants known as orange).',
    ),
  ];
});

class Food {
  Food({
    required this.title,
    required this.urlImage,
    required this.description,
  });

  final String title;
  final String urlImage;
  final String description;
}
