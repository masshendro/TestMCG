USE [master]
GO
/****** Object:  Database [MDKAReservasi]    Script Date: 10/02/2021 11:00:12 ******/
CREATE DATABASE [MDKAReservasi]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MDKAReservasi', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\MDKAReservasi.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MDKAReservasi_log', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\MDKAReservasi_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [MDKAReservasi] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MDKAReservasi].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MDKAReservasi] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MDKAReservasi] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MDKAReservasi] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MDKAReservasi] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MDKAReservasi] SET ARITHABORT OFF 
GO
ALTER DATABASE [MDKAReservasi] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MDKAReservasi] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MDKAReservasi] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MDKAReservasi] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MDKAReservasi] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MDKAReservasi] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MDKAReservasi] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MDKAReservasi] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MDKAReservasi] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MDKAReservasi] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MDKAReservasi] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MDKAReservasi] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MDKAReservasi] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MDKAReservasi] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MDKAReservasi] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MDKAReservasi] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MDKAReservasi] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MDKAReservasi] SET RECOVERY FULL 
GO
ALTER DATABASE [MDKAReservasi] SET  MULTI_USER 
GO
ALTER DATABASE [MDKAReservasi] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MDKAReservasi] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MDKAReservasi] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MDKAReservasi] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MDKAReservasi] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [MDKAReservasi] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'MDKAReservasi', N'ON'
GO
ALTER DATABASE [MDKAReservasi] SET QUERY_STORE = OFF
GO
USE [MDKAReservasi]
GO
/****** Object:  Table [dbo].[tblM_Ruangan]    Script Date: 10/02/2021 11:00:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblM_Ruangan](
	[Ruangan_PK] [int] IDENTITY(1,1) NOT NULL,
	[NamaRuangan] [nvarchar](200) NULL,
	[Lantai] [int] NULL,
	[DayaTampung] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[Status_FK] [int] NULL,
 CONSTRAINT [PK_tblM_Ruangan] PRIMARY KEY CLUSTERED 
(
	[Ruangan_PK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblM_Status]    Script Date: 10/02/2021 11:00:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblM_Status](
	[Status_PK] [int] IDENTITY(1,1) NOT NULL,
	[NamaStatus] [nvarchar](200) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_tblM_Status] PRIMARY KEY CLUSTERED 
(
	[Status_PK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblT_Reservasi]    Script Date: 10/02/2021 11:00:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblT_Reservasi](
	[Reservasi_PK] [int] IDENTITY(1,1) NOT NULL,
	[Ruangan_FK] [int] NULL,
	[SubjectReservasi] [nvarchar](max) NULL,
	[TanggalReservasi] [date] NULL,
	[JamMulai] [time](7) NULL,
	[JamSelesai] [time](7) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_tblT_Reservasi] PRIMARY KEY CLUSTERED 
(
	[Reservasi_PK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblT_Reservasi] ADD  CONSTRAINT [DF_tblT_Reservasi_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[tblM_Ruangan]  WITH CHECK ADD  CONSTRAINT [FK_StatusRuang] FOREIGN KEY([Status_FK])
REFERENCES [dbo].[tblM_Status] ([Status_PK])
GO
ALTER TABLE [dbo].[tblM_Ruangan] CHECK CONSTRAINT [FK_StatusRuang]
GO
/****** Object:  StoredProcedure [dbo].[sp_Edit_reserv]    Script Date: 10/02/2021 11:00:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_Edit_reserv]
	@Reservasi_PK int
      ,@SubjectReservasi as varchar(max)
      ,@TanggalReservasi as date
      ,@JamMulai as time
      ,@JamSelesai as time
as
Begin
update [MDKAReservasi].[dbo].[tblT_Reservasi] set
	   [SubjectReservasi]=@SubjectReservasi
      ,[TanggalReservasi]=@TanggalReservasi
      ,[JamMulai]=@JamMulai
      ,[JamSelesai]=@JamSelesai
	  where Reservasi_PK=@Reservasi_PK
End
GO
/****** Object:  StoredProcedure [dbo].[SP_Get_List_Sch]    Script Date: 10/02/2021 11:00:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[SP_Get_List_Sch]
as
Begin
  select a.Reservasi_PK,a.Ruangan_FK,b.NamaRuangan,a.SubjectReservasi,a.TanggalReservasi,left(a.JamMulai,5) as jamMulai,left(a.JamSelesai ,5) as JamSelesai
  from [MDKAReservasi].[dbo].[tblT_Reservasi] a
  inner join [MDKAReservasi].[dbo].tblM_Ruangan b on b.Ruangan_PK=a.Ruangan_FK

End
GO
/****** Object:  StoredProcedure [dbo].[SP_Get_Room]    Script Date: 10/02/2021 11:00:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[SP_Get_Room]
@StatusRoom as varchar(8)
as
Begin
SELECT [Ruangan_PK]
      ,[NamaRuangan]
   --   ,[Lantai]
   --   ,[DayaTampung]
   --   ,[Status_FK]
	  --,[NamaStatus]
  FROM [MDKAReservasi].[dbo].[tblM_Ruangan] a
  inner join [dbo].[tblM_Status] b on b.Status_PK=a.Status_FK
  where NamaStatus=@StatusRoom

End
GO
/****** Object:  StoredProcedure [dbo].[SP_Get_Room_status]    Script Date: 10/02/2021 11:00:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[SP_Get_Room_status]
@StatusRoom as varchar(8)
as
Begin
SELECT c.Reservasi_PK
	  ,a.NamaRuangan
	  ,c.SubjectReservasi
	  ,c.TanggalReservasi,c.JamMulai,c.JamSelesai,b.NamaStatus
  FROM [MDKAReservasi].[dbo].[tblM_Ruangan] a
  inner join [dbo].[tblM_Status] b on b.Status_PK=a.Status_FK
  left join [dbo].[tblT_Reservasi] c on c.Ruangan_FK=a.Ruangan_PK
  where NamaStatus=@StatusRoom 
End
GO
/****** Object:  StoredProcedure [dbo].[sp_New_reserv]    Script Date: 10/02/2021 11:00:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_New_reserv]
	@Ruangan_FK varchar
      ,@SubjectReservasi as varchar(max)
      ,@TanggalReservasi as date
      ,@JamMulai as time
      ,@JamSelesai as time
as
Begin

  insert into [MDKAReservasi].[dbo].[tblT_Reservasi](
	   [Ruangan_FK]
      ,[SubjectReservasi]
      ,[TanggalReservasi]
      ,[JamMulai]
      ,[JamSelesai]
  )
  Select @Ruangan_FK,@SubjectReservasi,@TanggalReservasi,@JamMulai,@JamSelesai

  update [MDKAReservasi].[dbo].tblM_Ruangan set Status_FK=1 where Ruangan_PK=@Ruangan_FK 

End
GO
/****** Object:  StoredProcedure [dbo].[sp_Rem_reserv]    Script Date: 10/02/2021 11:00:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_Rem_reserv]
	@Reservasi_PK int
as
Begin

	  Update b set b.Status_FK=2 from [MDKAReservasi].[dbo].[tblT_Reservasi] a
	  inner join [dbo].[tblM_Ruangan] b on b.Ruangan_PK=a.Ruangan_FK
	  where a.Reservasi_PK=@Reservasi_PK

	  Delete [MDKAReservasi].[dbo].[tblT_Reservasi]
	  Where Reservasi_PK=@Reservasi_PK

End
GO
USE [master]
GO
ALTER DATABASE [MDKAReservasi] SET  READ_WRITE 
GO
