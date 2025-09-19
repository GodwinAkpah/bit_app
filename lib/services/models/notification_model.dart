import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationModel {
  final int id;
  final String type;
  final String message;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.type,
    required this.message,
    required this.createdAt,
  });

  // A factory constructor to create a NotificationModel from JSON
  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'],
      type: map['type'] ?? 'general',
      message: map['message'] ?? 'No message content.',
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  // --- UI Helper Getters ---

  /// Provides a user-friendly title based on the notification type.
  String get title {
    switch (type) {
      case 'registration':
        return 'Account Setup Successful!';
      case 'login':
        return 'Successful Login';
      case 'password_updated':
        return 'Password Updated!';
      case 'profile_updated':
        return 'Profile Updated!';
      default:
        return 'New Notification';
    }
  }

  /// Provides a specific icon based on the notification type.
  IconData get icon {
    switch (type) {
      case 'registration':
      case 'profile_updated':
        return Icons.check_circle_outline;
      case 'password_updated':
        return Icons.lock_outline;
      case 'login':
        return Icons.login_outlined;
      default:
        return Icons.notifications_none;
    }
  }

  /// Provides a background color for the icon based on the type.
  Color get iconBackgroundColor {
    // You can customize these colors
    switch (type) {
      case 'registration':
      case 'profile_updated':
        return const Color(0xFFEAFBF2); // Light Green
      case 'password_updated':
        return const Color(0xFFFFF0E9); // Light Orange
      default:
        return const Color(0xFFE3F2FD); // Light Blue
    }
  }
  
  /// Formats the date and time for display.
  String get formattedTimestamp {
    return DateFormat('dd MMM. yyyy | hh:mma').format(createdAt);
  }
}