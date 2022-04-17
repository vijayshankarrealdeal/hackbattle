import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

/// The home page of the application which hosts the datagrid.
class MyHomePage extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  const MyHomePage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
        source: DataSinkXDataSource(DataSinkXData: data),
        columnWidthMode: ColumnWidthMode.fill,
        columns: data[0]
            .keys
            .map<GridColumn>(
              (e) => GridColumn(
                columnName: e,
                label: Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: Text(
                    e,
                  ),
                ),
              ),
            )
            .toList());
  }
}

class DataSinkX {
  /// Creates the DataSinkX class with required details.
  DataSinkX(this.id);

  /// Id of an DataSinkX.
  final int id;
}

class DataSinkXDataSource extends DataGridSource {
  DataSinkXDataSource({required List<Map<String, dynamic>> DataSinkXData}) {
    _DataSinkXData = DataSinkXData.map<DataGridRow>(
      (e) {
        return DataGridRow(
          cells: e.keys
              .map((x) => DataGridCell(columnName: x, value: e[x]))
              .toList(),
        );
      },
    ).toList();
  }

  List<DataGridRow> _DataSinkXData = [];

  @override
  List<DataGridRow> get rows => _DataSinkXData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
