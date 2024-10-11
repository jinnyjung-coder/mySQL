/* https://school.programmers.co.kr/learn/courses/30/lessons/299310
분화된 연도(YEAR), 분화된 연도별 대장균 크기의 편차(YEAR_DEV), 대장균 개체의 ID(ID) 를 출력하는 SQL 문을 작성해주세요. 
분화된 연도별 대장균 크기의 편차는 분화된 연도별 가장 큰 대장균의 크기 - 각 대장균의 크기로 구하며 
결과는 연도에 대해 오름차순으로 정렬하고 같은 연도에 대해서는 대장균 크기의 편차에 대해 오름차순으로 정렬해주세요. 

날짜 포맷: 
SELECT DATE_FORMAT(T.DATE, '%y-%m-%d') as "CREATE_DATE"
FROM T
데이터 : YYYY-MM-DD hh:mm:ss (만약 T 테이블의 DATE의 데이터)
출력 : YY-MM-DD

SELECT DATE_FORMAT(T.DATE, '%Y-%m-%d') as "CREATE_DATE"
FROM T
데이터 : YYYY-MM-DD hh:mm:ss (만약 T 테이블의 DATE의 데이터)
출력 : YYYY-MM-DD
*/

# SOL 1
SELECT YEAR(E.DIFFERENTIATION_DATE) AS "YEAR", (M.MAX-E.SIZE_OF_COLONY) AS "YEAR_DEV", E.ID
FROM ECOLI_DATA E
JOIN (SELECT YEAR(DIFFERENTIATION_DATE) AS "y", 
      MAX(SIZE_OF_COLONY) AS "max"
      FROM ECOLI_DATA
      GROUP BY YEAR(DIFFERENTIATION_DATE)) M 
      ON YEAR(E.DIFFERENTIATION_DATE) = M.y
ORDER BY YEAR, YEAR_DEV

# SOL 2
/* 
1) EXTRACT(YEAR FROM DIFFERENTIATION_DATE)를 사용하여 분화된 연도를 추출하고, 해당 연도별로 대장균 개체의 정보를 분류합니다.
2) MAX(SIZE_OF_COLONY) OVER (PARTITION BY EXTRACT(YEAR FROM DIFFERENTIATION_DATE))을 사용하여 연도별 가장 큰 대장균의 크기를 찾고, 각 개체의 크기와의 차이를 계산하여 YEAR_DEV로 저장합니다.
3) ORDER BY YEAR ASC, YEAR_DEV ASC를 사용하여 연도 오름차순, 그리고 같은 연도 내에서는 대장균 크기의 편차 오름차순으로 정렬합니다.

1. OVER
OVER는 윈도우 함수에서 사용되는 키워드
특정 집계나 순위 계산을 수행할 때 윈도우(또는 프레임)를 정의
OVER 키워드를 사용하면 전체 결과를 그룹으로 나누지 않고 집계 결과를 전체 또는 일부 행에 대해 계산 가능
ex) SUM(...) OVER (...)를 사용하면 각 행마다 윈도우 내 합계 계산 가능

2. PARTITION BY
PARTITION BY는 OVER와 함께 사용, 데이터를 그룹으로 나누는 역할
PARTITION BY를 통해 데이터를 특정 기준으로 나누고, 그 그룹별로 집계 연산을 수행
GROUP BY와 유사하지만, PARTITION BY를 사용하면 집계 결과를 각 행과 함께 표시할 수 있다는 점이 다름
*/
SELECT EXTRACT(YEAR FROM DIFFERENTIATION_DATE) AS YEAR, 
       (MAX(SIZE_OF_COLONY) OVER (PARTITION BY EXTRACT(YEAR FROM DIFFERENTIATION_DATE)) - SIZE_OF_COLONY) AS YEAR_DEV,
       ID
FROM ECOLI_DATA
ORDER BY YEAR ASC, YEAR_DEV ASC;
