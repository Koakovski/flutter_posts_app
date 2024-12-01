import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:posts_app/classes/comment.dart';
import 'package:posts_app/classes/post.dart';
import 'package:posts_app/components/comment_list_tile.dart';
import 'package:posts_app/components/show_toast.dart';
import 'package:posts_app/service/comment_service.dart';
import 'package:posts_app/util/result.dart';

class PostScreen extends StatefulWidget {
  final Post post;
  const PostScreen({super.key, required this.post});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late List<Comment> _comments = [];

  @override
  void initState() {
    super.initState();
    fetchComments();
  }

  Future<void> fetchComments() async {
    CommentService commentService = CommentService();
    Result<List<Comment>> result =
        await commentService.findAllOfPost(widget.post.id);

    if (result.isSuccess) {
      setState(() {
        _comments = result.data!;
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
      appBar: AppBar(
        title: const Text("Post"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(15),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.post.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Divider(),
                Text(
                  widget.post.body,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              'comments',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, position) {
                Comment comment = _comments[position];

                return CommentListTile(comment: comment);
              },
              itemCount: _comments.length,
            ),
          ),
        ],
      ),
    );
  }
}
