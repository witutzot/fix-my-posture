import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout.freezed.dart';
part 'workout.g.dart';

@freezed
class Workout with _$Workout {
  const factory Workout({
    required String id,
    required String title,
    String? description,
    required int duration,
    required String difficulty,
    required String category,
    String? thumbnailUrl,
    String? videoUrl,
    required List<Exercise> exercises,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Workout;

  factory Workout.fromJson(Map<String, dynamic> json) => _$WorkoutFromJson(json);
}

@freezed
class Exercise with _$Exercise {
  const factory Exercise({
    required String name,
    required String description,
    required int duration,
    String? imageUrl,
    String? videoUrl,
  }) = _Exercise;

  factory Exercise.fromJson(Map<String, dynamic> json) => _$ExerciseFromJson(json);
} 