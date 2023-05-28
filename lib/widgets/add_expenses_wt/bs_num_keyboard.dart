import 'package:expenses/models/combined_model.dart';
import 'package:expenses/utils/constants.dart';
import 'package:flutter/material.dart';

class BSNumKeyboardWidget extends StatefulWidget {
  final CombinedModel cModel;
  const BSNumKeyboardWidget({super.key, required this.cModel});

  @override
  State<BSNumKeyboardWidget> createState() => _BSNumKeyboardWidgetState();
}

class _BSNumKeyboardWidgetState extends State<BSNumKeyboardWidget> {
  String import = '0.00';

  @override
  void initState() {
    import = widget.cModel.amount.toStringAsFixed(2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    mathFunc(Match match) => '${match[1]},';

    return GestureDetector(
      onTap: _numpad,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            const Text('Cantidad Ingresada'),
            Text(
              '\$ ${import.replaceAllMapped(reg, mathFunc)}',
              style: const TextStyle(
                fontSize: 30,
                letterSpacing: 2.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _numpad() {
    expensesChange(String amount) {
      if (amount == '') amount = '0.00';
      widget.cModel.amount = double.parse(amount);
    }

    if (import == '0.00') import = '';
    num(String text, double height) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            import += text;
            widget.cModel.amount = double.parse(import);
          });
        },
        child: SizedBox(
          height: height,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 35,
              ),
            ),
          ),
        ),
      );
    }

    showModalBottomSheet(
      barrierColor: Colors.transparent,
      // isDismissible: false,
      // enableDrag: false,
      // isScrollControlled: true, //controlar el tamaño por nosotros y no el modal
      context: context,
      builder: (_) {
        return WillPopScope(
          onWillPop: () async => false,
          child: SizedBox(
            height: 350,
            child:
                LayoutBuilder(builder: (BuildContext cxt, BoxConstraints bct) {
              var height = bct.biggest.height / 5;
              return Column(
                children: [
                  Table(
                    border: TableBorder.symmetric(
                      inside: const BorderSide(
                        color: Colors.grey,
                        width: 0.1,
                      ),
                    ),
                    children: [
                      TableRow(children: [
                        num('1', height),
                        num('2', height),
                        num('3', height),
                      ]),
                      TableRow(children: [
                        num('4', height),
                        num('5', height),
                        num('6', height),
                      ]),
                      TableRow(children: [
                        num('7', height),
                        num('8', height),
                        num('9', height),
                      ]),
                      TableRow(children: [
                        num('.', height),
                        num('0', height),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (import.length > 0.0) {
                                import = import.substring(0, import.length - 1);
                                widget.cModel.amount = double.parse(import);
                                expensesChange(import);
                              }
                            });
                          },
                          onLongPress: () => {
                            setState(() => import = ''),
                            expensesChange(import)
                          },
                          behavior: HitTestBehavior.opaque,
                          child: SizedBox(
                            height: height,
                            child: const Icon(
                              Icons.backspace_outlined,
                            ),
                          ),
                        )
                      ]),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          child: Constants.customButton(
                            Colors.transparent,
                            Colors.red,
                            'CANCELAR',
                          ),
                          onTap: () {
                            setState(() {
                              import = '0.00';
                              // widget.cModel.amount = double.parse(import);
                              expensesChange(import);
                              Navigator.pop(context);
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          child: Constants.customButton(
                            Colors.green,
                            Colors.transparent,
                            'ACEPTAR',
                          ),
                          onTap: () {
                            setState(() {
                              if (import.length == 0.0) import = '0.00';
                              expensesChange(import);
                              Navigator.pop(context);
                            });
                          },
                        ),
                      ),
                    ],
                  )
                ],
              );
            }),
          ),
        );
      },
    );
  }
}
