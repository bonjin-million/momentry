import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:momentry/models/post/post_add_request.dart';
import 'package:momentry/providers/post_provider.dart';

class PostAddBody extends ConsumerStatefulWidget {
  const PostAddBody({Key? key}) : super(key: key);

  @override
  ConsumerState<PostAddBody> createState() => _PostAddBodyState();
}

class _PostAddBodyState extends ConsumerState<PostAddBody> {
  final _formKey = GlobalKey<FormState>();

  String title = '';
  String content = '';

  void add() async {
    final formKeyState = _formKey.currentState!;
    if (formKeyState.validate()) {
      formKeyState.save();

      final newPost = PostAddRequest(title: title, content: content);
      ref.read(postProvider.notifier).add(newPost.toMap()).then((value) {
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              '2023.05.23',
              style: const TextStyle(fontSize: 17),
            ),
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  autofocus: true,
                  maxLines: null,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '일기 작성하는 곳';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    if(value != null) {
                      content = value;
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: '일기 작성하는 곳',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.check),
                    onPressed: add,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
