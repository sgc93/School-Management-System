/*
 *  Group 6 
 *	Project titele:- Database Design and Implementation of School 
 *                   management system for Shumabo Secondary and Preparatory School  
 *  Group Members:-                
 *     Roll_no     Full_Name                 ID_no
 *        1.    Abiy     Shiferaw         130
 *        2.    Abrham   Desalegn         130
 *        3.    Jemal    Workie           13
 *        4.    Smachew  Gedefaw          1308736
 *        5.    Solomon  Muhye            130
 *        6.    Yordanos Ayenew           13
 *  
 *  
 */

-- create a database with name : Management_system_for_Shumabo_Secondary_and_Preparatory_school

  CREATE DATABASE Shumabo_Secondary_and_Preparatory_school

-- using the created database as a working area
  
 USE Shumabo_Secondary_and_Preparatory_school                  
 
 Use master
 drop DATABASE Shumabo_Secondary_and_Preparatory_school
-- creating tables in each schema

-- table 1: all parents (of all students) list in schema Stud_data

CREATE TABLE Stud_data.Parent (
    PID_no VARCHAR(15) NOT NULL,
    F_name VARCHAR(50),
    L_name VARCHAR(50),
    M_name VARCHAR(50),
    Gender VARCHAR(10),
    Birth_date DATE,
    Relation VARCHAR(255),
    Sub_city VARCHAR(255),
    Kebele VARCHAR(255),
    CONSTRAINT PK_PID PRIMARY KEY (PID_no)
);

-- table 2: list of parents' phone number, since we assumed that it will necessary to store more than one phone numbers for each parent

CREATE TABLE Stud_data.Parent_phone (
    PID_no VARCHAR(15) NOT NULL,
    Phone_number VARCHAR(20),
    CONSTRAINT PK_Parnent_phone PRIMARY KEY (PID_no, Phone_number),
    CONSTRAINT FK_Parent_Phone FOREIGN KEY (PID_no) REFERENCES Stud_data.Parent(PID_no)
);

-- table 3: list of Grade levels namely:- 9th, 10th, 11th and 12th

CREATE TABLE Assignment.Grade_level (
  Grade_level_ID VARCHAR(6) NOT NULL,
  Grade_level_name VARCHAR(6) NOT NULL,
  CONSTRAINT PK_Grade_level PRIMARY KEY (Grade_level_ID)
);

-- table 4: list of section which belongs to specific grade level and contain students

CREATE TABLE Assignment.Section (
  Section_code VARCHAR(6) NOT NULL,
  Grade_level_ID VARCHAR(6),
  CONSTRAINT PK_Section PRIMARY KEY (Section_code), 
  CONSTRAINT FK_Section FOREIGN KEY (Grade_level_ID) REFERENCES Assignment.Grade_level (Grade_level_ID)
);

-- table 5: list of all new students which registered in each year

CREATE TABLE Stud_data.New_Student (
  Ac_year INT, 
  Registration_date DATE,
  Stud_ID VARCHAR(10) NOT NULL,
  F_name VARCHAR(50),
  L_name VARCHAR(50),
  M_name VARCHAR(50),
  Gender VARCHAR(6),
  Birth_date DATE,
  Sub_city VARCHAR(50),
  Kebele VARCHAR(50),
  PID_no VARCHAR(15) NOT NULL
  CONSTRAINT PK_Stud PRIMARY KEY (Stud_ID), 
  CONSTRAINT FK_Stud_PID FOREIGN KEY (PID_no) REFERENCES Stud_data.Parent(PID_no)
  );

-- table 6: list of all students attended in class

CREATE TABLE Stud_data.Student (
  Ac_year INT, 
  Stud_ID VARCHAR(10) NOT NULL,
  F_name VARCHAR(50),
  L_name VARCHAR(50),
  M_name VARCHAR(50),
  Gender VARCHAR(6),
  Birth_date DATE,
  Sub_city VARCHAR(50),
  Kebele VARCHAR(50),
  PID_no VARCHAR(15) NOT NULL,
  Grade_level_ID VARCHAR(6),
  Section_code VARCHAR(6),
  CONSTRAINT PK_Student PRIMARY KEY (Stud_ID), 
  CONSTRAINT FK_Student_PID FOREIGN KEY (PID_no) REFERENCES Stud_data.Parent(PID_no),
  CONSTRAINT FK_Student_Grade FOREIGN KEY (Grade_level_ID) REFERENCES Assignment.Grade_level(Grade_level_ID),
  CONSTRAINT FK_Student_Section FOREIGN KEY (Section_code) REFERENCES Assignment.Section(Section_code)
  );
 

-- table 7: list of students' phone number, since we assumed that it will necessary to store more than one phone numbers for each student

CREATE TABLE Stud_data.Student_phone (
    Stud_ID VARCHAR(10) NOT NULL,
    Phone_number VARCHAR(20) NOT NULL,
    CONSTRAINT PK_SP PRIMARY KEY (Stud_ID, Phone_number),
    CONSTRAINT FK_SPstud FOREIGN KEY (Stud_ID) REFERENCES Stud_data.New_Student(Stud_ID),
);

-- table 8: a table that contains the yearly results of all students
       
CREATE TABLE Assignment.Subject(
  Subject_code VARCHAR(6) NOT NULL,
  Subject_name VARCHAR(50) NOT NULL,
  Grade_level_ID VARCHAR(6),
  CONSTRAINT PK_Sub PRIMARY KEY (Subject_code),
  CONSTRAINT FK_Sub_Grade FOREIGN KEY (Grade_level_ID) REFERENCES Assignment.Grade_level(Grade_level_ID)
);

-- table 9: the transcript list that contains the grade results(marks) of students in differet semester in different year (maximum for 4 years) and each year transcript is identified by the Trans_ser_no uniquely given number

CREATE TABLE Roaster_list (
  Ac_year INT NOT NULL,
  Stud_ID VARCHAR(10) NOT NULL,
  Grade_level_ID VARCHAR(6),
  Section_code VARCHAR(6),
  Subject_code VARCHAR(6),
  Frist_sem_mid_exam_25 INT,
  First_sem_quiz_10 INT,
  First_sem_assignment_15 INT,
  First_sem_final_exam_50 INT,
  Second_sem_mid_exam_25 INT,
  Second_sem_quiz_10 INT,
  Second_sem_assignment_15 INT,
  Second_sem_final_exam_50 INT,
  CONSTRAINT PK_Roaster_Stud PRIMARY KEY (Stud_ID),
  CONSTRAINT FK_Roaster_Stud FOREIGN KEY (Stud_ID) REFERENCES Stud_data.Student(Stud_ID),
  CONSTRAINT FK_Roaster_Grade FOREIGN KEY (Grade_level_ID) REFERENCES Assignment.Grade_level(Grade_level_ID),
  CONSTRAINT FK_Roaster_Subject FOREIGN KEY (Subject_code) REFERENCES Assignment.Subject(Subject_code),
  CONSTRAINT FK_Roaster_Section FOREIGN KEY (Section_code) REFERENCES Assignment.Section(Section_code)
);

