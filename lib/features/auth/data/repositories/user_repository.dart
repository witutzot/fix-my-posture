import 'package:fix_my_posture/config/supabase_config.dart';
import 'package:fix_my_posture/core/repositories/base_repository.dart';
import 'package:fix_my_posture/features/auth/domain/models/user.dart';

class UserRepository implements BaseRepository<User> {
  final _client = SupabaseConfig.client;
  final _table = 'users';

  @override
  Future<List<User>> getAll() async {
    final response = await _client.from(_table).select();
    return response.map((json) => User.fromJson(json)).toList();
  }

  @override
  Future<User?> getById(String id) async {
    final response = await _client
        .from(_table)
        .select()
        .eq('id', id)
        .single();
    return response != null ? User.fromJson(response) : null;
  }

  @override
  Future<User> create(User user) async {
    final response = await _client
        .from(_table)
        .insert(user.toJson())
        .select()
        .single();
    return User.fromJson(response);
  }

  @override
  Future<User> update(User user) async {
    final response = await _client
        .from(_table)
        .update(user.toJson())
        .eq('id', user.id)
        .select()
        .single();
    return User.fromJson(response);
  }

  @override
  Future<void> delete(String id) async {
    await _client.from(_table).delete().eq('id', id);
  }

  Future<User?> getCurrentUser() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return null;
    return getById(userId);
  }
} 