import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:posts_app/classes/post.dart';
import 'package:posts_app/components/post_list_tile.dart';
import 'package:posts_app/components/show_toast.dart';
import 'package:posts_app/service/post_service.dart';
import 'package:posts_app/util/result.dart';

class HomeScreen extends StatefulWidget {
  final int userId;
  final VoidCallback onLoggout;

  const HomeScreen({
    super.key,
    required this.userId,
    required this.onLoggout,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Post> _posts = [];

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    PostService postService = PostService();
    Result<List<Post>> result = await postService.findAllOfUser(widget.userId);

    if (result.isSuccess) {
      setState(() {
        _posts = result.data!;
      });
      return;
    }

    SchedulerBinding.instance.addPostFrameCallback((_) {
      showToast(
        context,
        result.errorMessage!,
        severity: ToastSeverity.error,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Posts App"),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: widget.onLoggout,
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, position) {
          Post post = _posts[position];

          return PostListTile(post: post);
        },
        itemCount: _posts.length,
      ),
    );
  }
}
