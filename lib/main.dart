import 'package:flutter/material.dart';
 import 'package:syncfusion_flutter_maps/maps.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MapShapeSource? _shapeSource;
  List<MapModel>? _mapData;

  @override
  void initState() {
    _mapData = _getMapData();
    _shapeSource = MapShapeSource.asset('assets/australia.json',
        shapeDataField: 'STATE_NAME',
        dataCount: _mapData!.length,
        primaryValueMapper: (int index) => _mapData![index].state,
        dataLabelMapper: (int index) => _mapData![index].stateCode,
        shapeColorValueMapper: (int index) => _mapData![index].color);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
        child:
        MapShapeLayer(
          source: _shapeSource!,
          showDataLabels: true,
          legend: const MapLegend(MapElement.shape),
          shapeTooltipBuilder: (BuildContext context, int index) {
            return Padding(
                padding: const EdgeInsets.all(7),
                child: Text(_mapData![index].stateCode,
                    style: const TextStyle(color: Colors.white)));
          },
          tooltipSettings: MapTooltipSettings(color: Colors.blue[900]),
        )

      ),
    );
  }

static List<MapModel> _getMapData() {
  return <MapModel>[
    MapModel('Australian Capital Territory', 'ACT', Colors.amber),
    MapModel('New South Wales', '       New\nSouth Wales', Colors.cyan),
    MapModel('Queensland', 'Queensland', Colors.amber[400]!),
    MapModel('Northern Territory', 'Northern\nTerritory', Colors.red[400]!),
    MapModel('Victoria', 'Victoria', Colors.purple[400]!),
    MapModel(
        'South Australia', 'South Australia', Colors.lightGreenAccent[200]!),
    MapModel('Western Australia', 'Western Australia', Colors.indigo[400]!),
    MapModel('Tasmania', 'Tasmania', Colors.lightBlue[100]!)
  ];
}
}

class MapModel {
  MapModel(this.state, this.stateCode, this.color);

  String state;
  String stateCode;
  Color color;
}
