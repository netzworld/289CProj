--
-- Alterar Sessão (formato de Data e Linguagem)
--
ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YYYY HH24:MI:SS';
ALTER SESSION SET NLS_LANGUAGE = 'PORTUGUESE';

--
-- Exibe a data e hora atual e o usuario que esta conectado.
--
SELECT SYSDATE,USER FROM DUAL;

--
-- Exibe a quantidade de dias de vida e o dia da semana
--

SELECT ROUND (SYSDATE - TO_DATE('01/09/2003', 'DD/MM/YYYY'), 2 )DIAS_VIDA, TO_CHAR
(TO_DATE('01/09/2003','DD/MM/YYYY'), 'DAY') DIA_SEMANA_NASCIMENTO FROM DUAL;

--
--
--

SELECT 180*80, SYSDATE-10000, SYSDATE+50000 FROM DUAL;

--
--
--
SELECT * FROM T_RHSTU_PACIENTE;

SELECT T_RHSTU_PACIENTE.NM_PACIENTE,
       T_RHSTU_PACIENTE.DT_NASCIMENTO,
       TO_CHAR(T_RHSTU_PACIENTE.DT_NASCIMENTO, 'MONTH') MES_NASCIMENTO,
       T_RHSTU_PACIENTE.DS_ESTADO_CIVIL
FROM T_RHSTU_PACIENTE
ORDER BY T_RHSTU_PACIENTE.NM_PACIENTE;

--
-- Atualizando o estado civil do paciente, pois existe a necessidade de padronizar.
--
UPDATE T_RHSTU_PACIENTE SET DS_ESTADO_CIVIL = UPPER(DS_ESTADO_CIVIL);
COMMIT;

--
-- Utilizando ALIAS (Colocando um apelido no nome da tabela)
--
SELECT P.NM_PACIENTE,
       P.DT_NASCIMENTO,
       TO_CHAR(P.DT_NASCIMENTO, 'MONTH') MES_NASCIMENTO,
       P.DS_ESTADO_CIVIL
FROM T_RHSTU_PACIENTE P
ORDER BY P.NM_PACIENTE;

--
-- Usando Where para filtrar dados com base no Mês e Estado Civil
--
SELECT P.NM_PACIENTE NOME_DO_PACIENTE,
       P.DT_NASCIMENTO DATA_NASCIMENTO,
       TO_CHAR(P.DT_NASCIMENTO, 'MONTH') MES_NASCIMENTO,
       P.DS_ESTADO_CIVIL ESTADO_CIVIL
FROM T_RHSTU_PACIENTE P
WHERE TO_CHAR(P.DT_NASCIMENTO, 'MM') = '04'
AND P.DS_ESTADO_CIVIL = 'SOLTEIRO'
ORDER BY P.NM_PACIENTE;

-- Clausula OR coloca () para verificar o filtro do OR primeiro
SELECT P.NM_PACIENTE NOME_DO_PACIENTE,
       P.DT_NASCIMENTO DATA_NASCIMENTO,
       TO_CHAR(P.DT_NASCIMENTO, 'MONTH') MES_NASCIMENTO,
       P.DS_ESTADO_CIVIL ESTADO_CIVIL
FROM T_RHSTU_PACIENTE P
WHERE TO_CHAR(P.DT_NASCIMENTO, 'MM') = '04'
AND (P.DS_ESTADO_CIVIL = 'SOLTEIRO'
OR P.DS_ESTADO_CIVIL = 'CASADO')
ORDER BY P.NM_PACIENTE;

--
-- Operador de Concatenacao
--

SELECT 'O paciente ' || X.NM_PACIENTE || ' tem o sexo biologico ' ||
DECODE(X.FL_SEXO_BIOLOGICO, 'M', 'masculino', 'F', 'feminino', 'I', 'indefinido', 'Outros') 
|| ' e possui hoje ' ||
TRUNC (MONTHS_BETWEEN(SYSDATE, X.DT_NASCIMENTO)/ 12 ,0) 
|| ' e nasceu no dia ' || TO_CHAR(X.DT_NASCIMENTO, 'DD/MM/YYYY') TEXTO_PACIENTE
FROM T_RHSTU_PACIENTE X
ORDER BY TRUNC(MONTHS_BETWEEN(SYSDATE, X.DT_NASCIMENTO)/ 12, 0) DESC;

--
-- Coluna ROWID é o endereco fisico da linha no disco do servidor
-- Coluna ROWNUM: Exibe de forma sequencial o número da linha do SELECT
-- P.* significa todas as colunas da tabela em questão

SELECT 	ROWID, 
		ROWNUM, 
		P.*
FROM T_RHSTU_PACIENTE P;