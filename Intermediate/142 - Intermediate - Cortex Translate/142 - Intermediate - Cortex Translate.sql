------------------
-- STARTUP CODE --
------------------

CREATE OR REPLACE TABLE customer_feedback (
  review_id INT,
  review_text STRING
);
INSERT INTO customer_feedback (review_id, review_text) VALUES
(1, 'It was okay, but could be better. Excellent customer support throughout the process. It was okay, but could be better. Excellent customer support throughout the process. It was okay, but could be better. Excellent customer support throughout the process. It was okay, but could be better. Excellent customer support throughout the process. It was okay, but could be better. Excellent customer support throughout the process.');
INSERT INTO customer_feedback (review_id, review_text) VALUES
(1, 'Estuvo bien, pero podría mejorar. No estoy satisfecho con la calidad del artículo. Estuvo bien, pero podría mejorar. No estoy satisfecho con la calidad del artículo. Estuvo bien, pero podría mejorar. No estoy satisfecho con la calidad del artículo. Estuvo bien, pero podría mejorar. No estoy satisfecho con la calidad del artículo. Estuvo bien, pero podría mejorar. No estoy satisfecho con la calidad del artículo.');
INSERT INTO customer_feedback (review_id, review_text) VALUES
(1, 'Je recommanderais certainement ce produit. La livraison était rapide et le service excellent. Je recommanderais certainement ce produit. La livraison était rapide et le service excellent. Je recommanderais certainement ce produit. La livraison était rapide et le service excellent. Je recommanderais certainement ce produit. La livraison était rapide et le service excellent. Je recommanderais certainement ce produit. La livraison était rapide et le service excellent.');
INSERT INTO customer_feedback (review_id, review_text) VALUES
(1, 'Ich würde dieses Produkt auf jeden Fall empfehlen. Es war okay, aber es könnte besser sein. Ich würde dieses Produkt auf jeden Fall empfehlen. Es war okay, aber es könnte besser sein. Ich würde dieses Produkt auf jeden Fall empfehlen. Es war okay, aber es könnte besser sein. Ich würde dieses Produkt auf jeden Fall empfehlen. Es war okay, aber es könnte besser sein. Ich würde dieses Produkt auf jeden Fall empfehlen. Es war okay, aber es könnte besser sein.');
INSERT INTO customer_feedback (review_id, review_text) VALUES
(1, '全体的に優れたカスタマーサポートでした。 この製品は間違いなくおすすめです。 全体的に優れたカスタマーサポートでした。 この製品は間違いなくおすすめです。 全体的に優れたカスタマーサポートでした。 この製品は間違いなくおすすめです。 全体的に優れたカスタマーサポートでした。 この製品は間違いなくおすすめです。 全体的に優れたカスタマーサポートでした。 この製品は間違いなくおすすめです。');

--------------
-- SOLUTION --
--------------

SELECT SNOWFLAKE.CORTEX.SUMMARIZE(LISTAGG(SNOWFLAKE.CORTEX.TRANSLATE(review_text, '', 'en'),'/')) FROM customer_feedback;