-- table 10: Transcript list of  which is the conbind in formation containing 
CREATE TABLE Stud_data.Transcript (
    Trans_Ser_no INT NOT NULL IDENTITY(1001,2),
    Ac_Year INT,
    Stud_ID VARCHAR(15) NOT NULL,
    Grade_level_ID VARCHAR(6),
    Section_code VARCHAR(6),
    First_semester_total FLOAT,
    Second_semester_total FLOAT,
    First_semester_avg float,
    Second_semester_avg float,
    Final_avg float,
    Conduct CHAR(1)
    CONSTRAINT PK_Trnas PRIMARY KEY (Trans_Ser_no),
    CONSTRAINT FK_Trans_Grade FOREIGN KEY (Grade_level_ID) REFERENCES Assignment.Grade_level(Grade_level_ID),
    CONSTRAINT FK_Trans_Section FOREIGN KEY (Section_code) REFERENCES Assignment.Section(Section_code)
);

-- table 11: list of transform form lists 

CREATE TABLE Stud_data.Transform_form_list (
    TSer_no VARCHAR(10) NOT NULL,
    Stud_ID varchar(10) NOT NULL,
    Grade_level_ID VARCHAR(6),
    Section_code VARCHAR(6),
    Reason TEXT,
    Application_date DATE,
    Target_school_name VARCHAR(100),
    CONSTRAINT PK_TForm PRIMARY KEY (TSer_no),
    CONSTRAINT FK_Tform_Stud FOREIGN KEY (Stud_ID) REFERENCES Stud_data.Student(Stud_ID),
    CONSTRAINT FK_Tform_Grade FOREIGN KEY (Grade_level_ID) REFERENCES Assignment.Grade_level(Grade_level_ID),
    CONSTRAINT FK_Tform_Section FOREIGN KEY (Section_code) REFERENCES Assignment.Section(Section_code)
);



-- table 12: calculated Progress reports for each grade

CREATE TABLE Shumabo.Progress_report (
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
    CONSTRAINT PK_Progress PRIMARY KEY (Report_no),
    CONSTRAINT FK_Progress_Grade FOREIGN key (Grade_level_ID) REFERENCES Assignment.Grade_level(Grade_level_ID)
);


-- table 13: list of students with passed and failed students

CREATE TABLE Stud_data.Pass_fail_Student (
  Roll_no int IDENTITY(1,1),
  Ac_year INT, 
  Stud_ID VARCHAR(10) NOT NULL,
  Grade_level_ID VARCHAR(6) NOT NULL,
  Section_code VARCHAR(6) NOT NULL,
  Gender VARCHAR(10),
  Final_avg FLOAT,
  Stud_status VARCHAR(20),
  CONSTRAINT PK_pfs PRIMARY KEY (Roll_no),
  CONSTRAINT FK_pfs_Stud FOREIGN KEY (Stud_ID) REFERENCES Stud_data.Student,
  CONSTRAINT FK_pfs_Grade FOREIGN KEY (Grade_level_ID) REFERENCES Assignment.Grade_level(Grade_level_ID),
  CONSTRAINT FK_pfs_Section FOREIGN KEY (Section_code) REFERENCES Assignment.Section(Section_code)
);

-- table 14: list of withdrew students

CREATE TABLE Stud_data.Non_attendant (
  Ac_Year INT,
  Stud_ID VARCHAR(10) NOT NULL,
  Grade_level_ID VARCHAR(6) NOT NULL,
  Section_code VARCHAR(6) NOT NULL,
  Gender VARCHAR(10),
  Stud_status VARCHAR(20),
  Reason TEXT,
  Leave_date DATE,
  CONSTRAINT PK_NA PRIMARY KEY (Stud_ID),
  CONSTRAINT FK_NA_Grade FOREIGN KEY (Grade_level_ID) REFERENCES Assignment.Grade_level(Grade_level_ID),
  CONSTRAINT FK_NA_Section FOREIGN KEY (Section_code) REFERENCES Assignment.Section(Section_code)
)

-- table 15: list of all teachers

CREATE TABLE Teacher_data.Teacher (
  Teacher_ID VARCHAR(10) NOT NULL,
  F_name VARCHAR(50),
  L_name VARCHAR(50),
  M_name VARCHAR(50),
  Gender VARCHAR(8),
  Birth_date DATE,
  Degree_level VARCHAR(50),
  Staff_role VARCHAR(50),
  Sub_city VARCHAR(50),
  Kebele VARCHAR(50),
  CONSTRAINT PK_Teacher PRIMARY key (Teacher_ID)
);


select * from  Teacher_data.Teacher
-- table 16: list of teachers' phone number

CREATE TABLE Teacher_data.Teacher_phone (
    Teacher_ID VARCHAR(10),
    Phone_number varchar(20),
    CONSTRAINT PK_Teacher_phone PRIMARY KEY (Teacher_ID),
    CONSTRAINT FK_Teacher FOREIGN KEY (Teacher_ID) REFERENCES Teacher_data.Teacher(Teacher_ID)
);

-- table 17: assigning Teachers on on to Grade levels

CREATE TABLE Assignment.Teacher_Grade_Level (
  Teacher_ID VARCHAR(10) NOT NULL,
  Grade_level_ID VARCHAR(6),
  CONSTRAINT PK_TS PRIMARY KEY (Teacher_ID),
  CONSTRAINT FK_TS_Grade FOREIGN KEY (Grade_level_ID) REFERENCES Assignment.Grade_level(Grade_level_ID)
)


-- table 18: assining a teacher to a section
CREATE TABLE Assignment.Teacher_section (
  Teacher_ID VARCHAR(10) NOT NULL,
  Section_code VARCHAR(6),
  CONSTRAINT PK_TSec PRIMARY KEY (Teacher_ID),
  CONSTRAINT FK_TS_Section FOREIGN KEY (Section_code) REFERENCES Assignment.Section(Section_code)
)


-- table 19: teacher grade_level and Section // it will be better to make this table a view table

 CREATE TABLE Teacher_Grade_Section (
  Teacher_ID VARCHAR(10),
  Grade_level_ID VARCHAR(6),
  Section_code VARCHAR(6),
  CONSTRAINT PK_TGS PRIMARY KEY (Teacher_ID),
  CONSTRAINT FK_TGS_Grade FOREIGN key (Grade_level_ID) REFERENCES Assignment.Grade_level(Grade_level_ID),
  CONSTRAINT FK_TGS_Section FOREIGN KEY (Section_code) REFERENCES Assignment.Section(Section_code)
 );


-- table 20: assignining a teacher with specific subjects  check !!

