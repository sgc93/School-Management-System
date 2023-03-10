USE Shumabo_secondary_school

-- Functionalities

-- Functionality 1: Add new Parent { with Stored procedure}
GO
  CREATE PROCEDURE Stud_data.Add_parent (
    @PID_no VARCHAR(15),
    @F_Name VARCHAR(50), 
    @L_Name VARCHAR(50),
    @M_Name VARCHAR(50),
    @Gender VARCHAR(10),
    @Birth_date DATE,
    @Relation VARCHAR(255),
    @Sub_city VARCHAR(255),
    @Kebele VARCHAR(255)
  )

  AS
  BEGIN 
    INSERT INTO Stud_data.Parent (PID_no, F_name, L_name, M_name, Gender, Birth_date, Relation, Sub_city, Kebele)
    VALUES (@PID_no, @F_Name, @L_Name, @M_name, @Gender, @Birth_date, @Relation, @Sub_city, @Kebele);
  END
GO

EXEC Stud_data.Add_parent 'BDR007', 'Chernet', 'Abegaz', 'Sewale', 'Male', '2000-01-01', 'Father', 'Gish Abay', 'Kebele 3';
EXEC Stud_data.Add_parent 'BDR008', 'Tsega', 'Abera', 'Wakene', 'Male', '1988-01-01', 'Father', 'Atse Tewodros', 'Kebele 3';

-- Functionality 2: Display data of specific parent

GO
  CREATE FUNCTION Get_parent (@PID_no VARCHAR(15))
  RETURNS TABLE
  AS
  RETURN 
  (
    SELECT *
    FROM Stud_data.Parent
    WHERE PID_no = @PID_no
  );
GO

SELECT * FROM dbo.Get_Parent('BDR007')

-- Functionality 3: Update specific Information of a specified Parent
GO
  CREATE PROCEDURE Stud_data.Update_parent (@PID_no VARCHAR(10), @Attribute_name NVARCHAR(50), @New_value sql_variant)
  AS
  BEGIN
    SET NOCOUNT ON;
    DECLARE @SQL NVARCHAR(MAX)

    SET @SQL = N'UPDATE Stud_data.Parent SET ' + @Attribute_name + ' = ' + '''' + CAST(@New_value AS NVARCHAR(MAX)) + '''' + ' WHERE PID_no = ' + '''' + @PID_no + ''''
    EXECUTE sp_executesql @SQL
  END
GO

-- Explaination
    /* In the above code, NVARCHAR(MAX) is used as the data type 
    for the input parameter @param_value in the stored procedure. 
    NVARCHAR(MAX) is a variable-length Unicode string data type 
    that can store up to 2^30-1 characters. 
    This data type is used to accommodate a wide range of values for
    the input parameter and handle updates for different data types.
    The purpose of using NVARCHAR(MAX) in the stored procedure 
    is to allow the input value to be passed as a string, 
    and then converted to the correct data type for the targeted
    column in the Stud_data.Parent table.

    sp_executesql is a system stored procedure in SQL Server that 
    is used to execute a dynamically constructed SQL statement or batch.
    The procedure takes parameters for the dynamic SQL string and any 
    parameters that need to be passed to the dynamic statement, and 
    returns the result set of the executed statement. This is useful in 
    situations where the exact SQL statement to be executed is not known 
    at design time, or when the statement needs to be constructed based on 
    user input or other dynamic data.

    The SQL_VARIANT data type is a special data type in SQL Server that 
    can store values of different data types, including:-
     - Numeric data types (int, float, decimal, etc.)
     - Character strings (char, varchar, nchar, nvarchar)
     - Binary data (binary, varbinary)
     - Date and time (date, time, datetime, datetime2, datetimeoffset)
    The purpose of using the SQL_VARIANT data type is to provide a flexible
    data type that can store multiple data types in a single column or variable.
    This allows for more efficient storage and manipulation of data, as well as 
    more flexible querying and reporting. However, it is important to note that 
    the SQL_VARIANT data type also has some limitations, such as less efficient 
    data storage and lower performance compared to using specific data types.
    */
    
EXEC Stud_data.Update_parent 'BDR007', 'Sub_city', 'Shumabo'
EXEC Stud_data.Update_parent 'BDR001', 'Birth_date', '1981-01-01'
EXEC Stud_data.Update_parent 'BDR001', 'PID_no', 'BDR000'  -- cannot update the PID_no of any parent since its concerns with referential integrity.

-- Functionality 4: Register new student

GO
  CREATE PROCEDURE Stud_data.Add_new_student (
    @Ac_Year INT,
    @Registration_data DATE,
    @Stud_ID VARCHAR(10),
    @F_Name VARCHAR(50), 
    @L_Name VARCHAR(50),
    @M_Name VARCHAR(50),
    @Gender VARCHAR(6),
    @Birth_date DATE,
    @Sub_city VARCHAR(50),
    @Kebele VARCHAR(50),
    @PID_no VARCHAR(15)
  )
  AS
  BEGIN
    INSERT INTO Stud_data.New_Student (Ac_year, Registration_date, Stud_ID, F_name, L_name, M_name, Gender, Birth_date, Sub_city, Kebele, PID_no)
    VALUES(@Ac_Year, @Registration_data, @Stud_ID, @F_Name, @L_Name, @M_name, @Gender, @Birth_date, @Sub_city, @Kebele, @PID_no);
  END
GO

EXEC Stud_data.Add_new_student 2023, '2023-08-03', 'ST0008', 'Alemayehu', 'Chernet', 'Abegaz', 'Male', '2000-01-01', 'Shumabo', 'Kebele 3', 'BDR007' ;
EXEC Stud_data.Add_new_student 2023, '2023-08-03', 'ST0009', 'Chaltu', 'Tsega', 'Abera', 'female', '2000-02-03', 'Atse Tewodros', 'Kebele 3', 'BDR008' ;

-- Functionality 5: Update a specified information of specified student

