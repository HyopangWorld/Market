//
//  ProductDummyData.swift
//  MarketTests
//
//  Created by 김효원 on 15/12/2019.
//  Copyright © 2019 김효원. All rights reserved.
//

import Foundation

@testable import Market

struct ProductsDummyData {
    static let productsJSONString = """
    {
      "statusCode": 200,
      "body": [
        {
          "thumbnail_520": "https://image.idus.com/image/files/4e47e2fa54e84fedbe56b610475adf0c_520.jpg",
          "id": 1,
          "seller": "골든팜",
          "title": "겨울에 아삭한여름복숭아먹기"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/53c325fec52342a7962936c843f6e03f_520.jpg",
          "id": 2,
          "seller": "시나브로와이너리",
          "title": "시나브로 로제"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/9c8cb5b62bfd4429891f656e0e13ec25_520.jpg",
          "id": 3,
          "seller": "율리스",
          "title": "장난꾸러기 웰시코기 머그"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/a5f9d17377e24473a4c74516b3c21022_520.jpg",
          "id": 4,
          "seller": "디에스타(Diesta)",
          "title": "[정품스왈/써지컬] 스퀘어 아이스큐빅 목걸이"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/ef823f2a2d1b45d0994df6a05fdb4c77_520.jpg",
          "id": 5,
          "seller": "토리팩토리",
          "title": "낚시왕 뚱뚱이 석고방향제"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/558756ee52274b529f9568b3288a3444_520.jpg",
          "id": 6,
          "seller": "움키키드(UMKIKID)",
          "title": "오늘은 내가 주인공"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/41090c9d17ef4dd38e932b1aa1905a45_520.jpg",
          "id": 7,
          "seller": "MERLIC(멀릭)",
          "title": "Dangle Bangle"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/7310efa7ced34bb6b246fd5ecf14b7fc_520.jpg",
          "id": 8,
          "seller": "체리의프랑스자수",
          "title": "라탄오브제 자수"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/8732dd5b4bd74467925d290165f8034e_520.jpg",
          "id": 9,
          "seller": "김성균그농부(황토쉼터농원)",
          "title": "💖환절기감기💖생강청 착즙원액"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/6e63fc31782245a5b8aad36e834ef98d_520.jpg",
          "id": 10,
          "seller": "라피오",
          "title": "겨울할인🐻포근💛 윈터베어 스트랩케이스🐻"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/e9b52d8ecb6f48e8bd89770a5b2b2865_520.jpg",
          "id": 11,
          "seller": "미향농원",
          "title": "[미향농원] 프리미엄 샤인머스켓"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/e3d31b15d00c4b5fab5244581d7a7067_520.jpg",
          "id": 12,
          "seller": "뻬르 스튜디오 (per studio)",
          "title": "🎄편지 속의 크리스마스 트리 'perry'🎄"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/1c738381611546efac53998ae1e4897e_520.jpg",
          "id": 13,
          "seller": "woodelight(우딜라이트)",
          "title": "화이트오크 서랍장"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/bae3395887584d7ca81bf0640775f30c_520.jpg",
          "id": 14,
          "seller": "채원이네 뜨개 공방",
          "title": " ⭐️파격할인😌포근한 겨울 감성🍂 뱀딸기 에어팟케이"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/0a24780d151d4c2d93bba99de28cf19d_520.jpg",
          "id": 15,
          "seller": "작은작업실",
          "title": "반려동물 키링+일러스트 배경화면/ 드로잉키링"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/6674da45ca964ad6a638ccf0f0462a62_520.jpg",
          "id": 16,
          "seller": "바나플",
          "title": "어린이집 유치원 레이저 이름 각인 식판"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/29daf1e6fc114be493dfd325feb66f64_520.jpg",
          "id": 17,
          "seller": "함박꽃 피는날",
          "title": " [런칭할인]생모짜치즈 함박스테이크 4장 520g"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/f358e728ff7041bcb4da7f27724f2ebf_520.jpg",
          "id": 18,
          "seller": "화봄화-화창한봄날, 화",
          "title": "우리집동물굿즈 스노우볼(소)"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/d278b390a1e54751b197b9d475442732_520.jpg",
          "id": 19,
          "seller": "고은트리",
          "title": "크리스마스 목화 솜 리스"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/686fd7acb90047e99d876ac8d680beef_520.jpg",
          "id": 20,
          "seller": "🌻겅겅공방🌻",
          "title": "[입점할인]몽글몽글🙂스마일 일러스트"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/3363d2b7e7274fe883922555af736101_520.jpg",
          "id": 21,
          "seller": "스튜디오,공지(studio,0g)",
          "title": "0g 체크파우치 & 메이크업 파우치"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/6066d4ca36a940f29ba87346bf42c2f4_520.jpg",
          "id": 22,
          "seller": "열대과일농장🍌유진팡이야기🌴",
          "title": "[농장직송] 비가림 하우스 감귤 무료배송"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/6ab1b08277e54ed6b35735013dd2c0bf_520.jpg",
          "id": 23,
          "seller": "DANI",
          "title": "🎄겨울시즌 스마일 걱정인형🎄"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/c637b3aeee66475583013032f36bef57_520.jpg",
          "id": 24,
          "seller": "구기",
          "title": " 3초솝 (지성용 클렌징)"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/32e5909bb6a146a3b635af07e0ce00a4_520.jpg",
          "id": 25,
          "seller": "잇츠깡스",
          "title": "세겹거즈 누빔 조끼/양면 극세사 / 맘 커플"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/5b65a4c29711411ab8144afbb35e354f_520.jpg",
          "id": 26,
          "seller": "투티거스🐾호랑이다과점",
          "title": "❣28일 발송🍋레몬이 통째로ᐛ🍋 레몬케이크🍰"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/8980659e481448c9ae13f5b87a4d1c8a_520.jpg",
          "id": 27,
          "seller": "melimelo",
          "title": "Black heart ring"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/74bb348449fb4e3186dab2ca8b5e8ad7_520.jpg",
          "id": 28,
          "seller": "프롬지캔들",
          "title": "[선물추천] 까눌레캔들&치즈캔들 선물세트"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/3382ff15def34a469d46507b09ddafa2_520.jpg",
          "id": 29,
          "seller": "kimdoolgi",
          "title": "[모던트리] 르템스 멀바우"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/366103ab59324ca49911a67ca4fffca6_520.jpg",
          "id": 30,
          "seller": "연이네HOME",
          "title": "꿀 듬뿍 ~유자차"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/5b3118496f6e4d02b7ad358a386c2549_520.jpg",
          "id": 31,
          "seller": "몽키플랜트",
          "title": "산소뿜 귀욤뿜 통통 스투키 화분"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/84801642edfe47a182f701c457659484_520.jpg",
          "id": 32,
          "seller": "온다스튜디오",
          "title": "아일렛 오픈 레이스 송치, 5cm"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/857a374c2fc642dab6b96009d295f841_520.jpg",
          "id": 33,
          "seller": "루아루체",
          "title": "고퀄❤️ 마카롱 멀티 카드지갑"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/aebb4cd0f16d4628a9fd1edd6b110a9a_520.jpg",
          "id": 34,
          "seller": "🌸코카네(COCANE)",
          "title": "작고 소듕한 원고지 쇼핑백"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/5476e05d86b24ff299f0357b5ad6a0b1_520.jpg",
          "id": 35,
          "seller": "수피아코코",
          "title": "린넨 자수 백"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/34921ea6796b4f848938b5b60d819b25_520.jpg",
          "id": 36,
          "seller": "이소커피",
          "title": " 수제크림치즈 5종"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/21758f27578c4bd2b54f0b3742c5a893_520.jpg",
          "id": 37,
          "seller": "잡화점.비",
          "title": "분홍빛 빈티지 조명"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/be6dcb935b734cb58fd73b04657278c5_520.jpg",
          "id": 38,
          "seller": "스튜디오에린",
          "title": "통통이 투버튼미니월렛 (명함지갑)"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/c8e261db7f5140d382539169889a44db_520.jpg",
          "id": 39,
          "seller": "아이레더&무드팔레트",
          "title": "🎄크리스마스 트리캔들🎄"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/33fb8696d3634298ae854444c1a555b1_520.jpg",
          "id": 40,
          "seller": "아트한생각",
          "title": "복고티브이♡화면조정♡냅킨케이스/냅킨을 넣어드려요~"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/f79ea1c521b54630860853219cb4fd83_520.jpg",
          "id": 41,
          "seller": "Jane Hase(제인하제)",
          "title": "Janehase 제인다이어리"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/8ec543848f654bedb34710912fceab14_520.jpg",
          "id": 42,
          "seller": "꾸미룸공방 박진영",
          "title": "생각나 눈사람 크리스마스카드"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/cd5607df5608474dacc6fb709d0634d3_520.jpg",
          "id": 43,
          "seller": "다람",
          "title": "[다람]통밀 비건 단호박파운드(두부)"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/b844a401286c4aea8608a263fa0784d4_520.jpg",
          "id": 44,
          "seller": "유센디",
          "title": "프롬유 이니셜 파우치 크로스백"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/fae5e9ea28474b349c2d70b37dfd804e_520.jpg",
          "id": 45,
          "seller": "본도공방",
          "title": "키재기자. 브릭 (brick)"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/7d866f2565284f53ba4e71b70fd34713_520.jpg",
          "id": 46,
          "seller": "오즈앤엔즈",
          "title": "블루 우드 썬캐쳐"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/49e35717548446699fa43cd55e345886_520.jpg",
          "id": 47,
          "seller": "1932포천일동막걸리",
          "title": "1932포천일동 담은생막걸리 WHITE 750ml *2"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/15f5edeca98f4b1babcb65a18e824cca_520.jpg",
          "id": 48,
          "seller": "아가그림 아가화",
          "title": "[예약할인]동백꽃필무렵🌺/고귀한 동백꽃! "
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/7b283a5ae1e044f88c590618f44c10a9_520.jpg",
          "id": 49,
          "seller": "또보네",
          "title": "귀여운 힙한오리와 너드오리 폰케이스"
        },
        {
          "thumbnail_520": "https://image.idus.com/image/files/320da85bce684c41b58b948235206459_520.jpg",
          "id": 50,
          "seller": "오투세븐디에세오스타",
          "title": "🍂폴링폼폼🌸생화귀걸이"
        }
      ]
    }
    """
    
