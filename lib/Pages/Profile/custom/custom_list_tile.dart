import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:careio_doctor_version/Utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:sizer/sizer.dart';

typedef FutureCallBack = Future<void> Function();

class CustomListTile extends StatelessWidget{
  final String title;
  final String subTitle;
  final String from;
  final String? to;
  final Callback onEdit;
  final FutureCallBack onDelete;
  final RxBool isLoading = false.obs;
  CustomListTile({super.key, required this.title, required this.subTitle, required this.from, this.to, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15.sp, left: 10.sp, right: 10.sp),
      child: Obx(()=> Opacity(
        opacity: isLoading.isTrue ? 0.5: 1,
        child: Card(
          elevation: 15,
          shadowColor: Colors.grey.shade50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.only(  top: 15.sp, left: 10.sp, right: 10.sp, bottom: 2.sp),
            title: Text(
              title,
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: AppColors.primaryColor,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subTitle,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 9.sp,
                    color: Colors.black,
                  ),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Chip(
                      label: Text(
                        from,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryColor,
                            fontSize: 8.sp),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    if(to != null)...[
                      Text('-'),
                      Chip(
                        label: Text(
                          to!,
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 8.sp),
                        ),
                        backgroundColor: Colors.white,
                      ),
                    ],
                  ],
                )
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: onEdit, icon: Icon(Boxicons.bxs_edit, color: AppColors.primaryColor), tooltip: 'edit'),
                IconButton(
                    onPressed: () async {
                      try{
                        if(isLoading.isTrue) return;
                        isLoading(true);
                        await onDelete();
                        isLoading(false);
                      }
                      catch(e){
                        isLoading(false);
                        showSnack(
                            title: AppStrings.cannotCompleteOperation.tr,
                            description: e.toString());
                      }
                    },
                    icon: Icon(Boxicons.bxs_trash, color: Colors.red,), tooltip: 'delete'),
              ],
            ),
          ),
        ),
      )),
    );
  }

}
