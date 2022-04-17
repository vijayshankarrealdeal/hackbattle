import 'package:flutter/material.dart';
import 'package:hbapp/model/most_sold_item.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

/// The home page of the application which hosts the datagrid.
class FamousItemTable extends StatelessWidget {
  final List<FamousItems> data;
  const FamousItemTable({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
        source: DataSinkXDataSource(dataSinkXData: data),
        columnWidthMode: ColumnWidthMode.fill,
        columns: [
          GridColumn(
            label: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: Text(
                'Product Name',
              ),
            ),
            columnName: 'Product Name',
          ),
          GridColumn(
            label: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: Text(
                'Prodcut Price',
              ),
            ),
            columnName: 'Prodcut Price',
          ),
          GridColumn(
            label: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: Text(
                'Order Item Quantity',
                
              ),
            ),
            columnName: 'Order Item Quantity',
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
  DataSinkXDataSource({required List<FamousItems> dataSinkXData}) {
    _dataSinkXData = dataSinkXData
        .map<DataGridRow>(
          (e) => DataGridRow(
            cells: [
              DataGridCell<String>(
                  columnName: 'Product Name', value: e.productName),
              DataGridCell<num>(
                  columnName: 'Product Price', value: e.productPrice),
              DataGridCell<num>(
                  columnName: 'Order Item Quantity',
                  value: e.orderItemQuantity),
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
      return Colors.transparent;
    }

    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        color: getRowBackgroundColor(),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
