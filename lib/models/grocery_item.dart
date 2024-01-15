import 'package:flutter/material.dart';

// Importance is an enum that you’ll use to tag the importance of an item: low, medium or high.
enum Importance { low, medium, high }

class GroceryItem {
  // Each GroceryItem must have a unique id to differentiate the items from one other.
  final String id;

  // A user can set the name, level of importance, color label, quantity and date, as
  // well as marking completed items.
  final String name;
  final Importance importance;
  final Color color;
  final int quantity;
  final DateTime dateTime;
  final bool isComplete;

  GroceryItem({
    required this.id,
    required this.name,
    required this.importance,
    required this.color,
    required this.quantity,
    required this.dateTime,
    this.isComplete = false,
  });

  // copyWith copies and creates a completely new instance of GroceryItem. This
  // will be useful later, when you manage the state of the items.
  GroceryItem copyWith({
    String? id,
    String? name,
    Importance? importance,
    Color? color,
    int? quantity,
    DateTime? dateTime,
    bool? isComplete,
  }) {
    return GroceryItem(
      id: id ?? this.id,
      name: name ?? this.name,
      importance: importance ?? this.importance,
      color: color ?? this.color,
      quantity: quantity ?? this.quantity,
      dateTime: dateTime ?? this.dateTime,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}