GO
  CREATE PROCEDURE Stud_data.Update_Student (@Stud_ID VARCHAR(15), @Attribute_name NVARCHAR(50), @New_value sql_variant)
  AS
  BEGIN
    SET NOCOUNT ON;
    DECLARE @SQL NVARCHAR(MAX)

    SET @SQL = N'UPDATE Stud_data.Student SET ' + @Attribute_name + ' = ' + '''' + CAST(@New_value AS NVARCHAR(MAX)) + '''' + ' WHERE Stud_ID = ' + '''' + @Stud_ID + ''''
    EXECUTE sp_executesql @SQL
  END
GO

EXEC Stud_data.Update_Student 'ST0009', 'Grade_level_Id', 'GID11'
EXEC Stud_data.Update_Student 'ST0009', 'Section_code', '11A'

-- Functionality 6: Display a specified Student information // with stored procedure
-- without phone number
GO
  CREATE PROCEDURE Display_student (@Stud_ID VARCHAR(10))
  AS
  BEGIN
    SELECT *
    FROM Stud_data.Student
    WHERE Stud_ID = @Stud_ID
  END
GO

-- with phone number
GO
 CREATE PROCEDURE show_Student (@Stud_ID VARCHAR(10))
 AS
 BEGIN
  SELECT 
    s.Stud_ID, 
    s.F_name, 
    s.L_name, 
    s.M_name, 
    s.Gender, 
    s.Birth_date, 
    s.Sub_city, 
    s.Kebele, 
    s.PID_no, 
    s.Grade_level_ID, 
    s.Section_code,
    sp.phone_number
  FROM 
    Stud_data.Student s 
  INNER JOIN 
    Stud_data.Student_phone sp ON s.Stud_ID = sp.Stud_ID
  WHERE 
    s.Stud_ID = @Stud_ID
 END
GO

EXEC show_Student 'ST00001'  -- With there phone number
EXEC Display_student 'ST0008'  -- without phone number

Select * FROM Stud_data.Student_phone
-- Functionality 7: Add new subject

GO
  CREATE PROCEDURE Assignment.Add_Subject (@Subject_code VARCHAR(6), @Subject_name VARCHAR(50), @Grade_level_ID VARCHAR(6))
  AS
  BEGIN
    INSERT INTO Assignment.Subject (Subject_code, Subject_name, Grade_level_ID)
    VALUES (@Subject_code, @Subject_name, @Grade_level_ID);
  END
GO

EXEC Assignment.Add_Subject 'STD11', 'Technical Drawing', 'GID11'

-- functionlity 8: display data about specific subject

GO
  CREATE PROCEDURE Get_Subject (@Subject_code VARCHAR(6))
  AS
  BEGIN
    SELECT * FROM
    Assignment.Subject_Teacher where Subject_code = @Subject_code
  END
GO

EXEC Get_Subject 'STD11'

-- Fun tionality 9: Update specific information of specific Subject

GO
  CREATE PROCEDURE Assignment.Update_Subject (@Subject_code VARCHAR(6), @Attribute_name NVARCHAR(50), @New_value sql_variant)
  AS
  BEGIN
    SET NOCOUNT ON;
    DECLARE @SQL NVARCHAR(MAX)

    SET @SQL = N'UPDATE Assignment.Subject SET ' + @Attribute_name + ' = ' + '''' + CAST(@New_value AS NVARCHAR(MAX)) + '''' + ' WHERE Subject_code = ' + '''' + @Subject_code + ''''
    EXECUTE sp_executesql @SQL
  END
GO

EXEC Assignment.Update_Subject 'STD11', 'Subject_name', 'Drawing'

-- Functionlity 10: Delete/remove a specific Subject from the list

GO
  CREATE PROCEDURE Assignment.Delete_Subject (@Subject_code VARCHAR(6))
  AS
  BEGIN
    DELETE FROM Assignment.Subject 
    WHERE Subject_code = @Subject_code;
  END
GO

EXEC Assignment.Delete_Subject 'STD11'

select * from Assignment.Subject

-- functionality 11: Add student result 
GO
  CREATE PROCEDURE Stud_data.Add_Roaster(
    @Ac_year FLOAT,
    @Stud_ID VARCHAR(10),
    @Grade_level_ID VARCHAR(6),
    @Section_code VARCHAR(6),
    @Subject_code VARCHAR(6),
    @Frist_sem_mid_exam_25 FLOAT,
    @First_sem_quiz_10 FLOAT,
    @First_sem_assignment_15 FLOAT,
    @First_sem_final_exam_50 FLOAT,
    @Second_sem_mid_exam_25 FLOAT,
    @Second_sem_quiz_10 FLOAT,
    @Second_sem_assignment_15 FLOAT,
    @Second_sem_final_exam_50 FLOAT )
  AS
  BEGIN
  if (@Frist_sem_mid_exam_25 > 25)
    BEGIN
      RA
    END
    INSERT INTO Stud_data.Roaster(Ac_year, Stud_ID, Grade_level_ID, Section_code, Subject_code, Frist_sem_mid_exam_25, First_sem_quiz_10, First_sem_assignment_15, First_sem_final_exam_50, Second_sem_mid_exam_25, Second_sem_quiz_10, Second_sem_assignment_15, Second_sem_final_exam_50 )
    VALUES (@Ac_year, @Stud_ID, @Grade_level_ID, @Section_code, @Subject_code, @Frist_sem_mid_exam_25, @First_sem_quiz_10, @First_sem_assignment_15, @First_sem_final_exam_50, @Second_sem_mid_exam_25, @Second_sem_quiz_10, @Second_sem_assignment_15, @Second_sem_final_exam_50)
  END
GO

EXEC Stud_data.Add_Roaster '2023','ST00004', 'GID10', '10A', 'SA10', 24, 10, 15, 44, 23, 9, 13, 50

-- functionality 12: display specific student's result

GO
    CREATE PROCEDURE Display_Roaster(@Stud_ID VARCHAR(10), @Ac_year INT)
    AS
    BEGIN
        SELECT * FROM Stud_data.Roaster
        WHERE Stud_ID = @Stud_ID AND Ac_year = @Ac_year
    END
GO

EXEC Display_Roaster 'ST00004', 2023

-- Functionlity 13: update specific information of specific student

