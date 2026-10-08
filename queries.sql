-- ============================================
-- SQL PAYMENTS
-- Consultas para análise de pagamentos
-- Autor: Victor Souza
-- ============================================


-- ============================================
-- 1. TOTAL DE PAGAMENTOS
-- ============================================

SELECT 
    COUNT(*) AS total_pagamentos
FROM payments;


-- ============================================
-- 2. VALOR TOTAL MOVIMENTADO
-- ============================================

SELECT 
    SUM(amount) AS valor_total
FROM payments;


-- ============================================
-- 3. TICKET MÉDIO
-- ============================================

SELECT 
    ROUND(AVG(amount), 2) AS ticket_medio
FROM payments;


-- ============================================
-- 4. PAGAMENTOS POR STATUS
-- ============================================

SELECT 
    status,
    COUNT(*) AS quantidade_pagamentos,
    SUM(amount) AS valor_total
FROM payments
GROUP BY status
ORDER BY valor_total DESC;


-- ============================================
-- 5. PAGAMENTOS POR MÉTODO
-- ============================================

SELECT 
    payment_method,
    COUNT(*) AS quantidade_pagamentos,
    SUM(amount) AS valor_total
FROM payments
GROUP BY payment_method
ORDER BY valor_total DESC;


-- ============================================
-- 6. PAGAMENTOS POR CLIENTE
-- ============================================

SELECT 
    c.customer_name,
    COUNT(p.payment_id) AS quantidade_pagamentos,
    SUM(p.amount) AS valor_total
FROM customers c
INNER JOIN payments p
    ON c.customer_id = p.customer_id
GROUP BY c.customer_name
ORDER BY valor_total DESC;


-- ============================================
-- 7. CLIENTES COM MAIOR VOLUME FINANCEIRO
-- ============================================

SELECT 
    c.customer_name,
    SUM(p.amount) AS valor_total
FROM customers c
INNER JOIN payments p
    ON c.customer_id = p.customer_id
GROUP BY c.customer_name
ORDER BY valor_total DESC;


-- ============================================
-- 8. MAIOR PAGAMENTO REALIZADO
-- ============================================

SELECT 
    MAX(amount) AS maior_pagamento
FROM payments;


-- ============================================
-- 9. MENOR PAGAMENTO REALIZADO
-- ============================================

SELECT 
    MIN(amount) AS menor_pagamento
FROM payments;


-- ============================================
-- 10. PAGAMENTOS APROVADOS
-- ============================================

SELECT 
    COUNT(*) AS pagamentos_aprovados,
    SUM(amount) AS valor_aprovado
FROM payments
WHERE status = 'Aprovado';


-- ============================================
-- 11. PAGAMENTOS RECUSADOS
-- ============================================

SELECT 
    COUNT(*) AS pagamentos_recusados,
    SUM(amount) AS valor_recusado
FROM payments
WHERE status = 'Recusado';


-- ============================================
-- 12. PAGAMENTOS PENDENTES
-- ============================================

SELECT 
    COUNT(*) AS pagamentos_pendentes,
    SUM(amount) AS valor_pendente
FROM payments
WHERE status = 'Pendente';


-- ============================================
-- 13. PAGAMENTOS POR PERÍODO
-- ============================================

SELECT 
    EXTRACT(MONTH FROM payment_date) AS mes,
    COUNT(*) AS quantidade_pagamentos,
    SUM(amount) AS valor_total
FROM payments
GROUP BY EXTRACT(MONTH FROM payment_date)
ORDER BY mes;


-- ============================================
-- 14. CLIENTES COM PAGAMENTOS ACIMA DE R$ 1.000
-- ============================================

SELECT 
    c.customer_name,
    p.amount,
    p.payment_date,
    p.payment_method,
    p.status
FROM customers c
INNER JOIN payments p
    ON c.customer_id = p.customer_id
WHERE p.amount > 1000
ORDER BY p.amount DESC;


-- ============================================
-- 15. RESUMO GERAL DOS PAGAMENTOS
-- ============================================

SELECT
    COUNT(*) AS total_pagamentos,
    SUM(amount) AS valor_total,
    ROUND(AVG(amount), 2) AS ticket_medio,
    MAX(amount) AS maior_pagamento,
    MIN(amount) AS menor_pagamento
FROM payments;


-- ============================================
-- 16. TAXA DE APROVAÇÃO
-- ============================================

SELECT
    ROUND(
        100.0 * SUM(
            CASE 
                WHEN status = 'Aprovado' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS taxa_aprovacao
FROM payments;


-- ============================================
-- 17. ANÁLISE POR CLIENTE E STATUS
-- ============================================

SELECT
    c.customer_name,
    p.status,
    COUNT(*) AS quantidade,
    SUM(p.amount) AS valor_total
FROM customers c
INNER JOIN payments p
    ON c.customer_id = p.customer_id
GROUP BY 
    c.customer_name,
    p.status
ORDER BY 
    c.customer_name,
    valor_total DESC;


-- ============================================
-- 18. TOP 5 CLIENTES POR VOLUME FINANCEIRO
-- ============================================

SELECT 
    c.customer_name,
    SUM(p.amount) AS valor_total
FROM customers c
INNER JOIN payments p
    ON c.customer_id = p.customer_id
GROUP BY c.customer_name
ORDER BY valor_total DESC
LIMIT 5;
