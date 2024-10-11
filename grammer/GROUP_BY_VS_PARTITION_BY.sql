-- GROUP BY  VS PARTITION BY (https://kimsyoung.tistory.com/entry/GROUP-BY-vs-PARTITION-BY-%EC%9C%A0%EC%82%AC%EC%A0%90%EA%B3%BC-%EC%B0%A8%EC%9D%B4%EC%A0%90?category=822739)

-- GROUP BY
/* 
사용 기준: 특정 기준으로 데이터를 정의하고자 할 때 사용. 보통 이런 기준은 우리가 분석을 할 때 분류 기준으로 삼는 것
예) 임직원의 정보를 그들의 '연봉 인상률'을 기준으로 그룹화, 기차 정보를 기차의 '출발역' 기준으로 그룹화, 매출 정보를 '연도' 및 '월별'로 그룹화
기존 행에 있던 데이터는 우리가 제공한 새로운 기준에 의해 생성된 새로운 행에 입력

집계 함수를 사용하여 기존 행에 있던 값들을 계산한 후 새로운 행에 입력. 
집계 함수로 데이터를 합치는 과정에서, 우리는 기존의 상세 데이터들을 잃음.
*/

train 테이블: 기차의 정보가 저장
journey 테이블: 기차의 여정이 저장
route 테이블: 해당 여정들이 어떤 경로를 통해 가는지에 관한 정보가 저장

train
id	model	max_speed	production_year	first_class_places	second_class_places
1	InterCity 100	160	2000	30	230
2	InterCity 100	160	2000	40	210
3	InterCity 125	200	2001	40	180
4	Pendolino 390	240	2012	45	150
5	Pendolino ETR310	240	2010	50	250
6	Pendolino 390	240	2010	60	250

journey
id	train_id	route_id	date
1	1	1	2016-01-03
2	1	2	2016-01-04
3	1	3	2016-01-05
4	1	4	2016-01-06
5	2	2	2016-01-03
6	2	3	2016-01-04
7	2	4	2016-01-05
8	2	5	2016-01-06
9	3	3	2016-01-03
10	3	5	2016-01-04
11	3	5	2016-01-05
12	3	6	2016-01-06
13	4	4	2016-01-04
14	4	5	2016-01-04
15	4	6	2016-01-05
16	4	7	2016-01-06
17	5	2	2016-01-03
18	5	1	2016-01-05
19	5	3	2016-01-05
20	5	1	2016-01-06
21	6	3	2016-01-03
22	6	3	2016-01-04
23	6	1	2016-01-05

route
id	name	from_city	to_city	distance
1	Manchester Express	Sheffield	Manchester	60
2	GoToLeads	Manchester	Leeds	70
3	StudentRoute	London	Oxford	90
4	MiddleEnglandWay	London	Leicester	160
5	BeatlesRoute	Liverpool	York	160
6	NewcastleDaily	York	Newcastle	135
7	ScotlandSpeed	Newcastle	Edinburgh	200

-- train 테이블과 journey 테이블을 활용해 기차와 해당 기차의 여정에 관한 정보를 뽑아주세요.
-- 기차의 고유 아이디를 기준으로 2개의 테이블을 조인

SELECT t.id, t.model, j.*
FROM train AS t
INNER JOIN journey AS j ON t.id=j.train_id
ORDER BY t.id;

Id	model	id	train_id	route_id	date
1	InterCity 100	1	1	1	1/3/2016
1	InterCity 100	25	1	5	1/3/2016
1	InterCity 100	2	1	2	1/4/2016
1	InterCity 100	3	1	3	1/5/2016
1	InterCity 100	4	1	4	1/6/2016
2	InterCity 100	6	2	3	1/4/2016
2	InterCity 100	7	2	4	1/5/2016
2	InterCity 100	8	2	5	1/6/2016
2	InterCity 100	5	2	2	1/3/2016
3	InterCity 125	10	3	5	1/4/2016
3	InterCity 125	11	3	5	1/5/2016
3	InterCity 125	29	3	4	1/3/2016
3	InterCity 125	27	3	3	1/5/2016
3	InterCity 125	12	3	6	1/6/2016
3	InterCity 125	9	3	3	1/3/2016
4	Pendolino 390	16	4	7	1/6/2016
4	Pendolino 390	13	4	4	1/4/2016
4	Pendolino 390	14	4	5	1/4/2016
4	Pendolino 390	15	4	6	1/5/2016
4	Pendolino 390	28	4	6	1/6/2016
-- 결과를 보면, 아이디가 1인 기차의 행이 총 5개가 존재합니다. 아이디가 2인 기차는 행이 총 4개

-- GROUP BY를 활용
SELECT t.id, t.model, COUNT(*) AS routes
FROM train AS t
INNER JOIN journey AS j ON t.id = j.train_id
GROUP BY t.id, t.model
ORDER BY t.id

id	model	routes
1	InterCity 100	5
2	InterCity 100	4
3	InterCity 125	6
4	Pendolino 390	5
/* 기차의 아이디와 모델명으로 데이터를 그룹 
COUNT 함수를 사용해 각 기차마다 몇 개의 경로를 갖고 있는지 알 수 있음.
journey 테이블에 있던 행 단위의 세세한 정보는 버림 

[집계 함수가 작동하는 원리]
1) 동일한 값을 여러 개 갖고 있는 열의 이름을 GROUP BY 절에 적어줌으로써 데이터가 그룹 지어질 수 있는 기준으로 제공
2) 집계 함수가 동일한 값을 하나의 값으로 합치기 위해 그 행들의 값을 계산
3) 집계 함수를 통해 값을 합치는 과정에서 기존의 행들은 사라지게 됨.
집계 함수를 통해 구한 값들을 볼 수는 있어도 기존에 있던 정보를 함께 볼 수는 없습니다.
*/

하지만, 집계 함수로 새로 구한 값과 원래 기존의 세세한 행들을 같이 보면서 분석을 해야 할 때가 생김.
  이는 서브 쿼리를 활용해 해결할 수 있지만, 서브 쿼리로 해결하다 보면 쿼리문도 길어질 수도 있습니다. 

-- PARTITION BY
/* 
특정 기준에 한정하여 집계된 값을 계산
여러 행의 집계된 값을 구하고자 PARTITION BY는 OVER절과 윈도우 함수와 함께 사용
GROUP BY와 집계 함수가 하는 역할과 거의 유사하지만, 차이점이 1가지 존재
PARTITION BY를 사용하면, GROUP BY와는 달리 기존 행의 세세한 정보들은 사라지지 않고 그대로 유지
즉, 기존의 데이터와 집계된 값을 함께 나란히 볼 수 있음
*/
SELECT
 t.id,
 t.model,
 r.name,
 r.from_city,
 r.to_city,
 COUNT(*) OVER(PARTITION BY t.id ORDER BY t.id) AS routes,
 COUNT(*) OVER() AS routes_total
FROM train AS t
INNER JOIN journey AS j
      ON t.id = j.train_id
INNER JOIN route AS r
      ON j.route_id = r.id;

/*
1) GROUP BY를 사용하지 않았지만 여전히 집계된 값을 구할 수 있었습니다 (routes 열과 routes_total 열)
2) GROUP BY 를 사용한 쿼리문에서도 우리는 기차의 아이디와 모델명을 추출해 달라고 SELECT 문에 적었음.
하지만 GROUP BY는 기차의 아이디와 모델명을 기준으로 데이터를 합치느라 
중복되는 기존 데이터는 다 지우고 기준이 될 수 있도록 한 개씩만 남겼음.
하지만 이번 PARTITION BY를 통해 얻어낸 결과에는 기존 데이터들이 그대로. 중복되는 데이터 없음. 
그리고 집계 함수를 통해 구한 값은 모든 행마다 부여되어 있습니다.
3) COUNT(*) OVER() AS routes_total은 집계되어야 할 행들끼리 구분 짓지 않았기 때문에 
(PARTITION BY를 적지 않음) 모든 행이 집계 함수의 대상이 됩니다. 
따라서 30이라는 숫자가 모든 행마다 부여된 것을 확인할 수 있습니다.
4) COUNT(*) OVER(PARTITION BY t.id ORDER BY t.id) AS routes 부분은
PARTITION BY를 통해 각 기차 아이디를 기준으로 행을 집계해달라고 요청.
routes 열을 보시면, 각 아이디마다 서로 다른 집계값을 가지고 있는 것을 확인 가능.
*/

Id	model	name	from_city	to_city	routes	routes_total
1	InterCity 100	Manchester Express	Sheffield	Manchester	5	30
1	InterCity 100	BeatlesRoute	Liverpool	York	5	30
1	InterCity 100	GoToLeads	Manchester	Leeds	5	30
1	InterCity 100	StudentRoute	London	Oxford	5	30
1	InterCity 100	MiddleEnglandWay	London	Leicester	5	30
2	InterCity 100	StudentRoute	London	Oxford	4	30
2	InterCity 100	MiddleEnglandWay	London	Leicester	4	30
2	InterCity 100	BeatlesRoute	Liverpool	York	4	30
2	InterCity 100	GoToLeads	Manchester	Leeds	4	30
3	InterCity 125	BeatlesRoute	Liverpool	York	6	30
3	InterCity 125	BeatlesRoute	Liverpool	York	6	30
3	InterCity 125	MiddleEnglandWay	London	Leicester	6	30
3	InterCity 125	StudentRoute	London	Oxford	6	30
3	InterCity 125	NewcastleDaily	York	Newcastle	6	30
3	InterCity 125	StudentRoute	London	Oxford	6	30
4	Pendolino 390	ScotlandSpeed	Newcastle	Edinburgh	5	30
4	Pendolino 390	MiddleEnglandWay	London	Leicester	5	30
4	Pendolino 390	BeatlesRoute	Liverpool	York	5	30
4	Pendolino 390	NewcastleDaily	York	Newcastle	5	30
4	Pendolino 390	NewcastleDaily	York	Newcastle	5	30
5	Pendolino ETR310	StudentRoute	London	Oxford	5	30
