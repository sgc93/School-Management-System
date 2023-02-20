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
            Assignment.Teacher_section_subject.Section_code,
            Assignment.Teacher_section_subject.Subject_code
    FROM Teacher_list

    LEFT JOIN Teacher_grade_level ON Teacher_list.Teacher_ID = Teacher_grade_level.Teacher_ID
    LEFT JOIN Assignment.Teacher_section_subject ON Teacher_list.Teacher_ID = Assignment.Teacher_section_subject.Teacher_ID
    LEFT JOIN Teacher_phone ON Teacher_list.Teacher_ID = Teacher_phone.Teacher_ID

GO

-- view 2
-- list of subjects and there Teachers

GO
    CREATE VIEW Subject_Teacher AS
    SELECT  Subject_list.Subject_code AS Subject_code,
            Subject_list.Subject_name AS Subject_name,
            Assignment.Teacher_section_subject.Section_code AS Section_code,
            Subject_list.Grade_level_ID As Grade_level_Id,
            Assignment.Teacher_section_subject.Teacher_ID AS Teacher_ID,
            Teacher_list.F_name AS Teacher_name
    FROM Subject_list
    LEFT JOIN Assignment.Teacher_section_subject ON Subject_list.Subject_code = Assignment.Teacher_section_subject.Subject_code
    LEFT JOIN Teacher_list ON Assignment.Teacher_section_subject.Teacher_ID = Teacher_list.Teacher_ID
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
    SELECT  Resource.All_item.ISer_no, 
            Resource.All_item.Item_name, 
            Resource.All_item.Item_type, 
            Resource.All_item.Unit_price,
            Resource.New_item.Recieving_date, 
            Resource.New_item.Added_quantity,
            (Resource.New_item.Added_quantity - Resource.All_item.Currejant_quantity) AS Withdrew_quantity,
            Resource.All_item.Current_quantity,
            Resource.All_item.Total_price
    FROM Resource.All_item
    LEFT JOIN Resource.New_item ON Resource.All_item.ISer_no = Resource.New_item.ISer_no
    LEFT JOIN Withdrawed_Items ON Resource.All_item.ISer_no = Withdrawed_Items.ISer_no;
GO

-- view 5
-- containing the full information of the grade_levels

GO
    CREATE VIEW  Grade_level_data AS
    SELECT  Roaster_list.Ac_year,
            Assignment.Grade_level.Grade_level_ID,
            Assignment.Grade_level.Grade_level_name,
            Assignment.Section.Section_Code,
            Stud_data.Student.Stud_ID,
            Stud_data.Student.Gender
    FROM Roaster_list
    LEFT JOIN Assignment.Grade_level ON Roaster_list.Grade_level_ID = Assignment.Grade_level.Grade_level_ID
    LEFT JOIN Assignment.Section ON Assignment.Grade_level.Grade_level_ID = Assignment.Section.Grade_level_ID
    LEFT JOIN Stud_data.Student ON Assignment.Section.Section_code = Stud_data.Student.Section_code
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
            Assignment.Grade_level.Grade_level_name,
            Class_schedule.period_no,
            Class_schedule.Subject_code,
            Subject_list.Subject_name,
            Class_schedule.Teacher_ID,
            Teacher_list.F_name as Teacher_F_name,
            Class_schedule.Day_name,
            Class_schedule.Start_time,
            Class_schedule.End_time
    FROM Class_schedule
    LEFT JOIN Assignment.Grade_level ON Class_schedule.Grade_level_ID = Assignment.Grade_level.Grade_level_ID
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