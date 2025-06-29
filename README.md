# India General Elections 2024 Result Analysis - Comprehensive Report
This repository contains a comprehensive SQL analysis of India's 2024 General Election results. The dataset includes constituency-level details, party-wise performance, and alliance-based analysis for all 543 parliamentary constituencies.

## Database Schema Overview
**Database Name:** India_Election_Result

## Tables Structure
![](https://github.com/Issita/India_Election_Result_Analysis/blob/main/table_diagram.png)

## Table Descriptions
**1.states:** Contains state names and IDs

**2.statewise_results:** Maps parliamentary constituencies to states

**3.constituencywise_results:** Winning candidate and party information for each constituency

**4.constituencywise_details:** Detailed vote breakdown for all candidates in each constituency

**5.partywise_results:** Summary of seats won by each party and their alliance classification

## Key Analysis Areas

### 1. Election Overview

```sql
-- Total seats in Parliament
SELECT DISTINCT COUNT(Parliament_Constituency) AS Total_Seats 
FROM constituencywise_results;

-- Seats distribution by state
SELECT s.State, COUNT(cr.Parliament_Constituency) AS No_of_Seats
FROM constituencywise_results cr
JOIN statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN states s ON sr.State_ID = s.State_ID
GROUP BY s.State
ORDER BY No_of_Seats DESC;
```

### 2. Alliance Performance Analysis
**National Democratic Alliance (NDA)**

```sql
-- Total NDA seats
SELECT SUM(CASE WHEN party IN (
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
) THEN Won ELSE 0 END) AS NDA_Total_Seats_Won
FROM partywise_results;

-- NDA party-wise seat distribution
SELECT Party, Won AS Seats_Won
FROM partywise_results
WHERE Party IN (/* NDA parties */)
ORDER BY Seats_Won DESC;
```
**Indian National Developmental Inclusive Alliance (I.N.D.I.A)**

```sql
-- Total I.N.D.I.A seats
SELECT SUM(CASE WHEN party IN (
    'Indian National Congress - INC',
    'Aam Aadmi Party - AAAP',
    'All India Trinamool Congress - AITC',
    'Bharat Adivasi Party - BHRTADVSIP',
    'Communist Party of India (Marxist) - CPI(M)',
    'Communist Party of India (Marxist-Leninist) (Liberation) - CPI(ML)(L)',
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
) THEN Won ELSE 0 END) AS INDIA_Total_Seats_Won
FROM partywise_results;

-- I.N.D.I.A party-wise seat distribution
SELECT Party, Won AS Seats_Won
FROM partywise_results
WHERE Party IN (/* I.N.D.I.A parties */)
ORDER BY Seats_Won DESC;
```

**3. Alliance Classification System**

```sql
-- Add alliance classification column
ALTER TABLE partywise_results
ADD Party_Alliance VARCHAR(50);

-- Classify parties into alliances
UPDATE partywise_results
SET Party_Alliance = 'I.N.D.I.A'
WHERE Party IN (/* I.N.D.I.A parties */);

UPDATE partywise_results
SET Party_Alliance = 'NDA'
WHERE Party IN (/* NDA parties */);

UPDATE partywise_results
SET Party_Alliance = 'OTHER'
WHERE Party_Alliance IS NULL;

-- Overall alliance comparison
SELECT pr.Party_Alliance, COUNT(cr.Constituency_ID) AS Seats_Won
FROM constituencywise_results cr
JOIN partywise_results pr ON cr.Party_ID = pr.Party_ID
GROUP BY Party_Alliance
ORDER BY Seats_Won DESC;
```
**4. Constituency-Level Analysis**

```sql
-- Keonjhar constituency (Odisha) detailed results
SELECT 
    cr.Winning_Candidate, 
    pr.Party, 
    cr.Total_Votes, 
    cr.Margin,
    s.State,
    cr.Constituency_Name
FROM constituencywise_results cr
JOIN partywise_results pr ON cr.Party_ID = pr.Party_ID
JOIN statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN states s ON sr.State_ID = s.State_ID
WHERE s.State = 'Odisha' AND cr.Constituency_Name = 'KEONJHAR';

-- Vote distribution in Keonjhar
SELECT 
    cd.Candidate, 
    cd.Party, 
    cd.EVM_Votes, 
    cd.Postal_Votes, 
    cd.Total_Votes
FROM constituencywise_details cd
JOIN constituencywise_results cr ON cd.Constituency_ID = cr.Constituency_ID
WHERE cr.Constituency_Name = 'KEONJHAR'
ORDER BY cd.Total_Votes DESC;
```

**5. State-Wise Analysis**
```sql
-- Odisha party performance
SELECT 
    pr.Party, 
    COUNT(cr.Constituency_ID) AS Seats_Won
FROM constituencywise_results cr
JOIN partywise_results pr ON cr.Party_ID = pr.Party_ID
JOIN statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN states s ON sr.State_ID = s.State_ID
WHERE s.state = 'Odisha'
GROUP BY pr.Party
ORDER BY Seats_Won DESC;

-- Alliance performance by state
SELECT 
    s.State,
    SUM(CASE WHEN pr.Party_Alliance = 'NDA' THEN 1 ELSE 0 END) AS NDA_Seats_Won,
    SUM(CASE WHEN pr.Party_Alliance = 'I.N.D.I.A' THEN 1 ELSE 0 END) AS INDIA_Seats_Won,
    SUM(CASE WHEN pr.Party_Alliance = 'OTHER' THEN 1 ELSE 0 END) AS OTHER_Seats_Won
FROM constituencywise_results cr
JOIN partywise_results pr ON cr.Party_ID = pr.Party_ID
JOIN statewise_results sr ON cr.Parliament_Constituency=sr.Parliament_Constituency
JOIN states s ON sr.State_ID = s.State_ID
GROUP BY s.State
ORDER BY s.State;
```

**6. Top Performers Analysis**

```sql
-- Top 10 candidates by EVM votes
SELECT TOP 10
    cr.Constituency_Name,
    cd.Candidate,
    cd.Party,
    cd.EVM_Votes
FROM constituencywise_details cd
JOIN constituencywise_results cr ON cd.Constituency_ID = cr.Constituency_ID
ORDER BY cd.EVM_Votes DESC;

-- Odisha election summary
SELECT
    COUNT(DISTINCT cr.Constituency_ID) AS Total_Seats,
    COUNT(DISTINCT cd.Candidate) AS Total_Candidates,
    COUNT(DISTINCT p.Party) AS Total_Parties,
    SUM(cd.EVM_Votes + cd.Postal_Votes) AS Total_Votes,
    SUM(cd.EVM_Votes) AS Total_EVM_Votes,
    SUM(cd.Postal_Votes) AS Total_Postal_Votes
FROM constituencywise_results cr
JOIN constituencywise_details cd ON cr.Constituency_ID = cd.Constituency_ID
JOIN statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN states s ON sr.State_ID = s.State_ID
JOIN partywise_results p ON cr.Party_ID = p.Party_ID
WHERE s.State = 'Odisha';
```

## Key Findings
#### Overall Results
![](https://github.com/Issita/India_Election_Result_Analysis/blob/main/overall%20result.png)

## State-Wise Highlights
- **Uttar Pradesh:** NDA won 36 seats, I.N.D.I.A won 42 seats
- **Maharashtra:** NDA won 17 seats, I.N.D.I.A won 30 seats
- **West Bengal:** I.N.D.I.A dominated with 29 out of 42 seats
- **Odisha:** BJD (Other alliance) won 9 seats, BJP won 21 seats

