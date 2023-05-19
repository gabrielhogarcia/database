-- Criando um banco de dados
CREATE DATABASE bdprecocerto;

USE bdprecocerto;






---------- CRIANDO TABELAS -----------------




-- Tabela pedido_ingrediente

CREATE TABLE pedidos_ingredientes(
    codigo_ingrediente INT NOT NULL,   
    codigo_fornecedor INT NOT NULL,   
    quantidade INT NOT NULL,
    valor DECIMAL(10.2) NOT NULL,
    PRIMARY KEY(codigo_ingrediente, codigo_fornecedor)
);




-- Tabela Ingredientes

CREATE TABLE ingredientes(
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    tamanho DECIMAL(10.2) NOT NULL,
    valor_unitario DECIMAL(10.2) NOT NULL,

    PRIMARY KEY(id)
);



-- Tabela ingredientes-receitas
CREATE TABLE ingredientes_receitas (
    codigo_ingrediente INT NOT NULL,    
    codigo_receita INT NOT NULL,        
    quantidade INT NOT NULL,

    PRIMARY KEY(codigo_ingrediente, codigo_receita)
);





-- Tabela receitas
CREATE TABLE receitas(
    id INT NOT NULL auto_increment,
    data_criacao DATE NOT NULL,
    taxa DECIMAL(10.2) NOT NULL,
    preco_custo DECIMAL(10.2),
    rendimento INT NOT NULL,

    PRIMARY KEY (id)
);



-- Tabela produtos
CREATE TABLE produtos(
    id INT NOT NULL auto_increment,
    nome VARCHAR(80) NOT NULL,
    descricao VARCHAR(200) NOT NULL,
    tamanho DECIMAL(10.2) NOT NULL,
    taxa_lucro DECIMAL(10.2) NOT NULL,
    codigo_receita INT NOT NULL,            
    PRIMARY KEY (id)
);



-- Tabela produtos_pedidos
CREATE TABLE produtos_pedidos(
    codigo_produto INT NOT NULL,   
    codigo_pedido INT NOT NULL,    
    quantidade INT NOT NULL,

    PRIMARY KEY (codigo_produto, codigo_pedido)

);





-- Tabelas pedidos
CREATE TABLE pedidos(
    id INT NOT NULL auto_increment,
    data DATE NOT NULL,
    codigo_cliente INT NOT NULL,    
    frete DECIMAL(10.2) NOT NULL,
    desconto DECIMAL(10.2) NOT NULL,
    adicional DECIMAL(10.2),
    total DECIMAL(10.2) NOT NULL,
    codigo_funcionario INT NOT NULL,    
    PRIMARY KEY(id)
);




-- Tabela clientes
CREATE TABLE clientes(
    id INT NOT NULL auto_increment,
    nome VARCHAR(80) NOT NULL,
    cpf VARCHAR(40) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    rua  INT NOT NULL,     
    numero VARCHAR(30) NOT NULL,
    complemento VARCHAR(80) NOT NULL,
    PRIMARY KEY(id)
);



-- Tabela funcionarios
CREATE TABLE funcionarios(
    id INT NOT NULL auto_increment,
    nome VARCHAR(80) NOT NULL,
    login VARCHAR(16) NOT NULL,
    senha VARCHAR(16) NOT NULL,
    nivel INT NOT NULL,
    cpf VARCHAR(40) NOT NULL,
    rua INT NOT NULL,   
    numero VARCHAR(30) NOT NULL,
    complemento VARCHAR(80) NOT NULL,
    PRIMARY KEY (id)
);



-- Tabela pagamento
CREATE TABLE pagamento(
    id INT NOT NULL AUTO_INCREMENT,
    data DATE NOT NULL,
    valor_pagamento DECIMAL(10.2) NOT NULL,
    codigo_pagamento INT NOT NULL,              
    tipo_pagamento INT NOT NULL,

    PRIMARY KEY(id)
);



-- Tabela tipo_pagamento
CREATE TABLE tipo_pagamento(
    id INT NOT NULL AUTO_INCREMENT,
    tipo INT NOT NULL,
    parcela INT NOT NULL,

    PRIMARY KEY(id)
);


-- Tabela preco
CREATE TABLE preco(
    id INT NOT NULL AUTO_INCREMENT,
    data DATE NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    codigo_produto INT NOT NULL,        

    PRIMARY KEY(id)
);



-- Tabela compra
CREATE TABLE compra(
    id INT NOT NULL AUTO_INCREMENT,
    nf_pedido INT NOT NULL,
    data DATE NOT NULL,
    codigo_fornecedor INT NOT NULL,         

    PRIMARY KEY(id)
);



-- Tabela fornecedores
CREATE TABLE fornecedores(
    id INT NOT NULL auto_increment,
    razaosocial VARCHAR(80) NOT NULL,
    nome_fantasia VARCHAR(80) NOT NULL,
    cpf_cnpj VARCHAR(14) NOT NULL,
    rg_ie VARCHAR(14) NOT NULL,
    rua INT NOT NULL,      
    numero VARCHAR(80) NOT NULL,
    complemento VARCHAR(80) NOT NULL,
    PRIMARY KEY(id)
);



