USE [master]
GO
CREATE DATABASE [StackOverflow] ON
( FILENAME = '$(wkdir)/StackOverflow2010.mdf'),
( FILENAME = '$(wkdir)/StackOverflow2010_log.ldf')
FOR ATTACH
GO 