create table constituencywise_results(
sno int,
parliament_constituency varchar(50),
constituency_name varchar(30),
winning_candidate varchar(30),
total_votes int,
margin int,
constituency_id varchar(10),
party_id int,
);

select * from states;
select * from partywise_results;
select * from statewise_results;
select * from constituencywise_details;
select * from constituencywise_results;

-- QUESTION 1 = TOTAL SEATS
select count(sno) as total_seats from constituencywise_results;
select distinct count(parliament_constituency) as total_seats from constituencywise_results;

-- QUESTION 2 = What are the total number of seats available for elections in each state?
select s.states as state_name
,count(cr.parliament_constituency) as total_seats from 
constituencywise_results cr 
INNER JOIN statewise_results sr ON cr.parliament_constituency = sr.parliament_constituency
INNER JOIN states s ON s.state_id = sr.state_id
group by s.states order by state_name;

-- Question 3 = Total Seats won by NDA ALLIANCE
SELECT 
    SUM(
        CASE 
            WHEN party IN (
                'Bharatiya Janata Party - BJP',
                'Telugu Desam - TDP',
                'Janata Dal (United) - JD(U)',
                'Shiv Sena - SHS',
                'AJSU Party - AJSUP',
                'Apna Dal (Soneylal) - ADAL',
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS',
                'Janasena Party - JnP',
                'Janata Dal (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV',
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD',
                'Sikkim Krantikari Morcha - SKM'
            )
            THEN won
            ELSE 0
        END
    ) AS nda_total_seats_won
FROM partywise_results;

-- QUESTION 4 = Seats won by NDA ALLIANCE PARTIES
select party AS party_name , won as seats_won FROM partywise_results 
WHERE party IN ('Bharatiya Janata Party - BJP',
                'Telugu Desam - TDP',
                'Janata Dal (United) - JD(U)',
                'Shiv Sena - SHS',
                'AJSU Party - AJSUP',
                'Apna Dal (Soneylal) - ADAL',
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS',
                'Janasena Party - JnP',
                'Janata Dal (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV',
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD',
                'Sikkim Krantikari Morcha - SKM')
order by seats_won desc;

-- QUESTION 5 = Total Seats won by INDIA ALLIANCE
SELECT 
    SUM(CASE 
            WHEN party IN (
                'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
            ) THEN won
            ELSE 0 
        END) AS INDIA_Total_Seats_Won
FROM 
    partywise_results;

-- QUESTION 6 = Seats won by INDIA ALLIANCE PARTIES
SELECT party as Party_Name, won as Seats_Won FROM partywise_results
WHERE party IN (
        'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
    )
ORDER BY Seats_Won DESC;

-- Question 7 = Add new column field in table partywise_results to get
-- the Party Allianz as NDA, I.N.D.I.A and OTHER ?
ALTER TABLE partywise_results add column party_alliance varchar(50);
select * from partywise_results;

UPDATE partywise_results
SET party_alliance = 'I.N.D.I.A'
WHERE party IN (
    'Indian National Congress - INC',
    'Aam Aadmi Party - AAAP',
    'All India Trinamool Congress - AITC',
    'Bharat Adivasi Party - BHRTADVSIP',
    'Communist Party of India  (Marxist) - CPI(M)',
    'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
    'Communist Party of India - CPI',
    'Dravida Munnetra Kazhagam - DMK',	
    'Indian Union Muslim League - IUML',
    'Jammu & Kashmir National Conference - JKN',
    'Jharkhand Mukti Morcha - JMM',
    'Kerala Congress - KEC',
    'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
    'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
    'Rashtriya Janata Dal - RJD',
    'Rashtriya Loktantrik Party - RLTP',
    'Revolutionary Socialist Party - RSP',
    'Samajwadi Party - SP',
    'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
    'Viduthalai Chiruthaigal Katchi - VCK'
);

UPDATE partywise_results
SET party_alliance = 'NDA'
WHERE party IN (
    'Bharatiya Janata Party - BJP',
    'Telugu Desam - TDP',
    'Janata Dal  (United) - JD(U)',
    'Shiv Sena - SHS',
    'AJSU Party - AJSUP',
    'Apna Dal (Soneylal) - ADAL',
    'Asom Gana Parishad - AGP',
    'Hindustani Awam Morcha (Secular) - HAMS',
    'Janasena Party - JnP',
    'Janata Dal  (Secular) - JD(S)',
    'Lok Janshakti Party(Ram Vilas) - LJPRV',
    'Nationalist Congress Party - NCP',
    'Rashtriya Lok Dal - RLD',
    'Sikkim Krantikari Morcha - SKM'
);

UPDATE partywise_results
SET party_alliance = 'OTHER'
WHERE party_alliance IS NULL;

-- calculations can be performed
SELECT party_alliance,sum(won) as total_seats_won from partywise_results 
group by party_alliance order by total_seats_won desc;

select party,won from partywise_results where 
party_alliance='I.N.D.I.A' order by won desc;

