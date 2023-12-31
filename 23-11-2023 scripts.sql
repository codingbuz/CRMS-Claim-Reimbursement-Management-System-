USE claimdatabase
GO
/****** Object:  Database [emsdb]    Script Date: 11/23/2023 10:11:44 PM ******/
CREATE DATABASE [emsdb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'emsdb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\emsdb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'emsdb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\emsdb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [emsdb] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [emsdb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [emsdb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [emsdb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [emsdb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [emsdb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [emsdb] SET ARITHABORT OFF 
GO
ALTER DATABASE [emsdb] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [emsdb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [emsdb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [emsdb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [emsdb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [emsdb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [emsdb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [emsdb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [emsdb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [emsdb] SET  ENABLE_BROKER 
GO
ALTER DATABASE [emsdb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [emsdb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [emsdb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [emsdb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [emsdb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [emsdb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [emsdb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [emsdb] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [emsdb] SET  MULTI_USER 
GO
ALTER DATABASE [emsdb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [emsdb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [emsdb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [emsdb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [emsdb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [emsdb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [emsdb] SET QUERY_STORE = OFF
GO
USE [emsdb]
GO
/****** Object:  UserDefinedFunction [dbo].[HashPassword]    Script Date: 11/23/2023 10:11:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[HashPassword](@pass varchar(100))
returns nvarchar(500)
as
begin
declare @afterhash varbinary(500) = HASHBYTES('SHA2_256', @pass)
return convert(nvarchar(1000), @afterhash, 2) 
end
GO
/****** Object:  Table [dbo].[Claim_Master]    Script Date: 11/23/2023 10:11:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Claim_Master](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Claim_Title] [varchar](100) NULL,
	[Claim_Reason] [varchar](100) NULL,
	[Amount] [decimal](18, 0) NULL,
	[ClaimDt] [datetime] NULL,
	[Evidence] [varchar](500) NULL,
	[Claim_Description] [varchar](500) NULL,
	[CurrentStatus] [varchar](50) NULL,
	[Status] [tinyint] NULL,
	[UserId] [int] NULL,
	[ExpenseDt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee_Claim_Action]    Script Date: 11/23/2023 10:11:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee_Claim_Action](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClaimId] [int] NULL,
	[Action] [varchar](100) NULL,
	[ActionBy] [int] NULL,
	[ActionDt] [datetime] NULL,
	[Remarks] [varchar](100) NULL,
	[Status] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee_Claim_Master_Mapping]    Script Date: 11/23/2023 10:11:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee_Claim_Master_Mapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CurrentAction] [varchar](100) NULL,
	[NextAction] [varchar](100) NULL,
	[Status] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee_Claim_Role_Master]    Script Date: 11/23/2023 10:11:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee_Claim_Role_Master](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Role] [varchar](100) NULL,
	[Action] [varchar](100) NULL,
	[Status] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee_Claim_Transaction]    Script Date: 11/23/2023 10:11:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee_Claim_Transaction](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Transaction_No] [varchar](100) NULL,
	[Employee_Id] [int] NULL,
	[Amount] [decimal](18, 0) NULL,
	[TransactionDt] [datetime] NULL,
	[ClaimId] [int] NULL,
	[Status] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Program_Master]    Script Date: 11/23/2023 10:11:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Program_Master](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[P_title] [varchar](100) NULL,
	[Path] [varchar](500) NULL,
	[Descr] [varchar](500) NULL,
	[Display_Sequence] [int] NULL,
	[Status] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Program_master_temp]    Script Date: 11/23/2023 10:11:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Program_master_temp](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[P_title] [varchar](100) NULL,
	[Path] [varchar](500) NULL,
	[Descr] [varchar](500) NULL,
	[Display_Sequence] [int] NULL,
	[Status] [tinyint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role_Employee_Mapping]    Script Date: 11/23/2023 10:11:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role_Employee_Mapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NULL,
	[EmpId] [int] NULL,
	[Status] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role_master]    Script Date: 11/23/2023 10:11:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role_master](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Role] [varchar](100) NULL,
	[Status] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_Rights]    Script Date: 11/23/2023 10:11:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Rights](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Programe_id] [int] NULL,
	[UserId] [int] NULL,
	[RoleId] [int] NULL,
	[Status] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User_Master]    Script Date: 11/23/2023 10:11:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_Master](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nm] [varchar](100) NULL,
	[Email] [varchar](100) NULL,
	[Mobile] [varchar](100) NULL,
	[Password] [varchar](500) NULL,
	[Manager_Id] [int] NULL,
	[Status] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[raise_error]    Script Date: 11/23/2023 10:11:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[raise_error]
as
begin

   DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();
		
    RAISERROR (@ErrorMessage, -- Message text.
               @ErrorSeverity, -- Severity.
               @ErrorState -- State.
               );
	end
GO
/****** Object:  StoredProcedure [dbo].[usd_get_program_path]    Script Date: 11/23/2023 10:11:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usd_get_program_path]
@UserId INT
as
begin
select p.Id,
	p.P_title title,
  CASE WHEN p.Path='Claim/ShowClaim' THEN	p.path+'?Role='+(select Role from Role_master(nolock) 
			where Id=(select RoleId from Role_Employee_Mapping(nolock) where EmpId=@UserId)) 
			ELSE p.Path END
			path,
	p.Descr
	from Program_Master p 
	inner join Tbl_Rights tr on p.Id=tr.Programe_id 
		where tr.UserId = @UserId 
		AND ( p.Status =1 AND tr.Status =1 )
		OR
		tr.RoleId in(SELECT RoleId FROM Role_Employee_Mapping(nolock) where EmpId=@UserId )

		order by p.Display_Sequence

end
GO
/****** Object:  StoredProcedure [dbo].[USP_CLAIM_TRANSACTION]    Script Date: 11/23/2023 10:11:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_CLAIM_TRANSACTION]
@empId INT,
@claimId INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN claim_tran
		DECLARE @amount DECIMAL;

		SELECT @amount = Amount FROM Claim_Master(NOLOCK) WHERE Id = @claimId;
		INSERT INTO Employee_Claim_Transaction(Transaction_No, Employee_Id, Amount, TransactionDt, ClaimId, Status) 
				VALUES(
					4585,
					@empId,
					@amount,
					GETDATE(),
					@claimId,
					1
					)
		COMMIT TRAN claim_tran
		END TRY
		BEGIN CATCH
		ROLLBACK TRAN claim_tran
		EXEC raise_error
		END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[usp_get_claim_action_history]    Script Date: 11/23/2023 10:11:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[usp_get_claim_action_history]
@claim_id int
as
begin

select 
convert(varchar(100),ec.ActionDt,103) ActionDt,
ur.Nm,
CASE
	WHEN ec.Action='Initiated' THEN 'Claim Raised by '+ur.Nm
	WHEN ec.Action='Pending at HR' THEN 'Claim approved by Manager '+ur.Nm
	WHEN ec.Action='Rejected By Manager' THEN 'Claim rejected by Manager'+ ur.Nm
	WHEN ec.Action='Rejected By HR' THEN 'Claim rejected by HR'+ur.Nm
	WHEN ec.Action='Pending at Account' THEN 'Claim approved by HR'+ur.Nm
	WHEN ec.Action='Completed' THEN 'Claim completed by Account '+ur.Nm END Action,

ec.Remarks from Employee_Claim_Action(nolock)ec
JOIN
User_Master(nolock)ur on ur.Id=ec.ActionBy
where ec.ClaimId=@claim_id

end
GO
/****** Object:  StoredProcedure [dbo].[USP_GET_Pending_Request]    Script Date: 11/23/2023 10:11:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GET_Pending_Request]
@role varchar(20),
@userid int
as
begin

	select cm.Id,
			cm.Amount,
			cm.Claim_Title,
			cm.Claim_Reason,
			cm.Claim_Description,
			cm.ClaimDt,
			cm.Evidence,
			cm.ExpenseDt,
			cm.CurrentStatus,
			um.Nm
	from Claim_Master(nolock) cm
	JOIN
	User_Master(nolock)um on um.Id=cm.UserId
	WHERE cm.CurrentStatus=(
	select rm.Action from 
	Employee_Claim_Role_Master(nolock)rm where rm.Role=@role
	) AND ( um.Manager_Id= CASE WHEN @role = 'Manager' THEN 
			@userid ELSE um.Manager_Id
			END)


end
GO
/****** Object:  StoredProcedure [dbo].[usp_get_transaction_data]    Script Date: 11/23/2023 10:11:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_get_transaction_data]
@UserId INT
AS
BEGIN

SELECT
		t.Transaction_No ,
		c.Claim_Title,
		c.Claim_Reason,
		c.Amount,
		c.Claim_Description,
		c.ClaimDt,
		t.TransactionDt,
		u.Nm ApprovedBy
	FROM Employee_Claim_Transaction(nolock)t
		JOIN Claim_Master(nolock)c on c.Id=t.ClaimId
		JOIN User_Master(nolock) u on u.Id=t.Employee_Id
		WHERE c.UserId=@UserId
END
GO
/****** Object:  StoredProcedure [dbo].[usp_get_user_by_email]    Script Date: 11/23/2023 10:11:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_get_user_by_email]
@email varchar(100)
as
begin

select Id,Nm,Email,Mobile,Manager_Id 
		from User_Master(nolock) 
				where Email=@email
end
GO
/****** Object:  StoredProcedure [dbo].[usp_get_user_by_role_id]    Script Date: 11/23/2023 10:11:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_get_user_by_role_id]
@role_id int
as
begin

select mst.Id,Nm from User_Master(nolock )mst
		JOIN Role_Employee_Mapping(nolock) rr on rr.EmpId=mst.Id
		where rr.RoleId=@role_id
		
end
GO
/****** Object:  StoredProcedure [dbo].[USP_LoginUser]    Script Date: 11/23/2023 10:11:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_LoginUser]
@email varchar(50),
@pass varchar(100)
as
begin
	if(EXISTS(SELECT 1 from User_Master(NOLOCK) where Email=@email and Status=1))
	begin
	if exists (select 1 from User_Master where Email = @email AND Password = dbo.HashPassword(@pass))
	begin
		select 1 as result
	end
	else
	begin
		select 2 as result
	end
	end
	else
	begin
	select 3 as result
	end
end
GO
/****** Object:  StoredProcedure [dbo].[USP_Manage_User]    Script Date: 11/23/2023 10:11:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--select* from User_Master
--  exec USP_Manage_User @Action='getall',@Id= 7

CREATE PROC [dbo].[USP_Manage_User]
@Action Varchar(20), --create,update,get
@Id INT=NULL,
@Nm Varchar(100)=null,
@Email Varchar(100)=null,
@Mobile Varchar(100)=null,
@Password Varchar(100)=null,
@Manager INT=null,
@Status TinyINT=null
as
begin

if(@Action='create')
begin
	INSERT INTO User_Master(Nm,
						Email,
						Mobile,
						Password,
						Manager_Id,
						Status)
						VALUES
						(
						@Nm,
						@Email,
						@Mobile,
						dbo.HashPassword(@Password),
						@Manager,
						@Status
						)
	select 1 as result
	end
	else if(@Action='update')
		begin
		update User_Master set
						Nm=@Nm,
						Email=@Email,
						Mobile=@Mobile,
						Manager_Id=@Manager,
						Status=@Status
				where Id=@Id
	select 1 as result
		end
	else if(@Action='get')
	begin
	select	 id,	nm,
				Email,
				Mobile,
				Manager_Id,
				Status
		from User_Master where Id=ISNULL(@Id,Id)
	end
	else if(@Action='getall')
	begin
	select	u.id,	u.nm,
				u.Email,
				u.Mobile,
				u1.Nm Manager,
				CASE WHEN u.Status=1 THEN 'Active'
					ELSE 'InActive' END Status
		from User_Master u
			left JOIN
			User_Master u1 ON u.Manager_Id=u1.Id
			where u.Id<>@Id
		
	end
end


GO
/****** Object:  StoredProcedure [dbo].[USP_Raise_Claim_Request]    Script Date: 11/23/2023 10:11:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec USP_Raise_Claim_Request 'Refund pertrol charges','travel',2000,'2023-10-02','fake.jpg','test',2

--select* from Claim_Master


--truncate table Employee_Claim_Action


CREATE proc [dbo].[USP_Raise_Claim_Request]
@Claim_Title varchar(100),
@Claim_Reason varchar(50),
@Amount DECIMAL,
@ExpenseDt varchar(100),
@Evidence varchar(500)=null,
@Claim_Description varchar(500),
@UserId int
as 
begin

	Declare @current_status varchar(100)
	Declare @ClaimID INT
	select @current_status=NextAction 
			from Employee_Claim_Master_Mapping(nolock) 
				where CurrentAction='Initiated'
	
	
	if(EXISTS(SELECT 1 FROM Claim_Master(NOLOCK) where UserId=@UserId AND CurrentStatus LIKE '%Pending%'))
	BEGIN
	THROW 50000, 'Claim already in pending', 1
	--raiserror('Claim already in pending',1,16)
	return
	END
	begin try
	begin transaction trn_claim
	insert into Claim_Master 
				(Claim_Title,
				Claim_Reason,
				Amount,
				ClaimDt,
				Evidence,
				Claim_Description,
				CurrentStatus,
				Status,
				UserId,
				ExpenseDt)
			VALUES
				(
				@Claim_Title,
				@Claim_Reason,
				@Amount,
				GETDATE(),
				@Evidence,
				@Claim_Description,
				@current_status,
				1,
				@UserId,
				@ExpenseDt		
				)
	SET @ClaimID=SCOPE_IDENTITY();
	
	----------insert record in action table----------------
	insert into Employee_Claim_Action(
					ClaimId,
					Action,
					ActionBy,
					ActionDt,
					Remarks,
					Status
					)
					VALUES
					(
					@ClaimID,
					'Initiated',
					@UserId,
					GETDATE(),
					@Claim_Description,
					1
					)
	Commit transaction trn_claim
	-------------------
	end try
	begin catch
	rollback transaction trn_claim
	exec raise_error
	end catch
	end





GO
/****** Object:  StoredProcedure [dbo].[usp_update_claim]    Script Date: 11/23/2023 10:11:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[usp_update_claim]
@role varchar(20),
@action tinyint, --action will 1-approve 0-reject
@remark varchar(200),
@claimid int,
@userid int
as
begin

declare @current_status varchar(100)
declare @next_action varchar(100)

select @current_status=CurrentStatus 
		from Claim_Master(nolock)cm where cm.Id=@claimid

select @next_action=NextAction 
		from Employee_Claim_Master_Mapping(nolock)mp
			where mp.CurrentAction=@current_status and mp.Status=@action

begin tran trn_update_claim
	begin try
	update Claim_Master set CurrentStatus=@next_action where Id=@claimid

	insert into Employee_Claim_Action(
						ClaimId,
						Action,
						ActionBy,
						ActionDt,
						Remarks,
						Status
						)
				values
						(@claimid,
						@next_action,
						@userid,
						getdate(),
						@remark,
						1 
						)
	IF @role = 'Account'
		BEGIN
			EXEC USP_CLAIM_TRANSACTION @userid, @claimid;
		END

	commit tran trn_update_claim
	end try
	begin catch
	rollback tran trn_update_claim
	end catch



end
GO
USE [master]
GO
ALTER DATABASE [emsdb] SET  READ_WRITE 
GO
