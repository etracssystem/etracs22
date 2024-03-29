[getById] 
SELECT * FROM incomeaccount WHERE objid = $P{objid}

[getList]
SELECT * FROM incomeaccount ORDER BY accttitle   

[getListByAcctNo]
SELECT * FROM incomeaccount WHERE acctno LIKE $P{acctno}  ORDER BY accttitle  

[getListByTitle]
SELECT * FROM incomeaccount WHERE accttitle LIKE $P{accttitle} ORDER BY accttitle   

[getIncomeAccountList]
SELECT objid, acctno, acctcode, accttitle, fundid, fundname, defaultvalue, amounttype, allowdiscount  FROM incomeaccount WHERE docstate = 'APPROVED' ORDER BY accttitle 

[getIncomeAccountListByNo]
SELECT objid, acctno, acctcode, accttitle, fundid, fundname, defaultvalue, amounttype, allowdiscount  FROM incomeaccount WHERE docstate = 'APPROVED' AND acctno = $P{acctno} ORDER BY accttitle 

[getIncomeAccountListByTitle]
SELECT objid, acctno, acctcode, accttitle, fundid, fundname, defaultvalue, amounttype, allowdiscount FROM incomeaccount WHERE docstate = 'APPROVED' AND accttitle LIKE $P{accttitle} ORDER BY accttitle 

[getFund]
SELECT * FROM fund WHERE docstate = 'APPROVED'

[getFundId]
SELECT objid FROM fund WHERE fundname = $P{fundname}

[checkDuplicateAcctNo]
SELECT COUNT(*) AS count FROM incomeaccount 
WHERE objid <> $P{objid} AND acctno = $P{acctno} 

[checkDuplicateTitle]
SELECT COUNT(*) AS count FROM incomeaccount 
WHERE objid <> $P{objid} AND accttitle = $P{title} 

[checkReferencedId]
SELECT COUNT(*) AS count FROM receiptitem WHERE acctid = $P{acctid}


/*** REPORT SQL ***/

[getNGASData]
SELECT 
	CONCAT( COALESCE(p2.acctcode, ''), ' - ' , COALESCE(p2.accttitle,'UNMAPPED') ) as parent2, 
	CONCAT( COALESCE(p1.acctcode, ''), ' - ' , COALESCE(p1.accttitle,'UNMAPPED') ) as parent1, 
	CONCAT( COALESCE(p.acctcode, ''), ' - ' , COALESCE(p.accttitle,'UNMAPPED') ) as parent, 
	CONCAT( COALESCE(ic.acctno, ''), ' - ' , COALESCE(ic.accttitle,'UNMAPPED') ) as account 
FROM incomeaccount ic  
LEFT JOIN account p ON ic.ngasid = p.objid 
LEFT JOIN account p1 ON p.parentid = p1.objid 
LEFT JOIN account p2 ON p1.parentid = p2.objid 
WHERE ic.docstate = 'APPROVED' 
GROUP BY p2.acctcode, p2.accttitle, p1.acctcode, p1.accttitle, p.acctcode, p.accttitle, ic.acctno, ic.accttitle


[getSREData]
SELECT 
	CONCAT( COALESCE(p2.acctcode, ''), '-' , COALESCE(p2.accttitle,'UNMAPPED') ) as parent2, 
	CONCAT( COALESCE(p1.acctcode, ''), '-' , COALESCE(p1.accttitle,'UNMAPPED') ) as parent1, 
	CONCAT( COALESCE(p.acctcode, ''), '-' , COALESCE(p.accttitle,'UNMAPPED') ) as parent, 
	CONCAT( COALESCE(ic.acctno, ''), '-' , COALESCE(ic.accttitle,'UNMAPPED') ) as account 
FROM incomeaccount ic  
LEFT JOIN account p ON ic.sreid = p.objid 
LEFT JOIN account p1 ON p.parentid = p1.objid 
LEFT JOIN account p2 ON p1.parentid = p2.objid 
WHERE ic.docstate = 'APPROVED' 
GROUP BY p2.acctcode, p2.accttitle, p1.acctcode, p1.accttitle, p.acctcode, p.accttitle, ic.acctno, ic.accttitle




[getAccttitleAtRule]
SELECT ruletext  
FROM rule 
WHERE ruletext LIKE $P{acctid} 

