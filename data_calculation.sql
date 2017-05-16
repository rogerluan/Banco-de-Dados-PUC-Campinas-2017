-- Calculates the coef_desemp of a aluno, grouped by ra
SELECT SUM(nota * cred) / SUM(cred) FROM cursadas, disciplinas WHERE cursadas.cod_disc = disciplinas.cod_disc GROUP BY ra;

UPDATE alunos SET coef_desemp = 


-- f)
SELECT disciplinas.nome FROM alunos, disciplinas, grade, cursadas WHERE alunos.num_curso = grade.num_curso AND (cursadas.cod_disc NOT IN (SELECT disciplinas.cod FROM grade, disciplinas WHERE grade.cod_disc = disciplinas.cod GROUP BY disciplinas.cod) AND cursadas.status != 'reprovado') GROUP BY ra;