alter table alunos rename column data_nasc to data_nasc_old;
alter table alunos add data_nasc date;
update alunos set data_nasc = to_date(data_nasc_old, 'dd/mm/yyyy');
alter table alunos drop column data_nasc_old;