CREATE TABLE Assignment.Teacher_Section_Subject (
  Assign_ID INT IDENTITY(1000, 2) not null,
  Teacher_ID VARCHAR(10),
  Section_code VARCHAR(6),
  Subject_code VARCHAR(6),
  CONSTRAINT PK_TSS PRIMARY KEY (Assign_ID),
  CONSTRAINT FK_TSS_Teacher FOREIGN KEY (Teacher_ID) REFERENCES Teacher_data.Teacher(Teacher_ID),
  CONSTRAINT FK_TSS_Subject FOREIGN KEY (Subject_code) REFERENCES Assignment.Subject(Subject_code),
  CONSTRAINT FK_TSS_Section FOREIGN KEY (Section_code) REFERENCES Assignment.Section(Section_code)
);

-- table 21: list of acadamic calendars

CREATE TABLE Shumabo.Academic_calendar (
    Calendar_ID VARCHAR(6) NOT NULL,
    Ac_Year INT,
    Activity_name VARCHAR(255),
    Activity_description VARCHAR(1000),
    Activity_start_date DATE,
    Activity_end_date DATE,
    Comment VARCHAR(1000),
    CONSTRAINT PK_Calendar PRIMARY KEY(Calendar_ID)
);


-- table 22: list of class schedules for each class 

CREATE TABLE Assignment.Class_Schedule (
    Schedule_ID VARCHAR(10),
    Ac_year INT,
    Section_code VARCHAR(6) NOT NULL,
    Grade_level_ID VARCHAR(6),
    Subject_code VARCHAR(6),
    Teacher_ID VARCHAR(10),
    Day_name VARCHAR(10),
    period_no INT,
    Start_time TIME,
    End_time TIME,
    CONSTRAINT PK_Class_schedule PRIMARY KEY (Schedule_ID),
    CONSTRAINT FK_Class_schedule_Grade_level FOREIGN KEY (Grade_level_ID) REFERENCES Assignment.Grade_level(Grade_level_ID),
    CONSTRAINT FK_Class_schedule_Section FOREIGN KEY (Section_code) REFERENCES Assignment.Section(Section_code),
    CONSTRAINT FK_Class_schedule_Subject FOREIGN KEY (Subject_code) REFERENCES Assignment.Subject(Subject_code),
    CONSTRAINT Fk_Class_schedule_Teacher FOREIGN KEY (Teacher_ID) REFERENCES Teacher_data.Teacher(Teacher_ID)
);
select * from Assignment.class_schedule
-- table 23: list of items in the resource room

CREATE TABLE Resource.All_item (
    ISer_no VARCHAR(8) not null,
    Item_name VARCHAR(50),
    Item_type varchar(50),
    Unit_price FLOAT, 
    Total_price FLOAT, 
    Current_quantity INT,
    CONSTRAINT PK_ALL PRIMARY KEY (ISer_no),
    CONSTRAINT FK_NI_New FOREIGN KEY (ISer_no) REFERENCES Resource.New_item(ISer_no),
);
-- table 24: list of newly add items

CREATE TABLE Resource.New_item (
    ISer_no VARCHAR(8) not null,
    Item_name VARCHAR(50),
    Item_type varchar(50),
    Unit_price FLOAT, 
    Total_price FLOAT,
    Recieving_date Date,
    Added_quantity INT,
    Item_resource TEXT,
    Comment TEXT,
    CONSTRAINT PK_NewItem PRIMARY KEY (ISer_no)
);

-- table 25: list of withdrawed itmes whith their description // can be a view table

CREATE TABLE Resource.Withdrew_Item (
    ISer_no VARCHAR(8) not null,
    Withdrawing_date Date,
    Withdrawed_quantity INT,
    Withdrawing_reason TEXT,
    Withdrawer_name VARCHAR(100),
    CONSTRAINT PK_WI PRIMARY KEY (ISer_no),
    CONSTRAINT FK_WI_All FOREIGN KEY (ISer_no) REFERENCES Resource.All_item(ISer_no)
);

-- table 26: list of Staff_data.Staff members

CREATE TABLE Staff_data.Staff (
  Staff_ID VARCHAR(10) NOT NULL,
  F_name VARCHAR(50),
  L_name VARCHAR(50),
  M_name VARCHAR(50),
  Gender VARCHAR(8),
  Birth_date DATE,
  Degree_level VARCHAR(50),
  Staff_role VARCHAR(50),
  Sub_city VARCHAR(50),
  Kebele VARCHAR(50),
  CONSTRAINT PK_Staff_member PRIMARY KEY (Staff_ID)
)

-- table 27: list of phone numbers for staff members

CREATE TABLE Staff_data.Staff_Phone (
  Staff_ID VARCHAR(10) NOT NULL,
  Phone_number VARCHAR(20),
  CONSTRAINT PK_SP PRIMARY KEY (Staff_ID),
  CONSTRAINT FK_SP_Staff FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID)
)

-- Inserting values for each tables created

-- inserting values for Table 1

INSERT INTO Stud_data.Parent (PID_no, F_name, L_name, M_name, Gender, Birth_date, Relation, Sub_city, Kebele)
VALUES ('BDR001', 'Abebe', 'Shiferaw', 'Abiy', 'Male', '1980-01-01', 'Father', 'Tana', 'Kebele 1'),
       ('BDR002', 'Almi', 'Desalegn', 'Abrham', 'Female', '1985-03-15', 'Mother', 'Facilo', 'Kebele 1'),
       ('BDR003', 'Wohy', 'Workie', 'Jemal', 'Male', '1975-05-20', 'Father', 'Gish Abay', 'Kebele 2'),
       ('BDR004', 'Meroda', 'Gedefaw', 'Smachew', 'Female', '1978-07-30', 'Mother', 'Belay Zeleke', 'Kebele 2'),
       ('BDR005', 'Sisay', 'Muhye', 'Solomon', 'Male', '1970-09-12', 'Father', 'Dagmawi Menelek', 'Kebele 3'),
       ('BDR006', 'Selam', 'Ayenew', 'Yordanos', 'Female', '1973-11-22', 'Mother', 'Atse Tewodros', 'Kebele 3');


-- check
-- SELECT * FROM Stud_data.Parent

-- inserting values for Table 2

INSERT INTO Parent_phone (PID_no, Phone_number)
VALUES ('BDR001', '+251 911 123 461'),
       ('BDR001', '+251 911 123 462'),
       ('BDR001', '+251 911 123 463'),
       ('BDR002', '+251 911 123 464'),
       ('BDR002', '+251 911 123 465'),
       ('BDR003', '+251 911 123 466'),
	     ('BDR003', '+251 911 123 467'),
       ('BDR004', '+251 911 123 468'),
       ('BDR004', '+251 911 123 469'),
       ('BDR005', '+251 911 123 471'),
       ('BDR006', '+251 911 123 472'),
       ('BDR006', '+251 911 123 473');
