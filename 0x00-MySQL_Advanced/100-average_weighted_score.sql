-- SQL script that creates a stored procedure ComputeAverageWeightedScoreForUser
-- that computes and store the average weighted score for a student

DELIMITER //

CREATE PROCEDURE ComputeAverageWeightedScoreForUser(IN user_id INT)
BEGIN
	DECLARE total_score FLOAT;
    	DECLARE total_weight INT;
	DECLARE weighted_score FLOAT;
	DECLARE num_projects INT;

	SELECT SUM(score * weight) INTO total_score, SUM(weight) INTO total_weight, COUNT(*) INTO num_projects 
	FROM corrections c 
	JOIN projects p ON c.project_id = p.id 
	WHERE c.user_id = user_id;

	IF num_projects > 0 THEN
		SET weighted_score = total_score / total_weight;
		UPDATE users SET average_score = weighted_score WHERE id = user_id;
	END IF;
END //

DELIMITER ;
