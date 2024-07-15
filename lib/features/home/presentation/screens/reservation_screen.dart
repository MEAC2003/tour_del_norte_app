import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/scheduler.dart';
import 'package:tour_del_norte_app/features/home/data/models/booking.dart';
import 'package:tour_del_norte_app/features/home/data/models/car.dart';
import 'package:tour_del_norte_app/features/home/presentation/providers/booking_provider.dart';
import 'package:tour_del_norte_app/features/home/presentation/providers/car_provider.dart';
import 'package:tour_del_norte_app/features/home/presentation/widgets/widgets.dart';
import 'package:tour_del_norte_app/features/shared/shared.dart';
import 'package:tour_del_norte_app/features/users/presentation/providers/users_provider.dart';
import 'package:tour_del_norte_app/services/cloudinary_service.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class ReservationScreen extends StatefulWidget {
  final int carId;

  const ReservationScreen({super.key, required this.carId});

  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  // ignore: unused_field
  String? _imageUrl;
  List<DateTime> _disabledDates = [];
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
    _loadDisabledDates();
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
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final user = userProvider.user;

    if (user == null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'No se encontró información del usuario. Por favor, inicie sesión.')),
        );
      });
      return;
    }

    _fullNameController.text = user.fullName;
    _emailController.text = user.email;
    _phoneController.text = user.phone;
    _dniController.text = user.dni;

    _licenseImageUrl =
        user.license?.isNotEmpty == true ? user.license?.first : null;
    _imageUrl = _licenseImageUrl;

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

  Future<void> _loadDisabledDates() async {
    final bookingProvider =
        Provider.of<BookingProvider>(context, listen: false);
    final bookings = await bookingProvider.getBookingsForCar(widget.carId);

    setState(() {
      _disabledDates = bookings.expand((booking) {
        final days = booking.endDate.difference(booking.startDate).inDays;
        return List.generate(
            days + 1, (index) => booking.startDate.add(Duration(days: index)));
      }).toList();
    });
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
                controller:
                    TextEditingController(text: 'Vehículo: ${car?.name}'),
                hintText: 'Vehículo: ${car?.name}',
                obscureText: false,
                icon: const Icon(Icons.car_repair),
                readOnly: true,
              ),
              CustomTextField(
                controller: TextEditingController(
                    text: 'Precio: S/ ${car?.priceByDay}'),
                hintText: 'Precio: S/ ${car?.priceByDay}',
                obscureText: false,
                icon: const Icon(Icons.price_check_outlined),
                readOnly: true,
              ),
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
              SizedBox(height: AppSize.defaultPadding),
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
                  padding: EdgeInsets.symmetric(
                      vertical: AppSize.defaultPadding * 0.5),
                  child: Image.network(_licenseImageUrl!,
                      height: 100.w, width: 100.h),
                ),
              DateRange(
                initialStartDate: _startDate,
                initialEndDate: _endDate,
                disabledDates: _disabledDates,
                onDateTimeRangeSelected: (start, end) {
                  setState(() {
                    _startDate = start;
                    _endDate = end;
                  });
                },
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: AppSize.defaultPadding,
                  horizontal: AppSize.defaultPaddingHorizontal * 1.5,
                ),
                padding: EdgeInsets.all(AppSize.defaultPadding),
                decoration: BoxDecoration(
                  color: AppColors.primaryGrey,
                  borderRadius: BorderRadius.circular(AppSize.defaultRadius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Resumen de la reserva',
                      style: AppStyles.h3(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: AppSize.defaultPadding * 0.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Duración:',
                          style: AppStyles.h4(color: AppColors.darkColor),
                        ),
                        Text(
                          '${_calculateDays()} día(s)',
                          style: AppStyles.h4(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.defaultPadding * 0.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Precio por día:',
                          style: AppStyles.h4(color: AppColors.darkColor),
                        ),
                        Text(
                          'S/ ${car?.priceByDay ?? 0}',
                          style: AppStyles.h4(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: AppColors.primaryColor.withOpacity(0.5),
                      thickness: 1,
                      height: AppSize.defaultPadding,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total:',
                          style: AppStyles.h3(
                            color: AppColors.darkColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'S/ ${_calculateTotal(car)}',
                          style: AppStyles.h3(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              CustomCTAButton(
                text: 'Confirmar Reserva',
                onPressed: () async {
                  if (_formKey.currentState!.validate() &&
                      _licenseImageUrl != null) {
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

                    bool accepted = await _showReservationPolicyModal(
                        context, booking, car!);
                    if (accepted) {
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
              SizedBox(height: AppSize.defaultPadding * 0.8),
            ],
          ),
        ),
      ),
    );
  }

  int _calculateDays() {
    // Calculate the difference in hours
    int hours = _endDate.difference(_startDate).inHours;

    // Round up to the nearest day
    return (hours / 24).ceil();
  }

  int _calculateTotal(Car? car) {
    if (car == null) return 0;
    return car.priceByDay * _calculateDays();
  }
}

String generateWhatsAppLink(String phoneNumber, Booking booking, Car car) {
  final message = Uri.encodeComponent('Nueva reserva:\n'
      'Nombre: ${booking.fullName}\n'
      'Email: ${booking.email}\n'
      'Teléfono: ${booking.phone}\n'
      'DNI: ${booking.dni}\n'
      'Vehículo: ${car.name}\n'
      'Fecha inicio: ${booking.startDate.toString().split(' ')[0]}\n'
      'Fecha fin: ${booking.endDate.toString().split(' ')[0]}\n'
      'Días: ${booking.qtyDays}\n'
      'Total: S/ ${booking.total}');
  return 'https://wa.me/$phoneNumber?text=$message';
}

Future<bool> _showReservationPolicyModal(
    BuildContext context, Booking booking, Car car) async {
  int garantia = car.idCarType == 1 ? 1500 : 2000;
  return await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Política de Reserva y Ubicación',
                style: AppStyles.h3(fontWeight: FontWeight.bold)),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      'Por favor, lea atentamente nuestra política de reserva:',
                      style: AppStyles.h3()),
                  const SizedBox(height: 10),
                  Text(
                      '1. Tiene 10 minutos para realizar el depósito de la reserva.',
                      style: AppStyles.h3(fontWeight: FontWeight.bold)),
                  Text(
                      '2. El depósito debe realizarse a una de las siguientes cuentas:',
                      style: AppStyles.h3(fontWeight: FontWeight.bold)),
                  Text('   Banco: BBVA (interbancaria)', style: AppStyles.h3()),
                  Text('   Cuenta: 00247510681626106921',
                      style: AppStyles.h3()),
                  Text('   Banco: BCP', style: AppStyles.h3()),
                  Text('   Cuenta: 47506816261069', style: AppStyles.h3()),
                  Text('   Yape o Plin: 983815949', style: AppStyles.h3()),
                  Text(
                      '3. Si no se realiza el depósito en el tiempo establecido, la reserva será cancelada.',
                      style: AppStyles.h3(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Text('4. Se debe pagar una garantía de S/ $garantia.',
                      style: AppStyles.h3(fontWeight: FontWeight.bold)),
                  Text(
                      'Esta garantía se deposita en una cuenta administrada por una entidad de seguros independiente, no por el propietario del vehículo.',
                      style: AppStyles.h3()),
                  const SizedBox(height: 20),
                  Text('Ubicación de recojo y devolución:',
                      style: AppStyles.h3(fontWeight: FontWeight.bold)),
                  Text('Francisco Bolognesi 626, Piura, Perú',
                      style: AppStyles.h3()),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _launchMaps,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.primaryColor,
                    ),
                    child: const Text('Ver ubicación'),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancelar', style: AppStyles.h4(color: Colors.red)),
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
              TextButton(
                child: Text(
                    'Aceptar y Enviar la reserva por WhatsApp(Para una pronto respuesta)',
                    style: AppStyles.h4(color: Colors.green)),
                onPressed: () async {
                  final whatsappLink =
                      generateWhatsAppLink('918402962', booking, car);
                  final Uri whatsappUri = Uri.parse(whatsappLink);
                  try {
                    if (await launchUrl(whatsappUri,
                        mode: LaunchMode.externalApplication)) {
                      // El enlace se lanzó correctamente
                    } else {
                      throw Exception('No se pudo abrir WhatsApp');
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Error: No se pudo abrir WhatsApp')),
                    );
                  }
                  // Agregamos esta línea para guardar la reserva y cerrar el diálogo
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        },
      ) ??
      false;
}

Future<void> _launchMaps() async {
  final Uri url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=-5.2052586,-80.619869');

  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw 'No se pudo abrir el mapa: $url';
  }
}
