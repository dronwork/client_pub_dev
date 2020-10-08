import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bloc_test/bloc/bloc.dart';
import 'package:my_bloc_test/bloc/event.dart';
import 'package:my_bloc_test/bloc/state.dart';
import 'package:my_bloc_test/main.dart';
import 'package:my_bloc_test/screens/description_page.dart';
import 'package:my_bloc_test/widgets/pages_buttons.dart';
import 'package:my_bloc_test/widgets/spacing_widgets.dart';

class PackageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PackageBloc>(context).add(PackageLoadEvent());
    return BlocBuilder<PackageBloc, PackageState>(
      builder: (context, state) {
        if (state == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is LoadedAllPackagesState) {
          return Scaffold(
            bottomNavigationBar: _bottomNavyBar(state),
            body: ListView.builder(
              itemCount: state.loadedPackages.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  _transitionToDescriptionPage(state, index, context);
                },
                child: _buildCard(state, index),
              ),
            ),
          );
        } else
          return Container();
      },
    );
  }

  Card _buildCard(LoadedAllPackagesState state, int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                '${state.loadedPackages.toList()[index].name}',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 23,
                ),
              ),
            ),
            SpaceH10(),
            Container(
              alignment: Alignment.centerLeft,
              child: buildDescriptionText(state, index),
            ),
            SpaceH10(),
            Row(
              children: [
                Text('v '),
                buildVersionText(state, index),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomNavyBar(state) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        color: Colors.white70,
        boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 2)],
      ),
      child: SafeArea(
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 36,
          child: Row(
            children: _paginationItemBuilder(state),
          ),
        ),
      ),
    );
  }

  _paginationItemBuilder(state) {
    List<Widget> pagesButtonsList = [];
    if (state.pagesList[0] != 1) {
      pagesButtonsList.add(
        PagesButtonPrevious(
          pageNumber: state.pagesList[0] - 1,
          isActive: true,
        ),
      );
    } else {
      pagesButtonsList.add(
        PagesButtonPrevious(
          pageNumber: 1,
          isActive: false,
        ),
      );
    }
    int currentPageNumber = state.currentPageNumber;

    for (int n in state.pagesList) {
      pagesButtonsList.add(
        PagesButton(
          isActive: n == currentPageNumber ? true : false,
          pageNumber: n,
        ),
      );
    }

    if (state.pagesList[4] + 1 != null) {
      pagesButtonsList.add(
        PagesButtonNext(
          pageNumber: state.pagesList[0] + 1,
          isActive: true,
        ),
      );
    } else {
      pagesButtonsList.add(
        PagesButtonNext(
          pageNumber: state.pagesList[0],
          isActive: false,
        ),
      );
    }

    return pagesButtonsList;
  }

  Text buildVersionText(LoadedAllPackagesState state, int index) {
    if (state.loadedPackages.toList()[index].latest != null) {
      return Text(
        '${state.loadedPackages.toList()[index].latest.version}',
        style: TextStyle(color: Colors.blue),
      );
    } else
      return Text('');
  }

  Text buildDescriptionText(LoadedAllPackagesState state, int index) {
    if (state.loadedPackages.toList()[index].latest != null) {
      return Text(
          '${state.loadedPackages.toList()[index].latest.pubspec.description}');
    } else
      return Text('');
  }

  void _transitionToDescriptionPage(state, index, context) {
    final name = state.loadedPackages.toList()[index].name;
    final String description =
        state.loadedPackages.toList()[index].latest.pubspec.description;
    final String version = state.loadedPackages.toList()[index].latest.version;
    String dependencies = '-';
    if (state.loadedPackages.toList()[index].latest.pubspec.dependencies !=
        null) {
      dependencies = state.loadedPackages
          .toList()[index]
          .latest
          .pubspec
          .dependencies
          .dependencies;
    }

    final String gitUrl =
        state.loadedPackages.toList()[index].latest.pubspec.homepage;

    Navigator.pushNamed(
      context,
      '/description',
      arguments: ScreenArguments(
        name: name,
        description: description,
        version: version,
        dependencies: dependencies,
        gitUrl: gitUrl,
      ),
    );
  }
}
