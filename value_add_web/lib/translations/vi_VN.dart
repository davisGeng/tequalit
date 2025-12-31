abstract class ViVN {
  static Map<String, String> translations = {
    "sightsys": "SightSys",
    "current_password": "Current password",
    "new_password": "New password",
    "confirm_the_changes": "Confirm the changes",
    "password_can_not_be_blank": "Password can not be blank",
    "canceling_your_account_will_delete_all_data":
        "Canceling your account will delete all data.",
    "username": "Username",
    "confirm_logout": "Confirm logout",
    "the_username_or_phone_number_you_entered_does_not_match_please_reenter":
        "The username or phone number you entered does not match, please re-enter.",
    "please_enter_a_different_device_name":
        "Please enter a different device name",
    "failed_to_modify_the_device_name": "Failed to modify the device name",
    "device_name_cannot_be_empty": "Device name cannot be empty",
    "next_step": "Next step",
    "finish": "Finish",
    "after_success_it_will_automatically_jump_to_the_next_step":
        "After success, it will automatically jump to the next step",
    "failed_to_create_qr_code": "Failed to create QR code",
    "need_to_enable_camera_permission": "Need to enable camera permission",
    "enable_camera_permission_to_scan_qr_code":
        "Enable camera permission to scan QR code",
    "failed_to_open_the_camera": "Failed to open the camera",
    "please_click_retry_to_start_qr_code_scanning":
        "Please click retry to start QR code scanning",
    "unknown_module_type": "Unknown module type",
    "error_processing_product_information":
        "Error processing product information",
    "error_processing_invitation": "Error processing invitation",
    "open": "Open",
    "please_confirm_whether_you_hear_the_prompt_tone":
        "Please confirm whether you hear the prompt tone",
    "connect_the_network_cable": "Connect the network cable",
    "go": "Go",
    "see": "Go",
    "connect_device_hotspot": "Connect device hotspot",
    "please_select_a_room": "Please select a room",
    "request_failed_please_try_again": "Request failed, please try again",
    "device_location": "Device location",
    "failed_to_load_room_list": "Failed to load room list",
    "choose_a_location_for_your_device": "Choose a location for your device",
    "device_search": "Device search",
    "bluetooth_device_scan_failed": "Bluetooth device scan failed",
    "common_problem": "Common problem",
    "please_enable_geolocation_permission_to_automatically_find_nearby_devices":
        "Please enable geolocation permission to automatically find nearby devices",
    "please_turn_on_bluetooth": "Please turn on bluetooth",
    "please_enable_location_permission": "Please enable location permission",
    "bluetooth_authorization_is_required_before_connecting_to_the_device":
        "Bluetooth authorization is required before connecting to the device",
    "bluetooth_added": "Bluetooth added",
    "add_hotspot": "Add hotspot",
    "device_scan": "Device scan",
    "add_network_cable": "Add network cable",
    "incorrect_format": "Incorrect format",
    "setup_failed": "Setup failed",
    "knew": "Knew",
    "surname": "Surname",
    "name": "Name",

    "describe_issue": "Please describe your issue in detail .",
    "phone_number": "Phone number",
    "and": "And",
    "verification_code": "Verification code",
    "please_try_again_later": "Please try again later",
    "login_failed": "Login failed",
    "upload_log_successfully": "Tải lên nhật ký thành công",
    "failed_to_upload_log": "Failed to upload log",
    "wechat_business": "Wechat business",
    "unable_to_clear_cache": "Unable to clear cache",
    "nickname_not_set": "Nickname not set",
    "unknown_user": "Unknown user",
    "edit_avatar": "Edit avatar",
    "system_authority": "System authority",
    "feedback": "Feedback",
    "contact_us": "Contact us",
    "get_logs": "Get logs",
    "select_a_chat_app": "Select a chat app",
    "unnamed_device": "Unnamed device",
    "unassigned_room": "Unassigned room",
    "scan_the_qr_code_on_the_device": "Scan the QR code on the device",
    "use_the_camera_to_scan_the_qr_code_on_your_device":
        "Use the camera to scan the QR code on your device",
    "privacy_policy": "Privacy policy",
    "user_agreement": "User agreement",
    "failed_to_obtain_version": "Failed to obtain version",
    "unknown_version": "Unknown version",
    "clear_cache": "Clear cache",
    "confirm_to_clear_cache": "Confirm to clear cache?",
    "this_will_delete_all_locally_saved_data":
        "This will delete all locally saved data.",
    "the_current_user_is_not_logged_in": "The current user is not logged in",
    "password_changed_successfully": "Password changed successfully",
    "password_changed_failed": "Failed to change password",
    "account_deleted": "Account deleted",
    "deletion_failed_please_try_again": "Deletion failed, please try again",
    "account_information": "Account information",
    "sign_out": "Sign out",
    "not_set": "Not set",
    "change_password": "Change password",
    "logout": "Logout",
    "logout_confirmation": "Logout confirmation",
    "are_you_sure_you_want_to_log_out_this_will_return_you_to_the_login_page":
        "Are you sure you want to log out? this will return you to the login page.",
    "edit_nickname": "Edit nickname",
    "are_you_sure_you_want_to_delete_your_account":
        "Are you sure you want to delete your account?",
    "unable_to_obtain_user_information_please_try_again_later":
        "Unable to obtain user information, please try again later.",
    "device": "Device",
    "failed_to_load_device_list": "Failed to load device list",
    "add_a_device": "Add a device",
    "offline_time": "Offline time:",
    "the_device_is_in_privacy_mode": "The device is in privacy mode",
    "camera_is_off_touch_the_screen_to_reactivate":
        "Camera is off, touch the screen to reactivate",
    "unlock_privacy": "Unlock privacy",
    "share_with": "Share with",
    "privacy_mode": "Privacy mode",
    "cloud_service": "Cloud service",
    "playback_speed": "speed",
    "playback_no_data": "no data",
    "cloud_storage": "cloud",
    "card_storage": "card",
    "mult_speed": "speed",
    "more": "More",
    "formatting_a_memory_card": "Formatting a memory card",
    "after_formatting_the_memory_card_all_videos_stored_in_the_card_will_be_deleted_do_you_want_to_format_it":
        "After formatting the memory card, all videos stored in the card will be deleted. do you want to format it?",
    "formatting_takes_time": "Formatting takes time",
    "user_cancelled_formatting": "User cancelled formatting",
    "unable_to_get_formatting_status": "Unable to get formatting status",
    "unknown_mistake": "Unknown mistake",
    "default": "Default",
    "unknown": "Unknown",
    "storage_card": "Storage card",
    "format": "Format",
    "video_resolution": "Video resolution",
    "currently_the_latest_version": "Currently the latest version",
    "firmware_upgrade": "Firmware upgrade",
    "volume": "Volume",
    "intercom_mode": "Intercom mode",
    "unidirectional": "Unidirectional",
    "twoway": "Two-way",
    "device_information_updated_successfully":
        "Device information updated successfully",
    "time_zone_settings": "Time zone settings",
    "firmware_version": "Firmware version",
    "memory_card_settings": "Memory card settings",
    "message_notification_type": "Message notification type",
    "letter": "Letter",
    "call_the_police": "Call the police",
    "alarm_tone_settings": "Alarm tone settings",
    "single_screen": "Single screen",
    "dual_screen": "Dual screen",
    "in_this_mode_youll_see_the_view_from_both_the_wideangle_and_telephoto_lenses_simultaneously":
        "In this mode, you'll see the view from both the wide-angle and telephoto lenses simultaneously.",
    "in_this_mode_you_will_be_automatically_shown_the_view_from_one_or_the_other_lens_depending_on_the_zoom_level":
        "In this mode, you will be automatically shown the view from one or the other lens, depending on the zoom level.",
    "all_sounds": "All sounds",
    "crying": "Crying",
    "dog_barking": "Dog barking",
    "siren": "Siren",
    "warn": "Warn",
    "detection_type": "Detection type",
    "cry_detection": "Cry detection",
    "smart_tracking": "Smart tracking",
    "automatically_rotate_the_camera_to_follow_the_path_of_a_moving_object":
        "Automatically rotate the camera to follow the path of a moving object",
    "start_smart_tracking": "Start smart tracking",
    "all_smart_detection_functions_will_be_turned_off_the_camera_will_not_record_video_and_push_notifications_do_you_want_to_continue":
        "All smart detection functions will be turned off, the camera will not record video and push notifications, do you want to continue?",
    "operation_cancelled": "Operation cancelled",
    "ptz_speed": "Ptz speed",
    "automatic_cruise_control": "Automatic cruise control",
    "preset_position": "Preset position",
    "ptz_calibration_confirmation": "Ptz calibration confirmation",
    "operating_mode": "Operating mode",
    "the_camera_is_not_working_for_a_long_time_saving_power":
        "The camera is not working for a long time, saving power",
    "the_camera_is_not_working_for_a_short_time_and_supports_remote_realtime_viewing":
        "The camera is not working for a short time, and supports remote real-time viewing",
    "event_video": "Event video",
    "continuous_video_recording": "Continuous video recording",
    // "night_vision_mode_automatic_des": "在夜间触发报警后自动打开白光灯",
    "night_vision_mode_colorfull": "Full color night vision",
    "night_vision_mode_colorfull_des":
        "Automatically switches between two modes depending on battery level",
    "night_vision_mode_dark": "Black and white night vision",
    "night_vision_mode_dark_des":
        "Automatically switches between two modes depending on battery level",
    "display_mode": "Display mode",
    // "video_recording_quality": "录像视频质量",
    // "video_recording_quality_hd_des": "高压缩编码格式的分辨率",
    // "video_recording_quality_ultraclear_des": "高分辨率高压缩编码格式",
    "wide_dynamic_range_mode": "Wide dynamic range mode",
    "close": "Close",
    "failed_to_delete_the_device": "Failed to delete the device",
    "light_switch": "Light switch",
    "light_color_temperature": "Light color temperature",
    "light_brightness": "Light brightness",
    "move": "Move",
    "doll": "Doll",
    "human_face": "Human face",
    "pet": "Pet",
    "face_detection": "Face detection",
    "alarm_on": "Alarm on",
    "automatically_pan_and_zoom_the_camera_to_track_moving_subjects":
        "Automatically pan and zoom the camera to track moving subjects",
    "all_day": "All day",
    "detection_area": "Detection area",
    "rotating_speed": "Rotating speed",
    "function_service_not_initialized": "Function service not initialized",
    "device_function_setting_successful": "Device function setting successful",
    "device_feature_update_failed": "Device feature update failed",
    "switch_to_hd": "Switch to hd",
    "switch_to_sd": "Switch to sd",
    "recording_forbid_to_operate":
        "While recording, please wait for the recording to end",
    "failed_to_switch_video_resolution": "Failed to switch video resolution",
    "an_error_occurred_while_switching_the_gimbal_correction_state":
        "An error occurred while switching the gimbal correction state",
    "storage_permission_denied_unable_to_save_screenshot":
        "Storage permission denied, unable to save screenshot",
    "the_screenshot_was_saved_successfully":
        "The screenshot was saved successfully",
    "failed_to_save_screenshot": "Failed to save screenshot",
    "saving_screenshots_abnormally": "Saving screenshots abnormally",
    "storage_permission_denied_unable_to_record_local_video":
        "Storage permission denied, unable to record local video",
    "start_recording_video": "Start recording video",
    "recording_video_saved": "Recording video saved",
    "an_error_occurred_while_toggling_night_vision":
        "An error occurred while toggling night vision",
    "an_error_occurred_while_switching_tracking_state":
        "An error occurred while switching tracking state",
    "microphone_permission_denied_unable_to_talk":
        "Microphone permission denied, unable to talk",
    "shared_users": "Shared users",
    "the_username_does_not_exist_or_another_error_occurred":
        "The username does not exist or another error occurred",
    "sharing_method": "Sharing method",
    "direct_sharing": "Direct sharing",
    "share_created_successfully": "Share created successfully",
    "share_creation_failed": "Share creation failed",
    "send_invitation": "Send invitation",
    "shared_with": "Shared with",
    "no_shared_users": "No shared users",
    "unbinding": "Unbinding",
    "view_permissions": "View permissions",
    "allow_users_to_view_camera_feed": "Allow users to view camera feed",
    "control_permissions": "Control permissions",
    "allow_users_to_operate_the_camera": "Allow users to operate the camera",
    "setting_permissions": "Setting permissions",
    "allow_users_to_change_camera_settings":
        "Allow users to change camera settings",
    "invalid_qr_code_data": "Invalid QR code data",
    "share_my_qr_code": "Share my QR code",
    "my_device_qr_code": "My device QR code",
    "configuring_new_guest_permissions": "Configuring new guest permissions",
    "no_events": "No events",
    "load_more": "Load more",
    "reset": "Reset",
    "all": "All",
    "my_device": "My device",
    "device_list_is_empty": "empty",
    "time_selection": "Time selection",
    "inquire": "Inquire",
    "image_download_failed": "Image download failed",
    "share_pictures": "Share pictures",
    "hello": "Hello",
    "no_qr_code_detected": "No QR code detected!",
    "total_capacity": "Total capacity:",
    "used": "Used:",
    "the_remaining_capacity": "The remaining capacity:",
    "device_information_updated_failed": "Device information updated failed",
    "preset": "Preset",
    "formatting_will_take_about_15_minutes_to_complete_please_be_patient":
        "Formatting will take about 1-5 minutes to complete, please be patient.",
    "storage_card_status": "Storage card status: {}",
    "format_startup_failed": "Format startup failed",
    "memory_card_formatting_completed": "Memory card formatting completed",
    "memory_card_is_being_formatted": "Memory card is being formatted",
    "memory_card_formatting_error": "Memory card formatting error",
    "no_memory_card": "Không có thẻ nhớ",
    "memory_card_error": "Memory card error",
    "ultraclear": "Ultra-clear",
    "the_memory_card_is_in_abnormal_state_please_format_it":
        "The memory card is in abnormal state. please format it.",
    "there_is_not_enough_space_on_the_memory_card_please_clear_up_some_space":
        "There is not enough space on the memory card. please clear up some space.",
    "the_memory_card_is_being_formatted_please_wait":
        "The memory card is being formatted, please wait",
    "unknown_memory_card_status": "Unknown memory card status",
    "memory_card_status": "Memory card status",
    "app_version": "App version",

    "the_device_does_not_support_memory_card_playback":
        "The device does not support memory card playback",
    "please_enter_your_username_below_to_confirm_the_deletion_of_the_account":
        "Please enter your username below to confirm the deletion of the account",
    "deleting_an_account": "Deleting an account",
    "connect_the_phones_wifi_to_the_device_hotspot":
        "Connect the phone's Wi-Fi to the device hotspot.",
    "1_please_connect_your_mobile_phone_to_the_hotspot_as_shown_in_the_diagram_below":
        "1. Please connect your mobile phone to the hotspot as shown in the diagram below.",
    "2_return_to_this_application_and_continue_adding_devices":
        "2. Return to this application and continue adding devices.",
    "switch_the_phones_wifi_to_the_device_hotspot":
        "Switch the phone's Wi-Fi to the device hotspot",
    "place_the_qr_code_in_front_of_your_device":
        "Place the qr code in front of your device",
    "scan_left_and_right_and_the_scan_is_complete_after_hearing_the_successful_scan_prompt_tone":
        "Scan left and right, and the scan is complete after hearing the successful scan prompt tone",
    "please_enter_a_valid": "Please enter a valid",
    "password": "Password",
    "information": "Information",
    "choose": "Choose",
    "if": "If",
    "yes": "Yes",
    "please_set_it_as": "Please set it as",
    "it_is_recommended_to_enable_and_configure":
        "It is recommended to enable and configure",
    "please_open": "Please open",
    "device_configuration_network": "Device configuration network",
    "connect": "Connect",
    "only_then_can_you_connect_to_the_device":
        "Only then can you connect to the device",
    "password_no_less_than": "Password no less than",
    "bit": "Bit",
    "not_detected": "Not detected",
    "please_install": "Please install",
    "current_version_number": "Current version number:",
    "latest_version_number": "Latest version number:",
    "indicator_light_switch": "Indicator light switch",
    "version": "Version",
    "flip_screen": "Flip screen",
    "an_exception_occurred_while_setting_device_capabilities":
        "An exception occurred while setting device capabilities:",
    "setting_exception": "Setting exception:",
    "direct_sharing_the_other_party_can_use_the_camera_directly":
        "Direct sharing: the other party can use the camera directly",
    "send_invitation_the_other_party_scans_the_invitation_qr_code_and_uses_the_camera":
        "Send invitation: the other party scans the invitation qr code and uses the camera",
    "please_ask_your_family_or_friends_to_open":
        "Please ask your family or friends to open",
    "scan_the_qr_code_below_to_use_the_device_with_you":
        "Scan the qr code below to use the device with you",
    "enable_local_bluetooth_permissions_for_the_app":
        "Enable local bluetooth permissions for the app",
    "enable_local_network_permissions_for_the_app":
        "Enable local network permissions for the app",
    "request_timed_out_please_try_again_later":
        "Request timed out, please try again later.",
    "you_have_enabled_push_notifications":
        "You have enabled push notifications",
    "required_permissions": "Required permissions",
    "open_settings": "Open settings",
    "granted_permission": "Granted permission",
    "error_saving_and_sharing_image": "Error saving and sharing image:",
    "quit": "Quit",
    "verification_code_error": "Verification code error",
    "internet_connection_available": "Internet connection available",
    "need_to_scan_qr_code": "Need to scan qr code",
    "device_connection_required": "Device connection required",
    "need_to_connect_to_device": "Need to connect to device",
    "des_allow_nearby_devices_permission":
        "Allow \"Nearby Devices\" Permission",
    "internet_connection_required": "Internet connection required",
    "internet_connection": "Internet connection",
    "bluetooth_switch": "Bluetooth switch",
    "switch_and_connect": "Switch and connect",

    "unable_to_request_the_specified_permission_please_check_the_app_permission_settings":
        "Unable to request the specified permission, please check the app permission settings",
    "ok": "Ok",
    "flashlight": "Flashlight",
    "photo_album": "Photo album",
    "this_permission_has_been_granted": "This permission has been granted",
    "none": "None",
    "horizontal_mirror": "Horizontal mirror",
    "vertically_mirror": "Vertically mirror",
    "cannot_share_with_yourself": "Cannot share with yourself",
    "user_id_lost": "User id lost",
    "check_username_request_failed": "Check username request failed",
    "firmware_upgrade_successful": "Firmware upgrade successful",
    "firmware_upgrade_failed": "Firmware upgrade failed",
    "video_not_play_message": "1、请检查设备电源\n2、尝试重启设备",
    "title_camera_private_mode": "是否要关闭摄像机",
    "message_camera_private_mode": "摄像机被关闭后，将停止录像和报警且无法修改设置",
    "camera_closed": "摄像机已关闭",
    "camera_closed_tips": "打开摄像机观看实时视频",
    "battery": "battery",
    "brightness": "brightness",
    "add": "add",
    "timing": "timing",
    "next_day": "Ngày hôm sau",
    "week1": "Mon",
    "week2": "Tue",
    "week3": "Wed",
    "week4": "Thur",
    "week5": "Fri",
    "week6": "Sat",
    "week7": "Sun",
    "weekday": "Weekday",
    "weekend": "Weekend",
    "everyday": "Every day",
    "duration": "duration",
    "delay": "delay",
    "second": "second",
    "seconds": "seconds",
    "minute": "minute",
    "minutes": "minutes",
    "signal_weak_tips":
        "Thiết bị của bạn có kết nối mạng kém. Tiếp tục nâng cấp?",

    ///新翻译
    ///通用
    "or": "OR",
    "agree_btn": "Đồng ý",
    "disagree_btn": "Không đồng ý",
    "continue_btn": "Tiếp tục",
    "continue_btn_format": "Tiếp tục",
    "go_to_set_btn": "Đi đến Thiết lập",
    "cancel_btn": "Hủy bỏ",
    "cancel_btn_format": "Hủy bỏ",

    "done_btn": "Xong",
    "add_btn": "Thêm vào",
    "ignore_btn": "Phớt lờ",
    "set_up_btn": "Cài đặt",
    "save_btn": "Cứu",
    "confirm_btn": "Xác nhận",
    "close_btn": "Đóng",
    "back_btn": "Mặt sau",
    "retry_btn": "Thử lại",
    "place_second": "@place giây",
    "place_mintue": "@place phút",
    "high_label": "Cao",
    "medium_label": "Trung bình",
    "low_label": "Thấp",
    "schedule_repeat_label": "Lặp lại",
    "next_day_label": "Ngày hôm sau",
    "download_btn": "Tải về",
    "delete_btn": "Xóa bỏ",
    "warning_title": "Lời nhắc nhở",
    "exit_btn": "Ra",
    "less_than_one_min_label": "Ít hơn 1 phút",
    "auto_label": "Tự động",
    "off_label": "Tắt",
    "on_label": "TRÊN",
    "success_label": "Thành công",
    "failed_label": "Lỗi",
    "info_label": "Thông tin",

    /// 首页
    "privacy_policy_dialog_title": "Chính sách bảo mật",
    "privacy_policy_label": "Chính sách bảo mật",
    "user_agreement_label": "Thỏa thuận người dùng",
    "privacy_policy_dialog_content":
        "Chào mừng bạn đến với Ứng dụng của chúng tôi! Chúng tôi rất coi trọng thông tin cá nhân và quyền riêng tư của bạn. Trước khi sử dụng dịch vụ của chúng tôi, vui lòng đọc kỹ “Chính sách bảo mật” và “Thỏa thuận người dùng”. Để cung cấp cho bạn dịch vụ tốt hơn, chúng tôi có thể yêu cầu các quyền như thông tin vị trí, quyền truy cập camera, quyền truy cập mạng, bluetooth, v.v. trong quá trình bạn sử dụng. Bạn có thể xem hoặc sửa đổi các quyền này trong Cài đặt hệ thống của mình, nhưng điều này có thể ảnh hưởng đến việc sử dụng một số tính năng.",
    "privacy_policy_label_mine": "Chính sách bảo mật",
    "user_agreement_label_mine": "Thỏa thuận người dùng",

    ///创建账号
    "create_account_btn": "Tạo tài khoản",
    "select_your_country_label": "Bạn sống ở nước nào?",
    "search_placeholder": "Tìm kiếm",
    "load_country_list_err":
        "Không tải được danh sách quốc gia, vui lòng thử lại.",
    "select_your_country_combobox_placeholder": "Chọn quốc gia",
    "email_label": "E-mail",
    "enter_email_address_label": "Địa chỉ email của bạn là gì?",
    "enter_email_address_placeholder": "Địa chỉ Email",
    "phone_label": "Điện thoại",
    "enter_phone_number_label": "Số điện thoại của bạn là gì?",
    "enter_phone_number_placeholder": "Số điện thoại",
    "privacy_and_agreement_checkbox_label":
        "Tôi đồng ý với “Chính sách bảo mật” và “Thỏa thuận người dùng” ",
    "account_exist_waning_content":
        "Tài khoản này đã tồn tại. Bạn có muốn đăng nhập không?",
    "privacy_warning_content":
        "Tôi đã đọc và đồng ý với “Chính sách bảo mật” và “Thỏa thuận người dùng” ",
    "enter_verification_code_label": "Nhập mã xác minh",
    "verification_code_has_sent_label": "Mã xác minh đã được gửi đến @place",
    "resend_verification_code_label": "Gửi lại sau @place",
    "didnt_get_verification_code_label": "Không nhận được mã xác minh?",
    "resend_btn": "Gửi lại",
    "set_password_label": "Hãy tạo mật khẩu của bạn",
    "confirm_password_placeholder": "Xác nhận mật khẩu",
    "enter_user_name_label": "Tên bạn là gì?",
    "name_placeholder": "Tên",
    "didnt_get_verification_code_check_span_label":
        "Vui lòng kiểm tra thư mục thư rác, nếu vẫn không thấy, vui lòng gửi lại.",

    ///登陆
    "sign_in_btn": "Đăng nhập",
    "welcome_to_login_label": "Chào mừng đến với",
    "enter_account_placeholder": "Email/Số điện thoại",
    "enter_password_placeholder": " Mật khẩu",
    "forgot_password_btn": "Quên mật khẩu?",
    "reset_password_title": "Quên mật khẩu",
    "reset_password_label":
        "Vui lòng nhập tài khoản mà bạn muốn đặt lại mật khẩu",
    "reset_password_success_msg":
        "Đã đặt lại mật khẩu thành công, vui lòng đăng nhập lại",
    "set_password_failed_err": "Không thể thiết lập mật khẩu",
    "registration_failed_err": "Đăng ký không thành công. Vui lòng thử lại.",
    "incorrect_account_format_err": "Định dạng tài khoản không hợp lệ",

    /// 权限
    "apply_permission_title": "Áp dụng Quyền",
    "apply_permission_label": "Các quyền sau đây là bắt buộc",
    "apply_permission_label_details":
        "Nhấp vào \"Tiếp tục\" để bắt đầu xin cấp quyền",
    "bluetooth_permission_label": "Bluetooth",
    "camera_permission_label": "Máy ảnh",
    "location_permission_label": "Vị trí",
    "push_notification_permission_label": "Thông báo đẩy",
    "bluetooth_permission_instruction":
        " Điều này sẽ cho phép ứng dụng tìm và kết nối các phụ kiện Bluetooth.",
    "camera_permission_instruction":
        "Cần quét mã QR để kết nối và liên kết thiết bị.",
    "local_network_permission_instruction":
        "Mục đích của ứng dụng kết nối với mạng cục bộ: cho phép ghép nối và kiểm soát các thiết bị được kết nối với mạng cục bộ.",
    "push_notification_permission_instruction":
        "Bạn sẽ nhận được thông báo ngay lập tức khi thiết bị kích hoạt báo động.",

    /// 添加设备
    "add_device_title": "Thêm thiết bị",
    "scan_qr_code_label": "Quét mã QR",
    "scan_qr_code_instruction_label":
        "Tìm mã QR trên thiết bị, bao bì hoặc hướng dẫn và đặt mã đó vào khung camera phía trên.",
    "searching_device_label": "Đang tìm kiếm thiết bị gần đó...",
    "manually_add_btn": "Không có mã QR? Thêm thủ công",
    "searching_device_result_label": "Thiết bị cần thêm: @place",
    "searching_device_menu_title": "Thiết bị đã phát hiện",
    "no_devices_found_label": "Không tìm thấy thiết bị nào",
    "no_devices_found_instruction_label":
        "Hãy thử thêm thiết bị theo cách thủ công",
    "allow_camera_access_label": "Cho phép truy cập máy ảnh",
    "set_permissions_btn": "Thiết lập Quyền",
    "apply_camera_permission_dialog_title": "Truy cập Camera",

    "turn_on_bluetooth_warning_label": "Bật Bluetooth",
    "turn_on_bluetooth_warning_instruction_label":
        "Bluetooth giúp thiết bị của bạn có thể được phát hiện",

    "turn_on_bluetooth_menu_title": "Cách bật bluetooth",
    "allow_bluetooth_permission_label": "Cho phép quyền Bluetooth",
    "turn_on_sys_bluetooth_label": "Bật Bluetooth",
    "apply_album_permission_dialog_title": "Truy cập Album",
    "choose_wifi_network_title": "Thiết lập Wi-Fi",
    "enter_wifi_information_label": " Nhập thông tin Wi-Fi",
    "wifi_name_placeholder": "Tên Wi-Fi",
    "next_step_btn": "Kế tiếp",
    "wifi_password_format_warning_content":
        "Vui lòng kiểm tra lại độ dài mật khẩu Wi-Fi bạn nhập, vì nó có thể khiến việc ghép nối không thành công.",
    "no_wifi_connetcion_warning_title": "Kết nối với mạng Wi-Fi",
    "no_wifi_connetcion_warning_content":
        "Chỉ sau khi điện thoại di động của bạn được kết nối với Wi-Fi thì mới có thể kết nối với thiết bị.",
    "5g_wifi_check_warning_content":
        "Đã chọn Wi-Fi 5G. Vui lòng xác nhận xem máy ảnh có hỗ trợ Wi-Fi 5G không. Nếu không, việc ghép nối sẽ không thành công.",
    "support_5g_wifi_btn": "Hỗ trợ Wi-Fi 5G",
    "connecting_device_label": "Kết nối",
    "try_again_btn": "Thử lại",
    "fail_to_add_device_label": "Không thêm được thiết bị",
    "naming_device_title": "Thêm thành công",
    "name_your_device_label": "Vui lòng đặt tên cho thiết bị của bạn",
    "enter_device_name_placeholder": "Tên thiết bị",
    "prepare_the_device_title": "Chuẩn bị thiết bị",

    ///未用到 或已改文案
    // "power_on_the_device_label": "Power on Device",
    // "power_on_the_device_content": "Plug the device into power or turn on the switch",
    // "reset_the_device_label": "Reset the Device",
    // "reset_the_device_content": "Press and hold RESET button, until you hear prompt",
    "above_operation_finished": "Hoạt động trên đã hoàn tất",
    "device_scan_qr_code_title": "Quét mã QR",
    "device_scan_qr_code_instruction":
        "Vui lòng hướng mã QR về phía camera, cách khoảng 10-20 cm. Khi nghe thấy âm báo nhắc, hãy nhấp vào \"Nghe âm báo nhắc\".",
    "hear_prompt_sound_btn": "Nghe âm báo nhắc",
    "failed_generate_qrcode_label": "Không tạo được Mã QR, hãy chạm để làm mới",
    "config_device_step1_label": "Bước 1. Bật thiết bị",
    "config_device_pown_on": "Thiết bị cắm thêm: cắm vào",
    "config_device_turn_on": "Thiết bị chạy bằng pin: bật",
    "config_device_step2_label": "Bước 2. Chờ kết nối",
    "config_device_waiting_make_sound": "Thiết bị phát ra tiếng \"ding-ding\"",
    "config_device_light_flashing": "Đèn báo thiết bị nhấp nháy",
    "config_device_no_response_to_reset":
        "Nếu không có phản hồi, vui lòng nhấn và giữ nút Reset trên máy ảnh",
    "apply_location_permission_dialog_title": "Sử dụng Vị trí của bạn",
    "apply_location_permission_dialog_content":
        "Cho phép truy cập vị trí để tự động lấy tên WiFi.",

    /// 设备列表
    "video_playback_btn": "Phát lại",
    "video_playback_msg_btn": "Phát lại",

    "share_btn": "Chia sẻ",
    "settings_btn": "Cài đặt",
    "camera_offline_label": "Máy ảnh đang ngoại tuyến",
    "help_btn": "Giúp đỡ",
    "offline_help_title": "Giúp đỡ",
    "offline_help_content":
        "1. Vui lòng xác nhận thiết bị đã được cấp nguồn. (Thiết bị sẽ ngoại tuyến trong một thời gian trong quá trình nâng cấp, vui lòng không cắt nguồn)\n2. Nếu bạn đang sử dụng kết nối Wi-Fi, vui lòng giữ máy ảnh và bộ định tuyến cách xa năm mét.\n3. Nếu bạn đang sử dụng kết nối có dây. vui lòng đảm bảo thiết bị được kết nối đúng cách với cáp mạng.\n4. Nếu bạn đang sử dụng kết nối 4G, vui lòng đảm bảo tín hiệu 4G tốt và gói dữ liệu vẫn hoạt động.\n5. Nếu không kết nối được thiết bị, vui lòng đặt lại thiết bị để kết nối lại.",
    "err_no_internet_connection": "Lỗi kết nối Internet.",
    "device_page_title": "Tất cả các thiết bị",
    "device_page_btn": "Thiết bị",
    "add_device_btn": "Thêm thiết bị",
    "device_list_empty_label": "Không có thiết bị",
    "cloud_service_btn": "Đám mâyRec",
    "4g_recharge_btn": "Nạp tiền",

    ///分享列表
    "share_device_title": "Thêm Chia sẻ",
    "empty_share_list_label": "Chia sẻ thiết bị với gia đình hoặc bạn bè.",
    "share_with_account_btn": "Chia sẻ với Tài khoản",
    "share_with_account_placeholder": "Nhập tài khoản",
    "invite_user_title": "Mời",
    "enter_the_account_placeholder": "Nhập tài khoản",
    "send_btn": "Gửi",
    "stop_share_btn": "Di dời",
    "stop_share_title": "Bạn có chắc chắn xóa thành viên này không?",
    "stop_share_success_msg": "Chia sẻ đã bị hủy",
    "failed_to_stop_share_err": "Không thể hủy chia sẻ",

    ///事件
    "event_page_title": "Sự kiện",
    "event_page_tab_btn": "Sự kiện",
    "no_events_label": "Không có sự kiện nào vào ngày này",
    "motion_event_type": "Cử động",
    "human_event_type": "Nhân loại",
    "pet_event_type": "Thú cưng",
    "vehicle_event_type": "Phương tiện giao thông",
    "event_list_bottom_line_label": "Không còn dữ liệu nữa",
    "event_filter_menu_title": "Bộ lọc sự kiện",
    "event_filter_all_device_combobox_item": "Tất cả các thiết bị",
    "event_filter_all_event_type": "Tất cả",
    "event_filter_device_label": "Thiết bị",
    "event_filter_event_type_label": "Loại sự kiện",
    "event_detail_title": "Chi tiết",
    "turn_on_push_warning_label": "Bật thông báo, cập nhật thông tin cho bạn",
    "turn_on_push_btn": "Bật lên",

    ///实时视频
    "reach_viewer_limit_warning_content": "Đã đạt giới hạn. Hãy thử lại sau",
    "retrieving_video_stream_label": "Đang truy xuất luồng video...",
    "err_failed_to_retrieve_video_label": "Không thể phát video trực tiếp",
    "recording_btn": "Ghi",
    "sound_btn": "Âm thanh",
    "pan_tilt_btn": "Quay ngang và nghiêng",
    "light_btn": "Ánh sáng",
    "screenshot_btn": "Ảnh chụp màn hình",
    "night_vision_btn": "Tầm nhìn ban đêm",
    "ai_track_btn": "Theo dõi AI",
    "calibrate_btn": "Hiệu chuẩn",
    "manual_alarm_btn": "Báo thức",

    "save_to_phone_album_label": "Đã lưu vào album điện thoại",
    "stop_recording_first_warning_label": "Xin hãy dừng ghi âm trước",
    "camera_off_label": "Tắt máy ảnh",
    "turn_on_camera_label": "Xin hãy bật máy ảnh",
    "apply_microphone_permission_dialog_title": "Sử dụng micrô của bạn",
    "apply_microphone_permission_dialog_content":
        "Cho phép truy cập micrô để đàm thoại hai chiều",
    "fhd_btn": "Độ phân giải FullHD",
    "hd_btn": "Độ nét cao",
    "sd_btn": "Thẻ: SD",
    "long_press_talking_warning_msg": "Nhấn và giữ để bắt đầu nói",
    "night_vision_mode_title": "Chế độ nhìn ban đêm",
    "manual_alarm_title": "Báo động thủ công",
    "manual_alarm_content":
        "Kích hoạt báo động bằng âm thanh.\nBáo động sẽ tự động tắt sau 15 giây.",

    ///doorbell
    "handup_btn": "Treo lên",
    "speak_on_btn": "Loa Bật",
    "speak_off_btn": "Tắt loa",
    "mic_on_btn": "Mic Bật",
    "mic_off_btn": "Tắt Mic",
    "quick_replies_btn": "Trả lời nhanh",
    "quick_reply_title": "Để lại tin nhắn",
    "quick_reply_message1": "Chào mừng! Chúng tôi sẽ có mặt ngay.",
    "quick_reply_message2": "Vui lòng để gói hàng ở bên ngoài.",
    "quick_reply_message3":
        "Xin lỗi, chúng tôi không quan tâm. Chúc bạn một ngày tốt lành.",
    "quick_reply_message4":
        "Xin chào! Có thể mất một lúc để trả lời. Vui lòng đợi.",

    /// 回放
    "tf_card_playback_title": "Thẻ TF",
    "speed_btn": "Tốc độ",
    "playback_speed_settings_title": "Tốc độ phát lại",
    "normal_speed_label": "Bình thường",
    "no_tf_card_playback_label": "Không có thẻ TF",
    "playback_no_data_label": "Không có Video Clip",
    "cloud_recording_nav_title": "Ghi Đám Mây",
    "enable_cloud_recording_warning_content":
        "Ghi âm đám mây vẫn chưa được bật",
    "subscribe_btn": "Đăng ký ngay",

    ///设置
    ///预设位
    "settings_preset_position_label": "Vị trí đặt trước",

    ///移动侦测
    "settings_shared_by_label": "Được chia sẻ bởi \"@place\"",
    "settings_motion_detection_label": "Phát hiện chuyển động",
    "motion_sensitivity_label": "Độ nhạy",
    "ai_filtering_label": "Lọc AI",
    "ai_filtering_human_label": "Phát hiện con người",
    "ai_filtering_pet_label": "Thú cưng",
    "ai_filtering_vehicle_label": "Phương tiện giao thông",
    "alarm_interval_label": "Khoảng thời gian báo động",
    "ai_tracking_label": "Theo dõi AI",
    "ai_tracking_instruction_label":
        "Tự động xoay và theo dõi chuyển động của cơ thể con người.",
    "auto_siren_label": "Còi báo động tự động",
    "detection_schedule_label": "Lịch trình",
    "pir_label": "PIR",
    "human_tracking_label": "Theo Dõi Con Người",
    "human_tracking_instruction_label":
        "Tự động xoay vòng và làm theo phong trào cơ thể con người.",
    "motion_tracking_label": "Theo Dõi Chuyển Động",
    "motion_tracking_instruction_label":
        "Tự động xoay vòng và làm theo chuyển động của đối tượng.",

    ///侦测时间段设置
    "detection_schedule_title": "Cài đặt lịch trình",
    "schedule_range_label": "Thời gian kích hoạt",
    "schedule_range_start_time_label": "Bắt đầu",
    "schedule_range_end_time_label": "Kết thúc",

    ///声音侦测
    "settings_sound_detection_label": "Phát hiện âm thanh",

    ///云台设置
    "settings_ptz_settings_label": "Cài đặt Pan-Tilt",
    "pan_tilt_calibaration_label": "Hiệu chuẩn Pan-Tilt",
    "calibration_warning_content":
        "Việc hiệu chỉnh máy ảnh sẽ mất khoảng 25 giây. Bạn có muốn tiếp tục không?",

    ///灯光设置
    "settings_light_settings_label": "Cài đặt ánh sáng",
    "light_settings_title": "Cài đặt ánh sáng",
    "light_switch_label": "Ánh sáng",
    "light_brightness_label": "Độ sáng",

    ///电池管理
    "settings_power_manager_label": "Quản lý nguồn điện",
    "battery_level_label": "Mức pin",
    "low_battery_alarm_label": "Báo động công suất thấp",
    "working_mode_label": "Chế độ làm việc",
    "working_mode_low_power_label": "Chế độ năng lượng thấp",
    "working_mode_low_power_instruction_label":
        "Camera không hoạt động khi PIR không được kích hoạt. Chỉ hỗ trợ ghi sự kiện.",
    "working_mode_continuous_label": "Chế độ làm việc liên tục",
    "working_mode_continuous_instruction_label":
        "Camera sẽ không chuyển sang chế độ ngủ, ngay cả khi không kích hoạt PIR. Hỗ trợ ghi hình 24/7.",
    "low_battery_event": "Pin yếu",

    ///视频设置
    "settings_video_settings_label": "Cài đặt video",
    "night_vision_mode_menu_title": "Chế độ nhìn ban đêm",
    "smart_mode_label": "Chế độ thông minh",
    "smart_mode_instruction_label":
        "Đèn trắng sẽ tự động bật khi báo động được kích hoạt vào ban đêm.",
    "color_mode_label": "Chế độ màu",
    "color_mode_instruction_label": "Đèn trắng sẽ tự động bật vào ban đêm.",
    "black_white_mode_label": "Chế độ đen trắng",
    "black_white_mode_intruction_label":
        "Camera cung cấp chế độ quan sát ban đêm đen trắng rõ nét, với đèn LED hồng ngoại.",
    "watermark_label": "Hình mờ",
    "streaming_quality_menu_title": "Chất lượng phát trực tuyến",
    "recording_quality_instruction_label":
        "Chất lượng hình ảnh khi camera đang ghi hình.",
    "fhd_label": "Độ phân giải FullHD",
    "fhd_instruction_label":
        "Chất lượng hình ảnh cao sẽ tiêu tốn nhiều dữ liệu hơn.",
    "hd_label": "Độ nét cao",
    "hd_instruction_label":
        "Chất lượng hình ảnh thấp sẽ giúp truyền phát mượt mà trong điều kiện mạng kém.",
    "streaming_quality_label": "Chất lượng phát trực tuyến",
    "streaming_quality_instruction_label":
        "Chất lượng hình ảnh khi bạn phát video trực tiếp.",
    "recording_quality_label": "Chất lượng ghi âm",
    "fhd_recording_instruction_label":
        "Độ phân giải 1080p cho hình ảnh phát lại rõ nét hơn.",
    "hd_recording_instruction_label":
        "Độ phân giải 720p đảm bảo hình ảnh mượt mà hơn ngay cả khi điều kiện mạng kém.",
    "recording_mode_label": "Chế độ ghi lại",
    "continuous_recording_label": "Ghi liên tục",
    "event_recording_label": "Ghi lại sự kiện",
    "flip_screen_label": "Màn hình lật",
    "anti_fliker_title": "Chống rung",
    "ir_mode_label": "Chế độ IR",
    "wdr_label": "WDR",

    ///音频设置
    "settings_audio_settings_label": "Cài đặt âm thanh",
    "microphone_switch_label": "Micrô",
    "mute_recording_label": "Tắt tiếng ghi âm",
    "mute_recording_instruction_label": "Tắt chức năng ghi âm khi quay video.",
    "speaker_switch_label": "Người nói",
    "speaker_volume_label": "Âm lượng loa",

    ///消息通知
    "settings_notification_label": "Thông báo",
    "notification_title": "Thông báo",

    "do_not_disturb_label": "Thông báo hệ thống",

    ///通用
    "settings_general_label": "Tổng quan",
    "device_name_label": "Tên thiết bị",
    "led_indicator_label": "Đèn báo LED",
    "device_id_label": "ID thiết bị",
    "firmware_update_label": "Phần mềm",
    "time_zone_label": "Múi giờ",
    "iccid_label": "Mã số thuế",
    "mac_address_label": "Địa chỉ Mac",
    "ip_address_label": "Địa chỉ IP",
    "signal_strength_label": "Cường độ tín hiệu",
    "copy_to_clipboard_msg": "Cường độ tín hiệu",
    "rename_device_title": "Đổi tên",
    "rename_device_placeholder": "Vui lòng nhập tên thiết bị",

    ///tf卡
    "tf_card_stroage_label": "Lưu trữ thẻ TF",
    "storage_settings_label": "Cài đặt lưu trữ",
    "total_label": "Tổng cộng",
    "used_label": "Đã sử dụng",
    "available_label": "Có sẵn",
    "format_btn": "Định dạng",
    "format_tf_card_warning_title": "Định dạng thẻ TF?",
    "format_tf_card_warning_instruction_label":
        "Định dạng thẻ TF sẽ xóa toàn bộ dữ liệu được lưu trữ trong đó và có thể mất vài phút. Bạn có chắc chắn muốn tiếp tục không?",
    "no_memory_card_warning_title": "Không có thẻ nhớ",
    "no_memory_card_warning_content":
        "Không phát hiện được thẻ nhớ, vui lòng lắp thẻ nhớ vào.",
    "format_startup_failed_prompt": "Không thể bắt đầu định dạng",
    "format_completed_prompt": "Định dạng đã hoàn tất",
    "formating_prompt": "Đang định dạng...",
    "format_failed_prompt": "Định dạng không thành công",
    "memory_card_abnormal_warning_content":
        "Trạng thái thẻ nhớ không bình thường, vui lòng định dạng thẻ nhớ.",
    "memory_card_is_full_warning_content":
        "Thẻ nhớ đã đầy, vui lòng giải phóng bớt dung lượng.",
    "memory_card_formatting_warning_content":
        "Thẻ nhớ đang được định dạng, vui lòng đợi...",
    "unknown_memory_card_status_warning_content":
        "Trạng thái thẻ nhớ không xác định",

    /// 固件升级
    "firmware_update_title": "Cập nhật phần mềm",
    "current_version_label": "Phiên bản hiện tại",
    "update_available_label": "Cập nhật có sẵn",
    "update_btn": "Cập nhật",
    "firmware_is_up_to_date_label": "Phần mềm đã được cập nhật.",
    "updating_label": "Đang cập nhật...",
    "updating_instruction_label":
        "Sẽ mất vài phút. Trong quá trình này, hãy bật nguồn máy ảnh.",
    "update_successful_label": "Cập nhật thành công",
    "update_failed_label": "Cập nhật không thành công",
    "firmware_upgrading_interrupt_warning_content":
        "Bạn có chắc chắn muốn thoát khỏi quá trình nâng cấp chương trình cơ sở không? Việc thoát có thể khiến quá trình nâng cấp không thành công.",
    "force_to_firmware_upgrade_title": "Đã phát hiện phần mềm mới",
    "force_to_firmware_upgrade_content":
        "Phiên bản này có những cập nhật quan trọng, vui lòng nâng cấp ngay lập tức.",
    "low_battery_upgrade_warning_label":
        "Mức pin dưới 30% có thể khiến quá trình nâng cấp không thành công. Bạn có muốn tiếp tục không?",
    "firmware_upgrade_timeout_label":
        "Quá trình nâng cấp đã hoàn tất, vui lòng khởi động lại thiết bị theo cách thủ công.",

    ///分享
    "settings_share_device_label": "Chia sẻ thiết bị",
    "settings_delete_device_btn": "Xóa thiết bị",
    "remove_device_warning_title": "Xóa thiết bị?",
    "remove_device_warning_content":
        "Bạn có chắc chắn muốn xóa thiết bị này không?",
    "remove_btn": "Di dời",

    ///我的
    "me_page_tab_btn": "Tôi",
    "region_label": "Vùng đất",
    "account_label": "ID tài khoản",
    "set_name_label": "Nhấn để đặt tên",
    "permission_settings_label": "Quyền ứng dụng",
    "app_language_label": "Ngôn ngữ APP",
    "contact_us_label": "Liên hệ với chúng tôi",
    "feedback_label": "Nhận xét",
    "faq_label": "Câu hỏi thường gặp",
    "clear_cache_label": "Xóa bộ nhớ đệm",
    "about_label": "Về",
    "cache_cleared_success_tip": "Đã xóa bộ nhớ đệm thành công",
    "account_settings_title": "Cài đặt tài khoản",
    "avatar_label": "Hình đại diện",
    "name_label": "Tên",
    "not_set_placeholder": "Chưa thiết lập",
    "change_password_label": "Thay đổi mật khẩu",
    "delete_account_label": "Xóa tài khoản",
    "sign_out_btn": "Đăng xuất",
    "delete_account_warning_title": "Xóa tài khoản?",
    "delete_account_warning_content":
        "Sau khi xóa, dữ liệu cá nhân của bạn sẽ bị xóa theo. Không thể hoàn tác.",
    "change_password_title": "Đặt mật khẩu mới",
    "password_guideline_label":
        "Mật khẩu phải bao gồm cả số và chữ cái và dài ít nhất 6 ký tự.",
    "current_password_placeholder": "Mật khẩu hiện tại",
    "new_password_placeholder": "Mật khẩu mới",
    "retype_new_password_placeholder": "Nhập lại mật khẩu mới",
    "about_title": "Về",
    "upload_log_label": "Tải lên Nhật ký",
    "clear_cache_warning_title": "Xóa bộ nhớ đệm?",
    "clear_cache_warning_content": "Tất cả dữ liệu lưu trữ cục bộ sẽ bị xóa.",
    "clear_cache_result_msg": "Đã xóa bộ nhớ đệm @placeMB ",
    "sign_out_warning_title": "Đăng xuất",
    "sign_out_warning_content":
        "Bạn có chắc chắn muốn đăng xuất khỏi tài khoản của mình không?",
    "change_nickname_title": "Thay đổi biệt danh",
    "upload_log_title": "Tải lên Nhật ký",
    "upload_to_cloud_label": "Tải lên đám mây",
    "send_to_others_label": "Gửi cho người khác",
    "select_language_title": "Chọn ngôn ngữ",
    "system_language_label": "Ngôn ngữ thiết bị",
    "system_language_instruction_label": "Thực hiện theo Cài đặt hệ thống",
    "chinese_instruction_label": "Tiếng Trung giản thể",
    "english_instruction_label": "Tiếng Anh",
    "spanish_instruction_label": "Tiếng Tây Ban Nha",
    "indonesian_instruction_label": "Tiếng Indonesia",
    "portuguese_instruction_label": "Tiếng Bồ Đào Nha (Brazil)",
    "russian_instruction_label": "Tiếng Nga",
    "traditional_chinese_instruction_label": "Trung Quốc, Truyền thống",
    "vietnamese_instruction_label": "Tiếng Việt",
    "thailand_instruction_label": "Tiếng Thái",
    "ukrainian_instruction_label": "‌Tiếng Ukraina",

    /// 灯
    "offline_label": "Ngoại tuyến",
    "power_label": "Quyền lực",
    "brightness_label": "Độ sáng",
    "battery_label": " Ắc quy ",
    "timer_label": "Bộ đếm thời gian",
    "edit_schedule_title": "Chỉnh sửa lịch trình",
    "monday_label": "Thứ Hai",
    "tuesday_label": "Thứ ba",
    "wednesday_label": "Thứ tư",
    "thursday_label": "Thứ năm",
    "friday_label": "Thứ sáu",
    "saturday_label": "Đã ngồi",
    "sunday_label": "Mặt trời",
    "everyday_label": "Hàng ngày",
    "weekend_label": "Ngày cuối tuần",
    "workday_label": "Ngày làm việc",
    "schedule_duration_label": "Khoảng thời gian",
    "type_set_placeholder": "Nhấn để đặt hẹn giờ",
    "edit_timer_btn": "Chỉnh sửa bộ đếm thời gian",
    "clear_timer_btn": "Xóa bộ đếm thời gian",
    "late_turn_off_title": "Tắt",
    "late_turn_off_second_label": "Sau @place giây",
    "late_turn_off_minute_label": "Sau @place phút",
    "connection_failed_warning_title": "Kết nối không thành công",
    "connection_failed_warning_content":
        "Có lỗi xảy ra. Vui lòng thử lại hoặc quay lại để kiểm tra thiết bị.",

    /// err
    "account_not_exist_err": "Tài khoản không tồn tại ở quốc gia này",
    "incorrect_password_err": "Mật khẩu không đúng",
    "incorrect_email_format_err": "Định dạng email không đúng",
    "incorrect_phone_number_format_err": "Định dạng số điện thoại không đúng",
    "account_already_exists_err": "Tài khoản đã tồn tại",
    "password_not_match_err": "Mật khẩu không khớp",
    "incorrect_password_format_err":
        "Mật khẩu phải bao gồm cả số và chữ, ít nhất 6 ký tự",
    "general_err": "Có gì đó không ổn, vui lòng thử lại",
    "cross_data_center_sharing_err":
        "Người dùng bạn mời đang ở các trung tâm dữ liệu khác nhau. Không được phép chia sẻ thiết bị do chính sách bảo vệ dữ liệu.",
    "share_with_yourself_err": "Không thể chia sẻ với chính mình.",
    "failed_to_share_device_err": "Không chia sẻ được thiết bị",
    "failed_to_remove_the_device_err": "Không thể xóa thiết bị",
    "operation_failed_err": "Thao tác không thành công. Vui lòng thử lại.",
    "download_forbid_err":
        "Vui lòng kết nối máy ảnh và điện thoại di động vào cùng một mạng Wi-Fi trước khi tải xuống.",
    "device_repeat_binding_err":
        "Thiết bị đã được liên kết với người dùng khác và không thể thêm lại được.",

    /// home
    "default_home_name_label": "Danh sách thiết bị",

    /// notification
    "notification_channel_doorbell_call": "Gọi chuông cửa",

    /// 增值业务
    "4g_recharge_reminder":
        "Thiết bị của bạn không còn dữ liệu. Vui lòng sạc lại trước.",
    "device_existed_err": "Thiết bị đã tồn tại. Vui lòng không thêm lại.",
    "qrcode_format_incorrect_err": "Định dạng mã QR không đúng",

    "schedule_duration_minute_label": "@place phút",
    "schedule_duration_second_label": "@place giây",
    "pan_tilt_calibaration_warning_label":
        "Quá trình hiệu chuẩn sẽ mất khoảng 25 giây. Bạn có muốn tiếp tục không?",

    "strong_4G_lock_warning_content":
        "Thiết bị của bạn bị khóa SIM và cần phải mở khóa trước khi bạn có thể sử dụng thẻ SIM của mình. ",
    "weak_4G_lock_warning_content":
        "Thiết bị của bạn bị khóa SIM. Để có trải nghiệm xem tốt hơn, bạn nên chuyển sang thẻ SIM tích hợp trong thiết bị của mình.",
    "my_plan_nav_title": "Dùng Gói",
    "iccid_number_label": "ICCID",
    "card_status_label": "TÌNH TRẠNG",
    "card_status_activated_label": "Đã kích hoạt",
    "card_status_unactivated_label": "Chưa kích hoạt",
    "card_status_discontinue_label": "Vô hiệu hóa",
    "card_status_suspended_label": "Tạm ngừng",
    "plan_usage_label": "SỬ DỤNG",
    "plan_used_label": "ĐÃ DÙNG:",
    "plan_remaining_label": "CÒN LẠI:",
    "plan_total_label": "TỔNG:",
    "my_packages_label": "GÓI CỦA TÔI",
    "plan_data_label": "DATA",
    "plan_data_unlimited_label": "Vô Hạn",
    "plan_validity_label": "HIỆU LỰC: ",
    "plan_days_label": "Ngày",
    "plan_coverage_label": "PHỤ SỞNG",
    "plan_expired_date_label": "HSD",
    "plan_top_up_btn": "NẠP TIỀN",
    "current_plan_label": "Đang Dùng",
    "unused_plan_label": "Chưa Kích Hoạt",
    "device_not_in_list_warning_content":
        "Thiết bị không còn trong danh sách của bạn",
    "unauth_card_warning_label":
        "Thẻ 4G bạn đang sử dụng là thẻ không chính thức. Chúng tôi không thể cung cấp dịch vụ tra cứu dung lượng giao thông và nạp tiền cho thẻ này. Vui lòng liên hệ với đơn vị phát hành thẻ của bạn.",
    "choose_plan_nav_title": "Chọn Gói",
    "plan_price_label": "GIÁ",
    "plan_recommand_tag_label": "ĐỀ XUẤT",
    "buy_now_btn": "Mua Ngay",
    "complete_order_nav_title": "Thanh Toán",
    "plan_details_label": "THÔNG TIN BỔ SUNG",
    "plan_network_label": "NHÀ MANG",
    "plan_type_label": "LOẠI GÓI",
    "plan_type_1_content_label":
        "Gói này chỉ áp dụng cho phát trực tiếp và phát lại thẻ TF.",
    "plan_validity_policy_label": "CHÍNH SÁCH HIỆU LỤC",
    "plan_validity_policy_content_label":
        "Dịch vụ hoạt động trong vòng 5 phút sau khi đăng ký, với thời hạn hiệu lực bắt đầu ngay lập tức",
    "plan_refound_policy_label": "CHÍNH SÁCH HOÀN TIỀN",
    "plan_refound_policy_content_label":
        "Bạn sẽ được hoàn tiền trong vòng 15 ngày kể từ ngày đăng ký nếu sự gián đoạn dịch vụ do lỗi sản phẩm vẫn chưa được giải quyết thông qua bộ phận hỗ trợ khách hàng.",
    "plan_complete_order_btn": "HOÀN TẤT ĐƠN HÀNG",
    "create_order_failed_err": "Tạo đơn thất bại",
    "cancel_order_msg": "Đã hủy đơn",
    "faild_take_effect_plan_err": "Không kích hoạt gói (ID: #xxxx)",
    "get_help_btn": "Hỗ trợ",
    "success_payment_msg": "Thanh toán thành công",
    "orders_nav_title": "Lịch Sử Đơn Hàng",
    "orders_order_id_label": "Mã Đơn Hàng: ",
    "orders_order_date_label": "Ngày Đặt Hàng: ",
    "orders_order_status_label": "Tình Trạng Đơn: ",
    "orders_iccid_label": "ICCID: ",
    "orders_deviceid_label": "ID Thiết Bị: ",
    "orders_completed_status_label": "Đã Thanh Toán",
    "orders_pending_status_label": "Chờ Thanh Toán",
    "orders_no_histry_warning_label": "Không có lịch sử đơn hàng",
    "services_page_title": "Dịch vụ",
    "services_page_btn": "Dịch vụ",
    "my_plan_btn": "Kế Hoạch Của Tôi",
    "services_cloud_recording_label": "Ghi Đám Mây",
    "services_cloud_recording_content":
        "Dựa trên Google. Tăng sức mạnh cho máy ảnh của bạn với các bản ghi video trên đám mây",
    "services_4g_top_up_label": "Hàng hóa thẻ 4G",
    "services_4g_top_up_content":
        "Giữ thiết bị của bạn được kết nối ở bất cứ đâu với 4G Top-Up-up",
    "services_ai_alert_label": "AI cảnh báo",
    "services_ai_alert_content":
        "Nhận thông báo chạy bằng AI ngay lập tức để giữ cho không gian của bạn an toàn",
    "coming_soon_label": "Sắp ra mắt",
    "cloud_recording_intro_content":
        "Lưu bản ghi của bạn, ngay cả khi bạn máy ảnh hoặc thẻ SD bị hỏng.",
    "subscribe_btn_in_buy_page": "Đặt mua",
    "choose_device_instruction": "Chọn thiết bị để bật dịch vụ",
    "not_supported_label": "Không được hỗ trợ",
    "payment_method_menu_title": "Phương Thức Thanh Toán: ",
    "credit_card_label": "Thẻ Tín Dụng",
    "paypal_label": "Paypal",
    "pay_now_btn": "Thanh Toán Ngay Bâ",
    "success_payment_content": "Cảm ơn vì đã chọn dịch vụ của chúng tôi!",
    "days_left_label": "@place ngày còn lại",
    "no_available_plans_label": "Không tìm thấy gói khả dụng",
    "no_active_plans_label": "Bạn không có gói dịch vụ đang hoạt động",
    "top_up_4g_intro_content":
        "Nạp tiền cho thiết bị 4G của bạn ngay để duy trì an ninh liên tục!",
  };
}
