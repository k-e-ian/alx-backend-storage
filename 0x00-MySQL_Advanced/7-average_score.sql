-- SQL script that creates a stored procedure ComputeAverageScoreForUser
-- computes and store the average score for a student. An average score can be a decimal
DELIMITER //

CREATE PROCEDURE ComputeAverageScoreForUser(IN user_id INT)
BEGIN
	DECLARE total_score FLOAT DEFAULT 0;
    	DECLARE num_projects INT DEFAULT 0;
	SELECT SUM(score), COUNT(*) INTO total_score, num_projects FROM corrections WHERE user_id = user_id;
	IF num_projects > 0 THEN
		UPDATE users SET average_score = total_score / num_projects WHERE id = user_id;
	END IF;
END //

DELIMITER ;
