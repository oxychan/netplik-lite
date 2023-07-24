import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:next_starter/common/utils/title_utils.dart';

class MovieCard extends StatefulWidget {
  const MovieCard({
    super.key,
    required this.title,
    required this.rating,
    required this.genres,
    required this.onTap,
  });

  final String title;
  final String rating;
  final List<String> genres;
  final VoidCallback onTap;

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            child: Image(
              image: AssetImage('assets/images/thumbnail.jpg'),
              width: 84.0,
              height: 128.0,
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: SizedBox(
              height: 128.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        TitleUtils.idToTitle(widget.title),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            const SizedBox(
                              width: 4.0,
                            ),
                            Text(widget.rating == "" ? "-" : widget.rating),
                          ],
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 30,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.genres.length,
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
                                    widget.genres[index],
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
                                width: 4.0,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
