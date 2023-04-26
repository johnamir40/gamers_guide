import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/user_games_model.dart';
import 'package:flutter_application_2/services/api_services.dart';
import 'package:flutter_application_2/views/game_details.dart';
import 'package:flutter_application_2/widgets/my_text.dart';
import 'package:lottie/lottie.dart';

import '../widgets/Circular_progress.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Widget customSearchBar = const Text('Type Your search Here');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: customSearchBar,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () =>
                  showSearch(context: context, delegate: MySearchDelegate()),
            )
          ]),
      body: Center(
        child: Lottie.network(
            'https://assets2.lottiefiles.com/packages/lf20_l5qvxwtf.json'),
      ),
    );
  }
}

////////////////////////////


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: (() {
          query.isEmpty ? close(context, null) : query = '';
        }),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // 8alebn htb2a list of model
    List<String> matchQuery = [];
    for (var game in searchedGames) {
      if (game.name!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(game.name!);
      }
    }
    try {
      return FutureBuilder(
        future: searchFunction(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return myListViewBuilder();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    try {
      return FutureBuilder(
        future: searchFunction(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return myListViewBuilder();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Widget myListViewBuilder() {
    return ListView.builder(
      /* searchedGames.isNotEmpty ? searchedGames.length - 1 : 0, */
      itemCount: searchedGames.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GameDetails(
                  gameId: searchedGames[index].id.toString(),
                ),
              ),
            ),
           
          ),
        );
      },
    );
  }
}
