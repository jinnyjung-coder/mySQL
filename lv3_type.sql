/* https://school.programmers.co.kr/learn/courses/30/lessons/293261
물고기 종류 별로 가장 큰 물고기의 ID, 물고기 이름, 길이를 출력하는 SQL 문을 작성해주세요.
물고기의 ID 컬럼명은 ID, 이름 컬럼명은 FISH_NAME, 길이 컬럼명은 LENGTH로 해주세요.
결과는 물고기의 ID에 대해 오름차순 정렬해주세요.
단, 물고기 종류별 가장 큰 물고기는 1마리만 있으며 10cm 이하의 물고기가 가장 큰 경우는 없습니다. */

  테이블 설명:
fish_info: 어종 정보가 담긴 테이블.
fish_name_info: 어종 이름 정보를 가진 테이블.

    FISH_INFO 테이블과 FISH_NAME_INFO 테이블을 물고기 종류(FISH_TYPE)를 기준으로 조인합니다.

    서브쿼리에서 물고기 종류별로 가장 큰 길이(MAX(LENGTH))를 구하고, 이를 MAX_FISH 테이블로 참조합니다.

    메인 쿼리에서 MAX_FISH와 조인하여 각 물고기 종류별 가장 큰 물고기의 정보를 가져옵니다.

    최종적으로 결과는 물고기의 ID에 대해 오름차순으로 정렬합니다.

SELECT F.ID, FNI.FISH_NAME, F.LENGTH
FROM FISH_INFO F
JOIN FISH_NAME_INFO FNI ON F.FISH_TYPE = FNI.FISH_TYPE
JOIN (
    SELECT FISH_TYPE, MAX(LENGTH) AS MAX_LENGTH
    FROM FISH_INFO
    GROUP BY FISH_TYPE
) AS MAX_FISH ON F.FISH_TYPE = MAX_FISH.FISH_TYPE AND F.LENGTH = MAX_FISH.MAX_LENGTH
ORDER BY F.ID;
