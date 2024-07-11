import 'package:flutter/material.dart';
import 'package:tour_del_norte_app/features/settings/presentation/widgets/widgets.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.symmetric(
              horizontal: AppSize.defaultPaddingHorizontal * 1.5.w),
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'Preguntas Frecuentes',
          style: AppStyles.h2(
              color: AppColors.darkColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: const _FAQView(),
    );
  }
}

class _FAQView extends StatelessWidget {
  const _FAQView();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppSize.defaultPaddingHorizontal * 1.5.w),
            child: Divider(
              color: AppColors.darkColor50,
              thickness: 0.5.h,
            ),
          ),
          SizedBox(
            height: AppSize.defaultPadding / 1.5.h,
          ),
          const CustomExpansion(
            title:
                '¿Cómo puedo reservar un vehículo a través de la aplicación?',
            body:
                'Puedes reservar un vehículo fácilmente a través de nuestra aplicación siguiendo estos pasos:\n'
                '• Inicia sesión en tu cuenta o crea una nueva si es tu primera vez.\n'
                '• Elige el tipo de vehículo que deseas alquilar y verifica la disponibilidad.\n'
                '• Rellena tus datos y selecciona la fecha y hora de recogida y devolución del vehículo.\n'
                '• Completa el proceso de reserva dando clic en el botón Consultar Reserva.\n'
                '• Espere a ser contactado por un encargado.',
          ),
          const CustomExpansion(
            title: '¿Qué documentos necesito para realizar una reserva?',
            body: 'Para realizar una reserva necesitas:\n'
                '• Licencia de conducir válida y vigente.\n'
                '• Documento de identidad oficial (DNI o pasaporte) en el caso de clientes internacionales.',
          ),
          const CustomExpansion(
            title: '¿Qué incluye el costo del alquiler del vehículo?',
            body: 'El costo del alquiler incluye:\n'
                '• El uso del vehículo durante el período especificado.\n'
                '• Seguro Obligatorio de Accidentes de Tránsito (SOAT)',
          ),
          const CustomExpansion(
            title:
                '¿Cuáles son las políticas de seguro para los vehículos alquilados?',
            body:
                'Ofrecemos diferentes opciones de seguro que pueden incluir:\n'
                '• Seguro Obligatorio de Accidentes de Tránsito (SOAT)\n'
                '• Cobertura de accidentes personales.',
          ),
          const CustomExpansion(
            title: '¿Dónde puedo recoger y devolver el vehículo?',
            body:
                'Puedes recoger y devolver el vehículo en nuestras instalaciones ubicadas en:\n'
                '• Dirección: Calle Bolognesi 626, Castilla, Piura.\n'
                '• Lugar de preferencia previa coordinación.\n'
                '• Horario de atención: De lunes a domingo, de 8:00 AM a 6:00 PM.',
          ),
          const CustomExpansion(
            title:
                '¿Hay cargos adicionales por kilómetro o por días de alquiler adicionales?',
            body:
                'Sí, pueden aplicarse cargos adicionales por kilómetro extra o por días de alquiler adicionales, dependiendo de las condiciones del contrato y la política de la empresa.',
          ),
          const CustomExpansion(
            title:
                '¿Cómo puedo contactar al servicio al cliente si tengo problemas durante mi alquiler?',
            body: 'Puedes contactar a nuestro servicio al cliente:\n'
                '• Teléfono: +51 978 712 299\n'
                '• WhatsApp: 978 712 299',
          ),
          const CustomExpansion(
            title:
                '¿Qué tipos de vehículos están disponibles para alquilar y cuáles son sus características?',
            body: 'Ofrecemos una variedad de vehículos que incluyen:\n'
                '• SUV, hatchbacks, crossovers, sedanes, coupés y minivans.\n'
                '• Cada tipo de vehículo tiene características específicas detalladas en la aplicación.',
          ),
          const CustomExpansion(
            title: '¿Hay opciones de alquiler a largo plazo disponibles?',
            body:
                'Sí, ofrecemos opciones de alquiler a largo plazo que pueden ser personalizadas según tus necesidades específicas. Contacta a nuestro equipo para más detalles al Teléfono: +51 978 712 299',
          ),
          const CustomExpansion(
            title:
                '¿Cómo puedo proporcionar comentarios o sugerencias sobre mi experiencia con la aplicación y el servicio de alquiler?',
            body:
                'Valoramos tus comentarios y sugerencias. Puedes proporcionarlos:\n'
                '• A través de nuestra página de Facebook "Tour del norte"',
          ),
        ],
      ),
    );
  }
}
