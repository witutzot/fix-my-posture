import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    String? fullName,
    String? avatarUrl,
    @Default({}) Map<String, dynamic> preferences,
    @Default(0) int currentStreak,
    @Default(0) int totalPoints,
    @Default(0) int monthlyPoints,
    @Default('Novice Sloucher') String prestigeLevel,
    DateTime? lastWorkoutDate,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
} 