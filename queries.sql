-- ============================================
-- SQL PAYMENTS
-- Consultas e análise de pagamentos
-- Autor: Victor Souza
-- ============================================


-- 1. Visualizar todos os pagamentos
SELECT *
FROM payments;


-- 2. Total de pagamentos
SELECT COUNT(*) AS total_pagamentos
FROM payments;


-- 3. Valor total dos pagamentos
SELECT SUM(amount) AS valor_total
FROM payments;


-- 4. Valor médio dos pagamentos
SELECT AVG(amount) AS valor_medio
FROM payments;


-- 5. Pagamentos aprovados
SELECT *
FROM payments
WHERE status = 'Aprovado';


-- 6. Total recebido apenas de pagamentos aprovados
SELECT SUM(amount) AS total_aprovado
FROM payments
WHERE status = 'Aprovado';


-- 7. Total por status
SELECT
    status,
    COUNT(*) AS quantidade,
    SUM(amount) AS valor_total
FROM payments
GROUP BY status
ORDER BY valor_total DESC;


-- 8. Total por método de pagamento
SELECT
    payment_method,
    COUNT(*) AS quantidade_pagamentos,
    SUM(amount) AS valor_total
FROM payments
GROUP BY payment_method
ORDER BY valor_total DESC;


-- 9. Clientes e seus pagamentos
SELECT
    c.customer_name,
    p.payment_date,
    p.amount,
    p.payment_method,
    p.status
FROM customers c
INNER JOIN payments p
    ON c.customer_id = p.customer_id
ORDER BY p.payment_date;


-- 10. Total pago por cliente
SELECT
    c.customer_name,
    COUNT(p.payment_id) AS quantidade_pagamentos,
    SUM(p.amount) AS valor_total
FROM customers c
INNER JOIN payments p
    ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY valor_total DESC;


-- 11. Maiores pagamentos
SELECT
    c.customer_name,
    p.amount,
    p.payment_date,
    p.payment_method,
    p.status
FROM customers c
INNER JOIN payments p
    ON c.customer_id = p.customer_id
ORDER BY p.amount DESC
LIMIT 5;


-- 12. Análise mensal
SELECT
    EXTRACT(MONTH FROM payment_date) AS mes,
    COUNT(*) AS quantidade_pagamentos,
    SUM(amount) AS valor_total
FROM payments
GROUP BY EXTRACT(MONTH FROM payment_date)
ORDER BY mes;
