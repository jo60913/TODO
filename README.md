# todo
TODO app 使用史蒂芬‧柯維（Stephen Covey）提出的「時間管理矩陣」來為待辦事項做分類。並於每日UTC 00:00 (GMT+8 8:00)通知使用者完成任務度
在Udemy中完成課程。並在課後自己延伸出任務導覽頁面、設定畫面與自動推播功能
https://www.udemy.com/course/flutter-made-easy-zero-to-mastery/

## 成品
* 網站版：https://todo-app-251e7.web.app/

## 功能
* 任務導覽：顯示使用者當前任務完成度，與各分類的完成度
* 任務分類：顯示我有任務分類，點擊任務分類可以查看該分類內有完成與未完成的待辦事項。任務分類主要以「時間管理矩陣」做為基礎。
* 設定：目前只有推播功能的開啟與關閉。開啟後UTC 00:00時間會收到目前所有任務的完成度，或提醒使用者新增任務。

## 安裝
將專案使用git clone下載即可
```
git clone https://github.com/jo60913/TODO
```

## 設置
Flutter 版本為3.16.8  
Dart 版本為3.2.5

## Build and Run
在Android studio IDE下 直接點擊Run

## Api專案的Github
https://github.com/jo60913/Todo-api

## 用法
使用BLoC模式+clean architecture架構開發，flutter_adaptive_scaffold套件做適配。目前成功運行在在Android、網頁上。
目前資料庫存放在Firebase Firestore。Udemy課程是在flutter呼叫cloud_firestore套件來直接存取內容。所以目前待辦事項還是以cloud_firestore來呼叫為主。
只有在設定->推播設定的值是取自後端/get/notification api，更新推播設定時呼叫/update/notification api
* 路由使用go_router套件，路由設定檔案在lib/application/core/routes.dart當中
* 登入與個人資料頁面使用firebase_ui_auth套件的SignInScreen、ProfileScreen產生。所以目前還只有英文內容
* BLoC使用flutter_bloc套件

