import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hbapp/dashboard/forecasting/forecasting_logic.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

/// The home page of the application which hosts the datagrid.
class ForecsatTable extends StatelessWidget {
  final List<AutoGenerateForecast> data;
  const ForecsatTable({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
        source: DataSinkXDataSource(dataSinkXData: data),
        columnWidthMode: ColumnWidthMode.fill,
        columns: [
          GridColumn(
            label: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: Text(
                'Dates',
              ),
            ),
            columnName: 'Dates',
          ),
          GridColumn(
            label: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: Text(
                'Monthy Forecast For Total Benifit Per Order',
              ),
            ),
            columnName: 'Monthy Forecast For Total Benifit Per Order',
          ),
        ]);
  }
}

class DataSinkX {
  /// Creates the DataSinkX class with required details.
  DataSinkX(this.id);

  /// Id of an DataSinkX.
  final int id;
}

class DataSinkXDataSource extends DataGridSource {
  DataSinkXDataSource({required List<AutoGenerateForecast> dataSinkXData}) {
    _dataSinkXData = dataSinkXData
        .map<DataGridRow>(
          (e) => DataGridRow(
            cells: [
              DataGridCell<String>(
                  columnName: 'Dates', value: e.date.substring(0, 10)),
              DataGridCell<num>(
                  columnName: 'Monthy Forecast For Total Benifit Per Order',
                  value: e.sales),
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> _dataSinkXData = [];

  @override
  List<DataGridRow> get rows => _dataSinkXData;

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
