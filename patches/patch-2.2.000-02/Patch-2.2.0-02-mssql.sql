use dev221_etracs
go


CREATE TABLE entitycontact
(
	objid VARCHAR(50) PRIMARY KEY,
	entityid VARCHAR(50) NOT NULL,
	contacttype VARCHAR(25) NOT NULL,
	contact VARCHAR(25) NOT NULL
)
go

ALTER TABLE entitycontact 
	ADD CONSTRAINT FK_entitycontact_entity FOREIGN KEY( entityid)
	REFERENCES entity(objid)
go	
	