class Content {
  final String status;
  final String content;
  final int tokensRemaining;
  final String contentType;

  Content({
    required this.status,
    required this.content,
    required this.tokensRemaining,
    required this.contentType,
  });

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'content': content,
      'availableToken': tokensRemaining,
      'contentType;': contentType,
    };
  }

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      status: json['status'],
      content: json['content'],
      tokensRemaining: json['tokensRemaining'],
      contentType: json['contentType'],
    );
  }
}
