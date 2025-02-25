class sourcesModel {
  final String? status;
  final List<Source> sources;

  sourcesModel({required this.status, required this.sources});

  factory sourcesModel.fromJson(Map<String, dynamic> json) {
    return sourcesModel(
      status: json['status'] ?? "unknown",  // Handle null status
      sources: (json['sources'] as List?)?.map((e) => Source.fromJson(e)).toList() ?? [],
    );
  }
}

class Source {
  final String id;
  final String name;
  final String desc;
  final String url;
  final String category;
  final String language;
  final String country;

  Source({
    required this.id,
    required this.name,
    required this.desc,
    required this.url,
    required this.category,
    required this.language,
    required this.country,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'] ?? "N/A",  // Assign default value if null
      name: json['name'] ?? "Unknown",
      desc: json['desc'] ?? "No description",
      url: json['url'] ?? "",
      category: json['category'] ?? "General",
      language: json['language'] ?? "en",
      country: json['country'] ?? "Unknown",
    );
  }
}
