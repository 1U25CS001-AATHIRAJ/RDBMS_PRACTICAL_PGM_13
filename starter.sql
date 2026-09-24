### starter.sql

```sql
-- STUDENT NORMALIZATION ASSIGNMENT
--
-- Original table:
-- Student(StudentID, StudentName, CourseName, FacultyName, DepartmentName)
--
-- Normalize the table up to Third Normal Form (3NF).
--
-- Write your normalized CREATE TABLE statements below.


-- Table 1
-- CREATE TABLE ...


-- Table 2
-- CREATE TABLE ...


-- Table 3
-- CREATE TABLE ...


-- Table 4
-- CREATE TABLE ...
```

---

### answers.sql

```sql
-- Student Table Normalization up to 3NF

CREATE TABLE DEPARTMENT (
    DepartmentID NUMBER(5) PRIMARY KEY,
    DepartmentName VARCHAR2(30) NOT NULL
);

CREATE TABLE FACULTY (
    FacultyID NUMBER(5) PRIMARY KEY,
    FacultyName VARCHAR2(30) NOT NULL
);

CREATE TABLE COURSE (
    CourseID NUMBER(5) PRIMARY KEY,
    CourseName VARCHAR2(30) NOT NULL,
    FacultyID NUMBER(5),
    CONSTRAINT fk_course_faculty
        FOREIGN KEY (FacultyID)
        REFERENCES FACULTY(FacultyID)
);

CREATE TABLE STUDENT (
    StudentID NUMBER(5) PRIMARY KEY,
    StudentName VARCHAR2(30) NOT NULL,
    CourseID NUMBER(5),
    DepartmentID NUMBER(5),
    CONSTRAINT fk_student_course
        FOREIGN KEY (CourseID)
        REFERENCES COURSE(CourseID),
    CONSTRAINT fk_student_department
        FOREIGN KEY (DepartmentID)
        REFERENCES DEPARTMENT(DepartmentID)
);
```
