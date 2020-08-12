Create database EC_Proj
use EC_Proj
 
 select * from User_Data 
drop table User_Data
Create Table User_Data(

	Trn int primary key,
	Company_Trn int,
	Person_Fname Varchar(30),
	Person_Lname Varchar(30),
	email Varchar(45),
	/*Password*/
	Pw Varchar(40),
	Phone int
);
insert into User_Data (Trn,Person_Fname,Person_Lname) values(1235,'kio','kio')
drop Table Employer
Create Table Employer(
	
	Trn int primary key,
	Business_name Varchar(45),

	CONSTRAINT FK_EMPLOYER FOREIGN KEY (Trn) REFERENCES User_Data(Trn)
);

select  *from Employee

drop Table Employee
select *from Employee
Create Table Employee(

	Trn int primary key,
	Company_Trn int,
	Business_name Varchar(45),
	Job Varchar(30),
	heartStudent VARCHAR (1),
	Salary float,
	Addition float,
	
	CONSTRAINT FK_EMPLOYEE FOREIGN KEY (Trn) REFERENCES User_Data(Trn),
	CONSTRAINT FK_EMPLOYERLINK FOREIGN KEY (Company_Trn) REFERENCES Employer (Trn)
);
Alter table Employee	
Add period date;
Select *from Employee

drop Table User_Address
Create Table User_Address(

	Trn int primary key,
	Company_Trn int,
	first_Line Varchar(40),
	City Varchar(40),
	Parish Varchar(40)

	CONSTRAINT FK_ASSIGN_ADDR FOREIGN KEY (Trn) REFERENCES User_Data(Trn)
);
select *from Employee

drop PROCEDURE Employee_Reg
Create PROCEDURE Employee_Reg(
	@Trn int,
	@Company_Trn int,
	@email Varchar(45),
	@Password Varchar(256),
	@Phone int,
	@first_Line Varchar(40),
	@City Varchar(40),
	@Parish Varchar(40)
)
As
	Begin
	
		Declare @Count int  
		Declare @codereturn int
		
		Select @Count = COUNT(Trn) from Employee where Trn = @Trn
		if(@Count > 0 )
			Begin
			Select @Count = COUNT(email)  
			from User_Data where email = @email AND Trn = @Trn
			End
		If @Count < 0  
		Begin   
			Set @codereturn = -1  
		End  
		Else  
		Begin 
		Select *from User_Address
			Set @codereturn  = 1 
			UPDATE User_Data SET Pw = @Password, Phone = @Phone WHERE Trn = @Trn
			insert into User_Address values(@Trn,@Company_Trn,@first_Line,@City,@Parish)
		End  
			Select @codereturn as ReturnValue
	End

drop Procedure Add_Employer
CREATE Procedure Add_Employer(

@Trn int,
@Person_Fname Varchar(30),
@Person_Lname Varchar(30),
@email Varchar(45),
@Password Varchar(40),
@Phone int,

@first_Line Varchar(40),
@City Varchar(40),
@Parish Varchar(40),

@Business_name Varchar(45)
)
As
Begin

 Declare @Count int
 Declare @Count2 int  
 Declare @codereturn int
 
 Select @Count = COUNT(email)  
 from User_Data where email = @email
  Select @Count2 = COUNT(Trn)  
 from User_Data where Trn = @Trn    
 If ((@Count > 0) OR (@Count2 > 0))
	 Begin   
	  Set @codereturn = -1  
	 End  
 Else  
	 Begin 
	  Set @codereturn  = 1 
	  insert into User_Data values(@Trn,@Trn,@Person_Fname,@Person_Lname,@email,@Password,@Phone)
	  insert into User_Address values(@Trn,@Trn,@first_Line,@City,@Parish)
	  insert into Employer values(@Trn,@Business_name)
	 End  
  Select @codereturn as ReturnValue
End



CREATE PROCEDURE loginCheck 
      
    @email varchar(50),  
    @Password varchar(50)  
      
AS  
BEGIN  
    Declare @Count int  
      
    Select @Count = COUNT(@email)  
    from User_Data where email=@email and Pw =@Password  
      
    If (@Count = 1)  
    Begin   
     Select 1 as codereturn  
    End  
    Else  
    Begin  
        Select -1 as codereturn  
    End  
End