GO
    CREATE PROCEDURE Stud_data.Update_Roaster (@Ac_year INT, @Stud_ID VARCHAR(10), @Subject_code VARCHAR(6), @attribute_name NVARCHAR(MAX), @New_value SQL_VARIANT)
    AS
    BEGIN
        DECLARE @SQL NVARCHAR(MAX)
        
        SET @SQL = N'UPDATE Stud_data.Roaster 
            SET ' + @attribute_name + ' = ' + CAST(@New_value AS NVARCHAR(MAX)) + '
            WHERE Ac_year = ' + CAST(@Ac_year AS NVARCHAR(10)) + '
            AND Stud_ID = ''' + @Stud_ID + '''
            AND Subject_code = ''' + @Subject_code + ''''

        EXEC sp_executesql @SQL
    END
GO

EXEC Stud_data.Update_Roaster 2022,'ST00006' , 'SCH11', 'Frist_sem_mid_exam_25', 24

-- Functionality 14: generating a Transcript for all students

GO
  CREATE PROCEDURE Stud_data.Generate_Transcript (@Stud_ID VARCHAR(15), @Ac_Year INT, @Conduct CHAR(1))
  AS
  BEGIN
    DECLARE @Grade_level_ID VARCHAR(6),
            @Section_code VARCHAR(6),
            @First_semester_total FLOAT,
            @Second_semester_total FLOAT,
            @First_semester_avg FLOAT,
            @Second_semester_avg FLOAT,
            @Final_avg FLOAT,
            @Number_of_Subjects INT

    SET @Grade_level_ID = (SELECT TOP 1 @Grade_level_ID FROM Stud_data.Submittable_roaster WHERE Stud_ID = @Stud_ID AND Ac_year = @Ac_Year)
    SET @Section_code = (SELECT TOP 1 @Section_code FROM Stud_data.Submittable_roaster WHERE Stud_ID = @Stud_ID AND Ac_year = @Ac_Year)
    SET @First_semester_total = (SELECT SUM(First_sem_sum) From Stud_data.Submittable_roaster WHERE Stud_ID = @Stud_ID AND Ac_year = @Ac_Year)
    SET @Second_semester_total = (SELECT SUM(Second_sem_sum) From Stud_data.Submittable_roaster WHERE Stud_ID = @Stud_ID AND Ac_year = @Ac_Year)
    SET @Number_of_Subjects = (select COUNT(Subject_code) From Stud_data.Submittable_roaster WHERE Stud_ID = @Stud_ID AND Ac_year = @Ac_Year)
    SET @First_semester_avg = ((@First_semester_total/ @Number_of_Subjects))
    SET @Second_semester_avg = ((@Second_semester_total/ @Number_of_Subjects))
    SET @Final_avg = (@First_semester_avg + @Second_semester_avg) / 2;
    INSERT INTO Stud_data.Transcript (Ac_Year, Stud_ID, Grade_level_ID, Section_Code,First_semester_total, Second_semester_total, First_semester_avg, Second_semester_avg, Final_avg, Conduct) 
    VALUES (@Ac_Year, @Stud_ID, @Grade_level_ID, @Section_code, @First_semester_total, @Second_semester_total, @First_semester_avg, @Second_semester_total, @Final_avg, @Conduct)
    select * from  Stud_data.Transcript
  END
GO

EXEC Stud_data.Generate_Transcript 'ST00001', '2022', 'A'
EXEC Stud_data.Generate_Transcript 'ST00004', '2023', 'A'

-- Functionality 15: updating the Transcript of a specific student when there is a change  of his/her in the roaster_list

GO
  CREATE PROCEDURE Stud_data.Update_Transcript (@Stud_ID VARCHAR(15), @Ac_year INT, @attribute_name NVARCHAR(50), @New_value SQL_VARIANT)
  AS
  BEGIN
      SET NOCOUNT ON;
      DECLARE @SQL NVARCHAR(MAX)

      SET @SQL =  N'UPDATE Stud_data.Transcript 
                  SET ' + @attribute_name + ' = ' + CAST(@New_value AS NVARCHAR(MAX)) + '
                  WHERE Ac_year = ' + CAST(@Ac_year AS NVARCHAR(10)) + '
                  AND Stud_ID = ''' + @Stud_ID + ''''
      EXECUTE sp_executesql @SQL

      SELECT * FROM Stud_data.Transcript WHERE Stud_ID  = @Stud_ID AND Ac_Year = @Ac_Year
  END
GO

EXEC Stud_data.Update_Transcript '','',''

-- Functionality 16: display the Transcript of a specific Student

GO
    CREATE FUNCTION Stud_data.Display_Transcript(@Stud_ID VARCHAR(10), @Ac_year INT)
    RETURNS TABLE
    AS
    RETURN (
      SELECT * FROM Stud_data.Transcript
        WHERE Stud_ID = @Stud_ID AND Ac_year = @Ac_year
    )
GO

SELECT * FROM Stud_data.Display_Transcript('ST00001', '2022')

-- Functionality 17: create the transform form for specific student

GO
  CREATE PROCEDURE Stud_data.ADD_Transform_form( 
    @TSer_no VARCHAR(10),
    @Stud_ID varchar(10), 
    @Grade_level_ID VARCHAR(6), 
    @Section_code VARCHAR(6), 
    @Reason TEXT, 
    @Application_date DATE, 
    @Target_school_name VARCHAR(100))

  AS
  BEGIN
    INSERT INTO Stud_data.Transform_form(TSer_no, Stud_ID, Grade_level_ID, Section_code , Reason, Application_date, Target_school_name)
    VALUES (@TSer_no, @Stud_ID, @Grade_level_ID , @Section_code, @Reason, @Application_date, @Target_school_name)
  END
GO

EXEC Stud_data.ADD_Transform_form 'TF1234', 'ST00001', 'GID11', '11A', 'Changing address', '2023-03-04', 'Belay Zeleke Secondary school'

-- functionlity 18: display/provide the transform form of specific studnet

GO
  CREATE PROCEDURE Stud_data.Dispaly_Transform_form ( @Stud_ID VARCHAR(10))
  AS
  BEGIN
    SELECT * FROM Stud_data.Transform_form
    WHERE Stud_ID = @Stud_ID
  END
GO

