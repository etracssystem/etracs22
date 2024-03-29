ALTER TABLE lguname_etracs.rptsetting ADD COLUMN allowreassessmentwithbalance INT NULL;

UPDATE lguname_etracs.rptsetting SET allowreassessmentwithbalance = 0 WHERE allowreassessmentwithbalance IS NULL ;

ALTER TABLE lguname_etracs.rptsetting ADD COLUMN allowchangedepreciationwithbalance INT NULL;

UPDATE lguname_etracs.rptsetting SET allowchangedepreciationwithbalance = 0;

CREATE TABLE lguname_etracs.remittance_subcollector (
	objid VARCHAR(50) NOT NULL,
	schemaname VARCHAR(50) NOT NULL,
	schemaversion VARCHAR(5) NOT NULL,
	docstate VARCHAR(20) NOT NULL,
	txnno VARCHAR(20) NOT NULL,
	txndate DATE NOT NULL,
	collectorname VARCHAR(50) NOT NULL,
	amount DECIMAL(10, 2) NULL,
	collectorid VARCHAR(50) NOT NULL,
	collectortitle VARCHAR(50) NULL,
	totalcash DECIMAL(10, 2) NULL,
	totalotherpayment DECIMAL(10, 2) NULL,
	remittanceid VARCHAR(50) NULL,
	remittanceno VARCHAR(15) NULL,
	remittancedate DATE NULL,
	remittanceofficerid VARCHAR(50) NULL,
	remittanceofficername VARCHAR(50) NULL,
	remittanceofficertitle VARCHAR(50) NULL,
	info TEXT NULL,
	PRIMARY KEY  (objid)
);

ALTER TABLE lguname_etracs.receiptlist ADD COLUMN sc_remittanceid VARCHAR(50) NULL;




/* ============================================================
**  DENORMALIZE REMITTANCE SUPPORT 
============================================================ */

ALTER TABLE lguname_etracs.remittancelist ADD COLUMN dtposted DATE NULL;

UPDATE lguname_etracs.remittancelist SET dtposted = txndate;

ALTER TABLE lguname_etracs.remittancelist CHANGE COLUMN dtposted dtposted DATE NOT NULL;

ALTER TABLE lguname_etracs.remittancelist ADD COLUMN denominations VARCHAR(600) NULL;

ALTER TABLE lguname_etracs.remittancelist DROP FOREIGN KEY FK_remittancelist_remittance;

ALTER TABLE lguname_etracs.receiptlist DROP FOREIGN KEY FK_receiptlist_remittance;

ALTER TABLE lguname_etracs.remittedform DROP FOREIGN KEY FK_remittedform_remittance;


RENAME TABLE lguname_etracs.remittance TO lguname_etracs.xremittance; 

RENAME TABLE lguname_etracs.remittancelist TO lguname_etracs.remittance; 


ALTER TABLE lguname_etracs.receiptlist
	ADD CONSTRAINT FK_receiptlist_remittance FOREIGN KEY (remittanceid) REFERENCES lguname_etracs.remittance(objid);

ALTER TABLE lguname_etracs.remittedform
	ADD CONSTRAINT FK_remittedform_remittance FOREIGN KEY (remittanceid) REFERENCES lguname_etracs.remittance(objid);




/* =================================================================== 
** Normalize Liquidation  
=================================================================== */
ALTER TABLE lguname_etracs.liquidationlist ADD COLUMN dtposted DATE;

UPDATE lguname_etracs.liquidationlist SET dtposted = txndate;

ALTER TABLE lguname_etracs.liquidationlist CHANGE COLUMN dtposted dtposted DATE NOT NULL ;


ALTER TABLE lguname_etracs.liquidationlist ADD COLUMN denominations VARCHAR(600);

UPDATE lguname_etracs.liquidationlist SET denominations = '[]' ;


ALTER TABLE lguname_etracs.liquidationlist DROP FOREIGN KEY FK_liquidationlist_deposit;

ALTER TABLE lguname_etracs.liquidationlist DROP FOREIGN KEY  FK_liquidationlist_liquidation;

ALTER TABLE lguname_etracs.liquidationlist DROP FOREIGN KEY  FK_liquidationlist_personnel;

ALTER TABLE lguname_etracs.liquidationlist DROP FOREIGN KEY  FK_liquidationlist_personnel_depositedbyid;


RENAME TABLE lguname_etracs.liquidation TO lguname_etracs.xliquidation;

RENAME TABLE lguname_etracs.liquidationlist TO lguname_etracs.liquidation ;



ALTER TABLE lguname_etracs.liquidation
	ADD CONSTRAINT FK_liquidation_deposit FOREIGN KEY(depositid) REFERENCES lguname_etracs.deposit(objid);

ALTER TABLE lguname_etracs.liquidation
	ADD CONSTRAINT FK_liquidation_personnel FOREIGN KEY(liquidatingofficerid) REFERENCES lguname_etracs.personnel(objid);

ALTER TABLE lguname_etracs.liquidation 
	ADD CONSTRAINT FK_liquidation_personnel_depositedbyid FOREIGN KEY(depositedbyid) REFERENCES lguname_etracs.personnel(objid);
	
ALTER TABLE lguname_etracs.remittance DROP FOREIGN KEY FK_remittancelist_liquidation;

ALTER TABLE lguname_etracs.remittance DROP FOREIGN KEY  FK_remittancelist_personnel;

ALTER TABLE lguname_etracs.remittance DROP FOREIGN KEY  FK_remittancelist_personnel_lqid;



ALTER TABLE lguname_etracs.remittance 
	ADD CONSTRAINT FK_remittance_liquidation FOREIGN KEY(liquidationid) 
	REFERENCES lguname_etracs.liquidation( objid );

ALTER TABLE lguname_etracs.remittance 
	ADD CONSTRAINT FK_remittance_personnel FOREIGN KEY(collectorid) 
	REFERENCES lguname_etracs.personnel( objid );

ALTER TABLE lguname_etracs.remittance 
	ADD CONSTRAINT FK_remittance_personnel_lqid FOREIGN KEY(liquidatingofficerid) 
	REFERENCES lguname_etracs.personnel( objid );




INSERT INTO lguname_system.sys_module(NAME, title, permissions)
VALUES('rpt2-reports', 'RPT Reports', '[[action:"rptreport.pdaprpta100", title:"Generate PDAP-RPTA 100 Report",]]');

ALTER TABLE lguname_etracs.rptpaymentmanual ADD COLUMN basicadv DECIMAL(16,2);
ALTER TABLE lguname_etracs.rptpaymentmanual ADD COLUMN basicadvdisc DECIMAL(16,2);
ALTER TABLE lguname_etracs.rptpaymentmanual ADD COLUMN sefadv DECIMAL(16,2);
ALTER TABLE lguname_etracs.rptpaymentmanual ADD COLUMN sefadvdisc DECIMAL(16,2);


UPDATE lguname_etracs.rptpaymentmanual SET 
	basicadv = 0.0, basicadvdisc = 0.0, 
	sefadv = 0.0, sefadvdisc = 0.0;
	
	
	
CREATE TABLE lguname_system.`sys_role` (
  `name` VARCHAR(50) NOT NULL,
  `domain` VARCHAR(50) NOT NULL,
  PRIMARY KEY  (`name`,`domain`)
) ENGINE=INNODB DEFAULT CHARSET=latin1;


CREATE TABLE lguname_system.`sys_role_permission` (
  `sysrole` VARCHAR(50) NOT NULL,
  `domain` VARCHAR(50) NOT NULL,
  `action` VARCHAR(50) NOT NULL,
  `title` VARCHAR(50) DEFAULT NULL,
  `module` VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY  (`sysrole`,`domain`,`action`, module),
  CONSTRAINT `FK_sys_role_permission` FOREIGN KEY (`sysrole`, `domain`) REFERENCES `sys_role` (`name`, `domain`)
) ENGINE=INNODB DEFAULT CHARSET=latin1;



