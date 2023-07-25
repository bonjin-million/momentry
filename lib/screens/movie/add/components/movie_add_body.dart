import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:momentry/models/movie/movie_add_request.dart';
import 'package:momentry/models/movie/movie_detail.dart';
import 'package:momentry/providers/movie/movie_list_provider.dart';
import 'package:momentry/providers/movie_credits_provider.dart';
import 'package:momentry/widgets/custom_image.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../models/movie/movie_credits_response.dart';

class MovieAddBody extends ConsumerStatefulWidget {
  final MovieDetail? item;
  final String type;

  const MovieAddBody({Key? key, this.item, required this.type})
      : super(key: key);

  @override
  ConsumerState<MovieAddBody> createState() => _MovieAddBodyState();
}

class _MovieAddBodyState extends ConsumerState<MovieAddBody> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();
  TextEditingController dateController = TextEditingController();
  List<bool> stars = List.generate(5, (index) => index < 3);
  XFile? _imageFile;
  String content = '';
  String date = '';
  MovieAddRequest movie = MovieAddRequest();

  // 갤러리 사진 선택
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
    setState(() {
      date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    });

    dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());

    // 영화 검색 후 등록 시 연출진 & 출연자 조회 (1.PATH:영화검색 후 등록, 2.MODIFY:수정, 3.FILE:직접 등록)

    if (widget.type == 'PATH') {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ref
            .read(movieCreditsProvider.notifier)
            .fetchItemDetail(id: widget.item!.movieId);
      });
    } else if (widget.type == 'MODIFY') {
      if (widget.item!.stars.isNotEmpty) {
        if (widget.item!.stars.isNotEmpty) {
          stars = widget.item!.stars;
        }
      }
    }
  }

  void add(String directors, String actors) async {
    final currentState = _formKey.currentState!;
    String imagePath = '';

    if (currentState.validate()) {
      currentState.save();
      if (widget.type == "PATH") {
        final newMoviePost = MovieAddRequest(
            title: widget.item?.title ?? '',
            movieId: widget.item?.movieId ?? 0,
            image: widget.item?.image,
            stars: stars,
            directors: directors,
            actors: actors,
            content: content,
            date: date,
            prodYear: widget.item?.prodYear ?? '',
            type: widget.type);
        ref
            .read(movieListProvider.notifier)
            .add(newMoviePost.toMap())
            .then((value) {
          Navigator.popUntil(context, (route) => route.isFirst);
        });
      } else if (widget.type == "FILE") {
        if (_imageFile != null) {
          imagePath = await saveFile(_imageFile);
        }
        final newMoviePost = MovieAddRequest(
            title: movie.title,
            movieId: 0,
            image: imagePath,
            stars: stars,
            directors: directors,
            actors: actors,
            content: content,
            date: date,
            prodYear: widget.item?.prodYear ?? '',
            type: widget.type);
        ref
            .read(movieListProvider.notifier)
            .add(newMoviePost.toMap())
            .then((value) {
          Navigator.popUntil(context, (route) => route.isFirst);
        });
      }
    }
  }

  Future<String> saveFile(XFile? imageFile) async {
    if (imageFile != null) {
      return base64Encode(File(imageFile.path).readAsBytesSync());
    }
    return '';
  }

  void update(String directors, String actors) async {
    final currentState = _formKey.currentState!;

    if (currentState.validate()) {
      currentState.save();

      final newMoviePost = MovieAddRequest(
          title: widget.item?.title ?? '',
          movieId: widget.item?.movieId ?? 0,
          image: widget.item?.image ?? '',
          stars: stars,
          directors: directors,
          actors: actors,
          content: content,
          date: date,
          type: widget.type,
          prodYear: widget.item?.prodYear ?? '');

      ref
          .read(movieListProvider.notifier)
          .update(newMoviePost.toMap(), widget.item!.id)
          .then((value) {
        Navigator.popUntil(context, (route) => route.isFirst);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String? actors = '';
    String? directors = '';
    String? image = '';
    String? releaseDate = '';
    String? title = '';

    if (widget.type == "PATH") {
      final state = ref.watch(movieCreditsProvider);
      final isData = state is AsyncData<MovieCreditsResponse>;
      final isLoading = state is AsyncLoading;
      final isError = state is AsyncError;

      if (isLoading || !isData) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (isError) {
        return const Center(
          child: Text('오류!'),
        );
      }

      final credits = state.value;
      actors = credits.cast.map((e) => e.name).join(", ");
      directors = credits.crew
          .where((e) => e.job == 'Director')
          .map(
            (e) => e.name ?? '',
          )
          .join(", ");
      image = widget.item?.image;
      releaseDate = widget.item?.prodYear;
      title = widget.item?.title;
    } else if (widget.type == "MODIFY") {
      actors = widget.item?.actors;
      directors = widget.item?.directors;
      image = widget.item?.image;
      releaseDate = widget.item?.prodYear;
      title = widget.item?.title;
    }

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(50, 0, 50, 25),
                          child: AspectRatio(
                            aspectRatio: 3 / 4,
                            child: widget.type == 'FILE' && _imageFile != null
                                ? Image.memory(base64Decode(image!),
                                    fit: BoxFit.contain)
                                : widget.type == 'PATH' ||
                                        widget.type == 'MODIFY'
                                    ? CustomImage(
                                        imageUrl: image ?? '',
                                      )
                                    : _imageFile != null
                                        ? Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 16,
                                            ),
                                            child: Stack(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: AspectRatio(
                                                    aspectRatio: 3 / 4,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        border: Border.all(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ),
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: FileImage(File(
                                                              _imageFile!
                                                                  .path)),
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
                                                      HapticFeedback
                                                          .mediumImpact();
                                                      setState(() {
                                                        _imageFile = null;
                                                      });
                                                    },
                                                    child: Container(
                                                      width: 24,
                                                      height: 24,
                                                      decoration:
                                                          const BoxDecoration(
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
                                        : InkWell(
                                            onTap: () {
                                              pressImagePicker(
                                                  ImageSource.gallery);
                                            },
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CustomImage(
                                                  imageUrl: image ?? '',
                                                ),
                                                const Text(
                                                  '이미지를 등록하시려면\n 클릭해주세요.',
                                                  textAlign: TextAlign.center,
                                                )
                                              ],
                                            ),
                                          ),
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(40, 0, 40, 10),
                          child: title!.isNotEmpty
                              ? Text(
                                  title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                )
                              : TextField(
                                  autofocus: false,
                                  onChanged: (String text) {
                                    setState(() {
                                      movie.title = text;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                      hintText: '영화제목을 입력해주세요.'),
                                )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50, 10, 50, 25),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blueAccent.withOpacity(0.5),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 50,
                                      child: Text(
                                        '개봉',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    widget.type != 'FILE'
                                        ? Text(releaseDate ?? '')
                                        : Expanded(
                                            child: TextFormField(
                                              controller: dateController,
                                              decoration:
                                                  const InputDecoration(),
                                              readOnly: true,
                                              onTap: () async {
                                                DateTime? pickedDate =
                                                    await showDatePicker(
                                                        context: context,
                                                        initialDate:
                                                            DateTime.now(),
                                                        firstDate:
                                                            DateTime(2000),
                                                        lastDate:
                                                            DateTime.now());

                                                if (pickedDate != null) {
                                                  String formattedDate =
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(pickedDate);
                                                  setState(() {
                                                    dateController.text =
                                                        formattedDate;
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                    // : Container()
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 50,
                                      child: Text(
                                        '감독',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: directors!.isNotEmpty
                                          ? Text(
                                              directors,
                                              textAlign: TextAlign.center,
                                            )
                                          : TextFormField(
                                              autofocus: false,
                                              maxLines: null,
                                              minLines: 1,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return '';
                                                }
                                                return null;
                                              },
                                              onSaved: (value) {
                                                if (value != null) {
                                                  directors = value;
                                                }
                                              },
                                            ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 50,
                                      child: Text(
                                        '배우',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: actors!.isNotEmpty
                                          ? Text(
                                              actors,
                                              textAlign: TextAlign.left,
                                            )
                                          : TextFormField(
                                              autofocus: false,
                                              maxLines: null,
                                              minLines: 1,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return '';
                                                }
                                                return null;
                                              },
                                              onSaved: (value) {
                                                if (value != null) {
                                                  actors = value;
                                                }
                                              },
                                            ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ...stars.asMap().entries.map(
                              (e) {
                                int index = e.key;
                                bool value = e.value;
                                return InkWell(
                                  onTap: () {
                                    var newStars = [...stars.map((e) => false)];

                                    for (int i = 0; i <= index; i++) {
                                      newStars[i] = true;
                                    }
                                    setState(() {
                                      stars = newStars;
                                    });
                                  },
                                  child: Icon(
                                    value
                                        ? Icons.star
                                        : Icons.star_border_outlined,
                                    color: value ? Colors.amber : Colors.grey,
                                  ),
                                );
                              },
                            ).toList(),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: TextFormField(
                          onSaved: (value) {
                            if (value != null) {
                              content = value;
                            }
                          },
                          initialValue: widget.item?.content ?? '',
                          autofocus:
                              // widget.item != null ? true : false,
                              true,
                          maxLines: null,
                          style: const TextStyle(decorationThickness: 0),
                          decoration: const InputDecoration(
                            hintText: '후기를 작성해주세요.',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        widget.type == 'PATH' || widget.type == 'FILE'
                            ? add(
                                directors ?? '',
                                actors ?? '',
                              )
                            : update(directors ?? '', actors ?? '');
                      },
                      icon: const Icon(Icons.check),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
