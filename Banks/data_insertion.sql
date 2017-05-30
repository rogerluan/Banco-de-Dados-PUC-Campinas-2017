INSERT INTO alunos (ra,nome,data_nasc,cidade,num_curso) VALUES (11,'Vladimir','19/08/1981','campinas',1);

insert into agencias values (1, 'campinas');
insert into agencias values (2, 'campinas');
insert into agencias values (3, 'sao paulo');
insert into agencias values (4, 'sao paulo');
insert into agencias values (5, 'guaruja');
insert into agencias values (6, 'guaruja');

insert into contas values (1, 1, 'bruno', 0);
insert into contas values (2, 1, 'gabriel', 0);
insert into contas values (3, 2, 'laura', 0);
insert into contas values (4, 2, 'gabriela', 0);
insert into contas values (5, 3, 'bruna', 0);
insert into contas values (6, 3, 'pedro', 0);

create sequence inc_movimentos start with 1 increment by 1;

create or replace trigger trigger_inc_movimentos
before insert on movimentos 
for each row
begin 
	select inc_movimentos.nextval into :new.num_mov from dual;
	select sysdate into:new.data from dual;
end;
/

insert into movimentos (num_conta, num_agencia, ) 