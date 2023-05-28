import 'package:expenses/providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthSelectorWidget extends StatelessWidget {
  const MonthSelectorWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var uIProvider = context.read<UIProvider>();
    int currPage = context.watch<UIProvider>().selectedMonth;

    final controller = PageController(
      initialPage: currPage,
      viewportFraction: 0.4,
    );

    return SizedBox(
      height: 40,
      child: PageView(
        onPageChanged: (value) => uIProvider.selectedMonth = value,
        controller: controller,
        children: [
          pageItems('Enero', 0, currPage),
          pageItems('Febrero', 1, currPage),
          pageItems('Marzo', 2, currPage),
          pageItems('Abril', 3, currPage),
          pageItems('Mayo', 4, currPage),
          pageItems('Junio', 5, currPage),
          pageItems('Julio', 6, currPage),
          pageItems('Agosto', 7, currPage),
          pageItems('Septiembre', 8, currPage),
          pageItems('Octubre', 9, currPage),
          pageItems('Noviembre', 10, currPage),
          pageItems('Diciembre', 11, currPage),
        ],
      ),
    );
  }

  pageItems(String name, int position, int currPage) {
    Alignment alignment;

    const selected = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
    final unSelected = TextStyle(fontSize: 20, color: Colors.grey[700]);

    if (position == currPage) {
      alignment = Alignment.center;
    } else if (position > currPage) {
      alignment = Alignment.centerRight / 2;
    } else {
      alignment = Alignment.centerLeft / 2;
    }

    return Align(
      alignment: alignment,
      child: Text(
        name,
        style: position == currPage ? selected : unSelected,
      ),
    );
  }
}
