class ImageResult {
  String title;
  String thumbnailUrl;
  String link;
  int position;

  ImageResult({
    required this.title, 
    required this.thumbnailUrl, 
    required this.link,
    required this.position,
  });

  factory ImageResult.fromJson(Map<String, dynamic> json) {
    return ImageResult(
      title: json["title"],
      thumbnailUrl: json["thumbnail"],
      link: json["link"],
      position: json["position"]
    );
  }
}