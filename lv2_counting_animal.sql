/* https://school.programmers.co.kr/learn/courses/30/lessons/59406
동물 보호소에 동물이 몇 마리 들어왔는지 조회하는 SQL 문을 작성해주세요.

COUNT(*) VS COUNT(COLUMN_NAME)
COUNT(*): NULL 포함
COUNT(COLUMN_NAME): NULL 값 제외한 행의 개수

*/

# SOL 1
SELECT COUNT(ANIMAL_ID)
FROM ANIMAL_INS

# SOL 2
SELECT COUNT(*) as count /* 테이블의 모든 행을 선택.*/
FROM animal_ins 
