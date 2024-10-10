/* https://school.programmers.co.kr/learn/courses/30/lessons/59408
동물 보호소에 들어온 동물의 이름은 몇 개인지 조회하는 SQL 문을 작성해주세요. 이때 이름이 NULL인 경우는 집계하지 않으며 중복되는 이름은 하나로 칩니다.*/

SELECT COUNT(DISTINCT(NAME))
FROM ANIMAL_INS
  
/* NULL 값은 DISTINCT 처리 시 무시되며, 중복 여부를 판단하지 않는다. 그래서 DISTINCT 처리하고 바로 COUNT 함수를 사용하면 된다. 
