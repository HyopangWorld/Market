# Market

상품 정보를 보여주는 Market App

<div><img src="./content/play.gif" style="width:40%; float:left"/>
<img src="./content/delete.gif" style="width:40%; float:left"/></div>

<br>

###  Feature
1. 상품 목록 정보
2. 상품 목록 Pull-to-Refresh
3. 상품 상세 화면
4. 상품 상세 전환 Animation
5. 상품 상세 이미지 Slider

<br>

### 설계
<img src=""/>

<br>

### 구현

| **구분** |   **역할**   |
| :------------- | :--------------- |
| **Views** |
|       ViewController       |       UIViewController에 bind하기 위한 공통 ViewController        |
|       ProductListViewController       |       d        |
|       ProductListViewModel       |       d       |
|       ProductListModel       |       d        |
|       ProductDetailViewController       |      d        |
|       ProductDetailViewModel       |       d        |
|       ProductDetailModel       |       d        |
| **Components** |
|       ProductListCell       |       d        |
| **Models** |
|       ProductResponse       |       d        |
|       Product       |       d       |
| **Constans** |
|       Constants       |       d        |
| **Network** |
|       ProductsNetwork       |       d        |
|       ProductsNetworkImpl       |       d       |
| **Extension** |
|       Observable+Distinct       |       d        |
|       Reactive+UIViewController       |       d        |

<br>

### Trouble Shooting
1. API 호출이 잦아 느려지는 현상
=> 기존의 가지고 있던 데이터를 VC끼리 공유하여 사용하되, 지역 리스트의 데이터가 변화할 때만 API를 재 호출하여 업데이트한다.

- VC 이동 시 날씨 데이터를 함께 보낸다.

```swift
let searchVC = segue.destination as! SearchViewController
for vc in navigationController!.viewControllers {
if vc is ListViewController {
// 날씨 데이터 전달 (api 중복 호출 방지)
searchVC.weatherList = (vc as! ListViewController).weatherList
}
}
```
- 추가 된 날씨 데이터만 업데이트해 호출한다.


```swift
// 날씨 리스트 업데이트 추가 (api 호출)
let _ = getWeatherApi([
"timezone" : selectedCell.timezone!,
"latitude" : selectedCell.latitude!,
"logitude" : selectedCell.longitude!])
```
<br>

2. 검색할 때 글자 입력할때마다 검색되어 데이터가 엉키는 현상
=> 입력 1초 후 검색이 되도록 delay를 준다. ( 입력중일 떄는 확인 중이라는 메세지 전달 )

```swift
// 안내문 출력
self.matchingItems = []
notice = "도시 확인 중..."
self.resultTable.reloadData()

// 이전 perform 삭제
NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.searchResults(_:)), object: nil)
// 1초 뒤 검색
self.perform(#selector(self.searchResults(_:)), with: nil, afterDelay: 1.0)

```

<br>

### Git Management

- master : 개발 및 최종본

**Commit Message 양식은 아래의 규칙을 따른다.**  

```
1. 기능 구현 : 구현 기능 - 내용 
2. 버그 수정 : 수정 기능 변경 전 -> 변경 후
```


### Style Guide

- Swift Dev Version : 5
- Deployment Target : 13.0
- Device Target : iPhone
- Code Architecture : MVVM
