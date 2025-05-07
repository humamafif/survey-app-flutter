import 'package:survey_app/core/app/app_exports.dart';
import 'package:survey_app/features/dosens/presentation/widgets/dropdown_dosen_widget.dart';

class SurveyPage extends StatelessWidget {
  const SurveyPage({super.key});

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
                Text("Pilih Dosen", style: AppTextStyles.h3),
                8.verticalSpace,
                DropdownDosenWidget(),
                16.verticalSpace,
                Text("Silakan isi survey berikut:", style: AppTextStyles.h3),
                8.verticalSpace,
                RadioButton(question: "Materi disampaikan dengan jelas"),
                RadioButton(question: "Dosen datang tepat waktu"),
                RadioButton(question: "Kuliah berjalan sesuai RPS"),
                RadioButton(question: "Penilaian dilakukan secara transparan"),
                24.verticalSpace,
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Submit form
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Terima kasih, survey berhasil dikirim',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: AppColor.success,
                        ),
                      );
                      Future.delayed(Duration(seconds: 1), () {
                        GoRouter.of(context).pop();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: 32.w,
                        vertical: 12.h,
                      ),
                    ),
                    child: Text(
                      "Submit Survey",
                      style: AppTextStyles.buttonText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