-- check
-- SELECT * FROM Parent_phone
-- SELECT * FROM Stud_data.Parent JOIN Parent_phone ON Stud_data.Parent.PID_no = Parent_phone.PID_no;


-- inserting values for Table 3

INSERT INTO Assignment.Grade_level (Grade_level_ID, Grade_level_name)
VALUES ('GID9', '9th'),
       ('GID10', '10th'),
       ('GID11', '11th'),
       ('GID12', '12th');

-- check
-- SELECT * FROM Assignment.Grade_level

-- inserting values for Table 4

INSERT INTO Assignment.Section (Section_code, Grade_level_ID)
VALUES ('9A', 'gid9'), 
       ('9B', 'gid9'), 
       ('10A', 'gid10'), 
       ('10B', 'gid10'),
       ('11A', 'gid11'), 
       ('11B', 'gid11'), 
       ('12A', 'gid12'), 
       ('12B', 'gid12');


-- check
-- SELECT * FROM Assignment.Section
-- SELECT distinct * FROM Assignment.Section JOIN Assignment.Grade_level ON Assignment.Section.Grade_level_ID = Assignment.Grade_level.Grade_level_ID;

-- inserting values for Table 5
INSERT INTO Stud_data.Student (Stud_ID, F_name, L_name, M_name, Gender, Birth_date, Age, Sub_city, Kebele, PID_no, Grade_level_ID, Section_code) 
VALUES ('ST00001', 'Habtsh','Shiferaw','Alemu', 'female', '2005-01-01', 18, 'Tana', 'Kebele 1', 'BDR001','GID11', '11A'),
       ('ST00002', 'Bezabh','Bogale', 'Desalegn', 'Male', '2005-03-15', 18, 'Facilo', 'Kebele 1', 'BDR002', 'GID11', '11B'),
       ('ST00003', 'Gebrie','Wohy', 'Workie', 'Male', '2007-05-20', 16, 'Gish Abay', 'Kebele 2', 'BDR003', 'GID9', '9A'),
       ('ST00004', 'Seblewongel','Meshesha', 'Gedefaw', 'Female', '2006-07-30', 17, 'Belay Zeleke', 'Kebele 2', 'BDR004', 'GID10', '10A'),
       ('ST00005', 'Gudukassa','Sisay', 'Muhye', 'Male', '2007-09-12', 16, 'Dagmawi Menelek', 'Kebele 3', 'BDR005', 'GID9', '9B'),
       ('ST00006', 'Tiruaynet','Selameneh', 'Ayenew', 'Female', '2006-11-22', 17, 'Atse Tewodros', 'Kebele 3', 'BDR006', 'GID10', '12A');

-- cheack
-- SELECT * FROM Stud_data.Student
       SELECT * FROM Assignment.Subject
-- for Table 6


INSERT INTO Student_phone (Stud_ID, Phone_number)
VALUES ('ST00001', '+251912345678'),
       ('ST00001', '+251909876543'),
       ('ST00002', '+251912378901'),
       ('ST00002', '+251909876501'),
       ('ST00003', '+251909876590'),
       ('ST00003', '+251909876578'),
       ('ST00003', '+251909876567'),
       ('ST00004', '+251909876512'),
       ('ST00004', '+251909876568'),
       ('ST00005', '+251909876513'),
       ('ST00005', '+251909876533'),
       ('ST00005', '+251909876522'),
       ('ST00006', '+251909876589'),
       ('ST00006', '+251909876534');
-- check
-- SELECT * FROM Student_phone

-- for Table 7

INSERT INTO Assignment.Subject (Subject_code, Subject_name, Grade_level_ID)
VALUES ('SA9', 'Amharic', 'GID9'),
       ('SE9', 'English', 'GID9'),
       ('SM9', 'Maths', 'GID9'),
       ('SB9', 'Biology', 'GID9'),
       ('SP9', 'Physics', 'GID9'),
       ('SCI9', 'Civics', 'GID9'),
       ('SCH9', 'Chemistry', 'GID9'),
       ('SH9', 'History', 'GID9'),
       ('SG9', 'Geography', 'GID9'),
       ('SS9', 'Sport Science', 'GID9'),
       ('SA10', 'Amharic', 'GID10'),
       ('SE10', 'English', 'GID10'),
       ('SM10', 'Maths', 'GID10'),
       ('SB10', 'Biology', 'GID10'),
       ('SP10', 'Physics', 'GID10'),
       ('SCI10', 'Civics', 'GID10'),
       ('SCH10', 'Chemistry', 'GID10'),
       ('SH10', 'History', 'GID10'),
       ('SG10', 'Geography', 'GID10'),
       ('SS10', 'Sport Science', 'GID10'),
       ('SA11', 'Amharic', 'GID11'),
       ('SE11', 'English', 'GID11'),
       ('SM11', 'Maths', 'GID11'),
       ('SB11', 'Biology', 'GID11'),
       ('SP11', 'Physics', 'GID11'),
       ('SCI11', 'Civics', 'GID11'),
       ('SCH11', 'Chemistry', 'GID11'),
       ('SH11', 'History', 'GID11'),
       ('SG11', 'Geography', 'GID11'),
       ('SS11', 'Sport Science', 'GID11'),
       ('SA12', 'Amharic', 'GID12'),
       ('SE12', 'English', 'GID12'),
       ('SM12', 'Maths', 'GID12'),
       ('SB12', 'Biology', 'GID12'),
       ('SP12', 'Physics', 'GID12'), 
       ('SCI12', 'Civics', 'GID12'),
       ('SCH12', 'Chemistry', 'GID12'),
       ('SH12', 'History', 'GID12'),
       ('SG12', 'Geography', 'GID12'),
       ('SS12', 'Sport Science', 'GID12'); 




-- check
--select * from Assignment.Subject
INSERT INTO Roaster_list (Ac_year, Stud_ID, Grade_level_ID, Section_code, Subject_code, Frist_sem_mid_exam_25, First_sem_quiz_10, First_sem_assignment_15, First_sem_final_exam_50, Second_sem_mid_exam_25, Second_sem_quiz_10, Second_sem_assignment_15, Second_sem_final_exam_50)
VALUES  (2021, 'ST00001', 'GID9', '9A', 'SA9', 14, 10, 15, 40, 10, 15, 10, 35),
        (2021, 'ST00001', 'GID9', '9A', 'SE9', 15, 9, 12, 50, 70, 15, 10, 35),
        (2021, 'ST00001', 'GID9', '9A', 'SM9', 15, 7, 14, 45, 70, 25, 10, 45),
        (2021, 'ST00001', 'GID9', '9A', 'SB9', 11, 6, 13, 46, 70, 25, 10, 45),
        (2021, 'ST00001', 'GID9', '9A', 'SP9', 13, 5, 15, 47, 70, 21, 10, 35),
        (2021, 'ST00001', 'GID9', '9A', 'SCI9', 13, 10, 15, 47, 24, 75, 10, 25),
        (2021, 'ST00001', 'GID9', '9A', 'SCH9', 12, 9, 12, 37, 22, 75, 10, 35),
        (2021, 'ST00001', 'GID9', '9A', 'SH9', 11, 7, 14, 50, 20, 75, 10, 45),
        (2021, 'sT00001', 'GID9', '9A', 'SG9', 13, 8, 13, 49, 24, 10, 11, 50),
        (2021, 'ST00001', 'GID9', '9A', 'SS9', 14, 10, 15, 30, 20, 75, 13, 35);
