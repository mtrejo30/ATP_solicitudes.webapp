USE [CITAS_TEST]
GO
ALTER TABLE [dbo].[user_table] DROP CONSTRAINT [FK7358465AF3311853]
GO
ALTER TABLE [dbo].[user_table] DROP CONSTRAINT [FK7358465A46C448DB]
GO
ALTER TABLE [dbo].[user_table] DROP CONSTRAINT [FK7358465A1D6234DB]
GO
ALTER TABLE [dbo].[solicitud_comentario] DROP CONSTRAINT [FK8EE4B05C860049B9]
GO
ALTER TABLE [dbo].[solicitud_comentario] DROP CONSTRAINT [FK8EE4B05C7E12E2BB]
GO
ALTER TABLE [dbo].[solicitud_appointment] DROP CONSTRAINT [FKD217A2847E12E2BB]
GO
ALTER TABLE [dbo].[solicitud] DROP CONSTRAINT [FKAF52BEA4860049B9]
GO
ALTER TABLE [dbo].[documento_solicitud] DROP CONSTRAINT [FK18A03AD9860049B9]
GO
ALTER TABLE [dbo].[documento_solicitud] DROP CONSTRAINT [FK18A03AD97E12E2BB]
GO
ALTER TABLE [dbo].[documento_solicitud] DROP CONSTRAINT [FK18A03AD956069B43]
GO
/****** Object:  Table [dbo].[user_table]    Script Date: 04/03/2014 07:05:59 pm ******/
DROP TABLE [dbo].[user_table]
GO
/****** Object:  Table [dbo].[system_property]    Script Date: 04/03/2014 07:05:59 pm ******/
DROP TABLE [dbo].[system_property]
GO
/****** Object:  Table [dbo].[solicitud_comentario]    Script Date: 04/03/2014 07:05:59 pm ******/
DROP TABLE [dbo].[solicitud_comentario]
GO
/****** Object:  Table [dbo].[solicitud_appointment]    Script Date: 04/03/2014 07:05:59 pm ******/
DROP TABLE [dbo].[solicitud_appointment]
GO
/****** Object:  Table [dbo].[solicitud]    Script Date: 04/03/2014 07:05:59 pm ******/
DROP TABLE [dbo].[solicitud]
GO
/****** Object:  Table [dbo].[report_access_level]    Script Date: 04/03/2014 07:05:59 pm ******/
DROP TABLE [dbo].[report_access_level]
GO
/****** Object:  Table [dbo].[profile]    Script Date: 04/03/2014 07:05:59 pm ******/
DROP TABLE [dbo].[profile]
GO
/****** Object:  Table [dbo].[holiday]    Script Date: 04/03/2014 07:05:59 pm ******/
DROP TABLE [dbo].[holiday]
GO
/****** Object:  Table [dbo].[generic_blob]    Script Date: 04/03/2014 07:05:59 pm ******/
DROP TABLE [dbo].[generic_blob]
GO
/****** Object:  Table [dbo].[empresa]    Script Date: 04/03/2014 07:05:59 pm ******/
DROP TABLE [dbo].[empresa]
GO
/****** Object:  Table [dbo].[documento_solicitud]    Script Date: 04/03/2014 07:05:59 pm ******/
DROP TABLE [dbo].[documento_solicitud]
GO
/****** Object:  Table [dbo].[activity_log]    Script Date: 04/03/2014 07:05:59 pm ******/
DROP TABLE [dbo].[activity_log]
GO
/****** Object:  Table [dbo].[activity_log]    Script Date: 04/03/2014 07:05:59 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[activity_log](
	[id] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[accessed_from] [varchar](255) NULL,
	[action] [varchar](255) NULL,
	[data] [varchar](255) NULL,
	[module] [varchar](255) NULL,
	[timestamp] [datetime] NOT NULL,
	[username] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[documento_solicitud]    Script Date: 04/03/2014 07:06:00 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[documento_solicitud](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[clave] [varchar](255) NOT NULL,
	[content_type] [varchar](255) NULL,
	[date] [datetime] NOT NULL,
	[file_name] [varchar](255) NOT NULL,
	[document_status] [int] NOT NULL,
	[document_type] [int] NOT NULL,
	[blob_id] [int] NOT NULL,
	[solicitud_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[empresa]    Script Date: 04/03/2014 07:06:00 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[empresa](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[codigo] [varchar](3) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[generic_blob]    Script Date: 04/03/2014 07:06:00 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[generic_blob](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[data] [varbinary](max) NOT NULL,
	[type] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[holiday]    Script Date: 04/03/2014 07:06:00 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[holiday](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[date] [datetime] NOT NULL,
	[name] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[profile]    Script Date: 04/03/2014 07:06:00 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[profile](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[code] [varchar](10) NOT NULL,
	[name] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[report_access_level]    Script Date: 04/03/2014 07:06:00 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[report_access_level](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[code] [varchar](10) NOT NULL,
	[name] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[solicitud]    Script Date: 04/03/2014 07:06:00 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[solicitud](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[agencia_aduanal_id] [int] NULL,
	[cliente_id] [int] NULL,
	[paquete_id] [int] NULL,
	[date_created] [datetime] NOT NULL,
	[date_scheduled] [datetime] NULL,
	[date_updated] [datetime] NOT NULL,
	[operador_id] [int] NULL,
	[operation_type] [int] NOT NULL,
	[placas] [varchar](10) NULL,
	[reference] [varchar](100) NOT NULL,
	[status] [int] NOT NULL,
	[transportista_id] [int] NULL,
	[user_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[solicitud_appointment]    Script Date: 04/03/2014 07:06:00 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[solicitud_appointment](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[appointment_nbr] [varchar](20) NOT NULL,
	[date_created] [datetime] NOT NULL,
	[date_updated] [datetime] NOT NULL,
	[definition] [text] NOT NULL,
	[status] [int] NULL,
	[solicitud_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[solicitud_comentario]    Script Date: 04/03/2014 07:06:00 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[solicitud_comentario](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[comentario] [text] NULL,
	[fecha] [datetime] NOT NULL,
	[solicitud_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[system_property]    Script Date: 04/03/2014 07:06:00 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[system_property](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NULL,
	[value] [varchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[user_table]    Script Date: 04/03/2014 07:06:00 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[user_table](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[first_name] [varchar](50) NULL,
	[last_login] [datetime] NULL,
	[last_name] [varchar](50) NULL,
	[last_password_change] [datetime] NOT NULL,
	[password] [varchar](100) NOT NULL,
	[status] [int] NULL,
	[user_n4_id] [int] NULL,
	[username] [varchar](50) NOT NULL,
	[empresa_id] [int] NOT NULL,
	[profile_id] [int] NOT NULL,
	[report_access_level_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[documento_solicitud]  WITH CHECK ADD  CONSTRAINT [FK18A03AD956069B43] FOREIGN KEY([blob_id])
REFERENCES [dbo].[generic_blob] ([id])
GO
ALTER TABLE [dbo].[documento_solicitud] CHECK CONSTRAINT [FK18A03AD956069B43]
GO
ALTER TABLE [dbo].[documento_solicitud]  WITH CHECK ADD  CONSTRAINT [FK18A03AD97E12E2BB] FOREIGN KEY([solicitud_id])
REFERENCES [dbo].[solicitud] ([id])
GO
ALTER TABLE [dbo].[documento_solicitud] CHECK CONSTRAINT [FK18A03AD97E12E2BB]
GO
ALTER TABLE [dbo].[documento_solicitud]  WITH CHECK ADD  CONSTRAINT [FK18A03AD9860049B9] FOREIGN KEY([user_id])
REFERENCES [dbo].[user_table] ([id])
GO
ALTER TABLE [dbo].[documento_solicitud] CHECK CONSTRAINT [FK18A03AD9860049B9]
GO
ALTER TABLE [dbo].[solicitud]  WITH CHECK ADD  CONSTRAINT [FKAF52BEA4860049B9] FOREIGN KEY([user_id])
REFERENCES [dbo].[user_table] ([id])
GO
ALTER TABLE [dbo].[solicitud] CHECK CONSTRAINT [FKAF52BEA4860049B9]
GO
ALTER TABLE [dbo].[solicitud_appointment]  WITH CHECK ADD  CONSTRAINT [FKD217A2847E12E2BB] FOREIGN KEY([solicitud_id])
REFERENCES [dbo].[solicitud] ([id])
GO
ALTER TABLE [dbo].[solicitud_appointment] CHECK CONSTRAINT [FKD217A2847E12E2BB]
GO
ALTER TABLE [dbo].[solicitud_comentario]  WITH CHECK ADD  CONSTRAINT [FK8EE4B05C7E12E2BB] FOREIGN KEY([solicitud_id])
REFERENCES [dbo].[solicitud] ([id])
GO
ALTER TABLE [dbo].[solicitud_comentario] CHECK CONSTRAINT [FK8EE4B05C7E12E2BB]
GO
ALTER TABLE [dbo].[solicitud_comentario]  WITH CHECK ADD  CONSTRAINT [FK8EE4B05C860049B9] FOREIGN KEY([user_id])
REFERENCES [dbo].[user_table] ([id])
GO
ALTER TABLE [dbo].[solicitud_comentario] CHECK CONSTRAINT [FK8EE4B05C860049B9]
GO
ALTER TABLE [dbo].[user_table]  WITH CHECK ADD  CONSTRAINT [FK7358465A1D6234DB] FOREIGN KEY([profile_id])
REFERENCES [dbo].[profile] ([id])
GO
ALTER TABLE [dbo].[user_table] CHECK CONSTRAINT [FK7358465A1D6234DB]
GO
ALTER TABLE [dbo].[user_table]  WITH CHECK ADD  CONSTRAINT [FK7358465A46C448DB] FOREIGN KEY([empresa_id])
REFERENCES [dbo].[empresa] ([id])
GO
ALTER TABLE [dbo].[user_table] CHECK CONSTRAINT [FK7358465A46C448DB]
GO
ALTER TABLE [dbo].[user_table]  WITH CHECK ADD  CONSTRAINT [FK7358465AF3311853] FOREIGN KEY([report_access_level_id])
REFERENCES [dbo].[report_access_level] ([id])
GO
ALTER TABLE [dbo].[user_table] CHECK CONSTRAINT [FK7358465AF3311853]
GO


/* default data */

