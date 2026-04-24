import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListScreen extends ConsumerWidget {
  final String title;
  final FutureProvider<List<dynamic>> provider;

  const ListScreen({
    super.key,
    required this.title,
    required this.provider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(provider);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: asyncValue.when(
        loading: () =>
            const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
        data: (list) {
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, i) {
              final item = list[i];

              return ListTile(
                leading: Image.network(
                  item["displayIcon"] ?? "",
                  width: 50,
                ),
                title: Text(item["displayName"] ?? "No name"),
              );
            },
          );
        },
      ),
    );
  }
}