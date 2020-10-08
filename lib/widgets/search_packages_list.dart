import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:my_bloc_test/bloc/bloc.dart';
import 'package:my_bloc_test/bloc/event.dart';
import 'package:my_bloc_test/bloc/state.dart';
import 'package:my_bloc_test/main.dart';
import 'package:my_bloc_test/widgets/spacing_widgets.dart';
import 'package:http/http.dart' as http;

class SearchPackageList extends StatelessWidget {
  String name;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackageBloc, PackageState>(
      builder: (context, state) {
        if (state == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is LoadedByNameState) {
          return buildListViewByName(state);
        }
        if (state is LoadedByLetterState) {
          return ListView.builder(
            itemCount: state.loadedByLetter.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                name = state.loadedByLetter.toList()[index].name;
                BlocProvider.of<PackageBloc>(context)
                    .add(PackageByNameEvent(name));
              },
              child: _buildCard(state, index),
            ),
          );
        } else
          return Container();
      },
    );
  }

  Card _buildCard(LoadedByLetterState state, int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                '${state.loadedByLetter.toList()[index].name}',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 23,
                ),
              ),
            ),
            SpaceH10(),
          ],
        ),
      ),
    );
  }

  buildListViewByName(state) {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    state.loadedByName.toList()[0].name != null
                        ? state.loadedByName.toList()[0].name
                        : 'name',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 23,
                    ),
                  ),
                ),
                SpaceH10(),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(state.loadedByName
                              .toList()[0]
                              .latest
                              .pubspec
                              .description !=
                          null
                      ? state.loadedByName
                          .toList()[0]
                          .latest
                          .pubspec
                          .description
                      : 'description'),
                ),
                SpaceH10(),
                Row(
                  children: [
                    Text('v '),
                    Text(
                      state.loadedByName.toList()[0].latest.pubspec.version !=
                              null
                          ? state.loadedByName
                              .toList()[0]
                              .latest
                              .pubspec
                              .version
                          : 'version',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
                SpaceH10(),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Dependencies: ',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    state.loadedByName
                                .toList()[0]
                                .latest
                                .pubspec
                                .dependencies !=
                            null
                        ? state.loadedByName
                            .toList()[0]
                            .latest
                            .pubspec
                            .dependencies
                            .dependencies
                        : '-',
                  ),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          child: FutureBuilder<String>(
            future: _createReadmeFromGit(
                state.loadedByName.toList()[0].latest.pubspec.homepage),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _buildMarkdown(snapshot);
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ],
    );
  }

  Markdown _buildMarkdown(AsyncSnapshot<String> snapshot) {
    return Markdown(
      styleSheetTheme: MarkdownStyleSheetBaseTheme.platform,
      controller: ScrollController(),
      selectable: true,
      data: snapshot.data,
      imageDirectory: 'https://img.shields.io/pub/v/',
    );
  }

  //create data for Markdown widget
  Future<String> _createReadmeFromGit(String gitUrl) async {
    if (gitUrl == null) {
      final readmeFromGit = 'READ.me not found';
      return readmeFromGit;
    }
    final String rowGitUrl = _createRowGitUrl(gitUrl);

    final response = await http.get(rowGitUrl);

    if (response.statusCode == 200) {
      final readmeFromGit = response.body;

      return readmeFromGit;
    } else {
      final readmeFromGit = 'Error code: ${response.statusCode}';
      return readmeFromGit;
    }
  }

// Make row url from http github url
  String _createRowGitUrl(String gitUrl) {
    List<String> list = gitUrl.split("/");

    if (list[2] != 'github.com') return gitUrl;
    final String rowGitUrl = 'https://raw.githubusercontent.com/' +
        list[3] +
        '/' +
        list[4] +
        '/master/README.md';

    return rowGitUrl;
  }
}
