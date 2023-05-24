import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:momentry/models/movie/movie_response.dart';
import 'package:momentry/providers/movie_provider.dart';
import 'package:momentry/screens/movie/search/components/movie_search_item.dart';

class MovieSearchBody extends ConsumerWidget {
  const MovieSearchBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(movieProvider);
    final isData = state is AsyncData<MovieResponse>;
    final isLoading = state is AsyncLoading;
    final isError = state is AsyncError;

    if (isLoading || !isData) {
      return Container();
    }

    if (isError) {
      return const Center(
        child: Text('오류!'),
      );
    }

    final data = state.value;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SafeArea(
        child: MasonryGridView.count(
          padding: const EdgeInsets.all(16),
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 8,
          itemCount: data.items.length,
          itemBuilder: (context, index) {
            final item = data.items[index];
            return MovieSearchItem(
              item: item,
            );
          },
        ),
      ),
    );
  }
}
