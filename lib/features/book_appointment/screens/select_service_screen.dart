import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk_app/core/constants/color_constants.dart';
import 'package:kiosk_app/core/constants/text_style_constants.dart';
import 'package:kiosk_app/core/utils/extensions.dart';
import 'package:kiosk_app/core/utils/size_utils.dart';
import 'package:kiosk_app/features/book_appointment/bloc/book_appointment_bloc.dart';
import 'package:kiosk_app/features/book_appointment/data/book_appointment_datasource.dart';
import 'package:kiosk_app/features/book_appointment/data/book_appointment_repo.dart';
import 'package:kiosk_app/features/book_appointment/model/services_model.dart';
import 'package:kiosk_app/features/book_appointment/widgets/service_group_widget.dart';
import 'package:kiosk_app/shared/widgets/appbar_widget.dart';

class SelectServiceScreen extends StatefulWidget {
  const SelectServiceScreen({super.key});

  @override
  State<SelectServiceScreen> createState() => _SelectServiceScreenState();
}

class _SelectServiceScreenState extends State<SelectServiceScreen> {
  late final BookAppointmentBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BookAppointmentBloc(
      repository: BookAppointmentRepository(
        datasource: BookAppointmentDatasource(),
      ),
    );
    _bloc.add(LoadServicesEvent());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocBuilder<BookAppointmentBloc, BookAppointmentState>(
        builder: (context, state) {
          final isShowingServices = state.showServices == true;

          return PopScope(
            canPop: !isShowingServices,
            onPopInvokedWithResult: (didPop, result) {
              if (didPop) return;
              if (isShowingServices) {
                _bloc.add(BackToCategoriesEvent());
              }
            },
            child: Scaffold(
              backgroundColor: ColorConstants.scaffoldBackgroundColor,
              appBar: CommonAppBar(
                title: "Choose a services",
                onBackPressed: () {
                  if (isShowingServices) {
                    _bloc.add(BackToCategoriesEvent());
                  } else {
                    Navigator.maybePop(context);
                  }
                },
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: ColorConstants.textPrimaryColor,
                      size: 22,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              body: _buildBody(context, state),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, BookAppointmentState state) {
    if (state.isLoading == true) {
      return const Center(
        child: CircularProgressIndicator(
          color: ColorConstants.primaryColor,
        ),
      );
    }

    if (state.errorMessage?.isNotEmpty == true) {
      return Center(
        child: Text(
          state.errorMessage ?? '',
          style: TextStyleConstants.error(),
        ),
      );
    }

    if (state.showServices == true) {
      return _buildServicesView(context, state);
    }

    return _buildCategorySelectionView(context, state);
  }

  // CATEGORY SELECTION VIEW
  Widget _buildCategorySelectionView(
    BuildContext context,
    BookAppointmentState state,
  ) {
    final isTablet = SizeUtils.isTablet(context);

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 24 : 16,
        vertical: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SUPER CATEGORY',
            style: TextStyleConstants.label(size: 14).copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          10.height,
          _buildCategoryGrid(
            context,
            state.superCategories ?? [],
          ),
          32.height,
          Text(
            'STANDALONE CATEGORY',
            style: TextStyleConstants.label(size: 14).copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          10.height,
          _buildCategoryGrid(
            context,
            state.standaloneCategories ?? [],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryGrid(
    BuildContext context,
    List<ServiceCategoryModel> categories,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 12.0;
        final isTablet = SizeUtils.isTablet(context);
        final columns = isTablet ? 3 : 2;

        final cardWidth = (constraints.maxWidth - (spacing * (columns - 1))) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: List.generate(
            categories.length,
            (index) {
              final category = categories[index];

              return InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  _bloc.add(SelectCategory(category.id));
                },
                child: Container(
                  width: cardWidth,
                  height: 114,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyleConstants.h3(),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        category.subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyleConstants.label(size: 12),
                      ),
                      const Spacer(),
                      const Align(
                        alignment: Alignment.bottomRight,
                        child: Icon(
                          Icons.chevron_right,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // SUBCATEGORIES & SERVICES GRID VIEW
  Widget _buildServicesView(
    BuildContext context,
    BookAppointmentState state,
  ) {
    final groups = state.filteredServiceGroups;
    final isTablet = SizeUtils.isTablet(context);

    if (groups.isEmpty) {
      return Center(
        child: Text(
          'No services available',
          style: TextStyleConstants.bodyMedium(),
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 24 : 16,
        vertical: 16,
      ),
      child: isTablet ? _buildTabletServicesLayout(groups) : _buildMobileServicesLayout(groups),
    );
  }

  // Mobile view
  Widget _buildMobileServicesLayout(List<ServiceGroupModel> groups) {
    return Column(
      children: List.generate(groups.length, (index) {
        final group = groups[index];
        return Padding(
          padding: EdgeInsets.only(bottom: index < groups.length - 1 ? 12 : 0),
          child: ServiceGroupWidget(
            group: group,
            onToggleExpand: () {
              _bloc.add(ToggleServiceGroupExpansionEvent(group.id));
            },
            onServiceTap: (service) {
              _bloc.add(
                ToggleServiceSelectionEvent(
                  groupId: group.id,
                  serviceId: service.id,
                ),
              );
            },
          ),
        );
      }),
    );
  }

  // Tablet view
  Widget _buildTabletServicesLayout(List<ServiceGroupModel> groups) {
    final leftGroups = <ServiceGroupModel>[];
    final rightGroups = <ServiceGroupModel>[];

    for (int i = 0; i < groups.length; i++) {
      if (i % 2 == 0) {
        leftGroups.add(groups[i]);
      } else {
        rightGroups.add(groups[i]);
      }
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: List.generate(leftGroups.length, (index) {
              final group = leftGroups[index];
              return Padding(
                padding: EdgeInsets.only(
                  bottom: index < leftGroups.length - 1 ? 12 : 0,
                ),
                child: ServiceGroupWidget(
                  group: group,
                  onToggleExpand: () {
                    _bloc.add(ToggleServiceGroupExpansionEvent(group.id));
                  },
                  onServiceTap: (service) {
                    _bloc.add(
                      ToggleServiceSelectionEvent(
                        groupId: group.id,
                        serviceId: service.id,
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            children: List.generate(rightGroups.length, (index) {
              final group = rightGroups[index];
              return Padding(
                padding: EdgeInsets.only(
                  bottom: index < rightGroups.length - 1 ? 12 : 0,
                ),
                child: ServiceGroupWidget(
                  group: group,
                  onToggleExpand: () {
                    _bloc.add(ToggleServiceGroupExpansionEvent(group.id));
                  },
                  onServiceTap: (service) {
                    _bloc.add(
                      ToggleServiceSelectionEvent(
                        groupId: group.id,
                        serviceId: service.id,
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
