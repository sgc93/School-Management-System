Use Shumabo_secondary_school

-- list of Views

-- view 1
-- full information of Teachers

GO
    CREATE VIEW Teacher_data AS
    SELECT  Teacher_list.Teacher_ID,
            Teacher_list.F_name,
            Teacher_list.L_name,
            Teacher_list.M_name,
            Teacher_list.Gender,
            Teacher_list.Birth_date,
            Teacher_list.Degree_level,
            Teacher_list.Sub_city,
            Teacher_list.Kebele,
            Teacher_phone.Phone_number,
            Teacher_grade_level.Grade_level_ID,
            Teacher_Section_Subject.Section_code,
            Teacher_Section_Subject.Subject_code
    FROM Teacher_list

    LEFT JOIN Teacher_grade_level ON Teacher_list.Teacher_ID = Teacher_grade_level.Teacher_ID
    LEFT JOIN Teacher_Section_Subject ON Teacher_list.Teacher_ID = Teacher_Section_Subject.Teacher_ID
    LEFT JOIN Teacher_phone ON Teacher_list.Teacher_ID = Teacher_phone.Teacher_ID

GO

-- view 2
-- list of subjects and there Teachers

GO
    CREATE VIEW Subject_Teacher AS
    SELECT  Subject_list.Subject_code AS Subject_code,
            Subject_list.Subject_name AS Subject_name,
            Teacher_Section_Subject.Section_code AS Section_code,
            Subject_list.Grade_level_ID As Grade_level_Id,
            Teacher_Section_Subject.Teacher_ID AS Teacher_ID,
            Teacher_list.F_name AS Teacher_name
    FROM Subject_list
    LEFT JOIN Teacher_Section_Subject ON Subject_list.Subject_code = Teacher_Section_Subject.Subject_code
    LEFT JOIN Teacher_list ON Teacher_Section_Subject.Teacher_ID = Teacher_list.Teacher_ID
GO

-- view 3
-- Submitted roasters

GO
    CREATE VIEW Submittable_roaster AS
    SELECT  Roaster_list.Ac_year, 
            Roaster_list.Stud_ID, 
            Roaster_list.Grade_level_ID, 
            Roaster_list.Section_code, 
            Roaster_list.Subject_code, 
            (Roaster_list.Frist_sem_mid_exam_25 + Roaster_list.First_sem_quiz_10 + Roaster_list.First_sem_assignment_15 + Roaster_list.First_sem_final_exam_50) AS First_sem_Sum,
            (Roaster_list.Second_sem_mid_exam_25 + Roaster_list.Second_sem_quiz_10 + Roaster_list.Second_sem_assignment_15 + Roaster_list.Second_sem_final_exam_50) AS Second_sem_Sum
    FROM Roaster_list
GO

SELECT * FROM Submittable_roaster

-- view 4
-- Current status of Items

GO
    CREATE VIEW Current_Item_Status AS
    SELECT  All_items_list.ISer_no, 
            All_items_list.Item_name, 
            All_items_list.Item_type, 
            All_items_list.Unit_price,
            New_items_list.Recieving_date, 
            New_items_list.Added_quantity,
            (New_items_list.Added_quantity - All_items_list.Currejant_quantity) AS Withdrew_quantity,
            All_items_list.Current_quantity,
            All_items_list.Total_price
    FROM All_items_list
    LEFT JOIN New_items_list ON All_items_list.ISer_no = New_items_list.ISer_no
    LEFT JOIN Withdrawed_Items ON All_items_list.ISer_no = Withdrawed_Items.ISer_no;
GO

-- view 5
-- containing the full information of the grade_levels

GO
    CREATE VIEW  Grade_level_data AS
    SELECT  Roaster_list.Ac_year,
            Grade_level_list.Grade_level_ID,
            Grade_level_list.Grade_level_name,
            Section_list.Section_Code,
            Stud_data.Student.Stud_ID,
            Stud_data.Student.Gender
    FROM Roaster_list
    LEFT JOIN Grade_level_list ON Roaster_list.Grade_level_ID = Grade_level_list.Grade_level_ID
    LEFT JOIN Section_list ON Grade_level_list.Grade_level_ID = Section_list.Grade_level_ID
    LEFT JOIN Stud_data.Student ON Section_list.Section_code = Stud_data.Student.Section_code
GO

-- view 6 
-- store the detail information of class schedule for each section

GO
    CREATE VIEW Class_schedule_detail AS
    SELECT 
            Class_schedule.Schedule_ID,
            Class_schedule.Ac_year,
            Class_schedule.Section_code,
            Class_schedule.Grade_level_ID,
            Grade_level_list.Grade_level_name,
            Class_schedule.period_no,
            Class_schedule.Subject_code,
            Subject_list.Subject_name,
            Class_schedule.Teacher_ID,
            Teacher_list.F_name as Teacher_F_name,
            Class_schedule.Day_name,
            Class_schedule.Start_time,
            Class_schedule.End_time
    FROM Class_schedule
    LEFT JOIN Grade_level_list ON Class_schedule.Grade_level_ID = Grade_level_list.Grade_level_ID
    LEFT JOIN Subject_list ON Class_schedule.Subject_code = Subject_list.Subject_code
    LEFT JOIN Teacher_list ON Class_schedule.Teacher_ID = Teacher_list.Teacher_ID
GO

-- view 7
-- formalized Report card from each student

GO
    CREATE VIEW Report_card AS
    SELECT  Transcript.Ac_year,
            Transcript.Stud_ID,
            Transcript.Grade_level_ID,
            Stud_data.Student.F_name,
            Stud_data.Student.L_name,
            Stud_data.Student.M_name,
            Stud_data.Student.Gender,
            Stud_data.Student.Age,
            Transcript.First_semester_avg,
            Transcript.Second_semester_avg,
            Transcript.Final_avg,
            Transcript.Conduct
    FROM Transcript
    JOIN Stud_data.Student ON Transcript.Stud_ID = Stud_data.Student.Stud_ID
GO

SELECT * FROM Report_card