EXEC Stud_data.Dispaly_Transform_form 'ST00001'

-- Functionality 19: Add Teacher { with Stored procedure}
GO
  CREATE PROCEDURE Teacher_data.Add_Teacher (
    @Teacher_ID VARCHAR(15),
    @F_Name VARCHAR(50), 
    @L_Name VARCHAR(50),
    @M_Name VARCHAR(50),
    @Gender VARCHAR(10),
    @Birth_date DATE,
    @Degree_level VARCHAR(255),
    @Sub_city VARCHAR(255),
    @Kebele VARCHAR(255)
  )

  AS
  BEGIN 
    INSERT INTO Teacher_data.Teacher (Teacher_ID, F_name, L_name, M_name, Gender, Birth_date, Degree_level, Sub_city, Kebele)
    VALUES (@Teacher_ID, @F_Name, @L_Name, @M_name, @Gender, @Birth_date, @Degree_level, @Sub_city, @Kebele);
  END
GO

EXEC Teacher_data.Add_Teacher 'T007', 'Bewketu', 'Sewmehon', 'gash Takele', 'Male', '1980-01-01', 'Master', 'Gish Abay', 'Kebele 3';

-- Functionality 20: Display a specific teacher's information with Table valued function

GO
  CREATE FUNCTION Get_Teacher (@Teacher_ID VARCHAR(15))
  RETURNS TABLE
  AS
  RETURN 
  (
    SELECT *
    FROM Teacher_data.Teacher
    WHERE Teacher_ID = @Teacher_ID
  );
GO

SELECT * FROM dbo.Get_Teacher('T007')

-- Functionality 21: Update specific Information of a specified Teacher
GO
  CREATE PROCEDURE Teacher_data.Update_Teacher (@Teacher_ID VARCHAR(10), @Attribute_name NVARCHAR(50), @New_value sql_variant)
  AS
  BEGIN
    SET NOCOUNT ON;
    DECLARE @SQL NVARCHAR(MAX)

    SET @SQL = N'UPDATE Teacher_data.Teacher SET ' + @Attribute_name + ' = ' + '''' + CAST(@New_value AS NVARCHAR(MAX)) + '''' + ' WHERE Teacher_ID = ' + '''' + @Teacher_ID + ''''
    EXECUTE sp_executesql @SQL
  END
GO

EXEC Teacher_data.Update_Teacher 'T007', 'M_name', 'Takele'

-- Assigning teachers to specific Grade level , displaying the assignment and updating the assignment
-- Functionlity 22: Assignign a particular teacher to specific Grade_level
GO
  CREATE PROCEDURE Assignment.Assign_Teacher_to_Grade (@Teacher_ID VARCHAR(10), @Grade_Level_ID VARCHAR(6))
  AS
  BEGIN
    INSERT INTO Assignment.Teacher_Grade_Level(Teacher_ID, Grade_level_ID)
    VALUES (@Teacher_ID, @Grade_Level_ID)
  END
GO

EXEC Assign_Teacher 'T007', 'GID10' 

-- functionality 23: Displaying

GO
  CREATE FUNCTION Display_Assigne_Teacher (@Teacher_ID VARCHAR(15))
  RETURNS TABLE
  AS
  RETURN (
    SELECT * FROM Assignment.Teacher_Grade_Level
    WHERE Teacher_ID = @Teacher_ID
  )
GO

select * from dbo.Display_Assigne_Teacher ('T007')

-- Functionality 24: Updating assignment of teachers to the grade level

GO
  CREATE PROCEDURE Assignment.Update_Grade_Assignment(@Teacher_ID VARCHAR(10), @New_Grade_level_ID VARCHAR(10))
  AS
  BEGIN
    UPDATE Assignment.Teacher_Grade_Level
    SET Grade_level_ID = @New_Grade_level_ID
    WHERE Teacher_ID = @Teacher_ID

    PRINT 'You Update an Information Successfully!'
  END
GO

EXEC Assignment.Update_Grade_Assignment 'T007', 'GID10'


-- Assigning teachers to specific Section and subject
-- functionality 25: Assigning a teacher to a Section and subject

GO
  CREATE PROCEDURE Assignment.Assign_Teacher_to_Sec_Sub (@Teacher_ID VARCHAR(10), @Section_code VARCHAR(6), @Subject_code VARCHAR(6))
  AS
  BEGIN
    INSERT INTO  Assignment.Teacher_Section_Subject(Teacher_ID, Section_code, Subject_code)
    VALUES (@Teacher_ID, @Section_code, @Subject_code)
  END
GO

EXEC Assignment.Assign_Teacher_to_Sec_Sub 'T007', '10A', 'SA10'

-- functionality 26: Displaying

GO
  CREATE FUNCTION Display_Assigned_Teacher_to_Sec_Sub (@Teacher_ID VARCHAR(15))
  RETURNS TABLE
  AS
  RETURN (
    SELECT * FROM 
    WHERE Teacher_ID = @Teacher_ID
  )
GO

select * from dbo.Display_Assigned_Teacher_to_Sec_Sub ('T007')

-- Functionality 27: Updating assignment of teachers to the grade level

GO
  CREATE PROCEDURE Assignment.Update_Sec_Sub_Assignment (@Teacher_ID VARCHAR(10), @Attribute_name NVARCHAR(50), @New_value sql_variant)
  AS
  BEGIN
    SET NOCOUNT ON;
    DECLARE @SQL NVARCHAR(MAX)

    SET @SQL = N'UPDATE Assignment.Teacher_Section_subject SET ' + @Attribute_name + ' = ' + '''' + CAST(@New_value AS NVARCHAR(MAX)) + '''' + ' WHERE Teacher_ID = ' + '''' + @Teacher_ID + ''''
    EXECUTE sp_executesql @SQL
    PRINT 'You Update an Information Successfully!'
  END
GO


EXEC Assignment.Update_Sec_Sub_Assignment 'T007', 'Subject_code', 'SE10'


-- creating, displaying, updating and Deleting an Academic Calendar
-- functionality 28: Creating an academic Calendar

