import 'package:flutter/material.dart';
import 'package:trendflix/colors/myColors.dart';
import 'package:trendflix/ui/home/controllers/home_controller.dart';
import 'package:trendflix/ui/home/widget/home_widget.dart';
import 'package:trendflix/ui/widget_global/typesMovieWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeController _controller;
  @override
  void initState() {
    _controller = HomeController();
    _controller.tvSeriesFunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: MyColor.cBlack,
        appBar: AppBar(
          backgroundColor: MyColor.cBlack,
          bottom: TabBar(
            labelColor: MyColor.cGrey2,
            unselectedLabelColor: MyColor.cGrey1,
            indicatorPadding: const EdgeInsets.all(0.0),
            indicatorWeight: 4.0,
            labelPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
            indicator: const ShapeDecoration(
                shape: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 0,
                        style: BorderStyle.solid)),
                gradient: LinearGradient(
                    colors: [Color(0xff0081ff), Color(0xff01ff80)])),
            tabs: <Widget>[
              Container(
                height: 50,
                alignment: Alignment.center,
                color: MyColor.cBlack,
                child: const Text("Tv Series"),
              ),
              Container(
                height: 50,
                alignment: Alignment.center,
                color: MyColor.cBlack,
                child: const Text("Movies"),
              ),
              Container(
                height: 50,
                alignment: Alignment.center,
                color: MyColor.cBlack,
                child: const Text("Upcomming"),
              ),
            ],
          ),
          title: tittletext("TREND FLIX"),
        ),
        body: TabBarView(
          children: [
            Container(
              color: MyColor.cBlack,
              child: FutureBuilder(
                future: _controller.tvSeriesFunction(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    // ignore: curly_braces_in_flow_control_structures
                    return Center(
                        child:
                            CircularProgressIndicator(color: MyColor.cGrey1));
                  else {
                    return SingleChildScrollView(
                      controller: ScrollController(),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HomeWidget().carouselList(
                              _controller.populartSeries,
                              "Popular Now",
                              "tv",
                              _controller.populartSeries.length,
                            ),
                            HomeWidget().sliderlist(
                              _controller.onairtSeries,
                              "On Air Now",
                              "tv",
                              _controller.onairtSeries.length,
                            ),
                            HomeWidget().sliderlist(
                              _controller.topratedSeries,
                              "Top Rated",
                              "tv",
                              _controller.topratedSeries.length,
                            ),
                            const SizedBox(
                              height: 50.0,
                            ),
                          ]),
                    );
                  }
                },
              ),
            ),
            Container(
              color: MyColor.cBlack,
              child: FutureBuilder(
                future: _controller.moviesFunction(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    // ignore: curly_braces_in_flow_control_structures
                    return Center(
                        child:
                            CircularProgressIndicator(color: MyColor.cGrey1));
                  else {
                    return SingleChildScrollView(
                      controller: ScrollController(),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HomeWidget().carouselList(
                              _controller.populartSeries,
                              "Popular Now",
                              "movie",
                              _controller.populartSeries.length,
                            ),
                            HomeWidget().sliderlist(
                              _controller.nowPlayingMovies,
                              "On Air Now",
                              "movie",
                              _controller.nowPlayingMovies.length,
                            ),
                            HomeWidget().sliderlist(
                              _controller.topPratedMovies,
                              "Top Rated",
                              "movie",
                              _controller.topPratedMovies.length,
                            ),
                            HomeWidget().sliderlist(
                              _controller.latesMovies,
                              "Lates Movies",
                              "movie",
                              _controller.latesMovies.length,
                            ),
                            const SizedBox(
                              height: 50.0,
                            ),
                          ]),
                    );
                  }
                },
              ),
            ),
            Container(
              color: MyColor.cBlack,
              child: FutureBuilder(
                  future: _controller.getUpcomming(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HomeWidget().sliderlist(
                                _controller.upComming,
                                "Upcomming",
                                "movie",
                                _controller.upComming.length),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 15, bottom: 40),
                                child: tittletext("Many More Coming Soon... "))
                          ]);
                    } else {
                      return const Center(
                          child:
                              CircularProgressIndicator(color: Colors.amber));
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
