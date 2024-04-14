// ignore_for_file: unused_field, prefer_is_empty, avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:trendflix/colors/myColors.dart';
import 'package:trendflix/ui/search/widget/search_widget.dart';

import '../../../service/data/checker.dart';
import '../../widget_global/typesMovieWidget.dart';
import '../controller/search_controller.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late SearchControllers _controller;
  @override
  void initState() {
    _controller = SearchControllers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.cBlack,
      appBar: AppBar(
        backgroundColor: MyColor.cBlack,
        title: tittletext("SEARCH"),
        actions: const [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SearchWidget().searchWidget(
              controller: _controller.searchtext,
              onChanged: (value) {
                _controller.SearchResults.clear();
                setState(() {
                  _controller.val1 = value;
                });
              },
              onSubmitted: (value) {
                _controller.SearchResults.clear();
                setState(() {
                  _controller.val1 = value;
                  FocusManager.instance.primaryFocus?.unfocus();
                });
              },
            ),
            const SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: _controller.searchtext.text.length > 0
                  ? FutureBuilder(
                      future: _controller.getSearchData(_controller.val1),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Container(
                            child: ListView.builder(
                              itemCount: _controller.SearchResults.length,
                              scrollDirection: Axis.vertical,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                descriptioncheckui(
                                                  _controller
                                                      .SearchResults[index].id,
                                                  _controller
                                                      .SearchResults[index]
                                                      .mediatype,
                                                )));
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: Container(
                                      height: 130,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        'https://image.tmdb.org/t/p/w500${_controller.SearchResults[index].posterPath}'),
                                                    fit: BoxFit.fill)),
                                          ),
                                          SizedBox(
                                            width: 15.0,
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  boldtext(
                                                    'Media : ${_controller.SearchResults[index].mediatype}',
                                                  ),
                                                  datetext(
                                                      '${_controller.SearchResults[index].date}'),
                                                  Text(
                                                    textAlign: TextAlign.left,
                                                    ' ${_controller.SearchResults[index].overview}',
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          height: 30,
                                                          decoration: BoxDecoration(
                                                              color: MyColor
                                                                  .cGrey
                                                                  .withOpacity(
                                                                      0.2),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          6))),
                                                          child: Center(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  Icons.star,
                                                                  color: MyColor
                                                                      .cGold,
                                                                  size: 20,
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                ratingtext(
                                                                    '${_controller.SearchResults[index].voteAverage}')
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),

                                                        //popularity
                                                        Container(
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          height: 30,
                                                          decoration: BoxDecoration(
                                                              color: MyColor
                                                                  .cGrey
                                                                  .withOpacity(
                                                                      0.2),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          8))),
                                                          child: Center(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .visibility,
                                                                  color: MyColor
                                                                      .cGold,
                                                                  size: 20,
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                ratingtext(
                                                                    '${_controller.SearchResults[index].popularity ?? 0}')
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10.0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return Center(
                              child: CircularProgressIndicator(
                            color: MyColor.cGrey1,
                          ));
                        }
                      })
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}
