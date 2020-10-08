import 'package:flutter/foundation.dart';

@immutable
abstract class PackageState {}

class LoadedAllPackagesState extends PackageState {
  final List<dynamic> loadedPackages;
  final List pagesList;
  final int currentPageNumber;
  LoadedAllPackagesState(
      {@required this.loadedPackages,
      @required this.pagesList,
      @required this.currentPageNumber})
      : assert(loadedPackages != null);
}

class LoadedByLetterState extends PackageState {
  final List<dynamic> loadedByLetter;
  LoadedByLetterState({
    @required this.loadedByLetter,
  }) : assert(loadedByLetter != null);
}

class LoadedByNameState extends PackageState {
  final List<dynamic> loadedByName;

  LoadedByNameState({
    @required this.loadedByName,
  }) : assert(loadedByName != null);
}

class PackageEmptyState extends PackageState {}

class PackageErrorState extends PackageState {}
