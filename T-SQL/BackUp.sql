-- list of backup tables and Triggers


-- Table 2
-- table for storing deleted Calendars
CREATE TABLE Shumabo.Deleted_Academic_calendar (
	Calendar_ID VARCHAR(6) NOT NULL,
    Ac_Year INT,
    Activity_name VARCHAR(255),
    Activity_description VARCHAR(1000),
    Activity_start_date DATE,
    Activity_end_date DATE,
    Comment VARCHAR(1000),
    CONSTRAINT PK_Deleted_Calendar PRIMARY KEY(Calendar_ID)
);


-- TAble 2
-- for storing deleted progress reports

CREATE TABLE Shumabo.Deleted_progress_report (
    Report_no INT NOT null IDENTITY(111,3),
    Ac_year INT NOT NULL,
    Grade_level_Id VARCHAR(6) not null,
    Num_of_section INT,
    Num_of_stud int,
    Num_of_male_stud INT,
    Num_of_female_stud INT,
    Max_avg FLOAT,
    Min_avg FLOAT,
    Passed_stud_percentage FLOAT,
    Failed_stud_percentage FLOAT,
    Passed_male_percentage FLOAT,
    Failed_male_percentage FLOAT,
    Passed_female_percentage FLOAT,
    Failed_female_percentage FLOAT,
);