drop Procedure AddUser_Adrs
Create Procedure AddUser_Adrs(

	@Trn int,
	@Company_Trn int,
	@first_Line Varchar(40),
	@City Varchar(40),
	@Parish Varchar(40)
)
as
	begin
		insert into User_Address values(@Trn,@Company_Trn,@first_Line,@City,@Parish);
	End




--Registration/Delete/Update status
Create Table RDU_Stats(

	Number int identity(1,1),
	info Varchar(45)
);

Create Table Theshold_Log(

	Number int identity(1,1),
	info Varchar(45)
);

drop Procedure AddUser_Data
Create Procedure AddUser_Data(

	@Trn int,
	@Company_Trn int,
	@Person_Fname Varchar(30),
	@Person_Lname Varchar(30),
	@email Varchar(45),
	@Pw Varchar(40),
	@Phone int
)
As
	Begin
		insert into User_Data values(@Trn,@Company_Trn,@Person_Fname,@Person_Lname,@email,@Pw,@Phone)
	End




	select *from User_Data

Create Procedure AddUser_Address(

	@Trn int,
	@Company_Trn int,
	@first_Line Varchar(40),
	@City Varchar(40),
	@Parish Varchar(40)
)
As
	Begin
		insert into User_Address values(@Trn,@Company_Trn,@first_Line,@City,@Parish)
	End


	drop Procedure SomeEmployee
	
Create Procedure SomeEmployee(

	@Trn int,
	@Person_Fname Varchar(30),
	@Person_Lname Varchar(30),
	@email Varchar(45),

	@Business_name Varchar(45),
	@Company_Trn int,
	@Job Varchar(30),
	@heartStudent VARCHAR(1),
	@Salary float,
	@addition float,
	@period date

)
As
	Begin

		insert into User_Data(Trn,Company_Trn,Person_Fname,Person_Lname,email) values(@Trn,@Company_Trn,@Person_Fname,@Person_Lname,@email);
		insert into Employee values(@Trn,@Company_Trn,@Business_name,@Job,@heartStudent,@Salary,@addition, @period);
	End






	drop Procedure FullEmployee
Create Procedure FullEmployee(

	@Trn int,
	@Person_Fname Varchar(30),
	@Person_Lname Varchar(30),
	@email Varchar(45),
	@Password Varchar(40),
	@Phone int,

	@first_Line Varchar(40),
	@City Varchar(40),
	@Parish Varchar(40),

	@Business_name Varchar(45),
	@Company_Trn int,
	@Job Varchar(30), 
	@heartStudent VARCHAR(1),
	@Salary float,
	@addition float,
	@period date
)
As
	Begin

		insert into User_Data values(@Trn,@Company_Trn,@Person_Fname,@Person_Lname,@email,@Password,@Phone)
		insert into User_Address values(@Trn,@Company_Trn,@first_Line,@City,@Parish)
		insert into Employee values(@Trn,@Company_Trn,@Business_name,@Job,@heartStudent,@Salary,@addition,@period)
	End
	select *from Employee
	--Exec FullEmployee 'kiodore','williams','kiodore@gmail.com', 1234, 1234567, '12 West kings road', 'Kingston', 'Kingston', '1plus', 123, 'The M-a-n', 9999999999, '10/10/1998'


drop Procedure AddEmployee
Create Procedure AddEmployee(
	
	@Trn int,
	@Company_Trn int,
	@Business_name Varchar(45),
	@Job Varchar(30),
	@heartStudent VARCHaR(1),
	@Salary float,
	@addition float
)
As
	Begin	
		insert into Employee values(@Trn,@Company_Trn,@Business_name,@Job,@heartStudent,@Salary,@addition)
	End


Create Procedure AddEmployer(

	@Trn int,
	@Person_Fname Varchar(30),
	@Person_Lname Varchar(30),
	@email Varchar(45),
	@Password Varchar(40),
	@Phone int,

	@first_Line Varchar(40),
	@City Varchar(40),
	@Parish Varchar(40),

	@Business_name Varchar(45)
)
As
	Begin
		insert into User_Data values(@Trn,@Trn,@Person_Fname,@Person_Lname,@email,@Password,@Phone)
		insert into User_Address values(@Trn,@Trn,@first_Line,@City,@Parish)
		insert into Employer values(@Trn,@Trn,@Business_name)
	End


