import 'package:cargo/constants.dart';
import 'package:cargo/helpers/lists.dart';
import 'package:cargo/models/cargo_model.dart';
import 'package:flutter/material.dart';
import 'package:lazy_data_table/lazy_data_table.dart';

class MyTable extends StatefulWidget {
  const MyTable({Key? key, required this.cargos}) : super(key: key);

  final List<CargoModel> cargos;

  @override
  State<MyTable> createState() => _MyTableState();
}

class _MyTableState extends State<MyTable> {
  @override
  Widget build(BuildContext context) {
    return LazyDataTable(
      rows: widget.cargos.length,
      columns: 5,
      tableDimensions: const LazyDataTableDimensions(
        cellHeight: 40,
        cellWidth: 150,
        topHeaderHeight: 40,
        leftHeaderWidth: 50,
      ),
      topHeaderBuilder: (i) => Container(
        color: Colors.grey,
        child: Center(
            child: Text(
          tableColumns[i],
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        )),
      ),
      leftHeaderBuilder: (i) => Container(
          color: Colors.grey,
          child: Center(
              child: Text(
            " ${i + 1}",
            style: const TextStyle(color: Colors.white),
          ))),
      dataCellBuilder: (i, j) => Center(child: Text(widget.cargos[i].row()[j])),
      topLeftCornerWidget: Container(
          color: Colors.grey,
          child: const Center(
            child: Text(
              "S/No",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          )),
    );
  }
}
