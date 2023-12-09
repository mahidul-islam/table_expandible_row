import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter DataTable with Expansion Behavior'),
        ),
        body: const MyDataTable(),
      ),
    );
  }
}

class MyDataTable extends StatefulWidget {
  const MyDataTable({super.key});

  @override
  State<MyDataTable> createState() => _MyDataTableState();
}

class _MyDataTableState extends State<MyDataTable> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: DataTable(
          dataRowMaxHeight: double.infinity,
          dataRowMinHeight: 100,
          columns: const [
            DataColumn(label: Text('Column 1')),
            DataColumn(label: Text('Column 2')),
          ],
          rows: [
            DataRow(
              cells: [
                DataCell(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                          height: 100,
                          child: Center(child: Text('Row 1, Column 1'))),
                      CrossfadeWrapperContainer(
                        visible: isExpanded,
                        useLoader: false,
                        child: const SizedBox(
                            height: 200,
                            child: Center(child: Text('Additional Content'))),
                      ),
                    ],
                  ),
                ),
                DataCell(
                  IconButton(
                    icon: Icon(
                      isExpanded ? Icons.expand_less : Icons.expand_more,
                    ),
                    onPressed: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                  ),
                ),
              ],
            ),
            DataRow(
              cells: [
                const DataCell(Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Row 2, Column 1'),
                  ],
                )),
                DataCell(Container()),
              ],
            ),
            DataRow(
              cells: [
                const DataCell(Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Row 3, Column 1'),
                  ],
                )),
                DataCell(Container()),
              ],
            ),
            DataRow(
              cells: [
                const DataCell(Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Row 4, Column 1'),
                  ],
                )),
                DataCell(Container()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CrossfadeWrapperContainer extends StatelessWidget {
  const CrossfadeWrapperContainer({
    required this.visible,
    required this.child,
    this.replacement,
    this.useLoader = true,
    this.loaderHeight,
    this.alignment = Alignment.center,
    this.duration = const Duration(milliseconds: 300),
    super.key,
  });

  final Widget child;
  final Widget? replacement;
  final Duration duration;
  final bool visible;
  final Alignment alignment;
  final bool useLoader;
  final double? loaderHeight;
  Widget get loader => loaderHeight == null
      ? const CircularProgressIndicator()
      : Container(
          height: loaderHeight,
          width: double.maxFinite,
          color: Colors.white,
          child: const Center(child: CircularProgressIndicator()),
        );
  Widget get empty => const SizedBox.shrink();

  @override
  Widget build(final BuildContext context) {
    return AnimatedCrossFade(
      firstChild: child,
      secondChild: empty,
      crossFadeState:
          visible ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: duration,
      alignment: alignment,
      layoutBuilder:
          (final Widget first, final _, final Widget second, final __) =>
              visible ? first : replacement ?? (useLoader ? loader : empty),
    );
  }
}
