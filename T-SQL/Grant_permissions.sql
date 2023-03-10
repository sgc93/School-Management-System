USE Shumabo_secondary_school

-- Grant permissions for users based on the schema they own

 -- For user Mesafint | login Director
  -- Grant CREATE TABLE permission to Mesafint on Shumabo schema
    -- grant creating
        GO
        GRANT CREATE TABLE 
        TO Mesafint

    -- grant selecting
        GO
        GRANT SELECT
        ON SCHEMA::[Shumabo]
        TO [Mesafint]
    -- Grant selecting tables from schema dbo
        GO
        GRANT SELECT 
        ON schema::[dbo] 
        TO [Mesafint];

    -- Grant EXECUTE permission to Mesafint on Shumabo schema

        GO
        GRANT EXECUTE 
        ON SCHEMA::Shumabo 
        TO Mesafint

    -- Grant Create Procedre function to Mesafint on Shumabo schema

        GO
        Grant CREATE PROCEDURE
        TO Mesafint

    -- Grant CREATE FUNCTION permission to Mesafint on Shumabo schema

        GO
        GRANT CREATE FUNCTION
        TO Mesafint
    
    -- Grant CREATE TRIGGER permission to Mesafint on Shumabo schema
    
    GO 
        GRANT CREATE TRIGGER
        TO Mesafint
    GO

 -- For user AlemGezi | user for login Registrar
  -- Grant CREATE TABLE permission to AlemGezi on Stud_data schema
    -- grant creating
        GO
        GRANT CREATE TABLE 
        TO AlemGezi

    -- grant selecting
        GO
        GRANT SELECT
        ON SCHEMA::[Stud_data]
        TO [AlemGezi]

    -- grant selecting tables from schema dbo
        GO
        GRANT SELECT
        ON schema::[dbo] 
        TO [AlemGezi];

    -- grant referencing schema Assignment
        GO
        GRANT REFERENCES 
        ON schema::[Assignment] 
        TO [AlemGezi];

    -- grant references permission
    GO
        GRANT REFERENCES 
        ON SCHEMA::[dbo] 
        TO [AlemGezi];
    GO
 -- Grant EXECUTE permission to AlemGezi on Stud_data schema
    
    GO
        GRANT EXECUTE 
        ON SCHEMA::Stud_data 
        TO AlemGezi
    GO

 -- Grant Create Procedre function to AlemGezi on Stud_data schema

    GO
        Grant CREATE PROCEDURE
        TO AlemGezi
    GO
    -- grant drop
    GO
        GRANT DROP TRIGGER 
        TO Alemgezi;
    GO
 -- Grant CREATE FUNCTION permission to AlemGezi on Stud_data schema
    
    GO
        GRANT CREATE FUNCTION
        TO AlemGezi
    GO
 -- Grant CREATE TRIGGER permission to AlemGezi on Stud_data schema
    
    GO 
        GRANT CREATE TRIGGER
        TO AlemGezi
    GO
 -- Grant alter permission 
    GO
        GRANT ALTER 
        ON SCHEMA::[dbo] 
        TO [AlemGezi];
    GO

    REVOKE ALTER ON SCHEMA::[dbo] FROM [AlemGezi];


    -- For user Abiy | user for login Unit_leader

 -- Grant CREATE TABLE permission to Abiy on Assignment schema
    -- grant creating
    GO
        GRANT CREATE TABLE 
        TO Abiy
    GO
    
    -- grant selecting tables from schema dbo
    GRANT SELECT 
    ON schema::[dbo] 
    TO [Abiy];
 -- grant a create view permission

    GRANT CREATE VIEW TO Abiy;
    
 -- Grant EXECUTE permission to Abiy on Assignment schema
  
    GO
        GRANT EXECUTE 
        ON SCHEMA::Assignment 
        TO Abiy
    GO

 -- Grant Create Procedre function to Abiy on Assignment schema

    GO
        Grant CREATE PROCEDURE
        TO Abiy
    GO
 -- Grant CREATE FUNCTION permission to Abiy on Assignment schema
    
    GO
        GRANT CREATE FUNCTION
        TO Abiy
    GO
 -- Grant CREATE TRIGGER permission to Abiy on Assignment schema
    
    GO 
        GRANT CREATE TRIGGER
        TO Abiy
    GO
 -- Grant reference permission on schema Teacher_Data

    GRANT REFERENCES 
    ON SCHEMA::Teacher_Data
    TO Abiy

-- For user Zemenay | user for login Resource_Officer

 -- Grant CREATE TABLE permission to Abiy on Assignment schema
    -- grant creating
    GO
        GRANT CREATE TABLE 
        TO Zemenay
    GO
    
    -- grant selecting tables from schema dbo
    GRANT SELECT 
    ON schema::[dbo] 
    TO [Zemenay];

 -- Grant EXECUTE permission to Abiy on Assignment schema
    
    GO
        GRANT EXECUTE 
        ON SCHEMA::Staff_data
        TO Zemenay
    GO

 -- Grant Create Procedre function to Abiy on Assignment schema

    GO
        Grant CREATE PROCEDURE
        TO Zemenay
    GO

 -- Grant CREATE FUNCTION permission to Abiy on Assignment schema
    
    GO
        GRANT CREATE FUNCTION
        TO Zemenay
    GO

 -- Grant CREATE TRIGGER permission to Abiy on Assignment schema
    
    GO 
        GRANT CREATE TRIGGER
        TO Zemanay
    GO