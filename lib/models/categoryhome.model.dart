class CategoryHome {
  final String name;

  CategoryHome({required this.name});

  factory CategoryHome.fromJson(Map<String, dynamic> json) {
    return CategoryHome(name: json['name']);
  }
}
