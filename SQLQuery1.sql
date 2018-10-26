USE DBNEW
GO

CREATE TABLE Blogusers  (
login varchar(50) NOT NULL,
Password nvarchar(50) NOT NULL,
Name nvarchar(50) NOT NULL,
Age int  NOT NULL, 
Reg_date datetime NOT NULL,
"e-mail" nvarchar(50) NOT NULL
)
GO

SELECT * FROM Blogusers
GO

INSERT INTO Blogusers (login, Password, Name, Age, Reg_date, "e-mail") VALUES 
('user03', 3424235, 'Kosta', 55, CAST('2007-05-08 13:00:00' AS DateTime), 'doom2@mail.ru'),
('user04', 54521145, 'Yura', 34, CAST('2007-05-08 14:00:00' AS DateTime), 'norrest2@list.ru')
GO

DECLARE @smalldatetime SmallDateTime = CAST('2007-05-08 12:35:29' AS SmallDateTime)
PRINT @smalldatetime;  
GO


CREATE TABLE Blogusers2  (
login varchar(50) NOT NULL,
Password nvarchar(50) NOT NULL,
Name nvarchar(50) NOT NULL,
Age int  NOT NULL, 
Reg_date date NOT NULL,
"e-mail" nvarchar(50) NOT NULL
)
GO

DECLARE @smalldatetime SmallDateTime = CAST('2007-05-08' AS  Date)
PRINT @smalldatetime;  
GO

INSERT INTO Blogusers2 (login, Password, Name, Age, Reg_date, "e-mail") VALUES 
('user01', 3424235, 'Kosta', 55, CAST('2017-05-15' AS Date), 'doom2@mail.ru'),
('user02', 54521145, 'Yura', 34, CAST('2018-05-12' AS Date), 'norrest2@list.ru')
GO

SELECT * FROM Blogusers2
GO

INSERT INTO Blogusers2 (login, Password, Name, Age, Reg_date, "e-mail") VALUES 
('user03', 3424235, 'Vasja', 55, '20/02/2016', 'doom3@mail.ru'),
('user04', 5452111145, 'Petja', 34, '14/12/2001', 'norrest33@list.ru')
GO


INSERT INTO Blogusers2 (login, Password, Name, Age, Reg_date, "e-mail") VALUES 
('user0355', 3424235, 'Vasja', 55, '20/02/2016', 'doom3@mail.ru')
GO

DELETE Blogusers2
WHERE login = 'user0355'
GO

SELECT * FROM Blogusers2
GO

UPDATE Blogusers2
SET "Password" = '522334556'
WHERE "login" = 'user01'
GO

--����������, ��� ��� list.ru � �����, ���������� �� ������ (��������)
SELECT * FROM Blogusers2
WHERE "e-mail" NOT LIKE '%list.ru%'
ORDER BY "login" DESC
GO


--���������� ������� ����
DECLARE @smalldatetime SmallDateTime = GETDATE()
PRINT @smalldatetime;  
GO

--���������� ������, ��� ���� ������ �������
SELECT * FROM Blogusers2
WHERE Reg_date < GETDATE()
GO


--���������� ������, ��� ���� ������ 2017 ����
SELECT * FROM Blogusers2
WHERE Reg_date < CAST ('01-01-2017' AS Date)
GO

--���������� ������, ��� ���� ������ 2017 ���� (CAST �������� � �������� ('01-01-2017' � '2017-01-01')
SELECT * FROM Blogusers2
WHERE Reg_date < CAST ('2017-01-01' AS Date)
GO


CREATE TABLE orders  (
login varchar(50) NOT NULL,
product varchar(50) NOT NULL,
client varchar(50) NOT NULL,
"count" int NOT NULL,
orderdate date NOT NULL
)
GO



INSERT INTO orders VALUES
('user01','����','������ �.�.',22,'22/05/2018'),
('user01','����','������ �.�.',5,'22/05/2018'),
('user01','������','������ �.�.',12,'23/05/2018'),
('user02','������','������� �.�.',12,'23/05/2017'),
('user02','�����','������� �.�.',2,'10/05/2017')
GO

INSERT INTO orders VALUES
('user01','����','�������� �.�.',1,'10/05/2018')
GO

--���������� ������������� � ������, ������� ���� ������� ������� � 1 ������ 2018
SELECT * FROM Blogusers2 a
join
orders b
ON a.login = b.login
WHERE b.orderdate >= CAST ('01-01-2018' as Date)
GO

-- ���������� ������������� (���, �����, �����), � ������� ���� ������ � ��������� �� �������� � ���-��� �� �������(���������)
SELECT a.Name,a.login,a.[e-mail],b.client, COUNT(b.client) AS [���-�� ���������] FROM Blogusers2 a
join
orders b
ON a.login = b.login
GROUP BY a.Name,a.login,a.[e-mail],b.client
ORDER BY a.login ASC
GO


-- ���������� ������������� (���, �����, �����), � ������� ���� ������ � ��������� �� �������� � ���-��� �� ������� (�������)
SELECT a.Name,a.login,a.[e-mail],b.client, SUM(b.count) AS [���-�� �������] FROM Blogusers2 a
join
orders b
ON a.login = b.login
GROUP BY a.Name,a.login,a.[e-mail],b.client
ORDER BY a.login ASC
GO

-- ���������� ������������� (���, �����, �����), � ������� ���� ������ � ��������� �� �������� � ���-��� �� ������� (�������)� ���-�� ������� ������ 10-��
SELECT a.Name,a.login,a.[e-mail],b.client, SUM(b.count) AS [���-�� �������] FROM Blogusers2 a
join
orders b
ON a.login = b.login
GROUP BY a.Name,a.login,a.[e-mail],b.client
HAVING SUM(b.count) > 10
ORDER BY a.login ASC
GO
