-- Create Tables
CREATE TABLE WithFriends_Users (
	UserId 				INTEGER,
	FirstName 			VARCHAR(20),
	LastName 			VARCHAR(20),
    sex					CHAR(1),
    EmailID 			VARCHAR(50),
    PWD	    			VARCHAR(20),
    DOB 				DATE,
	Address 			VARCHAR(50),
	City 				VARCHAR(20),
	State 				VARCHAR(20),
	ZipCode 			INTEGER,
	Telephone 			INTEGER,
	AccountNumber 		INTEGER,
	AccountCreationDate DATE,
	CreditCardNumber 	INTEGER,
	Preference 			VARCHAR(150),
	Ratings 			INTEGER,
	PRIMARY KEY (UserId),
	UNIQUE (AccountNumber)
);

CREATE TABLE WithFriends_Logins(
	LoginInId			INTEGER,
    PRIMARY KEY (LoginInId),
    FOREIGN KEY (LoginInId)	REFERENCES WithFriends_Users(UserId)
    ON DELETE CASCADE
	ON UPDATE CASCADE
);

CREATE TABLE WithFriends_UsersFriends (
	UserId 				INTEGER,
	FriendId 			INTEGER,
	PRIMARY KEY (UserId, FriendId),
	FOREIGN KEY (UserId) REFERENCES WithFriends_Users (UserId)
    ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (FriendId) REFERENCES WithFriends_Users (UserId)
    ON DELETE CASCADE
	ON UPDATE CASCADE
);

CREATE TABLE WithFriends_Groups (
	GroupId 			INTEGER,
	GroupName 			VARCHAR(50),
	Type 				VARCHAR(20),
	OwnerId 			INTEGER,
	PRIMARY KEY (GroupId),
	FOREIGN KEY (OwnerId) REFERENCES WithFriends_Users (UserId)
    ON DELETE CASCADE
	ON UPDATE CASCADE
);

CREATE TABLE WithFriends_GroupsMembers (
	GroupId 			INTEGER,
	UserId 				INTEGER,
	PRIMARY KEY (GroupId, UserId),
	FOREIGN KEY (GroupId) REFERENCES WithFriends_Groups (GroupId)
    ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (UserId) REFERENCES WithFriends_Users (UserId)
    ON DELETE CASCADE
	ON UPDATE CASCADE
);

CREATE TABLE WithFriends_Pages (
	PageId 				INTEGER,
	OwnerId 			INTEGER DEFAULT NULL,
	GroupId 			INTEGER DEFAULT NULL,
	PostCount 			INTEGER,
	PageType 			CHAR(5),
	PRIMARY KEY (PageId),
	FOREIGN KEY (OwnerId) REFERENCES WithFriends_Users (UserId)
    ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (GroupId) REFERENCES WithFriends_Groups (GroupId)
    ON DELETE CASCADE
	ON UPDATE CASCADE,
	CHECK (!(OwnerId = NULL && GroupId = NULL) && !(OwnerId != NULL && GroupId != NULL)),
	CHECK (PageType IN (‘Group’, ‘User’))
);

CREATE TABLE WithFriends_Posts (
	PostId 				INTEGER,
	PosterId 			INTEGER,
	PageId 				INTEGER,
	PostDate 			DATE,
	Content 			VARCHAR(2000),
	CommentCount 		INTEGER,
	PRIMARY KEY (PostId),
	FOREIGN KEY (PosterId) REFERENCES WithFriends_Users (UserId)
    ON DELETE SET NULL
	ON UPDATE CASCADE,
	FOREIGN KEY (PageId) REFERENCES WithFriends_Pages (PageId)
    ON DELETE CASCADE
	ON UPDATE CASCADE
);

CREATE TABLE WithFriends_Comments (
	CommentId 			INTEGER,
	PosterId 			INTEGER,
	PostId 				INTEGER,
	PostDate 			DATE,
	Content 			VARCHAR(2000),
	PRIMARY KEY (CommentId),
	FOREIGN KEY (PosterId) REFERENCES WithFriends_Users (UserId)
    ON DELETE SET NULL
	ON UPDATE CASCADE,
	FOREIGN KEY (PostId) REFERENCES WithFriends_Posts (PostId)
    ON DELETE CASCADE
	ON UPDATE CASCADE
);

CREATE TABLE WithFriends_Messages (
	MessageId 			INTEGER,
	SentDate 			DATE,
	Subject 			VARCHAR(50),
	Content 			VARCHAR(2000),
	PRIMARY KEY (MessageId)
);

CREATE TABLE WithFriends_MessagesSent (
	MessageId 				INTEGER,
	SenderId 				INTEGER,
	ReceiverId 				INTEGER,
	PRIMARY KEY (MessageId, SenderId, ReceiverId),
	FOREIGN KEY (MessageId) REFERENCES WithFriends_Messages (MessageId)
    ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (SenderId) REFERENCES WithFriends_Users (UserId)
    ON DELETE SET NULL
	ON UPDATE CASCADE,
	FOREIGN KEY (ReceiverId) REFERENCES WithFriends_Users (UserId)
    ON DELETE CASCADE
	ON UPDATE CASCADE
);

CREATE TABLE WithFriends_Employees (
	EmployeeId 				INTEGER,
	SSN 					INTEGER,
	HourlyRate 				DECIMAL (5,2),
	PRIMARY KEY (EmployeeId),
    FOREIGN KEY (EmployeeId) REFERENCES WithFriends_Users(UserId)
    ON DELETE CASCADE
	ON UPDATE CASCADE,
	UNIQUE (SSN)
);

