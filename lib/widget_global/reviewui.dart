// ignore_for_file: prefer_const_constructors, prefer_is_empty, non_constant_identifier_names, prefer_adjacent_string_concatenation, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:trendflix/colors/myColors.dart';
import 'package:trendflix/service/model/movieModel.dart';

import 'typesMovieWidget.dart';
// import 'package:url_launcher/url_launcher.dart';

class ReviewUI extends StatefulWidget {
  List<MovieModel> revdeatils = [];
  ReviewUI({required this.revdeatils});

  @override
  State<ReviewUI> createState() => _ReviewUIState();
}

class _ReviewUIState extends State<ReviewUI> {
  bool showall = false;

  @override
  Widget build(BuildContext context) {
    List<MovieModel> RiewDetails = widget.revdeatils;
    if (RiewDetails.length == 0) {
      return Center();
    } else {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20, bottom: 10, top: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Reviews',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showall = !showall;
                    });
                  },
                  child: Row(
                    children: [
                      showall == false
                          ? Text(
                              'All Reviews ' + '${RiewDetails.length} ',
                              style: TextStyle(
                                fontFamily: 'open sans',
                                decoration: TextDecoration.none,
                                color: MyColor.cGrey1,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          : Text(
                              'Show Less',
                              style: TextStyle(
                                color: MyColor.cGrey1,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: MyColor.cGrey1,
                        size: 16,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          //
          //show only one review
          showall == true
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: RiewDetails.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            right: 20,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              RiewDetails[index]
                                                  .avatarPhoto
                                                  .toString(),
                                            ),
                                            fit: BoxFit.cover)),
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  ChatBubble(
                                    elevation: 0,
                                    clipper: ChatBubbleClipper5(
                                        type: BubbleType.receiverBubble),
                                    alignment: Alignment.topRight,
                                    margin: EdgeInsets.only(top: 20),
                                    backGroundColor: MyColor.cGrey1,
                                    child: Container(
                                      constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              genrestext(
                                                RiewDetails[index]
                                                    .name
                                                    .toString(),
                                              ),
                                              datetext(
                                                RiewDetails[index]
                                                    .creationDate
                                                    .toString(),
                                              ),
                                            ],
                                          ),
                                          readMoreChat(
                                            RiewDetails[index]
                                                .review
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }))
              : Container()
        ],
      );
    }
  }
}

// Widget ReviewUII(context, List RiewDetails) {}
