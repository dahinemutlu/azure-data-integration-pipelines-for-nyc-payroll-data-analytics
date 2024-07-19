IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDelimitedTextFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseDelimitedTextFormat] 
	WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
	       FORMAT_OPTIONS (
			 FIELD_TERMINATOR = ',',
			 USE_TYPE_DEFAULT = FALSE
			))
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'adlsnycpayroll-synapse-dahi-n_sanycpayrollsynapsedn_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [adlsnycpayroll-synapse-dahi-n_sanycpayrollsynapsedn_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://adlsnycpayroll-synapse-dahi-n@sanycpayrollsynapsedn.dfs.core.windows.net' 
	)
GO

CREATE EXTERNAL TABLE dbo.NYC_Payroll_Summary (
    [FiscalYear] [int] NULL,
    [AgencyName] [varchar](50) NULL,
    [TotalPaid] [float] NULL
	)
	WITH (
	LOCATION = 'dirstaging',
	DATA_SOURCE = [adlsnycpayroll-synapse-dahi-n_sanycpayrollsynapsedn_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO


SELECT TOP 100 * FROM dbo.NYC_Payroll_Summary
GO