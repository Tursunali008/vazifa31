import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa31/bloc/file/bloc_event.dart';
import 'package:vazifa31/bloc/file/bloc_file.dart';
import 'package:vazifa31/bloc/file/bloc_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mening 5"),
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

          return ListView.builder(
            itemCount: files.length,
            itemBuilder: (ctx, index) {
              final file = files[index];
              print(file.saveUrl);
              return ListTile(
                leading: Image.network(file.image),
                title: Text(file.title),
                subtitle: Column(
                  children: [
                    Text(file.url),
                    const SizedBox(height: 5),
                    LinearProgressIndicator(
                      value: file.progress,
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        context.read<FileBloc>().add(UploadFile(file: file));
                      },
                      icon: const Icon(
                        Icons.upload,
                        size: 40,
                        color: Colors.red,
                      ),
                    ),
                    file.isLoading
                        ? const CircularProgressIndicator()
                        : IconButton(
                            onPressed: () {
                              if (file.isDownloaded) {
                                // open
                                context
                                    .read<FileBloc>()
                                    .add(OpenFile(filePath: file.saveUrl));
                              } else {
                                context
                                    .read<FileBloc>()
                                    .add(DownloadFile(file: file));
                              }
                            },
                            icon: Icon(
                              file.isDownloaded ? Icons.check : Icons.download,
                              size: 40,
                              color: Colors.blue,
                            ),
                          ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}