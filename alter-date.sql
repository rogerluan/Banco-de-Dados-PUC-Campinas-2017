alter table teste rename column birth to birth_old;
alter table teste add birth date;
update teste set birth = to_date(birth_old, 'dd/mm/yy');
alter table teste drop column birth_old;