import 'package:dart_extensions/dart_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../assets/assets.gen.dart';
import '../../common/utils/TimeUtils.dart';
import '../../common/utils/text_utils.dart';
import '../../model/value_add_subscription_list_response.dart';

class ValueAddSubscriptionCard extends StatelessWidget {
  final int index;
  final int selectIndex;
  final double radius;
  final DeviceSubscription item;
  final ValueChanged<DeviceSubscription>? onTap;

  const ValueAddSubscriptionCard({
    Key? key,
    required this.item,
    required this.index,
    required this.selectIndex,
    this.radius = 5,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    List<Subscriptions> subs = item.subscriptions ?? [];
    if (subs.isNotEmpty) {
      for (int i = 0; i < subs.length; i++) {
        widgetList.add(_buildSubOrderView(subs[i], i));
      }
    }

    return Column(
      children: [
        Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: index == 0 ? 20 : 10),
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius),
              topRight: Radius.circular(radius),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 68,
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Assets.images.iconBleDevice
                        .image(width: 40, height: 40, fit: BoxFit.fill)
                        .marginOnly(right: 8),
                    Expanded(child: _nameAndDidWidget()),
                  ],
                ),
              ),

              Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
            ],
          ),
        ),
        Column(children: widgetList),
      ],
    );
  }

  Widget _buildSubOrderView(Subscriptions data, int index) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(top: 15, bottom: 10, left: 14, right: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
          topLeft: Radius.circular(index == 0 ? 0 : radius),
          topRight: Radius.circular(index == 0 ? 0 : radius),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.plan?.name ?? "",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              height: 1.7,
            ),
          ).marginOnly(bottom: 4),
          if (data.plan?.productType == "4G_DATA")
            Text(
              _getPlanData(data),
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFF666666),
                height: 1.6,
              ),
            ),

          if (data.plan?.productType == "4G_DATA")
            Text(
              _getValidityData(data),
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFF666666),
                height: 1.6,
              ),
            ),

          Text(
            _getExpireDateString(data.getCurrentPeriodEnd()),
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF666666),
              height: 1.6,
            ),
          ).marginOnly(bottom: 4),
          Container(
            alignment: Alignment.centerRight,
            width: double.maxFinite,
            child: Text(
              _getSubscriptionStatus(data),
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                height: 1.6,
                color:
                    _showWarningForLeftDays(data)
                        ? Color(0xFFFB3B3B)
                        : Color(0xFF0B6288),
              ),
            ),
          ),
        ],
      ),
    );
  }

  int getLeftDaysForPackage(String endTime) {
    int intervalD = -1;
    if (endTime.length >= 10) {
      intervalD = TimeUtils.getIntervalDays(
        TimeUtils.getCurrentTimeWithFormat(),
        endTime,
      );
    }
    return intervalD;
  }

  Widget _nameAndDidWidget() {
    if (TextUtils.getStringWithOption(item.deviceName).isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item.deviceName ?? "",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          Text(
            'DID:${TextUtils.getStringWithOption(item.deviceId)}',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color(0xFF999999),
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'DID:${item.deviceId ?? ""}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            'device_not_in_list_warning_content'.tr,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: Color(0xFFFB3B3B),
              height: 1.64,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      );
    }
  }

  String _getPlanData(Subscriptions? data) {
    SubscriptionPlan? plan = data?.plan;
    if (plan == null) {
      return "";
    }
    bool isUnlimited = false;
    String dataResult = "";
    Map<String, Object>? attri = plan.getAttribute();
    if (attri != null) {
      if (attri.containsKey("data_total")) {
        isUnlimited = false;
      } else {
        isUnlimited = true;
      }

      if (attri.containsKey("data_total")) {
        dataResult = '${attri["data_total"]}';
      }
      if (attri.containsKey("data_unit")) {
        dataResult = dataResult + (attri["data_unit"] as String);
      }
    }
    return '• ${'plan_data_label'.tr}: ${isUnlimited == true ? 'plan_data_unlimited_label'.tr : dataResult}';
  }

  String _getValidityData(Subscriptions? data) {
    if (data == null) {
      return "";
    }
    String dataResult = "";
    int days = data.calculateDaysDifference();
    if (days > 0) {
      dataResult = days.toString();
    }
    // Map<String, Object>? attri = plan.getAttribute();
    // if (attri != null) {
    //   if (attri.containsKey("duration_days")) {
    //     dataResult = '${attri["duration_days"]}';
    //   }
    // }
    return '• ${'plan_validity_label'.tr}: $dataResult${'plan_days_label'.tr}';
  }

  String _getExpireDateString(String? time) {
    String backTime = "";
    String inputTime = TextUtils.getStringWithOption(time);
    if (inputTime.length >= 10) {
      backTime = TimeUtils.extractAndFormatDateTime(
        inputTime,
        format: "yyyy/MM/dd",
      );
    } else {
      backTime = "";
    }
    return "• ${'plan_expired_date_label'.tr}: $backTime";
  }

  String _getSubscriptionStatus(Subscriptions? subs) {
    String backResult = "";
    if (subs == null) {
      return backResult;
    }

    String status = subs.status ?? "";
    if (status.equalsIgnoreCase("ACTIVE")) {
      int leftDays = getLeftDaysForPackage(subs.getCurrentPeriodEnd());

      backResult = 'days_left_label'.trParams({
        "place": leftDays < 0 ? "" : leftDays.toString(),
      });
    } else if (status.equalsIgnoreCase("PENDING_ACTIVATION")) {
      backResult = 'PENDING_ACTIVATION'.tr;

      // backResult = 'unused_plan_label'.tr;
    } else {
      backResult = status;
    }

    return backResult;
  }

  bool _showWarningForLeftDays(Subscriptions? subs) {
    bool backResult = false;
    if (subs == null) {
      return backResult;
    }

    String status = subs.status ?? "";
    if (status.equalsIgnoreCase("ACTIVE")) {
      int leftDays = getLeftDaysForPackage(subs.getCurrentPeriodEnd());
      if (leftDays >= 0 && leftDays <= 3) {
        backResult = true;
      }
    }

    return backResult;
  }
}
