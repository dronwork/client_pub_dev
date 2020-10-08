class Dependencies {
  String dependencies = '';
  Dependencies({this.dependencies});

  Dependencies.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty == false) {
      String str = '';
      for (var item in json.entries) {
        if (item.key == 'flutter') {
          var map = Map();
          map = item.value;
          str = (map.keys.toString() + ': ' + map.values.toString());
          RegExp exp = RegExp(r"[^:\w\s]+");
          String res = str.replaceAll(exp, '');
          dependencies = dependencies + res + ', ';
        } else {
          str = (item.key.toString() + ' : ' + item.value.toString());
          RegExp exp = RegExp(r"[^.:>=<^\w\s]+");
          String res = str.replaceAll(exp, '');
          dependencies = dependencies + res + ', ';
        }
      }
    }
  }
}
