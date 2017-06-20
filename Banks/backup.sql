create table backup_movimentos(
	num_mov number,
	num_conta number, 
	num_agencia number,
	data date,
	tipo char,
	valor number(15,2),
	primary key(num_mov),
	constraint num_conta_bkp_mov foreign key (num_conta) references contas(num_conta),
	constraint num_agencia_bkp_mov foreign key (num_agencia) references agencias(num_agencia)
);

-- num_log = incremental uid
-- chave = movimentos pk
-- tipo = 'i', 'd' or 'u' (insert, delete or update)
-- data = sysdate of insertion
-- is_processed = 1 or 0 (true or false), representing whether it has already been processed or not

create table log_movimentos(
	num_log number,
	chave number, 
	tipo char,
	data date,
	is_processed number,
	primary key(num_log),
	constraint num_log_mov foreign key (chave) references movimentos(num_mov)
);

-- log_movimentos sequence --
create sequence inc_log start with 1 increment by 1;
create or replace trigger trigger_inc_log
before insert on log_movimentos
for each row
begin 
	select inc_log.nextval into :new.num_log from dual;
	select sysdate into :new.data from dual;
	select 0 into :new.is_processed from dual;
end;
/

create or replace trigger trigger_logger
before insert or delete or update on movimentos
for each row
begin
	if inserting then
		insert into log_movimentos (chave, tipo) values (:new.num_mov, 'i');
	elsif deleting then
		insert into log_movimentos (chave, tipo) values (:old.num_mov, 'd');
	elsif updating then
		insert into log_movimentos (chave, tipo) values (:new.num_mov, 'u');
	end if;
end;
/

create or replace procedure update_backup is
	line_exist_in_original_table number := 0;
	line_exist_in_backup_table number := 0;
begin
dbms_output.put_line ('Your backup is being processed...');
for log in (select * from log_movimentos where is_processed = 0) loop
	select count(*) into line_exist_in_backup_table from backup_movimentos where num_mov = log.chave;
	if log.tipo = 'd' then
		if line_exist_in_backup_table = 1 then
			delete from backup_movimentos where num_mov = log.chave;
			dbms_output.put_line ('Deleted record in backup table with identifier = ' || log.chave);
		end if;
	else
		dbms_output.put_line ('Inserting or deleting... Exist in original =  ' || line_exist_in_original_table || ' exist in backup = ' || line_exist_in_backup_table);
		select count(*) into line_exist_in_original_table from movimentos where num_mov = log.chave;
		if line_exist_in_original_table = 1 AND line_exist_in_backup_table = 1 then
			update backup_movimentos set (num_conta, num_agencia, data, tipo, valor) = (select num_conta, num_agencia, data, tipo, valor from movimentos where num_mov = log.chave) where num_mov = log.chave;
			dbms_output.put_line ('Updated record in backup table with identifier = ' || log.chave);
		elsif line_exist_in_original_table = 1 then 
			insert into backup_movimentos (select * from movimentos where num_mov = log.chave);
			dbms_output.put_line ('Created record in backup table with identifier = ' || log.chave);
		end if;
	end if;
	update log_movimentos set is_processed = 1 where num_log = log.num_log;
end loop;
dbms_output.put_line ('Your backup is now up-to-date!');
end;
/

set serveroutput on