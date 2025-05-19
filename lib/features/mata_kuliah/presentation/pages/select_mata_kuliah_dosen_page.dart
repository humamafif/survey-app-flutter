import 'package:survey_app/core/app/app_exports.dart';
import 'package:survey_app/features/dosens/domain/entities/dosen_entity.dart';
import 'package:survey_app/features/dosens/presentation/bloc/dosens_bloc.dart';
import 'package:survey_app/features/mata_kuliah/domain/entities/mata_kuliah_entity.dart';
import 'package:survey_app/features/mata_kuliah/presentation/bloc/mata_kuliah_bloc.dart';

class SelectMataKuliahDosenPage extends StatefulWidget {
  const SelectMataKuliahDosenPage({super.key});

  @override
  State<SelectMataKuliahDosenPage> createState() =>
      _SelectMataKuliahDosenPageState();
}

class _SelectMataKuliahDosenPageState extends State<SelectMataKuliahDosenPage> {
  String? selectedMataKuliahName;
  DosenEntity? selectedDosen;
  List<DosenEntity> filteredDosens = [];
  List<MataKuliahEntity> allMataKuliah = [];

  @override
  void initState() {
    super.initState();
    context.read<MataKuliahBloc>().add(GetAllMataKuliahEvent());
    context.read<DosensBloc>().add(GetAllDosensEvent());
  }

  void _filterDosensByMataKuliahName(String? mataKuliahName) {
    if (mataKuliahName == null) {
      setState(() {
        filteredDosens = [];
        selectedDosen = null;
      });
      return;
    }

    setState(() {
      selectedDosen = null;

      List<MataKuliahEntity> matchingMataKuliah =
          allMataKuliah.where((mk) => mk.namaMk == mataKuliahName).toList();

      filteredDosens =
          matchingMataKuliah
              .where((mk) => mk.dosen != null)
              .map((mk) => mk.dosen!)
              .toList();
      // if (filteredDosens.isNotEmpty) {
      //   selectedDosen = filteredDosens.first;
      // }
    });
  }

  List<String> _getUniqueMataKuliahNames(List<MataKuliahEntity> mataKuliahs) {
    Set<String> uniqueNames = {};

    for (var mk in mataKuliahs) {
      uniqueNames.add(mk.namaMk);
    }

    return uniqueNames.toList()..sort();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColor.textPrimary,
            size: 24.sp,
          ),
          onPressed: () => GoRouter.of(context).pop(),
        ),
        title: Text("Survey Page", style: AppTextStyles.h2),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Mata Kuliah Dropdown
                Text("Pilih Mata Kuliah", style: AppTextStyles.h3),
                8.verticalSpace,
                _buildMataKuliahDropdown(),
                24.verticalSpace,

                // Dosen Dropdown
                Text("Pilih Dosen Pengampu", style: AppTextStyles.h3),
                8.verticalSpace,
                _buildDosenDropdown(),
                16.verticalSpace,

                ElevatedButton(
                  onPressed:
                      selectedDosen == null
                          ? null
                          : () {
                            context.pushNamed(
                              AppRouteEnum.questionPage.name,
                              queryParameters: {
                                'dosenId': selectedDosen!.id.toString(),
                                'matakuliahId':
                                    allMataKuliah
                                        .firstWhere(
                                          (mk) =>
                                              mk.namaMk ==
                                              selectedMataKuliahName,
                                        )
                                        .id
                                        .toString(),
                              },
                            );
                          },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor,
                    disabledBackgroundColor: AppColor.textDisabled,
                  ),
                  child: Center(child: Text("Lanjutkan Survey")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMataKuliahDropdown() {
    return BlocBuilder<MataKuliahBloc, MataKuliahState>(
      builder: (context, state) {
        if (state is MataKuliahLoadingState) {
          return _buildLoadingWidget("Memuat data mata kuliah...");
        } else if (state is MataKuliahErrorState) {
          return _buildErrorWidget(state.message);
        } else if (state is MataKuliahLoadedAllState) {
          allMataKuliah = state.mataKuliah;

          if (allMataKuliah.isEmpty) {
            return _buildEmptyStateWidget("Tidak ada data mata kuliah.");
          }

          final uniqueMataKuliahNames = _getUniqueMataKuliahNames(
            allMataKuliah,
          );

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColor.surfaceColor,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColor.borderColor),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: Text(
                  'Pilih Mata Kuliah',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColor.textDisabled,
                  ),
                ),
                value: selectedMataKuliahName,
                isExpanded: true,
                menuMaxHeight: 0.5.sh,
                elevation: 2,
                icon: Icon(Icons.arrow_drop_down, color: AppColor.primaryColor),
                items:
                    uniqueMataKuliahNames.map((String nama) {
                      return DropdownMenuItem<String>(
                        value: nama,
                        child: Text(
                          nama,
                          style: AppTextStyles.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedMataKuliahName = newValue;
                  });

                  _filterDosensByMataKuliahName(newValue);
                },
              ),
            ),
          );
        }
        return _buildEmptyStateWidget("Pilih mata kuliah");
      },
    );
  }

  Widget _buildDosenDropdown() {
    if (selectedMataKuliahName == null) {
      return _buildEmptyStateWidget("Pilih mata kuliah terlebih dahulu");
    }

    if (filteredDosens.isNotEmpty) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: AppColor.surfaceColor,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColor.borderColor),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<DosenEntity>(
            hint: Text(
              'Pilih Dosen',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColor.textDisabled,
              ),
            ),
            value: selectedDosen,
            isExpanded: true,
            menuMaxHeight: 0.5.sh,
            elevation: 2,
            icon: Icon(Icons.arrow_drop_down, color: AppColor.primaryColor),
            items:
                filteredDosens.map((dosen) {
                  return DropdownMenuItem<DosenEntity>(
                    value: dosen,
                    child: Text(
                      dosen.name,
                      style: AppTextStyles.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
            onChanged: (DosenEntity? newDosen) {
              setState(() {
                selectedDosen = newDosen;
              });
            },
          ),
        ),
      );
    }

    return _buildEmptyStateWidget(
      "Tidak ada dosen pengampu untuk mata kuliah ini",
    );
  }

  // Helper widgets
  Widget _buildLoadingWidget(String message) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColor.surfaceColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColor.borderColor),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 20.w,
              height: 20.h,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColor.primaryColor,
              ),
            ),
            SizedBox(width: 16.w),
            Text(message, style: AppTextStyles.bodyMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.error.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColor.error),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: AppColor.error, size: 24.sp),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              message,
              style: AppTextStyles.bodyMedium.copyWith(color: AppColor.error),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyStateWidget(String message) {
    return Container(
      padding: EdgeInsets.all(16.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.warning.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColor.warning),
      ),
      child: Text(
        message,
        style: AppTextStyles.bodyMedium.copyWith(color: AppColor.textPrimary),
        textAlign: TextAlign.center,
      ),
    );
  }
}
