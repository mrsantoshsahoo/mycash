import 'package:flutter/material.dart';

class TheSearch extends SearchDelegate<String> {
  TheSearch({
    this.contextPage,
  });

  BuildContext? contextPage;
  final suggestions1 = ["https://www.google.com"];

  @override
  String get searchFieldLabel => "Enter a web address";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          Navigator.pop(context);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text("king");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty ? suggestions1 : [];
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (content, index) => ListTile(
          leading: const Icon(Icons.arrow_left), title: Text(suggestions[index])),
    );
  }
}