-- QUESTION 8 = Winning candidate's name, their party name, total votes, 
-- and the margin of victory for a specific state and constituency?
select cr.winning_candidate, pr.party_alliance,
pr.party, cr.total_votes, cr.margin, cr.constituency_name,s.states
from constituencywise_results cr
inner join partywise_results pr on cr.party_id = pr.party_id
inner join statewise_results sr on sr.parliament_constituency = cr.parliament_constituency
inner join states s on s.state_id = sr.state_id
where cr.constituency_name = 'BARAMATI';

-- QUESTION 9 = What is the distribution of EVM votes versus postal votes for
-- candidates in a specific constituency?
SELECT cd.candidate,
cd.party,cr.constituency_name,cd.evm_votes,
cd.postal_votes, cd.total_votes FROM constituencywise_details cd
inner join constituencywise_results cr on cr.constituency_id = cd.constituency_id
where constituency_name ='AGRA';

select * from constituencywise_results;
select * from constituencywise_details;

-- QUESTION 10 = Which parties won the most seats in State, and 
-- how many seats did each party win?
SELECT 
    p.Party,
    COUNT(cr.Constituency_ID) AS Seats_Won
FROM constituencywise_results cr
JOIN 
    partywise_results p ON cr.Party_ID = p.Party_ID
JOIN 
    statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN states s ON sr.State_ID = s.State_ID
WHERE 
    s.states = 'Andhra Pradesh'
GROUP BY 
    p.Party
ORDER BY 
    Seats_Won DESC;

-- QUESTION 11 = What is the total number of seats won by each party alliance 
-- (NDA, I.N.D.I.A, and OTHER) in each state for the India Elections 2024?
SELECT 
   s.states,
   sum(case when pr.party_alliance = 'NDA' then 1 else 0 end) as nda_seats_won,
   sum(case when pr.party_alliance = 'I.N.D.I.A' then 1 else 0 end) as india_seats_won,
   sum(case when pr.party_alliance = 'Other' then 1 else 0 end) as other_seats_won
   from partywise_results pr
inner join
    constituencywise_results cr on cr.party_id = pr.party_id
inner join 
    statewise_results sr on cr.parliament_constituency = sr.parliament_constituency
inner join 
    states s on s.state_id = sr.state_id
	
	group by s.states;

-- Question 12 = Which candidate received the highest number 
-- of EVM votes in each constituency (Top 10)?
select cr.constituency_name , cd.constituency_id,
cd.candidate , cd.evm_votes from constituencywise_details cd
inner join constituencywise_results cr
on cr.constituency_id = cd.constituency_id
where 
    cd.evm_votes= (select max(cd1.evm_votes) from constituencywise_details cd1
	where cd1.constituency_id = cd.constituency_id)
	order by cd.evm_votes desc limit 10;


-- important advanced query 
-- Question 13 = Which candidate won and which candidate was the 
-- runner-up in each constituency of State for the 2024 elections?

-- CTE IS USED
WITH RankedCandidates AS (
    SELECT 
        cd.Constituency_ID,
        cd.Candidate,
        cd.Party,
        cd.EVM_Votes,
        cd.Postal_Votes,
        cd.EVM_Votes + cd.Postal_Votes AS Total_Votes,
        ROW_NUMBER() OVER (PARTITION BY cd.Constituency_ID ORDER BY cd.EVM_Votes + cd.Postal_Votes DESC) AS VoteRank
    FROM 
        constituencywise_details cd
    JOIN 
        constituencywise_results cr ON cd.Constituency_ID = cr.Constituency_ID
    JOIN 
        statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
    JOIN 
        states s ON sr.State_ID = s.State_ID
    WHERE 
        s.States = 'Maharashtra'
)

SELECT 
    cr.Constituency_Name,
    MAX(CASE WHEN rc.VoteRank = 1 THEN rc.Candidate END) AS Winning_Candidate,
    MAX(CASE WHEN rc.VoteRank = 2 THEN rc.Candidate END) AS Runnerup_Candidate
FROM 
    RankedCandidates rc
JOIN 
    constituencywise_results cr ON rc.Constituency_ID = cr.Constituency_ID
GROUP BY 
    cr.Constituency_Name
ORDER BY 
    cr.Constituency_Name;




-- QUESTION 14 = For the state of Maharashtra, what are the total number of seats, 
-- total number of candidates, total number of parties, total votes 
-- (including EVM and postal), and the breakdown of EVM and postal votes?

select COUNT(DISTINCT cr.Constituency_ID) AS Total_Seats,
    COUNT(DISTINCT cd.Candidate) AS Total_Candidates,
    COUNT(DISTINCT pr.Party) AS Total_Parties,
    SUM(cd.EVM_Votes + cd.Postal_Votes) AS Total_Votes,
    SUM(cd.EVM_Votes) AS Total_EVM_Votes,
    SUM(cd.Postal_Votes) AS Total_Postal_Votes

  from constituencywise_results cr
   inner join 
      statewise_results sr 
	       on sr.parliament_constituency = cr.parliament_constituency 
   inner join 
      constituencywise_details cd on cd.constituency_id = cr.constituency_id
   inner join 
      states s on s.state_id = sr.state_id 
   inner join 
      partywise_results pr on pr.party_id = cr.party_id
where s.states = 'Punjab';

















