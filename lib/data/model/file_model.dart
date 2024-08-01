class FileModel {
  int id;
  String title;
  String url;
  bool isLoading;
  bool isDownloaded;
  double progress;
  String saveUrl;
  String image;
  String description;
  String aufter;
  double price;
  double reting;

  FileModel({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.reting,
    required this.aufter,
    required this.price,
    required this.url,
    this.isLoading = false,
    this.isDownloaded = false,
    this.progress = 0,
    this.saveUrl = "",
  });
}
