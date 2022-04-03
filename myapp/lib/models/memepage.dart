import 'dart:convert';

class MemePage {
  final String title;

  final String url;
  MemePage({
    required this.title,
    required this.url,
  });

  MemePage copyWith({
    String? title,
    String? url,
  }) {
    return MemePage(
      title: title ?? this.title,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'url': url});

    return result;
  }

  factory MemePage.fromMap(Map<String, dynamic> map) {
    return MemePage(
      title: map['title'] ?? '',
      url: map['url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MemePage.fromJson(String source) =>
      MemePage.fromMap(json.decode(source));

  @override
  String toString() => 'MemePage(title: $title, url: $url)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MemePage && other.title == title && other.url == url;
  }

  @override
  int get hashCode => title.hashCode ^ url.hashCode;
}
