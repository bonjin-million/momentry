import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:momentry/models/movie/movie_detail.dart';
import 'package:momentry/providers/movie/movie_list_provider.dart';
import 'package:momentry/screens/movie/detail/movie_detail_screen.dart';
import 'package:momentry/screens/movie/list/components/movie_list_item.dart';

class MovieListBody extends ConsumerStatefulWidget {
  const MovieListBody({Key? key}) : super(key: key);

  @override
  ConsumerState<MovieListBody> createState() => _MovieListBodyState();
}

class _MovieListBodyState extends ConsumerState<MovieListBody> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(movieListProvider.notifier).findAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(movieListProvider);
    final isData = state is AsyncData<List<MovieDetail>>;
    final isLoading = state is AsyncLoading;
    final isError = state is AsyncError;

    if (isLoading || !isData) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (isError) {
      return const Center(
        child: Text('오류!'),
      );
    }

    final items = state.value;

    if (items.isEmpty) {
      return Center(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/panic.png',
                width: MediaQuery.of(context).size.width * 0.2,
              ),
              const SizedBox(
                height: 24,
              ),
              const Text('등록된 영화가 없어요'),
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
            crossAxisCount: 3,
            padding: const EdgeInsets.all(16),
            mainAxisSpacing: 16,
            crossAxisSpacing: 8,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];

              return MovieListItem(
                item: item,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MovieDetailScreen(
                        id: item.id,
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
