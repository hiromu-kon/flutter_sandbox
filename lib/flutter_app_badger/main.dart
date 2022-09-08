import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
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

/// flutter_app_badgerのサンプル
///
/// アプリアイコンにバッジを表示したり、バッジの数値を変更するためのflutterライブラリ
///
/// Pub.dev https://pub.dev/packages/flutter_app_badger
class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = useState<int>(0);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(counter.value.toString()),
            ElevatedButton(
              onPressed: () {
                counter.value++;

                // バッジを追加するメソッド
                FlutterAppBadger.updateBadgeCount(counter.value);
              },
              child: const Text('Count Up'),
            ),
            ElevatedButton(
              onPressed: () {
                counter.value--;

                // バッジを追加するメソッド
                FlutterAppBadger.updateBadgeCount(counter.value);
              },
              child: const Text('Count Down'),
            ),
            ElevatedButton(
              onPressed: () {
                counter.value = 0;

                // バッジを削除するメソッド
                FlutterAppBadger.removeBadge();
              },
              child: const Text('Count Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
