// ignore_for_file: public_member_api_docs, sort_constructors_first, use_super_parameters, prefer_typing_uninitialized_variables, must_be_immutable, prefer_interpolation_to_compose_strings, prefer_const_constructors
// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:trendflix/ui/home/controllers/tv_detail_controller.dart';

import 'package:trendflix/ui/widget_global/typesMovieWidget.dart';

import '../widget/home_widget.dart';

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
                            color: Colors.white),
                    backgroundColor: Color.fromRGBO(18, 18, 18, 0.5),
                    expandedHeight: MediaQuery.of(context).size.height * 0.35,
                    pinned: true,
                    // flexibleSpace: FlexibleSpaceBar(
                    //   collapseMode: CollapseMode.parallax,
                    //   background: FittedBox(
                    //     fit: BoxFit.fill,
                    //     child: trailerwatch(
                    //       trailerytid: _controller.seriestrailerslist[0].key,
                    //     ),
                    //   ),
                    // )
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        // addtofavoriate(
                        //   id: widget.id,
                        //   type: 'tv',
                        //   Details: TvSeriesDetails,
                        // ),
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
                                        // color: Color.fromRGBO(25, 25, 25, 1),
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
                            padding: EdgeInsets.only(left: 10, top: 12),
                            child: tittletext("Series Overview : ")),

                        Container(
                            padding: EdgeInsets.only(left: 10, top: 20),
                            child: overviewtext(_controller
                                .TvSeriesDetails[0].overview
                                .toString())),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 20.0, top: 10),
                        //   child: ReviewUI(revdeatils: TvSeriesREview),
                        // ),
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
                                            CircleAvatar(
                                              radius: 45,
                                              backgroundImage: NetworkImage(
                                                'https://image.tmdb.org/t/p/w500' +
                                                    _controller
                                                        .data['created_by']
                                                            [index]
                                                            ['profile_path']
                                                        .toString(),
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
                        HomeWidget().sliderlist(
                          _controller.similarserieslist,
                          'Similar Series',
                          'tv',
                          _controller.similarserieslist.length,
                        ),
                        HomeWidget().sliderlist(
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
                  child:
                      CircularProgressIndicator(color: Colors.amber.shade400));
            }
          }),
    );
  }
}
