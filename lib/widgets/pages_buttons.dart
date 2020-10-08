import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bloc_test/bloc/bloc.dart';
import 'package:my_bloc_test/bloc/event.dart';

class PagesButton extends StatelessWidget {
  final int pageNumber;
  bool isActive = false;
  PagesButton({
    this.pageNumber,
    this.isActive,
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        child: FlatButton(
          color: isActive ? Colors.blue : Colors.white30,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          onPressed: () {
            isActive = true;
            BlocProvider.of<PackageBloc>(context)
                .add(ChangePageNumberEvent(pageNumber));
            BlocProvider.of<PackageBloc>(context).add(PackageLoadEvent());
          },
          disabledColor: Colors.black26,
          child: Text(
            pageNumber.toString(),
            style: TextStyle(color: isActive ? Colors.white : Colors.blue),
          ),
        ),
      ),
    );
  }
}

class PagesButtonPrevious extends StatelessWidget {
  final int pageNumber;
  bool isActive = false;
  PagesButtonPrevious({
    this.pageNumber,
    this.isActive,
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        child: FlatButton(
          color: Colors.white30,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          onPressed: () {
            BlocProvider.of<PackageBloc>(context)
                .add(ChangePageNumberEvent(pageNumber));
            BlocProvider.of<PackageBloc>(context).add(PackageLoadEvent());
          },
          disabledColor: Colors.black26,
          child: Text(
            '<<',
            style: TextStyle(color: isActive ? Colors.blue : Colors.black26),
          ),
        ),
      ),
    );
  }
}

class PagesButtonNext extends StatelessWidget {
  final int pageNumber;
  bool isActive = false;
  PagesButtonNext({
    this.pageNumber,
    this.isActive,
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        child: FlatButton(
          color: Colors.white30,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          onPressed: () {
            BlocProvider.of<PackageBloc>(context)
                .add(ChangePageNumberEvent(pageNumber));
            BlocProvider.of<PackageBloc>(context).add(PackageLoadEvent());
          },
          disabledColor: Colors.black26,
          child: Text(
            '>>',
            style: TextStyle(color: isActive ? Colors.blue : Colors.black26),
          ),
        ),
      ),
    );
  }
}
