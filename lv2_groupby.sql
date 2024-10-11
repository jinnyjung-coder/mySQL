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
SELECT YEAR(E.DIFFERENTIATION_DATE) AS "YEAR", (M.MAX-E.SIZE_OF_COLONY) AS "YEAR_DEV", E.ID
FROM ECOLI_DATA E
JOIN (SELECT YEAR(DIFFERENTIATION_DATE) AS "y", 
      MAX(SIZE_OF_COLONY) AS "max"
      FROM ECOLI_DATA
      GROUP BY YEAR(DIFFERENTIATION_DATE)) M 
      ON YEAR(E.DIFFERENTIATION_DATE) = M.y
ORDER BY YEAR, YEAR_DEV