ALTER TABLE lguname_etracs.orgtype ADD COLUMN system INT NOT NULL;

UPDATE lguname_etracs.orgtype SET system = 0;

UPDATE lguname_etracs.orgtype SET system = 1 WHERE NAME='BARANGAY';
	
	
-- ----	
USE lguname_etracs;

CREATE TABLE lguname_etracs.`jobposition_role` (
  `jobpositionid` VARCHAR(50) NOT NULL,
  `role` VARCHAR(50) NOT NULL,
  `domain` VARCHAR(50) NOT NULL,
  `sysrole` VARCHAR(50) NOT NULL,
  `disallowed` TEXT,
  PRIMARY KEY  (`jobpositionid`,`role`,`domain`)
) ENGINE=INNODB DEFAULT CHARSET=latin1;


CREATE UNIQUE INDEX `unique_jobposition_sysrole` ON lguname_etracs.`jobposition_role`(`jobpositionid`,`sysrole`, `domain`);

ALTER TABLE lguname_etracs.jobposition_role
  ADD CONSTRAINT FK_jobposition_role_jobposition FOREIGN KEY (jobpositionid) 
  REFERENCES jobposition(objid);
  
ALTER TABLE lguname_etracs.jobposition_role  
  ADD CONSTRAINT FK_jobposition_role_role FOREIGN KEY(role, domain) 
  REFERENCES role(role, domain);


ALTER TABLE lguname_etracs.personnel ADD COLUMN `txncode` VARCHAR(50) NULL AFTER `spouseinfo`;

UPDATE lguname_etracs.personnel p, lguname_etracs.personnel_txncode pc SET
p.txncode = pc.txncode 
WHERE pc.personnelid = p.objid;

RENAME TABLE lguname_etracs.personnel_txncode TO xpersonnel_txncode;


ALTER TABLE lguname_etracs.jobposition DROP FOREIGN KEY  `FK_jobposition_role`;


ALTER TABLE lguname_etracs.`jobposition` DROP COLUMN `roleclass`, DROP COLUMN `role`, DROP COLUMN `excluded`;


