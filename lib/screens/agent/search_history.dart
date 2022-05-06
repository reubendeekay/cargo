import 'package:cargo/constants.dart';
import 'package:cargo/helpers/database.dart';
import 'package:cargo/helpers/my_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class SearchHistory extends StatelessWidget {
  const SearchHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_ios,
            size: 18,
          ),
        ),
        title: FxText.titleMedium("Your Search History", fontWeight: 600),
      ),
      body: FutureBuilder<List<Word>>(
          future: DatabaseHelper.instance.queryWord(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: MyLoader(
                  color: kPrimaryColor,
                ),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: FxText.titleMedium(
                  'Error: ${snapshot.error}',
                  color: Colors.red,
                ),
              );
            }

            return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: snapshot.data!.length,
                itemBuilder: (ctx, index) => SearchHistoryWidget(
                      word: snapshot.data![index],
                    ));
          }),
    );
  }
}

class SearchHistoryWidget extends StatelessWidget {
  const SearchHistoryWidget({Key? key, required this.word}) : super(key: key);
  final Word word;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.search),
      title: FxText.titleMedium(word.word!),
      trailing: const Icon(Icons.north_west),
    );
  }
}
