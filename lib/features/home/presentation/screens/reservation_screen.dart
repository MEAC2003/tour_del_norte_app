import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:tour_del_norte_app/features/home/data/models/booking.dart';
import 'package:tour_del_norte_app/features/home/data/models/car.dart';
import 'package:tour_del_norte_app/features/home/presentation/providers/booking_provider.dart';
import 'package:tour_del_norte_app/features/home/presentation/providers/car_provider.dart';
import 'package:tour_del_norte_app/features/home/presentation/widgets/widgets.dart';
import 'package:tour_del_norte_app/features/shared/shared.dart';
import 'package:tour_del_norte_app/features/users/presentation/providers/users_provider.dart';
import 'package:tour_del_norte_app/services/cloudinary_service.dart';
import 'package:tour_del_norte_app/utils/utils.dart';
import 'package:flutter/scheduler.dart';

class ReservationScreen extends StatefulWidget {
  final int carId;

  const ReservationScreen({super.key, required this.carId});

  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  String? _imageUrl;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _dniController;

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(hours: 1));

  String? _licenseImageUrl;
  final CloudinaryService _cloudinaryService = CloudinaryService();

  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _dniController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _initializeUserData();
      _isInitialized = true;
    }
  }

  void _initializeUserData() {
    print('Initializing user data in ReservationScreen');
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    print('UserProvider: $userProvider');
    print('Is loading: ${userProvider.isLoading}');
    print('Error: ${userProvider.error}');

    final user = userProvider.user;
    print('User: ${user?.toJson()}');

    if (user == null) {
      print('User is null, showing error message');
      SchedulerBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'No se encontró información del usuario. Por favor, inicie sesión.')),
        );
      });
      return;
    }

    print('Setting user data to form fields');
    _fullNameController.text = user.fullName ?? '';
    _emailController.text = user.email ?? '';
    _phoneController.text = user.phone ?? '';
    _dniController.text = user.dni ?? '';

    _licenseImageUrl =
        user.license?.isNotEmpty == true ? user.license?.first : null;
    _imageUrl = _licenseImageUrl;

    print('User data initialized');
    setState(() {}); // Actualizar la UI con los datos del usuario
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dniController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final url = await _cloudinaryService.uploadImage();
    if (url != null) {
      setState(() {
        _imageUrl = url;
        _licenseImageUrl = url;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    final car = context.read<CarProvider>().getCarById(widget.carId);
    final bookingProvider = context.read<BookingProvider>();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 56.h,
        leading: IconButton(
          padding: EdgeInsets.symmetric(
              horizontal: AppSize.defaultPaddingHorizontal * 1.5),
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primaryGrey),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: Text(
          'Información',
          style: AppStyles.h3(
            color: AppColors.primaryGrey,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: AppSize.defaultPadding),
              CustomTextField(
                controller: _fullNameController,
                hintText: 'Nombre completo',
                obscureText: false,
                icon: const Icon(Icons.person),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su nombre completo';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: _emailController,
                hintText: 'Email',
                obscureText: false,
                icon: const Icon(Icons.email_outlined),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su email';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: _phoneController,
                hintText: 'Teléfono',
                obscureText: false,
                icon: const Icon(Icons.phone),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su teléfono';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: _dniController,
                hintText: 'DNI',
                obscureText: false,
                icon: const Icon(Icons.badge_outlined),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su DNI';
                  }
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppSize.defaultPaddingHorizontal * 1.5),
                child: ElevatedButton(
                  onPressed: _pickImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppSize.defaultRadius),
                    ),
                    minimumSize: Size.fromHeight(50.h),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.upload_file,
                          color: AppColors.primaryGrey),
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
              if (_licenseImageUrl != null)
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: AppSize.defaultPadding),
                  child: Image.network(_licenseImageUrl!,
                      height: 100.w, width: 100.h),
                ),
              DateRange(
                initialStartDate: _startDate,
                initialEndDate: _endDate,
                onDateTimeRangeSelected: (start, end) {
                  setState(() {
                    _startDate = start;
                    _endDate = end;
                  });
                },
              ),
              Text('Días: ${_calculateDays()}'),
              Text('Total: \$${_calculateTotal(car)}'),
              CustomCTAButton(
                text: 'Confirmar Reserva',
                onPressed: () async {
                  if (_formKey.currentState!.validate() &&
                      _licenseImageUrl != null) {
                    bool accepted = await _showReservationPolicyModal(context);
                    if (!accepted) {
                      return; // Si no acepta la política de reserva, no se crea la reserva y se cierra el modal
                    }

                    if (user == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('No se encontró información del usuario')),
                      );
                      return;
                    }
                    final booking = Booking(
                      fullName: _fullNameController.text,
                      email: _emailController.text,
                      phone: _phoneController.text,
                      dni: _dniController.text,
                      license: _licenseImageUrl ?? '',
                      idCar: widget.carId,
                      startDate: _startDate,
                      endDate: _endDate,
                      qtyDays: _calculateDays(),
                      total: _calculateTotal(car),
                      idUser: user.id,
                    );

                    try {
                      await bookingProvider.createBooking(booking);
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Reserva creada con éxito')),
                        );
                      });
                      context.pop();
                    } catch (e) {
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Error al crear la reserva: $e')),
                        );
                      });
                    }
                  } else if (_licenseImageUrl == null) {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Por favor, suba una imagen de su brevete')),
                      );
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _calculateDays() {
    return _endDate.difference(_startDate).inDays + 1;
  }

  int _calculateTotal(Car? car) {
    if (car == null) return 0;
    return car.priceByDay * _calculateDays();
  }
}

Future<bool> _showReservationPolicyModal(BuildContext context) async {
  return await showDialog<bool>(
        context: context,
        barrierDismissible: false, // Prevent closing by tapping outside
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Política de Reserva',
                style: AppStyles.h3(fontWeight: FontWeight.bold)),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      'Por favor, lea atentamente nuestra política de reserva:',
                      style: AppStyles.h3()),
                  const SizedBox(height: 10),
                  Text(
                      '1. Tiene 24 horas para realizar el depósito de la reserva.',
                      style: AppStyles.h3()),
                  Text(
                      '2. El depósito debe realizarse a la siguiente cuenta bancaria:',
                      style: AppStyles.h3()),
                  Text('   Banco: XXXX', style: AppStyles.h3()),
                  Text('   Cuenta: XXXX-XXXX-XXXX-XXXX', style: AppStyles.h3()),
                  Text(
                      '3. El monto del depósito es el 30% del total de la reserva.',
                      style: AppStyles.h3()),
                  Text(
                      '4. Si no se realiza el depósito en el tiempo establecido, la reserva será cancelada automáticamente.',
                      style: AppStyles.h3()),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancelar',
                    style: AppStyles.h4(
                        color: Colors.red)), // Cambiado a rojo para visibilidad
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Text('Aceptar',
                    style: AppStyles.h4(color: AppColors.primaryColor)),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        },
      ) ??
      false; // Provide a default value if null is returned
}