GO
  CREATE PROCEDURE Shumabo.Add_Calendar (@Calendar_ID VARCHAR(6), @Ac_Year INT, @Activity_name VARCHAR(255), @Activity_description TEXT, @Activity_start_date DATE, @Activity_end_date DATE, @Comment TEXT)
  AS
  BEGIN
    SET NOCOUNT ON;

    INSERT INTO Shumabo.Academic_Calendar (Calendar_ID, Ac_Year, Activity_name, Activity_description, Activity_start_date, Activity_end_date, Comment)
    VALUES (@Calendar_ID, @Ac_Year, @Activity_name, @Activity_description, @Activity_start_date, @Activity_end_date, @Comment)
  END
GO

EXEC shumabo.Add_Calendar 'Cal2023', '2023', 'Semester Break', 'since we all have ...', '2023-02-20', '2023-03-04', 'no more than 14 days'
EXEC Shumabo.Add_Calendar 'C2023b', '2023', 'Studnets Movement', 'this will be the movement of ...', '2023-02-20', '2023-02-21', 'teacheing learning process will be cloase for only 1 day'

-- functionality 29: Updating a created calendar

GO
  CREATE PROCEDURE Shumabo.Update_Calendar (@Calendar_ID VARCHAR(6), @Attribute_name NVARCHAR(50), @New_value sql_variant)
  AS
  BEGIN
    SET NOCOUNT ON;
    
    DECLARE @SQL NVARCHAR(MAX)

    SET @SQL = N'UPDATE Shumabo.Academic_calendar SET ' + @Attribute_name + ' = ' + '''' + CAST(@New_value AS NVARCHAR(MAX)) + '''' + ' WHERE Calendar_ID = ' + '''' + @Calendar_ID + ''''
    EXECUTE sp_executesql @SQL
  END
GO

EXEC Shumabo.Update_Calendar 'Cal202', 'Ac_Year', '2020'

-- Functionality 30: display the details of specific Activity in the calendar 

GO
  CREATE FUNCTION Get_Activity (@Calendar_ID VARCHAR(6))
  RETURNS TABLE
  AS
  RETURN
  (
    SELECT * FROM Shumabo.Academic_Calendar
    WHERE Calendar_ID = @Calendar_ID
  )
GO

SELECT * FROM dbo.Get_Activity('Cal202')

-- Functionality 31: display the all activities and thir details which are planned for specific year

GO
  CREATE FUNCTION Get_Yearly_Calendar (@Ac_Year INT)
  RETURNS TABLE
  AS
  RETURN
  (
    SELECT * FROM Shumabo.Academic_Calendar
    WHERE Ac_Year = @Ac_Year
  )
GO

SELECT * FROM dbo.Get_Yearly_Calendar('2023')
SELECT * FROM dbo.Get_Yearly_Calendar('2020')

-- Functionlity 32: Removing a certain year calender from the Calendar list

GO
  CREATE PROCEDURE Shumabo.Delete_Yearly_Calendar (@Ac_Year INT)
  AS
  BEGIN
    SET NOCOUNT ON;
    
    DELETE FROM Shumabo.Academic_Calendar WHERE Ac_Year = @Ac_Year

    PRINT 'You have Removed Calendar of  one year'
  END
GO

EXEC Shumabo.Delete_Yearly_Calendar '2020'

-- Manipulating the Staff members 
-- Functionlity 33: Add Data of new staff members like director, Record_Officer, ...

GO
  CREATE PROCEDURE Staff_data.Add_New_Staff(
  @Staff_ID VARCHAR(10),
  @F_name VARCHAR(50),
  @L_name VARCHAR(50),
  @M_name VARCHAR(50),
  @Gender VARCHAR(8),
  @Birth_date DATE,
  @Degree_level VARCHAR(50),
  @Staff_role VARCHAR(50),
  @Sub_city VARCHAR(50),
  @Kebele VARCHAR(50))
  AS
  BEGIN
    INSERT INTO Staff(Staff_ID, F_name, L_name, M_name, Gender, Birth_date, Degree_level, Staff_role, Sub_city, Kebele)
    VALUES (@Staff_ID, @F_name, @L_name, @M_name, @Gender, @Birth_date, @Degree_level, @Staff_role, @Sub_city, @Kebele)
    PRINT 'You have added new Staff member Successfully.'
  END
GO

EXEC Staff_data.Add_New_Staff 'STA002','R-memihr', 'Mesafint', 'Tefera','Male', '1980-04-12', 'Master', 'Director', 'Gish Abay', 'Kebele 5'

-- Functionality 34: Display the Data of specific Staff member

GO
  CREATE FUNCTION Get_Staff (@Staff_ID VARCHAR(10))
  RETURNS TABLE
  AS
    RETURN (
      SELECT * FROM Staff 
      WHERE Staff_ID = @Staff_ID
    )
GO

SELECT * FROM dbo.Get_Staff ('STA002')

-- Functionality 35: Update the specific data of a specific Staff member

GO
  CREATE PROCEDURE Staff_data.Update_staff (@Staff_ID VARCHAR(10), @Attribute_name NVARCHAR(50), @New_value sql_variant)
  AS
  BEGIN
    SET NOCOUNT ON;    
    DECLARE @SQL NVARCHAR(MAX)

    SET @SQL = N'UPDATE Staff_data.Staff SET ' + @Attribute_name + ' = ' + '''' + CAST(@New_value AS NVARCHAR(MAX)) + '''' + ' WHERE Staff_ID = ' + '''' + @Staff_ID + ''''
    EXECUTE sp_executesql @SQL
    PRINT 'You have updated the data successfully, and the data of the Update Staff is:-'
    SELECT * FROM Staff_data.Staff WHERE Staff_ID = @Staff_ID
  END
GO

EXEC Staff_data.Update_staff 'STA002', 'F_name', 'Director'

-- Functionality 36: Add new Items

GO
  CREATE PROCEDURE Resourse.Add_Item(@ISer_no VARCHAR(8), @Item_name VARCHAR(50), @Item_type varchar(50), @Unit_price FLOAT, @Total_price FLOAT, @Recieving_date Date, @Added_quantity INT, @Item_resource TEXT, @Comment TEXT)
  AS
  BEGIN
    INSERT INTO Resource.New_item
    VALUES (@ISer_no, @Item_name, @Item_type, @Unit_price, @Total_price, @Recieving_date, @Added_quantity, @Item_resource, @Comment)
    PRINT 'You have added new item.'
    INSERT INTO Resource.All_item 
    VALUES (@ISer_no, @Item_name, @Item_type, @Unit_price, @Total_price, @Added_quantity)
  END