## 操作
* Udemy完課後的app狀況  
![image](https://github.com/jo60913/TODO/blob/main/readmeimage/az_recorder_20240616_114225.gif?raw=true)
* 自己延伸Udemy後的app  
![image](https://github.com/jo60913/TODO/blob/main/readmeimage/az_recorder_20240616_090920.gif?raw=true)

## 結構
專案結構
```
.
├── application
│   ├── app
│   │   ├── basic_app.dart
│   │   └── cubit
│   │       ├── auth_cubit.dart
│   │       └── auth_state.dart
│   ├── component
│   │   └── todo_entry_item
│   │       ├── bloc
│   │       │   ├── todo_entry_item_cubit.dart
│   │       │   └── todo_entry_item_state.dart
│   │       ├── todo_entry_item.dart
│   │       └── view_state
│   │           ├── todo_entry_item_error.dart
│   │           ├── todo_entry_item_loaded.dart
│   │           └── todo_entry_item_loading.dart
│   ├── core
│   │   ├── constants.dart
│   │   ├── firebase_api.dart
│   │   ├── form_value.dart
│   │   ├── go_router_observer.dart
│   │   ├── page_config.dart
│   │   └── routes.dart
│   └── page
│       ├── create_todo_collection_page
│       │   ├── bloc
│       │   │   ├── create_todo_collection_page_cubit.dart
│       │   │   └── create_todo_collection_page_state.dart
│       │   └── create_todo_collection_page.dart
│       ├── create_todo_entry
│       │   ├── bloc
│       │   │   ├── create_to_do_entry_page_cubit.dart
│       │   │   └── create_to_do_entry_page_state.dart
│       │   └── create_todo_entry_page.dart
│       ├── dashboard
│       │   ├── bloc
│       │   │   ├── todo_dashboard_cubit.dart
│       │   │   └── todo_dashboard_state.dart
│       │   ├── dashboard.dart
│       │   └── view_states
│       │       ├── todo_dashboard_error.dart
│       │       ├── todo_dashboard_loaded.dart
│       │       └── todo_dashboard_loading.dart
│       ├── detail
│       │   ├── bloc
│       │   │   ├── to_do_detail_cubit.dart
│       │   │   └── to_do_detail_state.dart
│       │   ├── delete_todo_entry
│       │   │   ├── bloc
│       │   │   │   ├── todo_entry_delete_cubit.dart
│       │   │   │   └── todo_entry_delete_state.dart
│       │   │   └── view_states
│       │   │       └── todo_entry_delete_error.dart
│       │   ├── todo_detail.dart
│       │   └── view_state
│       │       ├── todo_detail_error.dart
│       │       ├── todo_detail_loaded.dart
│       │       └── todo_detail_loading.dart
│       ├── home
│       │   ├── bloc
│       │   │   ├── navigation_todo_cubit.dart
│       │   │   └── navigation_todo_state.dart
│       │   ├── component
│       │   │   └── login_button.dart
│       │   └── home.dart
│       ├── overview
│       │   ├── bloc
│       │   │   ├── todo_overview_cubit.dart
│       │   │   └── todo_overview_cubit_state.dart
│       │   ├── overview_page.dart
│       │   └── view_states
│       │       ├── todo_overview_error.dart
│       │       ├── todo_overview_loaded.dart
│       │       └── todo_overview_loading.dart
│       └── setting
│           └── setting_page.dart
├── core
│   └── use_case.dart
├── data
│   ├── data_source
│   │   ├── interface
│   │   │   ├── api_remote_data_source.dart
│   │   │   ├── todo_local_data_source_interface.dart
│   │   │   └── todo_remote_data_source_interface.dart
│   │   ├── local
│   │   │   ├── hive_local_data_source.dart
│   │   │   └── memory_local_data_source.dart
│   │   ├── mapper
│   │   │   ├── todo_collection_mapper.dart
│   │   │   └── todo_entry_mapper.dart
│   │   └── remote
│   │       ├── api_remote_data_source.dart
│   │       └── firestore_remote_data_source.dart
│   ├── exception
│   │   └── exception.dart
│   ├── model
│   │   ├── api
│   │   │   ├── api_response.dart
│   │   │   ├── api_response.g.dart
│   │   │   ├── get_token_response.dart
│   │   │   └── get_token_response.g.dart
│   │   ├── todo_collection_model.dart
│   │   ├── todo_collection_model.g.dart
│   │   ├── todo_entry_model.dart
│   │   └── todo_entry_model.g.dart
│   └── repository
│       ├── todo_repository_local.dart
│       ├── todo_repository_mock.dart
│       └── todo_repository_remote.dart
├── domain
│   ├── entity
│   │   ├── todo_collection.dart
│   │   ├── todo_collection_and_entry.dart
│   │   ├── todo_entry.dart
│   │   └── unique_id.dart
│   ├── failure
│   │   └── failures.dart
│   ├── repository
│   │   └── todo_repository.dart
│   └── usecase
│       ├── create_fcm_token.dart
│       ├── create_todo_collection.dart
│       ├── create_todo_entry.dart
│       ├── delete_todo_collection.dart
│       ├── delete_todo_entry.dart
│       ├── load_fcm_setting.dart
│       ├── load_todo_collection_and_entry.dart
│       ├── load_todo_collections.dart
│       ├── load_todo_entry.dart
│       ├── load_todo_entry_ids_for_collection.dart
│       ├── update_fcm_value.dart
│       └── update_todo_entry.dart
├── firebase_options.dart
├── main.dart
└── resource
    ├── app_color.dart
    ├── app_color_array.dart
    └── app_string.dart

```

## 打包
更改versionCode 在pubspec.yaml 當中version1.0.0+n 修改N的內容即可    
打包aab 在build.gradle中設定好key.properties所以只要打
```
flutter build appbundle
```
指令。aab檔就會出現在 {專案路徑}/Todo/build/app/outputs/bundle/release/app-release.aab

## 使用套件
* go_router 路由
* flutter_adaptive_scaffold 畫面的適配
* flutter_bloc bloc模式使用套件
* json_annotation json與對象轉換
* firebase_ui_auth 登入畫面
* cloud_firestore 連接Firebase Firestore
* firebase_crashlytics Firebase崩潰紀錄
* fl_chart  用來顯示任務總覽頁面的比例圖
* firebase_messaging 推播使用套件
* flutter_launcher_icons 切割app icon使用套件
* dio 連接api使用的網路套件