INSERT INTO Roaster_list (Ac_year, Stud_ID, Grade_level_ID, Section_code, Subject_code, Frist_sem_mid_exam_25, First_sem_quiz_10, First_sem_assignment_15, First_sem_final_exam_50, Second_sem_mid_exam_25, Second_sem_quiz_10, Second_sem_assignment_15, Second_sem_final_exam_50)
VALUES       
          (2022, 'ST00001', 'GID10', '10A', 'SA10', 24, 10, 15, 40, 10, 15, 10, 35),
          (2022, 'ST00001', 'GID10', '10A', 'SE10', 25, 9, 12, 50, 70, 15, 10, 35),
          (2022, 'ST00001', 'GID10', '10A', 'SM10', 25, 7, 14, 45, 70, 25, 10, 45),
          (2022, 'ST00001', 'GID10', '10A', 'SB10', 21, 6, 13, 46, 70, 25, 10, 45),
          (2022, 'ST00001', 'GID10', '10A', 'SP10', 23, 5, 15, 47, 70, 21, 10, 35),
          (2022, 'ST00001', 'GID10', '10A', 'SCI10', 23, 10, 15, 47, 24, 75, 10, 25),
          (2022, 'ST00001', 'GID10', '10A', 'SCH10', 22, 9, 12, 37, 22, 75, 10, 35),
          (2022, 'ST00001', 'GID10', '10A', 'SH10', 21, 7, 14, 50, 20, 75, 10, 45),
          (2022, 'sT00001', 'GID10', '10A', 'SG10', 21, 8, 13, 49, 24, 10, 11, 50),
          (2022, 'ST00001', 'GID10', '10A', 'SS10', 24, 10, 15, 30, 20, 75, 13, 35);
INSERT INTO Roaster_list (Ac_year, Stud_ID, Grade_level_ID, Section_code, Subject_code, Frist_sem_mid_exam_25, First_sem_quiz_10, First_sem_assignment_15, First_sem_final_exam_50, Second_sem_mid_exam_25, Second_sem_quiz_10, Second_sem_assignment_15, Second_sem_final_exam_50)
VALUES
            (2023, 'ST00001', 'GID11', '11A', 'SA11', 24, 10, 15, 40, 10, 15, 10, 35),
            (2023, 'ST00001', 'GID11', '11A', 'SE11', 19, 9, 12, 50, 70, 15, 10, 35),
            (2023, 'ST00001', 'GID11', '11A', 'SM11', 15, 7, 14, 45, 70, 25, 10, 45),
            (2023, 'ST00001', 'GID11', '11A', 'SB11', 21, 6, 13, 46, 70, 25, 10, 45),
            (2023, 'ST00001', 'GID11', '11A', 'SP11', 23, 5, 15, 47, 70, 21, 10, 35),
            (2023, 'ST00001', 'GID11', '11A', 'SCI11', 23, 10, 15, 47, 24, 75, 10, 25),
            (2023, 'ST00001', 'GID11', '11A', 'SCH11', 22, 9, 12, 37, 22, 75, 10, 35),
            (2023, 'ST00001', 'GID11', '11A', 'SH11', 21, 7, 14, 50, 20, 75, 10, 45),
            (2023, 'sT00001', 'GID11', '11A', 'SG11', 23, 8, 13, 49, 24, 10, 11, 50),
            (2023, 'ST00001', 'GID11', '11A', 'SS11', 24, 10, 15, 30, 20, 75, 13, 35);
INSERT INTO Roaster_list (Ac_year, Stud_ID, Grade_level_ID, Section_code, Subject_code, Frist_sem_mid_exam_25, First_sem_quiz_10, First_sem_assignment_15, First_sem_final_exam_50, Second_sem_mid_exam_25, Second_sem_quiz_10, Second_sem_assignment_15, Second_sem_final_exam_50)
VALUES
        (2021, 'ST00002', 'GID9', '9B', 'SA9', 24, 10, 15, 40, 10, 15, 10, 35),
        (2021, 'ST00002', 'GID9', '9B', 'SE9', 25, 9, 12, 50, 70, 15, 10, 35),
        (2021, 'ST00002', 'GID9', '9B', 'SM9', 25, 7, 14, 45, 70, 25, 10, 45),
        (2021, 'ST00002', 'GID9', '9B', 'SB9', 19, 6, 13, 46, 70, 25, 10, 45),
        (2021, 'ST00002', 'GID9', '9B', 'SP9', 25, 5, 15, 47, 70, 21, 10, 35),
        (2021, 'ST00002', 'GID9', '9B', 'SCI9', 24, 10, 15, 47, 24, 75, 10, 25),
        (2021, 'ST00002', 'GID9', '9B', 'SCH9', 23, 9, 12, 37, 22, 75, 10, 35),
        (2021, 'ST00002', 'GID9', '9B', 'SH9', 22, 7, 14, 50, 20, 75, 10, 45),
        (2021, 'sT00002', 'GID9', '9B', 'SG9', 23, 8, 13, 49, 24, 10, 11, 50),
        (2021, 'ST00002', 'GID9', '9B', 'SS9', 24, 10, 15, 30, 20, 75, 13, 35);

INSERT INTO Roaster_list (Ac_year, Stud_ID, Grade_level_ID, Section_code, Subject_code, Frist_sem_mid_exam_25, First_sem_quiz_10, First_sem_assignment_15, First_sem_final_exam_50, Second_sem_mid_exam_25, Second_sem_quiz_10, Second_sem_assignment_15, Second_sem_final_exam_50)
VALUES
          (2022, 'ST00002', 'GID10', '10B', 'SA10', 24, 10, 15, 40, 10, 15, 10, 35),
          (2022, 'ST00002', 'GID10', '10B', 'SE10', 25, 9, 12, 50, 70, 15, 10, 35),
          (2022, 'ST00002', 'GID10', '10B', 'SM10', 25, 7, 14, 45, 70, 25, 10, 45),
          (2022, 'ST00002', 'GID10', '10B', 'SB10', 22, 6, 13, 46, 70, 25, 10, 45),
          (2022, 'ST00002', 'GID10', '10B', 'SP10', 22, 5, 15, 47, 70, 21, 10, 35),
          (2022, 'ST00002', 'GID10', '10B', 'SCI10', 23, 10, 15, 47, 24, 75, 10, 25),
          (2022, 'ST00002', 'GID10', '10B', 'SCH10', 22, 9, 12, 37, 22, 75, 10, 35),
          (2022, 'ST00002', 'GID10', '10B', 'SH10', 19, 7, 14, 50, 20, 75, 10, 45),
          (2022, 'sT00002', 'GID10', '10B', 'SG10', 29, 8, 13, 49, 24, 10, 11, 50),
          (2022, 'ST00002', 'GID10', '10B', 'SS10', 17, 10, 15, 30, 20, 75, 13, 35);