    static let productJSONString = """
    {
      "statusCode": 200,
      "body": [
        {
          "discount_cost": null,
          "cost": "9,000원",
          "seller": "골든팜",
          "description": "여름철에만드실수있는 아삭한복숭아\\n이젠 겨울에도 드실수있답니다^^🍑🍑\\n일반 캔 통조림의 물렁한 식감과 아주 많이 다릅니다. \\n조림임에도 불구하고 원물의 식감과 거의 흡사합니다. 칼로리 함량이 높지 않아 몸매 관리에 신경쓰이는 분들에게도 쉽게 드실 수 있으며 당분이 많지 않아 어린이나 노인분들에게도 부담없이 권할 수 있는 제품입니다.\\n\\n직접 대규모 복숭아 농장을 재배하면서 직접 가공하는 농가이므로 산지 직거래 유통망 구조로 중간 유통 경로가 없이 거품을 뺀 도매가격으로 소비자분께서 직접 구매할 수 있는 판매구조를 가지고 있습니다.\\n\\n🍑복숭아 병조림은 그대로 드셔도 그 맛이 매우 좋으며 \\n요거트나 복숭아 주스로 만들어 드시면 또 다른 맛을 즐기실 수 있습니다.\\n\\n🍑요거트로 드실 경우 잘개 썰어서 희석시켜 드시면 되고 \\n복숭아 주스로 만들어 드실 경우에는 \\n복숭아 1: 우유 2 비율로 믹서기에 갈아서 드시면 또다른 새로운 맛으로 탄생이 됩니다.",
          "discount_rate": null,
          "id": 1,
          "thumbnail_720": "https://image.idus.com/image/files/4e47e2fa54e84fedbe56b610475adf0c_720.jpg",
          "thumbnail_list_320": "https://image.idus.com/image/files/4e47e2fa54e84fedbe56b610475adf0c_320.jpg#https://image.idus.com/image/files/7eea603aa68449ab95ca76e2857a0128_320.jpg#https://image.idus.com/image/files/565fb363e7134a9db706d5625dea73a5_320.jpg#https://image.idus.com/image/files/418035a208b94ce38ba69768edc04d90_320.jpg#https://image.idus.com/image/files/cab78c3c67a44264ad90c27d19b1b08b_320.jpg",
          "title": "겨울에 아삭한여름복숭아먹기"
        }
      ]
    }
    """
}
