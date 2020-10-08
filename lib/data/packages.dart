import 'dart:convert';

import 'package:my_bloc_test/data/dependencies.dart';

PubdevPackages pubdevPackagesFromJson(String str) =>
    PubdevPackages.fromJson(json.decode(str));

class PubdevPackages {
  String nextUrl;
  List<Packages> packages;

  PubdevPackages({this.nextUrl, this.packages});

  PubdevPackages.fromJson(Map<String, dynamic> json) {
    nextUrl = json['next_url'];
    if (json['packages'] != null) {
      packages = new List<Packages>();
      json['packages'].forEach(
        (v) {
          packages.add(
            new Packages.fromJson(v),
          );
        },
      );
    }
  }
}

class Packages {
  String name;
  Latest latest;

  Packages({this.name, this.latest});

  Packages.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    latest =
        json['latest'] != null ? new Latest.fromJson(json['latest']) : null;
  }
}

class Latest {
  String version;
  Pubspec pubspec;
  String archiveUrl;
  String packageUrl;
  String url;

  Latest({
    this.version,
    this.pubspec,
    this.archiveUrl,
    this.packageUrl,
    this.url,
  });

  Latest.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    pubspec =
        json['pubspec'] != null ? new Pubspec.fromJson(json['pubspec']) : null;
    archiveUrl = json['archive_url'];
    packageUrl = json['package_url'];
    url = json['url'];
  }
}

class Pubspec {
  String name;
  String version;
  Dependencies dependencies;
  String homepage;
  String description;
  List<String> authors;

  Pubspec({
    this.name,
    this.version,
    this.description,
    this.homepage,
    this.authors,
    this.dependencies,
  });

  Pubspec.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    version = json['version'];
    description = json['description'];
    homepage = json['homepage'];
    dependencies = json['dependencies'] != null
        ? new Dependencies.fromJson(json['dependencies'])
        : null;
    authors != null ? authors = (json['authors'].cast<String>()) : null;
  }
}
