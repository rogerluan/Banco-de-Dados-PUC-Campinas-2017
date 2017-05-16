ALTER TABLE alunos RENAME COLUMN data_nasc TO data_nasc_old;
ALTER TABLE alunos ADD data_nasc date;
UPDATE alunos SET data_nasc = to_date(data_nasc_old, 'dd/mm/yyyy');
ALTER TABLE alunos DROP COLUMN data_nasc_old;