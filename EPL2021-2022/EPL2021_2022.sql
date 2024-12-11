-- 1. TOP 10 TOP SCORER EPL2021-2022
SELECT 
	Name,
    Club,
    Goals
FROM epl2021
ORDER BY Goals DESC LIMIT 10;
-- As we can see that Harry Kane is the top scorer in the leage with 23 goals this season

-- 2. HIGHEST PLAYTIME PLAYER
SELECT 
	Name,
    Position,
    Mins
FROM epl2021
ORDER BY Mins DESC LIMIT 10;
-- As we can see that the highest playtime player are kasper,hojbjerg,lloris,martinez, ward-prowse etc, this lists are dominated with player with defensive position

-- 3. MOST ASSIST
SELECT 
	Name,
    Club,
    Assists
FROM epl2021
ORDER BY Assists DESC LIMIT 10;
-- Again, Harry Kane also the top assist this season with 14 assists, so we can know that Harry Kane is the top scorer and top assist this season, and he is a player from tottenham

-- 4. ARSENAL TOP SCORER
SELECT
	Name,
    Goals
FROM epl2021
WHERE Club = 'Arsenal'
ORDER BY Goals DESC LIMIT 5;
-- Arsenal Top Scorer is Alexandre Lacazette with 13 Goals

-- 5. RED/YELLOW CARD FOR TOP SCORER AND TOP ASSISTS
SELECT
	Name,
    Goals,
    Assists,
    Red_Cards,
    Yellow_Cards
FROM epl2021
ORDER BY Goals DESC LIMIT 1;
-- Harry Kane only got 1 Yellow Card througout this season, impressive

-- 6. TOP 5 CLUB WITH MOST GOALS
SELECT
	Club,
    SUM(Goals) AS Goals_Count
FROM epl2021
GROUP BY Club
ORDER BY Goals_Count DESC LIMIT 5;
-- Manchester City is the most productive club in scoring goals, securing 82 goals this season.

-- 7. Top scorer players with no cards
SELECT
	Name,
    Club,
	Goals
FROM epl2021
WHERE Yellow_Cards = 0 AND Red_Cards = 0
ORDER BY Goals DESC LIMIT 10;
-- Mohamad Salah is the top scorer with 0 yellow and red card

-- 8. The Player with the most red cards
SELECT 
    Name,
    Club,
    Red_Cards
FROM epl2021
ORDER BY Red_Cards DESC
LIMIT 1;
-- Lewis dunk is the only player that received 2 yellow cards this season

-- 9. The club with the most cards
SELECT
    Club,
    SUM(Yellow_Cards) AS Total_YellowCards,
    SUM(Red_Cards) AS Total_RedCards,
    SUM(Yellow_Cards + Red_Cards) AS Total_Cards
FROM epl2021
GROUP BY Club 
ORDER BY Total_Cards DESC;
-- Sheffield United is the club that has received the most cards this season.

-- Player with most key-passes and total completed passes
SELECT 
	Name,
    Position,
    Passes_Attempted,
    Perc_Passes_Completed,
    ROUND(SUM(Passes_Attempted * Perc_Passes_Completed) / 100,0) AS TotalCompletedPasses
FROM EPL2021
GROUP BY Name
ORDER BY Passes_Attempted DESC LIMIT 10
-- As we can see, the player with the most pass attempts is Andrew Robertson. Additionally, we can observe that the list of players with the most pass attempts is dominated by players in defensive positions.


