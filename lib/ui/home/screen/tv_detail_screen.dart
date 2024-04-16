// ignore_for_file: public_member_api_docs, sort_constructors_first, use_super_parameters, prefer_typing_uninitialized_variables, must_be_immutable, prefer_interpolation_to_compose_strings, prefer_const_constructors, avoid_unnecessary_containers, use_build_context_synchronously, avoid_print
// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trendflix/colors/myColors.dart';
import 'package:trendflix/service/model/sqflite_model.dart';

import 'package:trendflix/ui/home/controllers/tv_detail_controller.dart';

import 'package:trendflix/widget_global/typesMovieWidget.dart';

import '../../../service/db_sqflite/database_helper.dart';
import '../../../widget_global/TrailerUI.dart';
import '../../../widget_global/detailSliderList.dart';

class TvDetailScreen extends StatefulWidget {
  var id;
  TvDetailScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<TvDetailScreen> createState() => _TvDetailScreenState();
}

class _TvDetailScreenState extends State<TvDetailScreen> {
  late final TvDetailController _controller;

  @override
  void initState() {
    _controller = TvDetailController();
    _controller.id = widget.id.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(14, 14, 14, 1),
      body: FutureBuilder(
          future: _controller.getTvDetail(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                      automaticallyImplyLeading: false,
                      leading:
                          //circular icon button
                          IconButton(
                              onPressed: () {
                                SystemChrome.setEnabledSystemUIMode(
                                    SystemUiMode.manual,
                                    overlays: [SystemUiOverlay.bottom]);
                                SystemChrome.setPreferredOrientations([
                                  DeviceOrientation.portraitUp,
                                  DeviceOrientation.portraitDown,
                                ]);
                                Navigator.pop(context);
                              },
                              icon: Icon(FontAwesomeIcons.circleArrowLeft),
                              iconSize: 28,
                              color: MyColor.cWhite),
                      backgroundColor: Color.fromRGBO(18, 18, 18, 0.5),
                      expandedHeight: MediaQuery.of(context).size.height * 0.35,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        background: FittedBox(
                          child: trailerwatch(
                            trailerytid: _controller.seriestrailerslist[0].key,
                          ),
                        ),
                      )),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 10, top: 10),
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: _controller.data['genres'].length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(right: 10),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: genrestext(
                                        "#${_controller.TvSeriesDetails[index + 1].genre}"),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              tittletext("Series Overview : "),
                              Container(
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        SqfliteModel addFavorite = SqfliteModel(
                                          id: _controller.TvSeriesDetails[0].id,
                                          name: _controller
                                              .TvSeriesDetails[0].name,
                                          posterPath: _controller
                                              .TvSeriesDetails[0].posterPath,
                                          voteAverage: _controller
                                              .TvSeriesDetails[0].voteAverage,
                                          date: _controller
                                              .TvSeriesDetails[0].date,
                                          type: "tv",
                                        );
                                        DatabaseHelper dbHelper =
                                            DatabaseHelper();
                                        int result = await dbHelper
                                            .insertMovie(addFavorite);
                                        if (result != 0) {
                                          _controller.isFavorite = true;
                                          var snackBar = SnackBar(
                                            backgroundColor: MyColor.cGrey2,
                                            content: showSnackBarText(
                                                'Successfully added to favorites.'),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                          print('Movie inserted successfully!');
                                        } else {
                                          print('Failed to insert movie.');
                                          var snackBar = SnackBar(
                                            backgroundColor: MyColor.cGrey2,
                                            content: showSnackBarText(
                                                'Failed to insert movie.'),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                      },
                                      icon: Icon(
                                        color: _controller.isFavorite == false
                                            ? MyColor.cWhite
                                            : MyColor.cGrey2,
                                        Icons.bookmark,
                                        size: 24.0,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        color: MyColor.cWhite,
                                        Icons.share,
                                        size: 24.0,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),

                        Container(
                            padding: EdgeInsets.only(left: 10, top: 20),
                            child: readMore(_controller
                                .TvSeriesDetails[0].overview
                                .toString())),

                        Container(
                            padding: EdgeInsets.only(left: 10, top: 20),
                            child: boldtext("Status : " +
                                _controller.TvSeriesDetails[0].status
                                    .toString())),
                        // created by
                        if (_controller.data['created_by'].length != 0)
                          Container(
                              padding: EdgeInsets.only(left: 10, top: 20),
                              child: tittletext("Created By : ")),

                        if (_controller.data['created_by'].length != 0)
                          Container(
                              padding: EdgeInsets.only(left: 10, top: 10),
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      _controller.data['created_by'].length,
                                  itemBuilder: (context, index) {
                                    //generes box
                                    return Container(
                                        margin: EdgeInsets.only(right: 10),
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color:
                                                Color.fromRGBO(25, 25, 25, 1),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(children: [
                                          Column(children: [
                                            _controller.data['created_by']
                                                            [index]
                                                        ['profile_path'] ==
                                                    ''
                                                ? CircleAvatar(
                                                    radius: 45,
                                                    backgroundImage:
                                                        NetworkImage(
                                                      'https://image.tmdb.org/t/p/w500' +
                                                          _controller.data[
                                                                  'created_by']
                                                                  [index][
                                                                  'profile_path']
                                                              .toString(),
                                                    ),
                                                  )
                                                : CircleAvatar(
                                                    radius: 45,
                                                    backgroundImage:
                                                        NetworkImage(
                                                      'https://www.nicepng.com/png/detail/52-521023_download-free-icon-female-vectors-blank-facebook-profile.png',
                                                    ),
                                                  ),
                                            SizedBox(height: 10),
                                            genrestext(_controller
                                                .data['created_by'][index]
                                                    ['name']
                                                .toString())
                                          ])
                                        ]));
                                  })),
                        Container(
                            padding: EdgeInsets.only(left: 10, top: 20),
                            child: normaltext("Total Seasons : " +
                                _controller.TvSeriesDetails.length.toString())),
                        //airdate
                        Container(
                            padding: EdgeInsets.only(left: 10, top: 20),
                            child: normaltext("Release date : " +
                                _controller.TvSeriesDetails[0].date
                                    .toString())),
                        detailSliderList(
                          _controller.similarserieslist,
                          'Similar Series',
                          'tv',
                          _controller.similarserieslist.length,
                        ),
                        detailSliderList(
                          _controller.recommendserieslist,
                          'Recommended Series',
                          'tv',
                          _controller.recommendserieslist.length,
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(color: MyColor.cGrey1),
              );
            }
          }),
    );
  }
}