Create Procedure Add_RDU_Stats_Log(

	@info Varchar(45)
)
As
	Begin
		insert into RDU_Stats values(@info)
	End


Create Procedure AddToTheshold_Log(

	@info Varchar(45)
)
As
	Begin
		insert into Theshold_Log values(@info)
	End


CREATE PROCEDURE FIND_User_Data(
	@id Integer
)
AS
BEGIN
	Select *From User_Data
	WHERE Trn = @id
END




CREATE PROCEDURE FIND_Employer_Data(
	@id Integer
)
AS
BEGIN
	Select *From Employer
	WHERE Trn = @id
END




CREATE PROCEDURE FIND_Employee_Data(
	@id Integer
)
AS
BEGIN
	Select *From Employee
	WHERE Trn = @id
END



CREATE PROCEDURE FIND_Address(
	@id Integer
)
AS
BEGIN
	Select *From User_Address
	WHERE Trn = @id
END



Create Procedure UpdateUser_Address(

	@Trn int,
	@first_Line Varchar(40),
	@City Varchar(40),
	@Parish Varchar(40)
)
As
	Begin
		update User_Address
		Set first_Line = @first_Line
		where Trn = @Trn

		update User_Address
		Set City = @City
		where Trn = @Trn

		update User_Address
		Set Parish = @Parish
		where Trn = @Trn
	End




select *from User_Data
Create Procedure Update_UserData(

	@Trn int,
	@Fname Varchar(30),
	@Lname Varchar(30),
	@email Varchar(45),
	@Password Varchar(40),
	@Phone int
)
as
	Begin
		update User_Data
		Set Person_Fname = @Fname
		where Trn = @Trn

		update User_Data
		Set Person_Lname = @Lname
		where Trn = @Trn

		update User_Data
		Set email = @email
		where Trn = @Trn

		update User_Data
		Set Pw = @Password
		where Trn = @Trn

		update User_Data
		Set Phone = @Phone
		where Trn = @Trn
	End

	select *from employee

Create Procedure Upate_Employee(
	
	@trn int,
	@Company_trn int,
	@Business_name varchar(45),
	@Job varchar(45),
	@Salary float 
)
as
	Begin
		update Employee
		Set Company_trn = @Company_trn
		where Trn = @Trn

		update Employee
		Set Business_name = @Business_name
		where Trn = @Trn

		update Employee
		Set Job = @Job
		where Trn = @Trn

		update Employee
		Set Salary = @Salary
		where Trn = @Trn
	End


Create Procedure Update_Name(

	@Trn int,
	@Fname Varchar(40),
	@Lname VArchar(40)
)
as
	Begin
		update User_Data
		Set Person_Fname = @Fname
		where Trn = @Trn

		update User_Data
		Set Person_Lname = @Lname
		where Trn = @Trn
	End


Create Procedure Update_email(
	@Trn int,
	@email Varchar(45)
)
as
	Begin
		update User_Data
		Set email = @email
		where Trn = @Trn
	End

Create Procedure Update_Password(

	@Trn int,
	@Password Varchar(45)
)
as
	Begin
		update User_Data
		Set Pw = @Password
		where Trn = @Trn
	End


Create Procedure Update_Phone(

	@Trn int,
	@Phone Varchar(45)
)
as
	Begin
		update User_Data
		Set Phone = @Phone
		where Trn = @Trn
	End


--For Employer
Create Procedure Update_Business_name(

	@Trn int,
	@Business_name Varchar(45)
)
as
	Begin
		update Employer
		Set Business_name = @Business_name
		where Trn = @Trn
	End


Create Procedure Update_EmpBusiness_name(

	@Trn int,
	@Business_name Varchar(45)
)
as
	Begin
		update Employee
		Set Business_name = @Business_name
		where Trn = @Trn
	End

--Employee Data Entry
Create Procedure Update_EmpCompany_Trn(
	@Trn int,
	@Company_Trn int
)
as
	Begin
		update Employee
		Set Trn = @Company_Trn
		where Trn = @Trn
	End

--Employer
Create Procedure Update_Company_Trn(
	@Trn int,
	@Company_Trn int
)
as
	Begin
		update Employer
		Set Trn = @Company_Trn
		where Trn = @Trn
	End

