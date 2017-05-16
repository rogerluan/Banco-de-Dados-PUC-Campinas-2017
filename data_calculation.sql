-- Calculates the coef_desemp of a aluno, grouped by ra
SELECT ra, SUM(nota * creditos) / SUM(creditos) FROM cursadas, disciplinas WHERE cursadas.cod_disc = disciplinas.cod GROUP BY ra;


-- d)
-- Construa uma sentença em SQL que liste para cada aluno (RA), as disciplinas já CURSADAS, com seus respectivos resultados (sem/ano, nota,freq, status);
SELECT alunos.ra, nota, freq, status, sem_ano FROM alunos, cursadas WHERE cursadas.ra = alunos.ra ORDER BY alunos.ra ASC;

-- e)
-- Construa uma sentença em SQL que liste para cada aluno (RA), as disciplinas nas quais ele esteja matriculado (MATRÍCULA)
SELECT matriculas.ra, disciplinas.nome FROM disciplinas, matriculas WHERE matriculas.cod_disc = disciplinas.cod ORDER BY matriculas.ra ASC;

-- f)
-- Construa uma sentença em SQL que liste para cada aluno (RA), as disciplinas que faltam para a conclusão do seu Curso.
SELECT DISTINCT cursadas.ra, disciplinas.nome FROM alunos, cursadas, disciplinas, grade WHERE status != 'aprovado' AND cursadas.ra = alunos.ra AND grade.num_curso = alunos.num_curso ORDER BY cursadas.ra ASC;

-- g)
-- Construa uma sentença em SQL para calcular o coeficiente de desempenho de um aluno para o qual foi fornecido seu RA;
SELECT ra, SUM(nota * creditos) / SUM(creditos) FROM cursadas, disciplinas WHERE cursadas.cod_disc = disciplinas.cod_disc AND ra = 1;