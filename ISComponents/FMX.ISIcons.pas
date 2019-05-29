unit FMX.ISIcons;

interface

uses
  System.SysUtils, System.Classes, System.Types, System.UITypes, System.DateUtils, System.Generics.Collections, FMX.Utils, FMX.Types, FMX.Controls, FMX.Objects, FMX.StdCtrls, FMX.Graphics, FMX.MultiResBitmap,
  FMX.Ani, FMX.Effects, System.Actions, FMX.ActnList, FMX.Layouts, FMX.Filter.Effects, System.Rtti,

  FMX.IS_Base;


Type

   TIS_IconTypes = (
                  IS_3d_rotation,
                  IS_accessibility,
                  IS_access_alarm,
                  IS_access_alarms,
                  IS_access_time,
                  IS_account_balance,
                  IS_account_balance_wallet,
                  IS_account_box,
                  IS_account_child,
                  IS_account_circle,
                  IS_adb,
                  IS_add,
                  IS_add_alarm,
                  IS_add_box,
                  IS_add_circle,
                  IS_add_circle_outline,
                  IS_add_shopping_cart,
                  IS_add_to_photos,
                  IS_adjust,
                  IS_airplanemode_off,
                  IS_airplanemode_on,
                  IS_alarm,
                  IS_alarm_add,
                  IS_alarm_off,
                  IS_alarm_on,
                  IS_album,
                  IS_android,
                  IS_announcement,
                  IS_apps,
                  IS_archive,
                  IS_arrow_back,
                  IS_arrow_drop_down,
                  IS_arrow_drop_down_circle,
                  IS_arrow_drop_up,
                  IS_arrow_forward,
                  IS_aspect_ratio,
                  IS_assessment,
                  IS_assignment,
                  IS_assignment_ind,
                  IS_assignment_late,
                  IS_assignment_return,
                  IS_assignment_returned,
                  IS_assignment_turned_in,
                  IS_assistant_photo,
                  IS_attachment,
                  IS_attach_file,
                  IS_attach_money,
                  IS_audiotrack,
                  IS_autorenew,
                  IS_av_timer,
                  IS_backspace,
                  IS_backup,
                  IS_battery_20,
                  IS_battery_30,
                  IS_battery_50,
                  IS_battery_60,
                  IS_battery_80,
                  IS_battery_90,
                  IS_battery_alert,
                  IS_battery_charging_20,
                  IS_battery_charging_30,
                  IS_battery_charging_50,
                  IS_battery_charging_60,
                  IS_battery_charging_80,
                  IS_battery_charging_90,
                  IS_battery_charging_full,
                  IS_battery_full,
                  IS_battery_std,
                  IS_battery_unknown,
                  IS_beenhere,
                  IS_block,
                  IS_bluetooth,
                  IS_bluetooth_audio,
                  IS_bluetooth_connected,
                  IS_bluetooth_disabled,
                  IS_bluetooth_searching,
                  IS_blur_circular,
                  IS_blur_linear,
                  IS_blur_off,
                  IS_blur_on,
                  IS_book,
                  IS_bookmark,
                  IS_bookmark_outline,
                  IS_border_all,
                  IS_border_bottom,
                  IS_border_clear,
                  IS_border_color,
                  IS_border_horizontal,
                  IS_border_inner,
                  IS_border_left,
                  IS_border_outer,
                  IS_border_right,
                  IS_border_style,
                  IS_border_top,
                  IS_border_vertical,
                  IS_brightness_1,
                  IS_brightness_2,
                  IS_brightness_3,
                  IS_brightness_4,
                  IS_brightness_5,
                  IS_brightness_6,
                  IS_brightness_7,
                  IS_brightness_auto,
                  IS_brightness_high,
                  IS_brightness_low,
                  IS_brightness_medium,
                  IS_brush,
                  IS_bug_report,
                  IS_business,
                  IS_cached,
                  IS_cake,
                  IS_call,
                  IS_call_end,
                  IS_call_made,
                  IS_call_merge,
                  IS_call_missed,
                  IS_call_received,
                  IS_call_split,
                  IS_camera,
                  IS_camera_alt,
                  IS_camera_front,
                  IS_camera_rear,
                  IS_camera_roll,
                  IS_cancel,
                  IS_cast,
                  IS_cast_connected,
                  IS_center_focus_strong,
                  IS_center_focus_weak,
                  IS_chat,
                  IS_check,
                  IS_check_box,
                  IS_check_box_outline_blank,
                  IS_chevron_left,
                  IS_chevron_right,
                  IS_class,
                  IS_clear,
                  IS_clear_all,
                  IS_close,
                  IS_closed_caption,
                  IS_cloud,
                  IS_cloud_circle,
                  IS_cloud_done,
                  IS_cloud_download,
                  IS_cloud_off,
                  IS_cloud_queue,
                  IS_cloud_upload,
                  IS_collections,
                  IS_colorize,
                  IS_color_lens,
                  IS_comment,
                  IS_compare,
                  IS_computer,
                  IS_contacts,
                  IS_content_copy,
                  IS_content_cut,
                  IS_content_paste,
                  IS_control_point,
                  IS_control_point_duplicate,
                  IS_create,
                  IS_credit_card,
                  IS_crop,
                  IS_crop_16_9,
                  IS_crop_3_2,
                  IS_crop_5_4,
                  IS_crop_7_5,
                  IS_crop_din,
                  IS_crop_free,
                  IS_crop_landscape,
                  IS_crop_original,
                  IS_crop_portrait,
                  IS_crop_square,
                  IS_dashboard,
                  IS_data_usage,
                  IS_dehaze,
                  IS_delete,
                  IS_description,
                  IS_desktop_mac,
                  IS_desktop_windows,
                  IS_details,
                  IS_developer_mode,
                  IS_devices,
                  IS_dialer_sip,
                  IS_dialpad,
                  IS_directions,
                  IS_directions_bike,
                  IS_directions_bus,
                  IS_directions_car,
                  IS_directions_ferry,
                  IS_directions_subway,
                  IS_directions_train,
                  IS_directions_transit,
                  IS_directions_walk,
                  IS_disc_full,
                  IS_dnd_forwardslash,
                  IS_dnd_on,
                  IS_dns,
                  IS_dock,
                  IS_domain,
                  IS_done,
                  IS_done_all,
                  IS_do_not_disturb,
                  IS_drafts,
                  IS_drive_eta,
                  IS_dvr,
                  IS_edit,
                  IS_email,
                  IS_equalizer,
                  IS_error,
                  IS_event,
                  IS_event_available,
                  IS_event_busy,
                  IS_event_note,
                  IS_exit_to_app,
                  IS_expand_less,
                  IS_expand_more,
                  IS_explicit,
                  IS_explore,
                  IS_exposure,
                  IS_exposure_minus_1,
                  IS_exposure_minus_2,
                  IS_exposure_plus_1,
                  IS_exposure_plus_2,
                  IS_exposure_zero,
                  IS_extension,
                  IS_face_unlock,
                  IS_fast_forward,
                  IS_fast_rewind,
                  IS_favorite,
                  IS_favorite_outline,
                  IS_file_download,
                  IS_file_pdf_box,
                  IS_file_upload,
                  IS_filter,
                  IS_filter_1,
                  IS_filter_2,
                  IS_filter_3,
                  IS_filter_4,
                  IS_filter_5,
                  IS_filter_6,
                  IS_filter_7,
                  IS_filter_8,
                  IS_filter_9,
                  IS_filter_9_plus,
                  IS_filter_b_and_w,
                  IS_filter_center_focus,
                  IS_filter_drama,
                  IS_filter_frames,
                  IS_filter_hdr,
                  IS_filter_list,
                  IS_filter_none,
                  IS_filter_tilt_shift,
                  IS_filter_vintage,
                  IS_find_in_page,
                  IS_find_replace,
                  IS_flag,
                  IS_flare,
                  IS_flash_auto,
                  IS_flash_off,
                  IS_flash_on,
                  IS_flight,
                  IS_flip,
                  IS_flip_to_back,
                  IS_flip_to_front,
                  IS_folder,
                  IS_folder_open,
                  IS_folder_shared,
                  IS_folder_special,
                  IS_format_align_center,
                  IS_format_align_justify,
                  IS_format_align_left,
                  IS_format_align_right,
                  IS_format_bold,
                  IS_format_clear,
                  IS_format_color_fill,
                  IS_format_color_reset,
                  IS_format_color_text,
                  IS_format_indent_decrease,
                  IS_format_indent_increase,
                  IS_format_italic,
                  IS_format_line_spacing,
                  IS_format_list_bulleted,
                  IS_format_list_numbered,
                  IS_format_paint,
                  IS_format_quote,
                  IS_format_size,
                  IS_format_strikethrough,
                  IS_format_textdirection_l_to_r,
                  IS_format_textdirection_r_to_l,
                  IS_format_underline,
                  IS_forum,
                  IS_forward,
                  IS_fullscreen,
                  IS_fullscreen_exit,
                  IS_functions,
                  IS_gamepad,
                  IS_games,
                  IS_gesture,
                  IS_get_app,
                  IS_gps_fixed,
                  IS_gps_not_fixed,
                  IS_gps_off,
                  IS_grade,
                  IS_gradient,
                  IS_grain,
                  IS_grid,
                  IS_grid_off,
                  IS_grid_on,
                  IS_group,
                  IS_group_add,
                  IS_group_work,
                  IS_hdr_off,
                  IS_hdr_on,
                  IS_hdr_strong,
                  IS_hdr_weak,
                  IS_headset,
                  IS_headset_mic,
                  IS_healing,
                  IS_hearing,
                  IS_help,
                  IS_highlight_remove,
                  IS_high_quality,
                  IS_history,
                  IS_home,
                  IS_hotel,
                  IS_https,
                  IS_image,
                  IS_image_aspect_ratio,
                  IS_import_export,
                  IS_inbox,
                  IS_info,
                  IS_info_outline,
                  IS_input,
                  IS_insert_chart,
                  IS_insert_comment,
                  IS_insert_drive_file,
                  IS_insert_emoticon,
                  IS_insert_invitation,
                  IS_insert_link,
                  IS_insert_photo,
                  IS_invert_colors,
                  IS_invert_colors_off,
                  IS_invert_colors_on,
                  IS_iso,
                  IS_keyboard,
                  IS_keyboard_alt,
                  IS_keyboard_arrow_down,
                  IS_keyboard_arrow_left,
                  IS_keyboard_arrow_right,
                  IS_keyboard_arrow_up,
                  IS_keyboard_backspace,
                  IS_keyboard_capslock,
                  IS_keyboard_control,
                  IS_keyboard_hide,
                  IS_keyboard_return,
                  IS_keyboard_tab,
                  IS_keyboard_voice,
                  IS_label,
                  IS_label_outline,
                  IS_landscape,
                  IS_language,
                  IS_laptop,
                  IS_laptop_chromebook,
                  IS_laptop_mac,
                  IS_laptop_windows,
                  IS_launch,
                  IS_layers,
                  IS_layers_clear,
                  IS_leak_add,
                  IS_leak_remove,
                  IS_lens,
                  IS_link,
                  IS_list,
                  IS_live_help,
                  IS_local_airport,
                  IS_local_atm,
                  IS_local_attraction,
                  IS_local_bar,
                  IS_local_cafe,
                  IS_local_car_wash,
                  IS_local_convenience_store,
                  IS_local_drink,
                  IS_local_florist,
                  IS_local_gas_station,
                  IS_local_grocery_store,
                  IS_local_hospital,
                  IS_local_hotel,
                  IS_local_laundry_service,
                  IS_local_library,
                  IS_local_mall,
                  IS_local_movies,
                  IS_local_offer,
                  IS_local_parking,
                  IS_local_pharmacy,
                  IS_local_phone,
                  IS_local_pizza,
                  IS_local_play,
                  IS_local_post_office,
                  IS_local_print_shop,
                  IS_local_restaurant,
                  IS_local_see,
                  IS_local_shipping,
                  IS_local_taxi,
                  IS_location_city,
                  IS_location_disabled,
                  IS_location_history,
                  IS_location_off,
                  IS_location_on,
                  IS_location_searching,
                  IS_lock,
                  IS_lock_open,
                  IS_lock_outline,
                  IS_looks,
                  IS_looks_3,
                  IS_looks_4,
                  IS_looks_5,
                  IS_looks_6,
                  IS_looks_one,
                  IS_looks_two,
                  IS_loop,
                  IS_loupe,
                  IS_loyalty,
                  IS_mail,
                  IS_map,
                  IS_markunread,
                  IS_markunread_mailbox,
                  IS_memory,
                  IS_menu,
                  IS_merge_type,
                  IS_message,
                  IS_messenger,
                  IS_mic,
                  IS_mic_none,
                  IS_mic_off,
                  IS_mms,
                  IS_mode_comment,
                  IS_mode_edit,
                  IS_mood,
                  IS_more,
                  IS_more_horiz,
                  IS_more_vert,
                  IS_mouse,
                  IS_movie,
                  IS_movie_creation,
                  IS_multitrack_audio,
                  IS_my_library_add,
                  IS_my_library_books,
                  IS_my_library_music,
                  IS_my_location,
                  IS_nature,
                  IS_nature_people,
                  IS_navigate_before,
                  IS_navigate_next,
                  IS_navigation,
                  IS_network_cell,
                  IS_network_locked,
                  IS_network_wifi,
                  IS_new_releases,
                  IS_nfc,
                  IS_note_add,
                  IS_notifications,
                  IS_notifications_none,
                  IS_notifications_off,
                  IS_notifications_on,
                  IS_notifications_paused,
                  IS_not_interested,
                  IS_now_wallpaper,
                  IS_now_widgets,
                  IS_no_sim,
                  IS_open_in_browser,
                  IS_open_in_new,
                  IS_open_with,
                  IS_pages,
                  IS_pageview,
                  IS_palette,
                  IS_panorama,
                  IS_panorama_fisheye,
                  IS_panorama_horizontal,
                  IS_panorama_vertical,
                  IS_panorama_wide_angle,
                  IS_party_mode,
                  IS_pause,
                  IS_pause_circle_fill,
                  IS_pause_circle_outline,
                  IS_payment,
                  IS_people,
                  IS_people_outline,
                  IS_perm_camera_mic,
                  IS_perm_contact_cal,
                  IS_perm_data_setting,
                  IS_perm_device_info,
                  IS_perm_identity,
                  IS_perm_media,
                  IS_perm_phone_msg,
                  IS_perm_scan_wifi,
                  IS_person,
                  IS_person_add,
                  IS_person_outline,
                  IS_phone,
                  IS_phonelink,
                  IS_phonelink_off,
                  IS_phone_android,
                  IS_phone_bluetooth_speaker,
                  IS_phone_forwarded,
                  IS_phone_in_talk,
                  IS_phone_iphone,
                  IS_phone_locked,
                  IS_phone_missed,
                  IS_phone_paused,
                  IS_photo,
                  IS_photo_album,
                  IS_photo_camera,
                  IS_photo_library,
                  IS_picture_in_picture,
                  IS_pin_drop,
                  IS_place,
                  IS_playlist_add,
                  IS_play_arrow,
                  IS_play_circle_fill,
                  IS_play_circle_outline,
                  IS_play_download,
                  IS_play_install,
                  IS_play_shopping_bag,
                  IS_plus_one,
                  IS_poll,
                  IS_polymer,
                  IS_portable_wifi_off,
                  IS_portrait,
                  IS_print,
                  IS_public,
                  IS_publish,
                  IS_query_builder,
                  IS_question_answer,
                  IS_queue,
                  IS_queue_music,
                  IS_quick_contacts_dialer,
                  IS_quick_contacts_mail,
                  IS_radio,
                  IS_radio_button_off,
                  IS_radio_button_on,
                  IS_rate_review,
                  IS_receipt,
                  IS_recent_actors,
                  IS_redeem,
                  IS_redo,
                  IS_refresh,
                  IS_remove,
                  IS_remove_circle,
                  IS_remove_circle_outline,
                  IS_remove_red_eye,
                  IS_reorder,
                  IS_repeat,
                  IS_repeat_one,
                  IS_replay,
                  IS_reply,
                  IS_reply_all,
                  IS_report,
                  IS_report_problem,
                  IS_restaurant_menu,
                  IS_restore,
                  IS_ring_volume,
                  IS_room,
                  IS_rotate_left,
                  IS_rotate_right,
                  IS_satellite,
                  IS_save,
                  IS_schedule,
                  IS_school,
                  IS_screen_lock_landscape,
                  IS_screen_lock_portrait,
                  IS_screen_lock_rotation,
                  IS_screen_rotation,
                  IS_sd_card,
                  IS_sd_storage,
                  IS_search,
                  IS_security,
                  IS_select_all,
                  IS_send,
                  IS_settings,
                  IS_settings_applications,
                  IS_settings_backup_restore,
                  IS_settings_bluetooth,
                  IS_settings_cell,
                  IS_settings_display,
                  IS_settings_ethernet,
                  IS_settings_input_antenna,
                  IS_settings_input_component,
                  IS_settings_input_composite,
                  IS_settings_input_hdmi,
                  IS_settings_input_svideo,
                  IS_settings_overscan,
                  IS_settings_phone,
                  IS_settings_power,
                  IS_settings_remote,
                  IS_settings_system_daydream,
                  IS_settings_voice,
                  IS_share,
                  IS_shop,
                  IS_shopping_basket,
                  IS_shopping_cart,
                  IS_shop_two,
                  IS_shuffle,
                  IS_signal_cellular_0_bar,
                  IS_signal_cellular_1_bar,
                  IS_signal_cellular_2_bar,
                  IS_signal_cellular_3_bar,
                  IS_signal_cellular_4_bar,
                  IS_signal_cellular_connected_no_internet_0_bar,
                  IS_signal_cellular_connected_no_internet_1_bar,
                  IS_signal_cellular_connected_no_internet_2_bar,
                  IS_signal_cellular_connected_no_internet_3_bar,
                  IS_signal_cellular_connected_no_internet_4_bar,
                  IS_signal_cellular_no_sim,
                  IS_signal_cellular_null,
                  IS_signal_cellular_off,
                  IS_signal_wifi_0_bar,
                  IS_signal_wifi_1_bar,
                  IS_signal_wifi_2_bar,
                  IS_signal_wifi_3_bar,
                  IS_signal_wifi_4_bar,
                  IS_signal_wifi_off,
                  IS_signal_wifi_statusbar_1_bar,
                  IS_signal_wifi_statusbar_2_bar,
                  IS_signal_wifi_statusbar_3_bar,
                  IS_signal_wifi_statusbar_4_bar,
                  IS_signal_wifi_statusbar_connected_no_internet,
                  IS_signal_wifi_statusbar_connected_no_internet_1,
                  IS_signal_wifi_statusbar_connected_no_internet_2,
                  IS_signal_wifi_statusbar_connected_no_internet_3,
                  IS_signal_wifi_statusbar_connected_no_internet_4,
                  IS_signal_wifi_statusbar_not_connected,
                  IS_signal_wifi_statusbar_null,
                  IS_sim_card,
                  IS_sim_card_alert,
                  IS_skip_next,
                  IS_skip_previous,
                  IS_slideshow,
                  IS_smartphone,
                  IS_sms,
                  IS_sms_failed,
                  IS_snooze,
                  IS_sort,
                  IS_speaker,
                  IS_speaker_notes,
                  IS_spellcheck,
                  IS_star,
                  IS_stars,
                  IS_star_half,
                  IS_star_outline,
                  IS_star_rate,
                  IS_stay_current_landscape,
                  IS_stay_current_portrait,
                  IS_stay_primary_landscape,
                  IS_stay_primary_portrait,
                  IS_stop,
                  IS_storage,
                  IS_store,
                  IS_store_mall_directory,
                  IS_straighten,
                  IS_style,
                  IS_subject,
                  IS_subtitles,
                  IS_supervisor_account,
                  IS_surround_sound,
                  IS_swap_calls,
                  IS_swap_horiz,
                  IS_swap_vert,
                  IS_swap_vert_circle,
                  IS_switch_camera,
                  IS_switch_video,
                  IS_sync,
                  IS_sync_disabled,
                  IS_sync_problem,
                  IS_system_update,
                  IS_system_update_tv,
                  IS_tab,
                  IS_tablet,
                  IS_tablet_android,
                  IS_tablet_mac,
                  IS_tab_unselected,
                  IS_tag_faces,
                  IS_tap_and_play,
                  IS_terrain,
                  IS_textsms,
                  IS_texture,
                  IS_text_format,
                  IS_theaters,
                  IS_thumbs_up_down,
                  IS_thumb_down,
                  IS_thumb_up,
                  IS_timelapse,
                  IS_timer,
                  IS_timer_10,
                  IS_timer_3,
                  IS_timer_auto,
                  IS_timer_off,
                  IS_time_to_leave,
                  IS_toc,
                  IS_today,
                  IS_tonality,
                  IS_track_changes,
                  IS_traffic,
                  IS_transform,
                  IS_translate,
                  IS_trending_down,
                  IS_trending_neutral,
                  IS_trending_up,
                  IS_tune,
                  IS_turned_in,
                  IS_turned_in_not,
                  IS_tv,
                  IS_undo,
                  IS_unfold_less,
                  IS_unfold_more,
                  IS_usb,
                  IS_verified_user,
                  IS_vertical_align_bottom,
                  IS_vertical_align_center,
                  IS_vertical_align_top,
                  IS_vibration,
                  IS_videocam,
                  IS_videocam_off,
                  IS_video_collection,
                  IS_view_agenda,
                  IS_view_array,
                  IS_view_carousel,
                  IS_view_column,
                  IS_view_day,
                  IS_view_headline,
                  IS_view_list,
                  IS_view_module,
                  IS_view_quilt,
                  IS_view_stream,
                  IS_view_week,
                  IS_visibility,
                  IS_visibility_off,
                  IS_voicemail,
                  IS_voice_chat,
                  IS_volume_down,
                  IS_volume_mute,
                  IS_volume_off,
                  IS_volume_up,
                  IS_vpn_key,
                  IS_vpn_lock,
                  IS_wallet_giftcard,
                  IS_wallet_membership,
                  IS_wallet_travel,
                  IS_warning,
                  IS_watch,
                  IS_wb_auto,
                  IS_wb_cloudy,
                  IS_wb_incandescent,
                  IS_wb_irradescent,
                  IS_wb_sunny,
                  IS_web,
                  IS_whatshot,
                  IS_wifi_lock,
                  IS_wifi_tethering,
                  IS_work,
                  IS_wrap_text,
                  IS_zip_box);

   [ComponentPlatformsAttribute (pidWin32 or pidWin64 or pidOSX32 or pidiOSDevice32 or pidiOSDevice64 or pidAndroid)]
   TIS_Icon = Class(TIS_Control)
      Private
         FIcon       : TIS_IconTypes;
         FillEffect  : TFillRGBEffect;
         FIconColor  : TAlphaColor;
         FBitmap     : TBitmap;
         FIconMargin : Integer;
         procedure SetIconColor(const Value: TAlphaColor);
         procedure SetIcon (const Value: TIS_IconTypes);
         procedure SetIconMargin(const Value: Integer);
      Protected
         Procedure Paint; Override;
      Public
         Constructor Create(aOwner : TComponent); Override;
      Published
         Property Icon       : TIS_IconTypes  Read FIcon       Write SetIcon;
         Property IconColor  : TAlphaColor    Read FIconColor  Write SetIconColor;
         Property IconMargin : Integer        Read FIconMargin Write SetIconMargin;
         property Align;
         property Anchors;
         property ClipChildren default False;
         property ClipParent default False;
         property Cursor default crDefault;
         property DragMode default TDragMode.dmManual;
         property EnableDragHighlight default True;
         property Enabled default True;
         property Locked default False;
         property Height;
         property HitTest default True;
         property Padding;
         property Opacity;
         property Margins;
         property PopupMenu;
         property Position;
         property RotationAngle;
         property RotationCenter;
         property Scale;
         property Size;
         property Visible default True;
         property Width;
         {Drag and Drop events}
         property OnDragEnter;
         property OnDragLeave;
         property OnDragOver;
         property OnDragDrop;
         property OnDragEnd;
         {Mouse events}
         property OnClick;
         property OnDblClick;
         property OnMouseDown;
         property OnMouseMove;
         property OnMouseUp;
         property OnMouseWheel;
         property OnMouseEnter;
         property OnMouseLeave;
         property OnPainting;
         property OnPaint;
         property OnResize;
      End;

   [ComponentPlatformsAttribute (pidWin32 or pidWin64 or pidOSX32 or pidiOSDevice32 or pidiOSDevice64 or pidAndroid)]
   TIS_CircleIcon = Class(TIS_CircleControl)
      Private
         function  GetIcon        : TIS_IconTypes;
         function  GetIconColor   : TAlphaColor;
         function  GetIconMargin  : Integer;
         function  GetIconOpacity : SIngle;
         procedure SetIcon       (const Value: TIS_IconTypes);
         procedure SetIconColor  (const Value: TAlphaColor);
         procedure SetIconMargin (const Value: Integer);
         procedure SetIconOpacity(const Value: SIngle);
      Protected
         FIcon : TIS_Icon;
      Public
         Constructor Create(aOwner : TComponent); Override;
      Published
         Property Icon        : TIS_IconTypes  Read GetIcon        Write SetIcon;
         Property IconColor   : TAlphaColor    Read GetIconColor   Write SetIconColor;
         Property IconMargin  : Integer        Read GetIconMargin  Write SetIconMargin;
         Property IconOpacity : SIngle         Read GetIconOpacity Write SetIconOpacity;
         property Align;
         property Anchors;
         property ClipChildren default False;
         property ClipParent default False;
         property Cursor default crDefault;
         property DragMode default TDragMode.dmManual;
         property EnableDragHighlight default True;
         property Enabled default True;
         property Locked default False;
         property Height;
         property HitTest default True;
         property Padding;
         property Opacity;
         property Margins;
         property PopupMenu;
         property Position;
         property RotationAngle;
         property RotationCenter;
         property Scale;
         property Size;
         property Visible default True;
         property Width;
         {Drag and Drop events}
         property OnDragEnter;
         property OnDragLeave;
         property OnDragOver;
         property OnDragDrop;
         property OnDragEnd;
         {Mouse events}
         property OnClick;
         property OnDblClick;
         property OnMouseDown;
         property OnMouseMove;
         property OnMouseUp;
         property OnMouseWheel;
         property OnMouseEnter;
         property OnMouseLeave;
         property OnPainting;
         property OnPaint;
         property OnResize;
      End;

