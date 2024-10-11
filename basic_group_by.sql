-- dataframe
date	price	duration
2020-05-01	2	15
2020-05-01	4	37
2020-05-06	7	24

-- 1) group by + 1개열
-- 날짜별로 얼마나 많은 사람들이 방문했는지?
SELECT date, COUNT(*)
FROM visit
GROUP BY date;

-- 2) GROUP BY + 여러 개의 열
-- 월별 티켓의 평균 금액은?
SELECT
  EXTRACT(year FROM date) AS year,
  EXTRACT(month FROM date) AS month,
  ROUND(AVG(price), 2) AS avg_price
FROM visit
GROUP BY 
 EXTRACT(year FROM date),
 EXTRACT(month FROM date);

year	month	avg_price
2020	5	7.52
2020	6	6.70
/* 중요!!! GROUP BY 절 사용 시, 매우 중요한 점
SELECT 문에 있는 모든 열은 집계 함수가 되거나 GROUP BY 절에 나타나야 함.
예시) SELECT 문 중에서 EXTRACT 함수를 활용한 2개의 열은 GROUP BY 절에 사용 & 마지막 열은 COUNT 집계 함수 사용
GROUP BY 절을 사용하는데 만약 SELECT 문에 집계 함수를 사용하지 않거나 GROUP BY 절에 언급되지 않은 열이 존재한다면 오류가 발생 */

-- 3) GROUP BY와 ORDER BY 같이 사용
-- 월별 평균 머무른 시간?

SELECT
  EXTRACT(year FROM date) AS year,
  EXTRACT(month FROM date) AS month,
  ROUND(AVG(duration),2) AS avg_duration
FROM visit
GROUP BY year, month
ORDER BY year, month

-- 4) GROUP BY 랑 HAVING 같이 사용
-- 일별 평균 티겟 금액 & 방문 고객 수가 3명보다 적은 날짜는 제외하시오
SELECT date, ROUND(AVG(price),2) AS avg_price
FROM visit
GROUP BY date
HAVING COUNT(*)>3
ORDER BY date;

date	avg_price
2020-05-01	5.80
2020-05-15	7.00
2020-05-23	6.67

/* HAVING 절: GROUP BY 를 통해 데이터를 그룹핑 한 행에만 사용 가능. 
이 경우, 날짜로 이미 데이터를 그룹화하였기에 HAVING 절을 사용 */

-- 5) GROUP BY, HAVING 그리고 WHERE 까지 같이 사용
-- 일별 평균 머무른 시간, 1) 일별 방문 고객 수가 3명보다 많아야 하고, 2)해당 방문의 머무른 시간이 5분보다 길어야 함.
SELECT date, ROUND(AVG(duration),2) AS avg_price
FROM visit
WHERE duration >5
GROUP BY date
HAVING COUNT(date)
ORDER BY date;

/* WHERE VS GROUP BY
WHERE 절: 행들이 그룹 지어지기 전 단일 행들을 필터링하는 데 사용
HAVING 절: 행들이 그룹 지어진 후의 행들을 필터링하는 데 사용
*/
date	avg_duration
2020-05-01	29.80
2020-05-15	55.75
2020-05-23	32.17
2020-05-29	69.50
2020-06-02	39.83
2020-06-04	48.67
2020-06-09	48.50
2020-06-23	51.60
2020-06-29	57.86








