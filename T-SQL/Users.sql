
USE Shumabo_secondary_school

-- creating users for each login

-- 1. Creating a user for system_Admin login
GO
    CREATE USER Gsix FOR LOGIN System_Admin
GO

-- 2. Creating a user for Director login
GO
    CREATE USER Mesafint FOR LOGIN Director
GO

-- 3. Creating a user for Teacher login
GO
    CREATE USER Mintesnot FOR LOGIN Teacher
GO

-- 4. Creating a user for Student login | for publicaly authorized functionalities
GO
    CREATE USER Bezabh FOR LOGIN Student
GO

GO
    CREATE USER Seblewongel FOR LOGIN Student
GO


-- 5. Creating a user for Parent login
GO
    CREATE USER  Bogale FOR LOGIN Parent
GO

GO
    CREATE USER Meshesha FOR LOGIN Parent
GO

-- 6. Creating a user for Staff login
GO
    CREATE USER Tiruaynet FOR LOGIN Staff
GO

GO
    CREATE USER Wudnesh FOR LOGIN Staff
GO

-- 7. Creating a user for Resource Officer login
GO
    CREATE USER Zemenay FOR LOGIN Resource_officer
GO

-- 8. Creating a user for Registrar login
GO
    CREATE USER AlemGezi FOR LOGIN Registrar
GO

-- 9. creating a user for Unit_leader login
GO
    CREATE USER Abiy FOR LOGIN Unit_leader
GO


select * from Staff_list