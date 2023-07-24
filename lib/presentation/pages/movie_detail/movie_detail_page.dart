import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_starter/application/movie_detail/movie_detail_bloc.dart';
import 'package:next_starter/common/utils/title_utils.dart';
import 'package:next_starter/injection.dart';
import 'package:next_starter/presentation/components/base/base_scaffold.dart';
import 'package:next_starter/presentation/components/video/web_view.dart';

import '../../../common/widgets/app_error_widget.dart';
import '../../../common/widgets/loading_indicator_widget.dart';

@RoutePage()
class MovieDetailPage extends StatelessWidget {
  final String movieId;
  const MovieDetailPage({
    super.key,
    @PathParam('movieId') required this.movieId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          locator<MovieDetailBloc>()..add(FetchMoviesById(movieId)),
      child: MovieDetailView(movieId: movieId),
    );
  }
}

class MovieDetailView extends StatefulWidget {
  final String movieId;
  const MovieDetailView({
    super.key,
    required this.movieId,
  });

  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  @override
  void initState() {
    super.initState();
    context.read<MovieDetailBloc>().add(StreamMovie(widget.movieId));
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      padding: EdgeInsets.zero,
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          switch (state.status) {
            case MovieDetailStatus.initial:
              return const LoadingIndicatorWidget();
            case MovieDetailStatus.success:
              return state.movie == null
                  ? const LoadingIndicatorWidget()
                  : CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          pinned: true,
                          expandedHeight: 300,
                          flexibleSpace: FlexibleSpaceBar(
                            background: WebViewVideoPlayer(
                              streamUrl: state.streams?[0].url ?? "",
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    TitleUtils.idToTitle(state.movie?.id ?? ""),
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 32.0,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    const SizedBox(
                                      width: 4.0,
                                    ),
                                    Text(state.movie?.rating ?? "-"),
                                    const SizedBox(
                                      width: 16.0,
                                    ),
                                    const Icon(Icons.access_time),
                                    const SizedBox(
                                      width: 4.0,
                                    ),
                                    Text(state.movie?.duration ?? "-"),
                                    const SizedBox(
                                      width: 16.0,
                                    ),
                                    const Icon(Icons.calendar_month),
                                    const SizedBox(
                                      width: 4.0,
                                    ),
                                    Text(state.movie?.releaseDate ?? "-"),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                SizedBox(
                                  height: 30,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.movie?.genres?.length ?? 0,
                                    itemBuilder: (context, index) => Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.blue,
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            state.movie?.genres?[index] ?? "",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const SizedBox(
                                        width: 6.0,
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 24.0,
                                ),
                                const SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    "Deskrpsi",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    state.movie?.synopsis ?? "",
                                    style: const TextStyle(height: 1.5),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                                const SizedBox(
                                  height: 24.0,
                                ),
                                const SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    "Aktor",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                SizedBox(
                                  height: 30,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.movie?.genres?.length ?? 0,
                                    itemBuilder: (context, index) => Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.blue,
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            state.movie?.casts?[index] ?? "",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const SizedBox(
                                        width: 6.0,
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 24.0,
                                ),
                                const SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    "Direktor",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                SizedBox(
                                  height: 30,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        state.movie?.directors?.length ?? 0,
                                    itemBuilder: (context, index) => Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.blue,
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            state.movie?.directors?[index] ??
                                                "",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const SizedBox(
                                        width: 6.0,
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 24.0,
                                ),
                                const SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    "Negara",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                SizedBox(
                                  height: 30,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        state.movie?.countries?.length ?? 0,
                                    itemBuilder: (context, index) => Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.blue,
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            state.movie?.countries?[index] ??
                                                "",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const SizedBox(
                                        width: 6.0,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
            case MovieDetailStatus.failure:
              return AppErrorWidget(
                message: state.errorMessage,
                onTap: () => context.read<MovieDetailBloc>().add(
                      FetchMoviesById(widget.movieId),
                    ),
              );
          }
        },
      ),
    );
  }
}
