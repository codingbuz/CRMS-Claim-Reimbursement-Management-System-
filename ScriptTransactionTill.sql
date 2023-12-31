USE [emsdb]
GO
/****** Object:  UserDefinedFunction [dbo].[HashPassword]    Script Date: 11/9/2023 10:06:27 PM ******/
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
/****** Object:  Table [dbo].[Claim_Master]    Script Date: 11/9/2023 10:06:27 PM ******/
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
/****** Object:  Table [dbo].[Employee_Claim_Action]    Script Date: 11/9/2023 10:06:27 PM ******/
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
/****** Object:  Table [dbo].[Employee_Claim_Master_Mapping]    Script Date: 11/9/2023 10:06:27 PM ******/
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
/****** Object:  Table [dbo].[Employee_Claim_Role_Master]    Script Date: 11/9/2023 10:06:27 PM ******/
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
/****** Object:  Table [dbo].[Employee_Claim_Transaction]    Script Date: 11/9/2023 10:06:27 PM ******/
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
/****** Object:  Table [dbo].[Program_Master]    Script Date: 11/9/2023 10:06:27 PM ******/
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
/****** Object:  Table [dbo].[Program_master_temp]    Script Date: 11/9/2023 10:06:27 PM ******/
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
/****** Object:  Table [dbo].[Role_Employee_Mapping]    Script Date: 11/9/2023 10:06:27 PM ******/
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
/****** Object:  Table [dbo].[Role_master]    Script Date: 11/9/2023 10:06:27 PM ******/
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
/****** Object:  Table [dbo].[Tbl_Rights]    Script Date: 11/9/2023 10:06:27 PM ******/
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
/****** Object:  Table [dbo].[User_Master]    Script Date: 11/9/2023 10:06:27 PM ******/
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
SET IDENTITY_INSERT [dbo].[Claim_Master] ON 

