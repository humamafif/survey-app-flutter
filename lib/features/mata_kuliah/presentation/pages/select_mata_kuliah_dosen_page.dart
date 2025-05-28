import 'package:survey_app/core/app/app_exports.dart';
import 'package:survey_app/features/dosens/domain/entities/dosen_entity.dart';
import 'package:survey_app/features/dosens/presentation/bloc/dosens_bloc.dart';
import 'package:survey_app/features/mata_kuliah/domain/entities/mata_kuliah_entity.dart';
import 'package:survey_app/features/mata_kuliah/presentation/bloc/mata_kuliah_bloc.dart';
import 'package:survey_app/shared/pages/loading_page.dart';

class SelectMataKuliahDosenPage extends StatefulWidget {
  final int surveyId;
  const SelectMataKuliahDosenPage({super.key, required this.surveyId});

  @override
  State<SelectMataKuliahDosenPage> createState() =>
      _SelectMataKuliahDosenPageState();
}

class _SelectMataKuliahDosenPageState extends State<SelectMataKuliahDosenPage> {
  String? selectedMataKuliahName;
  DosenEntity? selectedDosen;
  List<DosenEntity> filteredDosens = [];
  List<MataKuliahEntity> allMataKuliah = [];
  bool _isMataKuliahLoading = true;
  bool _isDosenLoading = true;
  bool get isLoading => _isMataKuliahLoading || _isDosenLoading;

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
      filteredDosens = [];
      for (var mk in matchingMataKuliah) {
        if (mk.dosens != null && mk.dosens!.isNotEmpty) {
          filteredDosens.addAll(mk.dosens!);
        }
      }
      filteredDosens = filteredDosens.toSet().toList();
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
    return MultiBlocListener(
      listeners: [
        BlocListener<MataKuliahBloc, MataKuliahState>(
          listener: (context, state) {
            if (state is MataKuliahLoadingState) {
              setState(() => _isMataKuliahLoading = true);
            } else {
              setState(() => _isMataKuliahLoading = false);
              if (state is MataKuliahLoadedAllState) {
                setState(() => allMataKuliah = state.mataKuliah);
              }
            }
          },
        ),
        BlocListener<DosensBloc, DosensState>(
          listener: (context, state) {
            if (state is DosensLoadingState) {
              setState(() => _isDosenLoading = true);
            } else {
              setState(() => _isDosenLoading = false);
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColor.backgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: AppColor.textPrimary,
              size: 24.sp,
            ),
            onPressed: () => GoRouter.of(context).pop(),
          ),
          title: Text("Survey Kinerja Dosen", style: AppTextStyles.h2),
          centerTitle: true,
        ),
        body: isLoading ? LoadingPage() : _buildMainContent(),
      ),
    );
  }

  Widget _buildMainContent() {
    return SafeArea(
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
                          MataKuliahEntity? selectedMk;
                          for (var mk in allMataKuliah) {
                            if (mk.namaMk == selectedMataKuliahName) {
                              selectedMk = mk;
                              break;
                            }
                          }
                          context.pushNamed(
                            AppRouteEnum.questionPage.name,
                            queryParameters: {
                              'dosenId': selectedDosen!.id.toString(),
                              'matakuliahId': selectedMk?.id.toString() ?? '',
                              'surveyId': widget.surveyId.toString(),
                              'namaMk': selectedMk?.namaMk,
                              'namaDosen': selectedDosen!.name,
                            },
                          );
                        },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                  disabledBackgroundColor: AppColor.textDisabled,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Lanjutkan Survey",
                    style: AppTextStyles.buttonText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMataKuliahDropdown() {
    if (allMataKuliah.isEmpty) {
      return _buildEmptyStateWidget("Tidak ada data mata kuliah.");
    }
    final uniqueMataKuliahNames = _getUniqueMataKuliahNames(allMataKuliah);
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

  Widget _buildEmptyStateWidget(String message) {
    return Container(
      padding: EdgeInsets.all(16.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.warning.withAlpha(10),
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
