USE Shumabo_secondary_school

--Login 1: Create System_Admin login
GO
    CREATE LOGIN System_Admin WITH PASSWORD = 'sysadmin1234';
GO

--Login 2: Create Director login
GO
    CREATE LOGIN Director WITH PASSWORD = 'director1234';
GO

--Login 3: Create Teacher login
GO
 CREATE LOGIN Teacher WITH PASSWORD = 'teacher1234';
GO


--Login 4: Create Staff login
GO
    CREATE LOGIN Staffs WITH PASSWORD = 'staff1234';
GO

--Login 5: Create Resource Officer login
GO
    CREATE LOGIN Resource_officer WITH PASSWORD = 'RO1234';
GO

--Login 6: Create Registrar login
GO
    CREATE LOGIN Registrar WITH PASSWORD = 'registrar1234';
GO

--Login 7: create Unit_leader login
GO
    CREATE LOGIN Unit_leader WITH  PASSWORD = 'UL1234'
GO

-- Login 8: Create a Security_admin login

GO
    CREATE Login Security_Admin WITH PASSWORD = 'secadmin1234'
GO


drop table Teacher_list