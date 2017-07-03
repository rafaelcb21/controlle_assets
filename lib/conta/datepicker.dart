//import 'dart:async';
//import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
//
//class DatePicker extends StatelessWidget {
//  const DatePicker({
//    Key key,
//    this.labelText,
//    this.selectedDate,
//    this.selectDate
//  }) : super(key: key);
//
//  final String labelText;
//  final DateTime selectedDate;
//  final ValueChanged<DateTime> selectDate;
//
//  Future<Null> _selectDate(BuildContext context) async {
//    final DateTime picked = await showDatePicker(
//      context: context,
//      initialDate: selectedDate,
//      firstDate: new DateTime(2015, 8),
//      lastDate: new DateTime(2101)
//    );
//    if (picked != null && picked != selectedDate)
//      selectDate(picked);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    final TextStyle valueStyle = Theme.of(context).textTheme.title;
//    return new Row(
//      crossAxisAlignment: CrossAxisAlignment.end,
//      children: <Widget>[
//        new Expanded(
//          flex: 4,
//          child: new _InputDropdown(
//            labelText: labelText,
//            valueText: new DateFormat.yMMMd().format(selectedDate),
//            valueStyle: valueStyle,
//            onPressed: () { _selectDate(context); },
//          ),
//        ),
//        const SizedBox(width: 12.0),
//      ],
//    );
//  }
//}