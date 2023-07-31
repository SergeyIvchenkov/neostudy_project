create schema DS

create schema logs

create table ds.ft_balance_f (
	on_date date not null,
	account_rk numeric not null,
	currency_rk numeric,
	balance_out float,
	constraint ft_balance_f_pk primary key (on_date, account_rk)
)

create table ds.ft_posting_f (
	oper_date date not null,
	credit_account_rk numeric not null,
	debet_account_rk numeric not null,
	credit_amount float,
	debet_amount float,
	constraint ft_posting_f_pk primary key (oper_date, credit_account_rk, debet_account_rk)
)

create table ds.md_account_d (
	data_actual_date date not null,
	data_actual_end_date date not null,
	account_rk numeric not null,
	account_number varchar(20) not null,
	char_type varchar(1) not null,
	currency_rk numeric not null,
	currency_code varchar(3) not null,
	constraint md_account_d_pk primary key (data_actual_date, account_rk)
)

create table ds.md_currency_d (
	currency_rk numeric not null,
	data_actual_date date not null,
	data_actual_end_date date,
	currency_code varchar(3),
	code_iso_char varchar(3),
	constraint md_currency_d_pk primary key (currency_rk, data_actual_date)
)

--корректное отображение китайского символа
update ds.md_currency_d 
set code_iso_char = chr(27094)
where currency_rk = 33 and data_actual_date = '2017-05-11'


--ИЛИ замена китайского символа на валюту CNY
update ds.md_currency_d 
set code_iso_char = 'CNY'
where currency_rk = 33 and data_actual_date = '2017-05-11'


create table ds.md_exchange_rate_d (
	data_actual_date date not null, 
	data_actual_end_date date,
	currency_rk numeric not null,
	reduced_cource float,
	code_iso_num varchar(3),
	constraint md_exchange_rate_pk primary key (data_actual_date, currency_rk)
)

create table ds.md_ledger_account_s (
	chapter char(1),
	chapter_name varchar(16),
	section_number int,
	section_name varchar(22),
	subsection_name varchar(21),
	ledger1_account int,
	ledger1_account_name varchar(47),
	ledger_account int not null,
	ledger_account_name varchar(153),
	characteristic char(1),
	is_resident int,
	is_reserve int,
	is_reserved int,
	is_loan int,
	is_reserved_assets int,
	is_overdue int,
	is_interest int,
	pair_account varchar(5),
	start_date date not null, 
	end_date date,
	is_rub_only int,
	min_term varchar(1),
	min_term_measure varchar(1),
	max_term varchar(1),
	max_term_measure varchar(1),
	ledger_acc_full_name_translit varchar(1),
	is_revaluation varchar(1),
	is_correct varchar(1),
	constraint md_ledger_account_s_pk primary key (ledger_account, start_date)
)


CREATE TABLE logs.log_table( 
	row_changetime TIMESTAMP default current_timestamp, 
	"source" VARCHAR(50), 
	action_datetime TIMESTAMP, 
	status VARCHAR(50)
)


truncate table ds.ft_posting_f, ds.ft_balance_f , ds.md_account_d , ds.md_currency_d , ds.md_exchange_rate_d , ds.md_ledger_account_s, logs.log_table  

