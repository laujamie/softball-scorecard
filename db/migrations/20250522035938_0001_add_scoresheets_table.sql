-- migrate:up
CREATE TABLE umpire_scorecards (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    home_team string NOT NULL,
    away_team string NOT NULL,
    max_runs_per_inning INTEGER,
    created_on INTEGER NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE umpire_scorecard_innings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    scorecard_id INTEGER NOT NULL,
    inning_number INTEGER NOT NULL,
    is_home INTEGER NOT NULL,
    runs_scored INTEGER NOT NULL DEFAULT 0,
    outs_recorded INTEGER NOT NULL DEFAULT 0,
    created_on INTEGER NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (scorecard_id) REFERENCES umpire_scorecards(id),

    UNIQUE (scorecard_id, inning_number, is_home)
);

CREATE INDEX umpire_scorecards_created_on ON umpire_scorecards(created_on);
CREATE INDEX umpire_scorecard_innnings_created_on ON umpire_scorecard_innings(created_on);
CREATE INDEX umpire_scorecard_innings_scorecard_id ON umpire_scorecard_innings(scorecard_id);

-- migrate:down
DROP TABLE umpire_scorecard_innings;
DROP TABLE umpire_scorecards;