INSERT INTO Roaster_list (Ac_year, Stud_ID, Grade_level_ID, Section_code, Subject_code, Frist_sem_mid_exam_25, First_sem_quiz_10, First_sem_assignment_15, First_sem_final_exam_50, Second_sem_mid_exam_25, Second_sem_quiz_10, Second_sem_assignment_15, Second_sem_final_exam_50)
VALUES
            (2023, 'ST00002', 'GID11', '11B', 'SA11', 17, 10, 15, 40, 10, 15, 10, 35),
            (2023, 'ST00002', 'GID11', '11B', 'SE11', 16, 9, 12, 50, 70, 15, 10, 35),
            (2023, 'ST00002', 'GID11', '11B', 'SM11', 15, 7, 14, 45, 70, 25, 10, 45),
            (2023, 'ST00002', 'GID11', '11B', 'SB11', 22, 6, 13, 46, 70, 25, 10, 45),
            (2023, 'ST00002', 'GID11', '11B', 'SP11', 21, 5, 15, 47, 70, 21, 10, 35),
            (2023, 'ST00002', 'GID11', '11B', 'SCI11', 25, 10, 15, 47, 24, 75, 10, 25),
            (2023, 'ST00002', 'GID11', '11B', 'SCH11', 24, 9, 12, 37, 22, 75, 10, 35),
            (2023, 'ST00002', 'GID11', '11B', 'SH11', 23, 7, 14, 50, 20, 75, 10, 45),
            (2023, 'sT00002', 'GID11', '11B', 'SG11', 21, 8, 13, 49, 24, 10, 11, 50),
            (2023, 'ST00002', 'GID11', '11B', 'SS11', 25, 10, 15, 30, 20, 75, 13, 35);

