SET SERVEROUTPUT ON;

-- create or replace procedure Classifica_Cursos_versão1
--     is
--    V_classifica varchar2(10);
--   begin
--   for R in (select nome_curso, preco from curso) loop
--     if R.preco <  200 then
--      V_classifica := 'Baixo';
--     elsif R.preco < 350 then
--      v_classifica := 'Médio';
--     else
--      v_classifica := 'Alto';
--     end if;
--    dbms_output.put_line ('Curso: ' || R.nome_curso || ' é um curso de valor ' ||  
--            v_classifica);
--    end loop;
--   end;
-- /

-- 1. Retornar o coeficiente de desempenho de um aluno, dado um RA
CREATE OR REPLACE FUNCTION get_coef_desemp (p_ra number) RETURN number IS
return_coef_desemp number;
BEGIN
	SELECT SUM(nota * creditos) / SUM(creditos) INTO return_coef_desemp FROM cursadas, disciplinas WHERE cursadas.cod_disc = disciplinas.cod AND cursadas.ra = p_ra;
	RETURN (return_coef_desemp);
END;

-- 2. Imprimir o histórico escolar contendo as disciplinas que estão sendo cursadas, as que já foram cursadas (com status, nota, etc etc), e as que faltam pra se formar.
CREATE OR REPLACE PROCEDURE print_historico_escolar IS 



END;
