import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vazifa31/bloc/file/bloc_event.dart';
import 'package:vazifa31/bloc/file/bloc_state.dart';
import 'package:vazifa31/data/model/file_model.dart';
import 'package:vazifa31/data/repostoriya/repostoriya_file.dart';
import 'package:vazifa31/services/permission.dart';

class FileBloc extends Bloc<FileEvent, FileState> {
  FileBloc({required this.fileRepository})
      : super(FileState(
          status: FileStatus.initial,
          files: [],
        )) {
    on<GetFiles>(_onGetFiles);
    on<DownloadFile>(_onDownloadFile);
    on<OpenFile>(_onOpenFile);
    on<UploadFile>(_onUploadFile);
  }

  final FileRepository fileRepository;

  void _onGetFiles(event, emit) async {
    emit(state.copyWith(status: FileStatus.loading));

    try {
      await Future.delayed(const Duration(seconds: 1));
      final files = fileRepository.getFiles();

      for (FileModel file in files) {
        final fullPath = await _getSavePath(file);
        if (_checkFileExists(fullPath)) {
          file.isDownloaded = true;
          file.saveUrl = fullPath;
          file.progress = 1;
        }
      }

      emit(state.copyWith(
        status: FileStatus.loaded,
        files: files,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FileStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onDownloadFile(DownloadFile event, emit) async {
    final index = state.files!.indexWhere((file) {
      return file.id == event.file.id;
    });
    state.files![index].isLoading = true;
    emit(state.copyWith(files: state.files));

    try {
      if (await PermissionService.requestStoragePermission()) {
        final dio = Dio();

        final fullPath = await _getSavePath(event.file);
        final response = await dio.download(
          event.file.url,
          fullPath,
          onReceiveProgress: (count, total) {
            final progress = count / total;
            state.files![index].progress = progress;
            emit(state.copyWith(
              files: state.files,
            ));
          },
        );

        print(response);

        state.files![index].isDownloaded = true;
        state.files![index].isLoading = false;
        state.files![index].saveUrl = fullPath;

        emit(state.copyWith(
          files: state.files,
        ));
      } else {
        emit(
          state.copyWith(
            status: FileStatus.error,
            errorMessage: "Permission not granted",
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: FileStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onUploadFile(UploadFile event, emit) async {
    try {
      final dio = Dio();
      final file = File(event.file.saveUrl);

      final fileName = event.file.title;
      final fileFormat = event.file.url.split('.').last;

      final formData = FormData.fromMap({
        "file": MultipartFile.fromBytes(
          file.readAsBytesSync(),
          filename: "$fileName.$fileFormat",
        ),
      });

      final response = await dio.post(
        "https://api.escuelajs.co/api/v1/files/upload",
        data: formData,
      );

      print(response.data);
    } catch (e) {
      emit(state.copyWith(
        status: FileStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onOpenFile(OpenFile event, emit) async {
    await OpenFilex.open(event.filePath);
  }

  Future<String> _getSavePath(FileModel file) async {
    Directory? savePath = await getApplicationDocumentsDirectory();
    if (Platform.isAndroid) {
      savePath = Directory("/storage/emulated/0/download");
    }

    final fileName = file.title;
    final fileFormat = file.url.split('.').last;
    final fullPath = "${savePath.path}/$fileName.$fileFormat";

    return fullPath;
  }

  bool _checkFileExists(String fullPath) {
    final file = File(fullPath);

    return file.existsSync();
  }
}