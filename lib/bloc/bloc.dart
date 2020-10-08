import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bloc_test/bloc/event.dart';
import 'package:my_bloc_test/bloc/state.dart';
import 'package:my_bloc_test/data/package_by_name.dart';
import 'package:my_bloc_test/data/packages.dart';
import 'package:my_bloc_test/data/searching_packages.dart';
import 'package:my_bloc_test/services/package_repository.dart';

class PackageBloc extends Bloc<PackageEvent, PackageState> {
  final PackageRepository packageRepository;
  int currentPageNumber = 1;
  String search;
  String name;
  List pagesList = [1, 2, 3, 4, 5];

  PackageBloc(
    this.packageRepository,
  ) : super(PackageEmptyState());

  @override
  Stream<PackageState> mapEventToState(PackageEvent event) async* {
    try {
      if (event is ChangePageNumberEvent) {
        currentPageNumber = event.currentPageNumber;
      }
      if (event is PackageLoadEvent) {
        search = null;
        name = null;
        _pagesListChange(pagesList);
        final List<Packages> _loadedPackageList =
            await packageRepository.getAllPackages(currentPageNumber);

        yield LoadedAllPackagesState(
          loadedPackages: _loadedPackageList,
          pagesList: pagesList,
          currentPageNumber: currentPageNumber,
        );
      } else if (event is PackageChangeEvent) {
        if (event.search == null) {
          yield PackageEmptyState();
        } else
          search = event.search;

        List<Pack> _searchPackageList =
            await packageRepository.getSearchingPackages(search);
        yield LoadedByLetterState(loadedByLetter: _searchPackageList);
      } else if (event is PackageByNameEvent) {
        name = event.name;
        final List<PackageByName> _loadedByName =
            await packageRepository.getPackageByName(name);
        yield LoadedByNameState(loadedByName: _loadedByName);
      }
    } catch (_) {
      yield PackageErrorState();
    }
  }

  _pagesListChange(List pagesList) {
    pagesList.clear();
    for (var i = currentPageNumber; i <= currentPageNumber + 4;) {
      pagesList.add(i);
      i++;
    }
  }
}