Create Procedure Update_Job_Detail(

	@Trn int,
	@Job Varchar(45),
	@Salary float
)
as
	Begin
		update Employee
		Set Job = @Job
		where Trn = @Trn

		update Employee
		Set Salary = @Salary
		where Trn = @Trn
	End

	select * from employee
	
Create Procedure Update_Address(

	@Trn int,
	@first_Line Varchar(45),
	@City Varchar(40),
	@Parish Varchar(40)
)
as
	Begin
		update User_Address
		Set first_Line = @first_Line
		where Trn = @Trn

		update User_Address
		Set City = @City
		where Trn = @Trn
				
		update User_Address
		Set Parish = @Parish
		where Trn = @Trn
	End

Create Procedure Del_All
as
	Begin
		Delete from User_Data
		Delete from Employer
		Delete from Employee
		Delete from User_Address
		Delete from Employee_Log
		Delete from RDU_Stats
		Delete from Theshold_Log
	End


Create Procedure Del_User_Data
as
	Begin
		Delete from User_Data
	End		


Create Procedure Del_Employer
as 
	Begin
		Delete from Employer
	End


Create Procedure Del_Employer_withEmployees
as 
	Begin
		Delete from Employer
		Delete from Employee
	End


Create Procedure Del_Employee
as
	Begin
		Delete from Employee
	End


Create Procedure Del_All_Log
as
	Begin
		Delete from Employee_Log
		Delete from RDU_Stats
		Delete from Theshold_Log
	End


Create Procedure Del_Emp_Log
as 
	Begin
		Delete from Employee_Log
	End


Create Procedure Del_RDU_Stats
as
	Begin
		Delete from RDU_Stats
	End


Create Procedure Del_theshold_Log
as
	Begin
		Delete from Theshold_Log
	End


Create Procedure Del_All_UserAddress
as
	Begin 
		Delete from User_Address
	End

Create Procedure Del_Employer(
	@Trn int
)
as
	Begin
		Delete from User_Data where Trn = @Trn
		Delete from Employer where Trn = @Trn
		Delete from Employee where Trn = @Trn
	End


Create Procedure Del_Employee(
	@Trn int
)
as
	Begin
		Delete from Employee where Trn = @Trn
	End


Create Procedure Del_User_Address(
	@Trn int
)
as
	Begin
		Delete from User_Address where Trn = @Trn
	End


--Register, Delete and Update
DROP TRIGGER RDU_User_inserted
Create Trigger RDU_User_inserted
On User_Data
After Insert
As 
Begin

	Declare @Trn int
	Select @Trn = Trn from inserted

	insert into RDU_Stats
	values ('New User with Trn = '+ CAST(@Trn as nvarchar(5))+ ' is added at '+ cast(getdate() as nvarchar(20)))
End


	
DROP TRIGGER RDU_Employer_inserted
Create Trigger RDU_Employer_inserted
On Employer
After Insert
As 
Begin

	Declare @Trn int
	Select @Trn = Trn from inserted

	insert into RDU_Stats
	values ('New employer with Trn = '+ CAST(@Trn as nvarchar(5))+ ' is added at '+ cast(getdate() as nvarchar(20)))
End


DROP TRIGGER RDU_Employee_inserted
Create Trigger RDU_Employee_inserted
On Employee
After Insert
As 
Begin
	Declare @Trn int
	Select @Trn = Trn from inserted

	insert into RDU_Stats
	values ('New employee with Trn = '+ CAST(@Trn as nvarchar(5))+ ' is added at '+ cast(getdate() as nvarchar(20)))
End

DROP TRIGGER RDU_Address_inserted
Create Trigger RDU_Address_inserted
On User_Address
After Insert
As 
Begin
	Declare @Trn int
	Select @Trn = Trn from inserted

	insert into RDU_Stats
	values ('New address with Trn = '+ CAST(@Trn as nvarchar(5))+ ' is added at '+ cast(getdate() as nvarchar(20)))
End



DROP TRIGGER RDU_User_deleted
Create Trigger RDU_User_deleted
On User_Data
After delete
As 
Begin
	Declare @Trn int
	Select @Trn = Trn from deleted

	insert into RDU_Stats
	values ('User with Trn = '+ CAST(@Trn as nvarchar(5))+ ' is deleted at '+ cast(getdate() as nvarchar(20)))
End



