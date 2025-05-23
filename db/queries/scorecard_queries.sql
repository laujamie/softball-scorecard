-- name: ListUmpireScorecards :many
SELECT 
    us.id,
    us.home_team,
    us.away_team,
    us.created_on,
    us.max_runs_per_inning,
    usi.inning_number,
    usi.is_home,
    usi.runs_scored,
    usi.outs_recorded
FROM umpire_scorecards us
JOIN umpire_scorecard_innings usi
ON us.id = usi.scorecard_id
ORDER BY created_on;

-- name: CreateUmpireScorecard :one
INSERT INTO umpire_scorecards (
    home_team,
    away_team,
    max_runs_per_inning
) VALUES (
    ?,
    ?,
    ?    
) RETURNING *;

-- name: CreateUmpireScorecardInning :one
INSERT INTO umpire_scorecard_innings (
    scorecard_id,
    inning_number,
    is_home,
    runs_scored,
    outs_recorded
) VALUES (
    ?,
    ?,
    ?,
    ?,
    ?
) RETURNING *;
