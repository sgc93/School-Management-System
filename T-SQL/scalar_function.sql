USE Shumabo_secondary_school

-- Scalar functions that return a percentage value of required data

GO
    CREATE FUNCTION Get_passed_stud_percentage (@Number_of_passed_stud INT, @number_of_failed_stud INT)
    RETURNS FLOAT
    AS
    BEGIN
        RETURN (@Number_of_passed_stud / (@Number_of_passed_stud + @number_of_failed_stud)) * 100
    END
GO

GO
    CREATE FUNCTION Get_failed_stud_percentage (@Number_of_passed_stud INT, @Number_of_failed_stud INT)
    RETURNS FLOAT
    AS
    BEGIN
        RETURN (@number_of_failed_stud / (@Number_of_passed_stud + @number_of_failed_stud)) * 100
    END
GO



