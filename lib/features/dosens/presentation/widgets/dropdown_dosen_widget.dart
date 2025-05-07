import 'package:survey_app/core/app/app_exports.dart';
import 'package:survey_app/features/dosens/domain/entities/dosen_entity.dart';
import 'package:survey_app/features/dosens/presentation/bloc/dosens_bloc.dart';
import 'package:survey_app/shared/utils/shared_preferences_utils.dart';

class DropdownDosenWidget extends StatefulWidget {
  const DropdownDosenWidget({super.key});

  @override
  State<DropdownDosenWidget> createState() => _DropdownDosenWidgetState();
}

class _DropdownDosenWidgetState extends State<DropdownDosenWidget> {
  DosenEntity? _selectedDosen;

  @override
  void initState() {
    super.initState();
    final state = context.read<DosensBloc>().state;
    if (state is DosensLoadedGetAllState) {
      loadSelectedDosenFromPrefs(state.dosens.cast<DosenEntity>());
    }
  }

  Future<void> loadSelectedDosenFromPrefs(List<DosenEntity> dosens) async {
    final selected = await loadSelectedDosen(dosens);
    if (mounted) {
      setState(() {
        _selectedDosen = selected?.id == -1 ? null : selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DosensBloc, DosensState>(
      listenWhen:
          (previous, current) =>
              current is DosensLoadedGetAllState && previous != current,
      listener: (context, state) {
        if (state is DosensLoadedGetAllState) {
          loadSelectedDosenFromPrefs(state.dosens.cast<DosenEntity>());
        }
      },
      child: BlocBuilder<DosensBloc, DosensState>(
        builder: (context, state) {
          if (state is DosensLoadingState) {
            return _buildLoadingDropdown();
          } else if (state is DosensErrorState) {
            return _buildErrorState(state.message);
          } else if (state is DosensLoadedGetAllState) {
            final dosens = state.dosens;
            return _buildDropdown(dosens);
          } else {
            return _buildEmptyState();
          }
        },
      ),
    );
  }

  Widget _buildLoadingDropdown() {
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
            16.horizontalSpace,
            Text("Memuat data...", style: AppTextStyles.bodyMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
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
          16.horizontalSpace,
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

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.warning.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColor.warning),
      ),
      child: Text(
        'Tidak ada data dosen.',
        style: AppTextStyles.bodyMedium.copyWith(color: AppColor.textPrimary),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildDropdown(List<DosenEntity> dosens) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
              value: _selectedDosen,
              isExpanded: true,
              menuMaxHeight: 0.5.sh,
              elevation: 2,
              icon: Icon(Icons.arrow_drop_down, color: AppColor.primaryColor),
              items:
                  dosens.map((dosen) {
                    return DropdownMenuItem<DosenEntity>(
                      value: dosen,
                      child: Text(
                        dosen.name,
                        style: AppTextStyles.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
              onChanged: (newDosen) {
                if (newDosen != null) {
                  setState(() {
                    _selectedDosen = newDosen;
                  });
                  saveSelectedDosen(newDosen);
                }
              },
            ),
          ),
        ),
        if (_selectedDosen != null)
          Padding(
            padding: EdgeInsets.only(top: 16.h, left: 4.w),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: AppColor.success, size: 16.sp),
                8.horizontalSpace,
                Expanded(
                  child: Text(
                    'Dosen Terpilih: ${_selectedDosen!.name}',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColor.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
