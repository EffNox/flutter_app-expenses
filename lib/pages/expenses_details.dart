import 'package:expenses/models/combined_model.dart';
import 'package:expenses/providers/expenses_provider.dart';
import 'package:expenses/providers/ui_provider.dart';
import 'package:expenses/utils/constants.dart';
import 'package:expenses/utils/math_operations.dart';
import 'package:expenses/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ExpensesDetailPage extends StatefulWidget {
  const ExpensesDetailPage({Key? key}) : super(key: key);

  @override
  State<ExpensesDetailPage> createState() => _ExpensesDetailPageState();
}

class _ExpensesDetailPageState extends State<ExpensesDetailPage> {
  List<CombinedModel> lstCombined = [];
  final _scrollController = ScrollController();
  double _offset = 0;

  void _listener() {
    setState(() {
      _offset = _scrollController.offset / 100;
      if (_offset > 0.89) _offset = 0.89;
    });
  }

  @override
  void initState() {
    _scrollController.addListener(_listener);
    lstCombined = context.read<ExpensesProvider>().allItemsList;
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_listener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dataDay = ModalRoute.of(context)!.settings.arguments as int?;

    final xProvider = context.read<ExpensesProvider>();
    final uiProvider = context.read<UIProvider>();
    // final lstCombined = xProvider.allItemsList;
    lstCombined = context.watch<ExpensesProvider>().allItemsList;

    double totExp = 0.0;
    if (dataDay != null) {
      lstCombined = lstCombined.where((e) => e.day == dataDay).toList();
    }

    totExp = lstCombined.map((e) => e.amount).fold(0, (a, b) => a + b);
    lstCombined.sort((a, b) => b.amount.compareTo(a.amount));

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 125,
            title: const Text('Desglose de gastos'),
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Align(
                alignment: Alignment(_offset, 1),
                child: Text(getAmountFormat(totExp)),
              ),
              centerTitle: true,
              background: const Align(
                alignment: Alignment.bottomCenter,
                child: Text('Total'),
              ),
            ),
          ),
          // Hacer parecer un borde en la parte superior de la Lista de gastos
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(top: 15),
              height: 40,
              color: const Color(0xff121212),
              child: Container(
                decoration: Constants.sheetBoxDecoration(
                  Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, i) {
                var v = lstCombined[i];
                return Slidable(
                  key: ValueKey(v),
                  startActionPane:
                      ActionPane(motion: const BehindMotion(), children: [
                    SlidableAction(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      icon: Icons.delete_outline_rounded,
                      label: 'Borrar',
                      onPressed: (context) {
                        setState(() {
                          lstCombined.removeAt(i);
                        });
                        xProvider.deleteExpense(v.id);
                        // uiProvider.notifyListeners();
                        uiProvider.bnbIndex = 0;
                        Fluttertoast.showToast(msg: 'Registro eliminado');
                      },
                    ),
                    SlidableAction(
                      backgroundColor: Colors.greenAccent,
                      foregroundColor: Colors.black,
                      icon: Icons.edit_outlined,
                      label: 'Editar',
                      onPressed: (context) {
                        Navigator.pushNamed(
                          context,
                          'add_expenses',
                          arguments: v,
                        );
                      },
                    ),
                  ]),
                  child: ListTile(
                    leading: Stack(
                      alignment: Alignment.center,
                      children: [
                        const Icon(Icons.calendar_today_outlined, size: 42),
                        Positioned(
                          top: 20,
                          child: Text(
                            '${v.day}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                    title: Row(
                      children: [
                        Icon(v.icon.toIcon(), color: v.color.toColor()),
                        const SizedBox(width: 8),
                        Text(v.category),
                      ],
                    ),
                    subtitle: Text(v.comment),
                    trailing: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          getAmountFormat(v.amount),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${((100 * v.amount) / totExp).toStringAsFixed(2)}%',
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: lstCombined.length,
            ),
          )
        ],
      ),
    );
  }
}
