import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:momentry/models/movie/movie_response.dart';
import 'package:momentry/providers/movie_provider.dart';
import 'package:momentry/screens/movie/add/movie_add_screen.dart';
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

    if (data.items.isEmpty) {
      return Center(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/oops.png',
                width: MediaQuery.of(context).size.width * 0.2,
              ),
              const SizedBox(
                height: 24,
              ),
              const Text('검색된 영화가 없어요'),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MovieAddScreen(
                          type: 'FILE',
                        ),
                      ),
                    );
                  },
                  child: const Text('직접 입력')),
            ],
          ),
        ),
      );
    }

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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MovieAddScreen(item: item, type: "PATH"),
                    fullscreenDialog: true,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
