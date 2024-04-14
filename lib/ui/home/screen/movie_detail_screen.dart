// ignore_for_file: public_member_api_docs, sort_constructors_first, use_super_parameters, prefer_typing_uninitialized_variables, must_be_immutable, avoid_unnecessary_containers, prefer_const_constructors, prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trendflix/colors/myColors.dart';

import 'package:trendflix/ui/home/controllers/movie_detail_controller.dart';

import '../../widget_global/TrailerUI.dart';
import '../../widget_global/detailSliderList.dart';
import '../../widget_global/reviewui.dart';
import '../../widget_global/typesMovieWidget.dart';

class MovieDetailScreen extends StatefulWidget {
  var id;
  MovieDetailScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late final MovieDetailController _controller;

  @override
  void initState() {
    _controller = MovieDetailController();
    _controller.id = widget.id.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(14, 14, 14, 1),
      body: FutureBuilder(
          future: _controller.getDetailMovie(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                        automaticallyImplyLeading: false,
                        leading: IconButton(
                            onPressed: () {
                              SystemChrome.setEnabledSystemUIMode(
                                  SystemUiMode.manual,
                                  overlays: [SystemUiOverlay.bottom]);
                              // SystemChrome.setEnabledSystemUIMode(
                              //     SystemUiMode.manual,
                              //     overlays: []);
                              SystemChrome.setPreferredOrientations([
                                DeviceOrientation.portraitUp,
                                DeviceOrientation.portraitDown,
                              ]);
                              Navigator.pop(context);
                            },
                            icon: Icon(FontAwesomeIcons.circleArrowLeft),
                            iconSize: 28,
                            color: Colors.white),
                        backgroundColor: Color.fromRGBO(18, 18, 18, 0.5),
                        centerTitle: false,
                        pinned: true,
                        expandedHeight:
                            MediaQuery.of(context).size.height * 0.4,
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.parallax,
                          background: FittedBox(
                            fit: BoxFit.fill,
                            child: Container(
                              child: trailerwatch(
                                trailerytid: _controller.MovieTrailers[0].key,
                              ),
                            ),
                          ),
                        )),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      //add to favoriate button

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: 10, top: 10),
                              child: tittletext(_controller
                                  .MovieDetails[0].title
                                  .toString())),
                          Row(children: [
                            Container(
                              padding: EdgeInsets.only(left: 10, top: 10),
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    _controller.MoviesGeneres['genres'].length,
                                itemBuilder: (context, index) {
                                  //generes box
                                  return Container(
                                    margin: EdgeInsets.only(right: 10),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: genrestext(
                                        "#${_controller.MovieDetails[index].genre}"),
                                  );
                                },
                              ),
                            ),
                          ]),
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
                                    onPressed: () {
                                      _controller.isFavorite = true;
                                      var snackBar = SnackBar(
                                        backgroundColor: MyColor.cGrey2,
                                        content: showSnackBarText(
                                            'Successfully added to favorites.'),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
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

                      Padding(
                          padding: EdgeInsets.only(left: 10, top: 10),
                          child: tittletext('Movie Story :')),
                      Padding(
                          padding: EdgeInsets.only(left: 10, top: 10),
                          child: readMore(
                              _controller.MovieDetails[0].overview.toString())),

                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 10),
                        child: ReviewUI(revdeatils: _controller.UserReviews),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 10, top: 20),
                          child: normaltext('Release Date : ' +
                              _controller.MovieDetails[0].date.toString())),

                      detailSliderList(
                        _controller.SimilarMovie,
                        "Similar Movies",
                        "movie",
                        _controller.SimilarMovie.length,
                      ),
                      detailSliderList(
                        _controller.RecommendedMovie,
                        "Recommended Movies",
                        "movie",
                        _controller.RecommendedMovie.length,
                      ),
                    ]))
                  ]);
            } else {
              return Center(
                  child: CircularProgressIndicator(
                color: MyColor.cGrey1,
              ));
            }
          }),
    );
  }
}
