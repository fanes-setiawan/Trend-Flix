import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:trendflix/service/model/movieModel.dart';

import '../../widget_global/typesMovieWidget.dart';

class HomeWidget {
  Widget sliderlist(
    List<MovieModel> firstlistname,
    String categorytittle,
    String type,
    itemlength,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 15, bottom: 40),
            child: tittletext(categorytittle)),
        SizedBox(
          height: 250,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: itemlength,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (type == 'movie') {
                    // print(firstlistname[index]['id']);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => MovieDetails(
                    //               id: firstlistname[index]['id'],
                    //             )));
                  } else if (type == 'tv') {
                    // print(firstlistname[index]['id']);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => TvSeriesDetails(
                    //             id: firstlistname[index]['id'])));
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.3), BlendMode.darken),
                          image: NetworkImage(
                              'https://image.tmdb.org/t/p/w500${firstlistname[index].posterPath}'),
                          fit: BoxFit.cover)),
                  margin: const EdgeInsets.only(left: 13),
                  width: 170,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              height: 50, width: 170,
                              color:
                                  Colors.white.withOpacity(0.1), // Warna filter
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  normaltext(firstlistname[index].name),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      datetext(firstlistname[index].date),
                                      Row(
                                        children: [
                                          const Icon(Icons.star,
                                              color: Colors.yellow, size: 15),
                                          const SizedBox(width: 2),
                                          ratingtext(firstlistname[index]
                                              .voteAverage
                                              .toString())
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}
