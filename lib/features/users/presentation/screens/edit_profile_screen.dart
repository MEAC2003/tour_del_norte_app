// edit_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tour_del_norte_app/features/auth/presentation/widgets/widgets.dart';
import 'package:tour_del_norte_app/features/shared/shared.dart';
import 'package:tour_del_norte_app/features/users/presentation/providers/users_provider.dart';
import 'package:tour_del_norte_app/services/cloudinary_service.dart';
import 'package:tour_del_norte_app/utils/utils.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? _imageUrl;
  late TextEditingController _fullNameController;
  late final String _email;
  late TextEditingController _phoneController;
  late TextEditingController _dniController;
  final CloudinaryService _cloudinaryService = CloudinaryService();

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user!;
    _fullNameController = TextEditingController(text: user.fullName);
    _email = user.email;
    _phoneController = TextEditingController(text: user.phone);
    _dniController = TextEditingController(text: user.dni);
    _imageUrl = user.license?.isNotEmpty == true ? user.license!.first : null;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _dniController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final url = await _cloudinaryService.uploadImage();
    if (url != null) {
      setState(() {
        _imageUrl = url;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.symmetric(
              horizontal: AppSize.defaultPaddingHorizontal * 1.5.w),
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: Text(
          'Editar Perfil',
          style: AppStyles.h2(
            color: AppColors.darkColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSize.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              controller: _fullNameController,
              hintText: 'Nombre completo',
              icon: const Icon(Icons.person),
              obscureText: false,
            ),
            SizedBox(height: AppSize.defaultPadding),
            CustomTextField(
              hintText: _email,
              icon: const Icon(Icons.email),
              readOnly: true,
            ),
            SizedBox(height: AppSize.defaultPadding),
            CustomTextField(
              controller: _phoneController,
              hintText: 'Número de teléfono',
              icon: const Icon(Icons.phone),
            ),
            SizedBox(height: AppSize.defaultPadding),
            CustomTextField(
              controller: _dniController,
              hintText: 'DNI',
              icon: const Icon(Icons.badge),
            ),
            SizedBox(height: AppSize.defaultPadding),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSize.defaultPaddingHorizontal * 1.5),
              child: ElevatedButton(
                onPressed: _pickImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.defaultRadius),
                  ),
                  minimumSize: Size.fromHeight(50.h),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.upload_file, color: AppColors.primaryGrey),
                    SizedBox(width: 10.w),
                    Text(
                      'Subir brevete',
                      style: AppStyles.h4(
                        color: AppColors.primaryGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_imageUrl != null)
              Padding(
                padding: EdgeInsets.symmetric(vertical: AppSize.defaultPadding),
                child: Image.network(_imageUrl!, height: 100.w, width: 100.h),
              ),
            SizedBox(height: AppSize.defaultPadding),
            CustomUserActionButton(
              text: 'Guardar cambios',
              onPressed: () {
                final userProvider =
                    Provider.of<UserProvider>(context, listen: false);
                final updatedUser = userProvider.user!.copyWith(
                  fullName: _fullNameController.text,
                  phone: _phoneController.text,
                  dni: _dniController.text,
                  license: _imageUrl != null ? [_imageUrl!] : null,
                );
                userProvider.updateUser(updatedUser);
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
