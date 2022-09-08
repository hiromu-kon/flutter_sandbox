import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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

/// cached_network_imageのサンプル
///
/// インターネットから画像を取得、表示し、キャッシュに保持するためのflutterライブラリ
///
/// Pub.dev https://pub.dev/packages/cached_network_image
/// 参考記事 https://zenn.dev/susatthi/articles/20220615-160504-flutter-cached-network-image-test
class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: 20,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) => CachedNetworkImage(
          imageUrl: 'https://source.unsplash.com/random?sig=$index/100x100',

          // 読み込み中に進捗表示する
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
            child: CircularProgressIndicator(
              value: downloadProgress.progress,
            ),
          ),

          // プレースホルダーを表示する
          // placeholder: (context, url) => Container(
          //   color: Colors.black12,
          // ),

          // 画像表示処理をカスタマイズする
          imageBuilder: (context, imageProvider) => ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image(
              image: imageProvider,
            ),
          ),
          // エラー時にエラーアイコンを表示する
          errorWidget: (context, url, error) => Container(
            color: Colors.black12,
            child: const Icon(
              Icons.error,
              color: Colors.red,
              size: 80,
            ),
          ),
        ),
      ),
    );
  }
}
