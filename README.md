#개인 학습용 jsp게시판 프로젝트

## 프로젝트 목표

이 프로젝트는 JSP와 Spring Boot를 사용해서 웹 게시판을 직접 만들어보면서 웹 개발의 기본을 다지기 위해 시작한 개인 학습 프로젝트다. 
RESTful API 설계, AJAX, 세션/쿠키 관리, 비동기 통신 등 다양한 웹 개발 기술과 아키텍처 패턴을 직접 적용하고 깊이 있게 이해하는 것을 목표로 삼았다.

## 만들면서 중점적으로 본 것

## 주요 기능

* 회원 관리: 가입, 로그인, 로그아웃 (쿠키 활용, spring security 사용 x)
* 게시글 CRUD: 생성, 조회, 수정, 삭제 (기본적인 게시판 기능)
* 댓글/대댓글: 댓글, 답글 작성 및 계층형 구조 표시, 
		    비동기 통신으로 새로 고침 없이 실시간 처리 (AJAX, JSON)
* 페이징: 페이지 나누고 보여주기
* 조회수 카운트: 중복 조회 방지 (쿠키 활용)
* 파일 업로드: 게시글 및 댓글에 업로드 가능

## 기술 스택

* 프레임워크: Spring Boot
* 템플릿 엔진: JSP
* 데이터베이스: MariaDB
* 데이터 통신: JSON, AJAX
* 기타: JSTL

## 좀 더 자세히...

* **왜 JSP를 썼나:** 일단은 익숙한 기술이라 빠르게 프로토타입 만들기에 좋았다. Spring MVC의 기본 동작 방식을 이해하는 데도 도움이 됨.
* **RESTful API는 왜 넣었나:** 요즘은 프론트엔드랑 백엔드 분리하는 게 대세니까, 연습해보고 싶었다. 댓글 같은 부분은 JSON으로 주고받는 게 훨씬 깔끔하며 작성, 수정, 삭제시 바로 반영 되는 등의 비동기 처리를 위해 사용함.


## 참고한 자료

    AJAX 처리
        페이징 ajax
            https://chobopark.tistory.com/249
            https://congsong.tistory.com/60#1.-%EB%B9%84%EB%8F%99%EA%B8%B0ajax-%EC%B2%98%EB%A6%AC%EC%9D%98-%EB%AC%B8%EC%A0%9C%EC%A0%90
                History API
                    https://velog.io/@minw0_o/history-API%EB%9E%80
        로그인
            https://velog.io/@rladuswl/4-%ED%9A%8C%EC%9B%90%EA%B0%80%EC%9E%85-%EA%B5%AC%ED%98%84%ED%95%98%EA%B8%B0-Feat.-Ajax%EB%A5%BC-%EC%82%AC%EC%9A%A9%ED%95%98%EB%8A%94-%EC%9D%B4%EC%9C%A0
            https://devmoony.tistory.com/47
        댓글
            https://velog.io/@wiz_hey/Spring-Ajax%EB%A5%BC-%ED%99%9C%EC%9A%A9%ED%95%9C-%EB%B9%84%EB%8F%99%EA%B8%B0%EC%8B%9D-%EB%8C%93%EA%B8%80-%EA%B5%AC%ED%98%84-2.-%EB%8C%93%EA%B8%80-%EC%A1%B0%ED%9A%8C-%EB%B0%8F-%EC%9E%85%EB%A0%A5
.

    세션 쿠키
        https://ala-nueva.tistory.com/189

    페이징
       https://chobopark.tistory.com/170

    조회수 
        https://velog.io/@juwonlee920/Spring-%EC%A1%B0%ED%9A%8C%EC%88%98-%EA%B8%B0%EB%8A%A5-%EA%B5%AC%ED%98%84-%EC%A1%B0%ED%9A%8C%EC%88%98-%EC%A4%91%EB%B3%B5-%EB%B0%A9%EC%A7%80
    
    GET과 POST
        https://mommoo.tistory.com/60
        https://mundol-colynn.tistory.com/141
    
    쿼리 스트링
        https://chobopark.tistory.com/171

    JSON 으로 게시판 관리 (RESTful 게시판)
        https://colinch4.github.io/2023-09-15/13-07-54-455247-%EC%9E%90%EB%B0%94%EC%8A%A4%ED%81%AC%EB%A6%BD%ED%8A%B8%EC%97%90%EC%84%9C-json-%EB%8D%B0%EC%9D%B4%ED%84%B0%EB%A5%BC-%EC%9D%B4%EC%9A%A9%ED%95%98%EC%97%AC-%EA%B2%8C%EC%8B%9C%EB%AC%BC-%EA%B4%80%EB%A6%AC-%EA%B8%B0%EB%8A%A5-%EC%83%9D%EC%84%B1%ED%95%98%EA%B8%B0/
        https://sap518.tistory.com/160
        https://ttl-blog.tistory.com/267
        https://earth-95.tistory.com/49

.
    
    파일 입출력
        https://velog.io/@ayeonnam93/%ED%8C%8C%EC%9D%BC-%EC%97%85%EB%A1%9C%EB%93%9C-%EB%B0%A9%EC%8B%9D-Ajax%EB%A5%BC-%EC%9D%B4%EC%9A%A9%ED%95%98%EB%8A%94-%ED%8C%8C%EC%9D%BC-%EC%97%85%EB%A1%9C%EB%93%9C

        form 방식 (input)
        
        AJAX 방식

## 앞으로 해보고 싶은것
	마이페이지, 좋아요, 게시글 검색 기능
