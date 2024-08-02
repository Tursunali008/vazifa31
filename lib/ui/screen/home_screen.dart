import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa31/bloc/file/bloc_event.dart';
import 'package:vazifa31/bloc/file/bloc_file.dart';
import 'package:vazifa31/bloc/file/bloc_state.dart';
import 'package:vazifa31/ui/screen/book_info.dart';
import 'package:vazifa31/ui/widgets/book_widget.dart';
import 'package:vazifa31/ui/widgets/carusel.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  void _onSearchChanged() {
    final searchQuery = _searchController.text;
    context.read<FileBloc>().add(SearchFiles(searchQuery));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                  text: "Book ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  )),
              TextSpan(
                text: "Junction",
                style: TextStyle(
                  color: Color(0xffD1618A),
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        actions: [
          ZoomTapAnimation(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: SizedBox(
                width: 30,
                height: 30,
                child: Icon(Icons.notifications),
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<FileBloc, FileState>(
        bloc: context.read<FileBloc>()..add(GetFiles()),
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
          final filteredFiles = files.where((file) {
            final titleLower = file.title.toLowerCase();
            final queryLower = _searchQuery.toLowerCase();
            return titleLower.contains(queryLower);
          }).toList();

          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 5, bottom: 10),
                sliver: SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(27),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: IconButton(
                              onPressed: _onSearchChanged,
                              icon: Icon(Icons.search_sharp,
                                  color: Colors.grey.shade600)),
                        ),
                        hintText: "Search book",
                        hintStyle: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: RowsWidget()),
              const SliverPadding(
                padding: EdgeInsets.all(20),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    "Continue Reading",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: CarouselWidget(),
              ),
              const SliverPadding(
                padding: EdgeInsets.all(20),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    "Best Sellers",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
              ),
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (ctx, index) {
                    final file = filteredFiles[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 70,
                              width: double.infinity,
                              child:
                                  Image.network(file.image, fit: BoxFit.cover),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    file.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Text(file.reting.toString()),
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Price: ${file.price}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BooksInfoScreen(index: index),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                      Icons.arrow_circle_right_outlined),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: filteredFiles.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