CREATE TABLE WithFriends_Advertisements (
	ADId 			INTEGER,
	EmployeeId 		INTEGER,
	Type 			VARCHAR(20),
	PostDate 		DATE,
	Company 		VARCHAR(50),
	ItemName 		VARCHAR(50),
	Content 		VARCHAR(2000),
	UnitPrice 		INTEGER,
	PRIMARY KEY (ADId),
	FOREIGN KEY (EmployeeId) REFERENCES WithFriends_Employees (EmployeeId)
    ON DELETE NO ACTION
	ON UPDATE CASCADE
);

CREATE TABLE WithFriends_Sales (
	TransactionId 		INTEGER,
	SalesDate 			DATETIME,
	ADId 				INTEGER,
	Units 				INTEGER,
	AccountNumber 		INTEGER,
	PRIMARY KEY (TransactionId),
	FOREIGN KEY (ADId) REFERENCES WithFriends_Advertisements (ADId),
	FOREIGN KEY (AccountNumber) REFERENCES WithFriends_Users (AccountNumber)
);

CREATE TABLE WithFriends_LikePost (
	UserId 		INTEGER,
	PostId 		INTEGER,
	PRIMARY KEY (UserId, PostId),
	FOREIGN KEY (UserId) REFERENCES WithFriends_Users(UserId)
    ON DELETE NO ACTION
	ON UPDATE CASCADE,
	FOREIGN KEY (PostId) REFERENCES WithFriends_Posts(PostId)
    ON DELETE CASCADE
	ON UPDATE CASCADE
);

CREATE TABLE WithFriends_LikeComment (
	UserId 			INTEGER,
	CommentId 		INTEGER,
	PRIMARY KEY (UserId, CommentId),
	FOREIGN KEY (UserId) REFERENCES WithFriends_Users(UserId)
    ON DELETE NO ACTION
	ON UPDATE CASCADE,
	FOREIGN KEY (CommentId) REFERENCES WithFriends_Comments(CommentId)
    ON DELETE CASCADE
	ON UPDATE CASCADE
);

-- Load User data
INSERT INTO WithFriends_Users (UserId, FirstName, LastName, sex, EmailID, PWD, DOB, City, State, 
ZipCode, Telephone, AccountNumber, AccountCreationDate, Preference) 
VALUES (100001,	"Michael", "Collins", "M", "Michael.Collins@cse305.stonybrook.edu",
	"care2cash", '1997-03-14', "Washington", "DC",	12345,	228807080,	900001, '2016-11-15',
    "Slacklining,Skateboarding,Surfing,Orienteering,Water sports");

INSERT INTO WithFriends_Users (UserId, FirstName, LastName, sex, EmailID, PWD, DOB, City, State, 
ZipCode, Telephone, AccountNumber, AccountCreationDate, Preference) 
VALUES (100002,	"Aria", "Rose", "F", "Aria.Rose@cse305.stonybrook.edu",
	"dawn4call", '1991-05-11', "New York", "NY",	10001,	263303749,	900002, '2016-11-15',
    "Topiary,Jogging");
    
INSERT INTO WithFriends_Users (UserId, FirstName, LastName, sex, EmailID, PWD, DOB, City, State, 
ZipCode, Telephone, AccountNumber, AccountCreationDate, Preference) 
VALUES (100003,	"Jase", "Black", "M", "Jase.Black@cse305.stonybrook.edu",
	"data6bell", '2012-04-26', "Washington", "DC",	12345,	917443776,	900003, '2016-11-15',
    "Rugby,Roller skating,Life insurance,Rock climbing,Scouting");
    
INSERT INTO WithFriends_Users (UserId, FirstName, LastName, sex, EmailID, PWD, DOB, City, State, 
ZipCode, Telephone, AccountNumber, AccountCreationDate, Preference) 
VALUES (100004,	"Ellie", "Franklin", "F", "Ellie.Franklin@cse305.stonybrook.edu",
	"ablelcash", '2009-03-09', "Stony Brook", "NY",	11794,	381870672,	900004, '2016-11-15',
    "Cars,Skydiving,Bird watching,Sailing,Shopping,Skimboarding,Kayaking,Camping,Blacksmithing");
    
INSERT INTO WithFriends_Users (UserId, FirstName, LastName, sex, EmailID, PWD, DOB, City, State, 
ZipCode, Telephone, AccountNumber, AccountCreationDate, Preference) 
VALUES (100005,	"Mackenzie", "Wells", "F", "Mackenzie.Wells@cse305.stonybrook.edu",
	"burn2coat", '2004-09-14', "New York", "NY",	10001,	736594241,	900005, '2016-11-15',
    "Hunting,Topiary,Nordic skating,Foraging,Metal detecting,Camping,Astronomy");

INSERT INTO WithFriends_Users (UserId, FirstName, LastName, sex, EmailID, PWD, DOB, City, State, 
ZipCode, Telephone, AccountNumber, AccountCreationDate, Preference) 
VALUES (100006,	"Cameron", "Armstrong", "M", "Cameron.Armstrong@cse305.stonybrook.edu",
	"aged6area", '2010-08-14', "New York", "NY",	10001,	182209299,	900006, '2016-11-15',
    "Skydiving,Topiary,Scuba diving,Sailing,Beekeeping,Tai chi,Brazilian jiu-jitsu,Astronomy,Jogging");
    
INSERT INTO WithFriends_Users (UserId, FirstName, LastName, sex, EmailID, PWD, DOB, City, State, 
ZipCode, Telephone, AccountNumber, AccountCreationDate, Preference) 
VALUES (100007,	"Levi", "Ross", "M", "Levi.Ross@cse305.stonybrook.edu",
	"been7beer", '1991-06-07', "Stony Brook", "NY",	11794,	127536938,	900007, '2016-11-15',
    "Urban exploration,Freestyle football");
    