SET IDENTITY_INSERT empresa ON;

INSERT INTO empresa (id, nombre, codigo) VALUES (1, 'ATP', 'ATP');
INSERT INTO empresa (id, nombre, codigo) VALUES (2, 'ISTASA', 'IST');
INSERT INTO empresa (id, nombre, codigo) VALUES (3, 'RFI', 'RFI');

SET IDENTITY_INSERT empresa OFF;

SET IDENTITY_INSERT profile ON;

INSERT INTO profile (id, code, name) VALUES (1, 'TA', 'Terminal Administrador');
INSERT INTO profile (id, code, name) VALUES (2, 'TI', 'Terminal Interno');
INSERT INTO profile (id, code, name) VALUES (3, 'LN', 'Línea Naviera');
INSERT INTO profile (id, code, name) VALUES (4, 'AA', 'Agencia Aduanal');
INSERT INTO profile (id, code, name) VALUES (5, 'CLI', 'Cliente');
INSERT INTO profile (id, code, name) VALUES (6, 'TRA', 'Transportista');
INSERT INTO profile (id, code, name) VALUES (7, 'RF', 'Recintos Fiscalizados');
INSERT INTO profile (id, code, name) VALUES (8, 'DEP', 'Depósitos');
INSERT INTO profile (id, code, name) VALUES (9, 'CON', 'Consultas');