INSERT INTO Roaster_list (Ac_year, Stud_ID, Grade_level_ID, Section_code, Subject_code, Frist_sem_mid_exam_25, First_sem_quiz_10, First_sem_assignment_15, First_sem_final_exam_50, Second_sem_mid_exam_25, Second_sem_quiz_10, Second_sem_assignment_15, Second_sem_final_exam_50)
VALUES
        (2023, 'ST00003', 'GID9', '9A', 'SA9', 14, 10, 15, 40, 10, 15, 10, 35),
        (2023, 'ST00003', 'GID9', '9A', 'SE9', 15, 9, 12, 50, 70, 15, 10, 35),
        (2023, 'ST00003', 'GID9', '9A', 'SM9', 15, 7, 14, 45, 70, 25, 10, 45),
        (2023, 'ST00003', 'GID9', '9A', 'SB9', 11, 6, 13, 46, 70, 25, 10, 45),
        (2023, 'ST00003', 'GID9', '9A', 'SP9', 13, 5, 15, 47, 70, 21, 10, 35),
        (2023, 'ST00003', 'GID9', '9A', 'SCI9', 13, 10, 15, 47, 24, 75, 10, 25),
        (2023, 'ST00003', 'GID9', '9A', 'SCH9', 12, 9, 12, 37, 22, 75, 10, 35),
        (2023, 'ST00003', 'GID9', '9A', 'SH9', 11, 7, 14, 50, 20, 75, 10, 45),
        (2023, 'sT00003', 'GID9', '9A', 'SG9', 13, 8, 13, 49, 24, 10, 11, 50),
        (2023, 'ST00003', 'GID9', '9A', 'SS9', 14, 10, 15, 30, 20, 75, 13, 35),
        (2022, 'ST00004', 'GID9', '9A', 'SA9', 14, 10, 15, 40, 10, 15, 10, 35),
        (2022, 'ST00004', 'GID9', '9A', 'SE9', 15, 9, 12, 50, 70, 15, 10, 35),
        (2022, 'ST00004', 'GID9', '9A', 'SM9', 15, 7, 14, 45, 70, 25, 10, 45),
        (2022, 'ST00004', 'GID9', '9A', 'SB9', 11, 6, 13, 46, 70, 25, 10, 45),
        (2022, 'ST00004', 'GID9', '9A', 'SP9', 13, 5, 15, 47, 70, 21, 10, 35),
        (2022, 'ST00004', 'GID9', '9A', 'SCI9', 13, 10, 15, 47, 24, 75, 10, 25),
        (2022, 'ST00004', 'GID9', '9A', 'SCH9', 12, 9, 12, 37, 22, 75, 10, 35),
        (2022, 'ST00004', 'GID9', '9A', 'SH9', 11, 7, 14, 50, 20, 75, 10, 45),
        (2022, 'sT00004', 'GID9', '9A', 'SG9', 13, 8, 13, 49, 24, 10, 11, 50),
        (2022, 'ST00004', 'GID9', '9A', 'SS9', 14, 10, 15, 30, 20, 75, 13, 35),
          (2023, 'ST00004', 'GID1O', '1OA', 'SA10', 14, 10, 15, 40, 10, 15, 10, 35),
          (2023, 'ST00004', 'GID1O', '1OA', 'SE10', 15, 9, 12, 50, 70, 15, 10, 35),
          (2023, 'ST00004', 'GID1O', '1OA', 'SM10', 15, 7, 14, 45, 70, 25, 10, 45),
          (2023, 'ST00004', 'GID1O', '1OA', 'SB10', 11, 6, 13, 46, 70, 25, 10, 45),
          (2023, 'ST00004', 'GID1O', '1OA', 'SP10', 13, 5, 15, 47, 70, 21, 10, 35),
          (2023, 'ST00004', 'GID1O', '1OA', 'SCI10', 13, 10, 15, 47, 24, 75, 10, 25),
          (2023, 'ST00004', 'GID1O', '1OA', 'SCH10', 12, 9, 12, 37, 22, 75, 10, 35),
          (2023, 'ST00004', 'GID1O', '1OA', 'SH10', 11, 7, 14, 50, 20, 75, 10, 45),
          (2023, 'sT00004', 'GID1O', '1OA', 'SG10', 13, 8, 13, 49, 24, 10, 11, 50),
          (2023, 'ST00004', 'GID1O', '1OA', 'SS10', 14, 10, 15, 30, 20, 75, 13, 35),
        (2023, 'ST00005', 'GID9', '9B', 'SA9', 24, 10, 15, 40, 10, 15, 10, 35),
        (2023, 'ST00005', 'GID9', '9B', 'SE9', 15, 9, 12, 50, 70, 15, 10, 35),
        (2023, 'ST00005', 'GID9', '9B', 'SM9', 25, 7, 14, 45, 70, 25, 10, 45),
        (2023, 'ST00005', 'GID9', '9B', 'SB9', 11, 6, 13, 46, 70, 25, 10, 45),
        (2023, 'ST00005', 'GID9', '9B', 'SP9', 23, 5, 15, 47, 70, 21, 10, 35),
        (2023, 'ST00005', 'GID9', '9B', 'SCI9', 23, 10, 15, 47, 24, 75, 10, 25),
        (2023, 'ST00005', 'GID9', '9B', 'SCH9', 22, 9, 12, 37, 22, 75, 10, 35),
        (2023, 'ST00005', 'GID9', '9B', 'SH9', 11, 7, 14, 50, 20, 75, 10, 45),
        (2023, 'sT00005', 'GID9', '9B', 'SG9', 13, 8, 13, 49, 24, 10, 11, 50),
        (2023, 'ST00005', 'GID9', '9B', 'SS9', 14, 10, 15, 30, 20, 75, 13, 35),
        (2020, 'ST00006', 'GID9', '9A', 'SA9', 24, 10, 15, 40, 10, 15, 10, 35),
        (2020, 'ST00006', 'GID9', '9A', 'SE9', 15, 9, 12, 50, 70, 15, 10, 35),
        (2020, 'ST00006', 'GID9', '9A', 'SM9', 25, 7, 14, 45, 70, 25, 10, 45),
        (2020, 'ST00006', 'GID9', '9A', 'SB9', 11, 6, 13, 46, 70, 25, 10, 45),
        (2020, 'ST00006', 'GID9', '9A', 'SP9', 23, 5, 15, 47, 70, 21, 10, 35),
        (2020, 'ST00006', 'GID9', '9A', 'SCI9', 13, 10, 15, 47, 24, 75, 10, 25),
        (2020, 'ST00006', 'GID9', '9A', 'SCH9', 12, 9, 12, 37, 22, 75, 10, 35),
        (2020, 'ST00006', 'GID9', '9A', 'SH9', 11, 7, 14, 50, 20, 75, 10, 45),
        (2020, 'sT00006', 'GID9', '9A', 'SG9', 13, 8, 13, 49, 24, 10, 11, 50),
        (2020, 'ST00006', 'GID9', '9A', 'SS9', 14, 10, 15, 30, 20, 75, 13, 35),
          (2021, 'ST00006', 'GID10', '10B', 'SA10', 24, 10, 15, 40, 10, 15, 10, 35),
          (2021, 'ST00006', 'GID10', '10B', 'SE10', 5, 9, 12, 50, 70, 15, 10, 35),
          (2021, 'ST00006', 'GID10', '10B', 'SM10', 25, 7, 14, 45, 70, 25, 10, 45),
          (2021, 'ST00006', 'GID10', '10B', 'SB10', 1, 6, 13, 46, 70, 25, 10, 45),
          (2021, 'ST00006', 'GID10', '10B', 'SP10', 23, 5, 15, 47, 70, 21, 10, 35),
          (2021, 'ST00006', 'GID10', '10B', 'SCI10',13, 10, 15, 47, 24, 75, 10, 25),
          (2021, 'ST00006', 'GID10', '10B', 'SCH10', 12, 9, 12, 37, 22, 75, 10, 35),
          (2021, 'ST00006', 'GID10', '10B', 'SH10', 21, 7, 14, 50, 20, 75, 10, 45),
          (2021, 'sT00006', 'GID10', '10B', 'SG10', 13, 8, 13, 49, 24, 10, 11, 50),
          (2021, 'ST00006', 'GID10', '10B', 'SS10', 24, 10, 15, 30, 20, 75, 13, 35),
            (2022, 'ST00006', 'GID11', '11B', 'SA11', 24, 10, 15, 40, 10, 15, 10, 35),
            (2022, 'ST00006', 'GID11', '11B', 'SE11', 15, 9, 12, 50, 70, 15, 10, 35),
            (2022, 'ST00006', 'GID11', '11B', 'SM11', 25, 7, 14, 45, 70, 25, 10, 45),
            (2022, 'ST00006', 'GID11', '11B', 'SB11', 11, 6, 13, 46, 70, 25, 10, 45),
            (2022, 'ST00006', 'GID11', '11B', 'SP11', 23, 5, 15, 47, 70, 21, 10, 35),
            (2022, 'ST00006', 'GID11', '11B', 'SCI11', 23, 10, 15, 47, 24, 75, 10, 25),
            (2022, 'ST00006', 'GID11', '11B', 'SCH11', 12, 9, 12, 37, 22, 75, 10, 35),
            (2022, 'ST00006', 'GID11', '11B', 'SH11', 12, 7, 14, 50, 20, 75, 10, 45),
            (2022, 'sT00006', 'GID11', '11B', 'SG11', 13, 8, 13, 49, 24, 10, 11, 50),
            (2022, 'ST00006', 'GID11', '11B', 'SS11', 12, 10, 15, 30, 20, 75, 13, 35),
              (2023, 'ST00006', 'GID12', '12B', 'SA12', 14, 10, 15, 40, 10, 15, 10, 35),
              (2023, 'ST00006', 'GID12', '12B', 'SE12', 15, 9, 12, 50, 70, 15, 10, 35),
              (2023, 'ST00006', 'GID12', '12B', 'SM12', 24, 7, 14, 45, 70, 25, 10, 45),
              (2023, 'ST00006', 'GID12', '12B', 'SB12', 11, 6, 13, 46, 70, 25, 10, 45),
              (2023, 'ST00006', 'GID12', '12B', 'SP12', 24, 5, 15, 47, 70, 21, 10, 35),
              (2023, 'ST00006', 'GID12', '12B', 'SCI12', 13, 10, 15, 47, 24, 75, 10, 25),
              (2023, 'ST00006', 'GID12', '12B', 'SCH12', 12, 9, 12, 37, 22, 75, 10, 35),
              (2023, 'ST00006', 'GID12', '12B', 'SH12', 21, 7, 14, 50, 20, 75, 10, 45),
              (2023, 'sT00006', 'GID12', '12B', 'SG12', 23, 8, 13, 49, 24, 10, 11, 50),
              (2023, 'ST00006', 'GID12', '12B', 'SS12', 24, 10, 15, 30, 20, 75, 13, 35);

-- check 
-- select * from Roaster_list

