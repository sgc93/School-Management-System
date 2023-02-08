USE Shumabo_secondary_school
-- DML Triggers


-- Triggers that prevents updatting of some data in the table

-- Trigger 1
-- Functionlity : donot allow to update the Serial number of items

GO
  CREATE TRIGGER No_update_SerNo_TotalPrice
  ON New_Items_list
  for UPDATE
  AS 
  IF(UPDATE(ISer_no) OR UPDATE(Total_price))
  	BEGIN
    	RAISERROR('The Serial number of any Items should not be modified',14,12)
    	ROLLBACK TRANSACTION
  	END
GO

-- Triggers that update the a tabel as soon as othe table is updated

-- Trigger 2
-- Functionlality  : insert New items into All_Item ist or Update items as new itmes are added.

GO
	CREATE TRIGGER tr_update_all_items_list
	ON New_items_list
	AFTER INSERT
	AS
	BEGIN
		DECLARE 
			@ISer_no VARCHAR(8),
			@Item_name VARCHAR(50),
			@Item_type varchar(50),
			@Unit_price FLOAT,
			@Total_price FLOAT,
			@Added_quantity INT,
			@Recieving_date DATE
		SELECT 	
			@ISer_no = ISer_no,
       		@Item_name = Item_name,
    		@Item_type = Item_type,
       		@Unit_price = Unit_price, 
       		@Total_price = Total_price, 
       		@Added_quantity = Added_quantity,
       		@Recieving_date = Recieving_date
		FROM inserted

		IF NOT EXISTS (SELECT * FROM All_items_list WHERE ISer_no = @ISer_no)  -- if the added items not exist in the All_Item table
			BEGIN
    			INSERT INTO All_items_list (ISer_no, Item_name, Item_type, Unit_price, Total_price, Current_quantity)
    			VALUES (@ISer_no, @Item_name, @Item_type, @Unit_price, @Total_price, @Added_quantity)
			END
		ELSE
			BEGIN
    			UPDATE All_items_list 
    			SET Current_quantity = Current_quantity + @Added_quantity
    			WHERE ISer_no = @ISer_no
			END
	END
GO


-- Trigger 3
-- Functionality  : update the the current amount of a certain item as some of it is withdrawed.
GO
	CREATE TRIGGER tr_update_all_items_as_withdrawed
	ON Withdrawed_Items
	AFTER INSERT
	AS
	BEGIN
		DECLARE 
			@ISer_no VARCHAR(8),
			@Withdrawed_quantity INT,
			@Withdrawing_date DATE

		SELECT 
			@ISer_no = ISer_no,
       		@Withdrawed_quantity = Withdrawed_quantity,
       		@Withdrawing_date = Withdrawing_date
		FROM inserted

		UPDATE All_items_list 
		SET Current_quantity = Current_quantity - @Withdrawed_quantity
		WHERE ISer_no = @ISer_no

		UPDATE All_items_list
		SET Total_price = Unit_price * Current_quantity
		WHERE ISer_no = @ISer_no
	END
GO

-- Trigger 4
-- Functionality  : store the information of the withdrew students

GO
	CREATE TRIGGER tr_Set_Withdraw
	ON Student_list
	AFTER DELETE
	AS
	BEGIN
		DECLARE 
			@Stud_ID VARCHAR(10),				
			@Grade_level_ID VARCHAR(10),
			@Section_code VARCHAR(6),
			@Gender VARCHAR(10),
			@Stud_status VARCHAR(20)
		SELECT 	
			@Stud_ID = Stud_ID,
			@Grade_level_ID = Grade_level_ID,
			@Section_code = Section_code,
			@Gender = Gender
		FROM deleted
		SET @Stud_status = 'Withdrew'

		INSERT INTO Non_attendant (Stud_ID, Grade_level_ID, Section_code, Gender, Stud_status)
		VALUES (@Stud_ID, @Grade_level_ID, @Section_code, @Gender, @Stud_status)
		PRINT 'student has withdrew, fill some data about the withdran student'
	END
GO
-- Trigger 5
-- functionality  : store the last status (passed or failed) of students

