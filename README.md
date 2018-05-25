# Schapi-Go

Schapi RB는 Schapi의 Ruby 버전으로  
Ruby 기반의 급식, 학사일정 파싱 라이브러리입니다.  

## 1. 설치  

schapi-rb 는 프로젝트에 다음과 같이 설치할 수 있습니다.  

```
gem install schapi
```

## 2. 예제

다음은 대덕소프트웨어마이스터고등학교 (G100000170) 의 5월 23일자 점심  
식단표를 불러와 출력하는 예제입니다.

```
require 'schapi'

SchoolAPI = Schapi::SchoolAPI
Kind = Schapi::Kind
Region = Schapi::Region

api := SchoolAPI.new(Kind.HIGH, Region.DAEJEON, "G100000170")
fmt.Println(api.get_monthly_menus(2018, 5)[23].lunch)
```

## 3. ㅇㅅㅇ

~~솔직히 2개 해줬는데 Organization 껴줘~~