-- for Table 
INSERT INTO Teacher_data.Teacher (Teacher_ID, F_name, L_name, M_name, Gender, Birth_date, Age, Degree_level, Sub_city, Kebele)
VALUES ('T001', 'Abdi', 'Mohammed', 'Alemu', 'Male', '1980-01-01', 41, 'Degree', 'Facilo', 'Kebele 4'),
       ('T002', 'Roman', 'Bealu', 'Girma', 'Female', '1985-03-15', 36, 'Master', 'Tana', 'Kebele 13'),
       ('T003', 'Yesewku', 'Ewunetu', 'Manyazewal', 'Male', '1975-05-20', 46, 'Degree', 'Gish Abay', 'Kebele 3'),
       ('T004', 'Jemila', 'Gedefaw', 'Smachew', 'Female', '1978-07-30', 43, 'Degree', 'Belay Zeleke', 'Kebele 4'),
       ('T005', 'Yeab', 'Neged', 'Eleizier', 'Male', '1970-09-12', 51, 'Master', 'Dagmawi Menelek', 'Kebele 10'),
       ('T006', 'Tangut', 'Kasa', 'Gondere', 'Female', '1973-11-22', 48, 'Degree', 'Atse Tewodros', 'Kebele 14');

  -- check
  -- SELECT * FROM Teacher_data.Teacher

-- for Table

INSERT INTO Teacher_phone (Teacher_ID, Phone_number)
VALUES ('T001', '+251 989 143 563'),
       ('T001', '+251 989 143 564'),
       ('T001', '+251 989 143 565'),
       ('T002', '+251 989 143 566'),
       ('T002', '+251 989 143 567'),
       ('T003', '+251 989 143 568'),
	     ('T003', '+251 989 143 569'),
       ('T004', '+251 989 143 572'),
       ('T004', '+251 989 143 571'),
       ('T005', '+251 989 143 578'),
       ('T006', '+251 989 143 576'),
       ('T006', '+251 989 143 573');
  -- check
  -- SELECT * FROM Teacher_phone

-- for Table

INSERT INTO Assignment.Teacher_Grade_Level (Teacher_ID, Grade_level_ID)
VALUES  ('T001', 'GID9'),
        ('T002', 'GID10'),
        ('T003', 'GID11'),
        ('T004', 'GID12'),
        ('T005', 'GID11'),
        ('T006', 'GID12');

  -- check
  -- SELECT * FROM Assignment.Teacher_Grade_Level

-- for Table

INSERT INTO Assignment.Teacher_section (Teacher_ID, Section_code)
VALUES  ('T001', '9A'),
        ('T002', '10B'),
        ('T003', '11A'),
        ('T004', '12B'),
        ('T005', '11A'),
        ('T006', '12A');

  -- check
  -- SELECT * FROM Assignment.Teacher_section


-- for Table

INSERT INTO Teacher_Subject (Teacher_ID, Subject_code)
VALUES  ('T001', 'SP9'),
        ('T001', 'SCH9'),
        ('T002', 'SM10'),
        ('T002', 'SP10'),
        ('T003', 'SB11'),
        ('T004', 'SM12'),
        ('T005', 'SH11A'),
        ('T005', 'SG11A'),
        ('T006', 'SCH12'),
        ('T006', 'SP12');
 -- check
 -- SELECT * FROM Teacher_Subject

-- for Table

INSERT INTO Shumabo.Academic_calendar (Calendar_ID, Ac_Year, Activity_name, Activity_description, Activity_start_date, Activity_end_date, Comment)
VALUES ('C2023', 2023, 'Cleaning Day', 'by this program almost all parts of the school are going to be cleaned by both students and staff members', '2023-02-01', '2023-02-05', 'Commete, which constain 3 members, should me constructed ')

 -- check
 -- SELECT * FROM Shumabo.Academic_calendar


-- for Table

INSERT INTO Resource.New_item (ISer_no, Item_name, Item_type, Unit_price, Total_price, Recieving_date, Added_quantity, Item_resource, Comment)
VALUES ('IT1112', 'Grade 12 Physices Teacher guede book', 'I_Alaki', 59.50, 5950, '2022-09-12', 100, 'From Amhara Education Bureau', 'there is no any budgent withdrwal for them.');

 -- check
 -- SELECT * FROM Resource.New_item

 
-- for table
INSERT INTO Resource.Withdrew_item (ISer_no, Withdrawed_quantity, Withdrawing_date, Withdrawing_reason, Withdrawer_name)
VALUES ('IT1112', '45', '2022-09-14', 'teachers need a updated version', 'Tr. Mohammed Alemu')

DELETE from Resource.Withdrew_item WHERE ISer_no = 'IT1112'
 -- cheack
 -- SELECT * FROM Resource.Withdrew_item

-- for Table

INSERT INTO Staff_data.Staff (Staff_ID, F_name, L_name, M_name, Gender, Birth_date, Age, Degree_level, Staff_role,Sub_city, Kebele)
VALUES ('SF001', 'Abdi', 'Mohammed', 'Alemu', 'Male', '1980-01-01', 41, 'Degree', 'Facilo', 'Kebele 4'),
       ('SF002', 'Roman', 'Bealu', 'Girma', 'Female', '1985-03-15', 36, 'Master', 'Tana', 'Kebele 13'),
       ('SF003', 'Yesewku', 'Ewunetu', 'Manyazewal', 'Male', '1975-05-20', 46, 'Degree', 'Gish Abay', 'Kebele 3'),
       ('SF004', 'Jemila', 'Gedefaw', 'Smachew', 'Female', '1978-07-30', 43, 'Degree', 'Belay Zeleke', 'Kebele 4'),
       ('SF005', 'Yeab', 'Neged', 'Eleizier', 'Male', '1970-09-12', 51, 'Master', 'Dagmawi Menelek', 'Kebele 10'),
       ('SF006', 'Tangut', 'Kasa', 'Gondere', 'Female', '1973-11-22', 48, 'Degree', 'Atse Tewodros', 'Kebele 14');

  -- check
  -- SELECT * FROM Staff_data.Staff

-- for Table

INSERT INTO Staff_data.Staff_phone (Staff_ID, Phone_number)
VALUES ('SF001', '+251 918 567 893'),
       ('SF001', '+251 918 567 894'),
       ('SF001', '+251 918 567 895'),
       ('SF002', '+251 918 567 896'),
       ('SF002', '+251 918 567 897'),
       ('SF003', '+251 918 567 898'),
	     ('SF003', '+251 918 567 899'),
       ('SF004', '+251 918 567 892'),
       ('SF004', '+251 918 567 891'),
       ('SF005', '+251 918 567 810'),
       ('SF006', '+251 918 567 811'),
       ('SF006', '+251 918 567 812');
  -- check
  -- SELECT * FROM Staff_data.Staff_phone

SELECT * FROM Assignment.Class_Schedule

