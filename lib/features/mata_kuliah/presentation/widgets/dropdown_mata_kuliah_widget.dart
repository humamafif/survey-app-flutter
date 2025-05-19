import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:survey_app/core/app/theme/colors/app_color.dart';
import 'package:survey_app/core/app/theme/style/app_text_styles.dart';
import 'package:survey_app/features/mata_kuliah/domain/entities/mata_kuliah_entity.dart';
import 'package:survey_app/features/mata_kuliah/presentation/bloc/mata_kuliah_bloc.dart';

class DropdownMataKuliahWidget extends StatefulWidget {
  final Function(MataKuliahEntity?)? onMataKuliahSelected;

  const DropdownMataKuliahWidget({Key? key, this.onMataKuliahSelected})
    : super(key: key);

  @override
  State<DropdownMataKuliahWidget> createState() =>
      _DropdownMataKuliahWidgetState();
}

class _DropdownMataKuliahWidgetState extends State<DropdownMataKuliahWidget> {
  MataKuliahEntity? _selectedMataKuliah;

  @override
  void initState() {
    super.initState();
    context.read<MataKuliahBloc>().add(GetAllMataKuliahEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MataKuliahBloc, MataKuliahState>(
      builder: (context, state) {
        if (state is MataKuliahLoadingState) {
          return _buildLoadingDropdown();
        } else if (state is MataKuliahErrorState) {
          return _buildErrorState(state.message);
        } else if (state is MataKuliahLoadedAllState) {
          return _buildDropdown(state.mataKuliah);
        } else {
          return _buildEmptyState();
        }
      },
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
            SizedBox(width: 16.w),
            Text("Memuat data mata kuliah...", style: AppTextStyles.bodyMedium),
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

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.warning.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColor.warning),
      ),
      child: Text(
        'Tidak ada data mata kuliah.',
        style: AppTextStyles.bodyMedium.copyWith(color: AppColor.textPrimary),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildDropdown(List<MataKuliahEntity> mataKuliahs) {
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
            child: DropdownButton<MataKuliahEntity>(
              hint: Text(
                'Pilih Mata Kuliah',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColor.textDisabled,
                ),
              ),
              value: _selectedMataKuliah,
              isExpanded: true,
              menuMaxHeight: 0.5.sh,
              elevation: 2,
              icon: Icon(Icons.arrow_drop_down, color: AppColor.primaryColor),
              items:
                  mataKuliahs.map((mataKuliah) {
                    return DropdownMenuItem<MataKuliahEntity>(
                      value: mataKuliah,
                      child: Text(
                        mataKuliah.namaMk,
                        style: AppTextStyles.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
              onChanged: (newMataKuliah) {
                setState(() {
                  _selectedMataKuliah = newMataKuliah;
                });

                // Trigger callback to update dosen dropdown
                if (widget.onMataKuliahSelected != null) {
                  widget.onMataKuliahSelected!(newMataKuliah);
                }

                // For state management
                if (newMataKuliah != null) {
                  context.read<MataKuliahBloc>().add(
                    SelectMataKuliahEvent(newMataKuliah),
                  );
                }
              },
            ),
          ),
        ),
        if (_selectedMataKuliah != null)
          Padding(
            padding: EdgeInsets.only(top: 16.h, left: 4.w),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: AppColor.success, size: 16.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Mata Kuliah: ${_selectedMataKuliah!.namaMk}',
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
