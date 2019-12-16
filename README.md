# Market

상품 정보를 보여주는 Market App

<div><img src="./contents/feature_list.gif" style="width:40%; float:left"/>
<img src="./contents/feature_detail.gif" style="width:40%; float:left"/></div>

<br>

###  Feature
1. 상품 목록 정보
2. 상품 목록 Pull-to-Refresh
3. 상품 상세 화면
4. 상품 상세 전환 Animation
5. 상품 상세 이미지 Slider

<br>

### 설계

<br>

### 구현

| **구분** |   **역할**   |
| :------------- | :--------------- |
| **Views** |
|       ViewController       |       UIViewController에 bind하기 위한 공통 ViewController        |
|       ProductListViewController       |               |
|       ProductListViewModel       |              |
|       ProductListModel       |               |
|       ProductDetailViewController       |              |
|       ProductDetailViewModel       |               |
|       ProductDetailModel       |               |
| **Components** |
|       ProductListCell       |               |
| **Models** |
|       ProductResponse       |               |
|       Product       |              |
| **Constans** |
|       Constants       |               |
| **Network** |
|       ProductsNetwork       |               |
|       ProductsNetworkImpl       |              |
| **Extension** |
|       Observable+Distinct       |               |
|       Reactive+UIViewController       |               |

<br>

### Trouble Shooting

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