INSERT [dbo].[Claim_Master] ([Id], [Claim_Title], [Claim_Reason], [Amount], [ClaimDt], [Evidence], [Claim_Description], [CurrentStatus], [Status], [UserId], [ExpenseDt]) VALUES (1, N'Food expense', N'Food', CAST(4500 AS Decimal(18, 0)), CAST(N'2023-11-02T21:35:01.273' AS DateTime), N'EvidenceFiles/Evidence_cb789437-a570-4f5b-9e3f-5ac46f29bcb0.jpg', N'test', N'Completed', 1, 2, CAST(N'2023-11-03T00:00:00.000' AS DateTime))
INSERT [dbo].[Claim_Master] ([Id], [Claim_Title], [Claim_Reason], [Amount], [ClaimDt], [Evidence], [Claim_Description], [CurrentStatus], [Status], [UserId], [ExpenseDt]) VALUES (2, N'Mobile Recharge', N'Mobile Recharge', CAST(1000 AS Decimal(18, 0)), CAST(N'2023-11-06T20:41:41.787' AS DateTime), N'EvidenceFiles/Evidence_0791f573-823e-4a4a-95e9-d36a37f3676c.txt', N'required remuburshiment', N'Completed', 1, 2, CAST(N'2023-11-06T00:00:00.000' AS DateTime))
INSERT [dbo].[Claim_Master] ([Id], [Claim_Title], [Claim_Reason], [Amount], [ClaimDt], [Evidence], [Claim_Description], [CurrentStatus], [Status], [UserId], [ExpenseDt]) VALUES (3, N'gg', N'Travel', CAST(55 AS Decimal(18, 0)), CAST(N'2023-11-07T12:11:16.740' AS DateTime), N'EvidenceFiles/Evidence_65e7b908-1994-4263-a7ec-db423962ad33.png', N'r', N'Pending at Manager', 1, 5, CAST(N'2023-11-08T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Claim_Master] OFF
GO
SET IDENTITY_INSERT [dbo].[Employee_Claim_Action] ON 

INSERT [dbo].[Employee_Claim_Action] ([Id], [ClaimId], [Action], [ActionBy], [ActionDt], [Remarks], [Status]) VALUES (1, 1, N'Initiated', 2, CAST(N'2023-11-02T21:35:01.273' AS DateTime), N'test', 1)
INSERT [dbo].[Employee_Claim_Action] ([Id], [ClaimId], [Action], [ActionBy], [ActionDt], [Remarks], [Status]) VALUES (2, 1, N'Pending at HR', 1, CAST(N'2023-11-04T20:09:58.943' AS DateTime), N'ok for approval', 1)
INSERT [dbo].[Employee_Claim_Action] ([Id], [ClaimId], [Action], [ActionBy], [ActionDt], [Remarks], [Status]) VALUES (3, 1, N'Pending at Account', 4, CAST(N'2023-11-04T20:17:05.383' AS DateTime), N'Ok for payment', 1)
INSERT [dbo].[Employee_Claim_Action] ([Id], [ClaimId], [Action], [ActionBy], [ActionDt], [Remarks], [Status]) VALUES (4, 1, NULL, 5, CAST(N'2023-11-04T20:20:40.593' AS DateTime), N'not ok', 1)
INSERT [dbo].[Employee_Claim_Action] ([Id], [ClaimId], [Action], [ActionBy], [ActionDt], [Remarks], [Status]) VALUES (5, 1, N'Completed', 5, CAST(N'2023-11-04T20:25:12.550' AS DateTime), N'ok for money', 1)
INSERT [dbo].[Employee_Claim_Action] ([Id], [ClaimId], [Action], [ActionBy], [ActionDt], [Remarks], [Status]) VALUES (6, 1, N'Completed', 5, CAST(N'2023-11-04T20:26:15.207' AS DateTime), N'ok', 1)
INSERT [dbo].[Employee_Claim_Action] ([Id], [ClaimId], [Action], [ActionBy], [ActionDt], [Remarks], [Status]) VALUES (7, 1, N'Completed', 5, CAST(N'2023-11-04T20:27:26.540' AS DateTime), N'okk', 1)
INSERT [dbo].[Employee_Claim_Action] ([Id], [ClaimId], [Action], [ActionBy], [ActionDt], [Remarks], [Status]) VALUES (8, 1, N'Completed', 5, CAST(N'2023-11-04T20:28:22.993' AS DateTime), N'okkk', 1)
INSERT [dbo].[Employee_Claim_Action] ([Id], [ClaimId], [Action], [ActionBy], [ActionDt], [Remarks], [Status]) VALUES (9, 2, N'Initiated', 2, CAST(N'2023-11-06T20:41:41.787' AS DateTime), N'required remuburshiment', 1)
INSERT [dbo].[Employee_Claim_Action] ([Id], [ClaimId], [Action], [ActionBy], [ActionDt], [Remarks], [Status]) VALUES (10, 2, N'Pending at HR', 1, CAST(N'2023-11-06T20:42:30.487' AS DateTime), N'ok for payment', 1)
INSERT [dbo].[Employee_Claim_Action] ([Id], [ClaimId], [Action], [ActionBy], [ActionDt], [Remarks], [Status]) VALUES (11, 2, N'Pending at Account', 4, CAST(N'2023-11-06T21:21:07.080' AS DateTime), N'ok now for payment', 1)
INSERT [dbo].[Employee_Claim_Action] ([Id], [ClaimId], [Action], [ActionBy], [ActionDt], [Remarks], [Status]) VALUES (12, 3, N'Initiated', 5, CAST(N'2023-11-07T12:11:16.740' AS DateTime), N'r', 1)
INSERT [dbo].[Employee_Claim_Action] ([Id], [ClaimId], [Action], [ActionBy], [ActionDt], [Remarks], [Status]) VALUES (13, 2, N'Completed', 5, CAST(N'2023-11-08T22:02:47.880' AS DateTime), N'Ok for Payment....', 1)
SET IDENTITY_INSERT [dbo].[Employee_Claim_Action] OFF
GO
SET IDENTITY_INSERT [dbo].[Employee_Claim_Master_Mapping] ON 

INSERT [dbo].[Employee_Claim_Master_Mapping] ([Id], [CurrentAction], [NextAction], [Status]) VALUES (1, N'Initiated', N'Pending at Manager', 1)
INSERT [dbo].[Employee_Claim_Master_Mapping] ([Id], [CurrentAction], [NextAction], [Status]) VALUES (2, N'Pending at Manager', N'Pending at HR', 1)
INSERT [dbo].[Employee_Claim_Master_Mapping] ([Id], [CurrentAction], [NextAction], [Status]) VALUES (3, N'Pending at Manager', N'Rejected By Manager', 0)
INSERT [dbo].[Employee_Claim_Master_Mapping] ([Id], [CurrentAction], [NextAction], [Status]) VALUES (4, N'Pending at HR', N'Pending at Account', 1)
INSERT [dbo].[Employee_Claim_Master_Mapping] ([Id], [CurrentAction], [NextAction], [Status]) VALUES (5, N'Pending at HR', N'Rejected By HR', 0)
INSERT [dbo].[Employee_Claim_Master_Mapping] ([Id], [CurrentAction], [NextAction], [Status]) VALUES (6, N'Pending at Account', N'Completed', 1)
SET IDENTITY_INSERT [dbo].[Employee_Claim_Master_Mapping] OFF
GO
SET IDENTITY_INSERT [dbo].[Employee_Claim_Role_Master] ON 

INSERT [dbo].[Employee_Claim_Role_Master] ([Id], [Role], [Action], [Status]) VALUES (1, N'Employee', N'Initiated', 1)
INSERT [dbo].[Employee_Claim_Role_Master] ([Id], [Role], [Action], [Status]) VALUES (2, N'Manager', N'Pending at Manager', 1)
INSERT [dbo].[Employee_Claim_Role_Master] ([Id], [Role], [Action], [Status]) VALUES (3, N'HR', N'Pending at HR', 1)
INSERT [dbo].[Employee_Claim_Role_Master] ([Id], [Role], [Action], [Status]) VALUES (4, N'Account', N'Pending at Account', 1)
SET IDENTITY_INSERT [dbo].[Employee_Claim_Role_Master] OFF
GO
SET IDENTITY_INSERT [dbo].[Employee_Claim_Transaction] ON 

INSERT [dbo].[Employee_Claim_Transaction] ([Id], [Transaction_No], [Employee_Id], [Amount], [TransactionDt], [ClaimId], [Status]) VALUES (1, N'4585', 5, CAST(1000 AS Decimal(18, 0)), CAST(N'2023-11-08T22:02:47.880' AS DateTime), 2, 1)
SET IDENTITY_INSERT [dbo].[Employee_Claim_Transaction] OFF
GO
SET IDENTITY_INSERT [dbo].[Program_Master] ON 

INSERT [dbo].[Program_Master] ([Id], [P_title], [Path], [Descr], [Display_Sequence], [Status]) VALUES (1, N'Add Claim', N'Claim/AddClaim', N'Add new claim', 0, 1)
INSERT [dbo].[Program_Master] ([Id], [P_title], [Path], [Descr], [Display_Sequence], [Status]) VALUES (2, N'Employee Claims', N'Claim/ShowClaim', N'show claim request', 1, 1)
INSERT [dbo].[Program_Master] ([Id], [P_title], [Path], [Descr], [Display_Sequence], [Status]) VALUES (3, N'Dashboard', N'Home/Dashboard', N'dashboard', 2, 1)
INSERT [dbo].[Program_Master] ([Id], [P_title], [Path], [Descr], [Display_Sequence], [Status]) VALUES (4, N'Show Claim Status', N'Claim/ClaimStatus', N'show claim', 3, 1)
INSERT [dbo].[Program_Master] ([Id], [P_title], [Path], [Descr], [Display_Sequence], [Status]) VALUES (5, N'Show Transaction History', N'Claim/Claimtransaction', N'show claim', 3, 1)
SET IDENTITY_INSERT [dbo].[Program_Master] OFF
GO
SET IDENTITY_INSERT [dbo].[Program_master_temp] ON 

INSERT [dbo].[Program_master_temp] ([Id], [P_title], [Path], [Descr], [Display_Sequence], [Status]) VALUES (4, N'Show Claim Status', N'Claim/ClaimStatus', N'show claim', 3, 1)
SET IDENTITY_INSERT [dbo].[Program_master_temp] OFF
GO
SET IDENTITY_INSERT [dbo].[Role_Employee_Mapping] ON 

INSERT [dbo].[Role_Employee_Mapping] ([Id], [RoleId], [EmpId], [Status]) VALUES (1, 1, 2, 1)
INSERT [dbo].[Role_Employee_Mapping] ([Id], [RoleId], [EmpId], [Status]) VALUES (2, 1, 3, 1)
INSERT [dbo].[Role_Employee_Mapping] ([Id], [RoleId], [EmpId], [Status]) VALUES (3, 2, 1, 1)
INSERT [dbo].[Role_Employee_Mapping] ([Id], [RoleId], [EmpId], [Status]) VALUES (4, 3, 4, 1)
INSERT [dbo].[Role_Employee_Mapping] ([Id], [RoleId], [EmpId], [Status]) VALUES (5, 4, 5, 1)
SET IDENTITY_INSERT [dbo].[Role_Employee_Mapping] OFF
GO
SET IDENTITY_INSERT [dbo].[Role_master] ON 

INSERT [dbo].[Role_master] ([Id], [Role], [Status]) VALUES (1, N'Employee', 1)
INSERT [dbo].[Role_master] ([Id], [Role], [Status]) VALUES (2, N'Manager', 1)
INSERT [dbo].[Role_master] ([Id], [Role], [Status]) VALUES (3, N'HR', 1)
INSERT [dbo].[Role_master] ([Id], [Role], [Status]) VALUES (4, N'Account', 1)
SET IDENTITY_INSERT [dbo].[Role_master] OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_Rights] ON 

INSERT [dbo].[Tbl_Rights] ([Id], [Programe_id], [UserId], [RoleId], [Status]) VALUES (1, 1, 1, NULL, 1)
INSERT [dbo].[Tbl_Rights] ([Id], [Programe_id], [UserId], [RoleId], [Status]) VALUES (2, 2, 1, NULL, 1)
INSERT [dbo].[Tbl_Rights] ([Id], [Programe_id], [UserId], [RoleId], [Status]) VALUES (3, 3, 1, NULL, 1)
INSERT [dbo].[Tbl_Rights] ([Id], [Programe_id], [UserId], [RoleId], [Status]) VALUES (4, 4, 1, NULL, 1)
INSERT [dbo].[Tbl_Rights] ([Id], [Programe_id], [UserId], [RoleId], [Status]) VALUES (5, 1, 2, NULL, 1)
INSERT [dbo].[Tbl_Rights] ([Id], [Programe_id], [UserId], [RoleId], [Status]) VALUES (6, 4, 2, NULL, 1)
INSERT [dbo].[Tbl_Rights] ([Id], [Programe_id], [UserId], [RoleId], [Status]) VALUES (7, 1, 3, NULL, 1)
INSERT [dbo].[Tbl_Rights] ([Id], [Programe_id], [UserId], [RoleId], [Status]) VALUES (8, 4, 3, NULL, 1)
INSERT [dbo].[Tbl_Rights] ([Id], [Programe_id], [UserId], [RoleId], [Status]) VALUES (9, 1, 4, NULL, 1)
INSERT [dbo].[Tbl_Rights] ([Id], [Programe_id], [UserId], [RoleId], [Status]) VALUES (10, 2, 4, NULL, 1)
INSERT [dbo].[Tbl_Rights] ([Id], [Programe_id], [UserId], [RoleId], [Status]) VALUES (11, 3, 4, NULL, 1)
INSERT [dbo].[Tbl_Rights] ([Id], [Programe_id], [UserId], [RoleId], [Status]) VALUES (12, 4, 4, NULL, 1)
INSERT [dbo].[Tbl_Rights] ([Id], [Programe_id], [UserId], [RoleId], [Status]) VALUES (13, 1, 5, NULL, 1)
INSERT [dbo].[Tbl_Rights] ([Id], [Programe_id], [UserId], [RoleId], [Status]) VALUES (14, 2, 5, NULL, 1)
INSERT [dbo].[Tbl_Rights] ([Id], [Programe_id], [UserId], [RoleId], [Status]) VALUES (15, 3, 5, NULL, 1)
INSERT [dbo].[Tbl_Rights] ([Id], [Programe_id], [UserId], [RoleId], [Status]) VALUES (16, 4, 5, NULL, 1)
INSERT [dbo].[Tbl_Rights] ([Id], [Programe_id], [UserId], [RoleId], [Status]) VALUES (17, 2, 3, NULL, 1)
INSERT [dbo].[Tbl_Rights] ([Id], [Programe_id], [UserId], [RoleId], [Status]) VALUES (18, 3, 3, NULL, 1)
INSERT [dbo].[Tbl_Rights] ([Id], [Programe_id], [UserId], [RoleId], [Status]) VALUES (19, 5, NULL, 1, 1)
SET IDENTITY_INSERT [dbo].[Tbl_Rights] OFF
GO
SET IDENTITY_INSERT [dbo].[User_Master] ON 

INSERT [dbo].[User_Master] ([Id], [Nm], [Email], [Mobile], [Password], [Manager_Id], [Status]) VALUES (1, N'Akash Kumar', N'akash123@gmail.com', N'93483943', N'5BD4D4E7AB3495A126035CC0FCF08557192B0B027CC54F4FEDE03449833A13B8', NULL, 1)
INSERT [dbo].[User_Master] ([Id], [Nm], [Email], [Mobile], [Password], [Manager_Id], [Status]) VALUES (2, N'Rahul Kumar', N'rahul213@gmail.com', N'73483943', N'6110E881C3B1912B7C4D0E63D645AC95F529FBEAE7BD80DA7DCC56438F757CD8', 1, 1)
INSERT [dbo].[User_Master] ([Id], [Nm], [Email], [Mobile], [Password], [Manager_Id], [Status]) VALUES (3, N'Mayank Kumar', N'mayank0023@gmail.com', N'88483943', N'535B3311338EAE13AEB2CB13263F6B5948158A7DEA55090D8313A57552D9D4D1', 1, 1)
INSERT [dbo].[User_Master] ([Id], [Nm], [Email], [Mobile], [Password], [Manager_Id], [Status]) VALUES (4, N'Sumit Kumar', N'smt03@gmail.com', N'78483943', N'F0769D93661E28CDD2625A6AAC07AFEF373A81D2CDC5292794D058AB71BA7C2C', 3, 1)
INSERT [dbo].[User_Master] ([Id], [Nm], [Email], [Mobile], [Password], [Manager_Id], [Status]) VALUES (5, N'Pawan Kumar', N'pawan123@gmail.com', N'87483943', N'476D0D465F370CBAB7C04A8B03BBFAAB92DA7F5DA2413AD6C05D4E3326885395', 1, 1)
SET IDENTITY_INSERT [dbo].[User_Master] OFF
GO
/****** Object:  StoredProcedure [dbo].[raise_error]    Script Date: 11/9/2023 10:06:27 PM ******/
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
/****** Object:  StoredProcedure [dbo].[usd_get_program_path]    Script Date: 11/9/2023 10:06:27 PM ******/
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
/****** Object:  StoredProcedure [dbo].[USP_CLAIM_TRANSACTION]    Script Date: 11/9/2023 10:06:27 PM ******/
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
/****** Object:  StoredProcedure [dbo].[usp_get_claim_action_history]    Script Date: 11/9/2023 10:06:27 PM ******/
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
/****** Object:  StoredProcedure [dbo].[USP_GET_Pending_Request]    Script Date: 11/9/2023 10:06:27 PM ******/
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
/****** Object:  StoredProcedure [dbo].[usp_get_transaction_data]    Script Date: 11/9/2023 10:06:27 PM ******/
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
/****** Object:  StoredProcedure [dbo].[usp_get_user_by_email]    Script Date: 11/9/2023 10:06:27 PM ******/
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
/****** Object:  StoredProcedure [dbo].[USP_LoginUser]    Script Date: 11/9/2023 10:06:27 PM ******/
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
/****** Object:  StoredProcedure [dbo].[USP_Raise_Claim_Request]    Script Date: 11/9/2023 10:06:27 PM ******/
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
/****** Object:  StoredProcedure [dbo].[usp_update_claim]    Script Date: 11/9/2023 10:06:27 PM ******/
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
