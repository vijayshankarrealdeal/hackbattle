import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hbapp/model/fraud_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

/// The home page of the application which hosts the datagrid.
class FraudTable extends StatelessWidget {
  final List<FraudData> data;
  const FraudTable({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
        source: DataSinkXDataSource(dataSinkXData: data),
        columnWidthMode: ColumnWidthMode.fill,
        columns: [
          GridColumn(
            label: Container(
              padding:const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child:const Text(
                'Transction Type',
              ),
            ),
            columnName: 'Transction Type',
          ),
          GridColumn(
            label: Container(
              padding:const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: const Text(
                'Customer Segment',
              ),
            ),
            columnName: 'Customer Segment',
          ),
          GridColumn(
            label: Container(
              padding:const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child:const Text(
                'Product Price',
              ),
            ),
            columnName: 'Product Price',
          ),
          GridColumn(
            label: Container(
              padding:const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child:const Text(
                'benefitPerOrder',
              ),
            ),
            columnName: "benefitPerOrder",
          ),
          GridColumn(
            label: Container(
              padding:const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child:const Text(
                'Fraud',
              ),
            ),
            columnName: "Fraud",
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
  DataSinkXDataSource({required List<FraudData> dataSinkXData}) {
    _dataSinkXData = dataSinkXData
        .map<DataGridRow>(
          (e) => DataGridRow(
            cells: [
              DataGridCell<String>(
                  columnName: 'Transction Type', value: e.transferType),
              DataGridCell<String>(
                  columnName: 'Customer Segment', value: e.customerSegment),
              DataGridCell<num>(
                  columnName: 'Product Price', value: e.productPrice),
              DataGridCell<num>(
                  columnName: 'benefitPerOrder', value: e.benefitPerOrder),
              DataGridCell<num>(columnName: 'Fraud', value: e.fraud),
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
    Color getRowBackgroundColor() {
      final int fraud = row.getCells()[4].value;
      if (fraud == 0) {
        return Colors.transparent;
      } else {
        return Colors.red;
      }
    }

    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        color: getRowBackgroundColor(),
        alignment: Alignment.center,
        padding:const EdgeInsets.all(8.0),
        child: e.columnName == "Fraud"
            ? e.value == 0
                ?const Icon(CupertinoIcons.check_mark_circled_solid,
                    color: CupertinoColors.activeGreen)
                :const Icon(CupertinoIcons.clear_circled_solid,
                    color: CupertinoColors.white)
            : Text(e.value.toString()),
      );
    }).toList());
  }
}
