# PRINT THE MOST EXPENSIVE PRICE OF FOOD INFORMATION
# Write an SQL statement to retrieve the food ID, food name, food code, food classification, and food price of the most expensive food item in the FOOD_PRODUCT table.
# https://school.programmers.co.kr/learn/courses/30/lessons/131115

  # 단순히 SELECT MAX(PRICE) 를 쓰면 안되는 이유는, 가격만 MAX가 나오고, 다른 열의 정보는 MAX 가격과 매칭 되는 정보가 아니기 때문!
  
#SOL 1 (WHERE SUB-QUERY)
SELECT PRODUCT_ID, PRODUCT_NAME, PRODUCT_CD, CATEGORY, PRICE
FROM FOOD_PRODUCT
WHERE PRICE = (SELECT MAX(PRICE) FROM FOOD_PRODUCT)

#SOL 2 (ORDER BY, LIMIT)
  # 가장 비싼 가격이 2개인 경우, 오답처리 될 가능성 있음
SELECT PRODUCT_ID, PRODUCT_NAME, PRODUCT_ID, CATEGORY, PRICE
FROM FOOD_PRODUCT
ORDER BY PRICE DESC
LIMIT 1
