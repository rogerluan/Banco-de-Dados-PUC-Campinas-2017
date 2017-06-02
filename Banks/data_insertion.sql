-- 2 --
insert into agencias values (1, 'campinas');
insert into agencias values (2, 'campinas');
insert into agencias values (3, 'sao paulo');
insert into agencias values (4, 'sao paulo');
insert into agencias values (5, 'guaruja');
insert into agencias values (6, 'guaruja');

-- 3 --
insert into contas values (1, 1, 'bruno', 0);
insert into contas values (2, 1, 'gabriel', 0);
insert into contas values (3, 2, 'laura', 0);
insert into contas values (4, 2, 'gabriela', 0);
insert into contas values (5, 3, 'bruna', 0);
insert into contas values (6, 3, 'pedro', 0);

-- 4 --
create sequence inc_movimentos start with 1 increment by 1;
create or replace trigger trigger_inc_movimentos
before insert on movimentos 
for each row
begin 
	select inc_movimentos.nextval into :new.num_mov from dual;
	select sysdate into :new.data from dual;
end;
/

-- 5 --
insert into movimentos (num_conta, num_agencia, tipo, valor) values (1, 1, 'c', 1000);
insert into movimentos (num_conta, num_agencia, tipo, valor) values (2, 1, 'd', 239);
insert into movimentos (num_conta, num_agencia, tipo, valor) values (3, 2, 'c', 9483);
insert into movimentos (num_conta, num_agencia, tipo, valor) values (4, 2, 'c', 8473);
insert into movimentos (num_conta, num_agencia, tipo, valor) values (5, 3, 'd', 4323);
insert into movimentos (num_conta, num_agencia, tipo, valor) values (6, 3, 'c', 3289);
insert into movimentos (num_conta, num_agencia, tipo, valor) values (1, 1, 'd', 5490);
insert into movimentos (num_conta, num_agencia, tipo, valor) values (2, 1, 'd', 5940);
insert into movimentos (num_conta, num_agencia, tipo, valor) values (3, 2, 'd', 7690);
insert into movimentos (num_conta, num_agencia, tipo, valor) values (4, 2, 'c', 2190);
insert into movimentos (num_conta, num_agencia, tipo, valor) values (5, 3, 'c', 8745);
insert into movimentos (num_conta, num_agencia, tipo, valor) values (6, 3, 'c', 9230);

-- 6 --
create or replace procedure update_balance is
begin
for movimento in (select * from movimentos) loop
	if movimento.tipo = 'c' then
		update contas set saldo = ((select saldo from contas where num_conta = movimento.num_conta) + movimento.valor) where num_conta = movimento.num_conta;
	elsif movimento.tipo = 'd' then
		update contas set saldo = ((select saldo from contas where num_conta = movimento.num_conta) - movimento.valor) where num_conta = movimento.num_conta;
	end if;
end loop;
end;
/


-- 7 --
create or replace trigger trigger_update_balance
before insert on movimentos
for each row
begin
	if :new.tipo = 'c' then
		update contas set saldo = ((select saldo from contas where num_conta = :new.num_conta) + :new.valor) where num_conta = :new.num_conta;
	elsif :new.tipo = 'd' then
		update contas set saldo = ((select saldo from contas where num_conta = :new.num_conta) - :new.valor) where num_conta = :new.num_conta;
	end if;
end;
/

-- 8 -- Criar uma função para, dada uma cidade, retornar o “resultado” (em valor) de movimentos (valor dos créditos menos valor dos débitos) nela ocorridos. A cidade considerada é aquela da agência onde ocorreu o movimento e não da agência da conta.
create or replace function balance_by_city(city in varchar2)
return number
is
	credit number;
	debit number;
begin
	select sum(value) into credit from movimentos where (select cidade from agencias where movimentos.num_agencia = agencias.num_agencia) = city and movimentos.tipo = 'c';
	select sum(value) into debit from movimentos where (select cidade from agencias where movimentos.num_agencia = agencias.num_agencia) = city and movimentos.tipo = 'd';
	return credit-debit;
end;
/

select balance_by_city('campinas') from dual;

-- 9 -- Criar outra função para, dada uma cidade, retornar a quantidade de movimentos (número de movimentos de créditos e débitos) nela ocorridos. Idem sobre a consideração do local da agência acima.
create or replace function mov_count_by_city(city in varchar2)
return number
is
	mov_count number;
begin
	select count(*) into mov_count from movimentos where (select cidade from agencias where movimentos.num_agencia = agencias.num_agencia) = city;
	return mov_count;
end;
/

select mov_count_by_city('campinas') from dual;

-- 10 -- Criar outra função para, dada uma cidade, retornar o valor médio dos movimentos (créditos e débitos) nela ocorridos. Idem sobre a consideração do local da agência acima.
create or replace function average_mov_by_city(city in varchar2)
return number
is 
	average_value number;
begin
	select avg(valor) into average_value from movimentos where (select cidade from agencias where movimentos.num_agencia = agencias.num_agencia) = city;
	return average_value;
end;
/

select average_mov('campinas') from dual;

-- 11 -- Eu poderia criar uma função única para retornar os três valores dos três exercícios anteriores? Explique.






