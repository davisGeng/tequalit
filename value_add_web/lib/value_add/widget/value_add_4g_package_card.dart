import 'package:dart_extensions/dart_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../assets/assets.gen.dart';
import '../../model/value_add_product_response.dart';

class ValueAdd4gPackageCard extends StatelessWidget {
  final Plans item;

  final int parentIndex;
  final bool parentIsLast;

  final String selectPlanTag;
  final double radius;
  final bool isHead;
  final bool isTrail;
  final ValueChanged<String>? onTapArrow;

  const ValueAdd4gPackageCard({
    super.key,
    required this.item,
    required this.parentIndex,
    required this.selectPlanTag,
    this.isHead = false,
    this.isTrail = false,
    this.radius = 5,
    this.onTapArrow,
    this.parentIsLast = false,
  });
  @override
  Widget build(BuildContext context) {
    final pricesList = item.prices ?? [];
    return Column(
      children:
          pricesList.asMap().entries.map((entry) {
            final sonIndex = entry.key;
            final price = entry.value;
            final tag = '${parentIndex}_$sonIndex';
            final isSelected = selectPlanTag.equalsIgnoreCase(tag);
            final isLastItem = parentIsLast && (sonIndex == pricesList.length - 1);

            return _PriceOptionCard(
              key: ValueKey(tag), // 为每个子项提供一个稳定的key，有助于Flutter的Diffing算法
              item: item,
              price: price,
              itemName: item.name ?? "",
              tag: tag,
              isSelected: isSelected,
              isLastItem: isLastItem,
              onTap: () => onTapArrow?.call(tag),
            );
          }).toList(),
    );
  }
}

class _PriceOptionCard extends StatelessWidget {
  double cardRadius = 8.0; // 假设半径是8.0，你可以根据实际情况修改
  final Color selectedCardColor = Color.fromRGBO(222, 242, 255, 1);
  final Color unselectedCardColor = Colors.white;
  final Color selectedBorderColor = Color(0xFF0B6288);
  final Color unselectedBorderColor = Color(0xFFDDDDDD);
  final Color subtitleColor = Color(0xFF666666);

  final Plans item;
  final Prices price;
  final String itemName;
  final String tag;
  final bool isSelected;
  final bool isLastItem;
  final VoidCallback onTap;

  _PriceOptionCard({
    super.key,
    required this.item,
    required this.price,
    required this.itemName,
    required this.tag,
    required this.isSelected,
    required this.isLastItem,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 10, left: 24, right: 24, bottom: isLastItem ? 20 : 0),
        padding: const EdgeInsets.only(left: 14, top: 15, right: 14, bottom: 10),
        decoration: BoxDecoration(
          color: isSelected ? selectedCardColor : unselectedCardColor,
          borderRadius: BorderRadius.all(Radius.circular(cardRadius)),
          border: Border.all(color: isSelected ? selectedBorderColor : unselectedBorderColor, width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 8), // 增加适当的间距，提升UI美观度
            _buildSubtitles(),
            _buildPrice(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(itemName, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
        isSelected
            ? Assets.images.iconServiceCloudBoxSelected.image(width: 20, height: 20, fit: BoxFit.fill)
            : Assets.images.iconRadioBox.image(width: 20, height: 20),
      ],
    );
  }

  Widget _buildSubtitles() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("• ", style: TextStyle(fontSize: 11, color: subtitleColor)),
            Expanded(
              child: Text(
                getSubTitle1(),
                style: TextStyle(fontSize: 11, color: subtitleColor),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
        Text(
          getSubTitle2(price),
          style: TextStyle(fontSize: 11, color: subtitleColor),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          getSubTitle3(price),
          style: TextStyle(fontSize: 11, color: subtitleColor),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildPrice() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Spacer(),
        Text(
          '${price.currencySymbol}${_showPrice(price.unitAmount ?? -1)}',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  String getSubTitle1() {
    return "${'plan_coverage_label'.tr}: ${"US"}";
  }

  String getSubTitle2(Prices price) {
    return '• ${'plan_data_label'.tr}: ${item.isUnlimited == true ? 'plan_data_unlimited_label'.tr : _planDataShow()}';
  }

  String getSubTitle3(Prices price) {
    return '• ${'plan_validity_label'.tr}${_durationDays()} ${'plan_days_label'.tr}';
  }

  String _planDataShow() {
    String result = "";
    Map<String, Object>? attri = item.attributes;
    if (attri != null) {
      if (attri.containsKey("data_total")) {
        result = '${attri["data_total"]}';
      }
      if (attri.containsKey("data_unit")) {
        result = result + (attri["data_unit"] as String);
      }
    }
    return result;
  }

  String _durationDays() {
    Map<String, Object>? attributes = item.getAttribute();
    if (attributes == null) return "";

    return '${attributes["duration_days"]}';
  }

  String _showPrice(int unitAmount) {
    String price = "";
    if (unitAmount > -1) {
      double tPrice = unitAmount / 100.0;
      price = tPrice.toString();
    }
    return price;
  }
}
