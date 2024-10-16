# https://school.programmers.co.kr/learn/courses/30/lessons/59038
# 동물 보호소에 가장 먼저 들어온 동물은 언제 들어왔는지 조회하는 SQL 문을 작성해주세요.

ANIMAL_ID	ANIMAL_TYPE	DATETIME	INTAKE_CONDITION	NAME	SEX_UPON_INTAKE
A399552	Dog	2013-10-14 15:38:00	Normal	Jack	Neutered Male
A379998	Dog	2013-10-23 11:42:00	Normal	Disciple	Intact Male
A370852	Dog	2013-11-03 15:04:00	Normal	Katie	Spayed Female
A403564	Dog	2013-11-18 17:03:00	Normal	Anna	Spayed Female

가장 먼저 들어온 동물은 Jack이고, Jack은 2013-10-14 15:38:00에 들어왔습니다. 따라서 SQL문을 실행하면 다음과 같이 나와야 합니다.

시간
2013-10-14 15:38:00
※ 컬럼 이름(위 예제에서는 "시간")은 일치하지 않아도 됩니다.

#SOL 1 - ORDER BY, LIMIT
SELECT DATETIME
FROM (SELECT ANIMAL_ID, ANIMAL_TYPE, DATETIME, INTAKE_CONDITION, NAME, SEX_UPON_INTAKE
      FROM ANIMAL_INS
      ORDER BY DATETIME ASC
      LIMIT 1) AS subquery;

#SOL 2 - WHERE
SELECT DATETIME
FROM (SELECT ANIMAL_ID, ANIMAL_TYPE, DATETIME, INTAKE_CONDITION, NAME, SEX_UPON_INTAKE
      FROM ANIMAL_INS
      WHERE DATETIME= (SELECT MIN(DATETIME) AS DATETIME FROM ANIMAL_INS)) AS SUBQUERY;
