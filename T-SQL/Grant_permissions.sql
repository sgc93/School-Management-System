USE Shumabo_secondary_school

-- Granting permissions 

-- Grant permissions for users based on the schema they own

-- For user Mesafint | user for login Director

-- Grant CREATE TABLE permission to Mesafint on Shumabo schema
    -- grant creating
    GO
        GRANT CREATE TABLE 
        TO Mesafint
    GO
    -- grant selecting
    GO
        GRANT SELECT
        ON SCHEMA::[Shumabo]
        TO [Mesafint]
    GO
    -- grant selecting tables from schema dbo
    GRANT SELECT 
    ON schema::[dbo] 
    TO [Mesafint];

-- Grant EXECUTE permission to Mesafint on Shumabo schema
    
    GO
        GRANT EXECUTE 
        ON SCHEMA::Shumabo 
        TO Mesafint
    GO

-- Grant Create Procedre function to Mesafint on Shumabo schema

    GO
        Grant CREATE PROCEDURE
        TO Mesafint
    GO
-- Grant CREATE FUNCTION permission to Mesafint on Shumabo schema
    
    GO
        GRANT CREATE FUNCTION
        TO Mesafint
    GO
-- Grant CREATE TRIGGER permission to Mesafint on Shumabo schema
    
    GO 
        GRANT CREATE TRIGGER
        TO Mesafint
    GO
