-- ============================================
-- SQL PAYMENTS
-- Banco de dados para análise de pagamentos
-- Autor: Victor Souza
-- ============================================

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(100),
    state CHAR(2)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    customer_id INT,
    payment_date DATE,
    amount DECIMAL(10,2),
    payment_method VARCHAR(50),
    status VARCHAR(30),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

-- ============================================
-- CLIENTES
-- ============================================

INSERT INTO customers
(customer_id, customer_name, city, state)
VALUES
(1, 'João Silva', 'São Paulo', 'SP'),
(2, 'Maria Santos', 'Campinas', 'SP'),
(3, 'Carlos Oliveira', 'Rio de Janeiro', 'RJ'),
(4, 'Ana Souza', 'Belo Horizonte', 'MG'),
(5, 'Lucas Ferreira', 'Curitiba', 'PR'),
(6, 'Juliana Costa', 'São Paulo', 'SP'),
(7, 'Rafael Almeida', 'Salvador', 'BA'),
(8, 'Beatriz Lima', 'Recife', 'PE');

-- ============================================
-- PAGAMENTOS
-- ============================================

INSERT INTO payments
(payment_id, customer_id, payment_date, amount, payment_method, status)
VALUES
(1, 1, '2026-01-05', 450.00, 'PIX', 'Aprovado'),
(2, 2, '2026-01-07', 780.50, 'Cartão', 'Aprovado'),
(3, 3, '2026-01-10', 320.00, 'Boleto', 'Pendente'),
(4, 4, '2026-01-12', 1250.00, 'PIX', 'Aprovado'),
(5, 5, '2026-01-15', 560.00, 'Cartão', 'Recusado'),
(6, 6, '2026-01-18', 920.00, 'PIX', 'Aprovado'),
(7, 7, '2026-01-20', 300.00, 'Boleto', 'Pendente'),
(8, 8, '2026-01-22', 1500.00, 'Cartão', 'Aprovado'),
(9, 1, '2026-02-03', 670.00, 'PIX', 'Aprovado'),
(10, 2, '2026-02-08', 890.00, 'Cartão', 'Aprovado'),
(11, 3, '2026-02-11', 430.00, 'PIX', 'Recusado'),
(12, 4, '2026-02-14', 1100.00, 'Boleto', 'Aprovado'),
(13, 5, '2026-02-17', 720.00, 'PIX', 'Aprovado'),
(14, 6, '2026-02-20', 980.00, 'Cartão', 'Pendente'),
(15, 7, '2026-02-22', 610.00, 'PIX', 'Aprovado'),
(16, 8, '2026-02-25', 1350.00, 'Cartão', 'Aprovado');
