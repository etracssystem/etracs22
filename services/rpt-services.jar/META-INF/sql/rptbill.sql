[getOpenLedgersByTaxpayerId]
SELECT 
${fields}	
FROM rptledger rl
	INNER JOIN faaslist fl ON rl.faasid = fl.objid 
WHERE rl.taxpayerid = $P{taxpayerid} AND rl.docstate = 'APPROVED' AND rl.taxable = 1 
 AND ( rl.lastyearpaid < $P{currentyr} OR (rl.lastyearpaid = $P{currentyr} AND rl.lastqtrpaid < 4 ) or rl.partialbasic > 0) 
  
[getOpenLedgersByPropertyPayer]
SELECT 
${fields}
FROM rptledger rl
	INNER JOIN propertypayeritem ppi ON rl.objid = ppi.ledgerid 
	INNER JOIN propertypayer p ON ppi.propertypayerid = p.objid
	INNER JOIN faaslist fl ON rl.faasid = fl.objid 
WHERE p.taxpayerid = $P{taxpayerid}
 AND rl.docstate = 'APPROVED' AND rl.taxable = 1 
 AND ( rl.lastyearpaid < $P{currentyr} OR (rl.lastyearpaid = $P{currentyr} AND rl.lastqtrpaid < 4 ) or partialbasic > 0) 
 
 
[getOpenLedgersById]
SELECT  
${fields}
FROM rptledger rl 
	INNER JOIN faaslist fl ON rl.faasid = fl.objid 
WHERE rl.objid = $P{objid} AND rl.docstate = 'APPROVED' AND rl.taxable = 1 
 AND ( rl.lastyearpaid < $P{currentyr} OR (rl.lastyearpaid = $P{currentyr} AND rl.lastqtrpaid < 4 ) OR rl.partialbasic > 0 )  
 
[getOpenLedgerItems] 
SELECT 
	objid, tdno, txntype, classid, classcode, actualuseid, actualusecode, backtax,  
	fromyear, CASE WHEN toyear = 0 THEN $P{currentyr} ELSE toyear END AS toyear, assessedvalue ,
    0.0 AS basic, 0.0 AS basicint, 0.0 AS basicdisc,
    0.0 AS sef, 0.0 AS sefint, 0.0 AS sefdisc     
FROM rptledgeritem  
WHERE parentid = $P{parentid} AND docstate = 'APPROVED' AND taxable = 1   
ORDER BY fromyear   

[getOpenLedgersByTdRange]
SELECT  objid, tdno 
FROM rptledger rl 
WHERE rl.docstate = 'APPROVED' 
 AND rl.taxable = 1 
 AND rl.tdno BETWEEN $P{fromtdno} AND $P{totdno} 
 AND ( rl.lastyearpaid < $P{currentyr} OR (rl.lastyearpaid = $P{currentyr} AND rl.lastqtrpaid < 4 ) OR rl.partialbasic > 0 )  
 AND undercompromised = 0 
ORDER BY tdno  
 

[getOpenLedgersByBarangay] 
SELECT  objid, tdno
FROM rptledger  
WHERE barangay LIKE $P{barangay} 
  AND docstate = 'APPROVED' AND taxable = 1  
  AND ( lastyearpaid < $P{currentyr} OR (lastyearpaid = $P{currentyr} AND lastqtrpaid < 4 ) )  
  AND undercompromised = 0 
ORDER BY tdno 


[getIncomeAccountInfo]
SELECT objid AS acctid, acctno, accttitle, fundid, fundname FROM incomeaccount  WHERE objid = $P{objid}


[lookupAccount]
SELECT objid, acctno, accttitle FROM incomeaccount WHERE systype = $P{systype} ORDER BY accttitle 


[lookupAccountByNo]
SELECT objid, acctno, accttitle FROM incomeaccount  WHERE acctno = $P{acctno} AND systype = $P{systype} ORDER BY accttitle 

[lookupAccountByTitle]
SELECT objid, acctno, accttitle FROM incomeaccount  WHERE accttitle LIKE $P{accttitle} AND systype = $P{systype} ORDER BY accttitle 



[getLatestPaymentInfo]
SELECT 
	receiptid AS latestorid,
	receiptno AS latestorno, 
	receiptdate AS latestordate 
FROM rptpayment 
WHERE rptledgerid = $P{rptledgerid}
  AND voided = 0
ORDER BY receiptdate DESC 

[getLedgerByTdNo]
SELECT * FROM rptledger WHERE tdno = $P{tdno} AND docstate = 'APPROVED'