GO

EXEC Resource.Add_Item 'IT1111', 'Grade 10 Amharic text Book', 'Alaki', '40.50', '4050', '2023-03-02', '100', 'gift from BDU University', 'No Maney is invested'
EXEC Resource.Add_Item 'IT1113', 'Board Cleaner', 'Alaki', '15', '1500', '2023-05-02', '100', 'Bought', 'Maney is from the yearly collested fee'


-- Functionality 37:  Update the data of the available Item in the store

GO
  CREATE PROCEDURE Resource.Update_Item (@ISer_no VARCHAR(8), @Attribute_name NVARCHAR(50), @New_value sql_variant)
  AS
  BEGIN
    SET NOCOUNT ON;
    
    DECLARE @SQL NVARCHAR(MAX)
    DECLARE @SQLB NVARCHAR(Max)

    SET @SQL = N'UPDATE Resource.New_item SET ' + @Attribute_name + ' = ' + '''' + CAST(@New_value AS NVARCHAR(MAX)) + '''' + ' WHERE ISer_no = ' + '''' + @ISer_no + ''''
    EXECUTE sp_executesql @SQL
    PRINT 'You have updated the data successfully, and the data of the Update Staff is:-'
    SELECT * FROM Resource.New_item WHERE ISer_no = @ISer_no

    IF (@Attribute_name = 'Item_name' OR @Attribute_name = 'Item_type' OR @Attribute_name = 'Unit_price' OR @Attribute_name = 'Total_price' OR @attribute_name = 'Added_quantity')
    BEGIN
      SET @SQLB = N'UPDATE Resource.All_item SET ' + @Attribute_name + ' = ' + '''' + CAST(@New_value AS NVARCHAR(MAX)) + '''' + ' WHERE ISer_no = ' + '''' + @ISer_no + ''''
      EXECUTE sp_executesql @SQLB
    END
  END
GO

DROP PROCEDURE Resource.Update_Item
EXEC Resource.Update_Item 'IT1111', 'Item_type', 'I_Alaki'
EXEC Resource.Update_Item 'I20231', 'Item_type', 'I_Alaki'
exec Resource.Update_Item 'I20231', 'Item_name', 'Grade 11 English text book.'
EXEC Resource.Update_Item 'I20231', 'ISer_no', 'IT1112'  --updates the Serial no of the Item



-- Manipullating table withdrawed Itmes list
-- Functionlity 38: withdrowing items

GO
  CREATE PROCEDURE Resource.Withdraw_Item(@ISer_no VARCHAR(8), @withdrawing_date Date, @Withdrawed_quantity INT, @Withdrawing_reason TEXT, @Withdrawer_name VARCHAR(100))
  AS
  BEGIN
    INSERT INTO Resource.Withdrew_item
    VALUES (@ISer_no, @Withdrawing_date, @Withdrawed_quantity, @Withdrawing_reason, @Withdrawer_name)
    PRINT 'You have Withdrawed an item.'
    -- update the available amount
    UPDATE Resource.All_item
    SET Current_quantity = Current_quantity - @Withdrawed_quantity where ISer_no = @ISer_no
    -- update the total price of the available amount
    UPDATE Resource.All_item 
    SET Total_price = Unit_price * Current_quantity WHERE ISer_no = @ISer_no
  END
GO


EXEC Resource.Withdraw_Item 'IT1113', '2023-02-02', 13, 'Class room Education', 'Tr. chernet'
EXEC Resource.Withdraw_Item 'IT1111', '2022-02-02', 2, 'losting the priviously given one', 'St. Jemila smachew'

-- Functinality 39: display the withdrawing Items in specific year, month, week or days 

GO
  CREATE FUNCTION Get_Withdrawed_Item (@Date_one DATE, @Date_two DATE)
  RETURNS TABLE
  AS
  RETURN (
    SELECT * FROM Resource.Withdrew_item
    WHERE Withdrawing_date BETWEEN @Date_one AND  @Date_two  
  )
GO

SELECT * FROM dbo.Get_Withdrawed_Item('2022-01-01', '2022-12-30')

-- Manipulating all available items in All_Item
-- Functinality 40: display the Current status of an Item 

GO
  CREATE FUNCTION Resource.Get_Item (@ISer_no VARCHAR(10))
  RETURNS TABLE
  AS
  RETURN (
    SELECT * FROM Resource.Current_Item_Status
    WHERE ISer_no = @ISer_no  
  )
GO

SELECT * FROM Resource.Get_Item('IT1111')

