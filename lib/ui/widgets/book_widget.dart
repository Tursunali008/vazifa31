import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa31/bloc/file/bloc_file.dart';
import 'package:vazifa31/bloc/file/bloc_state.dart';
import 'package:vazifa31/ui/screen/book_info.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({super.key});

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FileBloc, FileState>(
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
        return CarouselSlider.builder(
          itemCount: files.length,
          itemBuilder: (context, index, realIndex) {
            return ZoomTapAnimation(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return BooksInfoScreen(index: index);
                  },
                ));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 100,
                      height: 250,
                      child: Image.network(
                        files[index].image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            files[index].title,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const Text(
                            "Online books",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff515151),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: 109,
                            height: 29,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color(0xff404066),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                "Update Progress",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xff404066),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 144,
            autoPlay: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 1500),
            enableInfiniteScroll: true,
            viewportFraction: 0.8,
            enlargeCenterPage: true,
          ),
        );
      },
    );
  }
}
