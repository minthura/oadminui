import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oadminui/constants.dart';
import 'package:oadminui/services/json_convertable.dart';
import 'package:oadminui/views/widgets/loading_indicator.dart';

class MyPaginatedDataTable extends StatefulWidget {
  const MyPaginatedDataTable({
    Key? key,
    required this.headers,
    required this.rows,
    this.onPageChange,
    required this.rowsPerPage,
    required this.totalRows,
    this.hasActions = false,
    required this.props,
    this.onActionDetail,
    this.onActionEdit,
    this.onActionDelete,
    this.isBusy = false,
  }) : super(key: key);
  final List<String> headers;
  final Function(int)? onPageChange;
  final int rowsPerPage;
  final int totalRows;
  final bool hasActions;
  final List<String> props;
  final List<JsonConvertable> rows;
  final Function(int)? onActionDetail;
  final Function(int)? onActionEdit;
  final Function(int)? onActionDelete;
  final bool isBusy;

  @override
  _MyPaginatedDataTableState createState() => _MyPaginatedDataTableState();
}

class _MyPaginatedDataTableState extends State<MyPaginatedDataTable> {
  int currentPage = 1;
  @override
  Widget build(BuildContext context) {
    int totalPages = (widget.totalRows / widget.rowsPerPage).ceil();
    return Container(
      // color: widget.isBusy ? Colors.black12 : Colors.white,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DataTable(
                columns: widget.hasActions
                    ? widget.headers
                        .map(
                        (h) => DataColumn(
                          label: Text(
                            h,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                        .followedBy([
                        DataColumn(
                            label: Text(
                          'Actions',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                      ]).toList()
                    : widget.headers
                        .map(
                          (h) => DataColumn(
                            label: Text(
                              h,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                        .toList(),
                rows: widget.rows.asMap().entries.map(
                  (entry) {
                    final jconvertable = entry.value;
                    final index = entry.key;
                    final cells = widget.props.map((prop) {
                      final json = jconvertable.toJson();
                      return DataCell(
                        Text(json.containsKey(prop) ? json[prop] : ''),
                      );
                    }).toList();
                    if (widget.hasActions) {
                      final fcells = cells.followedBy([
                        DataCell(Row(
                          children: [
                            IconButton(
                              color: Colors.green,
                              onPressed: widget.onActionDetail != null
                                  ? () => widget.onActionDetail!(index)
                                  : null,
                              icon: Icon(CupertinoIcons.list_dash),
                            ),
                            IconButton(
                              color: Colors.orange,
                              onPressed: widget.onActionEdit != null
                                  ? () => widget.onActionEdit!(index)
                                  : null,
                              icon: Icon(CupertinoIcons.pencil),
                            ),
                            IconButton(
                              color: Colors.red,
                              onPressed: widget.onActionDelete != null
                                  ? () => widget.onActionDelete!(index)
                                  : null,
                              icon: Icon(CupertinoIcons.delete),
                            ),
                          ],
                        ))
                      ]).toList();
                      return DataRow(cells: fcells);
                    }
                    return DataRow(cells: cells);
                  },
                ).toList(),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Spacer(),
                    IconButton(
                        onPressed: (currentPage == 1 || widget.isBusy)
                            ? null
                            : () async {
                                if (widget.onPageChange != null)
                                  await widget.onPageChange!(currentPage - 1);
                                setState(() {
                                  currentPage -= 1;
                                });
                              },
                        icon: Icon(CupertinoIcons.left_chevron)),
                    Text('Page $currentPage of $totalPages'),
                    IconButton(
                        onPressed: (currentPage == totalPages || widget.isBusy)
                            ? null
                            : () async {
                                if (widget.onPageChange != null)
                                  await widget.onPageChange!(currentPage + 1);
                                setState(() {
                                  currentPage += 1;
                                });
                              },
                        icon: Icon(CupertinoIcons.right_chevron)),
                  ],
                ),
              )
            ],
          ),
          widget.isBusy ? LoadingIndicator() : SizedBox(),
        ],
      ),
    );
  }
}