GO
	CREATE TRIGGER tr_Set_stud_status
	ON Transcript
	AFTER INSERT
	AS
	BEGIN
		DECLARE 
			@Ac_Year INT,
			@Stud_ID VARCHAR(10),				
			@Grade_level_ID VARCHAR(10),
			@Section_code VARCHAR(6),
			@Gender VARCHAR(10),
			@final_avg FLOAT,
			@Stud_status VARCHAR(20)
		SELECT 	
			@Ac_year = Ac_Year,
			@Stud_ID = Stud_ID,
			@final_avg = Final_avg 
		FROM inserted
		SELECT 
			@Grade_level_ID = Grade_level_ID,
			@Section_code = Section_code,
			@Gender = Gender
		FROM Student_list WHERE Stud_ID = @Stud_ID

		IF EXISTS (SELECT * FROM Pass_fail_Student WHERE Ac_year = @Ac_year AND Stud_ID = @Stud_ID)
			BEGIN
				RAISERROR('try to set a status for the same studetn.', 12,3)
				ROLLBACK
			END
		ELSE
			BEGIN
				IF @final_avg >= 48
					BEGIN
			 			SET @Stud_status = 'Passed'
			 			INSERT INTO Pass_fail_Student (Ac_Year, Stud_ID, Grade_level_Id, Section_code, Gender, Final_avg, Stud_status)
			 			VALUES (@Ac_Year, @Stud_ID, @Grade_level_ID, @Section_code, @Gender, @final_avg,  @Stud_status)
					END
				ELSE
					BEGIN
			 			SET @Stud_status = 'Failed'
			 			INSERT INTO Pass_fail_Student (Ac_Year, Stud_ID, Grade_level_Id, Section_code, Gender, Final_avg, Stud_status)
			 			VALUES (@Ac_Year, @Stud_ID, @Grade_level_ID, @Section_code, @Gender, @final_avg,  @Stud_status)
					END
				PRINT 'Student status is set.'
			END
	END
GO

-- Triggers that stores the deleted tables
-- Trigger 6: 
-- store the deleted calanders

GO
	CREATE TRIGGER Shumabo.tr_deleted_Academic_calendar
	ON Shumabo.Academic_calendar
	AFTER DELETE
	AS
	BEGIN
		SET NOCOUNT ON;

		INSERT INTO Shumabo.Deleted_Academic_calendar
		SELECT * FROM deleted;
	END;
GO

/*
The SET NOCOUNT ON statement is used in T-SQL (Transact-SQL) to prevent 
the display of the number of rows affected by a query. 
The NOCOUNT option is used to suppress the message returned by the SQL Server 
after each Transact-SQL statement that updates data.

The purpose of using SET NOCOUNT ON is to improve the performance of a 
database by reducing the amount of data that needs to be sent between 
the server and the client. When NOCOUNT is set to ON, the number of affected
 rows is not returned, reducing network traffic and increasing the performance 
 of the database.
 */

-- Trigger 7
-- Storing the deleted Progress report

GO
	CREATE TRIGGER Shumabo.tr_store_deleted_progress_report
	ON Shumabo.Progress_report
	AFTER DELETE
	AS
	BEGIN
		INSERT INTO Shumabo.Deleted_progress_report (Ac_year, Grade_level_Id, Num_of_section, Num_of_stud, Num_of_male_stud, Num_of_female_stud, Max_avg, Min_avg, Passed_stud_percentage, Failed_stud_percentage, Passed_male_percentage, Failed_male_percentage, Passed_female_percentage, Failed_female_percentage)
		SELECT Ac_year, Grade_level_Id, Num_of_section, Num_of_stud, Num_of_male_stud, Num_of_female_stud, Max_avg, Min_avg, Passed_stud_percentage, Failed_stud_percentage, Passed_male_percentage, Failed_male_percentage, Passed_female_percentage, Failed_female_percentage FROM deleted;
	END
GO

-- Trigger 8
-- donnot allow to insert doublcate rows in the transcript

GO
	CREATE TRIGGER Tr_no_duble_Transcript
	ON Transcript
	AFTER INSERT
	AS
	BEGIN
		DECLARE @Stud_ID VARCHAR(10), 
				@Ac_Year INT;
		SELECT 	@stud_id = Stud_ID, 
				@Ac_year = Ac_year
		FROM inserted;

		IF EXISTS (SELECT * FROM Transcript
		WHERE Stud_ID = @stud_id AND Ac_year = @Ac_year)
			BEGIN
				RAISERROR('YOU ARE TRYING TO GENERATE DOUBLCATE ROASTER', 11,1)
				ROLLBACK
			END
	END
GO


-- DDL Triggers
-- donot update
GO
	CREATE TRIGGER tr_No_Table_Change
	ON Grade_report 
	INSTEAD OF UPDATE
	AS
	PRINT 'Tables should not be modified'
	ROLLBACK;
GO
-- Logon Trigers