Procedure Register;

implementation

{$R ISIcones.res}

Procedure Register;
Begin
RegisterComponents('Imperium Software', [TIS_Icon, TIS_CircleIcon]);
End;


{ TISIcone }

constructor TIS_Icon.Create(aOwner: TComponent);
begin
inherited;
FillEffect        := TFillRGBEffect.Create(Self);
FillEffect.Stored := False;
FBitmap           := TBitmap.Create;
FIconMargin       := 4;
FIconColor        := TAlphaColors.Black;
Icon              := TIS_IconTypes.IS_add;
end;

procedure TIS_Icon.Paint;
Var
   Rect  : TRectF;
   Save  : TCanvasSaveState;
begin
inherited;
Save := Canvas.SaveState;
Rect := FBitmap.BoundsF;
Rect := Rect.FitInto(LocalRect);
Rect.Inflate(-FIconMargin, -FIconMargin);
Canvas.DrawBitmap(FBitmap, FBitmap.BoundsF, Rect, Opacity);
Canvas.RestoreState(Save);
if (csDesigning in ComponentState) then DrawDesignBorder;
end;

procedure TIS_Icon.SetIconColor(const Value: TAlphaColor);
begin
FIconColor := Value;
SetIcon(FIcon);
end;

procedure TIS_Icon.SetIcon(const Value: TIS_IconTypes);
Var
   Ind : Integer;
   RC  : TResourceStream;