INSERT INTO WithFriends_Users (UserId, FirstName, LastName, sex, EmailID, PWD, DOB, City, State, 
ZipCode, Telephone, AccountNumber, AccountCreationDate, Preference) 
VALUES (100008,	"Levi", "West", "M", "Levi.West@cse305.stonybrook.edu",
	"coal3cell", '2011-02-09', "New York", "NY",	10001,	699136094,	900008, '2016-11-15',
    "BASE jumping,Letterboxing,Roller skating,Metal detecting,Swimming,Mountaineering,
    Sculling or Rowing,Basketball,Surfing");
    
INSERT INTO WithFriends_Users (UserId, FirstName, LastName, sex, EmailID, PWD, DOB, City, State, 
ZipCode, Telephone, AccountNumber, AccountCreationDate, Preference) 
VALUES (100009,	"Christian", "Davies", "M", "Christian.Davies@cse305.stonybrook.edu",
	"bush1bone", '2011-05-10', "Stony Brook", "NY",	11794,	364390765,	900009, '2016-11-15',
    "BASE jumping,Driving,Mountaineering");
    
INSERT INTO WithFriends_Users (UserId, FirstName, LastName, sex, EmailID, PWD, DOB, City, State, 
ZipCode, Telephone, AccountNumber, AccountCreationDate, Preference) 
VALUES (100010,	"Kylie", "Davies", "F", "Kylie.Davies@cse305.stonybrook.edu",
	"coat7calm", '1996-11-22', "New York", "NY",	10001,	562348521,	900010, '2016-11-15',
    "Toys,Graffiti,Skiing,Road biking,Kayaking");
    
INSERT INTO WithFriends_Users (UserId, FirstName, LastName, sex, EmailID, PWD, DOB, City, State, 
ZipCode, Telephone, AccountNumber, AccountCreationDate, Preference) 
VALUES (100011,	"Tyler", "Long", "M", "Tyler.Long@cse305.stonybrook.edu",
	"area3boom", '2007-01-08', "Stony Brook", "NY",	11794,	306139234,	900011, '2016-11-15',
    "Topiary,Basketball");
    
INSERT INTO WithFriends_Users (UserId, FirstName, LastName, sex, EmailID, PWD, DOB, City, State, 
ZipCode, Telephone, AccountNumber, AccountCreationDate, Preference) 
VALUES (100012, "Henry", "Stewart", "M", "Henry.Stewart@cse305.stonybrook.edu",
	"boat3also", '2006-02-11', "Washington", "DC",	12345,	503422119,	900012, '2016-11-15',
    "Roller skating,Netball,Flag football,Water sports");
    
INSERT INTO WithFriends_Users (UserId, FirstName, LastName, sex, EmailID, PWD, DOB, City, State, 
ZipCode, Telephone, AccountNumber, AccountCreationDate, Preference) 
VALUES (100013, "Isaiah", "Bennett", "M", "Isaiah.Bennett@cse305.stonybrook.edu",
	"book6bank", '1997-12-24', "Washington", "DC",	12345,	929342276,	900013, '2016-11-15',
    "Walking,Baseball,Scuba diving,Running,Shopping");
    
INSERT INTO WithFriends_Users (UserId, FirstName, LastName, sex, EmailID, PWD, DOB, City, State, 
ZipCode, Telephone, AccountNumber, AccountCreationDate, Preference) 
VALUES (100014,	"Arianna", "Dunn", "F", "Arianna.Dunn@cse305.stonybrook.edu",
	"chip2calm", '2003-01-27', "New York", "NY",	10001,	311083148,	900014, '2016-11-15',
    "Shooting,Ghost hunting,Horseback riding,Netball,Astronomy");
    
INSERT INTO WithFriends_Users (UserId, FirstName, LastName, sex, EmailID, PWD, DOB, City, State, 
ZipCode, Telephone, AccountNumber, AccountCreationDate, Preference) 
VALUES (100015,	"Victoria", "Powell", "F", "Victoria.Powell@cse305.stonybrook.edu",
	"cash7bush", '1997-04-28', "New York", "NY",	10001,	854902993,	900015, '2016-11-15',
    "LARPing,Walking,Slacklining,Foraging,Rock climbing,Taekwondo,Inline skating");
    
INSERT INTO WithFriends_Users (UserId, FirstName, LastName, sex, EmailID, PWD, DOB, City, State, 
ZipCode, Telephone, AccountNumber, AccountCreationDate, Preference) 
VALUES (100016, "Blakely", "Alexander", "F", "Blakely.Alexander@cse305.stonybrook.edu",
	"bear3cope", '2006-01-21', "Washington", "DC",	12345,	140361398,	900016, '2016-11-15',
    "Hooping,Bird watching,Shooting,Board sports,Graffiti,Sculling or Rowing");
    
INSERT INTO WithFriends_Users (UserId, FirstName, LastName, sex, EmailID, PWD, DOB, City, State, 
ZipCode, Telephone, AccountNumber, AccountCreationDate, Preference) 
VALUES (100017,	"Connor", "Collins", "M", "Connor.Collins@cse305.stonybrook.edu",
	"ball1days", '2005-06-23', "New York", "NY",	10001,	282433780,	900017, '2016-11-15',
    "Rugby,Skiing,Snowboarding,Rock climbing,Swimming,Skimboarding,Scouting");
    
INSERT INTO WithFriends_Users (UserId, FirstName, LastName, sex, EmailID, PWD, DOB, City, State, 
ZipCode, Telephone, AccountNumber, AccountCreationDate, Preference) 
VALUES (100018,	"Jeremiah", "Miller", "M", "Jeremiah.Miller@cse305.stonybrook.edu",
	"code3case", '1999-11-29', "New York", "NY",	10001,	533130991,	900018, '2016-11-15',
    "Urban exploration,Roller skating,Bird watching,Skiing,Kayaking,Mushroom hunting/Mycology");
    
INSERT INTO WithFriends_Users (UserId, FirstName, LastName, sex, EmailID, PWD, DOB, City, State, 
ZipCode, Telephone, AccountNumber, AccountCreationDate, Preference) 
VALUES (100019,	"Riley", "Field", "F", "Riley.Field@cse305.stonybrook.edu",
	"cash7born", '2003-05-03', "New York", "NY",	10001,	477174572,	900019, '2016-11-15',
    "Photography,LARPing,Shooting,Archery,Kayaking,Fishing ,Astronomy");
    
INSERT INTO WithFriends_Users (UserId, FirstName, LastName, sex, EmailID, PWD, DOB, City, State, 
ZipCode, Telephone, AccountNumber, AccountCreationDate, Preference) 
VALUES (100020,	"Lucy", "Phillips", "F", "Lucy.Phillips@cse305.stonybrook.edu",
	"away2bath", '1996-07-25', "New York", "NY",	10001,	995652638,	900020, '2016-11-15',
    "Parkour,Rock climbing,Handball,Surfing");
    
INSERT INTO WithFriends_Users (UserId, FirstName, LastName, sex, EmailID, PWD, DOB, City, State, 
ZipCode, Telephone, AccountNumber, AccountCreationDate, Preference) 
VALUES (100021,	"Empoyee#1", "Sys#1", "M", "sys1@cse305.stonybrook.edu",
	"admin1", '1993-10-28', "New York", "NY",	10001,	111111111,	900021, '2016-11-15',
    "Managing Stuff");
    
INSERT INTO WithFriends_Users (UserId, FirstName, LastName, sex, EmailID, PWD, DOB, City, State, 
ZipCode, Telephone, AccountNumber, AccountCreationDate, Preference) 
VALUES (100022,	"Empoyee#2", "Sys#2", "M", "sys2@cse305.stonybrook.edu",
	"admin2", '1993-10-28', "New York", "NY",	10001,	111111111,	900022, '2016-11-15',
    "Managing Stuff");
    
INSERT INTO WithFriends_Users (UserId, FirstName, LastName, sex, EmailID, PWD, DOB, City, State, 
ZipCode, Telephone, AccountNumber, AccountCreationDate, Preference) 
VALUES (100023,	"Empoyee#3", "Sys#3", "M", "sys3@cse305.stonybrook.edu",
	"admin3", '1993-10-28', "New York", "NY",	10001,	111111111,	900023, '2016-11-15',
    "Managing Stuff");
    
INSERT INTO WithFriends_Users (UserId, FirstName, LastName, sex, EmailID, PWD, DOB, City, State, 
ZipCode, Telephone, AccountNumber, AccountCreationDate, Preference) 
VALUES (100024,	"Empoyee#4", "Sys#4", "M", "sys4@cse305.stonybrook.edu",
	"admin4", '1993-10-28', "New York", "NY",	10001,	111111111,	900024, '2016-11-15',
    "Managing Stuff");
    
INSERT INTO WithFriends_Users (UserId, FirstName, LastName, sex, EmailID, PWD, DOB, City, State, 
ZipCode, Telephone, AccountNumber, AccountCreationDate, Preference) 
VALUES (100025,	"Empoyee#5", "Sys#5", "M", "sys5@cse305.stonybrook.edu",
	"admin5", '1993-10-28', "New York", "NY",	10001,	111111111,	900025, '2016-11-15',
    "Managing Stuff");
    
INSERT INTO WithFriends_Users (UserId, FirstName, LastName, sex, EmailID, PWD, DOB, City, State, 
ZipCode, Telephone, AccountNumber, AccountCreationDate, Preference) 
VALUES (100026,	"Empoyee#6", "Sys#6", "M", "sys6@cse305.stonybrook.edu",
	"admin6", '1993-10-28', "New York", "NY",	10001,	111111111,	900026, '2016-11-15',
    "Managing Stuff");
    
INSERT INTO WithFriends_Users (UserId, FirstName, LastName, sex, EmailID, PWD, DOB, City, State, 
ZipCode, Telephone, AccountNumber, AccountCreationDate, Preference) 
VALUES (100027,	"Empoyee#7", "Sys#7", "M", "sys7@cse305.stonybrook.edu",
	"admin7", '1993-10-28', "New York", "NY",	10001,	111111111,	900027, '2016-11-15',
    "Managing Stuff");
    
INSERT INTO WithFriends_Users (UserId, FirstName, LastName, sex, EmailID, PWD, DOB, City, State, 
ZipCode, Telephone, AccountNumber, AccountCreationDate, Preference) 
VALUES (100028,	"Empoyee#8", "Sys#8", "M", "sys8@cse305.stonybrook.edu",
	"admin8", '1993-10-28', "New York", "NY",	10001,	111111111,	900028, '2016-11-15',
    "Managing Stuff");
    
INSERT INTO WithFriends_Users (UserId, FirstName, LastName, sex, EmailID, PWD, DOB, City, State, 
ZipCode, Telephone, AccountNumber, AccountCreationDate, Preference) 
VALUES (100029,	"Empoyee#9", "Sys#9", "M", "sys9@cse305.stonybrook.edu",
	"admin9", '1993-10-28', "New York", "NY",	10001,	111111111,	900029, '2016-11-15',
    "Managing Stuff");
    
INSERT INTO WithFriends_Users (UserId, FirstName, LastName, sex, EmailID, PWD, DOB, City, State, 
ZipCode, Telephone, AccountNumber, AccountCreationDate, Preference) 
VALUES (100030,	"Empoyee#10", "Sys#10", "M", "sys10@cse305.stonybrook.edu",
	"admin10", '1993-10-28', "New York", "NY",	10001,	111111111,	900030, '2016-11-15',
    "Managing Stuff");
    
-- Load UserFriends data 
INSERT INTO WithFriends_UsersFriends (UserId, FriendId) 
VALUES (100001, 100020);
INSERT INTO WithFriends_UsersFriends (UserId, FriendId) 
VALUES (100002, 100019);
INSERT INTO WithFriends_UsersFriends (UserId, FriendId) 
VALUES (100003, 100018);
INSERT INTO WithFriends_UsersFriends (UserId, FriendId) 
VALUES (100004, 100017);
INSERT INTO WithFriends_UsersFriends (UserId, FriendId) 
VALUES (100005, 100016);
INSERT INTO WithFriends_UsersFriends (UserId, FriendId) 
VALUES (100006, 100015);
INSERT INTO WithFriends_UsersFriends (UserId, FriendId) 
VALUES (100007, 100014);
INSERT INTO WithFriends_UsersFriends (UserId, FriendId) 
VALUES (100008, 100013);
INSERT INTO WithFriends_UsersFriends (UserId, FriendId) 
VALUES (100009, 100012);
INSERT INTO WithFriends_UsersFriends (UserId, FriendId) 
VALUES (100010, 100011);

-- Load Group data
INSERT INTO WithFriends_Groups (GroupId, GroupName, Type, OwnerId) 
VALUES (200001, "My Friends", "Friends", 100001);
INSERT INTO WithFriends_Groups (GroupId, GroupName, Type, OwnerId) 
VALUES (200002, "Best Friends", "Friends", 100002);
INSERT INTO WithFriends_Groups (GroupId, GroupName, Type, OwnerId) 
VALUES (200003, "StonyBrookGang", "Friends", 100003);
INSERT INTO WithFriends_Groups (GroupId, GroupName, Type, OwnerId) 
VALUES (200004, "CS Folks", "Friends", 100004);
INSERT INTO WithFriends_Groups (GroupId, GroupName, Type, OwnerId) 
VALUES (200005, "My Family", "Friends", 100005);
INSERT INTO WithFriends_Groups (GroupId, GroupName, Type, OwnerId) 
VALUES (200006, "Microsoft Groupies", "Friends", 100006);
INSERT INTO WithFriends_Groups (GroupId, GroupName, Type, OwnerId) 
VALUES (200007, "WOWers", "Game", 100012);
INSERT INTO WithFriends_Groups (GroupId, GroupName, Type, OwnerId) 
VALUES (200008, "Apartment Union", "Neighbors", 100013);
INSERT INTO WithFriends_Groups (GroupId, GroupName, Type, OwnerId) 
VALUES (200009, "Agents", "Work", 100014);
INSERT INTO WithFriends_Groups (GroupId, GroupName, Type, OwnerId) 
VALUES (200010, "Google Interns", "Interns", 100015);

-- Load GroupMembers data
INSERT INTO WithFriends_GroupsMembers (GroupId, UserId)
VALUES(200001 ,100001);
INSERT INTO WithFriends_GroupsMembers (GroupId, UserId)
VALUES(200001 ,100002);
INSERT INTO WithFriends_GroupsMembers (GroupId, UserId)
VALUES(200001 ,100003);
INSERT INTO WithFriends_GroupsMembers (GroupId, UserId)
VALUES(200001 ,100006);
INSERT INTO WithFriends_GroupsMembers (GroupId, UserId)
VALUES(200003 ,100005);
INSERT INTO WithFriends_GroupsMembers (GroupId, UserId)
VALUES(200003 ,100003);
INSERT INTO WithFriends_GroupsMembers (GroupId, UserId)
VALUES(200004 ,100010);
INSERT INTO WithFriends_GroupsMembers (GroupId, UserId)
VALUES(200004 ,100001);
INSERT INTO WithFriends_GroupsMembers (GroupId, UserId)
VALUES(200004 ,100004);
INSERT INTO WithFriends_GroupsMembers (GroupId, UserId)
VALUES(200004 ,100013);
INSERT INTO WithFriends_GroupsMembers (GroupId, UserId)
VALUES(200005 ,100005);
INSERT INTO WithFriends_GroupsMembers (GroupId, UserId)
VALUES(200005 ,100017);
INSERT INTO WithFriends_GroupsMembers (GroupId, UserId)
VALUES(200005 ,100020);

-- Load Pages data
INSERT INTO WithFriends_Pages (PageId, OwnerId, GroupId, PostCount, PageType) 
VALUES (300001, 100001, NULL, 0, "User");
INSERT INTO WithFriends_Pages (PageId, OwnerId, GroupId, PostCount, PageType) 
VALUES (300002, 100002, NULL, 0, "User");
INSERT INTO WithFriends_Pages (PageId, OwnerId, GroupId, PostCount, PageType) 
VALUES (300003, 100003, NULL, 0, "User");
INSERT INTO WithFriends_Pages (PageId, OwnerId, GroupId, PostCount, PageType) 
VALUES (300004, 100004, NULL, 0, "User");
INSERT INTO WithFriends_Pages (PageId, OwnerId, GroupId, PostCount, PageType) 
VALUES (300005, 100005, NULL, 0, "User");
INSERT INTO WithFriends_Pages (PageId, OwnerId, GroupId, PostCount, PageType) 
VALUES (300006, NULL, 200001, 0, "Group");
INSERT INTO WithFriends_Pages (PageId, OwnerId, GroupId, PostCount, PageType) 
VALUES (300007, NULL, 200002, 0, "Group");
INSERT INTO WithFriends_Pages (PageId, OwnerId, GroupId, PostCount, PageType) 
VALUES (300008, NULL, 200003, 0, "Group");
INSERT INTO WithFriends_Pages (PageId, OwnerId, GroupId, PostCount, PageType) 
VALUES (300009, NULL, 200004, 0, "Group");
INSERT INTO WithFriends_Pages (PageId, OwnerId, GroupId, PostCount, PageType) 
VALUES (300010, NULL, 200005, 0, "Group");

-- Load Posts data
INSERT INTO WithFriends_Posts (PostId, PosterId, PageId, PostDate, Content, CommentCount) 
VALUES (400001, 100001, 300006, '2016-11-15', "Hey guys, I'm Michael Collins. The number one rule about this group: Michael is the king, Thinks!", 0);
INSERT INTO WithFriends_Posts (PostId, PosterId, PageId, PostDate, Content, CommentCount) 
VALUES (400002, 100001, 300006, '2016-11-15', "This is the second post, just want to make sure it works.", 0);
INSERT INTO WithFriends_Posts (PostId, PosterId, PageId, PostDate, Content, CommentCount) 
VALUES (400003, 100002, 300006, '2016-11-15', "This is Aria, I think CSE 320 is hard. Can somebody give me some advice.", 0);
INSERT INTO WithFriends_Posts (PostId, PosterId, PageId, PostDate, Content, CommentCount) 
VALUES (400004, 100003, 300006, '2016-11-15', "Does anyboby selling a laptop?", 0);
INSERT INTO WithFriends_Posts (PostId, PosterId, PageId, PostDate, Content, CommentCount) 
VALUES (400005, 100004, 300004, '2016-11-15', "Hey, I'm Ellie, just registered for WithFriends and it's absolutely amazing", 0);
INSERT INTO WithFriends_Posts (PostId, PosterId, PageId, PostDate, Content, CommentCount) 
VALUES (400006, 100004, 300004, '2016-11-15', "I only got 50 on the midterm, OMG, I'm failing", 0);
INSERT INTO WithFriends_Posts (PostId, PosterId, PageId, PostDate, Content, CommentCount) 
VALUES (400007, 100010, 300009, '2016-11-15', "I'm Kylie, Does anyone know the requirements to get in CSE major?", 0);
INSERT INTO WithFriends_Posts (PostId, PosterId, PageId, PostDate, Content, CommentCount) 
VALUES (400008, 100001, 300009, '2016-11-15', "Aced Google's interview today, really easy", 0);
INSERT INTO WithFriends_Posts (PostId, PosterId, PageId, PostDate, Content, CommentCount) 
VALUES (400009, 100013, 300009, '2016-11-15', "What's the workload of CSE381 like? I'm really interested in game programming.", 0);
INSERT INTO WithFriends_Posts (PostId, PosterId, PageId, PostDate, Content, CommentCount) 
VALUES (400010, 100004, 300009, '2016-11-15', "My schedule for the next semester is : CSE 219, CSE 220, CSE 320, CSE 306, is it doable?", 0);

-- Load Comments data
INSERT INTO WithFriends_Comments (CommentId, PosterId, PostId, PostDate, Content) 
VALUES (500001, 100002, 400001, '2016-11-16', "The rule is ridiculous Michael!!");
INSERT INTO WithFriends_Comments (CommentId, PosterId, PostId, PostDate, Content) 
VALUES (500002, 100001, 400003, '2016-11-16', "Switch to ISE and you will feel better.");
INSERT INTO WithFriends_Comments (CommentId, PosterId, PostId, PostDate, Content) 
VALUES (500003, 100002, 400004, '2016-11-16', "I'm selling my 2014 Macbook Pro for $1000. Message me if you're interested.");
INSERT INTO WithFriends_Comments (CommentId, PosterId, PostId, PostDate, Content) 
VALUES (500004, 100002, 400005, '2016-11-16', "Hi, I'm Aria, It's so nice to meet you on WithFriends!");
INSERT INTO WithFriends_Comments (CommentId, PosterId, PostId, PostDate, Content) 
VALUES (500005, 100001, 400006, '2016-11-16', "Don't worry too much, the average is like 38. You will be fine.");
INSERT INTO WithFriends_Comments (CommentId, PosterId, PostId, PostDate, Content) 
VALUES (500006, 100001, 400007, '2016-11-16', "You will have to pass both 114 and 215 with C or better.");
INSERT INTO WithFriends_Comments (CommentId, PosterId, PostId, PostDate, Content) 
VALUES (500007, 100002, 400008, '2016-11-16', "You are really good. What kind of questions you were asked?");
INSERT INTO WithFriends_Comments (CommentId, PosterId, PostId, PostDate, Content) 
VALUES (500008, 100001, 400008, '2016-11-16', "Well, it's basically just coding stuff with data structures and algorithms.");
INSERT INTO WithFriends_Comments (CommentId, PosterId, PostId, PostDate, Content) 
VALUES (500009, 100001, 400009, '2016-11-16', "CSE 381 is hard and heavliy use C++.");
INSERT INTO WithFriends_Comments (CommentId, PosterId, PostId, PostDate, Content) 
VALUES (500010, 100002, 400010, '2016-11-16', "You will have no time to sleep if you do this.");

-- Load Messages data
INSERT INTO WithFriends_Messages (MessageId, SentDate, Subject, Content)
VALUES (600001, '2016-11-17', 'System Msg', 'Content#1');
INSERT INTO WithFriends_Messages (MessageId, SentDate, Subject, Content)
VALUES (600002, '2016-11-17', 'System Msg', 'Content#2');
INSERT INTO WithFriends_Messages (MessageId, SentDate, Subject, Content)
VALUES (600003, '2016-11-17', 'System Msg', 'Content#3');
INSERT INTO WithFriends_Messages (MessageId, SentDate, Subject, Content)
VALUES (600004, '2016-11-17', 'System Msg', 'Content#4');
INSERT INTO WithFriends_Messages (MessageId, SentDate, Subject, Content)
VALUES (600005, '2016-11-17', 'System Msg', 'Content#5');
INSERT INTO WithFriends_Messages (MessageId, SentDate, Subject, Content)
VALUES (600006, '2016-11-17', 'System Msg', 'Content#6');
INSERT INTO WithFriends_Messages (MessageId, SentDate, Subject, Content)
VALUES (600007, '2016-11-17', 'System Msg', 'Content#7');
INSERT INTO WithFriends_Messages (MessageId, SentDate, Subject, Content)
VALUES (600008, '2016-11-17', 'System Msg', 'Content#8');
INSERT INTO WithFriends_Messages (MessageId, SentDate, Subject, Content)
VALUES (600009, '2016-11-17', 'System Msg', 'Content#9');
INSERT INTO WithFriends_Messages (MessageId, SentDate, Subject, Content)
VALUES (600010, '2016-11-17', 'System Msg', 'Content#10');
INSERT INTO WithFriends_Messages (MessageId, SentDate, Subject, Content)
VALUES (600011, '2016-11-17', 'System Msg', 'Content#11');

-- Load MessageSent data
INSERT INTO WithFriends_MessagesSent (MessageId, SenderId, ReceiverId)
VALUES (600001, 100001, 100002);
INSERT INTO WithFriends_MessagesSent (MessageId, SenderId, ReceiverId)
VALUES (600002, 100001, 100003);
INSERT INTO WithFriends_MessagesSent (MessageId, SenderId, ReceiverId)
VALUES (600003, 100004, 100002);
INSERT INTO WithFriends_MessagesSent (MessageId, SenderId, ReceiverId)
VALUES (600004, 100005, 100001);
INSERT INTO WithFriends_MessagesSent (MessageId, SenderId, ReceiverId)
VALUES (600005, 100004, 100007);
INSERT INTO WithFriends_MessagesSent (MessageId, SenderId, ReceiverId)
VALUES (600006, 100002, 100005);
INSERT INTO WithFriends_MessagesSent (MessageId, SenderId, ReceiverId)
VALUES (600007, 100008, 100002);
INSERT INTO WithFriends_MessagesSent (MessageId, SenderId, ReceiverId)
VALUES (600008, 100004, 100009);
INSERT INTO WithFriends_MessagesSent (MessageId, SenderId, ReceiverId)
VALUES (600009, 100010, 100001);
INSERT INTO WithFriends_MessagesSent (MessageId, SenderId, ReceiverId)
VALUES (600010, 100005, 100004);

-- Load Empolyees data
INSERT INTO WithFriends_Employees (EmployeeId, SSN, HourlyRate)
VALUES (100021, 222222001, 10.28);
INSERT INTO WithFriends_Employees (EmployeeId, SSN, HourlyRate)
VALUES (100022, 222222002, 10.28);
INSERT INTO WithFriends_Employees (EmployeeId, SSN, HourlyRate)
VALUES (100023, 222222003, 10.28);
INSERT INTO WithFriends_Employees (EmployeeId, SSN, HourlyRate)
VALUES (100024, 222222004, 10.28);
INSERT INTO WithFriends_Employees (EmployeeId, SSN, HourlyRate)
VALUES (100025, 222222005, 10.28);
INSERT INTO WithFriends_Employees (EmployeeId, SSN, HourlyRate)
VALUES (100026, 222222006, 10.28);
INSERT INTO WithFriends_Employees (EmployeeId, SSN, HourlyRate)
VALUES (100027, 222222007, 10.28);
INSERT INTO WithFriends_Employees (EmployeeId, SSN, HourlyRate)
VALUES (100028, 222222008, 10.28);
INSERT INTO WithFriends_Employees (EmployeeId, SSN, HourlyRate)
VALUES (100029, 222222009, 10.28);
INSERT INTO WithFriends_Employees (EmployeeId, SSN, HourlyRate)
VALUES (100030, 222222010, 10.28);

-- Load ADs data
INSERT INTO WithFriends_Advertisements (ADId, EmployeeId, Type, PostDate, Company, ItemName, Content, UnitPrice)
VALUES (800001, 100021, 'Commercial', '2016-11-17', 'H&M', 'Coat#1', 'Worm and water-proof', '100');
INSERT INTO WithFriends_Advertisements (ADId, EmployeeId, Type, PostDate, Company, ItemName, Content, UnitPrice)
VALUES (800002, 100021, 'Commercial', '2016-11-17', 'A&F', 'Coat#2', 'Worm', '150');
INSERT INTO WithFriends_Advertisements (ADId, EmployeeId, Type, PostDate, Company, ItemName, Content, UnitPrice)
VALUES (800003, 100022, 'Educational', '2016-11-17', 'Blackboard Inc.', 'Blackboard', 'Easy to use', '300');
INSERT INTO WithFriends_Advertisements (ADId, EmployeeId, Type, PostDate, Company, ItemName, Content, UnitPrice)
VALUES (800004, 100023, 'Commercial', '2016-11-17', 'Canada Goose', 'Coat#3', 'Great', '900');
INSERT INTO WithFriends_Advertisements (ADId, EmployeeId, Type, PostDate, Company, ItemName, Content, UnitPrice)
VALUES (800005, 100024, 'Educational', '2016-11-17', 'Nike', 'Sneaker#1', 'Confortable for running', '150');
INSERT INTO WithFriends_Advertisements (ADId, EmployeeId, Type, PostDate, Company, ItemName, Content, UnitPrice)
VALUES (800006, 100024, 'Commercial', '2016-11-17', 'Apple', 'MacBook Pro', 'Powerful', '1999');
INSERT INTO WithFriends_Advertisements (ADId, EmployeeId, Type, PostDate, Company, ItemName, Content, UnitPrice)
VALUES (800007, 100025, 'Commercial', '2016-11-17', 'Microsoft', 'Surface Pro', 'Ppwerful too', '1899');
INSERT INTO WithFriends_Advertisements (ADId, EmployeeId, Type, PostDate, Company, ItemName, Content, UnitPrice)
VALUES (800008, 100024, 'Educational', '2016-11-17', 'Staple', 'Large Notebook', 'Cheap', '3');
INSERT INTO WithFriends_Advertisements (ADId, EmployeeId, Type, PostDate, Company, ItemName, Content, UnitPrice)
VALUES (800009, 100026, 'Commercial', '2016-11-17', 'Dior', 'Handbag#1', 'Luxury', '3000');
INSERT INTO WithFriends_Advertisements (ADId, EmployeeId, Type, PostDate, Company, ItemName, Content, UnitPrice)
VALUES (800010, 100027, 'Commercial', '2016-11-17', 'Michael Kors', 'Handbag#2', 'Great deal', '500');

-- Load Sales data
INSERT INTO WithFriends_Sales (TransactionId, SalesDate, ADId, Units, AccountNumber)
VALUES (110001, '2016-11-17 23:23:23', 800001, 10, 900001);
INSERT INTO WithFriends_Sales (TransactionId, SalesDate, ADId, Units, AccountNumber)
VALUES (110002, '2016-11-17 23:23:23', 800002, 12, 900002);
INSERT INTO WithFriends_Sales (TransactionId, SalesDate, ADId, Units, AccountNumber)
VALUES (110003, '2016-11-17 23:23:23', 800003, 15, 900003);
INSERT INTO WithFriends_Sales (TransactionId, SalesDate, ADId, Units, AccountNumber)
VALUES (110004, '2016-11-17 23:23:23', 800004, 40, 900004);
INSERT INTO WithFriends_Sales (TransactionId, SalesDate, ADId, Units, AccountNumber)
VALUES (110005, '2016-11-17 23:23:23', 800005, 30, 900005);
INSERT INTO WithFriends_Sales (TransactionId, SalesDate, ADId, Units, AccountNumber)
VALUES (110006, '2016-11-17 23:23:23', 800006, 60, 900006);
INSERT INTO WithFriends_Sales (TransactionId, SalesDate, ADId, Units, AccountNumber)
VALUES (110007, '2016-11-17 23:23:23', 800007, 110, 900007);
INSERT INTO WithFriends_Sales (TransactionId, SalesDate, ADId, Units, AccountNumber)
VALUES (110008, '2016-11-17 23:23:23', 800008, 13, 900008);
INSERT INTO WithFriends_Sales (TransactionId, SalesDate, ADId, Units, AccountNumber)
VALUES (110009, '2016-11-17 23:23:23', 800009, 53, 900009);
INSERT INTO WithFriends_Sales (TransactionId, SalesDate, ADId, Units, AccountNumber)
VALUES (110010, '2016-11-17 23:23:23', 800010, 12, 900010);

-- Load LikePost data
INSERT INTO WithFriends_LikePost (UserId, PostId)
VALUES (100001, 400001);
INSERT INTO WithFriends_LikePost (UserId, PostId)
VALUES (100002, 400001);
INSERT INTO WithFriends_LikePost (UserId, PostId)
VALUES (100003, 400002);
INSERT INTO WithFriends_LikePost (UserId, PostId)
VALUES (100004, 400001);
INSERT INTO WithFriends_LikePost (UserId, PostId)
VALUES (100005, 400003);
INSERT INTO WithFriends_LikePost (UserId, PostId)
VALUES (100006, 400004);
INSERT INTO WithFriends_LikePost (UserId, PostId)
VALUES (100007, 400003);
INSERT INTO WithFriends_LikePost (UserId, PostId)
VALUES (100008, 400002);
INSERT INTO WithFriends_LikePost (UserId, PostId)
VALUES (100009, 400001);
INSERT INTO WithFriends_LikePost (UserId, PostId)
VALUES (100010, 400001);

-- Load LikeComment data
INSERT INTO WithFriends_LikeComment (UserId, CommentId)
VALUES (100001, 500004);
INSERT INTO WithFriends_LikeComment (UserId, CommentId)
VALUES (100002, 500001);
INSERT INTO WithFriends_LikeComment (UserId, CommentId)
VALUES (100003, 500001);
INSERT INTO WithFriends_LikeComment (UserId, CommentId)
VALUES (100004, 500001);
INSERT INTO WithFriends_LikeComment (UserId, CommentId)
VALUES (100005, 500002);
INSERT INTO WithFriends_LikeComment (UserId, CommentId)
VALUES (100006, 500001);
INSERT INTO WithFriends_LikeComment (UserId, CommentId)
VALUES (100007, 500002);
INSERT INTO WithFriends_LikeComment (UserId, CommentId)
VALUES (100008, 500001);
INSERT INTO WithFriends_LikeComment (UserId, CommentId)
VALUES (100009, 500005);
INSERT INTO WithFriends_LikeComment (UserId, CommentId)
VALUES (100010, 500007);
