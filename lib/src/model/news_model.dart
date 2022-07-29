class NewsModel {
  NewsModel(this.author, this.title, this.description, this.urlToImage,
      this.publishedAt, this.content, this.sourceName, this.sourceId);

  String? author;
  String? title;
  String? description;
  String? urlToImage;
  DateTime? publishedAt;
  String? content;
  String? sourceId;
  String? sourceName;
}
