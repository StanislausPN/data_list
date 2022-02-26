import 'package:flutter/material.dart';
import 'package:flutter_test_app/data/models/post_models.dart';
import 'package:flutter_test_app/data/repositories/post_repositories.dart';

class SearchBox extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<PostModels?>(
      future: PostRepository.getPostWithId(query),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Failed to load data');
        }
        if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  snapshot.data!.id.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  snapshot.data!.title.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                snapshot.data!.body.toString(),
                textAlign: TextAlign.center,
              ),
            ],
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<PostModels>?>(
      future: PostRepository.getPost(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Failed to load data');
        }
        if (snapshot.hasData) {
          List<PostModels> datas = snapshot.data!.where((element) {
            final result = element.id!.toString();
            final input = query.toLowerCase();

            return result.contains(input);
          }).toList();
          return ListView.builder(
            itemCount: datas.length,
            itemBuilder: (BuildContext context, int index) {
              final data = datas[index];
              return ListTile(
                title: Text(data.id.toString()),
                onTap: () {
                  query = data.id.toString();
                  showResults(context);
                },
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
