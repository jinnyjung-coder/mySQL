/* https://school.programmers.co.kr/learn/courses/30/lessons/298515
FISH_INFO 테이블에서 잡은 물고기 중 가장 큰 물고기의 길이를 'cm' 를 붙여 출력하는 SQL 문을 작성해주세요.
이 때 컬럼명은 'MAX_LENGTH' 로 지정해주세요.*/

SELECT CONCAT(MAX(LENGTH), 'cm') AS MAX_LENGTH
FROM FISH_INFO

/*
찾은 길이에 'cm'를 붙이는 방법은 CONCAT()
*/
