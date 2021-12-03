import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final bool isSearching;
  final Function(bool val) callback;
  final TextEditingController searchTerm;

  const SearchBar(this.isSearching, this.callback, this.searchTerm, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _searchBoxOutterWidth = isSearching ? 280 : 300;
    double _searchBoxInnerWidth = isSearching ? 260 : 270;
    return Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
      isSearching
          ? SizedBox(
              width: 50,
              child: IconButton(
                onPressed: () {
                  callback(false);
                  FocusScope.of(context).unfocus();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 35,
                ),
              ),
            )
          : const SizedBox(
              width: 30,
            ),
      Container(
        height: 50,
        width: _searchBoxOutterWidth,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(45))),
        child: Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: _searchBoxInnerWidth,
            child: SizedBox(
              child: TextField(
                controller: searchTerm,
                onTap: () => callback(true),
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  isCollapsed: false,
                  icon: isSearching ? null : const Icon(Icons.search),
                  border: InputBorder.none,
                  hintText: 'Search...',
                ),
              ),
              width: 235,
            ),
          ),
        ),
      ),
    ]);
  }
}
