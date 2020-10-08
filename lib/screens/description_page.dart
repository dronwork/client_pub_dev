import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:my_bloc_test/widgets/spacing_widgets.dart';
import 'package:http/http.dart' as http;

class ScreenArguments {
  final String name;
  final String description;
  final String version;
  final String dependencies;
  final String gitUrl;
  final Key key;

  ScreenArguments({
    this.gitUrl,
    this.dependencies,
    this.key,
    this.name,
    this.description,
    this.version,
  });
}

class DescriptionPage extends StatelessWidget {
  final String name;
  final String description;
  final String version;
  final String dependencies;
  final String gitUrl;

  DescriptionPage({
    Key key,
    this.description,
    this.name,
    this.version,
    this.dependencies,
    this.gitUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: _buildColumn(),
    );
  }

  Column _buildColumn() {
    return Column(
      children: [
        BuildCard(
          name: name,
          description: description,
          version: version,
          dependencies: dependencies,
        ),
        Flexible(
          child: FutureBuilder<String>(
            future: _createReadmeFromGit(gitUrl),
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
      controller: ScrollController(),
      styleSheetTheme: MarkdownStyleSheetBaseTheme.platform,
      selectable: true,
      data: snapshot.data,
      imageDirectory: 'https://img.shields.io/pub/v/',
    );
  }
}

class BuildCard extends StatelessWidget {
  const BuildCard({
    Key key,
    @required this.name,
    @required this.description,
    @required this.version,
    @required this.dependencies,
  }) : super(key: key);

  final String name;
  final String description;
  final String version;
  final String dependencies;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                name != null ? name : 'name',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 23,
                ),
              ),
            ),
            SpaceH10(),
            Container(
                alignment: Alignment.centerLeft,
                child: Text(description != null ? description : 'description')),
            SpaceH10(),
            Row(
              children: [
                Text('v '),
                Text(
                  version != null ? version : 'version',
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
                dependencies != null ? dependencies : '-',
              ),
            ),
          ],
        ),
      ),
    );
  }
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
