// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:test_app/app/core/utils/extensions.dart';

// showLanguageDialog() {
//   final List<String> titles = ['ar'.tr, 'en_US'.tr];
//   Get.dialog(
//     Dialog(
//       backgroundColor: Colors.white,
//       insetPadding: const EdgeInsets.all(20),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Container(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: 'lang'.tr.title(),
//             ),
//             Column(
//               mainAxisSize: MainAxisSize.min,
//               children: List.generate(
//                 TranslationService.languages.length,
//                 (index) {
//                   var lang = TranslationService.languages.elementAt(index);
//                   return RadioListTile<String>(
//                     // checkColor: Colors.white,
//                     controlAffinity: ListTileControlAffinity.trailing,
//                     groupValue: Get.locale.toString(),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     activeColor: Get.theme.primaryColor,
//                     title: titles[index].body(),

//                     value: lang,
//                     onChanged: (val) {
//                       Get.updateLocale(Locale(val!));
//                       Get.back();
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
