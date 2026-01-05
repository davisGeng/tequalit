import 'package:json_annotation/json_annotation.dart';

// 序列化代码生成文件（执行build_runner后自动生成）
part 'check_device_available_by_plan_request.g.dart';

/// 对应Java → CheckDeviceAvailableByPlanRequest 主类
@JsonSerializable()
class CheckDeviceAvailableByPlanRequest {
  /// 设备列表【必传】对应Java @SerializedName("devices")
  @JsonKey(name: "devices", required: true)
  final List<SimpleDevice> devices;

  /// 计划ID【可选】对应Java @SerializedName("plan_id")
  @JsonKey(name: "plan_id", nullable: true)
  final String? planId;

  /// ✅ 构造方法（对齐Java语义：devices必传，planId可选）
  CheckDeviceAvailableByPlanRequest({
    required this.devices,
    this.planId,
  });

  /// ✅ JSON反序列化 → 从Map转对象（接口返回解析用）
  factory CheckDeviceAvailableByPlanRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckDeviceAvailableByPlanRequestFromJson(json);

  /// ✅ JSON序列化 → 从对象转Map（接口请求传参用，核心）
  Map<String, dynamic> toJson() => _$CheckDeviceAvailableByPlanRequestToJson(this);

  /// ✅ 重写toString → 对齐Java日志打印格式，方便调试
  @override
  String toString() {
    return 'CheckDeviceAvailableByPlanRequest{'
        'devices: $devices, '
        'planId: $planId'
        '}';
  }
}

/// 对应Java → CheckDeviceAvailableByPlanRequest.SimpleDevice 内部类
/// 设备信息模型，严格对齐JSON结构：{"device_id":"xxx","model":"xxx","firmware_version":"xxx"}
@JsonSerializable()
class SimpleDevice {
  /// 设备ID【必传】对应Java @SerializedName("device_id")
  @JsonKey(name: "device_id", required: true)
  final String deviceId;

  /// 设备型号【可选】对应Java @SerializedName("model")
  @JsonKey(name: "model", nullable: true)
  final String? model;

  /// 固件版本【必传】对应Java @SerializedName("firmware_version")
  @JsonKey(name: "firmware_version", required: true)
  final String firmwareVersion;

  /// ✅ 构造方法（严格对齐Java的带参构造器参数顺序）
  SimpleDevice({
    required this.firmwareVersion,
    required this.deviceId,
    this.model,
  });

  /// ✅ JSON反序列化
  factory SimpleDevice.fromJson(Map<String, dynamic> json) =>
      _$SimpleDeviceFromJson(json);

  /// ✅ JSON序列化
  Map<String, dynamic> toJson() => _$SimpleDeviceToJson(this);

  /// ✅ 重写toString → 对齐Java日志打印格式
  @override
  String toString() {
    return 'SimpleDevice{'
        'deviceId: $deviceId, '
        'model: $model, '
        'firmwareVersion: $firmwareVersion'
        '}';
  }
}