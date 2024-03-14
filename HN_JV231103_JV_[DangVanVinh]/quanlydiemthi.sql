create database QUANLYDIEMTHI;
use quanlydiemthi;

# tạo bảng
    create table STUDENT (
        studentId varchar(4) primary key ,
        studentName varchar(100),
        birthday DATE,
        gender BIT(1),
        address text,
        phoneNumber varchar(45)
    );
    
     create table SUBJECT (
        SUBJECTId varchar(4) primary key ,
        SUBJECTName varchar(100),
        priority INT(11)
    );
    
CREATE TABLE MARK (
    subjectId VARCHAR(4),
    studentId VARCHAR(4),
    point INT(11), -- Thêm cột point với kiểu dữ liệu INT
    PRIMARY KEY (subjectId, studentId),
    FOREIGN KEY (subjectId) REFERENCES SUBJECT(subjectId),
    FOREIGN KEY (studentId) REFERENCES STUDENT(studentId)
);


# insert 

INSERT INTO STUDENT (studentId, studentName, birthday, gender, address, phoneNumber)
VALUES
('s001', 'Nguyễn Thế Anh', '1999-01-11', 1, 'Hà Nội', '0987654321'),
('s002', 'Đặng Bảo Trâm', '1998-12-22', 0, 'Lào Cai', '0123456789'),
('s003', 'Trần Hà Phương', '2000-05-05', 0, 'Nghệ An', '0369852147'),
('s004', 'Đỗ Tiến Mạnh', '1999-03-26', 1, 'Hà Nội', '0928374651'),
('s005', 'Phạm Duy Nhất', '1998-10-04', 1, 'Tuyên Quang', '0321587436'),
('s006', 'Mai Văn Thái', '2002-06-22', 1, 'Nam Định', '0547986312'),
('s007', 'Giang Gia Hân', '1996-11-10', 0, 'Phú Thọ', '0765432198'),
('s008', 'Nguyễn Ngọc Bảo My', '1999-01-22', 0, 'Hà Nam', '0987654321'),
('s009', 'Nguyễn Tiến Đạt', '1998-08-07', 1, 'Tuyên Quang', '0123456789'),
('s010', 'Nguyễn Thiều Quang', '2000-09-18', 1, 'Hà Nội', '0369852147');


INSERT INTO SUBJECT (subjectId, subjectName, priority)
VALUES
('MH01', 'Toán', 2),
('MH02', 'Vật Lý', 2),
('MH03', 'Hóa Học', 1),
('MH04', 'Ngữ Văn', 1),
('MH05', 'Tiếng Anh', 2);

INSERT INTO MARK (subjectId, studentId, point)
VALUES
('MH01', 's001', 8.5), ('MH02', 's001', 7), ('MH03', 's001', 9), ('MH04', 's001', 9), ('MH05', 's001', 5),
('MH01', 's002', 9), ('MH02', 's002', 8), ('MH03', 's002', 6.5), ('MH04', 's002', 8), ('MH05', 's002', 6),
('MH01', 's003', 7.5), ('MH02', 's003', 6.5), ('MH03', 's003', 8), ('MH04', 's003', 7), ('MH05', 's003', 7),
('MH01', 's004', 6), ('MH02', 's004', 7), ('MH03', 's004', 5), ('MH04', 's004', 6.5), ('MH05', 's004', 8),
('MH01', 's005', 5.5), ('MH02', 's005', 10), ('MH03', 's005', 7.5), ('MH04', 's005', 8.5), ('MH05', 's005', 9),
('MH01', 's006', 8), ('MH02', 's006', 9), ('MH03', 's006', 9), ('MH04', 's006', 7.5), ('MH05', 's006', 6.5),
('MH01', 's007', 9.5), ('MH02', 's007', 8.5), ('MH03', 's007', 6), ('MH04', 's007', 9), ('MH05', 's007', 4),
('MH01', 's008', 10), ('MH02', 's008', 7), ('MH03', 's008', 8.5), ('MH04', 's008', 6), ('MH05', 's008', 9.5),
('MH01', 's009', 7.5), ('MH02', 's009', 8), ('MH03', 's009', 9), ('MH04', 's009', 5), ('MH05', 's009', 10),
('MH01', 's010', 6.5), ('MH02', 's010', 8), ('MH03', 's010', 5.5), ('MH04', 's010', 4), ('MH05', 's010', 7);


# update

-- Sửa tên sinh viên có mã `S004` thành “Đỗ Đức Mạnh”.
UPDATE STUDENT
SET studentName = 'Đỗ Đức Mạnh'
WHERE studentId = 'S004';

-- Sửa tên và hệ số môn học có mã `MH05` thành “Ngoại Ngữ” và hệ số là 1.
UPDATE SUBJECT
SET subjectName = 'Ngoại Ngữ', priority = 1
WHERE subjectId = 'MH05';

-- Cập nhật lại điểm của học sinh có mã `S009` thành (MH01 : 8.5, MH02 : 7,MH03 : 5.5, MH04 : 6, MH05 : 9).
UPDATE MARK
SET point = 
    CASE 
        WHEN subjectId = 'MH01' THEN 8.5
        WHEN subjectId = 'MH02' THEN 7
        WHEN subjectId = 'MH03' THEN 5.5
        WHEN subjectId = 'MH04' THEN 6
        WHEN subjectId = 'MH05' THEN 9
    END
