import 'package:flutter/material.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class PoliciesScreen extends StatelessWidget {
  const PoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Políticas y Condiciones',
          style: AppStyles.h2(
              color: AppColors.darkColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppSize.defaultPaddingHorizontal * 1.5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppSize.defaultPadding),
              _buildSection('1. Introducción',
                  'Bienvenido a Tours del Norte. Estas políticas y condiciones rigen el uso de nuestro servicio de alquiler de vehículos automotores. Al utilizar nuestros servicios, usted acepta cumplir con los términos y condiciones establecidos a continuación.'),
              _buildSection('2. Información de la Empresa',
                  'Tours del Norte es una microempresa de alquiler de vehículos automotores, ubicada en calle Bolognesi 626, Castilla, Piura. Fundada el 1 de mayo de 2020 por Juan Carlos Taboada García, la empresa ofrece una amplia variedad de vehículos que incluyen SUV, hatchbacks, crossovers, sedanes, coupés y minivans.'),
              _buildSection('3. Vehículos Disponibles',
                  'Nuestros clientes pueden elegir entre una selección diversa de vehículos, adaptados a distintas necesidades y preferencias. La flota inicial comenzó con un único vehículo y se ha expandido, especialmente durante la pandemia, con la adquisición de más unidades y la colaboración de nuevos socios.'),
              _buildSection('4. Uso del Servicio',
                  'Para utilizar nuestro servicio de alquiler de vehículos, los clientes deben cumplir con los siguientes requisitos:\n• Presentar una identificación válida.\n• Poseer una licencia de conducir vigente.\n• Cumplir con las condiciones de edad mínima establecidas por la empresa.'),
              _buildSection('5. Garantía de Alquiler',
                  'Es necesario proporcionar una garantía para el alquiler de los vehículos, la cual se depositará a una cuenta bancaria mediante POS. Esta cuenta bancaria no está vinculada directamente al propietario de la empresa, sino al banco. Los montos de la garantía son los siguientes:\n• Carros: S/ 1500\n• Camionetas: S/ 2000'),
              _buildSection('6. Límite de Kilometraje',
                  'El alquiler diario incluye un límite de 250 kilómetros de recorrido libre. Si el usuario supera este límite, se aplicará un cargo adicional de S/ 1.00 por cada kilómetro extra recorrido.'),
              _buildSection('7. Responsabilidades del Usuario',
                  'El usuario es responsable del cuidado y uso adecuado del vehículo durante el periodo de alquiler. Cualquier daño, pérdida o mal uso del vehículo será responsabilidad del arrendatario, quien deberá asumir los costos de reparación o reposición correspondientes.'),
              _buildSection('8. Condiciones de Pago',
                  'El pago del servicio de alquiler debe realizarse de acuerdo con las tarifas y condiciones establecidas al momento de la reserva. Tours del Norte se reserva el derecho de ajustar las tarifas y condiciones sin previo aviso.'),
              _buildSection('9. Cancelaciones y Modificaciones',
                  'Las políticas de cancelación y modificación de reservas están sujetas a las condiciones específicas de cada contrato de alquiler. Se recomienda a los clientes revisar detalladamente estas políticas antes de confirmar su reserva.'),
              _buildSection('10. Limitaciones de Responsabilidad',
                  'Tours del Norte no se responsabiliza por daños personales, pérdidas económicas, accidentes o cualquier otro incidente que ocurra durante el uso del vehículo alquilado. El cliente es responsable de contratar un seguro adicional si así lo desea.'),
              _buildSection('11. Modificaciones de las Políticas',
                  'Estas políticas y condiciones pueden ser modificadas por Tours del Norte en cualquier momento, y las modificaciones entrarán en vigor una vez publicadas en nuestro sitio web o comunicadas a los usuarios.'),
              _buildSection('12. Contacto',
                  'Para cualquier consulta o aclaración sobre nuestras políticas y condiciones, puede contactarnos en nuestra oficina ubicada en calle Bolognesi 626, Castilla, Piura, o a través de nuestro número de atención al cliente.'),
              _buildSection('13. Aceptación de las Políticas',
                  'Al utilizar nuestro servicio de alquiler de vehículos, usted reconoce haber leído, entendido y aceptado estas políticas y condiciones en su totalidad.'),
              SizedBox(height: AppSize.defaultPadding * 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppStyles.h3(fontWeight: FontWeight.bold)),
        SizedBox(height: AppSize.defaultPadding / 2),
        Text(content, style: AppStyles.h4()),
        SizedBox(height: AppSize.defaultPadding),
      ],
    );
  }
}
