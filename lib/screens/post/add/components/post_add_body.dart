import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:momentry/models/post/post_add_request.dart';
import 'package:momentry/providers/post_provider.dart';

class PostAddBody extends ConsumerStatefulWidget {
  const PostAddBody({Key? key}) : super(key: key);

  @override
  ConsumerState<PostAddBody> createState() => _PostAddBodyState();
}

class _PostAddBodyState extends ConsumerState<PostAddBody> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  String title = '';
  String content = '';
  String date = '';

  @override
  void initState() {
    super.initState();

    dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  void add() async {
    final formKeyState = _formKey.currentState!;
    if (formKeyState.validate()) {
      formKeyState.save();

      final newPost = PostAddRequest(
          title: title, content: content, date: dateController.text);
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
            TextFormField(
              controller: dateController,
              decoration: const InputDecoration(
                icon: Icon(Icons.calendar_today),
                labelText: "언제?",
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now());

                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  setState(() {
                    dateController.text = formattedDate;
                    date = formattedDate;
                  });
                }
              },
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
                    print(value);
                    if (value != null) {
                      content = value;
                    }
                  },
                  decoration: const InputDecoration(
                    icon: Icon(Icons.note_outlined),
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
