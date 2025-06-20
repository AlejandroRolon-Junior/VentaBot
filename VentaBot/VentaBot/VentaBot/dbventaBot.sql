USE [master]
GO

CREATE DATABASE [VentaBot]
GO

USE [VentaBot]
GO

CREATE TABLE [dbo].[articulo](
	[idarticulo] [int] IDENTITY(1,1) NOT NULL,
	[codigo] [varchar](50) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[descripcion] [varchar](1024) NULL,
	[imagen] [image] NULL,
	[idcategoria] [int] NOT NULL,
	[idpresentacion] [int] NOT NULL,
 CONSTRAINT [PK_articulo] PRIMARY KEY CLUSTERED 
(
	[idarticulo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[categoria]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[categoria](
	[idcategoria] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[descripcion] [varchar](256) NULL,
 CONSTRAINT [PK_categoria] PRIMARY KEY CLUSTERED 
(
	[idcategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cliente]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cliente](
	[idcliente] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](20) NOT NULL,
	[apellidos] [varchar](40) NULL,
	[sexo] [varchar](1) NULL,
	[fecha_nacimiento] [date] NOT NULL,
	[tipo_documento] [varchar](20) NOT NULL,
	[num_documento] [varchar](20) NOT NULL,
	[direccion] [varchar](100) NULL,
	[telefono] [varchar](12) NULL,
	[email] [varchar](50) NULL,
 CONSTRAINT [PK_cliente] PRIMARY KEY CLUSTERED 
(
	[idcliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[detalle_ingreso]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[detalle_ingreso](
	[iddetalle_ingreso] [int] IDENTITY(1,1) NOT NULL,
	[idingreso] [int] NOT NULL,
	[idarticulo] [int] NOT NULL,
	[precio_compra] [money] NOT NULL,
	[precio_venta] [money] NOT NULL,
	[stock_inicial] [int] NOT NULL,
	[stock_actual] [int] NOT NULL,
	[fecha_produccion] [date] NOT NULL,
	[fecha_vencimiento] [date] NOT NULL,
 CONSTRAINT [PK_detalle_ingreso] PRIMARY KEY CLUSTERED 
(
	[iddetalle_ingreso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[detalle_venta]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[detalle_venta](
	[iddetalle_venta] [int] IDENTITY(1,1) NOT NULL,
	[idventa] [int] NOT NULL,
	[iddetalle_ingreso] [int] NOT NULL,
	[cantidad] [int] NOT NULL,
	[precio_venta] [money] NOT NULL,
	[descuento] [money] NOT NULL,
 CONSTRAINT [PK_detalle_venta] PRIMARY KEY CLUSTERED 
(
	[iddetalle_venta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ingreso]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ingreso](
	[idingreso] [int] IDENTITY(1,1) NOT NULL,
	[idtrabajador] [int] NOT NULL,
	[idproveedor] [int] NOT NULL,
	[fecha] [date] NOT NULL,
	[tipo_comprobante] [varchar](20) NOT NULL,
	[serie] [varchar](4) NOT NULL,
	[correlativo] [varchar](7) NOT NULL,
	[igv] [decimal](4, 2) NOT NULL,
	[estado] [varchar](7) NOT NULL,
 CONSTRAINT [PK_ingreso] PRIMARY KEY CLUSTERED 
(
	[idingreso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[presentacion]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[presentacion](
	[idpresentacion] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[descripcion] [varchar](256) NULL,
 CONSTRAINT [PK_presentacion] PRIMARY KEY CLUSTERED 
(
	[idpresentacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[proveedor]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[proveedor](
	[idproveedor] [int] IDENTITY(1,1) NOT NULL,
	[razon_social] [varchar](150) NOT NULL,
	[sector_comercial] [varchar](50) NOT NULL,
	[tipo_documento] [varchar](20) NOT NULL,
	[num_documento] [varchar](11) NOT NULL,
	[direccion] [varchar](100) NULL,
	[telefono] [varchar](10) NULL,
	[email] [varchar](50) NULL,
	[url] [varchar](100) NULL,
 CONSTRAINT [PK_proveedor] PRIMARY KEY CLUSTERED 
(
	[idproveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[trabajador]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[trabajador](
	[idtrabajador] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](20) NOT NULL,
	[apellidos] [varchar](40) NOT NULL,
	[sexo] [varchar](1) NOT NULL,
	[fecha_nac] [date] NOT NULL,
	[num_documento] [varchar](20) NOT NULL,
	[direccion] [varchar](100) NULL,
	[telefono] [varchar](10) NULL,
	[email] [varchar](50) NULL,
	[acceso] [varchar](20) NOT NULL,
	[usuario] [varchar](20) NOT NULL,
	[password] [varchar](20) NOT NULL,
 CONSTRAINT [PK_trabajador] PRIMARY KEY CLUSTERED 
(
	[idtrabajador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[venta]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[venta](
	[idventa] [int] IDENTITY(1,1) NOT NULL,
	[idcliente] [int] NOT NULL,
	[idtrabajador] [int] NOT NULL,
	[fecha] [date] NOT NULL,
	[tipo_comprobante] [varchar](20) NOT NULL,
	[serie] [varchar](4) NOT NULL,
	[correlativo] [varchar](7) NOT NULL,
	[igv] [decimal](4, 2) NOT NULL,
 CONSTRAINT [PK_venta] PRIMARY KEY CLUSTERED 
(
	[idventa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[View_2]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_2]
AS
SELECT        dbo.articulo.idarticulo, dbo.articulo.codigo, dbo.articulo.nombre, dbo.articulo.descripcion, dbo.articulo.imagen, dbo.articulo.idcategoria, dbo.categoria.nombre AS Expr1, dbo.articulo.idpresentacion, 
                         dbo.presentacion.nombre AS Expr2
FROM            dbo.articulo INNER JOIN
                         dbo.categoria ON dbo.articulo.idcategoria = dbo.categoria.idcategoria INNER JOIN
                         dbo.presentacion ON dbo.articulo.idpresentacion = dbo.presentacion.idpresentacion

GO
/****** Object:  View [dbo].[View_38]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_38]
AS
SELECT        dbo.articulo.codigo, dbo.articulo.nombre, dbo.categoria.nombre AS Expr1, dbo.detalle_ingreso.stock_inicial, dbo.detalle_ingreso.stock_actual
FROM            dbo.articulo INNER JOIN
                         dbo.categoria ON dbo.articulo.idcategoria = dbo.categoria.idcategoria INNER JOIN
                         dbo.detalle_ingreso ON dbo.articulo.idarticulo = dbo.detalle_ingreso.idarticulo INNER JOIN
                         dbo.ingreso ON dbo.detalle_ingreso.idingreso = dbo.ingreso.idingreso

GO
/****** Object:  View [dbo].[vista1]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vista1]
AS
SELECT     dbo.articulo.idarticulo, dbo.articulo.codigo, dbo.articulo.nombre, dbo.articulo.descripcion, dbo.articulo.idcategoria, dbo.categoria.nombre AS Expr1, 
                      dbo.articulo.idpresentacion, dbo.presentacion.nombre AS Expr2
FROM         dbo.articulo INNER JOIN
                      dbo.categoria ON dbo.articulo.idcategoria = dbo.categoria.idcategoria INNER JOIN
                      dbo.presentacion ON dbo.articulo.idpresentacion = dbo.presentacion.idpresentacion

GO
SET IDENTITY_INSERT [dbo].[articulo] ON 

INSERT [dbo].[articulo] ([idarticulo], [codigo], [nombre], [descripcion], [imagen], [idcategoria], [idpresentacion]) VALUES (2, N'424243121', N'BASE DE DATOS VACÍA', N'Es una base de datos vacía pero lista para llenar', 0x89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7AF4000000017352474200AECE1CE90000000467414D410000B18F0BFC6105000000097048597300000EC400000EC401952B0E1B000005DE494441545847ED976B4C536718C75DB60FCBB2659B5BB66C6E1F962CFA657317A6F336D101718802A6E0AC8660D44D27B228C91263B2390DCB4087D771935110C132AAD4225869894069A12DB4DC2F2D5DB9F4060A721F8E80FF3DEFE941E532C179D9973DC99343CFE1F4F7BCCFFBFF9FE774CEFF31433C131C1C3C572C16CFCFCFCFF7B876EDDA72A552B9AAA0A060F57449D73DD9FFC8E5F28FD3D2D2DE0D08087889BEE369F757CD32E8E6353A9D2EB9B2B2B2AAAEB6B6DF6C32DDA684E90193BFE7766D6D6D8FD1682CD76AB5B132996C098F993E341ACD470C68A8A8C0E348BD4E77CBD3D3937565FA686C6C5C3D3A3A8A3F8786D0D9D981D69616989A9A409D407555156AAAABE95889AA4A9646541A591A506930C0C867B95E47B07268CB4AA12D2D45194B8D069A921294A85458BF7EFDEB3C6E6A8C1730323282E1E1610C0D0EA2BFBF1FBD3D3DB879F32686A8B0413A3740E7FAFAFAD0DBDB8B1E76ADBB1B5D5D5DB871E306FEB058D062B582DA8E8AF272E8B45AAE08F5A32860029C3FD74DE02E025FBF7E1D9D1D1DB03437C342453C960206060626C0B955337067273A5C2E389D4E98CD664E80FFAA0083C1B0F02F8A7F2AA09F6FFB64B88BE00E8703769B8DD30C2D64DA028A0A0BFBBCBDBD5FE4715343A5522D945EBC38A6B82AE784D4D4D4C809D161B7A383DACBC06CBF59DB27C36D046F6B6D45437D3D27586D591954C5C52850287059268338231D6922D1F07D0B18DF82FEFE3ED8DADBB956D6D7B91DC0D4CE1CE04EE60877B2BF992B9823980BC86AE4043D4A35EA3BCA2FA142D851FDB01A98B50BA86B4FCE050CFE9FBA80E08FCC057ABDFE2382B3989D0B783813A293B980C47A3F1728F2F3C77C7C7C5EE37153A3B0B0F0BD6C896494299789AA9956C3C4C800ACC5DC9EF36D9F02672E686BE3E0B535351C98ADB840A9446E8E0C67534408D9FF33047B0EE4D13C789E474E8CF12D601066BFC686064EE9464305AD46CFA99C15C6CD02DE11F73AC03D03CA085E462B26F5AB8AC98A455C11E1878E61515C0596C4572068DF614DA097D72B3CF66ECCA4813B2E202D8C6FC74C2E28A5417420FA243EFD550B8F846A2C4AAAC332511D04FB636AE97DE16D1EED8E990A986C41766E820B684BEE75017B26FC743C16DE49155871B6098B93EBB158D48025674DF04C6F8670D7BE7C1EED8E990A98EC02EE89C8E0D3B980B6E4445C227CCF9461659A09AB322CF83CD38AE56966AC386781E050928D1CF10E8F7607CD020F828FCDD605ED24D01C7ACC32F004179076929253B021B118DEE926789DB7C04B6C8577561BD65CB0411095DE1D1C10F03E8FBD1B6AB5FAC3AB57F2C64A4838F5F412C2E6BAD3E9E0DACB56CB56CFF69CB59D01BF8F89C79A2352C48BD23807B0829AC805BF6749204C50C237C304DF4C0BD64A5AE1976DC3BA4B4E6C89CB1B0C0E0E5CC12327C6F816B056B301C4F6B391864B2DF726544573A18E1B36EC0DE9C7A327B1EC1705969E2EC5BAD84244C69CE6DA9E2916636B5C2E0232CDD820B122486643D0652704B99DD89E5A0CA15028E0715363362E60C525A666E0B32357F0C971153C1374F0F9CD08418A1E878FC56157AC1441123384975AB125D70E61AE139B725DD8715E876451CAC3CF02F6592CB988B5D4FAA5A7349CC2D7A6562120BD0E5BB21A20BC604688AC055BF3EC08BDE24088DC85AF2555884B38F3E86601D381EC722E361ECBC617A24AF89FAB419098C14D08BD64C557721BB6CB1DD876D585DDB2469C884DE0E0331640DEFD80E0B766EB02A542891DA7B321385F8F4D9226844A2DD8256FC737F90EECCC77223CCF82A3A7E2A151ABB959505C54D47BDFD77216595959F3AC566BA8D36E3F4EF6CAA167BD81B28DB297C023B4FADBE3053077B0557D1B2B41487633B6E55811AEB4638FD285BD8A367C7738BA59A1506453464BA5D22F0F1E3C3897C73C703C45C97E623DBB60C182172222225E8D8C8C7C232A2AEA2D3ACEDBBC79E3CAB09854D7CEBC56EC563810516047D80FD1C51E1E1ECF71773F89080CF49D1F16956861F0F0C893557E7E7E2FF3979E5CF8FBFBBFB9236CAF94E0F3F85333C49C397F03156338748883BAD20000000049454E44AE426082, 2, 1)
INSERT [dbo].[articulo] ([idarticulo], [codigo], [nombre], [descripcion], [imagen], [idcategoria], [idpresentacion]) VALUES (1002, N'1232', N'OTRO ARTÍCULO', N'Artículo de relleno', 0x89504E470D0A1A0A0000000D49484452000000010000000108060000001F15C48900000182694343504943432070726F66696C65000028CF95914B2844511CC67F068D4492C92B8BBBC08A1292A5864899D218E5B570EF1D33D4DC3BD3BD231B4B65AB2C3C36060B1B6BB616B64A298F928DAD15B191AEFFB9A36652A39C3A9D5FDF39DFD739DF81402E655A6E450F5876D6898E85B599D9392DF84C907A9A68A44537DD4C646A3446C9F1714B995A6FBA5516FF1BB5F125D784324D78C8CC3859E145E181B56C46F1AE70C85CD6E3C2A7C25D8E5C50F85EE9469E5F14277D0EA8CC90138B0E0B8784B564111B456C2E3B9670BF707BDCB2253F3093E7B8E275C5566AD5FCB9A77A61CD923D3DA574996D8C314E8449340C56592145966E596D515CA2B21F2EE16FF5FD93E232C4B582298E11D258E8BE1FF507BFBB75137DBDF9A49A30543E79DE5B0704B7E16BCBF33E0F3DEFEB08CA1FE1C22EF8D339187C177DABA0B51F40DD069C5D16346307CE37A1F921A33BBA2F95CB0C2412F07A22DF340B0DD7503D9FEFED679FE33B8849571357B0B70F9D49C95E28F1EEAAE2DEFE3CE3F747F81B72B572A77F6661D8000000097048597300002E2300002E230178A53F760000000774494D4507E3071117191B0E8DFA670000001974455874436F6D6D656E74004372656174656420776974682047494D5057810E170000000D49444154185763606060600000000500018A33E3000000000049454E44AE426082, 3, 3)
INSERT [dbo].[articulo] ([idarticulo], [codigo], [nombre], [descripcion], [imagen], [idcategoria], [idpresentacion]) VALUES (1003, N'78887', N'RON', N'Romo', 0x89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7AF4000000017352474200AECE1CE90000000467414D410000B18F0BFC6105000000097048597300000EC400000EC401952B0E1B00000477494441545847ED576D4C5B5518C6C525267E24C6A8316AFCA931A28B2D6E620C5B94E8CC629C5927DE7B4B7B697BDB42BF4B0B145A28303E36CAE786C228C280E140E7C2BE98CA5C3637D0191026CB9843E58F18C011B764B22A7D3DE7F65C0ADD8501037FED499E1FB7F7DEF779CEFBBEE79EB7517702FA15FA21769DEC5172F9FF21F125D993DCAB4C6D29AB0F5427A7048D1B138F2A255434B9BD7AA0A2A987D531F2E2525677A3BBCE0517DBB379F63665C1C706C3BFBAD7E49F28A51F3C4D1E5F39302F32F7A3156619DFD44DEE739A678423F95D7D2694ABF43754EB999DD82C797DF9E024DCDA24299DBC4BB76374A8EF12046E06E078D311285159E0747586A809CCD31F654021A5FD5329655215CFC4DD47C22D09F7A01553195B928673130CF0FD573D100C0641C0F5C96BD0EADB07553A239C6FC814358179A2D409EEADAA11A58456A0986B42A16F03564A6DB6BFC5F6B567DBE0A7031E186CF3409BC70A55D602F8F5E230B110C21F23A3509B5901F53613F4EF778B9AC0EF1FCAB783F31DB61FC72632B7828EA69F326D527ED39466860BAD9E5B02FDD8E286BD161334E4D7C0D5B1ABC4420843BD97A0DC980BED39365E30F25DCC0B9F7A60BFCB02E637145D588BC886A18D951F43DB0A7E68CC120D20B0C7EF820AAD193AEABE809B7F4F110BC097A8A7F31C9468D2E084CF29FA6E5F73165472C9A0D9C07412D9308A19EDD819D43C254A1DF8AD467EC56241047E5D91063E8D13BA8F9F9DD31F81A9001C6B3C0C659C05BEAD0935EA00CA28DE3DB9DB35D0966D851C997A8CC886B133513B3113BC3C0D8A182DB46458F8D409BF4712A7FB33AF0D2A4C797065E032B110C235D4A84D457ED8A34F01AF4C034DE966E8AA4CE3890C4C10D930661B10821F294A85024A0B9F2391F96A8B891BD06F35813FA71A2646C77903D3D3D37CAF14A93D285BCE19F1451B10C8AF123517DAD770B4D8B1A011FC21CAFBD0003FF75F8691A1DFE017B46B2AEDBE39E24B36201097A219A511F50A74A1FA47DE3F57EB021FABE34B57EBAEE6C58707AF404972FECA1810889BB3CE62049F520FA776A743F75E17ECD6A5F0C28751C93A7D0EA87294C1A94327A15095090DA9A6953520106F57DC60EEAD6A3898679B098EEB9D9790CC6F37FC259C2D2C70450C609EAC4AC7A7A0A8C842BC6BE0AE81790CE8C6C54416E2B20D6C1331E0DAA2EAC5E7BF98D07C5C8E01BC4DF1BC4164C35048E88D051437397BD8BC1D976AA0A3D00EEEF7D59349126A13919D0B347C3E8626DB7ABFC5383DD0BAF0718CB958035F9639A142A30F72B1F246D50B098F13B9F9C14A98F5A96FB3E73B0A53D1E1232E8EB91803F8FCB0C52B06942FD3AF93F08BC69AA4184AB323811B3F4B068BA518C0E9F66E53FFC54A286B5C54DCBD24E6D281E77B2E96D9536334FC1339258919C0E9AEE4F4416D2CD3424BE82748983B8722865A678F579E39986B9F9909220D346798C11AAF184C9CAFC95602AC9466BC32F5EFF88F8960001FC3DEEDEAEB0A29EDE02492B5E4D1D543D2B3EF3EA8DE20DF8566BD29C766765A172B3F203A6AAF3664CFCB1E903FF7DE23E47219888AFA0F8B5239576BD8D6ED0000000049454E44AE426082, 3, 3)
SET IDENTITY_INSERT [dbo].[articulo] OFF
SET IDENTITY_INSERT [dbo].[categoria] ON 

INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion]) VALUES (2, N'VERDURAS2', N'Producto de prueba2')
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion]) VALUES (3, N'ALCOHOL2', N'Bebidas alcohólicas')
SET IDENTITY_INSERT [dbo].[categoria] OFF
SET IDENTITY_INSERT [dbo].[cliente] ON 

INSERT [dbo].[cliente] ([idcliente], [nombre], [apellidos], [sexo], [fecha_nacimiento], [tipo_documento], [num_documento], [direccion], [telefono], [email]) VALUES (1, N'PEDRO', N'PEREZ', N'M', CAST(N'1986-02-10' AS Date), N'CEDULA', N'40222222222', N'Herrera', N'8099999999', N'pedroperez@ejemplo.algundominio')
INSERT [dbo].[cliente] ([idcliente], [nombre], [apellidos], [sexo], [fecha_nacimiento], [tipo_documento], [num_documento], [direccion], [telefono], [email]) VALUES (2, N'DEMI', N'LOVATO', N'F', CAST(N'1982-08-20' AS Date), N'CEDULA', N'00111111111', N'United States', N'1305656885', N'demi@demi.demi')
SET IDENTITY_INSERT [dbo].[cliente] OFF
SET IDENTITY_INSERT [dbo].[detalle_ingreso] ON 

INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [precio_compra], [precio_venta], [stock_inicial], [stock_actual], [fecha_produccion], [fecha_vencimiento]) VALUES (8, 7, 1002, 3.0000, 5.0000, 12, 12, CAST(N'2019-08-09' AS Date), CAST(N'2019-08-30' AS Date))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [precio_compra], [precio_venta], [stock_inicial], [stock_actual], [fecha_produccion], [fecha_vencimiento]) VALUES (9, 7, 2, 6.0000, 9.0000, 43, 36, CAST(N'2019-08-09' AS Date), CAST(N'2019-08-30' AS Date))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [precio_compra], [precio_venta], [stock_inicial], [stock_actual], [fecha_produccion], [fecha_vencimiento]) VALUES (10, 8, 1002, 5.0000, 7.0000, 100, 95, CAST(N'2019-08-10' AS Date), CAST(N'2019-08-10' AS Date))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [precio_compra], [precio_venta], [stock_inicial], [stock_actual], [fecha_produccion], [fecha_vencimiento]) VALUES (11, 8, 2, 10.0000, 15.0000, 100, 92, CAST(N'2019-08-10' AS Date), CAST(N'2019-08-10' AS Date))
SET IDENTITY_INSERT [dbo].[detalle_ingreso] OFF
SET IDENTITY_INSERT [dbo].[detalle_venta] ON 

INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [iddetalle_ingreso], [cantidad], [precio_venta], [descuento]) VALUES (1, 1, 9, 7, 9.0000, 0.0000)
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [iddetalle_ingreso], [cantidad], [precio_venta], [descuento]) VALUES (4, 3, 10, 5, 7.0000, 0.0000)
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [iddetalle_ingreso], [cantidad], [precio_venta], [descuento]) VALUES (5, 3, 11, 8, 15.0000, 0.0000)
SET IDENTITY_INSERT [dbo].[detalle_venta] OFF
SET IDENTITY_INSERT [dbo].[ingreso] ON 

INSERT [dbo].[ingreso] ([idingreso], [idtrabajador], [idproveedor], [fecha], [tipo_comprobante], [serie], [correlativo], [igv], [estado]) VALUES (7, 1, 1, CAST(N'2019-08-09' AS Date), N'TICKET', N'001', N'0002', CAST(18.00 AS Decimal(4, 2)), N'EMITIDO')
INSERT [dbo].[ingreso] ([idingreso], [idtrabajador], [idproveedor], [fecha], [tipo_comprobante], [serie], [correlativo], [igv], [estado]) VALUES (8, 1, 1002, CAST(N'2019-08-09' AS Date), N'TICKET', N'001', N'0004', CAST(18.00 AS Decimal(4, 2)), N'EMITIDO')
SET IDENTITY_INSERT [dbo].[ingreso] OFF
SET IDENTITY_INSERT [dbo].[presentacion] ON 

INSERT [dbo].[presentacion] ([idpresentacion], [nombre], [descripcion]) VALUES (1, N'UND', N'Unidad')
INSERT [dbo].[presentacion] ([idpresentacion], [nombre], [descripcion]) VALUES (3, N'LT', N'Litro')
INSERT [dbo].[presentacion] ([idpresentacion], [nombre], [descripcion]) VALUES (4, N'PRUEBANEW', N'Prueba de la nueva base de datos')
SET IDENTITY_INSERT [dbo].[presentacion] OFF
SET IDENTITY_INSERT [dbo].[proveedor] ON 

INSERT [dbo].[proveedor] ([idproveedor], [razon_social], [sector_comercial], [tipo_documento], [num_documento], [direccion], [telefono], [email], [url]) VALUES (1, N'FARMACIA SALUDABLE', N'Salud', N'RUC', N'20457812356', N'Dr Delgado esq. Bolívar', N'8099999999', N'farmaciasaludable@ejemplo.algundominio', N'farmacia.algundominio')
INSERT [dbo].[proveedor] ([idproveedor], [razon_social], [sector_comercial], [tipo_documento], [num_documento], [direccion], [telefono], [email], [url]) VALUES (1002, N'RICH COMPANY', N'Ropa', N'CÉDULA', N'001-1111111', N'Un lugar', N'8099999999', N'lalalala@lalala.com', N'lalala.com')
SET IDENTITY_INSERT [dbo].[proveedor] OFF
SET IDENTITY_INSERT [dbo].[trabajador] ON 

INSERT [dbo].[trabajador] ([idtrabajador], [nombre], [apellidos], [sexo], [fecha_nac], [num_documento], [direccion], [telefono], [email], [acceso], [usuario], [password]) VALUES (1, N'MEN', N'HOMBRES', N'M', CAST(N'1993-03-18' AS Date), N'402-2222222-2', N'Los Alcarrizos', N'8099999999', N'menhombres@gmail.com', N'Administrador', N'admin', N'admin')
INSERT [dbo].[trabajador] ([idtrabajador], [nombre], [apellidos], [sexo], [fecha_nac], [num_documento], [direccion], [telefono], [email], [acceso], [usuario], [password]) VALUES (2, N'ZAPATO', N'DE GOMA', N'F', CAST(N'1990-07-26' AS Date), N'999-9999', N'Gazcue', N'8099994454', N'Zapato@degoma.net', N'Vendedor', N'vendedor', N'vendedor')
INSERT [dbo].[trabajador] ([idtrabajador], [nombre], [apellidos], [sexo], [fecha_nac], [num_documento], [direccion], [telefono], [email], [acceso], [usuario], [password]) VALUES (3, N'ALMACENERO', N'ROSA', N'M', CAST(N'1996-06-03' AS Date), N'001-1151', N'En tu corazón amor', N'8099995955', N'almacenero@alma.net', N'Almacenero', N'almacenero', N'almacenero')
INSERT [dbo].[trabajador] ([idtrabajador], [nombre], [apellidos], [sexo], [fecha_nac], [num_documento], [direccion], [telefono], [email], [acceso], [usuario], [password]) VALUES (5, N'SI', N'SI', N'M', CAST(N'2019-08-03' AS Date), N'47747474', N'SI', N'', N'', N'Administrador', N'administrador', N'administrador')
SET IDENTITY_INSERT [dbo].[trabajador] OFF
SET IDENTITY_INSERT [dbo].[venta] ON 

INSERT [dbo].[venta] ([idventa], [idcliente], [idtrabajador], [fecha], [tipo_comprobante], [serie], [correlativo], [igv]) VALUES (1, 1, 1, CAST(N'2019-08-10' AS Date), N'FACTURA', N'001', N'0003', CAST(18.00 AS Decimal(4, 2)))
INSERT [dbo].[venta] ([idventa], [idcliente], [idtrabajador], [fecha], [tipo_comprobante], [serie], [correlativo], [igv]) VALUES (3, 1, 1, CAST(N'2019-08-10' AS Date), N'TICKET', N'001', N'00078', CAST(18.00 AS Decimal(4, 2)))
SET IDENTITY_INSERT [dbo].[venta] OFF
ALTER TABLE [dbo].[articulo]  WITH CHECK ADD  CONSTRAINT [FK_articulo_categoria] FOREIGN KEY([idcategoria])
REFERENCES [dbo].[categoria] ([idcategoria])
GO
ALTER TABLE [dbo].[articulo] CHECK CONSTRAINT [FK_articulo_categoria]
GO
ALTER TABLE [dbo].[articulo]  WITH CHECK ADD  CONSTRAINT [FK_articulo_presentacion] FOREIGN KEY([idpresentacion])
REFERENCES [dbo].[presentacion] ([idpresentacion])
GO
ALTER TABLE [dbo].[articulo] CHECK CONSTRAINT [FK_articulo_presentacion]
GO
ALTER TABLE [dbo].[detalle_ingreso]  WITH CHECK ADD  CONSTRAINT [FK_detalle_ingreso_articulo] FOREIGN KEY([idarticulo])
REFERENCES [dbo].[articulo] ([idarticulo])
GO
ALTER TABLE [dbo].[detalle_ingreso] CHECK CONSTRAINT [FK_detalle_ingreso_articulo]
GO
ALTER TABLE [dbo].[detalle_ingreso]  WITH CHECK ADD  CONSTRAINT [FK_detalle_ingreso_ingreso] FOREIGN KEY([idingreso])
REFERENCES [dbo].[ingreso] ([idingreso])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[detalle_ingreso] CHECK CONSTRAINT [FK_detalle_ingreso_ingreso]
GO
ALTER TABLE [dbo].[detalle_venta]  WITH CHECK ADD  CONSTRAINT [FK_detalle_venta_detalle_ingreso] FOREIGN KEY([iddetalle_ingreso])
REFERENCES [dbo].[detalle_ingreso] ([iddetalle_ingreso])
GO
ALTER TABLE [dbo].[detalle_venta] CHECK CONSTRAINT [FK_detalle_venta_detalle_ingreso]
GO
ALTER TABLE [dbo].[detalle_venta]  WITH CHECK ADD  CONSTRAINT [FK_detalle_venta_venta] FOREIGN KEY([idventa])
REFERENCES [dbo].[venta] ([idventa])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[detalle_venta] CHECK CONSTRAINT [FK_detalle_venta_venta]
GO
ALTER TABLE [dbo].[ingreso]  WITH CHECK ADD  CONSTRAINT [FK_ingreso_proveedor] FOREIGN KEY([idproveedor])
REFERENCES [dbo].[proveedor] ([idproveedor])
GO
ALTER TABLE [dbo].[ingreso] CHECK CONSTRAINT [FK_ingreso_proveedor]
GO
ALTER TABLE [dbo].[ingreso]  WITH CHECK ADD  CONSTRAINT [FK_ingreso_trabajador] FOREIGN KEY([idtrabajador])
REFERENCES [dbo].[trabajador] ([idtrabajador])
GO
ALTER TABLE [dbo].[ingreso] CHECK CONSTRAINT [FK_ingreso_trabajador]
GO
ALTER TABLE [dbo].[venta]  WITH CHECK ADD  CONSTRAINT [FK_venta_cliente] FOREIGN KEY([idcliente])
REFERENCES [dbo].[cliente] ([idcliente])
GO
ALTER TABLE [dbo].[venta] CHECK CONSTRAINT [FK_venta_cliente]
GO
ALTER TABLE [dbo].[venta]  WITH CHECK ADD  CONSTRAINT [FK_venta_trabajador] FOREIGN KEY([idtrabajador])
REFERENCES [dbo].[trabajador] ([idtrabajador])
GO
ALTER TABLE [dbo].[venta] CHECK CONSTRAINT [FK_venta_trabajador]
GO
/****** Object:  StoredProcedure [dbo].[spanular_ingreso]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Procedimiento anular ingreso
CREATE proc [dbo].[spanular_ingreso]
@idingreso int
as
update ingreso set estado='ANULADO'
where idingreso=@idingreso

GO
/****** Object:  StoredProcedure [dbo].[spbuscar_articulo_nombre]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spbuscar_articulo_nombre]
@textobuscar varchar(50)
as
SELECT    dbo.articulo.idarticulo, dbo.articulo.codigo, dbo.articulo.nombre, dbo.articulo.descripcion, dbo.articulo.idcategoria, dbo.categoria.nombre AS Categoria, 
                      dbo.articulo.idpresentacion, dbo.presentacion.nombre AS Presentacion
FROM         dbo.articulo INNER JOIN
                      dbo.categoria 
					  ON dbo.articulo.idcategoria = dbo.categoria.idcategoria INNER JOIN
                      dbo.presentacion 
					  ON dbo.articulo.idpresentacion = dbo.presentacion.idpresentacion
where dbo.articulo.nombre like @textobuscar + '%'
order by dbo.articulo.idarticulo desc

GO
/****** Object:  StoredProcedure [dbo].[spbuscar_categoria]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Procedimiento buscar Nombre
create proc [dbo].[spbuscar_categoria]
@textobuscar varchar(50)
as
select * from categoria
where nombre like @textobuscar + '%'

GO
/****** Object:  StoredProcedure [dbo].[spbuscar_cliente_apellidos]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Buscar Apellidos
create proc [dbo].[spbuscar_cliente_apellidos]
@textobuscar varchar(50)
as
select * from cliente
where apellidos like @textobuscar + '%'

GO
/****** Object:  StoredProcedure [dbo].[spbuscar_cliente_num_documento]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Buscar Num_Documento
create proc [dbo].[spbuscar_cliente_num_documento]
@textobuscar varchar(50)
as
select * from cliente
where num_documento like @textobuscar + '%'

GO
/****** Object:  StoredProcedure [dbo].[spbuscar_ingreso_fecha]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Mostrar ingresos entre fechas
create proc [dbo].[spbuscar_ingreso_fecha]
@textobuscar varchar(20),
@textobuscar2 varchar(20)
as
select i.idingreso,(t.apellidos+' '+t.nombre) as Trabajador,
p.razon_social as Proveedor,i.fecha,i.tipo_comprobante,i.serie,
i.correlativo,i.estado,
sum(d.precio_compra*d.stock_inicial) as Total
from detalle_ingreso d inner join ingreso i
on d.idingreso=i.idingreso
inner join proveedor p
on i.idproveedor=p.idproveedor
inner join trabajador t
on i.idtrabajador=t.idtrabajador
group by i.idingreso,t.apellidos+' '+t.nombre,
p.razon_social,i.fecha,i.tipo_comprobante,i.serie,
i.correlativo,i.estado
having i.fecha>=@textobuscar and i.fecha<=@textobuscar2

GO
/****** Object:  StoredProcedure [dbo].[spbuscar_presentacion_nombre]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spbuscar_presentacion_nombre]
@textobuscar varchar(50)
as
select * from presentacion
where nombre like @textobuscar + '%'

GO
/****** Object:  StoredProcedure [dbo].[spbuscar_proveedor_num_documento]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Buscar_num_documento
create proc [dbo].[spbuscar_proveedor_num_documento]
@textobuscar varchar(11)
as
select * from proveedor
where num_documento like @textobuscar + '%'

GO
/****** Object:  StoredProcedure [dbo].[spbuscar_proveedor_razon_social]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spbuscar_proveedor_razon_social]
@textobuscar varchar(50)
as
select * from proveedor
where razon_social like @textobuscar + '%'

GO
/****** Object:  StoredProcedure [dbo].[spbuscar_trabajador_apellidos]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Buscar Apellidos
create proc [dbo].[spbuscar_trabajador_apellidos]
@textobuscar varchar(50)
as
select * from trabajador
where apellidos like @textobuscar + '%'
order by apellidos asc

GO
/****** Object:  StoredProcedure [dbo].[spbuscar_trabajador_num_documento]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Buscar Num_Documento
create proc [dbo].[spbuscar_trabajador_num_documento]
@textobuscar varchar(50)
as
select * from trabajador
where num_documento like @textobuscar + '%'
order by apellidos asc

GO
/****** Object:  StoredProcedure [dbo].[spbuscar_venta_fecha]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Buscar ventas por fechas
create proc [dbo].[spbuscar_venta_fecha]
@textobuscar varchar(50),
@textobuscar2 varchar(50)
as
select v.idventa,
(t.apellidos+' '+t.nombre) as Trabajador,
(c.apellidos+' '+c.nombre) as Cliente,
v.fecha,v.tipo_comprobante,v.serie,v.correlativo,
sum((d.cantidad*d.precio_venta)-d.descuento) as Total
from detalle_venta d inner join venta v
on d.idventa=v.idventa
inner join cliente c
on v.idcliente=c.idcliente
inner join trabajador t
on v.idtrabajador=t.idtrabajador
group by v.idventa,
(t.apellidos+' '+t.nombre),
(c.apellidos+' '+c.nombre),
v.fecha,v.tipo_comprobante,v.serie,v.correlativo
having v.fecha>=@textobuscar and v.fecha<=@textobuscar2

GO
/****** Object:  StoredProcedure [dbo].[spbuscararticulo_venta_codigo]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Mostrar los artículos para la venta (código de barras)
create proc [dbo].[spbuscararticulo_venta_codigo]
@textobuscar varchar(50)
as
select d.iddetalle_ingreso,a.Codigo,a.Nombre,
c.nombre as Categoria,p.nombre as Presentacion,
d.stock_actual,d.precio_compra,d.precio_venta,
d.fecha_vencimiento
from articulo a inner join categoria c
on a.idcategoria=c.idcategoria
inner join presentacion p
on a.idpresentacion=p.idpresentacion
inner join detalle_ingreso d
on a.idarticulo=d.idarticulo
inner join ingreso i
on d.idingreso=i.idingreso
where a.codigo=@textobuscar
and d.stock_actual>0 
and i.estado<>'ANULADO'

GO
/****** Object:  StoredProcedure [dbo].[spbuscararticulo_venta_nombre]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Mostrar los artículos para la venta
create proc [dbo].[spbuscararticulo_venta_nombre]
@textobuscar varchar(50)
as
select d.iddetalle_ingreso,a.Codigo,a.Nombre,
c.nombre as Categoria,p.nombre as Presentacion,
d.stock_actual,d.precio_compra,d.precio_venta,
d.fecha_vencimiento
from articulo a inner join categoria c
on a.idcategoria=c.idcategoria
inner join presentacion p
on a.idpresentacion=p.idpresentacion
inner join detalle_ingreso d
on a.idarticulo=d.idarticulo
inner join ingreso i
on d.idingreso=i.idingreso
where a.nombre like @textobuscar + '%'
and d.stock_actual>0 
and i.estado<>'ANULADO'

GO
/****** Object:  StoredProcedure [dbo].[spdisminuir_stock]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Disminuir el stock después de una venta
create proc [dbo].[spdisminuir_stock]
@iddetalle_ingreso int,
@cantidad int
as
update detalle_ingreso set stock_actual=stock_actual-@cantidad
where iddetalle_ingreso=@iddetalle_ingreso

GO
/****** Object:  StoredProcedure [dbo].[speditar_articulo]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[speditar_articulo]
@idarticulo int,
@codigo varchar(50),
@nombre varchar(50),
@descripcion varchar(1024),
@imagen image,
@idcategoria int,
@idpresentacion int
as
update articulo set codigo=@codigo,nombre=@nombre,descripcion=@descripcion,imagen=@imagen,idcategoria=@idcategoria,idpresentacion=@idpresentacion
where idarticulo=@idarticulo

GO
/****** Object:  StoredProcedure [dbo].[speditar_categoria]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Procedimiento Editar
create proc [dbo].[speditar_categoria]
@idcategoria int,
@nombre varchar(50),
@descripcion varchar(256)
as
update categoria set nombre=@nombre,
descripcion=@descripcion
where idcategoria=@idcategoria

GO
/****** Object:  StoredProcedure [dbo].[speditar_cliente]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Editar
create proc [dbo].[speditar_cliente]
@idcliente int,
@nombre varchar(50),
@apellidos varchar(40),
@sexo varchar(1),
@fecha_nacimiento date,
@tipo_documento varchar(20),
@num_documento varchar(11),
@direccion varchar(100),
@telefono varchar(10),
@email varchar(50)
as
update cliente set nombre=@nombre,apellidos=@apellidos,sexo=@sexo,
fecha_nacimiento=@fecha_nacimiento,tipo_documento=@tipo_documento,
num_documento=@num_documento,direccion=@direccion,telefono=@telefono,
email=@email
where idcliente=@idcliente

GO
/****** Object:  StoredProcedure [dbo].[speditar_presentacion]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[speditar_presentacion]
@idpresentacion int,
@nombre varchar(50),
@descripcion varchar(256)
as
update presentacion set nombre=@nombre,descripcion=@descripcion
where idpresentacion=@idpresentacion

GO
/****** Object:  StoredProcedure [dbo].[speditar_proveedor]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--editar
create proc [dbo].[speditar_proveedor]
@idproveedor int,
@razon_social varchar(150),
@sector_comercial varchar(50),
@tipo_documento varchar(20),
@num_documento varchar(11),
@direccion varchar(100),
@telefono varchar(10),
@email varchar(50),
@url varchar(100)
as
update proveedor set razon_social=@razon_social,sector_comercial=@sector_comercial,
tipo_documento=@tipo_documento,num_documento=@num_documento,direccion=@direccion,
telefono=@telefono,email=@email,url=@url
where idproveedor=@idproveedor

GO
/****** Object:  StoredProcedure [dbo].[speditar_trabajador]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Editar
create proc [dbo].[speditar_trabajador]
@idtrabajador int,
@nombre varchar(20),
@apellidos varchar(40),
@sexo varchar(1),
@fecha_nacimiento date,
@num_documento varchar(20),
@direccion varchar(100),
@telefono varchar(10),
@email varchar(50),
@acceso varchar(20),
@usuario varchar(20),
@password varchar(20)
as
update trabajador set nombre=@nombre,apellidos=@apellidos,
sexo=@sexo,fecha_nac=@fecha_nacimiento,num_documento=@num_documento,
direccion=@direccion,telefono=@telefono,email=@email,
acceso=@acceso,usuario=@usuario,password=@password
where idtrabajador=@idtrabajador

GO
/****** Object:  StoredProcedure [dbo].[speliminar_articulo]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[speliminar_articulo]
@idarticulo int
as
delete from articulo
where idarticulo=@idarticulo

GO
/****** Object:  StoredProcedure [dbo].[speliminar_categoria]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Procedimiento Eliminar
create proc [dbo].[speliminar_categoria]
@idcategoria int
as
delete from categoria
where idcategoria=@idcategoria

GO
/****** Object:  StoredProcedure [dbo].[speliminar_cliente]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[speliminar_cliente]
@idcliente int
as
delete from cliente
where idcliente=@idcliente

GO
/****** Object:  StoredProcedure [dbo].[speliminar_presentacion]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[speliminar_presentacion]
@idpresentacion int
as
delete from presentacion
where idpresentacion=@idpresentacion

GO
/****** Object:  StoredProcedure [dbo].[speliminar_proveedor]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[speliminar_proveedor]
@idproveedor int
as
delete from proveedor
where idproveedor=@idproveedor

GO
/****** Object:  StoredProcedure [dbo].[speliminar_trabajador]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Eliminar
create proc [dbo].[speliminar_trabajador]
@idtrabajador int
as
delete from trabajador
where idtrabajador=@idtrabajador

GO
/****** Object:  StoredProcedure [dbo].[speliminar_venta]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Eliminar Venta
create proc [dbo].[speliminar_venta]
@idventa int
as
delete from venta
where idventa=@idventa

GO
/****** Object:  StoredProcedure [dbo].[spinsertar_articulo]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spinsertar_articulo]
@idarticulo int output,
@codigo varchar(50),
@nombre varchar(50),
@descripcion varchar(1024),
@imagen image,
@idcategoria int,
@idpresentacion int
as
insert into articulo (codigo,nombre,descripcion,imagen,idcategoria,idpresentacion)
values (@codigo,@nombre,@descripcion,@imagen,@idcategoria,@idpresentacion)

GO
/****** Object:  StoredProcedure [dbo].[spinsertar_categoria]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Procedimiento Insertar
create proc [dbo].[spinsertar_categoria]
@idcategoria int output,
@nombre varchar(50),
@descripcion varchar(256)
as
insert into categoria (nombre,descripcion)
values (@nombre,@descripcion)

GO
/****** Object:  StoredProcedure [dbo].[spinsertar_cliente]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spinsertar_cliente]
@idcliente int output,
@nombre varchar(50),
@apellidos varchar(40),
@sexo varchar(1),
@fecha_nacimiento date,
@tipo_documento varchar(20),
@num_documento varchar(11),
@direccion varchar(100),
@telefono varchar(10),
@email varchar(50)
as
insert into cliente(nombre,apellidos,sexo,fecha_nacimiento,
tipo_documento,num_documento,direccion,telefono,email)
values (@nombre,@apellidos,@sexo,@fecha_nacimiento,
@tipo_documento,@num_documento,@direccion,@telefono,@email)

GO
/****** Object:  StoredProcedure [dbo].[spinsertar_detalle_ingreso]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Procedimiento para insertar los detalles de ingreso
create proc [dbo].[spinsertar_detalle_ingreso]
@iddetalle_ingreso int output,
@idingreso int,
@idarticulo int,
@precio_compra money,
@precio_venta money,
@stock_inicial int,
@stock_actual int,
@fecha_produccion date,
@fecha_vencimiento date
as
insert into detalle_ingreso (idingreso,idarticulo,precio_compra,precio_venta,
stock_inicial,stock_actual,fecha_produccion,fecha_vencimiento)
values (@idingreso,@idarticulo,@precio_compra,@precio_venta,
@stock_inicial,@stock_actual,@fecha_produccion,@fecha_vencimiento)

GO
/****** Object:  StoredProcedure [dbo].[spinsertar_detalle_venta]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Insertar detalles 
create proc [dbo].[spinsertar_detalle_venta]
@iddetalle_venta int output,
@idventa int,
@iddetalle_ingreso int,
@cantidad int,
@precio_venta money,
@descuento money
as
insert into detalle_venta (idventa,iddetalle_ingreso,cantidad,precio_venta,descuento)
values (@idventa,@iddetalle_ingreso,@cantidad,@precio_venta,@descuento)

GO
/****** Object:  StoredProcedure [dbo].[spinsertar_ingreso]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Procedimiento insertar ingreso
create proc [dbo].[spinsertar_ingreso]
@idingreso int=null output,
@idtrabajador int,
@idproveedor int,
@fecha date,
@tipo_comprobante varchar(20),
@serie varchar(4),
@correlativo varchar(7),
@igv decimal (4,2),
@estado varchar(7)
as
insert into ingreso (idtrabajador,idproveedor,fecha,tipo_comprobante,
serie,correlativo,igv,estado)
values (@idtrabajador,@idproveedor,@fecha,@tipo_comprobante,
@serie,@correlativo,@igv,@estado)
-- Obtener el código autogenerado
SET @idingreso=@@IDENTITY

GO
/****** Object:  StoredProcedure [dbo].[spinsertar_presentacion]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spinsertar_presentacion]
@idpresentacion int output,
@nombre varchar(50),
@descripcion varchar(256)
as
insert into presentacion (nombre,descripcion)
values (@nombre,@descripcion)

GO
/****** Object:  StoredProcedure [dbo].[spinsertar_proveedor]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--insertar
create proc [dbo].[spinsertar_proveedor]
@idproveedor int output,
@razon_social varchar(150),
@sector_comercial varchar(50),
@tipo_documento varchar(20),
@num_documento varchar(11),
@direccion varchar(100),
@telefono varchar(10),
@email varchar(50),
@url varchar(100)
as
insert into proveedor (razon_social,sector_comercial,tipo_documento,
num_documento,direccion,telefono,email,url)
values (@razon_social,@sector_comercial,@tipo_documento,
@num_documento,@direccion,@telefono,@email,@url)

GO
/****** Object:  StoredProcedure [dbo].[spinsertar_trabajador]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Insertar
create proc [dbo].[spinsertar_trabajador]
@idtrabajador int output,
@nombre varchar(20),
@apellidos varchar(40),
@sexo varchar(1),
@fecha_nacimiento date,
@num_documento varchar(20),
@direccion varchar(100),
@telefono varchar(10),
@email varchar(50),
@acceso varchar(20),
@usuario varchar(20),
@password varchar(20)
as
insert into trabajador (nombre,apellidos,sexo,fecha_nac,num_documento,
direccion,telefono,email,acceso,usuario,password)
values (@nombre,@apellidos,@sexo,@fecha_nacimiento,@num_documento,
@direccion,@telefono,@email,@acceso,@usuario,@password)

GO
/****** Object:  StoredProcedure [dbo].[spinsertar_venta]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Insertar Venta
create proc [dbo].[spinsertar_venta]
@idventa int=null output,
@idcliente int,
@idtrabajador int,
@fecha date,
@tipo_comprobante varchar(20),
@serie varchar(4),
@correlativo varchar(7),
@igv decimal(4,2)
as
insert into venta (idcliente,idtrabajador,fecha,tipo_comprobante,
serie,correlativo,igv)
values (@idcliente,@idtrabajador,@fecha,@tipo_comprobante,
@serie,@correlativo,@igv)
-- Obtener el código autogenerado
set @idventa=@@IDENTITY

GO
/****** Object:  StoredProcedure [dbo].[splogin]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[splogin]
@usuario varchar(20),
@password varchar(20)
as
select idtrabajador,apellidos,nombre,acceso
from trabajador
where usuario=@usuario and password=@password

GO
/****** Object:  StoredProcedure [dbo].[spmostrar_articulo]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spmostrar_articulo]
as
SELECT top 100 dbo.articulo.idarticulo, dbo.articulo.codigo, dbo.articulo.nombre,
dbo.articulo.descripcion, dbo.articulo.imagen, dbo.articulo.idcategoria,
dbo.categoria.nombre AS Categoria, dbo.articulo.idpresentacion, 
dbo.presentacion.nombre AS Presentacion
FROM dbo.articulo INNER JOIN dbo.categoria 
ON dbo.articulo.idcategoria = dbo.categoria.idcategoria 
INNER JOIN dbo.presentacion 
ON dbo.articulo.idpresentacion = dbo.presentacion.idpresentacion
order by dbo.articulo.idarticulo desc

GO
/****** Object:  StoredProcedure [dbo].[spmostrar_articuloo.bak]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spmostrar_articuloo.bak]
as
SELECT top 100    dbo.articulo.idarticulo, dbo.articulo.codigo, dbo.articulo.nombre, dbo.articulo.descripcion, dbo.articulo.idcategoria, dbo.categoria.nombre AS Categoria, 
                      dbo.articulo.idpresentacion, dbo.presentacion.nombre AS Presentacion
FROM         dbo.articulo INNER JOIN
                      dbo.categoria 
					  ON dbo.articulo.idcategoria = dbo.categoria.idcategoria INNER JOIN
                      dbo.presentacion 
					  ON dbo.articulo.idpresentacion = dbo.presentacion.idpresentacion
order by dbo.articulo.idarticulo desc

GO
/****** Object:  StoredProcedure [dbo].[spmostrar_categoria]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Procedimiento mostrar
create proc [dbo].[spmostrar_categoria]
as
select top 200 * from categoria
order by idcategoria desc

GO
/****** Object:  StoredProcedure [dbo].[spmostrar_cliente]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Mostrar
create proc [dbo].[spmostrar_cliente]
as
select top 100 * from cliente
order by apellidos asc

GO
/****** Object:  StoredProcedure [dbo].[spmostrar_detalle_ingreso]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Mostrar detalle de ingreso
CREATE proc [dbo].[spmostrar_detalle_ingreso]
@textobuscar int
as
select d.idarticulo,a.nombre as Articulo,d.precio_compra,
d.precio_venta,d.stock_inicial,d.fecha_produccion,
d.fecha_vencimiento,(d.stock_inicial*d.precio_compra) as Subtotal
from detalle_ingreso d inner join articulo a
on d.idarticulo=a.idarticulo
where d.idingreso=@textobuscar

GO
/****** Object:  StoredProcedure [dbo].[spmostrar_detalle_venta]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Mostrar los detalles de una venta
create proc [dbo].[spmostrar_detalle_venta]
@textobuscar int
as
select d.iddetalle_ingreso,a.nombre as Articulo,
d.cantidad,d.precio_venta,d.descuento,
((d.precio_venta*d.cantidad)-d.descuento) as Subtotal
from detalle_venta d inner join detalle_ingreso di
on d.iddetalle_ingreso=di.iddetalle_ingreso
inner join articulo a
on di.idarticulo=a.idarticulo
where d.idventa=@textobuscar

GO
/****** Object:  StoredProcedure [dbo].[spmostrar_ingreso]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- (CÓDIGO QUE EJECUTA DESPUÉS, DEBES EJECUTAR EL "create proc spmostrar_ingreso" 
-- COMPLETO DE ARRIBA ANTES

-- Procedimiento almacenado para mostrar los ingresos
CREATE proc [dbo].[spmostrar_ingreso]
as
select top 100 i.idingreso,(t.apellidos+' '+t.nombre) as Trabajador,
p.razon_social as Proveedor,i.fecha,i.tipo_comprobante,i.serie,
i.correlativo,i.estado,
sum(d.precio_compra*d.stock_inicial) as Total
from detalle_ingreso d inner join ingreso i
on d.idingreso=i.idingreso
inner join proveedor p
on i.idproveedor=p.idproveedor
inner join trabajador t
on i.idtrabajador=t.idtrabajador
group by i.idingreso,t.apellidos+' '+t.nombre,
p.razon_social,i.fecha,i.tipo_comprobante,i.serie,
i.correlativo,i.estado
order by i.idingreso desc

GO
/****** Object:  StoredProcedure [dbo].[spmostrar_presentacion]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spmostrar_presentacion]
as
select top 100 * from presentacion
order by idpresentacion desc

GO
/****** Object:  StoredProcedure [dbo].[spmostrar_proveedor]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spmostrar_proveedor]
as
select top 100 * from proveedor
order by razon_social asc

GO
/****** Object:  StoredProcedure [dbo].[spmostrar_trabajador]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Mostrar
create proc [dbo].[spmostrar_trabajador]
as
select top 100 * from trabajador
order by apellidos asc

GO
/****** Object:  StoredProcedure [dbo].[spmostrar_venta]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spmostrar_venta]
as
select top 100 v.idventa,
(t.apellidos+' '+t.nombre) as Trabajador,
(c.apellidos+' '+c.nombre) as Cliente,
v.fecha,v.tipo_comprobante,v.serie,v.correlativo,
sum((d.cantidad*d.precio_venta)-d.descuento) as Total
from detalle_venta d inner join venta v
on d.idventa=v.idventa
inner join cliente c
on v.idcliente=c.idcliente
inner join trabajador t
on v.idtrabajador=t.idtrabajador
group by v.idventa,
(t.apellidos+' '+t.nombre),
(c.apellidos+' '+c.nombre),
v.fecha,v.tipo_comprobante,v.serie,v.correlativo
order by v.idventa desc

GO
/****** Object:  StoredProcedure [dbo].[spreporte_factura]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Reporte de factura
create proc [dbo].[spreporte_factura]
@idventa int
as
select
v.idventa,(t.apellidos+' '+t.nombre) as Trabajador,
(c.apellidos+' '+c.nombre) as Cliente,
c.direccion,c.telefono,c.num_documento,
v.fecha,v.tipo_comprobante,v.serie,v.correlativo,
v.igv,a.nombre,dv.precio_venta,dv.cantidad,dv.descuento,
(dv.cantidad*dv.precio_venta-dv.descuento) as Total_Parcial

from detalle_venta dv inner join detalle_ingreso di
on dv.iddetalle_ingreso=di.iddetalle_ingreso
inner join articulo a
on a.idarticulo=di.idarticulo
inner join venta v
on v.idventa=dv.idventa
inner join cliente c
on v.idcliente=c.idcliente
inner join trabajador t
on t.idtrabajador=v.idtrabajador
where v.idventa=@idventa

GO
/****** Object:  StoredProcedure [dbo].[spstock_articulos]    Script Date: 9/3/2019 12:12:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spstock_articulos]
as
SELECT dbo.articulo.codigo, dbo.articulo.nombre, 
dbo.categoria.nombre AS Categoria,
sum(dbo.detalle_ingreso.stock_inicial) as Cantidad_Ingreso, 
sum(dbo.detalle_ingreso.stock_actual) as Cantidad_Stock,
(sum(dbo.detalle_ingreso.stock_inicial)-
sum(dbo.detalle_ingreso.stock_actual)) as Cantidad_Venta
FROM dbo.articulo INNER JOIN dbo.categoria 
ON dbo.articulo.idcategoria = dbo.categoria.idcategoria 
INNER JOIN dbo.detalle_ingreso 
ON dbo.articulo.idarticulo = dbo.detalle_ingreso.idarticulo 
INNER JOIN dbo.ingreso 
ON dbo.detalle_ingreso.idingreso = dbo.ingreso.idingreso
where ingreso.estado<>'ANULADO'
group by dbo.articulo.codigo, dbo.articulo.nombre, 
dbo.categoria.nombre
GO