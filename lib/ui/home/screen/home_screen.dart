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
  late final HomeController controller;
  @override
  void initState() {
    controller = HomeController();
    controller.tvSeriesFunction();
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
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Tv Series",
              ),
              Tab(
                text: "Movies",
              ),
              Tab(
                text: "Upcomming",
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
                future: controller.tvSeriesFunction(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    // ignore: curly_braces_in_flow_control_structures
                    return Center(
                        child: CircularProgressIndicator(
                            color: Colors.amber.shade400));
                  else {
                    return SingleChildScrollView(
                      controller: ScrollController(),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HomeWidget().sliderlist(
                              controller.populartSeries,
                              "Popular Now",
                              "tv",
                              controller.populartSeries.length,
                            ),
                            HomeWidget().sliderlist(
                              controller.onairtSeries,
                              "On Air Now",
                              "tv",
                              controller.onairtSeries.length,
                            ),
                            HomeWidget().sliderlist(
                              controller.topratedSeries,
                              "Top Rated",
                              "tv",
                              controller.topratedSeries.length,
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
                future: controller.moviesFunction(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    // ignore: curly_braces_in_flow_control_structures
                    return Center(
                        child: CircularProgressIndicator(
                            color: Colors.amber.shade400));
                  else {
                    return SingleChildScrollView(
                      controller: ScrollController(),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HomeWidget().sliderlist(
                              controller.popularMovies,
                              "Popular Now",
                              "movie",
                              controller.popularMovies.length,
                            ),
                            HomeWidget().sliderlist(
                              controller.nowPlayingMovies,
                              "On Air Now",
                              "movie",
                              controller.nowPlayingMovies.length,
                            ),
                            HomeWidget().sliderlist(
                              controller.topPratedMovies,
                              "Top Rated",
                              "movie",
                              controller.topPratedMovies.length,
                            ),
                            HomeWidget().sliderlist(
                              controller.latesMovies,
                              "Lates Movies",
                              "movie",
                              controller.latesMovies.length,
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
              color: Colors.blue[100],
            ),
          ],
        ),
      ),
    );
  }
}
