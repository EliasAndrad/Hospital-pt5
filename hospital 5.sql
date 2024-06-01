    use hospital;

-- Todos os dados e o valor médio das consultas do ano de 2020 e das que foram feitas sob convênio.
SELECT * FROM CONSULTA
WHERE
    
YEAR(DATA_HORA) = 2020
AND ID_CONVENIO IS NOT NULL;
SELECT
AVG(VALOR_CONSULTA) AS VALOR_MEDIO
FROM CONSULTA WHERE
YEAR(DATA_HORA) = 2020
AND ID_CONVENIO IS NOT NULL;

-- Todos os dados das internações que tiveram data de alta maior que a data prevista para a alta.

SELECT * FROM INTERNACAO
WHERE  DATA_SAIDA > DATA_PREV_ALTA;

SELECT * FROM RECEITA;
-- Receituário completo da primeira consulta registrada com receituário associado.
SELECT INSTRUCOES 
FROM RECEITA 
WHERE ID_CONSULTA = 109;

-- Todos os dados da consulta de maior valor e também da de menor valor (ambas as consultas não foram realizadas sob convênio
-- OBS TODAS AS CONSULTA REGISTRADAS NA BASE DE DADOS POSSUI CONVENIO ASSOCIADO
SELECT * 
FROM CONSULTA 
WHERE VALOR_CONSULTA = (SELECT MAX(VALOR_CONSULTA) FROM CONSULTA);

SELECT * 
FROM CONSULTA 
WHERE VALOR_CONSULTA = (SELECT MIN(VALOR_CONSULTA) FROM CONSULTA);

-- Data, procedimento e número de quarto de internações em quartos do tipo “apartamento”.
SELECT
I.DATA_ENTRADA AS Data_Internacao,
Q.NUMERO_QUARTO AS Numero_Quarto
FROM NTERNACAO I
INNER JOIN
QUARTO Q ON I.ID_QUARTO = Q.ID_QUARTO
WHERE
Q.TIPO_QUARTO = 'APARTAMENTO';

-- Nome do paciente, data da consulta e especialidade de todas as consultas em que os pacientes eram menores de 18 anos na data da consulta e cuja especialidade não seja “pediatria”, ordenando por data de realização da consulta.

-- Nome do paciente, nome do médico, data da internação e procedimentos das internações realizadas por médicos da especialidade “gastroenterologia”, que tenham acontecido em “enfermaria”.
SELECT 
    P.NOME AS 'Nome do Paciente',
    M.NOME AS 'Nome do Médico',
    I.DATA_ENTRADA AS 'Data da Internação',
    R.MEDICAMENTOS AS 'Procedimentos'
FROM 
    INTERNACAO I
INNER JOIN 
    PACIENTE P ON I.CPF_PACIENTE = P.CPF_PACIENTE
INNER JOIN 
    QUARTO Q ON I.ID_QUARTO = Q.ID_QUARTO
INNER JOIN 
    MEDICO M ON I.CRM_ID = M.CRM_ID

INNER JOIN 
    RECEITA R;
    
    
-- Os nomes dos médicos, seus CRMs e a quantidade de consultas que cada um realizou.

SELECT M.NOME AS Nome_Medico, M.CRM_ID AS CRM, COUNT(C.ID_CONSULTA) AS Quantidade_Consultas
FROM MEDICO M
LEFT JOIN CONSULTA C ON M.CRM_ID = C.CRM_ID
GROUP BY M.NOME, M.CRM_ID;

-- Todos os médicos que tenham "Gabriel" no nome. 
SELECT * 
FROM MEDICO
WHERE NOME LIKE'%GABRIEL%';

-- Os nomes, CREs e número de internações de enfermeiros que participaram de mais de uma internação.
SELECT E.NOME, E.ID_COREM, COUNT(*) AS Numero_de_Internacoes
FROM ENFERMEIRO E
INNER JOIN ENFERMEIRO_INTERNACOES EI ON E.ID_COREM = EI.ID_COREM
GROUP BY E.ID_COREM, E.NOME;

-- Inserir dados na tabela ENFERMEIRO_INTERNACOES
INSERT INTO ENFERMEIRO_INTERNACOES (ID_INTERNACAO, ID_COREM)
VALUES
(1, 12345),
(2, 23456),
(3, 34567),
(4, 45678),
(5, 56789),
(6, 67890),
(7, 78901),
(8, 89012),
(9, 90123);

