import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _markersLatLongList = prefs
              .getStringList('ff_markersLatLongList')
              ?.map(latLngFromString)
              .withoutNulls ??
          _markersLatLongList;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  List<LatLng> _markersLatLongList = [const LatLng(0, 0), const LatLng(0, 0)];
  List<LatLng> get markersLatLongList => _markersLatLongList;
  set markersLatLongList(List<LatLng> value) {
    _markersLatLongList = value;
    prefs.setStringList(
        'ff_markersLatLongList', value.map((x) => x.serialize()).toList());
  }

  void addToMarkersLatLongList(LatLng value) {
    markersLatLongList.add(value);
    prefs.setStringList('ff_markersLatLongList',
        _markersLatLongList.map((x) => x.serialize()).toList());
  }

  void removeFromMarkersLatLongList(LatLng value) {
    markersLatLongList.remove(value);
    prefs.setStringList('ff_markersLatLongList',
        _markersLatLongList.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromMarkersLatLongList(int index) {
    markersLatLongList.removeAt(index);
    prefs.setStringList('ff_markersLatLongList',
        _markersLatLongList.map((x) => x.serialize()).toList());
  }

  void updateMarkersLatLongListAtIndex(
    int index,
    LatLng Function(LatLng) updateFn,
  ) {
    markersLatLongList[index] = updateFn(_markersLatLongList[index]);
    prefs.setStringList('ff_markersLatLongList',
        _markersLatLongList.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInMarkersLatLongList(int index, LatLng value) {
    markersLatLongList.insert(index, value);
    prefs.setStringList('ff_markersLatLongList',
        _markersLatLongList.map((x) => x.serialize()).toList());
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