SET IDENTITY_INSERT profile OFF;

SET IDENTITY_INSERT report_access_level ON;

INSERT INTO report_access_level (id, code, name) VALUES (1, 'BASIC', 'Básico');
INSERT INTO report_access_level (id, code, name) VALUES (2, 'MEDIUM', 'Medio');
INSERT INTO report_access_level (id, code, name) VALUES (3, 'ADVANCED', 'Avanzado');

SET IDENTITY_INSERT report_access_level OFF;

SET IDENTITY_INSERT user_table ON;

INSERT INTO user_table (id, email, first_name, last_login, last_name, last_password_change, password, status, user_n4_id, username, profile_id, report_access_level_id, empresa_id) VALUES (1, 'fdeutsch@objectwave.com', 'Fernando', '2014-03-04 10:43:57', 'Deutsch', '2014-02-20 14:31:19', '076dcc100d3ca3a0bc2b5162bdd7289dab5d250159d5343a73579194f52a2739', 0, 305854, 'admin', 1, 3, 1);
INSERT INTO user_table (id, email, first_name, last_login, last_name, last_password_change, password, status, user_n4_id, username, profile_id, report_access_level_id, empresa_id) VALUES (2, 'f_deutsch@yahoo.com', 'Consultor', '2014-03-04 10:42:02', 'Consultor ATPs', '2014-02-24 11:43:25', '076dcc100d3ca3a0bc2b5162bdd7289dab5d250159d5343a73579194f52a2739', 0, 305981, 'consultor', 9, 2, 1);
INSERT INTO user_table (id, email, first_name, last_login, last_name, last_password_change, password, status, user_n4_id, username, profile_id, report_access_level_id, empresa_id) VALUES (3, 'fdeutsch@gmail.com', 'Sergio Emilio', '2014-03-03 12:00:42', 'Rivas Lozano', '2014-03-03 11:45:59', '076dcc100d3ca3a0bc2b5162bdd7289dab5d250159d5343a73579194f52a2739', 0, 0, 'sergio.rivas', 5, 1, 1);
INSERT INTO user_table (id, email, first_name, last_login, last_name, last_password_change, password, status, user_n4_id, username, profile_id, report_access_level_id, empresa_id) VALUES (4, 'fdeutsch1@gmail.com', 'valdez', '2014-03-03 12:03:01', 'woodward', '2014-03-03 11:57:21', '076dcc100d3ca3a0bc2b5162bdd7289dab5d250159d5343a73579194f52a2739', 0, 305980, 'valdez.woodward', 5, 1, 1);

