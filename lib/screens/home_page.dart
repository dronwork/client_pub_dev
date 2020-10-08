import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bloc_test/bloc/bloc.dart';
import 'package:my_bloc_test/bloc/event.dart';
import 'package:my_bloc_test/screens/description_page.dart';
import 'package:my_bloc_test/screens/search_page.dart';
import 'package:my_bloc_test/services/package_repository.dart';
import 'package:my_bloc_test/widgets/package_list.dart';

class HomePage extends StatelessWidget {
  final packageRepository = PackageRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PackageBloc>(
      create: (context) => PackageBloc(packageRepository),
      child: MaterialApp(
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/description':
              final ScreenArguments args = settings.arguments;
              return MaterialPageRoute(
                builder: (context) => DescriptionPage(
                  name: args.name,
                  description: args.description,
                  version: args.version,
                  dependencies: args.dependencies,
                  gitUrl: args.gitUrl,
                ),
              );
              break;
            case '/search':
              return MaterialPageRoute(builder: (context) => SearchPage());
              break;
          }
        },
        home: Scaffold(
          appBar: _buildAppBar(),
          body: Column(
            children: [
              TopSearchElement(),
              Expanded(child: PackageList()),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.grey[900],
      flexibleSpace: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Image(
          image: AssetImage('assets/pub-dev-logo.png'),
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}

class TopSearchElement extends StatelessWidget {
  String inputText;
  @override
  Widget build(BuildContext context) {
    final PackageBloc packageBloc = BlocProvider.of<PackageBloc>(context);
    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
          padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  if (inputText != null) {
                    packageBloc.add(
                      PackageChangeEvent(inputText),
                    );
                  }
                  Navigator.of(context)
                      .pushNamed('/search', arguments: context);
                },
              ),
              Expanded(
                child: _buildTextField(packageBloc, context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  TextField _buildTextField(PackageBloc packageBloc, BuildContext context) {
    return TextField(
      decoration: InputDecoration.collapsed(
        hintText: 'Search packages',
        hintStyle: TextStyle(color: Colors.grey[400]),
      ),
      cursorColor: Colors.white,
      style: TextStyle(
        color: Colors.white,
        fontSize: 23,
      ),
      onChanged: (text) {
        inputText = text;
      },
      onEditingComplete: () {
        if (inputText != null) {
          packageBloc.add(PackageChangeEvent(inputText));
        }
        Navigator.of(context).pushNamed('/search', arguments: context);
      },
    );
  }
}
