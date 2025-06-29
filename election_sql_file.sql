CREATE DATABASE India_Election_Result;
USE India_Election_Result;

--See the imported tables
SELECT * FROM constituencywise_details;
SELECT * FROM constituencywise_results;
SELECT * FROM partywise_results;
SELECT * FROM states;
SELECT * FROM statewise_results;

--Total_seats:
SELECT DISTINCT COUNT(Parliament_Constituency) AS Total_Seats FROM constituencywise_results;

--What is the total number of seats available for elections in each state
SELECT * FROM constituencywise_results;
SELECT * FROM statewise_results;
SELECT * FROM states;

SELECT
s.State,
count(cr.Parliament_Constituency) as No_of_Seats
FROM
constituencywise_results as cr
JOIN
statewise_results as sr
ON
cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN
states as s
ON
sr.State_ID = s.State_ID
GROUP BY s.State
ORDER BY s.State;


--Total Seats Won by NDA Allianz

SELECT * FROM partywise_results;

SELECT 
    SUM(CASE 
            WHEN party IN (
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
            ) THEN Won
            ELSE 0 
        END) AS NDA_Total_Seats_Won
FROM 
    partywise_results


--Seats Won by NDA Allianz Parties

SELECT
Party,
Won AS Seats_Won
FROM partywise_results
WHERE Party IN (
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
)
ORDER BY Seats_Won DESC;


--Total Seats Won by I.N.D.I.A. Allianz

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
            ) THEN Won
            ELSE 0 
        END) AS INDIA_Total_Seats_Won
FROM 
    partywise_results


--Seats Won by I.N.D.I.A. Allianz Parties

SELECT 
    Party ,
    Won as Seats_Won
FROM 
    partywise_results
WHERE 
    party IN (
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

--Add new column field in table partywise_results to get the Party Allianz as NDA, I.N.D.I.A and OTHER

ALTER TABLE partywise_results
ADD Party_Alliance VARCHAR(50);

--I.N.D.I.A Allianz
UPDATE partywise_results
SET Party_Alliance = 'I.N.D.I.A'
WHERE Party IN (
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

select * from partywise_results;

--NDA Allianz

UPDATE partywise_results
SET Party_Alliance = 'NDA'
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

select * from partywise_results;

--OTHER

UPDATE partywise_results
SET Party_Alliance = 'OTHER'
WHERE Party_Alliance IS NULL;

select * from partywise_results;
SELECT * FROM constituencywise_results;


--Which party alliance (NDA, I.N.D.I.A, or OTHER) won the most seats across all states?

SELECT 
pr.Party_Alliance,
COUNT(cr.Constituency_ID) as Seats_Won
FROM constituencywise_results cr
JOIN
partywise_results pr
ON
cr.Party_ID = pr.Party_ID
GROUP BY Party_Alliance
ORDER BY Seats_Won DESC;

--Winning candidate's name, 
--their party name, total votes, and the margin of victory for a specific state and constituency?

SELECT * FROM constituencywise_results;
SELECT * FROM partywise_results;
SELECT * FROM states;
SELECT * FROM statewise_results;

SELECT
cr.Winning_Candidate,
pr.Party,
cr.Total_Votes,
cr.Margin,
s.State,
cr.Constituency_Name
FROM constituencywise_results cr
JOIN
partywise_results pr
ON cr.Party_ID = pr.Party_ID
JOIN
statewise_results sr
ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN
states s
ON sr.State_ID = s.State_ID
WHERE s.State = 'Odisha' AND cr.Constituency_Name = 'KEONJHAR';

--What is the distribution of EVM votes versus postal votes for candidates in a specific constituency?
SELECT * FROM constituencywise_details;
SELECT * FROM constituencywise_results;

SELECT
cr.Constituency_Name,
cd.Candidate,
cd.Party,
cd.EVM_Votes,
cd.Postal_Votes,
cd.Total_Votes
FROM constituencywise_details cd
JOIN
constituencywise_results cr
ON 
cd.Constituency_ID = cr.Constituency_ID
WHERE cr.Constituency_Name = 'KEONJHAR'
ORDER BY cd.Total_Votes DESC;


--Which parties won the most seats in s State, and how many seats did each party win?

SELECT 
    pr.Party,
    COUNT(cr.Constituency_ID) AS Seats_Won
FROM 
    constituencywise_results cr
JOIN 
    partywise_results pr 
ON 
cr.Party_ID = pr.Party_ID
JOIN 
statewise_results sr 
ON 
cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN states s 
ON 
sr.State_ID = s.State_ID
WHERE 
    s.state = 'Odisha'
GROUP BY 
    pr.Party
ORDER BY 
    Seats_Won DESC;

SELECT * FROM constituencywise_details;
SELECT * FROM constituencywise_results;
SELECT * FROM partywise_results;
SELECT * FROM states;
SELECT * FROM statewise_results;

--What is the total number of seats won by each party alliance (NDA, I.N.D.I.A, and OTHER) 
--in each state for the India Elections 2024

SELECT
s.State,
SUM(CASE WHEN pr.Party_Alliance = 'NDA' THEN 1 ELSE 0 END) AS NDA_Seats_Won,
SUM(CASE WHEN pr.Party_Alliance = 'I.N.D.I.A' THEN 1 ELSE 0 END) AS INDIA_Seats_Won,
SUM(CASE WHEN pr.Party_Alliance = 'OTHER' THEN 1 ELSE 0 END) AS OTHER_Seats_Won
FROM constituencywise_results cr
JOIN partywise_results pr
ON cr.Party_ID = pr.Party_ID
JOIN statewise_results sr
ON cr.Parliament_Constituency=sr.Parliament_Constituency
JOIN states s 
ON sr.State_ID = s.State_ID
GROUP BY s.State
ORDER BY s.State;


--Which candidate received the highest number of EVM votes in each constituency (Top 10)?


SELECT TOP 10
cr.Constituency_Name,
cd.Constituency_ID,
cd.Candidate,
cd.Party,
cd.EVM_Votes
FROM
constituencywise_details cd
JOIN
constituencywise_results cr
ON cd.Constituency_ID = cr.Constituency_ID
ORDER BY cd.EVM_Votes DESC;


--For the state of Odisha, what are the total number of seats, total number of candidates, total number of parties, 
--total votes (including EVM and postal), and the breakdown of EVM and postal votes?

SELECT 
    COUNT(DISTINCT cr.Constituency_ID) AS Total_Seats,
    COUNT(DISTINCT cd.Candidate) AS Total_Candidates,
    COUNT(DISTINCT p.Party) AS Total_Parties,
    SUM(cd.EVM_Votes + cd.Postal_Votes) AS Total_Votes,
    SUM(cd.EVM_Votes) AS Total_EVM_Votes,
    SUM(cd.Postal_Votes) AS Total_Postal_Votes
FROM 
constituencywise_results cr
JOIN 
constituencywise_details cd 
ON cr.Constituency_ID = cd.Constituency_ID
JOIN 
statewise_results sr 
ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN 
states s 
ON sr.State_ID = s.State_ID
JOIN 
partywise_results p 
ON cr.Party_ID = p.Party_ID
WHERE 
s.State = 'Odisha';
