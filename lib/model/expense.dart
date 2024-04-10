import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();
final uuid = Uuid();

enum Category { food, travel, work, leisure }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.work: Icons.work,
  Category.leisure: Icons.movie,
};

class Expense {
  Expense(
      {required this.amount,
      required this.date,
      required this.title,
      required this.category})
      : id = uuid.v4();
  final String id;

  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get FormatedDate {
    return formatter.format(date);
  }
}
