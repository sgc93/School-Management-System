Use Shumabo_secondary_school

-- list of Views

-- view 1
-- full information of Teachers

GO
    CREATE VIEW Teacher_data.Teacher_data AS
    SELECT  Teacher_data.Teacher.Teacher_ID,
            Teacher_data.Teacher.F_name,
            Teacher_data.Teacher.L_name,
            Teacher_data.Teacher.M_name,
            Teacher_data.Teacher.Gender,
            Teacher_data.Teacher.Birth_date,
            Teacher_data.Teacher.Degree_level,
            Teacher_data.Teacher.Sub_city,
            Teacher_data.Teacher.Kebele,
            Teacher_phone.Phone_number,
            Assignment.Teacher_Grade_Level.Grade_level_ID,
            Assignment.Teacher_section_subject.Section_code,
            Assignment.Teacher_section_subject.Subject_code
    FROM Teacher_data.Teacher

    LEFT JOIN Assignment.Teacher_Grade_Level ON Teacher_data.Teacher.Teacher_ID = Assignment.Teacher_Grade_Level.Teacher_ID
    LEFT JOIN Assignment.Teacher_section_subject ON Teacher_data.Teacher.Teacher_ID = Assignment.Teacher_section_subject.Teacher_ID
    LEFT JOIN Teacher_phone ON Teacher_data.Teacher.Teacher_ID = Teacher_phone.Teacher_ID

GO

-- view 2
-- list of subjects and there Teachers

GO
    CREATE VIEW Assignment.Subject_Teacher AS
    SELECT  Assignment.Subject.Subject_code AS Subject_code,
            Assignment.Subject.Subject_name AS Subject_name,
            Assignment.Teacher_section_subject.Section_code AS Section_code,
            Assignment.Subject.Grade_level_ID As Grade_level_Id,
            Assignment.Teacher_section_subject.Teacher_ID AS Teacher_ID,
            Teacher_data.Teacher.F_name AS Teacher_name
    FROM Assignment.Subject
    LEFT JOIN Assignment.Teacher_section_subject ON Assignment.Subject.Subject_code = Assignment.Teacher_section_subject.Subject_code
    LEFT JOIN Teacher_data.Teacher ON Assignment.Teacher_section_subject.Teacher_ID = Teacher_data.Teacher.Teacher_ID
GO

-- view 3
-- Submitted roasters

GO
    CREATE VIEW Stud_data.Submittable_roaster AS
    SELECT  Stud_data.Roaster.Ac_year, 
            Stud_data.Roaster.Stud_ID, 
            Stud_data.Roaster.Grade_level_ID, 
            Stud_data.Roaster.Section_code, 
            Stud_data.Roaster.Subject_code, 
            (Stud_data.Roaster.Frist_sem_mid_exam_25 + Stud_data.Roaster.First_sem_quiz_10 + Stud_data.Roaster.First_sem_assignment_15 + Stud_data.Roaster.First_sem_final_exam_50) AS First_sem_Sum,
            (Stud_data.Roaster.Second_sem_mid_exam_25 + Stud_data.Roaster.Second_sem_quiz_10 + Stud_data.Roaster.Second_sem_assignment_15 + Stud_data.Roaster.Second_sem_final_exam_50) AS Second_sem_Sum
    FROM Stud_data.Roaster
GO

SELECT * FROM Stud_data.Submittable_roaster

-- view 4
-- Current status of Items

GO
    CREATE VIEW Resource.Current_Item_Status AS
    SELECT  Resource.All_item.ISer_no, 
            Resource.All_item.Item_name, 
            Resource.All_item.Item_type, 
            Resource.All_item.Unit_price,
            Resource.New_item.Recieving_date, 
            Resource.New_item.Added_quantity,
            (Resource.New_item.Added_quantity - Resource.All_item.Current_quantity) AS Withdrew_quantity,
            Resource.All_item.Current_quantity,
            Resource.All_item.Total_price
    FROM Resource.All_item
    LEFT JOIN Resource.New_item ON Resource.All_item.ISer_no = Resource.New_item.ISer_no
    LEFT JOIN Resource.Withdrew_Item ON Resource.All_item.ISer_no = Resource.Withdrew_Item.ISer_no;
GO

-- view 5
-- containing the full information of the grade_levels

GO
    CREATE VIEW  Assignment.Grade_level_data AS
    SELECT  Stud_data.Roaster.Ac_year,
            Assignment.Grade_level.Grade_level_ID,
            Assignment.Grade_level.Grade_level_name,
            Assignment.Section.Section_Code,
            Stud_data.Student.Stud_ID,
            Stud_data.Student.Gender
    FROM Stud_data.Roaster
    LEFT JOIN Assignment.Grade_level ON Stud_data.Roaster.Grade_level_ID = Assignment.Grade_level.Grade_level_ID
    LEFT JOIN Assignment.Section ON Assignment.Grade_level.Grade_level_ID = Assignment.Section.Grade_level_ID
    LEFT JOIN Stud_data.Student ON Assignment.Section.Section_code = Stud_data.Student.Section_code
GO

-- view 6 
-- store the detail information of class schedule for each section

GO
    CREATE VIEW Assignment.Class_schedule_detail AS
    SELECT 
            Assignment.Class_Schedule.Schedule_ID,
            Assignment.Class_Schedule.Ac_year,
            Assignment.Class_Schedule.Section_code,
            Assignment.Class_Schedule.Grade_level_ID,
            Assignment.Grade_level.Grade_level_name,
            Assignment.Class_Schedule.period_no,
            Assignment.Class_Schedule.Subject_code,
            Assignment.Subject.Subject_name,
            Assignment.Class_Schedule.Teacher_ID,
            Teacher_data.Teacher.F_name as Teacher_F_name,
            Assignment.Class_Schedule.Day_name,
            Assignment.Class_Schedule.Start_time,
            Assignment.Class_Schedule.End_time
    FROM Assignment.Class_Schedule
    LEFT JOIN Assignment.Grade_level ON Assignment.Class_Schedule.Grade_level_ID = Assignment.Grade_level.Grade_level_ID
    LEFT JOIN Assignment.Subject ON Assignment.Class_Schedule.Subject_code = Assignment.Subject.Subject_code
    LEFT JOIN Teacher_data.Teacher ON Assignment.Class_Schedule.Teacher_ID = Teacher_data.Teacher.Teacher_ID
GO


-- view 7
-- formalized Report card from each student

GO
    CREATE VIEW Stud_data.Report_card AS
    SELECT  Stud_data.Transcript.Ac_year,
            Stud_data.Transcript.Stud_ID,
            Stud_data.Transcript.Grade_level_ID,
            Stud_data.Student.F_name,
            Stud_data.Student.L_name,
            Stud_data.Student.M_name,
            Stud_data.Student.Gender,
            Stud_data.Student.Age,
            Stud_data.Transcript.First_semester_avg,
            Stud_data.Transcript.Second_semester_avg,
            Stud_data.Transcript.Final_avg,
            Stud_data.Transcript.Conduct
    FROM Assignment.Stud_data.Transcript
    JOIN Stud_data.Student ON Stud_data.Transcript.Stud_ID = Stud_data.Student.Stud_ID
GO

SELECT * FROM Report_card