-- Generating, displaying and updating yearly Progress reports
-- Functionality 41: generating progress level
GO
  CREATE PROCEDURE Shumabo.Generate_Progress_report (@Ac_Year INT, @Grade_level_ID VARCHAR(6))
  AS
  BEGIN
    DECLARE @Number_of_section INT, 
            @Number_of_student INT,
            @Number_of_male_stud INT,
            @Number_of_female_stud INT,
            @Number_of_passed_stud INT,
            @Number_of_failed_stud INT,
            @Passed_stud_percentage FLOAT,
            @Number_of_passed_male_stud int,
            @Passed_male_percentage FLOAT,
            @Number_of_passed_female_stud INT,
            @Passed_female_percentage FLOAT,
            @Failed_stud_percentage FLOAT,
            @Number_of_failed_female_stud INT, 
            @Number_of_failed_male_stud int,
            @Failed_male_percentage FLOAT,
            @Failed_female_percentage FLOAT,
            @Max_avg FLOAT,
            @Min_avg FLOAT,
            @Avg_range FLOAT

      SET @Number_of_section = (SELECT COUNT(DISTINCT Section_code) FROM Grade_level_data WHERE Grade_level_ID = @Grade_level_ID AND Ac_year = @Ac_year )
      SET @Number_of_student = (SELECT COUNT(DISTINCT Stud_ID) FROM Grade_level_data WHERE Grade_level_ID = @Grade_level_ID AND Ac_year = @Ac_year )
      SET @Number_of_male_stud = (SELECT COUNT(DISTINCT Stud_ID) FROM Grade_level_data WHERE Grade_level_data.Gender = 'male' AND Grade_level_data.Grade_level_ID = @Grade_level_ID AND Grade_level_data.Ac_year = @Ac_year )
      SET @Number_of_female_stud = (@Number_of_student - @Number_of_male_stud)
      SET @Number_of_passed_stud = (SELECT COUNT(Stud_status) FROM Stud_data.Pass_fail_student WHERE Stud_status = 'passed' AND Stud_data.Pass_fail_student.Grade_level_ID = @Grade_level_ID AND Stud_data.Pass_fail_student.Ac_year = @Ac_Year)
      SET @Number_of_failed_stud = (SELECT COUNT(Stud_status) FROM Stud_data.Pass_fail_student WHERE Stud_status = 'failed' AND Stud_data.Pass_fail_student.Grade_level_ID = @Grade_level_ID AND Stud_data.Pass_fail_student.Ac_year = @Ac_Year)
      SET @Passed_stud_percentage = (@Number_of_passed_stud / (@Number_of_passed_stud + @number_of_failed_stud)) * 100
      SET @Number_of_passed_male_stud = (SELECT COUNT(Stud_status) FROM Stud_data.Pass_fail_student WHERE Stud_status = 'passed' AND Gender = 'male' AND Stud_data.Pass_fail_student.Grade_level_ID = @Grade_level_ID AND Stud_data.Pass_fail_student.Ac_year = @Ac_Year)
      SET @Passed_male_percentage = (@Number_of_passed_male_stud / (@Number_of_passed_male_stud + @Number_of_passed_female_stud)) * 100
      SET @Number_of_passed_female_stud = (SELECT COUNT(Stud_status) FROM Stud_data.Pass_fail_student WHERE Stud_status = 'passed' AND Gender = 'female' AND Stud_data.Pass_fail_student.Grade_level_ID = @Grade_level_ID AND Stud_data.Pass_fail_student.Ac_year = @Ac_Year)
      SET @Passed_female_percentage = (@Number_of_passed_female_stud / (@Number_of_passed_female_stud + @Number_of_passed_female_stud)) * 100
      SET @Failed_stud_percentage = (@Number_of_passed_stud / (@Number_of_passed_stud + @number_of_failed_stud)) * 100
      SET @Number_of_failed_male_stud = (SELECT COUNT(Stud_status) FROM Stud_data.Pass_fail_student WHERE Stud_status = 'failed' AND Gender = 'male' AND Stud_data.Pass_fail_student.Grade_level_ID = @Grade_level_ID AND Stud_data.Pass_fail_student.Ac_year = @Ac_Year)
      SET @Failed_male_percentage = (@Number_of_failed_male_stud / (@Number_of_failed_male_stud + @Number_of_failed_female_stud)) * 100
      SET @Number_of_failed_female_stud = (SELECT COUNT(Stud_status) FROM Stud_data.Pass_fail_student WHERE Stud_status = 'failed' AND Gender = 'female' AND Stud_data.Pass_fail_student.Grade_level_ID = @Grade_level_ID AND Stud_data.Pass_fail_student.Ac_year = @Ac_Year)
      SET @Failed_female_percentage = (@Number_of_passed_female_stud / (@Number_of_passed_female_stud + @Number_of_passed_female_stud)) * 100
      SET @Max_avg = (SELECT MAX(Final_avg) FROM Transcript WHERE Grade_level_ID = @Grade_level_ID AND Ac_year = @Ac_year)
      SET @Min_avg = (SELECT MIN(Final_avg) FROM Transcript WHERE Grade_level_ID = @Grade_level_ID AND Ac_year = @Ac_year) 
      
    INSERT INTO Shumabo.Progress_report (Ac_year, Grade_level_Id, Num_of_section, Num_of_stud, Num_of_male_stud, Num_of_female_stud, Max_avg, Min_avg, Passed_stud_percentage, Failed_stud_percentage, Passed_male_percentage, Failed_male_percentage, Passed_female_percentage, Failed_female_percentage)
    VALUES (@Ac_Year, @Grade_level_ID, @Number_of_section, @Number_of_student, @Number_of_male_stud, @Number_of_female_stud, @Max_avg, @Min_avg, @Passed_stud_percentage, @Failed_stud_percentage, @Passed_male_percentage, @Failed_male_percentage, @Passed_female_percentage, @Failed_female_percentage)
    PRINT 'the progress report is generated successfully.'
  END
GO

EXEC Shumabo.Generate_Progress_report 2023, 'GID12'

-- Functionality 42: displaying Progress levels of a specific Grade_level

GO
  CREATE FUNCTION Get_Progress_report (@Ac_year INT, @Grade_Level_ID VARCHAR(6))
  RETURNS TABLE
  AS
    RETURN (
      SELECT * FROM Shumabo.Progress_report
      WHERE Ac_year = @Ac_year AND Grade_level_ID = @Grade_Level_ID
    )
GO

SELECT * FROM dbo.Get_Progress_report(2023, 'GID12') 

-- Functionality 43: removing specific registered Progress report
GO
  CREATE PROCEDURE Shumabo.Remove_progress_report (@Ac_year INT, @Grade_Level_ID VARCHAR(6))
  AS
  BEGIN
    DELETE FROM Shumabo.Progress_report 
    WHERE Ac_year = @Ac_year AND Grade_level_ID = @Grade_Level_ID
  END
GO

EXEC  Shumabo.Remove_progress_report '2023', 'GID11'

-- Functionality 44: Recording passed and failed students (trigger 5)

-- Functionality 45: Displaying passed and failed students

GO
  CREATE FUNCTION Stud_data.Get_Stud_status (@Stud_ID varchar(10), @Ac_Year INT)
  RETURNS TABLE
  AS
  RETURN (
    SELECT * FROM Stud_data.Pass_fail_student
    WHERE Stud_ID =  @Stud_ID AND @Ac_Year = Ac_year
  )
