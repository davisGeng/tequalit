import 'dart:convert';

import '../model/check_device_available_by_plan_response.dart';
import '../model/value_add_check_device_service_response.dart';
import '../model/value_add_create_order_response.dart';
import '../model/value_add_order_list_response.dart';
import '../model/value_add_product_response.dart';
import '../model/value_add_subscription_list_response.dart';
import '../model/value_add_support_device_plans_response.dart';
import '../network/api_exception.dart';
import '../network/dio_http_util.dart';

/// 示例：增值服务模块接口
class ValueAddApi {
  static final ValueAddApi instance = ValueAddApi._internal();
  factory ValueAddApi() => instance;
  ValueAddApi._internal();

  String _language = "zh";
  void init(String language) {
    // 核心：将DioHttpUtil的全局Dio传入VasApi，完成融合
    _language = language;
  }
  Future<ValueAddProductResponse?> getProductList({
    String productType = "",
    int pageSize = 20,
    int page = 1,
    String supplier = "",
    bool filterCountry = false,
    String coverageMode = "",
    String regionType = "",
  }) async {
    try {
      final args = {
        // 'type': productType,
        "limit": pageSize,
        "offset": (page - 1)*pageSize,
        // "supplier": supplier,
        // "filterCountry": filterCountry,
        // "coverage_mode": coverageMode,
        // "region_type": regionType,
        // "language": _language,
      };
      final response = await dioHttp.get("/api/v1/vas/products",params: args);
      ValueAddProductResponse model = ValueAddProductResponse.fromJson(response as Map<String, dynamic>);
      return model;
    } catch (e) {
      throw Exception("Failed to getProductlist : $e");
    }
  }

  Future<ValueAddProductItem?> getProductDetail(String productId) async {
    try {
      // 1. 路径参数：用字符串插值替换{product_id}
      final url = "/api/v1/vas/products/$productId";
      // 2. Query参数：只保留非路径参数（比如language）
      final queryParams = {"language": _language};
      final response = await dioHttp.get(url,params: queryParams);
      ValueAddProductItem model = ValueAddProductItem.fromJson(response as Map<String, dynamic>);
      return model;
    } catch (e) {
      throw Exception("Failed to getProductDetail : $e");
    }
  }

  Future<ValueAddCreateOrderResponse?> createOrder({
    String couponCode = "",
    String deviceId = "",
    String source = "web",
    String iccid = "",
    String paymentChannel = "",
    String priceId = "",
    int quantity = 1,
  }) async {
    try {
      Map<String, Object> param = <String, Object>{};

// 2. 非空判断后赋值，与Java逻辑完全一致
      if (couponCode.isNotEmpty) {
        param["coupon_code"] = couponCode;
      }

      if (deviceId.isNotEmpty) {
        param["device_id"] = deviceId;
      }

      if (paymentChannel.isNotEmpty) {
        param["payment_channel"] = paymentChannel;
      }

      if (priceId.isNotEmpty) {
        param["price_id"] = priceId;
      }

// 3. 必传参数：无条件赋值（与Java一致）
      param["quantity"] = quantity;
      Map<String,Object> metaMap = {};
      if(source.isNotEmpty){
        metaMap['source'] = source;
      }
      if(iccid.isNotEmpty){
        metaMap['iccid'] = iccid;
      }
      if (metaMap.isNotEmpty) {
        param["metadata"] = metaMap;
      }


      String response = await dioHttp.post("/api/v1/vas/orders/",data: param);
      if (response.isEmpty) {
        return null;
      }
      ValueAddCreateOrderResponse model = ValueAddCreateOrderResponse.fromJson(
        json.decode(response),
      );
      return model;
    } catch (e) {
      throw Exception("Failed to createOrder : $e");
    }
  }
  //
  // Future<ValueAddOrderStatus?> checkOrderStatus(
  //     String orderNumber, {
  //       int page = 1,
  //       int pageSize = 20,
  //     }) async {
  //   try {
  //     final args = {
  //       'tag': _tag,
  //       'orderNumber': orderNumber,
  //       'page': page,
  //       'pageSize': pageSize,
  //     };
  //     String response = await _invoker.invoke(
  //       _NativeMethodNames.checkValueAddOrderStatus,
  //       args,
  //     );
  //     if (response.isEmpty) {
  //       return null;
  //     }
  //     ValueAddOrderStatus orderStatus = ValueAddOrderStatus.fromString(
  //       response,
  //     );
  //     return orderStatus;
  //   } catch (e) {
  //     throw Exception("Failed to checkOrderStatus : $e");
  //   }
  // }
  //
  //   String version = Optional.ofNullable(args.get("version"))
  //       .map(value -> (String) value).orElse("v2");
  //  创建时间起始点 (ISO 8601格式) min_amount: 最小金额 (分为单位)
  Future<ValueAddOrderListResponse?> getValueAddOrderList({
    int page = 1,
    int pageSize = 20,
    String orderNumber = "",
    String status = "",
    String currency = "",
    String paymentMethod = "",
    String deviceId = "",
    String createTimeAfter = "",
    String createTimeBefore = "",
    int minAmount = -1,
    int maxAmount = -1,
    String productType = "",
    String productId = "",
    String planId = "",
    String providerCode = "",
    String ordering = "",
    String version = "v2",
  }) async {
    try {
      final args = {
        'offset': (page -1)*pageSize,
        'limit': pageSize,
        'order_number': orderNumber,
        'status': status,
        'currency': currency,
        'payment_method': paymentMethod,
        'device_id': deviceId,
        'created_after': createTimeAfter,
        'created_before': createTimeBefore,
        'min_amount': minAmount,
        'max_amount': maxAmount,
        'product_type': productType,
        'product_id': productId,
        'plan_id': planId,
        'provider_code': providerCode,
        'ordering': ordering,
        'version': version,
      };

      String response = await dioHttp.get("/api/v1/vas/orders/",params: args);
      if (response.isEmpty) {
        return null;
      }
      ValueAddOrderListResponse? result = ValueAddOrderListResponse.fromJson(
        json.decode(response),
      );
      return result;
    } catch (e) {
      throw Exception("Failed to getValueAddOrderList : $e");
    }
  }

