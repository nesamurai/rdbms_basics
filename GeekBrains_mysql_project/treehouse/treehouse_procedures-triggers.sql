DELIMITER $$

-- 1. Триггер, когда курс добавляется в завершенные курсы, то очки за курс
-- прибавляются к общим очкам в профиле
CREATE TRIGGER add_points
AFTER INSERT ON completed_courses
FOR EACH ROW
BEGIN
    UPDATE users
    SET total_points = total_points + NEW.points_achieved
    WHERE id = NEW.user_id;
END$$

-- 2. Триггер на удаление курса из запланированных при изменении значения has_bookmark
CREATE TRIGGER delete_bookmark
AFTER UPDATE ON bookmarks
FOR EACH ROW
BEGIN
    DELETE FROM bookmarks
    WHERE has_bookmark != '1';
END$$
