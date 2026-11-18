-- =============================================================
-- EduResult - Student Result Management System
-- Database Schema & Sample Data Setup Script
-- Database: StudentResultDB
-- =============================================================

CREATE DATABASE StudentResultDB;
GO

USE StudentResultDB;
GO

-- 1. Students Table
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Students' AND xtype='U')
BEGIN
    CREATE TABLE Students (
        StudentID INT IDENTITY(1,1) PRIMARY KEY,
        EnrollmentNo NVARCHAR(50) NOT NULL UNIQUE,
        Name NVARCHAR(100) NOT NULL,
        Email NVARCHAR(100) NOT NULL,
        Password NVARCHAR(100) NOT NULL,
        Department NVARCHAR(100) NOT NULL,
        Semester INT NOT NULL
    );
END
GO

-- 2. Results Table
-- Note: Curriculum subjects are statically mapped in application code:
-- 1: .NET Technologies (Max: 100, Passing: 40)
-- 2: Operating Systems & Technology (OST) (Max: 100, Passing: 40)
-- 3: Data Science Engineering (DSE) (Max: 100, Passing: 40)
-- 4: Database Management Systems (DBMS) (Max: 100, Passing: 40)
-- 5: Data Structures (Max: 100, Passing: 40)
-- 6: Artificial Intelligence (Max: 100, Passing: 40)
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Results' AND xtype='U')
BEGIN
    CREATE TABLE Results (
        ResultID INT IDENTITY(1,1) PRIMARY KEY,
        StudentID INT NOT NULL,
        SubjectID INT NOT NULL,
        Marks INT NOT NULL,
        CONSTRAINT FK_Results_Students FOREIGN KEY (StudentID) 
            REFERENCES Students(StudentID) ON DELETE CASCADE
    );
END
GO

-- 3. Sample Seed Data
-- Insert Sample Students
IF NOT EXISTS (SELECT 1 FROM Students WHERE EnrollmentNo = '92200101001')
BEGIN
    INSERT INTO Students (EnrollmentNo, Name, Email, Password, Department, Semester)
    VALUES 
    ('92200101001', 'Aarav Patel', 'aarav.patel@marwadiuniversity.ac.in', 'student123', 'Computer Engineering', 5),
    ('92200101002', 'Diya Sharma', 'diya.sharma@marwadiuniversity.ac.in', 'student123', 'Computer Engineering', 5),
    ('92200101003', 'Rohan Mehta', 'rohan.mehta@marwadiuniversity.ac.in', 'student123', 'Information Technology', 5),
    ('92200101004', 'Priya Varma', 'priya.varma@marwadiuniversity.ac.in', 'student123', 'Computer Engineering', 5);
END
GO

-- Insert Sample Examination Marks
-- SubjectIDs: 1=.NET, 2=OST, 3=DSE, 4=DBMS, 5=Data Structures, 6=AI
IF NOT EXISTS (SELECT 1 FROM Results)
BEGIN
    -- Student 1 (Aarav Patel) - Pass
    INSERT INTO Results (StudentID, SubjectID, Marks) VALUES
    (1, 1, 88),
    (1, 2, 75),
    (1, 3, 82),
    (1, 4, 91),
    (1, 5, 79),
    (1, 6, 85);

    -- Student 2 (Diya Sharma) - Pass
    INSERT INTO Results (StudentID, SubjectID, Marks) VALUES
    (2, 1, 92),
    (2, 2, 86),
    (2, 3, 90),
    (2, 4, 95),
    (2, 5, 89),
    (2, 6, 94);

    -- Student 3 (Rohan Mehta) - With Backlog (Failed Subject 2)
    INSERT INTO Results (StudentID, SubjectID, Marks) VALUES
    (3, 1, 65),
    (3, 2, 32), -- Backlog (< 40)
    (3, 3, 58),
    (3, 4, 70),
    (3, 5, 45),
    (3, 6, 60);

    -- Student 4 (Priya Varma) - Pass
    INSERT INTO Results (StudentID, SubjectID, Marks) VALUES
    (4, 1, 78),
    (4, 2, 72),
    (4, 3, 68),
    (4, 4, 84),
    (4, 5, 77),
    (4, 6, 80);
END
GO