  Future<ValueAddSubscriptionListResponse?> getValueAddSubscriptions({
    int page = 1,
    int pageSize = 20,
    bool useGroupBy = false,
  }) async {
    try {
      final args = {
        'offset': (page -1)*pageSize,
        'limit': pageSize,
        "group_by": useGroupBy ? 'device_id' : "",
      };
      String response = await dioHttp.get("/api/v1/vas/subscriptions",params: args);
      if (response.isEmpty) {
        return null;
      }
      ValueAddSubscriptionListResponse model =
      ValueAddSubscriptionListResponse.fromJson(json.decode(response));
      return model;
    } catch (e) {
      throw Exception("Failed to getValueAddSubscriptions : $e");
    }
  }

  Future<ValueAddCheckDeviceServiceResponse?>
  checkDeviceSubscriptionsEntitlements(
      String deviceId, {
        String serviceType = "",
        int page = 1,
        int pageSize = 20,
      }) async {
    try {
      final args = {
        'device_id': deviceId,
        'service_type': serviceType,
      };
      String? response = await dioHttp.get("/api/v1/vas/subscriptions/entitlements/check/",params: args);
      if (response == null) {
        return null;
      }
      ValueAddCheckDeviceServiceResponse model =
      ValueAddCheckDeviceServiceResponse.fromJson(json.decode(response));

      return model;
    } catch (e) {
      throw Exception("Failed to checkDeviceSubscriptionsEntitlements : $e");
    }
  }

  // device_id: 设备唯一ID（自动从 Server 查询产品信息）
  // device_ids: 多个设备唯一ID，逗号分隔（V2批量查询，如 dev1,dev2,dev3）
  // device_product_id: 设备产品型号ID（如 CAMERA_PRO_001）
  // device_product_ids: 多个设备产品型号ID，逗号分隔（V2批量查询，如 CAM_001,CAM_002）
  Future<ValueAddSupportDevicePlansResponse?> getValueAddPlansByDevice(
      String deviceIds, {
        int page = 1,
        int pageSize = 20,
      }) async {
    try {
      final args = {
        'offset': (page -1)*pageSize,
        'limit': pageSize,
        'device_ids': deviceIds,
      };
      String? response = await dioHttp.get("/api/v1/vas/products/device-plans/",params: args);
      if (response == null) {
        return null;
      }
      ValueAddSupportDevicePlansResponse model =
      ValueAddSupportDevicePlansResponse.fromJson(json.decode(response));

      return model;
    } catch (e) {
      throw Exception("Failed to getValueAddPlansByDevice : $e");
    }
  }

  Future<CheckDeviceAvailableByPlanResponse?> getValueAddAvailableDeviceByPlan(
      String planId,
      List<Map<String, dynamic>> deviceMaps,
      ) async {
    try {
      // List<Map<String, dynamic>> deviceValue = devices.map((device) => device.toJson()).toList();

      final args = {'plan_id': planId, 'devices': deviceMaps};
      CheckDeviceAvailableByPlanResponse? response = await dioHttp.get<CheckDeviceAvailableByPlanResponse>("/api/v1/vas/products/batch-check-compatibility/",params: args);
      return response;
    } catch (e) {
      throw Exception("Failed to getValueAddCheckDeviceAvailableByPlan : $e");
    }
  }
}