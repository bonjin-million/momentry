import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:momentry/models/post/post_add_request.dart';
import 'package:momentry/providers/post_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

class PostAddBody extends ConsumerStatefulWidget {
  const PostAddBody({Key? key}) : super(key: key);

  @override
  ConsumerState<PostAddBody> createState() => _PostAddBodyState();
}

class _PostAddBodyState extends ConsumerState<PostAddBody> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _imageFile;

  String title = '';
  String content = '';
  String date = '';

  void pressImagePicker(ImageSource source) async {
    if (await Permission.photos.request().isGranted) {
      final XFile? pickedFile = await _imagePicker.pickImage(
        maxHeight: 1000,
        maxWidth: 1000,
        source: source,
      );
      if (pickedFile != null) {
        setState(() {
          _imageFile = pickedFile;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();

    dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  void add() async {
    final formKeyState = _formKey.currentState!;
    if (formKeyState.validate()) {
      formKeyState.save();

      final imagePath = await saveFile(_imageFile);

      final newPost = PostAddRequest(
        title: title,
        content: content,
        date: dateController.text,
        imageFile: imagePath,
      );
      ref.read(postProvider.notifier).add(newPost.toMap()).then((value) {
        Navigator.pop(context);
      });
    }
  }

  Future<String> saveFile(XFile? imageFile) async {
    if (imageFile != null) {
      return base64Encode(File(imageFile.path).readAsBytesSync());
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
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
                        _imageFile != null
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: FileImage(
                                                  File(_imageFile!.path)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: InkWell(
                                        onTap: () {
                                          HapticFeedback.mediumImpact();
                                          setState(() {
                                            _imageFile = null;
                                          });
                                        },
                                        child: Container(
                                          width: 24,
                                          height: 24,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey,
                                          ),
                                          child: const Center(
                                            child: Icon(
                                              Icons.close,
                                              size: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        TextFormField(
                          autofocus: true,
                          maxLines: null,
                          minLines: 1,
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x10000000),
                      offset: Offset(0, -3),
                      blurRadius: 3,
                      spreadRadius: 0,
                    ),
                  ],
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        pressImagePicker(ImageSource.gallery);
                      },
                      icon: const Icon(Icons.photo_album),
                    ),
                    IconButton(
                      onPressed: add,
                      icon: const Icon(Icons.check),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
