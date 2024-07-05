import 'package:tour_del_norte_app/features/users/data/datasources/supabase_users_data_source.dart';
import 'package:tour_del_norte_app/features/users/data/models/public_user.dart';
import 'users_repository.dart';

class UsersRepositoryImpl implements UsersRepository {
  final SupabaseUsersDataSource _dataSource;

  UsersRepositoryImpl(this._dataSource);

  @override
  Future<PublicUser?> getCurrentUser() => _dataSource.getCurrentUser();

  @override
  Future<void> updateUser(PublicUser user) async {
    await _dataSource.updateUser(user);
  }
}