ALTER TABLE lguname_etracs.`role` 
	DROP COLUMN `included`,
	ADD COLUMN `domain` VARCHAR(50) NULL AFTER `role`, 
	ADD COLUMN `excluded` TEXT NULL AFTER `sysrole`,
	CHANGE `name` `role` VARCHAR(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT '' NOT NULL, 
	CHANGE `description` `description` VARCHAR(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL , 
	CHANGE `roleclass` `sysrole` VARCHAR(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT '' NOT NULL, 
	CHANGE `system` `system` INT(6) DEFAULT '0' NULL ;


ALTER TABLE lguname_etracs.`role` 
	CHANGE `domain` `domain` VARCHAR(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL, 
	CHANGE `sysrole` `sysrole` VARCHAR(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT '' NOT NULL, DROP PRIMARY KEY,  
	ADD PRIMARY KEY(`role`, `domain`);


ALTER TABLE lguname_etracs.`role` DROP KEY `FK_role`;

ALTER TABLE lguname_etracs.`role` ADD INDEX `role_sysrole` (`sysrole`);


DELETE FROM lguname_etracs.jobposition_role;
DELETE FROM lguname_etracs.role;
DELETE FROM lguname_system.sys_role;


INSERT  INTO lguname_system.sys_role(NAME,domain) VALUES ('AFO','TREASURY');
INSERT  INTO lguname_system.sys_role(NAME,domain) VALUES ('APPRAISER','RPT');
INSERT  INTO lguname_system.sys_role(NAME,domain) VALUES ('APPROVER','RPT');
INSERT  INTO lguname_system.sys_role(NAME,domain) VALUES ('ASSESSOR_REPORTS','RPT');
INSERT  INTO lguname_system.sys_role(NAME,domain) VALUES ('BP_REPORTS','BP');
INSERT  INTO lguname_system.sys_role(NAME,domain) VALUES ('CASHIER','TREASURY');
INSERT  INTO lguname_system.sys_role(NAME,domain) VALUES ('CERTIFICATION_ISSUANCE','RPT');
INSERT  INTO lguname_system.sys_role(NAME,domain) VALUES ('CITY_ASSESSOR','RPT');
INSERT  INTO lguname_system.sys_role(NAME,domain) VALUES ('COLLECTOR','BP');
INSERT  INTO lguname_system.sys_role(NAME,domain) VALUES ('COLLECTOR','TREASURY');
INSERT  INTO lguname_system.sys_role(NAME,domain) VALUES ('ENTITY_ENCODER','ENTITY');
INSERT  INTO lguname_system.sys_role(NAME,domain) VALUES ('LANDTAX','RPT');
INSERT  INTO lguname_system.sys_role(NAME,domain) VALUES ('LICENSING','BP');
INSERT  INTO lguname_system.sys_role(NAME,domain) VALUES ('LIQUIDATING_OFFICER','TREASURY');
INSERT  INTO lguname_system.sys_role(NAME,domain) VALUES ('MASTER_ENCODER','BP');
INSERT  INTO lguname_system.sys_role(NAME,domain) VALUES ('MASTER_ENCODER','RPT');
INSERT  INTO lguname_system.sys_role(NAME,domain) VALUES ('MASTER_ENCODER','TREASURY');
INSERT  INTO lguname_system.sys_role(NAME,domain) VALUES ('MUNICIPAL_ASSESSOR','RPT');
INSERT  INTO lguname_system.sys_role(NAME,domain) VALUES ('PROVINCIAL_ASSESSOR','RPT');
INSERT  INTO lguname_system.sys_role(NAME,domain) VALUES ('RELEASING','BP');
INSERT  INTO lguname_system.sys_role(NAME,domain) VALUES ('RULE_AUTHOR','BP');
INSERT  INTO lguname_system.sys_role(NAME,domain) VALUES ('RULE_AUTHOR','CTC');
INSERT  INTO lguname_system.sys_role(NAME,domain) VALUES ('RULE_AUTHOR','RPT');
INSERT  INTO lguname_system.sys_role(NAME,domain) VALUES ('RULE_MANAGEMENT','RULEMGMT');
INSERT  INTO lguname_system.sys_role(NAME,domain) VALUES ('SHARED','BP');
INSERT  INTO lguname_system.sys_role(NAME,domain) VALUES ('SHARED','RPT');
INSERT  INTO lguname_system.sys_role(NAME,domain) VALUES ('SUBCOLLECTOR','TREASURY');
INSERT  INTO lguname_system.sys_role(NAME,domain) VALUES ('TREASURY_ADMIN','TREASURY');
INSERT  INTO lguname_system.sys_role(NAME,domain) VALUES ('TREASURY_REPORTS','TREASURY');


INSERT  INTO lguname_etracs.role(role,domain,description,sysrole,excluded,system) VALUES ('AFO','TREASURY',NULL,'AFO',NULL,1);
INSERT  INTO lguname_etracs.role(role,domain,description,sysrole,excluded,system) VALUES ('APPRAISER','RPT',NULL,'APPRAISER',NULL,1);
INSERT  INTO lguname_etracs.role(role,domain,description,sysrole,excluded,system) VALUES ('APPROVER','RPT',NULL,'APPROVER',NULL,1);
INSERT  INTO lguname_etracs.role(role,domain,description,sysrole,excluded,system) VALUES ('ASSESSOR_REPORTS','RPT',NULL,'ASSESSOR_REPORTS',NULL,1);
INSERT  INTO lguname_etracs.role(role,domain,description,sysrole,excluded,system) VALUES ('BP_REPORTS','BP',NULL,'BP_REPORTS',NULL,1);
INSERT  INTO lguname_etracs.role(role,domain,description,sysrole,excluded,system) VALUES ('CASHIER','TREASURY',NULL,'CASHIER',NULL,1);
INSERT  INTO lguname_etracs.role(role,domain,description,sysrole,excluded,system) VALUES ('CERTIFICATION_ISSUANCE','RPT',NULL,'CERTIFICATION_ISSUANCE',NULL,1);
INSERT  INTO lguname_etracs.role(role,domain,description,sysrole,excluded,system) VALUES ('CITY_ASSESSOR','RPT',NULL,'CITY_ASSESSOR',NULL,1);
INSERT  INTO lguname_etracs.role(role,domain,description,sysrole,excluded,system) VALUES ('COLLECTOR','BP',NULL,'COLLECTOR',NULL,1);
INSERT  INTO lguname_etracs.role(role,domain,description,sysrole,excluded,system) VALUES ('COLLECTOR','TREASURY',NULL,'COLLECTOR',NULL,1);
INSERT  INTO lguname_etracs.role(role,domain,description,sysrole,excluded,system) VALUES ('ENTITY_ENCODER','ENTITY',NULL,'ENTITY_ENCODER',NULL,1);
INSERT  INTO lguname_etracs.role(role,domain,description,sysrole,excluded,system) VALUES ('LANDTAX','RPT',NULL,'LANDTAX',NULL,1);
INSERT  INTO lguname_etracs.role(role,domain,description,sysrole,excluded,system) VALUES ('LICENSING','BP',NULL,'LICENSING',NULL,1);
INSERT  INTO lguname_etracs.role(role,domain,description,sysrole,excluded,system) VALUES ('LIQUIDATING_OFFICER','TREASURY',NULL,'LIQUIDATING_OFFICER',NULL,1);
INSERT  INTO lguname_etracs.role(role,domain,description,sysrole,excluded,system) VALUES ('MASTER_ENCODER','BP',NULL,'MASTER_ENCODER',NULL,1);
INSERT  INTO lguname_etracs.role(role,domain,description,sysrole,excluded,system) VALUES ('MASTER_ENCODER','RPT',NULL,'MASTER_ENCODER',NULL,1);
INSERT  INTO lguname_etracs.role(role,domain,description,sysrole,excluded,system) VALUES ('MASTER_ENCODER','TREASURY',NULL,'MASTER_ENCODER',NULL,1);
INSERT  INTO lguname_etracs.role(role,domain,description,sysrole,excluded,system) VALUES ('MUNICIPAL_ASSESSOR','RPT',NULL,'MUNICIPAL_ASSESSOR',NULL,1);
INSERT  INTO lguname_etracs.role(role,domain,description,sysrole,excluded,system) VALUES ('PROVINCIAL_ASSESSOR','RPT',NULL,'PROVINCIAL_ASSESSOR',NULL,1);
INSERT  INTO lguname_etracs.role(role,domain,description,sysrole,excluded,system) VALUES ('RELEASING','BP',NULL,'RELEASING',NULL,1);
INSERT  INTO lguname_etracs.role(role,domain,description,sysrole,excluded,system) VALUES ('RULE_AUTHOR','BP',NULL,'RULE_AUTHOR',NULL,1);
INSERT  INTO lguname_etracs.role(role,domain,description,sysrole,excluded,system) VALUES ('RULE_AUTHOR','CTC',NULL,'RULE_AUTHOR',NULL,1);
INSERT  INTO lguname_etracs.role(role,domain,description,sysrole,excluded,system) VALUES ('RULE_AUTHOR','RPT',NULL,'RULE_AUTHOR',NULL,1);
INSERT  INTO lguname_etracs.role(role,domain,description,sysrole,excluded,system) VALUES ('RULE_MANAGEMENT','RULEMGMT',NULL,'RULE_MANAGEMENT',NULL,1);
INSERT  INTO lguname_etracs.role(role,domain,description,sysrole,excluded,system) VALUES ('SHARED','BP',NULL,'SHARED',NULL,1);
INSERT  INTO lguname_etracs.role(role,domain,description,sysrole,excluded,system) VALUES ('SHARED','RPT',NULL,'SHARED',NULL,1);
INSERT  INTO lguname_etracs.role(role,domain,description,sysrole,excluded,system) VALUES ('SUBCOLLECTOR','TREASURY',NULL,'SUBCOLLECTOR',NULL,1);
INSERT  INTO lguname_etracs.role(role,domain,description,sysrole,excluded,system) VALUES ('TREASURY_ADMIN','TREASURY',NULL,'TREASURY_ADMIN',NULL,1);
INSERT  INTO lguname_etracs.role(role,domain,description,sysrole,excluded,system) VALUES ('TREASURY_REPORTS','TREASURY',NULL,'TREASURY_REPORTS',NULL,1);

INSERT INTO lguname_etracs.`jobposition_role`(jobpositionid, role, domain, sysrole) 
SELECT t.jobid, t.tagid, s.domain, t.tagid FROM lguname_etracs.`jobposition_tag` t, lguname_system.`sys_role` s
WHERE t.tagid = s.name AND EXISTS(SELECT * FROM lguname_etracs.`jobposition` WHERE objid = t.jobid);


INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('RULE_AUTHOR', 'BP', 'bpassessmentrule.view', 'Author Business Assessment Rules', 'bp-rule-mgmt');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('RULE_AUTHOR', 'BP', 'bpbillingrule.view', 'Author BP Billing Rules', 'bp-rule-mgmt');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LICENSING', 'BP', 'bplicensing.submitforreview', 'Submit Business Application For Review', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LICENSING', 'BP', 'bplicensing.disapprove', 'Disapprove Business Application', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LICENSING', 'BP', 'bplicensing.approve', 'Approve Business Application', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LICENSING', 'BP', 'bplicensing.newtransaction', 'Create New Application Transaction', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LICENSING', 'BP', 'bplicensing.save', 'Save Application Transaction', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LICENSING', 'BP', 'bplicensing.edit', 'Edit Application Transaction', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LICENSING', 'BP', 'bplicensing.delete', 'Delete Application Transaction', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LICENSING', 'BP', 'bplicensing.submit', 'Submit Application Transaction', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LICENSING', 'BP', 'bplicensing.renewtransaction', 'Create Renew Application Transaction', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LICENSING', 'BP', 'bplicensing.addlobtransaction', 'Create Add Line of Business Application Transaction', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LICENSING', 'BP', 'bplicensing.retiretransaction', 'Create Retire Application Transaction', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LICENSING', 'BP', 'bplicensing.retiretransaction', 'Create Retire Application Transaction', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LICENSING', 'BP', 'bplicensing.capturenewtransaction', 'Create Capture New Application Transaction', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LICENSING', 'BP', 'bplicensing.capturerenewtransaction', 'Create Capture Renew Application Transaction', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LICENSING', 'BP', 'bplicensing.newtransaction', 'Create New Application Transaction', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LICENSING', 'BP', 'bplicensing.renewtransaction', 'Create Renew Application Transaction', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LICENSING', 'BP', 'bplicensing.applicationlist', 'View Application Listing', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('SHARED', 'BP', 'bppermit.approvedapplications', 'View Approved Business Applications', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('RELEASING', 'BP', 'bppermit.forreleasepermits', 'View For Relased Permits', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LICENSING', 'BP', 'bppermit.forrenewapplications', 'View Retired Applications', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('SHARED', 'BP', 'bppermit.activepermits', 'View Active Permits', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('SHARED', 'BP', 'bppermit.retire', 'View Retired Applications', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('SHARED', 'BP', 'bppermit.approvedapplications', 'View Approved Business Applications', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('RELEASING', 'BP', 'bppermit.forreleasepermits', 'View For Relased Permits', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LICENSING', 'BP', 'bppermit.forrenewapplications', 'View Retired Applications', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('SHARED', 'BP', 'bppermit.activepermits', 'View Active Permits', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('SHARED', 'BP', 'bppermit.retire', 'View Retired Applications', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LICENSING', 'BP', 'bplicensing.renewtransaction', 'Create Renew Application Transaction', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'BP', 'bpadmin.setting', 'Manage Business Settings', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'BP', 'bpbilling.generate', 'Generate BP Billing', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'BP', 'bpbilling.generate', 'Generate BP Billing', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LICENSING', 'BP', 'bpadmin.ledger', 'Manage Business Ledger', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LICENSING', 'BP', 'bpadmin.ledger', 'Manage Business Ledger', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LICENSING', 'BP', 'bpadmin.changebusinessaddress', 'Allow Change Business Address Transaction', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LICENSING', 'BP', 'bpadmin.changebusinessaddress', 'Allow Change Business Address Transaction', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LICENSING', 'BP', 'bpadmin.changebusinessaddress', 'Allow Change Business Address Transaction', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LICENSING', 'BP', 'bpadmin.changeadministrator', 'Change Business Administrator', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LICENSING', 'BP', 'bpadmin.changeadministrator', 'Change Business Administrator', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LICENSING', 'BP', 'changeadministratorlist', 'changeadministratorlist', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LICENSING', 'BP', 'bpadmin.changepermittee', 'Allow Change Permittee Transaction', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LICENSING', 'BP', 'bpadmin.changepermittee', 'Allow Change Permittee Transaction', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LICENSING', 'BP', 'bpadmin.changepermittee', 'Allow Change Permittee Transaction', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LICENSING', 'BP', 'bpadmin.changetradename', 'Allow Change Trade Name', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LICENSING', 'BP', 'bpadmin.changetradename', 'Allow Change Trade Name', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'BP', 'bpadmin.lob', 'Create View and Update Line Of Business Transaction', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'BP', 'bpadmin.lobattributes', 'Manage LOB Attributes', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'BP', 'bpadmin.lobclassification', 'Create View and Update Line Of Business Classification Transaction', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('BP_REPORTS', 'BP', 'bpreport.apploblisting', 'Generate Application With LOB Listing', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('BP_REPORTS', 'BP', 'bpreport.apploblisting', 'Generate Application With LOB Listing', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('BP_REPORTS', 'BP', 'bpreport.bpcollectionreport', 'Generate Business Collection Report Listing', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('BP_REPORTS', 'BP', 'bpreport.delinquency', 'Generate Delinquency Listing', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('BP_REPORTS', 'BP', 'bpreport.delinquency', 'Generate Delinquency Listing', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('BP_REPORTS', 'BP', 'bpreport.masterlist', 'Generate Taxpayer Masterlist', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('BP_REPORTS', 'BP', 'bpreport.masterlist', 'Generate Taxpayer Masterlist', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('BP_REPORTS', 'BP', 'bpreport.bppermitlisting', 'bpreport.bppermitlisting', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('BP_REPORTS', 'BP', 'bpreport.bppermitlisting', 'bpreport.bppermitlisting', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('BP_REPORTS', 'BP', 'bpreport.comparativeassessmentlisting', 'bpreport.comparativeassessmentlisting', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('BP_REPORTS', 'BP', 'bpreport.comparativeassessmentlisting', 'bpreport.comparativeassessmentlisting', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('BP_REPORTS', 'BP', 'bpreport.comparativelisting', 'bpreport.comparativelisting', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('BP_REPORTS', 'BP', 'bpreport.comparativelisting', 'bpreport.comparativelisting', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('BP_REPORTS', 'BP', 'bpreport.lobcountlisting', 'Generate LOB Count Listing', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('BP_REPORTS', 'BP', 'bpreport.lobcountlisting', 'Generate LOB Count Listing', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('BP_REPORTS', 'BP', 'bpreport.loblisting', 'Generate Line of Business Listing', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('BP_REPORTS', 'BP', 'bpreport.lobtoplisting', 'Generate Top N Businesses', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('BP_REPORTS', 'BP', 'bpreport.lobtoplisting', 'Generate Top N Businesses', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'BP', 'bpadmin.bprulevariable', 'Manage Business Variable', 'bp2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('RULE_AUTHOR', 'CTC', 'ctcassessmentrule.view', 'Manage CTC Rules', 'ctc-rule-mgmt');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('RULE_AUTHOR', 'CTC', 'ctcassessmentrule.view', 'Manage CTC Rules', 'ctc-rule-mgmt');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ENTITY_ENCODER', 'ENTITY', 'entity.mapping', 'Map Entity Data', 'etracs2-entity');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ENTITY_ENCODER', 'ENTITY', 'individual.create', 'Create Individual Entity', 'etracs2-entity');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ENTITY_ENCODER', 'ENTITY', 'individual.create', 'Create Individual Entity', 'etracs2-entity');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ENTITY_ENCODER', 'ENTITY', 'individual.create', 'Create Individual Entity', 'etracs2-entity');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ENTITY_ENCODER', 'ENTITY', 'individual.create', 'Create Individual Entity', 'etracs2-entity');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ENTITY_ENCODER', 'ENTITY', 'individual.edit', 'Edit Individual Entity', 'etracs2-entity');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ENTITY_ENCODER', 'ENTITY', 'individual.delete', 'Delete Individual Entity', 'etracs2-entity');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ENTITY_ENCODER', 'ENTITY', 'entity.mapping', 'Map Entity Data', 'etracs2-entity');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ENTITY_ENCODER', 'ENTITY', 'individual.enrollonline', 'individual.enrollonline', 'etracs2-entity');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ENTITY_ENCODER', 'ENTITY', 'individual.enrollonline', 'individual.enrollonline', 'etracs2-entity');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ENTITY_ENCODER', 'ENTITY', 'juridical.create', 'Create Juridical Entity', 'etracs2-entity');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ENTITY_ENCODER', 'ENTITY', 'juridical.create', 'Create Juridical Entity', 'etracs2-entity');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ENTITY_ENCODER', 'ENTITY', 'juridical.create', 'Create Juridical Entity', 'etracs2-entity');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ENTITY_ENCODER', 'ENTITY', 'juridical.create', 'Create Juridical Entity', 'etracs2-entity');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ENTITY_ENCODER', 'ENTITY', 'juridical.edit', 'Edit Juridical Entity', 'etracs2-entity');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ENTITY_ENCODER', 'ENTITY', 'juridical.delete', 'Delete Juridical Entity', 'etracs2-entity');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ENTITY_ENCODER', 'ENTITY', 'entity.mapping', 'Map Entity Data', 'etracs2-entity');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ENTITY_ENCODER', 'ENTITY', 'entity.manage', 'Manage Entity', 'etracs2-entity');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ENTITY_ENCODER', 'ENTITY', 'multiple.create', 'Create Multiple Entity', 'etracs2-entity');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ENTITY_ENCODER', 'ENTITY', 'multiple.create', 'Create Multiple Entity', 'etracs2-entity');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ENTITY_ENCODER', 'ENTITY', 'multiple.create', 'Create Multiple Entity', 'etracs2-entity');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ENTITY_ENCODER', 'ENTITY', 'multiple.create', 'Create Multiple Entity', 'etracs2-entity');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ENTITY_ENCODER', 'ENTITY', 'multiple.edit', 'Edit Multiple Entity', 'etracs2-entity');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ENTITY_ENCODER', 'ENTITY', 'multiple.delete', 'Delete Multiple Entity', 'etracs2-entity');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ENTITY_ENCODER', 'ENTITY', 'entity.mapping', 'Map Entity Data', 'etracs2-entity');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('RULE_AUTHOR', 'RPT', 'rptbillingrule.view', 'View RPT Billing Rules', 'rpt-rule-mgmt');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'annotation.create', 'annotation.create', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'annotation.create', 'annotation.create', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'annotation.create', 'annotation.create', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPROVER', 'RPT', 'annotation.approve', 'Approve Annotation', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'cancelannotation.create', 'Create Cancel Annotation', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'cancelannotation.view', 'View Cancel Annotation', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPROVER', 'RPT', 'cancelannotation.approve', 'Approve Cancel Annotation', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('SHARED', 'RPT', 'cancelannotationmgmt.view', 'Manage Cancelled Annotations', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('SHARED', 'RPT', 'cancelannotationmgmt.view', 'Manage Cancelled Annotations', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'cancelannotation.open', 'Open Cancel Annotation', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('SHARED', 'RPT', 'annotationmgmt.view', 'Manage Annotations', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('SHARED', 'RPT', 'annotationmgmt.view', 'Manage Annotations', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('SHARED', 'RPT', 'annotationmgmt.view', 'Manage Annotations', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'annotation.create', 'annotation.create', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'annotation.view', 'View Annotation', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'cancelannotation.create', 'Create Cancel Annotation', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'batchgr.create', 'batchgr.create', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'batchgr.create', 'batchgr.create', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'rysetting.view', 'View General Revision Year Setting', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'cancelfaas.create', 'Create Cancel FAAS', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'cancelfaas.create', 'Create Cancel FAAS', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPROVER', 'RPT', 'cancelfaas.approve', 'Approve Cancel FAAS', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('SHARED', 'RPT', 'cancelfaasmgt.view', 'View Cancel FAAS Management', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('SHARED', 'RPT', 'cancelfaasmgt.view', 'View Cancel FAAS Management', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'cancelfaasmgt.create', 'Create Cancel FAAS Management', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'cancelfaasmgt.open', 'Open Cancel FAAS Management', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'canceltdreasons.view', 'View Cancel TD Reasons', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'canceltdreasons.view', 'View Cancel TD Reasons', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'canceltdreasons.create', 'Create Cancel TD Reasons', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'canceltdreasons.edit', 'Edit Cancel TD Reasons', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'canceltdreasons.delete', 'Delete Cancel TD Reasons', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'consolidation.view', 'View Consolidation', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'consolidation.view', 'View Consolidation', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'consolidation.view', 'View Consolidation', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'consolidation.view', 'View Consolidation', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'consolidation.view', 'View Consolidation', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'consolidation.submit', 'Submit Consolidation', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CITY_ASSESSOR', 'RPT', 'consolidation.disapprove', 'Disapprove Consolidation', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CITY_ASSESSOR', 'RPT', 'consolidation.approve', 'Approve Consolidation', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MUNICIPAL_ASSESSOR', 'RPT', 'consolidation.submitToProvince', 'Disapprove by Province Consolidation', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('PROVINCIAL_ASSESSOR', 'RPT', 'consolidation.disapproveByProvince', 'Disapprove by Province Consolidation', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('PROVINCIAL_ASSESSOR', 'RPT', 'consolidation.approveByProvince', 'Approve By Province Consolidation', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'consolidationmgt.view', 'View Consolidation Management', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'consolidationmgt.view', 'View Consolidation Management', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'consolidationmgt.view', 'View Consolidation Management', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'consolidationmgt.create', 'Create Consolidation Management', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'consolidationmgt.view', 'View Consolidation Management', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'exemptiontypes.view', 'View Exemption Types', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'exemptiontypes.view', 'View Exemption Types', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'exemptiontypes.create', 'Create Exemption Types', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'exemptiontypes.edit', 'Edit Exemption Types', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'exemptiontypes.delete', 'Delete Exemption Types', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'faas.create', 'Create FAAS', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'faas.open', 'Open FAAS', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'datacapture.create', 'Create FAAS Data Capture', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'transfer.create', 'Create Transfer of Ownership', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'transfer.create', 'Create Transfer of Ownership', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'transfer.create', 'Create Transfer of Ownership', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'changeclassification.create', 'changeclassification.create', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'changetaxability.create', 'changetaxability.create', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'correction.create', 'Create Correction of Entry', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'newdiscovery.create', 'Create New Discovery', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'multipleclaim.create', 'Create Multiple Claim', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'reassessment.create', 'Create Reassessment', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'generalrevision.create', 'generalrevision.create', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'faas.submit', 'Submit FAAS for approval', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'faas.submit', 'Submit FAAS for approval', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'faas.delete', 'Delete FAAS', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'faas.disapprove', 'Dispprove FAAS', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CITY_ASSESSOR', 'RPT', 'faas.approve', 'Approve FAAS', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('PROVINCIAL_ASSESSOR', 'RPT', 'faas.approve', 'Approve FAAS', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MUNICIPAL_ASSESSOR', 'RPT', 'faas.submittoprovince', 'Submit to Province FAAS', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('PROVINCIAL_ASSESSOR', 'RPT', 'faas.disapprove', 'Dispprove FAAS', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('PROVINCIAL_ASSESSOR', 'RPT', 'faas.disapprove', 'Dispprove FAAS', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('PROVINCIAL_ASSESSOR', 'RPT', 'faas.approvebyprovince', 'Approve By Province FAAS', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'realpropertyupdate.create', 'Create Real Property Update Information', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'realpropertyupdate.create', 'Create Real Property Update Information', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'realpropertyupdate.open', 'Open Real Property Update Information', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'realpropertyupdate.edit', 'Edit Real Property Update Information', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPROVER', 'RPT', 'realpropertyupdate.approve', 'Approve Real Property Update Information', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'realpropertyupdate.view', 'View Real Property Update Listing', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'titleupdate.create', 'Update Title Information', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'titleupdate.create', 'Update Title Information', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'titleupdate.open', 'Open Title Information', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'titleupdate.edit', 'Edit Title Information', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPROVER', 'RPT', 'titleupdate.approve', 'Approve Title Information', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'titleupdate.view', 'View Title Update Listing', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'faasmgt.view', 'View FAAS Management', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'faasmgt.view', 'View FAAS Management', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'faasmgt.view', 'View FAAS Management', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'faasmgt.create', 'Create FAAS Management', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'faasmgt.view', 'View FAAS Management', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'fortransmittalmgmt.view', 'For Transmittal Management', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'fortransmittalmgmt.view', 'For Transmittal Management', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'kindofbldg.view', 'View Kind of Building', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'kindofbldg.view', 'View Kind of Building', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'kindofbldg.create', 'Create Kind of Building', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'kindofbldg.edit', 'Edit Kind of Building', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'kindofbldg.delete', 'Delete Kind of Building', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'rysetting.view', 'View General Revision Year Setting', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'machines.view', 'View Machines', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'machines.view', 'View Machines', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'machines.create', 'Create Machines', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'machines.edit', 'Edit Machines', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'machines.delete', 'Delete Machines', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'rysetting.view', 'View General Revision Year Setting', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'materials.view', 'View Materials', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'materials.view', 'View Materials', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'materials.create', 'Create Materials', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'materials.edit', 'Edit Materials', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'materials.delete', 'Delete Materials', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'miscitems.view', 'View Miscellaneous Items', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'miscitems.view', 'View Miscellaneous Items', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'miscitems.create', 'Create Miscellaneous Items', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'miscitems.edit', 'Edit Miscellaneous Items', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'miscitems.delete', 'Delete Miscellaneous Items', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'rysetting.view', 'View General Revision Year Setting', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'plantstrees.view', 'View Plants and Trees', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'plantstrees.view', 'View Plants and Trees', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'plantstrees.create', 'Create Plants and Trees', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'plantstrees.edit', 'Edit Plants and Trees', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'plantstrees.delete', 'Delete Plants and Trees', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'rysetting.view', 'View General Revision Year Setting', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'propertyclassification.view', 'View Property Classifications', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'propertyclassification.view', 'View Property Classifications', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'propertyclassification.create', 'Create Property Classification', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'propertyclassification.edit', 'Edit Property Classification', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'propertyclassification.delete', 'Delete Property Classification', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'propertypayer.view', 'View Property Payers', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'propertypayer.view', 'View Property Payers', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'landtax.abstractrptcollection', 'Generate Abstract of Realty Tax Collection', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ASSESSOR_REPORTS', 'RPT', 'rptreport.accomplishmentrpa', 'Generate Accomplishment Report on Real Property Assessment', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ASSESSOR_REPORTS', 'RPT', 'rptreport.accomplishmentrpa', 'Generate Accomplishment Report on Real Property Assessment', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ASSESSOR_REPORTS', 'RPT', 'rptreport.annotationlisting', 'Generate Annotation Listing', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ASSESSOR_REPORTS', 'RPT', 'rptreport.jat', 'Generate Journal of Assessment Transaction', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ASSESSOR_REPORTS', 'RPT', 'rptreport.jat', 'Generate Journal of Assessment Transaction', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ASSESSOR_REPORTS', 'RPT', 'rptreport.assessmentroll', 'Generate Assessment Roll', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ASSESSOR_REPORTS', 'RPT', 'rptreport.assessmentroll', 'Generate Assessment Roll', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ASSESSOR_REPORTS', 'RPT', 'rptreport.assessmentroll', 'Generate Assessment Roll', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'landtax.brgyshare', 'Generate Barangay Share', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ASSESSOR_REPORTS', 'RPT', 'rptreport.comparativeav', 'Generate Comparative Data On Assessed Value', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ASSESSOR_REPORTS', 'RPT', 'rptreport.comparativeav', 'Generate Comparative Data On Assessed Value', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ASSESSOR_REPORTS', 'RPT', 'rptreport.comparativemv', 'Generate Comparative Data on Market Value', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ASSESSOR_REPORTS', 'RPT', 'rptreport.comparativemv', 'Generate Comparative Data on Market Value', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ASSESSOR_REPORTS', 'RPT', 'rptreport.comparativerpucount', 'Generate Comparative Data on RPU Count', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ASSESSOR_REPORTS', 'RPT', 'rptreport.comparativerpucount', 'Generate Comparative Data on RPU Count', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'landtax.rptcompromisepayment', 'landtax.rptcompromisepayment', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ASSESSOR_REPORTS', 'RPT', 'rptreport.jat', 'Generate Journal of Assessment Transaction', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ASSESSOR_REPORTS', 'RPT', 'rptreport.jat', 'Generate Journal of Assessment Transaction', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ASSESSOR_REPORTS', 'RPT', 'rptreport.jat', 'Generate Journal of Assessment Transaction', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ASSESSOR_REPORTS', 'RPT', 'rptreport.masterlist', 'Generate Master List of Real Property', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ASSESSOR_REPORTS', 'RPT', 'rptreport.notice', 'Generate Notice of Assessment', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ASSESSOR_REPORTS', 'RPT', 'rptreport.notice', 'Generate Notice of Assessment', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ASSESSOR_REPORTS', 'RPT', 'rptreport.notice', 'Generate Notice of Assessment', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'rptledger.noticeofdelinquency', 'Generate Realty Tax Notice of Delinquency', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ASSESSOR_REPORTS', 'RPT', 'rptreport.orf', 'Generate Ownership Record Form', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ASSESSOR_REPORTS', 'RPT', 'rptreport.orf', 'Generate Ownership Record Form', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ASSESSOR_REPORTS', 'RPT', 'rptreport.orf', 'Generate Ownership Record Form', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ASSESSOR_REPORTS', 'RPT', 'rptreport.reportonrpa', 'Report on Real Property Assessment', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ASSESSOR_REPORTS', 'RPT', 'rptreport.comparativemv', 'Generate Comparative Data on Market Value', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'landtax.rptc', 'Real Property Tax Collection', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'xlandtax.rptc', 'xlandtax.rptc', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'landtax.rptdelinquency', 'Generate Realty Tax Delinquency Listing', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'landtax.rptclearance', 'Realty Tax Clearance', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'landtax.rptclearance', 'Realty Tax Clearance', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ASSESSOR_REPORTS', 'RPT', 'rptreport.tmcr', 'Generate TMCR Report', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ASSESSOR_REPORTS', 'RPT', 'rptreport.tmcr', 'Generate TMCR Report', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('ASSESSOR_REPORTS', 'RPT', 'rptreport.tmcr', 'Generate TMCR Report', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'RPT', 'rptreceipt.batch', 'Batch Realty Tax Collection', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'rptbilling.generate', 'Generate Real Property Billing', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'rptbilling.generate', 'Generate Real Property Billing', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'rptbilling.generate', 'Generate Real Property Billing', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'rptbilling.printbill', 'Print Real Property Billing', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'rptbilling.previewbill', 'Preview Real Property Billing', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'rptcertifications.open', 'RPT Certifications Open', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'rptcertifications.open', 'RPT Certifications Open', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'landholding.view', 'RPT Certifications Land Holding View', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'landholding.view', 'RPT Certifications Land Holding View', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'landholding.create', 'RPT Certifications Land Holding Create', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'landholding.create', 'RPT Certifications Land Holding Create', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'latestexistproperty.open', 'RPT Certifications Latest Exist Property Open', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'latestexistproperty.view', 'RPT Certifications Latest Exist Property View', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'latestexistproperty.create', 'RPT Certifications Latest Exist Property Create', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'latestexistproperty.create', 'RPT Certifications Latest Exist Property Create', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'rptcertification_list.view', 'RPT Certifications List View', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'rptcertification_list.view', 'RPT Certifications List View', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'multipleproperty.open', 'RPT Certifications Multiple Property Open', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'multipleproperty.view', 'RPT Certifications Multiple Property View', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'multipleproperty.create', 'RPT Certifications Multiple Property Create', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'multipleproperty.create', 'RPT Certifications Multiple Property Create', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'noencumbrance.open', 'Open No Encumbrance Certification', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'noencumbrance.view', 'View No Encumbrance Certification', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'noencumbrance.create', 'Create No Encumbrance Certification', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'noencumbrance.create', 'Create No Encumbrance Certification', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'noimprovementbytdno.open', 'RPT Certifications No Improvement By TD No Open', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'noimprovementbytdno.view', 'RPT Certifications No Improvement By TD No View', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'noimprovementbytdno.create', 'RPT Certifications No Improvement By TD No Create', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'noimprovementbytdno.create', 'RPT Certifications No Improvement By TD No Create', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'noimprovement.open', 'RPT Certifications No Improvement Open', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'noimprovement.view', 'RPT Certifications No Improvement View', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'noimprovement.create', 'RPT Certifications No Improvement Create', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'noimprovement.create', 'RPT Certifications No Improvement Create', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'noproperty.open', 'RPT Certifications No Property Open', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'noproperty.view', 'RPT Certifications No Property View', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'noproperty.create', 'RPT Certifications No Property Create', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'noproperty.create', 'RPT Certifications No Property Create', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'ownership.open', 'Open Ownership Certification', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'ownership.view', 'View Ownership Certification', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAICERTIFICATION_ISSUANCESER', 'RPT', 'ownership.create', 'Create Ownership Certification', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'ownership.create', 'Create Ownership Certification', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'wimprovebytdno.open', 'RPT Certifications With Improvement By TD No Open', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'wimprovebytdno.view', 'RPT Certifications With Improvement By TD No View', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'wimprovebytdno.create', 'RPT Certifications With Improvement By TD No Create', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'wimprovebytdno.create', 'RPT Certifications With Improvement By TD No Create', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'withimproveland.open', 'withimproveland.open', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'withimproveland.view', 'withimproveland.view', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'withimproveland.create', 'withimproveland.create', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CERTIFICATION_ISSUANCE', 'RPT', 'withimproveland.create', 'withimproveland.create', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'rptcompromise.create', 'Create Compromise Agreement', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'rptcompromise.open', 'Open Compromise Agreement', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'rptcompromise.create', 'Create Compromise Agreement', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'rptcompromise.create', 'Create Compromise Agreement', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'rptcompromise.edit', 'Edit Compromise Agreement', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'rptcompromise.submit', 'Submit Compromise Agreement', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'rptcompromise.submitforapproval', 'Submit For Approval Compromise Agreement', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'rptcompromise.approve', 'Approve Compromise Agreement', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'rptcompromise.delete', 'Delete Compromise Agreement', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'rptcompromise.preview', 'Preview Compromise Agreement', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'rptcompromise.print', 'Print Compromise Agreement', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'rptcompromise.view', 'Manage Compromise Agreemtns', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'rptcompromise.view', 'Manage Compromise Agreemtns', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'rptcompromise.create', 'Create Compromise Agreement', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'rptcompromise.open', 'Open Compromise Agreement', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'rptledger.approve', 'Approve RPT Ledger', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'rptledger.capturepayment', 'Capture RPT Ledger Payment', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'rptledger.previewbill', 'Preview RPT Bill', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'rptledger.printbill', 'Print RPT Bill', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'rptledger.view', 'View RPT Ledger', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'rptledger.view', 'View RPT Ledger', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'rptledger.view', 'View RPT Ledger', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LANDTAX', 'RPT', 'rptledger.open', 'Open RPT Ledger', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'rptparameters.view', 'View RPT Parameters', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'rptparameters.create', 'Create RPT Parameters', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'rptparameters.edit', 'Edit RPT Parameters', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'rptparameters.delete', 'Delete RPT Parameters', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'rptsetting.view', 'View RPT Settings', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'structures.view', 'View Structures', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'structures.create', 'Create Structures', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'structures.edit', 'Edit Structures', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'RPT', 'structures.delete', 'Delete Structures', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'subdivision.view', 'View Subdivision', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'subdivision.view', 'View Subdivision', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'subdivision.create', 'Create Subdivision', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'subdivision.create', 'Create Subdivision', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'subdivision.view', 'View Subdivision', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'subdivision.submit', 'Submit Subdivision', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CITY_ASSESSOR', 'RPT', 'subdivision.disapprove', 'Disapprove Subdivision', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CITY_ASSESSOR', 'RPT', 'subdivision.approve', 'Approve Subdivision', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MUNICIPAL_ASSESSOR', 'RPT', 'subdivision.submitToProvince', 'Submit to Province Subdivision', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('PROVINCIAL_ASSESSOR', 'RPT', 'subdivision.disapproveByProvince', 'Disapprove By Province Subdivision', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('PROVINCIAL_ASSESSOR', 'RPT', 'subdivision.approveByProvince', 'Appry By Province Subdivision', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'subdivisionmgt.view', 'View Subdivision Management', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'subdivisionmgt.view', 'View Subdivision Management', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'subdivisionmgt.open', 'Open Subdivision Management', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'rpt_transmittal.create', 'Create FAAS Transmittal', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'rpt_transmittal.open', 'Open FAAS Transmittal', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'rpt_transmittal.create', 'Create FAAS Transmittal', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'rpt_transmittal.create', 'Create FAAS Transmittal', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'rpt_transmittal.export', 'Export FAAS Transmittal', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'rpt_transmittal_import.create', 'Import FAAS Transmittal', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'rpt_transmittal_import.open', 'View Imported FAAS Transmittal', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'rpt_transmittal_import.create', 'Import FAAS Transmittal', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'rpt_transmittal_import.create', 'Import FAAS Transmittal', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'rpt_transmittal_import_mgmt.view', 'Manage Import FAAS Transmittals', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'rpt_transmittal_import_mgmt.view', 'Manage Import FAAS Transmittals', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'rpt_transmittal_import.create', 'Import FAAS Transmittal', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'rpt_transmittal_import.open', 'View Imported FAAS Transmittal', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'rpt_transmittal_mgmt.view', 'Manage FAAS Transmittals', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'rpt_transmittal_mgmt.view', 'Manage FAAS Transmittals', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'faastransmittal.create', 'faastransmittal.create', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'rpt_transmittal.open', 'Open FAAS Transmittal', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'truecopy.view', 'View Certified True Copy', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'truecopy.create', 'Create Certified True Copy', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('APPRAISER', 'RPT', 'rptutil.modifypin', 'Access Modify PIN Utility', 'rpt2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'account.view', 'View Chart of Account', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'account.view', 'View Chart of Account', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'af.viewlist', 'View Accountable Form Listing', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'af.viewlist', 'View Accountable Form Listing', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'af.create', 'Create Accountable Form', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'af.edit', 'Edit Accountable Form', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'af.delete', 'Delete Accountable Form', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'af.approve', 'Approve Accountable Form', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('AFO', 'TREASURY', 'afcontrol.viewlist', 'afcontrol.viewlist', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('AFO', 'TREASURY', 'afcontrol.delete', 'afcontrol.delete', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('AFO', 'TREASURY', 'afcontrol.changemode', 'AF Control Change Mode', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('AFO', 'TREASURY', 'afcontrol.transfer', 'Transfer AF Control', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('AFO', 'TREASURY', 'afcontrol.adjustqty', 'Adjust AF Control Quantity (NonSerial)', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('AFO', 'TREASURY', 'afcontrol.assignto', 'Assign AF Control', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('AFO', 'TREASURY', 'afcontrol.activate', 'Activate AF Control', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('AFO', 'TREASURY', 'afcontrol.activate', 'Activate AF Control', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('AFO', 'TREASURY', 'afcontrol.activate', 'Activate AF Control', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('AFO', 'TREASURY', 'afinventory.view', 'View AF Inventory Information', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('AFO', 'TREASURY', 'afinventory.view', 'View AF Inventory Information', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('AFO', 'TREASURY', 'afinventory.view', 'View AF Inventory Information', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'bank.view', 'View Bank Information', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'bank.view', 'View Bank Information', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'bank.create', 'Create Bank', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'bank.edit', 'Edit Bank', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'bank.delete', 'Delete Bank', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'bankacct.view', 'View Bank Account Information', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'bankacct.view', 'View Bank Account Information', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'bankacct.create', 'Create Bank Account', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'bankacct.edit', 'Edit Bank Account', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'bankacct.delete', 'Delete Bank Account', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'bankacct.approve', 'Approve Bank Account', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'batchcapture.create', 'Create Batch Capture', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'batchcapture.create', 'Create Batch Capture', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'batchcapture.view', 'View Batch Capture', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'batchcapture.create', 'Create Batch Capture', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'batchcapturemgmt.view', 'View Batch Capture Management', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'batchcapturemgmt.view', 'View Batch Capture Management', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'batchcapture.create', 'Create Batch Capture', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'batchcapture.open', 'Open Batch Capture', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'batchcapture.create', 'Create Batch Capture', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'batchcapture.create', 'Create Batch Capture', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'batchcapture.view', 'View Batch Capture', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'batchcapture.create', 'Create Batch Capture', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'bookletcollection.create', 'bookletcollection.create', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'collection.create_online', 'Create Online Collection', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'collection.create_offline', 'Create Offline Collection', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'collection.create_capture', 'Create Capture Collection', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'collection.create_online', 'Create Online Collection', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'collection.create_offline', 'Create Offline Collection', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'collection.create_capture', 'Create Capture Collection', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'collection.create_online', 'Create Online Collection', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'collection.create_offline', 'Create Offline Collection', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'collection.create_capture', 'Create Capture Collection', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'collectiongroup.view', 'View Collection Groups', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'collectiongroup.view', 'View Collection Groups', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'collectiongroup.create', 'Create Collection Group', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'collectiongroup.edit', 'Edit Collection Group', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'collectiongroup.delete', 'Delete Collection Group', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'collectionsetting.manage', 'Manage Collection Setting', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'collectionsetting.manage', 'Manage Collection Setting', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'collectiontype.viewlist', 'View Collection Type Listing', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'collectiontype.viewlist', 'View Collection Type Listing', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'collectiontype.create', 'Create Collection Type', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'collectiontype.edit', 'Edit Collection Type', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'collectiontype.delete', 'Delete Collection Type', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CASHIER', 'TREASURY', 'deposit.create', 'Create Deposit Information', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CASHIER', 'TREASURY', 'deposit.create', 'Create Deposit Information', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CASHIER', 'TREASURY', 'deposit.create', 'Create Deposit Information', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CASHIER', 'TREASURY', 'deposit.viewlist', 'View Deposit Listing', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('CASHIER', 'TREASURY', 'deposit.viewlist', 'View Deposit Listing', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'form60.setup', 'Setup Form 60 Report', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'fund.viewlist', 'View Fund Listing', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'fund.viewlist', 'View Fund Listing', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'fund.create', 'Create Fund', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'fund.edit', 'Edit Fund', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'fund.delete', 'Delete Fund', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'fund.approve', 'Approve Fund', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'incomeacct.viewlist', 'View Income Account Listing', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'incomeacct.viewlist', 'View Income Account Listing', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'incomeacct.create', 'Create Income Account', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'incomeacct.edit', 'Edit Income Account', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'incomeacct.delete', 'Delete Income Account', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'incomeacct.approve', 'Approve Income Account', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'incomeacctgroup.viewlist', 'View Income Account Group Listing', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'incomeacctgroup.viewlist', 'View Income Account Group Listing', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'incomeacctgroup.create', 'Create Income Account Group', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('MASTER_ENCODER', 'TREASURY', 'incomeacctgroup.delete', 'Delete Income Account Group', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('AFO', 'TREASURY', 'iraf.viewlist', 'View IRAF Listing', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('AFO', 'TREASURY', 'iraf.viewlist', 'View IRAF Listing', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('AFO', 'TREASURY', 'iraf.create', 'Create IRAF', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('AFO', 'TREASURY', 'iraf.edit', 'Edit IRAF', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('AFO', 'TREASURY', 'iraf.delete', 'Delete IRAF', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('AFO', 'TREASURY', 'iraf.approve', 'Approve IRAF', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LIQUIDATING_OFFICER', 'TREASURY', 'liquidation.create', 'Create Liquidation', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LIQUIDATING_OFFICER', 'TREASURY', 'liquidation.create', 'Create Liquidation', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LIQUIDATING_OFFICER', 'TREASURY', 'liquidation.create', 'Create Liquidation', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LIQUIDATING_OFFICER', 'TREASURY', 'liquidation.viewlist', 'View Liquidation Listing', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LIQUIDATING_OFFICER', 'TREASURY', 'liquidation.viewlist', 'View Liquidation Listing', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LIQUIDATING_OFFICER', 'TREASURY', 'liquidation.viewlist', 'View Liquidation Listing', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LIQUIDATING_OFFICER', 'TREASURY', 'liquidationmulti.create', 'Create Multi-Cashier Liquidation', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LIQUIDATING_OFFICER', 'TREASURY', 'liquidationmulti.create', 'Create Multi-Cashier Liquidation', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('LIQUIDATING_OFFICER', 'TREASURY', 'liquidationmulti.create', 'Create Multi-Cashier Liquidation', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'postcapturereceipt.create', 'Create Post Capture Receipt', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'postcapturereceipt.create', 'Create Post Capture Receipt', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'postcapturereceipt.create', 'Create Post Capture Receipt', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'postcapturereceipt.viewlist', 'View Post Capture Listing', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'postcapturereceipt.viewlist', 'View Post Capture Listing', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'postcapturereceipt.create', 'Create Post Capture Receipt', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'receipt.inquire', 'Inquire Receipt Information', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'remittance.create', 'Create Remittance', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'remittance.create', 'Create Remittance', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'remittance.create', 'Create Remittance', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'remittance.create', 'Create Remittance', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'remittance.import', 'Import Remittance', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('SUBCOLLECTOR', 'TREASURY', 'remittance_subcollector.create', 'remittance_subcollector.create', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('SUBCOLLECTOR', 'TREASURY', 'remittance_subcollector.create', 'remittance_subcollector.create', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'remittance.viewlist', 'View Remittance Listing', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'remittance.viewlist', 'View Remittance Listing', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'remittance.create', 'Create Remittance', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('AFO', 'TREASURY', 'riv_lgu.create', 'Create LGU RIV', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'riv.collector', 'Create RIV (Collector)', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'riv.salecreate', 'Create RIV (SALE)', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('AFO', 'TREASURY', 'riv_lgu.create', 'Create LGU RIV', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'riv.create', 'Create RIV', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'riv.salecreate', 'Create RIV (SALE)', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('TREASURY_REPORTS', 'TREASURY', 'tcreport.craaf', 'CRAAF Report', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('TREASURY_REPORTS', 'TREASURY', 'tcreport.statementofrevenue', 'Generate Statement of Revenue', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('TREASURY_REPORTS', 'TREASURY', 'tcreport.incomeaccount', 'Income Account Report', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('TREASURY_REPORTS', 'TREASURY', 'tcreport.reportofcollection', 'Report of Collection', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('TREASURY_REPORTS', 'TREASURY', 'tcreport.reportofcollection2', 'Report of Collection 2', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('TREASURY_REPORTS', 'TREASURY', 'tcreport.reportofcollection2', 'Report of Collection 2', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('TREASURY_REPORTS', 'TREASURY', 'tcreport.statementofrevenue', 'Generate Statement of Revenue', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('TREASURY_REPORTS', 'TREASURY', 'tcreport.statementofrevenueexpanded', 'tcreport.statementofrevenueexpanded', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('TREASURY_REPORTS', 'TREASURY', 'tcreport.statementofrevenue', 'Generate Statement of Revenue', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('TREASURY_REPORTS', 'TREASURY', 'tcreport.statementofrevenue', 'Generate Statement of Revenue', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('TREASURY_ADMIN', 'TREASURY', 'treasurymgmt.view', 'View Treasury Management', 'tc2');
INSERT INTO lguname_system.sys_role_permission ( sysrole, domain, ACTION, title, module )  VALUES ('COLLECTOR', 'TREASURY', 'receipt.viewissued', 'View Issued Receipt Listing', 'tc2');


ALTER TABLE lguname_etracs.afcontrol CHANGE COLUMN afinventorycreditid afinventorycreditid VARCHAR(50) NULL;


/*================================================================================================
**
** Addition of quarterlyInstallmentPaidOnTime fact 
**
================================================================================================*/

ALTER TABLE lguname_etracs.rptledger ADD COLUMN quarterlyinstallmentpaidontime INT NULL;

/* default to unpaid */
UPDATE lguname_etracs.rptledger SET quarterlyinstallmentpaidontime = 1;

/* set if currently year has payment */
UPDATE lguname_etracs.rptledger SET 
	quarterlyinstallmentpaidontime = 0
WHERE lastyearpaid < 2012 ;



CREATE TABLE lguname_etracs.landtaxsetting(
	objid VARCHAR(50) PRIMARY KEY,
	duedates TEXT NOT NULL
);

DELETE FROM lguname_system.rule_package WHERE `type` = 'facts'

ALTER TABLE lguname_etracs.rptledger ADD COLUMN undercompromised INT;

UPDATE lguname_etracs.rptledger SET undercompromised = 0;