GO

-- operating on the non_attendat table
-- functionality  46: withdraw a student from the lise

GO
  CREATE PROCEDURE Stud_data.Withdraw_student(@Ac_Year INT, @Stud_ID VARCHAR(10))
  AS
  BEGIN
    IF EXISTS (Select * from Stud_data.Student WHERE Ac_year = @Ac_year AND Stud_ID = @Stud_ID)
      BEGIN
        DELETE FROM Stud_data.Student
        WHERE Ac_year = @Ac_Year AND Stud_ID = @Stud_ID
      END
    ELSE
      BEGIN
        RAISERROR('There is no student with you specification, please be sure about you are trying to operate on the existing student.', 16, 1)
        ROLLBACK
      END
  END
GO

EXEC Stud_data.Withdraw_student '2023', 'ST0009'


-- Functionality 47: Update the withdrew students | add reason and leave_date

GO
  CREATE PROCEDURE Stud_data.Update_Non_attendant (@Ac_Year INT, @Stud_ID VARCHAR(10), @Reason TEXT, @leave_date DATE)
  AS
  BEGIN
    IF EXISTS (SELECT * FROM Stud_data.Non_attendant WHERE Ac_year = @Ac_Year AND Stud_ID = @Stud_ID)
      BEGIN
        UPDATE Stud_data.Non_attendant
        SET Reason = @Reason, 
            Leave_date = @leave_date
        WHERE Ac_year = @Ac_Year and Stud_Id = @Stud_ID
      END
    ELSE
      BEGIN
        RAISERROR('The is no one in the withdrawn list with your specification.', 16,1)
        ROLLBACK
      END
  END
GO

EXEC Stud_data.Update_Non_attendant 2023, 'ST0008', 'Health case', '2023-08-07' 
EXEC Stud_data.Update_Non_attendant 2023, 'ST0009', 'Transfer to other school', '2023-01-23' 

-- Generating, displaying and updating class schedule
-- functionality 48: store class schedule
GO
  CREATE PROCEDURE Assignment.Add_Class_schedule (@Schedule_Id VARCHAR(10), @Ac_year INT, @Section_code VARCHAR(6), @Grade_level_ID VARCHAR(6), @Subject_code VARCHAR(6), @Teacher_ID VARCHAR(10), @Day_name VARCHAR(10), @period_no INT, @Start_time TIME, @End_time TIME)
  AS
  BEGIN
    INSERT INTO Assignment.Class_Schedule (Schedule_Id, Ac_year, Section_code, Grade_level_ID, Subject_code, Teacher_Id, Day_name, period_no, Start_time, End_time)
    VALUES (@Schedule_Id, @Ac_year, @Section_code, @Grade_level_ID, @Subject_code, @Teacher_ID, @Day_name, @period_no, @Start_time, @End_time);
    
    PRINT 'You have added a class schedule'
  END
GO

drop PROCEDURE Assignment.Add_Class_schedule;

EXEC Assignment.Add_Class_schedule '2312AMon1', 2023, '12A', 'GID12', 'SA12', 'T001', 'Monday', 1, '02:00:00', '02:40:00'
EXEC Assignment.Add_Class_schedule '2312AMon2', 2023, '12A', 'GID12', 'SE12', 'T004', 'Monday', 2, '02:40:00', '03:20:00'
EXEC Assignment.Add_Class_schedule '2312AMon3', 2023, '12A', 'GID12', 'SCH12', 'T003', 'Monday', 3, '03:20:00', '04:00:00'
EXEC Assignment.Add_Class_schedule '2312AMon4', 2023, '12A', 'GID12', 'SCI12', 'T002', 'Monday', 4, '04:15:00', '04:55:00'
EXEC Assignment.Add_Class_schedule '2312AMon5', 2023, '12A', 'GID12', 'SP12', 'T005', 'Monday', 5, '04:55:00', '05:35:00'
EXEC Assignment.Add_Class_schedule '2312AMon6', 2023, '12A', 'GID12', 'SM12', 'T006', 'Monday', 6, '02:35:00', '06:15:00'

-- Functionality 49: Displaying class schedule

GO
  CREATE FUNCTION Get_class_schedule (@Ac_Year INT, @Section_code VARCHAR(6), @Day_name VARCHAR(10))
  RETURNS TABLE
  AS 
  RETURN (
    SELECT Period_no, Start_time, End_time, Subject_name, Teacher_F_name
    From Assignment.Class_schedule_detail
    WHERE  Ac_year = @Ac_Year AND Section_code = @Section_code AND Day_name = @Day_name
  )
GO


SELECT * FROM dbo.Get_class_schedule(2023, '12A', 'Monday')  

-- OR

SELECT * FROM Assignment.Class_schedule_detail
WHERE Ac_year = 2023 AND Grade_level_ID = '12A'

-- Functionality 50: Updating class schedule

GO
  CREATE PROCEDURE Assignment.Update_class_schedule (@Schedule_ID VARCHAR(10), @Attribute_name NVARCHAR(50), @New_value sql_variant)
  AS
  BEGIN
    SET NOCOUNT ON;    
    DECLARE @SQL NVARCHAR(MAX)

    SET @SQL = N'UPDATE Class_schedule SET ' + @Attribute_name + ' = ' + '''' + CAST(@New_value AS NVARCHAR(MAX)) + '''' + ' WHERE Schedule_Id = ' + '''' + @Schedule_ID + ''''
    
    EXECUTE sp_executesql @SQL
    PRINT 'You have updated the class schedule successfully.'
  END
GO

EXEC Assignment.Update_class_schedule '2312AMon1', 'Subject_code', 'SB12'

-- functionlaity 51: Generate Report card (view 7)
-- functionlaity 52: display the report card of a specified student

GO
  CREATE FUNCTION Stud_data.Get_report_card(@Ac_year INT, @Stud_ID VARCHAR(10))
  RETURNS TABLE
  AS
  RETURN (
    select * FROM Stud_data.Report_card
    WHERE Ac_year = @Ac_year AND Stud_ID = @Stud_ID
  )
GO

SELECT * FROM dbo.Get_report_card(2022, 'ST00003')