DROP TRIGGER RDU_Employer_deleted
Create Trigger RDU_Employer_deleted
On Employer
After delete
As 
Begin
	Declare @Trn int
	Select @Trn = Trn from deleted

	insert into RDU_Stats
	values ('Employer with Trn = '+ CAST(@Trn as nvarchar(5))+ ' is deleted at '+ cast(getdate() as nvarchar(20)))
End


DROP TRIGGER RDU_Employee_deleted
Create Trigger RDU_Employee_deleted
On Employee
After delete
As 
Begin
	Declare @Trn int
	Select @Trn = Trn from deleted

	insert into RDU_Stats
	values ('Employee with Trn = '+ CAST(@Trn as nvarchar(5))+ ' is deleted at '+ cast(getdate() as nvarchar(20)))
End


DROP TRIGGER RDU_Address_deleted
Create Trigger RDU_Address_deleted
On User_Address
After delete
As 
Begin
	Declare @Trn int
	Select @Trn = Trn from deleted

	insert into RDU_Stats
	values ('Address with Trn = '+ CAST(@Trn as nvarchar(5))+ ' is deleted at '+ cast(getdate() as nvarchar(20)))
End




DROP TRIGGER RDU_User_Update
Create Trigger RDU_User_Update
On User_Data
After Update
As 
Begin
	Declare @trn int;
	Select @trn = Trn from deleted

	Declare @identifier Varchar(25);
	Declare @O Varchar(50);
	Declare @N Varchar(50);

	If  UPDATE(Person_Fname) 
		BEGIN 
			Set @identifier = 'FirstName'
			Select @O = Person_Fname from deleted
			Select @N = Person_Fname from inserted
		End

	If  UPDATE(Person_Lname) 
		BEGIN 
			Set @identifier = 'LastName'
			Select @O = Person_Lname from deleted
			Select @N = Person_Lname from inserted
		End

	If  UPDATE(email) 
		BEGIN 
			Set @identifier = 'Email'
			Select @O = email from deleted
			Select @N = email from inserted
		End

	If  UPDATE(pw) 
		BEGIN 
			Set @identifier = 'Password'
			Select @O = pw from deleted
			Select @N = pw from inserted
		End

	If  UPDATE(Phone) 
		BEGIN 
			Set @identifier = 'Phone'
			Select @O = Phone from deleted
			Select @N = Phone from inserted
		End

	insert into RDU_Stats
	values('User '+@identifier+' with Trn = '+@trn+ ' was updated from: ' +@O+ ' to: ' +@N+' on'+ GETDATE())
End




DROP TRIGGER RDU_Employer_Update
Create Trigger RDU_Employer_Update
On Employer
After Update
As 
Begin
	Declare @trn int;
	Select @trn = Trn from deleted

	Declare @identifier Varchar(25);
	Declare @O Varchar(50);
	Declare @N Varchar(50);

	If  UPDATE(Business_name) 
		BEGIN 
			Set @identifier = 'Business name'
			Select @O = Business_name from deleted
			Select @N = Business_name from inserted
		End


	insert into RDU_Stats
	values('Employer '+@identifier+' with Trn = '+@trn+ ' was updated from: ' +@O+ ' to: ' +@N+' on'+ GETDATE())
End


DROP TRIGGER RDU_Employee_Update
Create Trigger RDU_Employee_Update
On Employee
After Update
As 
Begin
	Declare @trn int;
	Select @trn = Trn from deleted

	Declare @identifier Varchar(25);
	Declare @O Varchar(50);
	Declare @N Varchar(50);

	If  UPDATE(Business_name) 
		BEGIN 
			Set @identifier = 'Business Name'
			Select @O = Business_name from deleted
			Select @N = Business_name from inserted
		End

	If  UPDATE(Job) 
		BEGIN 
			Set @identifier = 'Job'
			Select @O = Job from deleted
			Select @N = Job from inserted
		End

	If  UPDATE(Salary) 
		BEGIN 
			Set @identifier = 'Salary'
			Select @O = Salary from deleted
			Select @N = Salary from inserted
		End
	insert into RDU_Stats
	values('Employee '+@identifier+' with Trn = '+@trn+ ' was updated from: ' +@O+ ' to: ' +@N+' on'+ GETDATE())
End




