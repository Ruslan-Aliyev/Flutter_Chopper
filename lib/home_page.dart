import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:chopper/chopper.dart';
import 'package:provider/provider.dart';
import 'data/post_api_service.dart';
import 'post.dart' as model;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<model.Post>> futureAlbums;

  @override
  void initState() {
    super.initState();
    futureAlbums = fetchAlbums();
  }

  Future<List<model.Post>> fetchAlbums() async {
    final response = await Provider.of<PostApiService>(context, listen: false).getPosts();
    //print(response.body);

    if (response.statusCode == 200) {
      List rawList = json.decode(response.bodyString).toList();
      List<model.Post> list = [];

      for (int i = 0; i < rawList.length; i++) {
        model.Post post = model.Post.fromJson(rawList[i]);
        print(post.title);
        print(post.body);
        list.add(post);
      }

      return list;
    } else {
      print('Failed to load albums');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<model.Post>>(
          future: futureAlbums,
          builder: (context, snapshot) {

            if (snapshot.connectionState == ConnectionState.done) {
              List<model.Post> posts = snapshot.data ?? [];

              return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    model.Post post = posts[index];
                    return new ListTile(
                      title: new Text(
                        post.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(post.body),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

          }
      ),
    );
  }
}
