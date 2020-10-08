import 'dart:convert';

SearchingPackage searchingPackageFromJson(String str) =>
    SearchingPackage.fromJson(json.decode(str));

class SearchingPackage {
  List<Pack> packages;
  String next;

  SearchingPackage({
    this.packages,
    this.next,
  });

  SearchingPackage.fromJson(Map<String, dynamic> json) {
    if (json['packages'] != null) {
      packages = new List<Pack>();
      json['packages'].forEach((v) {
        packages.add(new Pack.fromJson(v));
      });
    }
    next = json['next'];
  }
}

class Pack {
  String name;

  Pack({this.name});

  Pack.fromJson(Map<String, dynamic> json) {
    name = json['package'];
  }
}
