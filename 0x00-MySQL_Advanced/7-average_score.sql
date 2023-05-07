-- SQL script that creates a stored procedure ComputeAverageScoreForUser
-- computes and store the average score for a student. An average score can be a decimal
DELIMITER //

CREATE PROCEDURE ComputeAverageScoreForUser(IN user_id INT)
BEGIN
	DECLARE total_score FLOAT DEFAULT 0;
    	DECLARE num_scores INT DEFAULT 0;
	DECLARE avg_score FLOAT DEFAULT 0;

	SELECT SUM(score), COUNT(*)
	INTO total_score, num_scores
	FROM corrections
	WHERE user_id = user_id;

	IF num_scores > 0 THEN
		SET avg_score = total_score / num_scores;
	END IF;

	UPDATE users
	SET average_score = avg_score
	WHERE id = user_id;

END //

DELIMITER ;
