import 'package:vazifa31/data/model/file_model.dart';

sealed class FileEvent {}

final class GetFiles extends FileEvent {}

final class DownloadFile extends FileEvent {
  final FileModel file;

  DownloadFile({
    required this.file,
  });
}

final class OpenFile extends FileEvent {
  final String filePath;

  OpenFile({required this.filePath});
}

final class UploadFile extends FileEvent {
  final FileModel file;

  UploadFile({
    required this.file,
  });
}