DROP TRIGGER RDU_Address_Update
Create Trigger RDU_Address_Update
On User_Address
After Update
As 
Begin
	Declare @trn int;
	Select @trn = Trn from deleted

	Declare @identifier Varchar(25);
	Declare @O Varchar(50);
	Declare @N Varchar(50);

	If  UPDATE(first_Line) 
		BEGIN 
			Set @identifier = 'first Line'
			Select @O = first_Line from deleted
			Select @N = first_Line from inserted
		End

	If  UPDATE(City) 
		BEGIN 
			Set @identifier = 'City'
			Select @O = City from deleted
			Select @N = City from inserted
		End

	If  UPDATE(Parish) 
		BEGIN 
			Set @identifier = 'Parish'
			Select @O = Parish from deleted
			Select @N = Parish from inserted
		End

	insert into RDU_Stats
	values('Address '+@identifier+' with Trn = '+@trn+ ' was updated from: ' +@O+ ' to: ' +@N+' on'+ GETDATE())
End





CRE




Create view View_User
as
	Select *from User_Data


Create view View_Employer
as
	Select *from Employer


Create view View_Employee
as
	Select *from Employee


Create view View_Address
as
	Select *from User_Address


Create view View_RDU_Stats
as
	Select *from RDU_Stats


Create view View_Theshold_Log
as
	Select *from Theshold_Log


CREATE PROCEDURE spTotalPaid (@trn)

DECLARE @trn int,
DECLARE @period date,
DECLARE @nis float,
DECLARE @nht float,
DECLARE @heart float,
DECLARE @paye float

as 
begin
if(trn=@trn)
begin
@total=@total+@nis+@nht+@heart+@paye


get year
 y2d fin cur year select ++

 CREATE TABLE [dbo].[payments](
	[PID] [int] IDENTITY(1,1) NOT NULL,
	[EmpTRN] [int] NULL,
	[CompanyTRN] [int] NULL,
	[Pay_Date] [date] NULL,
	[Pay_amount] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[PID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[payments]  WITH CHECK ADD  CONSTRAINT [fk_cTRN] FOREIGN KEY([CompanyTRN])
REFERENCES [dbo].[Employer] ([Trn])
GO

ALTER TABLE [dbo].[payments] CHECK CONSTRAINT [fk_cTRN]
GO

ALTER TABLE [dbo].[payments]  WITH CHECK ADD  CONSTRAINT [fk_eTRN] FOREIGN KEY([EmpTRN])
REFERENCES [dbo].[Employee] ([Trn])
GO

ALTER TABLE [dbo].[payments] CHECK CONSTRAINT [fk_eTRN]
GO












Create Table Tax_type(

	NHT float,
	Payee float,
	Income_Tax float
);
drop table Tax_type


Create Table  Theshold_Stats(
trn INTEGER PRIMARY KEY,
nis float  NULL,
nht float  NULL,
edTax float NULL,
heart float NULL,
paye float NULL,
salary float NULL,
addition float NULL,
total float NULL
CONSTRAINT FK_Theshold_Stats FOREIGN KEY (trn) REFERENCES Employee(Trn)
);
ALTER TABLE Theshold_Stats
ADD period date

--calculate 
/*drop procedure Employee_Reg
drop procedure SomeEmployee
drop procedure FullEmployee
drop procedure SomeEmployee
drop table Employee*/

CREATE  PROCEDURE sp_Calucation
(
@trn integer,
@nis float,
@nht float,
@edTax float,
@heart float,
@paye float,
@salary float ,
@addition float ,
@total float,
@period date
)
AS
	BEGIN
	   SET @total= @salary+@addition
		IF(1500096<=@total and @total<6000000)
		BEGIN
			SET @paye=0.25*@total
		 END
			ELSE
			IF(@total>6000000)
			BEGIN
			SET @paye=0.30*@total
			END
				ELSE
				BEGIN
				SET @nis=0.025*@total
				SET @nht=0.02*@total
				SET @edTax=(@total-@nis)*2.25
					
					SET @heart= @total*0.03 --needs to be only for those persons who are heart students
					END
					/*ELSE 
					BEGIN
					SET @heart=0
					END*/
							
INSERT INTO  Theshold_Stats (trn,nis,nht,edTax,heart,salary, addition, total) 
VALUES (@trn,@nis,@nht,@edTax,@heart,@salary,@addition,@total,@period)

	END




Create Table Benefits(


);


