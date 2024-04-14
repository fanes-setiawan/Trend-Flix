import 'package:flutter/material.dart';
import 'package:trendflix/colors/myColors.dart';

class SearchWidget {
  Widget searchWidget({
    TextEditingController? controller,
    void Function(String)? onSubmitted,
    void Function(String)? onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: MyColor.cGrey1,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: MyColor.cGrey2,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(color: MyColor.cGrey2),
              onSubmitted: onSubmitted,
              onChanged: onChanged,
              cursorColor: MyColor.cGrey2,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: MyColor.cGrey2,
                ),
                helperStyle: TextStyle(
                  color: MyColor.cGrey2,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
        ],
      ),
    );
  }
}
