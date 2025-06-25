/* 
cleaning the incorect data in satewise_result
*/ 

select distinct 
	States
from
	statewise_results;
    
alter table statewise_results 
add column new_state varchar(255);

update statewise_results sr
join states s on s.`state id` = sr.`state id`
set sr.new_state = s.state;

alter table statewise_results drop column State;
alter table statewise_results change column new_state States varchar(255);

/* 
Finding total num of seat in each state
*/
  
select distinct
	sr.states as state_name,
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

/* 
cleaning the party id, deleting the old messy party id and creating new corrected party id,
manually add the no of seat won in won column using old party id. 
sorting by party allience by creating new coloumn to find tot seats won by each alliences
*/ 

-- SELECT * FROM election_result_2024.pr_table;

-- rename table pr_table to  partywise_results;
-- SELECT * FROM election_result_2024.partywise_results;

-- alter table pr_table
-- add column won int;

-- alter table election_result_2024.partywise_results
-- rename column merged_col to Party;

update election_result_2024.partywise_results
set won = case Party
		when 'Aam Aadmi Party' then 3
		when 'Aazad Samaj Party (Kanshi Ram)' then 1 
		when 'AJSU Party' then 	1
		when 'All India Majlis' then 1
		when 'All India Trinamool Congress' then 29
		when 'Apna Dal (Soneylal)' then 1
		when 'Asom Gana Parishad' then 1
		when 'Bharat Adivasi Party' then 1
		when 'Bharatiya Janata Party' then 240
        when 'Communist Party of India' then 2
		when 'Communist Party of India  (Marxist-Leninist)' then 2
		when 'Communist Party of India  (Marxist)' then 4
		when 'Dravida Munnetra Kazhagam' then 22
		when'Hindustani Awam Morcha (Secular)' then 1  
		when 'Independent' then 7
		when 'Indian National Congress' then 99
		when 'Indian Union Muslim League' then 2
		when 'Jammu & Kashmir National Conference' then 2  
		when 'Janasena Party' then 2
		when 'Janata Dal  (Secular)' then 2
		when 'Janata Dal  (United)' then 12
		when 'Jharkhand Mukti Morcha' then 3
		when 'Kerala Congress' then 1
		when 'Lok Janshakti Party(Ram Vilas)' then 5
		when 'Marumalarchi Dravida Munnetra Kazhagam' then 1
		when 'Nationalist Congress Party'	then 1
		when 'Nationalist Congress Party Sharadchandra Pawar' then 	8
		when 'Rashtriya Janata Dal' then 4
		when 'Rashtriya Lok Dal' then 2
		when 'Rashtriya Loktantrik Party' then 1
		when 'Revolutionary Socialist Party' then 1
		when 'Samajwadi Party' then 37
		when 'Shiromani Akali Dal' then 1
		when 'Shiv Sena' then 7
		when 'Shiv Sena (Uddhav Balasaheb Thackrey)' then 9
		when 'Sikkim Krantikari Morcha' then 1
		when 'Telugu Desam' then 16
		when 'United Peopleâ€™s Party, Liberal' then 1
		when 'Viduthalai Chiruthaigal Katchi' then 2
		when 'Voice of the People Party' then 1
		when 'Yuvajana Sramika Rythu Congress Party' then 4
		when 'Zoram Peopleâ€™s Movement' then 1

		else 0 
		end 
            
		where Party in ('Aam Aadmi Party',
							'Aazad Samaj Party (Kanshi Ram)',
                            'AJSU Party' ,
							'All India Majlis',
							'All India Trinamool Congress', 
							'Apna Dal (Soneylal)',
							'Asom Gana Parishad', 
							'Bharat Adivasi Party', 
							'Bharatiya Janata Party',
                            'Communist Party of India', 
							'Communist Party of India  (Marxist-Leninist)',
							'Communist Party of India  (Marxist)', 
							'Dravida Munnetra Kazhagam',
							'Hindustani Awam Morcha (Secular)', 
							'Independent',
							'Indian National Congress', 
							'Indian Union Muslim League', 
							'Jammu & Kashmir National Conference', 
							'Janasena Party',
                            'Janata Dal  (Secular)', 
							'Janata Dal  (United)', 
							'Jharkhand Mukti Morcha', 
							'Kerala Congress', 
							'Lok Janshakti Party(Ram Vilas)', 
							'Marumalarchi Dravida Munnetra Kazhagam', 
							'Nationalist Congress Party', 
							'Nationalist Congress Party Sharadchandra Pawar', 
							'Rashtriya Janata Dal', 
							'Rashtriya Lok Dal', 
							'Rashtriya Loktantrik Party', 
							'Revolutionary Socialist Party', 
							'Samajwadi Party', 
							'Shiromani Akali Dal', 
							'Shiv Sena', 
							'Shiv Sena (Uddhav Balasaheb Thackrey)', 
							'Sikkim Krantikari Morcha', 
							'Telugu Desam', 
							'United Peopleâ€™s Party, Liberal', 
							'Viduthalai Chiruthaigal Katchi', 
							'Voice of the People Party', 
							'Yuvajana Sramika Rythu Congress Party', 
							'Zoram Peopleâ€™s Movement'
						);

alter table election_result_2024.partywise_results
add column Party_allience varchar(255);

UPDATE election_result_2024.partywise_results
SET Party_allience = 'NDA'
WHERE party IN (
  'AJSU Party',
  'Apna Dal (Soneylal)',
  'Asom Gana Parishad',
  'Bharatiya Janata Party',
  'Hindustani Awam Morcha (Secular)',
  'Janasena Party',
  'Janata Dal  (Secular)',
  'Janata Dal  (United)',
  'Lok Janshakti Party(Ram Vilas)',
  'Nationalist Congress Party',
  'Rashtriya Lok Dal',
  'Shiv Sena',
  'Sikkim Krantikari Morcha',
  'Telugu Desam'
);

