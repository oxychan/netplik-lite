import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_starter/application/bloc/movie_bloc.dart';
import 'package:next_starter/common/widgets/app_error_widget.dart';
import 'package:next_starter/common/widgets/loading_indicator_widget.dart';
import 'package:next_starter/common/widgets/row_loading_widget.dart';
import 'package:next_starter/injection.dart';
import 'package:next_starter/presentation/components/base/base_scaffold.dart';
import 'package:next_starter/presentation/components/card/movie_card.dart';
import 'package:next_starter/presentation/routes/app_router.dart';

@RoutePage()
class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<MovieBloc>()..add(FetchMovies()),
      child: const MovieView(),
    );
  }
}

class MovieView extends StatefulWidget {
  const MovieView({super.key});
  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<MovieBloc>().add(FetchMovies());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      padding: const EdgeInsets.all(8.0),
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Center(
          child: Text(
            'Moview :3',
            style: TextStyle(color: Colors.black),
          ),
        ),
        elevation: 0.5,
        backgroundColor: Colors.white,
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          switch (state.status) {
            case MovieStatus.failure:
              return AppErrorWidget(
                message: state.errorMessage,
                onTap: () => context.read<MovieBloc>().add(FetchMovies()),
              );
            case MovieStatus.success:
              return state.movies.isEmpty
                  ? const Center(
                      child: Text('Movie is empty'),
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextField(
                            onChanged: (value) {
                              if (value == "") {
                                state.movies.clear();
                                context.read<MovieBloc>().add(FetchMovies());
                              } else {
                                state.movies.clear();
                                context
                                    .read<MovieBloc>()
                                    .add(SearchMovies(value));
                              }
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(179, 218, 218, 218),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Input the title...",
                              suffix: const Icon(Icons.search),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              return index >= state.movies.length
                                  ? const RowLoadingWidget()
                                  : MovieCard(
                                      title: state.movies[index].id ?? "",
                                      rating: state.movies[index].rating ?? "",
                                      genres: state.movies[index].genres ?? [],
                                      onTap: () {
                                        context.pushRoute(
                                          MovieDetailRoute(
                                              movieId:
                                                  state.movies[index].id ?? ""),
                                        );
                                      },
                                    );
                            },
                            itemCount: state.hasReachedMax
                                ? state.movies.length
                                : state.movies.length + 1,
                            controller: _scrollController,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(height: 16.0);
                            },
                          ),
                        ),
                      ],
                    );
            case MovieStatus.initial:
              return const LoadingIndicatorWidget();
          }
        },
      ),
    );
  }
}
