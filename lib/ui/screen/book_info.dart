import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa31/bloc/file/bloc_event.dart';
import 'package:vazifa31/bloc/file/bloc_file.dart';
import 'package:vazifa31/bloc/file/bloc_state.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class BooksInfoScreen extends StatefulWidget {
  final int index;
  const BooksInfoScreen({super.key, required this.index});

  @override
  State<BooksInfoScreen> createState() => _BooksInfoScreenState();
}

class _BooksInfoScreenState extends State<BooksInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Books Upload"),
      ),
      body: BlocBuilder<FileBloc, FileState>(
        builder: (context, state) {
          if (state.status == FileStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.status == FileStatus.error) {
            return Center(
              child: Text(state.errorMessage!),
            );
          }

          if (state.files == null || state.files!.isEmpty) {
            return const Center(
              child: Text("Fayllar mavjud emas"),
            );
          }

          final files = state.files!;
          return Column(
            children: [
              Image.network(
                files[widget.index].image,
                width: double.infinity,
                height: 350,
                fit: BoxFit.fill,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(files[widget.index].saveUrl),
              ),
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: BlocBuilder<FileBloc, FileState>(
            builder: (context, state) {
              final files = state.files!;
              final file = files[widget.index];
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(file.description),
                  LinearProgressIndicator(
                    value: file.progress.toDouble(),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ZoomTapAnimation(
                        onTap: () {},
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade500),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Icon(Icons.save_alt),
                        ),
                      ),
                      ZoomTapAnimation(
                        onTap: () {
                          if (file.isDownloaded) {
                            context
                                .read<FileBloc>()
                                .add(OpenFile(filePath: file.saveUrl));
                          } else {
                            context.read<FileBloc>().add(
                                  DownloadFile(file: file),
                                );
                          }
                        },
                        child: file.isDownloaded
                            ? Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xff404066),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.check,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : Container(
                                width: 230,
                                height: 52,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: const Color(0xff404066),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Download",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ],
              );
            },
          )),
    );
  }
}
