import 'package:flutter/material.dart';
import 'package:flutter_test_app/data/models/post_models.dart';
import 'package:flutter_test_app/data/repositories/post_repositories.dart';
import 'package:flutter_test_app/view/components/searchbox.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Post Data'),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchBox());
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: FutureBuilder<List<PostModels>?>(
                future: PostRepository.getPost(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Failed to load data');
                  }
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: snapshot.data!.map((dataPost) {
                            return Text('- ${dataPost.title!}\n');
                          }).toList()),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
