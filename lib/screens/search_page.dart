import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bloc_test/bloc/bloc.dart';
import 'package:my_bloc_test/bloc/event.dart';
import 'package:my_bloc_test/widgets/search_packages_list.dart';

class SearchPage extends StatelessWidget {
  String inputText;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              BlocProvider.of<PackageBloc>(context).add(PackageLoadEvent());
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.grey[900],
          flexibleSpace: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image(
              image: AssetImage('assets/pub-dev-logo.png'),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        body: _buildColumn(context),
      ),
    );
  }

  Column _buildColumn(BuildContext context) {
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
                    BlocProvider.of<PackageBloc>(context)
                        .add(PackageChangeEvent(inputText));
                  }
                },
              ),
              Expanded(
                child: TextField(
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

                    BlocProvider.of<PackageBloc>(context)
                        .add(PackageChangeEvent(text));
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SearchPackageList(),
        ),
      ],
    );
  }
}
