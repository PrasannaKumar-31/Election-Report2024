/* 
cleaning the incorect data in satewise_result
*/ 

select distinct 
	State
from
	statewise_results;
    
alter table statewise_results 
add column new_state varchar(255);

update statewise_results sr
join states s on s.`state id` = sr.`state id`
set sr.new_state = s.state;

alter table statewise_results drop column State;
alter table statewise_results change column new_state State varchar(255);

/* 
Finding total num of seat in each state
*/
  
select distinct
	sr.state as state_name,
	count(cr.`Parliament Constituency`) as Tot_seats
from election_result_2024.constituencywise_results cr
inner join 
	election_result_2024.statewise_results sr
on
	sr.`Parliament Constituency` = cr.`Parliament Constituency`
inner join
	election_result_2024.states s
on
	sr.`State ID` = s.`State ID`
group by state_name 
order by state_name;