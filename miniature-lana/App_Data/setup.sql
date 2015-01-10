CREATE TABLE champs (
	champID INT PRIMARY KEY,
	name VARCHAR(20) NOT NULL,
	link VARCHAR(50) NOT NULL,
	description VARCHAR (50) NOT NULL
);

CREATE TABLE items (
	itemID INT PRIMARY KEY,
	name VARCHAR(20) NOT NULL,
	link VARCHAR(50) NOT NULL,
	price INT NOT NULL,
	description VARCHAR (50) NOT NULL
);

CREATE TABLE summonerSpells (
	summonerSpellID INT PRIMARY KEY,
	name VARCHAR(20) NOT NULL,
	link VARCHAR(50) NOT NULL,
	description VARCHAR (50) NOT NULL
);

CREATE TABLE teams (
	teamID INT PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	link VARCHAR(50),
	elo INT NOT NULL,
	region VARCHAR(50) NOT NULL
);

CREATE TABLE players (
	playerID INT PRIMARY KEY,
	name VARCHAR(50),
	handle VARCHAR(50) NOT NULL,
	link VARCHAR(50),
	elo INT NOT NULL,
	teamID INT FOREIGN KEY REFERENCES teams(teamID),
	region VARCHAR(50) NOT NULL
);

CREATE TABLE games (
	gameID INT PRIMARY KEY,
	date DATETIME NOT NULL,
	winner INT FOREIGN KEY REFERENCES teams(teamID),
	length TIME NOT NULL
);

CREATE TABLE tournaments (
	tournamentID INT PRIMARY KEY,
	date DATETIME NOT NULL,
	link VARCHAR(50)
);

--------------------------------------------------------------

CREATE TABLE teamELOs (
	tEloID INT PRIMARY KEY,
	teamID INT FOREIGN KEY REFERENCES teams(teamID),
	elo INT NOT NULL,
	date DATETIME NOT NULL
);

CREATE TABLE playerELOs (
	pEloID INT PRIMARY KEY,
	playerID INT FOREIGN KEY REFERENCES players(playerID),
	elo INT NOT NULL,
	date DATETIME NOT NULL
);

Create Table teamHistory (
	teamHistoryID INT PRIMARY KEY,
	playerID INT FOREIGN KEY REFERENCES players(playerID),
	teamID INT FOREIGN KEY REFERENCES teams(teamID),
	joinDate DATETIME NOT NULL
)

CREATE TABLE playerGames (
	playerGameID INT PRIMARY KEY,
	playerID INT FOREIGN KEY REFERENCES players(playerID),
	gameID INT FOREIGN KEY REFERENCES games(gameID),
	champ INT FOREIGN KEY REFERENCES champs(champID),
	position VARCHAR(10) NOT NULL,
	kills INT NOT NULL,
	deaths INT NOT NULL,
	assists INT NOT NULL,
	cs INT,
	gold INT,
	triple INT,
	quadra INT,
	penta INT,
	fantasyPts DECIMAL
)

CREATE TABLE teamGames (
	teamGameID INT PRIMARY KEY,
	teamID INT FOREIGN KEY REFERENCES teams(teamID),
	gameID INT FOREIGN KEY REFERENCES games(gameID),
	-- 1=win 0=loss
	result BIT NOT NULL, 
	-- 1 = blue, bottom, 1st ban, 1st pick
	-- 0 = red, top, 2nd ban, 2nd pick
	color BIT,
	kills INT NOT NULL,
	deaths INT NOT NULL,
	assists INT NOT NULL,
	firstBlood INT FOREIGN KEY REFERENCES teams(teamID),
	dragon INT,
	baron INT,
	tower INT,
	fantasyPts DECIMAL
);

CREATE TABLE teamGameBans (
	teamGameBanID INT PRIMARY KEY,
	teamGameID INT FOREIGN KEY REFERENCES teamGames(teamGameID),
	ban INT FOREIGN KEY REFERENCES champs(champID)
);

CREATE TABLE playerGameSummoners (
	playerGameSummonerID INT PRIMARY KEY,
	playerGameID INT FOREIGN KEY REFERENCES playerGames(playerGameID),
	summonerSpellID INT FOREIGN KEY REFERENCES summonerSpells(summonerSpellID)
)

CREATE TABLE playerGameItems (
	playerGameItemID INT PRIMARY KEY,
	playerGameID INT FOREIGN KEY REFERENCES playerGames(playerGameID),
	itemID INT FOREIGN KEY REFERENCES items(itemID)
)

CREATE TABLE gameTournaments (
	gameTournamentID INT PRIMARY KEY,
	gameID INT FOREIGN KEY REFERENCES games(gameID),
	touramentID INT FOREIGN KEY REFERENCES tournaments(tournamentID)
);