WHERE studentId = 'S009';

-- Xóa thông tin của học sinh có mã S010 từ bảng MARK
DELETE FROM MARK
WHERE studentId = 'S010';

-- Xóa thông tin của học sinh có mã S010 từ bảng STUDENT
DELETE FROM STUDENT
WHERE studentId = 'S010';



# truy vấn
-- Lấy ra tất cả thông tin của sinh viên trong bảng Studen
SELECT * FROM STUDENT;

-- Hiển thị tên và mã môn học của những môn có hệ số bằng 1
SELECT subjectId, subjectName
FROM SUBJECT
WHERE priority = 1;

-- Hiển thị thông tin học sinh bào gồm: mã học sinh, tên học sinh, tuổi (bằng năm hiện tại trừ năm sinh) , giới tính (hiển thị nam hoặc nữ) và quê quán của tất cả học sinh
SELECT 
    studentId,
    studentName,
    YEAR(CURRENT_DATE()) - YEAR(birthday) AS age,
    IF(gender = 1, 'Nam', 'Nữ') AS gender,
    address
FROM 
    STUDENT;  
    
-- 4.Hiển thị thông tin bao gồm: tên học sinh, tên môn học , điểm thi của tất cả học sinh của môn Toán và sắp xếp theo điểm giảm dần
SELECT 
    STUDENT.studentName AS studentName,
    SUBJECT.subjectName AS subjectName,
    MARK.point AS point
FROM 
    STUDENT
           JOIN MARK    ON STUDENT.studentId = MARK.studentId
		     JOIN SUBJECT ON MARK.subjectId = SUBJECT.subjectId
WHERE 
    SUBJECT.subjectName = 'Toán'
ORDER BY 
    MARK.point DESC;

-- 5. Thống kê số lượng học sinh theo giới tính ở trong bảng (Gồm 2 cột: giới tính và số lượng)
SELECT 
    CASE 
        WHEN gender = 1 THEN 'Nam'
        ELSE 'Nữ'
    END AS gender,
    COUNT(*) AS count
FROM 
    STUDENT
GROUP BY 
    gender;

-- Tính tổng điểm và điểm trung bình của các môn học theo từng học sinh (yêu cầu sử dụng hàm để tính toán) , 
-- bảng gồm mã học sinh, tên hoc sinh, tổng điểm và điểm trung bình.
SELECT 
    STUDENT.studentId AS studentId,
    STUDENT.studentName AS studentName,
    SUM(MARK.point) AS totalPoint,
    AVG(MARK.point) AS averagePoint
FROM 
    MARK
JOIN     STUDENT ON MARK.studentId = STUDENT.studentId
GROUP BY STUDENT.studentId, STUDENT.studentName;




# view,index,producer

-- Tạo VIEW có tên STUDENT_VIEW lấy thông tin sinh viên bao gồm : mã học sinh, tên học sinh, giới tính , quê quán
CREATE VIEW STUDENT_VIEW AS
SELECT 
    studentId,
    studentName,
    CASE 
        WHEN gender = 1 THEN 'Nam'
        ELSE 'Nữ'
    END AS gender,
    address
FROM 
    STUDENT;
-- Tạo VIEW có tên AVERAGE_MARK_VIEW lấy thông tin gồm:mã học sinh, tên học sinh, điểm trung bình các môn học
CREATE VIEW AVERAGE_MARK_VIEW AS
SELECT 
    STUDENT.studentId,
    STUDENT.studentName,
    AVG(MARK.point) AS average_mark
FROM 
    MARK
JOIN 
    STUDENT ON MARK.studentId = STUDENT.studentId
GROUP BY 
    STUDENT.studentId, STUDENT.studentName;
    -- Đánh Index cho trường `phoneNumber` của bảng STUDENT
		CREATE INDEX idx_phoneNumber on STUDENT(phoneNumber);

-- Tạo PROC_INSERTSTUDENT dùng để thêm mới 1 học sinh bao gồm tất cả thông tin học sinh đó.
DELIMITER //

CREATE PROCEDURE PROC_INSERTSTUDENT(p_studentId VARCHAR(4),
												  p_studentName VARCHAR(100),
												  p_birthday DATE,
												  p_gender BIT(1),
												  p_address TEXT,
												  p_phoneNumber VARCHAR(45))
BEGIN
    INSERT INTO STUDENT (studentId, studentName, birthday, gender, address, phoneNumber)
    VALUES (p_studentId, p_studentName, p_birthday, p_gender, p_address, p_phoneNumber);
END //

DELIMITER ;

-- Tạo PROC_UPDATESUBJECT dùng để cập nhật tên môn học theo mã môn học.
DELIMITER //

CREATE PROCEDURE PROC_UPDATESUBJECT(
    IN p_subjectId VARCHAR(4),
    IN p_newSubjectName VARCHAR(100)
)
BEGIN
    UPDATE SUBJECT
    SET SUBJECTName = p_newSubjectName
    WHERE SUBJECTId = p_subjectId;
END //

DELIMITER ;

-- Tạo PROC_DELETEMARK dùng để xoá toàn bộ điểm các môn học theo mã học sinh.
DELIMITER //

CREATE PROCEDURE PROC_DELETEMARK(
    IN p_studentId VARCHAR(4)
)
BEGIN
    DELETE FROM MARK
    WHERE studentId = p_studentId;
END //

DELIMITER ;



