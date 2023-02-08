
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

-- Student 1 
    CREATE USER Bezabh FOR LOGIN Student
GO

-- student 2
GO
    CREATE USER Seblewongel FOR LOGIN Student
GO


-- 5. Creating a user for Parent login

-- Parent 1
    CREATE USER  Bogale FOR LOGIN Parent
GO

-- Parent 2
    CREATE USER Meshesha FOR LOGIN Parent
GO

-- 6. Creating a user for Staff login

-- Staff 1
    CREATE USER Tiruaynet FOR LOGIN Staff
GO

-- Staff 2
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

-- 10. creating a user for the Security_Admin login

GO
    CREATE USER Begood FOR LOGIN Security_admin
GO