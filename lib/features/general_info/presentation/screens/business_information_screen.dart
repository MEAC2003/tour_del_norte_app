import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tour_del_norte_app/core/config/app_router.dart';
import 'package:tour_del_norte_app/features/general_info/presentation/providers/information_provider.dart';
import 'package:tour_del_norte_app/features/general_info/presentation/widgets/widgets.dart';
import 'package:tour_del_norte_app/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class BusinessInformationScreen extends StatelessWidget {
  const BusinessInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 56.h,
        leading: IconButton(
          padding: EdgeInsets.symmetric(
              horizontal: AppSize.defaultPaddingHorizontal * 1.5),
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primaryGrey),
          onPressed: () {
            context.go(AppRouter.home);
          },
        ),
        centerTitle: true,
        title: Text(
          'Tour del Norte',
          style: AppStyles.h3(
            color: AppColors.primaryGrey,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: const _BusinessInformationView(),
      floatingActionButton: const FloatingActionButton(
        onPressed: _launchUrl,
        backgroundColor: AppColors.primaryColor,
        child: Icon(
          Icons.facebook,
          color: AppColors.primaryGrey,
        ),
      ),
    );
  }
}

class _BusinessInformationView extends StatefulWidget {
  const _BusinessInformationView();

  @override
  State<_BusinessInformationView> createState() =>
      _BusinessInformationViewState();
}

class _BusinessInformationViewState extends State<_BusinessInformationView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<InformationProvider>().loadInformation());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<InformationProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (provider.error != null) {
          return Center(child: Text('Error: ${provider.error}'));
        }
        if (provider.information == null) {
          return const Center(child: Text('No hay información disponible'));
        }

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: AppSize.defaultPadding * 2),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    AppAssets.logo,
                    width: 200.w,
                    height: 200.w,
                  ),
                ),
                MultiOptionButton(information: provider.information!),
              ],
            ),
          ),
        );
      },
    );
  }
}

final Uri _url = Uri.https('www.facebook.com', 'Tourdelnorte');
Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
