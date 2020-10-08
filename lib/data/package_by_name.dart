import 'dart:convert';

import 'package:my_bloc_test/data/dependencies.dart';

PackageByName namePackageFromJson(String str) =>
    PackageByName.fromJson(json.decode(str));

class PackageByName {
  String name;
  Latest latest;

  PackageByName({this.name, this.latest});

  PackageByName.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    latest =
        json['latest'] != null ? new Latest.fromJson(json['latest']) : null;
  }
}

class Latest {
  String version;
  Pubspec pubspec;

  Latest({this.version, this.pubspec});

  Latest.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    pubspec =
        json['pubspec'] != null ? new Pubspec.fromJson(json['pubspec']) : null;
  }
}

class Pubspec {
  String name;
  String version;
  String homepage;
  String description;
  Environment environment;
  Dependencies dependencies;

  Pubspec({
    this.name,
    this.version,
    this.homepage,
    this.description,
    this.environment,
    this.dependencies,
  });

  Pubspec.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    version = json['version'];
    homepage = json['homepage'];
    description = json['description'];
    environment = json['environment'] != null
        ? new Environment.fromJson(json['environment'])
        : null;
    dependencies = json['dependencies'] != null
        ? new Dependencies.fromJson(json['dependencies'])
        : null;
  }
}

class Environment {
  String sdk;

  Environment({this.sdk});

  Environment.fromJson(Map<String, dynamic> json) {
    sdk = json['sdk'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sdk'] = this.sdk;
    return data;
  }
}
