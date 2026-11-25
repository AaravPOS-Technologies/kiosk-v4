import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk_app/core/utils/navigation_utils.dart';
import 'package:kiosk_app/features/book_appointment/bloc/book_appointment_bloc.dart';
import 'package:kiosk_app/features/book_appointment/data/book_appointment_datasource.dart';
import 'package:kiosk_app/features/book_appointment/data/book_appointment_repo.dart';
import 'package:kiosk_app/features/book_appointment/screens/add_service_screen.dart';
import 'package:kiosk_app/features/book_appointment/screens/select_service_screen.dart';
import 'package:kiosk_app/features/book_appointment/widgets/choose_service_card.dart';
import 'package:kiosk_app/features/book_appointment/widgets/service_professional_card.dart';
import 'package:kiosk_app/shared/widgets/appbar_widget.dart';

class SelectProfetionalsScreen extends StatefulWidget {
  const SelectProfetionalsScreen({super.key});

  @override
  State<SelectProfetionalsScreen> createState() => _SelectProfetionalsScreenState();
}

class _SelectProfetionalsScreenState extends State<SelectProfetionalsScreen> {
  final BookAppointmentBloc _bloc = BookAppointmentBloc(
    repository: BookAppointmentRepository(
      datasource: BookAppointmentDatasource(),
    ),
  );

  @override
  void initState() {
    super.initState();
    _loadServiceProfessionals();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  /// call api for get service professionals
  _loadServiceProfessionals() {
    _bloc.add(
      ServiceProfessionalListEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Choose a professional',
      ),
      body: BlocBuilder<BookAppointmentBloc, BookAppointmentState>(
        bloc: _bloc,
        builder: (context, state) {
          debugPrint(
            'BUILD CALLED: ${state.professionalsList.length}',
          );

          return LayoutBuilder(
            builder: (context, constraints) {
              debugPrint('Available width: ${constraints.maxWidth}');
              debugPrint('Available height: ${constraints.maxHeight}');

              return Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Center(
                    child: Wrap(
                      // alignment: WrapAlignment.center,
                      // runAlignment: WrapAlignment.center,
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        // choose service first card
                        GestureDetector(
                            onTap: () => NavigationUtils.push(context, SelectServiceScreen()),
                            child: ChooseServiceCard()),

                        // professionals list
                        ...List.generate(
                          state.professionalsList.length,
                          (index) {
                            final item = state.professionalsList[index];
                            return ServiceProfessionalCard(
                              item: item,
                              onTap: () => NavigationUtils.push(
                                  context,
                                  AddServiceScreen(
                                    professional: item,
                                  )),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
