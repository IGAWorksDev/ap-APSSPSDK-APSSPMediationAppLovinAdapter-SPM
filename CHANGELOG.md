# APSSPMediationAppLovin

`AppLovin (Waterfall)` 미디에이션 어댑터 변경 이력

> **각 항목의 제목이 SPM 설치 시 입력하는 버전(태그)입니다.**
> SemVer 3자리 제약으로 어댑터 버전이 인코딩되어 발행됩니다. (`8.1.7.0` → `8010700.0.0`)

---

## 최소 요구사항

| 항목 | 요구 버전 |
|---|---|
| **APSSPSDK (코어)** | `3.4.0` 이상 |
| **iOS Deployment Target** | **`13.0` 이상** |
| Swift Tools | `5.9` 이상 |
| 네트워크 SDK | `AppLovinSDK` |

**설치**

```swift
.package(url: "https://github.com/IGAWorksDev/ap-APSSPSDK-APSSPMediationAppLovinAdapter-SPM.git",
         exact: "13060400.0.0")
```

> `Other Linker Flags` 에 **`-ObjC`** 추가 필수. 미설정 시 어댑터가 런타임에 인식되지 않습니다.

---

## 13060400.0.0

AppLovinSDK `13.6.4` 대응 · SPM 개별 배포 시작
어댑터 버전 `13.6.4.0`

2026-08-31

## 13060300.0.0

AppLovinSDK `13.6.3` 대응
어댑터 버전 `13.6.3.0`

2026-08-31

## 13060200.0.0

AppLovinSDK `13.6.2` 대응
어댑터 버전 `13.6.2.0`

2026-08-31

## 13060100.0.0

AppLovinSDK `13.6.1` 대응
어댑터 버전 `13.6.1.0`

2026-08-31

## 13060000.0.0

AppLovinSDK `13.6.0` 대응
어댑터 버전 `13.6.0.0`

2026-08-31

## 13050100.0.0

AppLovinSDK `13.5.1` 대응
어댑터 버전 `13.5.1.0`

2026-08-31

## 13050000.0.0

AppLovinSDK `13.5.0` 대응
어댑터 버전 `13.5.0.0`

2026-08-31

## 13040000.0.0

AppLovinSDK `13.4.0` 대응
어댑터 버전 `13.4.0.0`

2026-08-31