UPDATE election_result_2024.partywise_results
SET Party_allience = 'I.N.D.I.A'
WHERE party IN (
  'Aam Aadmi Party',
  'All India Trinamool Congress',
  'Bharat Adivasi Party',
  'Communist Party of India  (Marxist-Leninist)',
  'Communist Party of India  (Marxist)',
  'Communist Party of India',
  'Dravida Munnetra Kazhagam',
  'Indian National Congress',
  'Indian Union Muslim League',
  'Jammu & Kashmir National Conference',
  'Jharkhand Mukti Morcha',
  'Kerala Congress',
  'Marumalarchi Dravida Munnetra Kazhagam',
  'Nationalist Congress Party Sharadchandra Pawar',
  'Rashtriya Janata Dal',
  'Rashtriya Loktantrik Party',
  'Revolutionary Socialist Party',
  'Samajwadi Party',
  'Shiv Sena (Uddhav Balasaheb Thackrey)',
  'Viduthalai Chiruthaigal Katchi'
);

UPDATE election_result_2024.partywise_results
SET Party_allience = 'Other'
WHERE Party_allience IS NULL;

/*
Manually correcting old party id to new party id for proper data 
*/

SELECT * FROM election_result_2024.constituencywise_results;
select distinct `Party ID` 
from election_result_2024.constituencywise_results;

update election_result_2024.constituencywise_results
set `Party ID` = case `Party ID`
				when 369 then 9
                when 2989 then 128
                when 2070 then 123
                when 140 then 30
                when 118 then 58
                when 160 then 145
                when 83 then 129 
                when 3482 then 47
                when 544 then 76
                when 545 then 74
                when 547 then 29
                when 582 then 13
                when 664 then 144
                when 743 then 3
                when 742 then 8
                when 772 then 26
                when 834 then 68
                when 860 then 11
                when 804 then 81 
                when 805 then 64
                when 852 then 12
                when 911 then 95
                when 3165 then 48
                when 1046 then 75
                when 1142 then 131
                when 3620 then 31
                when 1420 then 113
                when 1458 then 114
                when 2484 then 127 
                when 1534 then 92
                when 1680 then 27 
                when 1584 then 130
                when 3529 then 25
                when 3369 then 24
                when 1658 then 66
                when 1745 then 67
                when 1998 then 80
                when 1847 then 50
                when 3388 then 65 
                when 1888 then 10
                when 2757 then 124
                when 1 then 49
                else `Party ID`
                end
                
			where `Party ID` in (
								1,2989,160,118,140,2070,83,3482,369,547,545,544,582,
                                664,743,742,772,834,860,804,805,852,911,3165,1046,1142,
                                3620,1420,1458,2484,1534,1680,1584,3529,3369,1658,1745,
                                1998,1847,3388,1888,2757
							);

-- finding total seats won by each alliense 

select 
	Party,won,
	sum(won) over(partition by Party_allience) as Tot_seats_NDA
    
from election_result_2024.partywise_results
where Party_allience = 'NDA';

select 
	Party,won,
	sum(won) over(partition by Party_allience) as Tot_seats_IndiaAllience
    
from election_result_2024.partywise_results
where Party_allience = 'I.N.D.I.A';

select 
	Party,won,
	sum(won) over(partition by Party_allience) as Tot_seats_others
    
from election_result_2024.partywise_results
where Party_allience = 'Other';

/*
 Winning candidate name, Party, margin, tot vote for specific state and constituancy
*/

select 
	cr. `Winning Candidate`,
	pr.Party,
	pr.Party_allience,
	cr.`Total Votes`,
	cr.Margin,
	s.State,
	cr.`Constituency Name`

from
	election_result_2024.constituencywise_results cr
inner join
	election_result_2024.partywise_results pr
on
	cr.`Party ID` = pr.`Party ID`
inner join
	election_result_2024.statewise_results sr
on
	cr.`Parliament Constituency` = sr.`Parliament Constituency`
inner join
	election_result_2024.states s
on
	sr.`State ID` = s.`State ID`
    
where 
	s.State = 'Tamil Nadu';
    
/* 
	max seats won by partys in states
*/
	
select 
	pr.party,
	pr.Party_allience,
    count(cr.`Constituency ID`) as total_seats
from 
	election_result_2024.partywise_results pr
join
	election_result_2024.constituencywise_results cr
on
	cr.`Party ID` = pr.`Party ID`
join
	election_result_2024.statewise_results sr
on
	cr.`Parliament Constituency` = sr.`Parliament Constituency`
join
	election_result_2024.states s
on 
	sr.`State ID` = s.`State ID`
    
where
	state =  'Rajasthan'
group by
	pr.party_allience,
    pr.party
    
order by
	total_seats desc;
    
/*
tot seats won by alliences
*/ 
  
select
	s.state,
    sum(case
		when 
			pr.Party_allience = 'NDA'
		then 1 
		else 0 end) as NDA_seats,
	sum(case
		when 
			pr.Party_allience = 'I.N.D.I.A'
		then 1 
        else 0 end) as 'I.N.D.I.A_seats',
	sum(case
		when 
			pr.Party_allience = 'Others'
		then 1 
        else 0 end) as others_seats
from
	election_result_2024.partywise_results pr
join
	election_result_2024.constituencywise_results cr
on
	cr.`Party ID` = pr.`Party ID`
join
	election_result_2024.statewise_results sr
on
	cr.`Parliament Constituency` = sr.`Parliament Constituency`
join
	election_result_2024.states s
on 
	sr.`State ID` = s.`State ID`
group by
	s.State
order by
	s.State;