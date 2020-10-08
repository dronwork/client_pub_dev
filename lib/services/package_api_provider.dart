import 'package:http/http.dart' as http;
import 'package:my_bloc_test/data/package_by_name.dart';
import 'package:my_bloc_test/data/packages.dart';
import 'package:my_bloc_test/data/searching_packages.dart';

class PackageProvider {
  Future<List<Packages>> getPackagesList(currentPageNumber) async {
    final url =
        'https://pub.dev/api/packages?page=' + currentPageNumber.toString();

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final pubdevPackages = pubdevPackagesFromJson(response.body);

      return pubdevPackages.packages;
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  //get only searching Packages List
  Future<List<Pack>> getSearchingPackagesList(String search) async {
    final String url = 'https://pub.dev/api/search?q=' + search;

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final pubdevPackages = searchingPackageFromJson(response.body);
      return pubdevPackages.packages;
    } else
      throw Exception('Error: ${response.reasonPhrase}');
  }

  Future<List<PackageByName>> getPackageByName(String name) async {
    List<PackageByName> list = [];
    final String url = 'https://pub.dev/api/packages/' + name;
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final pubdevPackages = namePackageFromJson(response.body);
      list.add(pubdevPackages);
      return list;
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }
}
