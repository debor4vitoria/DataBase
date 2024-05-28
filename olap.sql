CREATE DATABASE vendas_olap;
USE vendas_olap;


CREATE TABLE preco (
    id INT AUTO_INCREMENT PRIMARY KEY,
    valor int
);

CREATE TABLE comida (
    id INT AUTO_INCREMENT PRIMARY KEY,
    categoria VARCHAR(50),
    subcategoria VARCHAR(50),
    nome VARCHAR(50),
    quantidade int
);

CREATE TABLE filiais (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pais VARCHAR(50),
    regiao VARCHAR(50),
    cidade VARCHAR(50)
);

CREATE TABLE vendas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    preco_id INT,
    comida_id INT,
    filiais_id INT,
    quantidade INT,
    receita DECIMAL(10, 2),
    lucro DECIMAL(10, 2),
    FOREIGN KEY (preco_id) REFERENCES preco(id),
    FOREIGN KEY (comida_id) REFERENCES comida(id),
    FOREIGN KEY (filiais_id) REFERENCES filiais(id)
);

INSERT INTO preco  (valor) VALUES
(100), (200), (300);


INSERT INTO comida (categoria, subcategoria, nome) VALUES
('saladas', 'salada do mar', 'camarão no repolho'),
('massa', 'lasanha', 'bolonhesa'),
('massa', 'pizza', 'portuguesa');

INSERT INTO filiais (pais, regiao, cidade) VALUES
('Brasil', 'nordeste', 'joao pessoa'),
('Brasil', 'nordeste', 'salvador'),
('brasil', 'nordeste', 'recife');

INSERT INTO vendas (preco_id, comida_id, filiais_id, quantidade, receita, lucro) VALUES
(1, 1, 1, 10, 1000, 20000),
(2, 2, 2, 10, 2000, 30000),
(3, 3, 3, 10, 3000, 15000);

SELECT p.valor, c.categoria, SUM(v.receita) AS receita_total
FROM vendas v
JOIN preco p ON v.preco_id = p.id
JOIN comida c ON v.comida_id = c.id
GROUP BY p.valor, c.categoria;

SELECT f.regiao, p.valor, SUM(v.lucro) AS lucro_total
FROM vendas v
JOIN preco p ON v.preco_id = p.id
JOIN filiais f ON v.filiais_id = f.id
GROUP BY f.regiao, p.valor;

SELECT f.cidade, c.nome, SUM(v.quantidade) AS quantidade_total
FROM vendas v
JOIN filiais f ON v.filiais_id = f.id
JOIN comida c ON v.comida_id = c.id
GROUP BY f.cidade, c.nome;