begin
FIcon := Value;
Ind   := Integer(Icon)+1;
if Ind > 0 then
   Begin
   RC := TResourceStream.Create(HInstance, 'ISIcon_'+Ind.ToString, RT_RCDATA);
   FBitmap.LoadFromStream(RC);
   RC.DisposeOf;
   FillEffect.Color := FIconColor;
   if FillEffect.Color <> TAlphaColorRec.Black Then
      Begin
      FillEffect.ProcessEffect(FBitmap.Canvas, FBitmap, 0);
      End;
   End
Else
   FBitmap.Clear(0);
Repaint;
end;

procedure TIS_Icon.SetIconMargin(const Value: Integer);
begin
FIconMargin := Value;
Repaint;
end;

{ TIS_CircleIcon }

constructor TIS_CircleIcon.Create(aOwner: TComponent);
begin
inherited;
FIcon         := TIS_Icon.Create(Self);
FIcon.Parent  := Self;
FIcon.Align   := TAlignLayout.Client;
FIcon.Color   := TAlphaColorRec.Null;
FIcon.Stored  := False;
FIcon.HitTest := False;
FIcon.BringToFront;
Color        := TAlphaColorRec.White;
end;

function TIS_CircleIcon.GetIcon: TIS_IconTypes;
begin
Result := FIcon.Icon;
end;

function TIS_CircleIcon.GetIconColor: TAlphaColor;
begin
Result := FIcon.IconColor
end;

function TIS_CircleIcon.GetIconMargin: Integer;
begin
result := FIcon.IconMargin;
end;

function TIS_CircleIcon.GetIconOpacity: SIngle;
begin
Result := FIcon.Opacity;
end;

procedure TIS_CircleIcon.SetIcon(const Value: TIS_IconTypes);
begin
FIcon.Icon := Value;
end;

procedure TIS_CircleIcon.SetIconColor(const Value: TAlphaColor);
begin
FIcon.IconColor := Value;
end;

procedure TIS_CircleIcon.SetIconMargin(const Value: Integer);
begin
FIcon.IconMargin := Value;
end;

procedure TIS_CircleIcon.SetIconOpacity(const Value: SIngle);
begin
FIcon.Opacity := Value;
end;



end.
