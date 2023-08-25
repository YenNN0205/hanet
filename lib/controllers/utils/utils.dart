// compare only time part of 2 datetime
// return 0 if is equal
// return negative if first is before second
// return positive if firse is after second
import 'dart:io';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

int compareTimeOnly(DateTime first, DateTime second) {
  return first
      .copyWith(year: 0, month: 0, day: 0)
      .compareTo(second.copyWith(year: 0, month: 0, day: 0));
}

_exportToExcel(SfDataGridState state) async {
  final Workbook workbook = state.exportToExcelWorkbook();
  final List<int> bytes = workbook.saveAsStream();
  await File('DataGrid.xlsx').writeAsBytes(bytes, flush: true);
}
