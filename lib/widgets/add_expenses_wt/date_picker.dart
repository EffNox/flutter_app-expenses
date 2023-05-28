import 'package:expenses/models/combined_model.dart';
import 'package:flutter/material.dart';

class DatePickerWidget extends StatefulWidget {
  final CombinedModel cModel;
  const DatePickerWidget({Key? key, required this.cModel}) : super(key: key);

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  String selectedDay = 'Hoy';

  @override
  void initState() {
    if (widget.cModel.day == 0) {
      widget.cModel.year = DateTime.now().year;
      widget.cModel.month = DateTime.now().month;
      widget.cModel.day = DateTime.now().day;
    } else {
      selectedDay = 'Otro día';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    var widgets = <Widget>[
      const Icon(Icons.calendar_month_outlined, size: 35),
      const SizedBox(width: 4),
    ];

    calendar() {
      showDatePicker(
        context: context,
        initialDate: date.subtract(const Duration(days: 2)),
        // firstDate: date.subtract(const Duration(days: 30)),
        firstDate: date.subtract(const Duration(days: 120)),
        lastDate: date.subtract(const Duration(days: 2)),
        locale: const Locale('es', 'ES'),
      ).then((value) => {
            setState(() {
              if (value != null) {
                widget.cModel.year = value.year;
                widget.cModel.month = value.month;
                widget.cModel.day = value.day;
              } else {
                setState(() {
                  selectedDay = 'Hoy';
                });
              }
            })
          });
    }

    Map<String, DateTime> items = {
      'Hoy': date,
      'Ayer': date.subtract(const Duration(hours: 24)),
      'Otro día': date
    };

    items.forEach(
      (name, date) {
        widgets.add(Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedDay = name;
                widget.cModel.year = date.year;
                widget.cModel.month = date.month;
                widget.cModel.day = date.day;
                if (name == 'Otro día') calendar();
              });
            },
            child: DateContainWidget(
              cModel: widget.cModel,
              name: name,
              isSelected: name == selectedDay,
            ),
          ),
        ));
      },
    );

    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        children: widgets,
      ),
    );
  }
}

class DateContainWidget extends StatelessWidget {
  final CombinedModel cModel;
  final String name;
  final bool isSelected;
  const DateContainWidget(
      {Key? key,
      required this.cModel,
      required this.name,
      required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.green
                  : Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(child: Text(name)),
          ),
        ),
        isSelected
            ? FittedBox(
                fit: BoxFit.fitWidth,
                child: Text('${cModel.year}-${cModel.month}-${cModel.day}'),
              )
            : const Text('')
      ],
    );
  }
}
