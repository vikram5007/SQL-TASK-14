CREATE DATABASE SQL14

CREATE TABLE hobbies(
hobby_id int primary key,
hobby_name varchar(20) unique
)

-----------a) INSERTING VALUES USING STORED PROCEDURE -----------

alter procedure hobbies_insert(@id int,@name varchar(20))
as
begin
    insert into hobbies values(@id,@name)
end;

exec hobbies_insert 1,cricket
exec hobbies_insert 2,singing
exec hobbies_insert 3,'table tennis'
exec hobbies_insert 4,volleyball
select*from hobbies

----------------2.CREATING A TABLE TO STORE ALL ERRORS --------------------

create table error_backup(
ErrorID        INT IDENTITY(1, 1),
          UserName       VARCHAR(100),
          ErrorNumber    INT,
          ErrorState     INT,
          ErrorSeverity  INT,
          ErrorLine      INT,
          ErrorProcedure VARCHAR(MAX),
          ErrorMessage   VARCHAR(MAX),
          ErrorDateTime  DATETIME

		  )

-------------3.PROCEDURE OF TRY CATCH TO INSERT THE VALUES IN THE HOOBIES TABLE AND ERROR_BACKUP TABLE ---------------

create  procedure error_handling(@id int,@name varchar(20))
as
begin try
insert into hobbies values(@id,@name)
end try
begin catch
insert into dbo.error_backup values(SUSER_SNAME(),
   ERROR_NUMBER(),
   ERROR_STATE(),
   ERROR_SEVERITY(),
   ERROR_LINE(),
   ERROR_PROCEDURE(),
   ERROR_MESSAGE(),
   GETDATE());
   end catch

  
   exec error_handling 5,carrom
   exec error_handling 5,carrom
    select*from hobbies
   select * from error_backup

   -----------------b) Create a procedure to accept 2 numbers, if the numbers are equal then calculate the product else use RAISERROR to show the working of exception handling.---------------------


   create procedure product(@num1 int,@num2 int)
   as begin
   declare @productval int
   set @productval=0
   if(@num1=@num2)
   begin 
   set @productval=@num1*@num2
   print'THE PRODUCT OF '+cast(@num1 as varchar)+' AND '+cast(@num2 as varchar)+' IS : '+cast(@productval as varchar)
   end
   else 
   begin
   raiserror ('THE NUMBERS ARE NOT EQUAL',16,1) 
   END
   END

   exec product 10,10
   exec product 10,20


   ---- c) Create a table Friends(id(identity), name (uk)) and insert records into the table using a stored procedure.
   ---------- Note: insert the names which start only with A,D,H,K,P,R,S,T,V,Y ELSE using THROW give the error details.------

   create table friends(
   friends int identity(1,1),
   name varchar(20) unique
   )

  create procedure friends_insert(@name varchar(25))
  as begin

if (@name like '[A,D,H,K,P,R,S,T,V,Y]%')
begin
insert into friends(name) values(@name)
select * from friends
end
else
begin
throw 500001,'NAME VALUE SHOULD CONTAIN FIRST LETTER AS A,D,H,K,P,R,S,T,V,Y',1;
end
end


  friends_insert vikram
  friends_insert vasanth

  select * from friends


  ------------------------------- END ------------------------------------------------
