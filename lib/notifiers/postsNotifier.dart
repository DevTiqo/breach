import 'dart:convert';
import 'dart:io';

import 'package:breach/models/post_model.dart';
import 'package:breach/modules/post/post.dart';
import 'package:breach/modules/http.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostState {
  final List<Post> postsFeatured;
  final List<Post> postsPopular;
  final List<Post> postsRecent;

  final Post? currentPost;

  PostState({
    this.postsFeatured = const [],
    this.postsPopular = const [],
    this.postsRecent = const [],
    this.currentPost,
  });

  PostState copyWith({
    List<Post>? postsFeatured,
    List<Post>? postsPopular,
    List<Post>? postsRecent,
    Post? currentPost,
  }) {
    return PostState(
      postsFeatured: postsFeatured ?? this.postsFeatured,
      postsPopular: postsPopular ?? this.postsPopular,
      postsRecent: postsRecent ?? this.postsRecent,
      currentPost: currentPost ?? this.currentPost,
    );
  }
}

class PostNotifier extends StateNotifier<PostState> {
  PostApi postApi;
  PostNotifier({required this.postApi}) : super(PostState());

  void setCurrentPost(Post post) async {
    state = PostState(currentPost: post);
  }

  setPosts(List<Post> posts) {
    state = state.copyWith(
      postsFeatured: posts,
      postsPopular: posts,
      postsRecent: posts,
    );
  }

  // void removePost(int postid) async {
  //   List<Post> remPost = List.from(state.userPost ?? []);

  //   remPost.removeWhere((element) => element.id == Postid);

  //   state = state.copyWith(userPost: remPost);
  // }

  Future<RequestResult> getPosts({int? categoryId}) async {
    RequestResult req = RequestResult(false, 400, "yet to call");

    req = await postApi.getPosts(categoryId ?? 0);
    debugPrint(req.ok.toString());
    if (req.ok) {
      // reqq = req;
      debugPrint("okayy");
      List<Post> posts = req.data as List<Post>;

      setPosts(posts);

      return req;
      // await UserPreferences().saveUser(thisuser);

      // await UserPreferences().saveAUser(thisuser);

      // return PostClass(user: state.value?.user, users: state.value?.users);
    } else {
      debugPrint(req.data);
      return req;
      // throw Exception(req.data['message'] ?? 'Unknown Error');
    }
  }
}