-- Tabela estado
CREATE TABLE estado(
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    uf VARCHAR(2) NOT NULL,
    PRIMARY KEY(id)
);



-- Tabela cidade
CREATE TABLE cidade(
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    codigo_estado INT NOT NULL, 
    PRIMARY KEY(id)    
);



-- Tabela bairro
CREATE TABLE bairro(
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    codigo_cidade INT NOT NULL,   
    PRIMARY KEY(id)  
);




-- Taela rua
CREATE TABLE rua(
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    codigo_bairro INT NOT NULL,     
    CEP VARCHAR(50) NOT NULL,
    PRIMARY KEY(id)
);

ALTER TABLE rua ADD CONSTRAINT fk_ruas_bairro FOREIGN KEY (codigo_bairro) REFERENCES bairro (id);
ALTER TABLE compra ADD CONSTRAINT fk_rua_bairro FOREIGN KEY (codigo_fornecedor) REFERENCES fornecedores (id);
ALTER TABLE fornecedores ADD CONSTRAINT fk_rua_fornecedores FOREIGN KEY (rua) REFERENCES rua (id);
ALTER TABLE cidade ADD CONSTRAINT fk_cidade_estado FOREIGN KEY (codigo_estado) REFERENCES estado (id);
ALTER TABLE bairro ADD CONSTRAINT fk_bairro_cidade FOREIGN KEY (codigo_cidade) REFERENCES cidade (id);
ALTER TABLE pedidos ADD CONSTRAINT fk_pedido_cliente FOREIGN KEY (codigo_cliente) REFERENCES clientes (id);
ALTER TABLE pedidos ADD CONSTRAINT fk_pedido_funcionario FOREIGN KEY (codigo_funcionario) REFERENCES funcionarios (id);
ALTER TABLE clientes ADD CONSTRAINT fk_cliente_rua FOREIGN KEY (rua) REFERENCES rua (id);
ALTER TABLE pagamento ADD CONSTRAINT fk_codigopagamento_pedidos FOREIGN KEY (codigo_pagamento) REFERENCES pedidos (id);
ALTER TABLE pagamento ADD CONSTRAINT fk_tipopagamento_pedidos FOREIGN KEY (tipo_pagamento) REFERENCES tipo_pagamento (id);
ALTER TABLE funcionarios ADD CONSTRAINT fk_funcionario_rua FOREIGN KEY (rua) REFERENCES rua (id);
ALTER TABLE preco ADD CONSTRAINT fk_preco_produto FOREIGN KEY (codigo_produto) REFERENCES produtos (id);
ALTER TABLE produtos ADD CONSTRAINT fk_pedido_receita FOREIGN KEY (codigo_receita) REFERENCES receitas (id);
ALTER TABLE produtos_pedidos ADD CONSTRAINT fk_produto_produtos FOREIGN KEY (codigo_produto) REFERENCES produtos (id);
ALTER TABLE ingredientes_receitas ADD CONSTRAINT fk_ingrediente_ingredientes FOREIGN KEY (codigo_ingrediente) REFERENCES ingredientes (id);
ALTER TABLE pedidos_ingredientes ADD CONSTRAINT fk_pedido_ingrediente FOREIGN KEY (codigo_ingrediente) REFERENCES ingredientes (id);
ALTER TABLE produtos_pedidos ADD CONSTRAINT fk_pedido_pedidos FOREIGN KEY (codigo_pedido) REFERENCES pedidos (id);
ALTER TABLE ingredientes_receitas ADD CONSTRAINT fk_receita_receitas FOREIGN KEY (codigo_receita) REFERENCES receitas (id);
ALTER TABLE pedidos_ingredientes ADD CONSTRAINT fk_pedido_forncedor FOREIGN KEY (codigo_fornecedor) REFERENCES fornecedores (id);



select * from clientes order by nome; 
--select de todos os clientes


delete from clientes where id > 0;
-- apagar a tabela clientes com os id's maior que 1


alter table clientes auto_increment =1;
-- resetar os id's



INSERT INTO cidade (nome, codigo_estado) 
VALUES ('São Paulo', 1), 
('Rio de Janeiro', 2), 
('Belo Horizonte', 3), 
('Salvador', 4), 
('Curitiba', 5);




INSERT INTO bairro (nome, codigo_cidade) 
VALUES ('Moema', 1), 
('Copacabana', 2), 
('Savassi', 3), 
('Barra', 4), 
('Batel', 5);


INSERT INTO rua (nome, codigo_bairro, CEP) 
VALUES ('Rua A', 1, '01234-567'), 
('Rua B', 2, '23456-789'), 
('Rua C', 3, '34567-890'), 
('Rua D', 4, '45678-901'), 
('Rua E', 5, '56789-012');        



INSERT INTO clientes (nome, cpf, telefone, rua, numero, complemento) 
VALUES ('João Silva', 12345, '123456789', 1, '123', 'Complemento 1'),
('Maria Santos', 23456, '234567890', 2, '456', 'Complemento 2'),
('Pedro Oliveira', 3456, '345678901', 3, '789', 'Complemento 3'),
('Ana Pereira', 45678, '456789012', 4, '012', 'Complemento 4'),
('Lucas Almeida', 56789, '567890123', 5, '345', 'Complemento 5');

