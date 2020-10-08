abstract class PackageEvent {}

class PackageLoadEvent extends PackageEvent {}

class PackageChangeEvent extends PackageEvent {
  final String search;
  PackageChangeEvent(this.search);
}

class PackageByNameEvent extends PackageEvent {
  final String name;
  PackageByNameEvent(this.name);
}

class ChangePageNumberEvent extends PackageEvent {
  final int currentPageNumber;

  ChangePageNumberEvent(this.currentPageNumber);
}
