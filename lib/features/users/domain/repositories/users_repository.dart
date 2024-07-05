import 'package:tour_del_norte_app/features/users/data/models/public_user.dart';

abstract class UsersRepository {
  Future<PublicUser?> getCurrentUser();
  Future<void> updateUser(PublicUser user);
}
