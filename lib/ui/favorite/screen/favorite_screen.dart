// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:trendflix/colors/myColors.dart';
import 'package:trendflix/service/db_sqflite/database_helper.dart';
import 'package:trendflix/ui/favorite/controller/favorite_controller.dart';

import '../../../widget_global/typesMovieWidget.dart';
import '../../home/screen/movie_detail_screen.dart';
import '../../home/screen/tv_detail_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late FavoriteController _controller;

  @override
  void initState() {
    _controller = FavoriteController(context: context);
    _loadFavoriteData();
    super.initState();
  }

  Future<void> _loadFavoriteData() async {
    await _controller.getDataFavorite();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.cBlack,
      appBar: AppBar(
        backgroundColor: MyColor.cBlack,
        title: tittletext("MY FAVORITE"),
      ),
      body: _controller.isLoading == false
          ? _controller.movies.isNotEmpty
              ? Container(
                  padding: EdgeInsets.all(5),
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.8,
                      crossAxisCount: 3,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                    ),
                    itemCount: _controller.movies.length,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      var data = _controller.movies[index];
                      return GestureDetector(
                        onLongPress: () async {
                          await showDialog<void>(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Container(
                                        height: 150,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                'https://image.tmdb.org/t/p/w500${data.posterPath}'),
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(
                                              8.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: ElevatedButton.icon(
                                              icon: Icon(
                                                Icons.play_arrow,
                                                color: MyColor.cWhite,
                                              ),
                                              label: Text(
                                                "Play",
                                                style: TextStyle(
                                                    color: MyColor.cWhite),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: MyColor.cGrey2,
                                              ),
                                              onPressed: () {
                                                if (data.type == 'movie') {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MovieDetailScreen(
                                                                id: data.id,
                                                              )));
                                                } else if (data.type == 'tv') {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          TvDetailScreen(
                                                              id: data.id),
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10.0,
                                          ),
                                          Expanded(
                                            child: ElevatedButton.icon(
                                              icon: Icon(
                                                Icons.delete_forever,
                                                color: MyColor.cWhite,
                                              ),
                                              label: Text(
                                                "Hapus",
                                                style: TextStyle(
                                                    color: MyColor.cWhite),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: MyColor.cGrey1,
                                              ),
                                              onPressed: () {
                                                DatabaseHelper().deleteMovie(
                                                  data.id!.toInt(),
                                                );

                                                _loadFavoriteData();
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        onTap: () {
                          if (data.type == 'movie') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MovieDetailScreen(
                                          id: data.id,
                                        )));
                          } else if (data.type == 'tv') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TvDetailScreen(id: data.id),
                              ),
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.3),
                                    BlendMode.darken),
                                image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500${data.posterPath}'),
                                fit: BoxFit.cover),
                          ),
                          margin: const EdgeInsets.only(left: 13),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 0,
                                right: 0,
                                left: 0,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                  child: BackdropFilter(
                                    filter:
                                        ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      height: 50,
                                      color: Colors.white
                                          .withOpacity(0.1), // Warna filter
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          normaltext(data.name.toString()),
                                          Row(
                                            children: [
                                              Icon(Icons.date_range_sharp,
                                                  color: MyColor.cGrey,
                                                  size: 14),
                                              datetext(data.date.toString()),
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
                )
              : Center(
                  child: normaltext("0 favorite"),
                )
          : Center(
              child: CircularProgressIndicator(
                color: MyColor.cGrey1,
              ),
            ),
    );
  }
}
