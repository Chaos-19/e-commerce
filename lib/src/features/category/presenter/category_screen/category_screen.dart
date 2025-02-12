import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_ecommerce/src/common_widgets/shared_scaffold.dart';
import 'package:pro_ecommerce/src/constants/strings.dart';
import 'package:pro_ecommerce/src/features/category/data/category_repository.dart';
import 'package:pro_ecommerce/src/features/category/domain/category.dart';

final categoryRepositoryProvider = Provider((ref) => CategoryRepository());

final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  final repository = ref.read(categoryRepositoryProvider);
  return repository.fetchCategories();
});

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsyncValue = ref.watch(categoriesProvider);

    return SharedScaffold(
      title: Strings.ecommerce,
      body: categoriesAsyncValue.when(
        data: (categories) => ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return ListTile(
              title: Text(category.name),
              onTap: () {
                // Navigate to the category's product list
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
