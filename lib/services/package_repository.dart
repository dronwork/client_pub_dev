import 'package:my_bloc_test/data/package_by_name.dart';
import 'package:my_bloc_test/data/packages.dart';
import 'package:my_bloc_test/data/searching_packages.dart';
import 'package:my_bloc_test/services/package_api_provider.dart';

class PackageRepository {
  PackageProvider _packagesProvider = PackageProvider();
  Future<List<Packages>> getAllPackages(currentPageNumber) =>
      _packagesProvider.getPackagesList(currentPageNumber);

  //request only searching Packages List
  Future<List<Pack>> getSearchingPackages(search) =>
      _packagesProvider.getSearchingPackagesList(search);

  Future<List<PackageByName>> getPackageByName(name) =>
      _packagesProvider.getPackageByName(name);
}