SET IDENTITY_INSERT user_table OFF;

SET IDENTITY_INSERT [dbo].[solicitud] ON 

GO
INSERT [dbo].[solicitud] ([id], [agencia_aduanal_id], [cliente_id], [paquete_id], [date_created], [date_scheduled], [date_updated], [operador_id], [operation_type], [placas], [reference], [status], [transportista_id], [user_id]) VALUES (1, 305981, 305472, 24, CAST(0x0000A2E4013C5364 AS DateTime), NULL, CAST(0x0000A2E4013D4181 AS DateTime), NULL, 0, NULL, N'Importación Test', 2, NULL, 2)
GO
INSERT [dbo].[solicitud] ([id], [agencia_aduanal_id], [cliente_id], [paquete_id], [date_created], [date_scheduled], [date_updated], [operador_id], [operation_type], [placas], [reference], [status], [transportista_id], [user_id]) VALUES (2, 305981, 305472, NULL, CAST(0x0000A2E4013C6EB2 AS DateTime), NULL, CAST(0x0000A2E4013D4661 AS DateTime), NULL, 1, NULL, N'Exportación Test', 2, NULL, 2)
GO
INSERT [dbo].[solicitud] ([id], [agencia_aduanal_id], [cliente_id], [paquete_id], [date_created], [date_scheduled], [date_updated], [operador_id], [operation_type], [placas], [reference], [status], [transportista_id], [user_id]) VALUES (3, 305981, 305472, NULL, CAST(0x0000A2E4013C9434 AS DateTime), NULL, CAST(0x0000A2E4013D4D17 AS DateTime), NULL, 2, NULL, N'Entrega Vacio Test', 2, NULL, 2)
GO
INSERT [dbo].[solicitud] ([id], [agencia_aduanal_id], [cliente_id], [paquete_id], [date_created], [date_scheduled], [date_updated], [operador_id], [operation_type], [placas], [reference], [status], [transportista_id], [user_id]) VALUES (4, 305981, 305472, 24, CAST(0x0000A2E4013CAAFA AS DateTime), NULL, CAST(0x0000A2E4013D5236 AS DateTime), NULL, 3, NULL, N'Recepcion Vacio Test', 2, NULL, 2)
GO
INSERT [dbo].[solicitud] ([id], [agencia_aduanal_id], [cliente_id], [paquete_id], [date_created], [date_scheduled], [date_updated], [operador_id], [operation_type], [placas], [reference], [status], [transportista_id], [user_id]) VALUES (5, 305981, 305472, NULL, CAST(0x0000A2E4013CC9F6 AS DateTime), NULL, CAST(0x0000A2E4013D57C1 AS DateTime), NULL, 4, NULL, N'Desestimiento Test', 2, NULL, 2)
GO
SET IDENTITY_INSERT [dbo].[solicitud] OFF
GO