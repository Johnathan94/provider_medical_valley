import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider_medical_valley/core/app_colors.dart';
import 'package:provider_medical_valley/core/app_paddings.dart';
import 'package:provider_medical_valley/core/app_styles.dart';
import 'package:provider_medical_valley/core/strings/images.dart';
class FilterView extends StatelessWidget {
  final Function ()  onSortTapped ;
  const FilterView({required this.onSortTapped , Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: smallPaddingHV,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset("${svgImagesPath}filter.svg"),
              const SizedBox(width: 8,),
              Text("12 Booked" , style: AppStyles.baloo2FontWith400WeightAnd18Size.copyWith(color: headerGrey, decoration: TextDecoration.none),)
            ],
          ),
          Row(
            children: [
              Text("Sort" , style: AppStyles.baloo2FontWith400WeightAnd12Size.copyWith(),),
              InkWell(
                  onTap: onSortTapped,
                  child: SvgPicture.asset("${svgImagesPath}sort.svg")),

            ],
          ),

        ],
      ),
    );
  }
}
