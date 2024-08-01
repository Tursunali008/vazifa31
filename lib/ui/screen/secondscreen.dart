import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa31/bloc/file/bloc_event.dart';
import 'package:vazifa31/bloc/file/bloc_file.dart';
import 'package:vazifa31/bloc/file/bloc_state.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload and Download"),
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
          return ListView.builder(
            itemCount: files.length,
            itemBuilder: (ctx, index) {
              final file = files[index];
              return ListTile(
                title: Text(file.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(file.url),
                    const SizedBox(height: 5),
                    LinearProgressIndicator(
                      value: file.progress.toDouble(),
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        context
                            .read<FileBloc>()
                            .add(UploadFile(file: file));
                      },
                      icon: const Icon(
                        Icons.upload,
                        color: Colors.grey,
                        size: 40,
                      ),
                    ),
                    file.isLoading
                        ? const CircularProgressIndicator()
                        : IconButton(
                            onPressed: () {
                              if (file.isDownloaded) {
                                context
                                    .read<FileBloc>()
                                    .add(OpenFile(  filePath:file.saveUrl, ));
                              } else {
                                context
                                    .read<FileBloc>()
                                    .add(DownloadFile(file: file));
                              }
                            },
                            icon: Icon(
                              file.isDownloaded ? Icons.check : Icons.download,
                              color: Colors.blue,
                              size: 40,
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