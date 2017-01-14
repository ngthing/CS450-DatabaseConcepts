SELECT	itemno, description
FROM 	Items 
WHERE	itemno IN
		(SELECT CS1.itemno
		FROM	canSupply CS1, canSupply CS2
		WHERE	CS1.itemno = CS2.itemno AND 
				CS1.supno != CS2.supno AND
				CS1.cost = CS2.cost);


SELECT	cusno, cname
FROM 	Customers
WHERE	cusno IN 
		(SELECT	P.cusno
		FROM	Purchase P, Items I 
		WHERE	I.itemno = P.itemno AND I.price > 100 
				AND P.purdate >= to_date('150101','YYMMDD')
				AND	P.purdate <= to_date('151231', 'YYMMDD'));


SELECT  itemno, description
FROM 	Items 
WHERE	quantity > 20 
		AND itemno NOT IN
		(SELECT itemno
		FROM	Purchase
		WHERE	purdate >= to_date('160101','YYMMDD'));


SELECT	cusno, cname
FROM 	Customers
WHERE	cusno NOT IN
		(SELECT	cusno
		FROM	CardOwner
		WHERE	cardno IN
				(SELECT	cardno
				FROM	CreditCards
				WHERE	expiration >= to_date('160722','YYMMDD')));

SELECT	C.cusno, C.cname
FROM 	Customers C
WHERE	NOT EXISTS(
		(SELECT	itemno
		FROM	canSupply
		WHERE	supno='S01')
		MINUS
		(SELECT	P.itemno
		FROM 	Purchase P
		WHERE	P.cusno = C.cusno));



(SELECT	e1.empno AS empno1, e1.empname AS empname1, e2.empno AS empno2, e2.empname AS empname2
FROM 	Employees e1, Employees e2
WHERE	e1.empno < e2.empno AND e1.workdept = e2.workdept )
MINUS
(SELECT empno1,empname1, empno2, empname2
FROM (
(SELECT	e1.empno AS empno1, e1.empname AS empname1, e2.empno AS empno2,e2.empname AS empname2,e2.eskill, e1.eskill
	FROM 	Employees e1, Employees e2
	WHERE	e1.empno < e2.empno AND e1.workdept = e2.workdept)
	MINUS
	(SELECT	e1.empno AS empno1, e1.empname AS empname1, e2.empno AS empno2,e2.empname AS empname2,e1.eskill, e2.eskill
	FROM 	Employees e1, Employees e2
	WHERE	e1.empno < e2.empno AND e1.workdept = e2.workdept))
	);



SELECT 	C.cusno, C.cname, Count(*) AS Number_of_purchases, SUM(P.quantity*(I.price + I.shipcost)) AS Total_payed
FROM	Customers C, Purchase P, Items I 
WHERE	P.purdate >= to_date('150101','YYMMDD') AND	P.purdate <= to_date('151231', 'YYMMDD')
		AND P.cusno = C.cusno AND I.itemno = P.itemno
Group by C.cusno, C.cname
Order by  Total_payed desc;

SELECT	I.itemno, I.description, SUM(P.quantity) AS Total_procured,
		Sum(P.quantity*S.cost) AS Total_cost, AVG(S.cost) AS Average_cost
FROM	Items I, Procurement P, canSupply S
WHERE	P.pdate >= to_date('150101','YYMMDD') AND P.pdate <= to_date('151231', 'YYMMDD')
		AND I.itemno = P.itemno AND S.itemno = P.itemno
Group by I.itemno, I.description;


SELECT T.ctype as credit_card_type
FROM (
	SELECT 	c.type as ctype, SUM(p.quantity*(i.price+i.shipcost)) as total_charged
	FROM	Creditcards c, Purchase p, Items i
	WHERE	c.cardno = p.cardno AND p.itemno = i.itemno
	Group by c.type ) T
WHERE T.total_charged >= ALL (
	SELECT	total_charged
	FROM	
	(SELECT 	c.type as ctype, SUM(p.quantity*(i.price+i.shipcost)) as total_charged
	FROM	Creditcards c, Purchase p, Items i
	WHERE	c.cardno = p.cardno AND p.itemno = i.itemno
	Group by c.type));
	
SELECT 	COUNT(DISTINCT e.empno) AS Total_Violators
FROM 	Employees e, Admin a
WHERE	e.empno = a.managerno AND e.workdept != a.deptcode;


SELECT	c.cusno, c.cname, c.address
FROM 	Customers
WHERE 	c.cusno IN


// For HW6
1a. custPurchaseDetail
SELECT	c.cusno,c.cname, c.address, p.purdate, i.itemno, i.description, i.price, i.shipcost,
		p.quantity, (i.price*p.quantity) as total_price, (i.shipcost*p.quantity) as total_shipping,
		(i.price*p.quantity + i.shipcost*p.quantity) as overall_charge, p.cardno as credit_card 
FROM	Customers c, Purchase p, Items i
WHERE	p.purdate >= to_date('160401','YYMMDD')
AND 	p.purdate <= to_date('160630','YYMMDD')
AND 	c.cusno = p.cusno
AND 	i.itemno = p.itemno

1b. custPurchaseSum
SELECT	c.cusno,c.cname, c.address SUM(p.quantity) as customer_purchases,
		SUM(p.quantity*(i.price+i.shipcost)) as overall_charge,
		(SUM(p.quantity*(i.price+i.shipcost))/SUM(p.quantity)) as average_charge
FROM	Customers c, Purchase p, Items i
WHERE	p.purdate >= to_date('160401','YYMMDD')
AND 	p.purdate <= to_date('160630','YYMMDD')
AND 	c.cusno = p.cusno
AND 	i.itemno = p.itemno
GROUP BY c.cusno, c.cname, c.address
String custPurchaseSum = "SELECT c.cusno, SUM(p.quantity) as customer_purchases, SUM(p.quantity*(i.price+i.shipcost)) as overall_charge,(SUM(p.quantity*(i.price+i.shipcost))/SUM(p.quantity)) as average_charge FROM Customers c, Purchase p, Items i WHERE p.purdate >= to_date('160401','YYMMDD') AND p.purdate <= to_date('160630','YYMMDD') AND c.cusno = p.cusno AND i.itemno = p.itemno GROUP BY c.cusno"

1c quarterSum
SELECT	SUM(p.quantity) as quarter_purchases,
		SUM(p.quantity*(i.price+i.shipcost)) as overall_charge,
		(SUM(p.quantity*(i.price+i.shipcost))/SUM(p.quantity)) as average_charge
FROM	Customers c, Purchase p, Items i
WHERE	p.purdate >= to_date('160401','YYMMDD')
AND 	p.purdate <= to_date('160630','YYMMDD')
AND 	c.cusno = p.cusno
AND 	i.itemno = p.itemno

String qsum = "SELECT SUM(p.quantity) as quarter_purchases, SUM(p.quantity*(i.price+i.shipcost)) as overall_charge, (SUM(p.quantity*(i.price+i.shipcost))/SUM(p.quantity)) as average_charge FROM	Customers c, Purchase p, Items i WHERE	p.purdate >= to_date('160401','YYMMDD') AND p.purdate <= to_date('160630','YYMMDD') AND c.cusno = p.cusno AND i.itemno = p.itemno"

1d notActiveCust
SELECT	c.cusno, c.cname
FROM 	Customers c
WHERE 	c.cusno NOT IN (
SELECT	c.cusno
FROM	Customers c, Purchase p
WHERE	p.purdate >= to_date('160401','YYMMDD')
AND 	p.purdate <= to_date('160630','YYMMDD')
AND 	c.cusno = p.cusno
)
String notactive = "SELECT c.cusno, c.cname FROM Customers c WHERE c.cusno NOT IN (SELECT c.cusno FROM Customers c, Purchase p WHERE p.purdate >= to_date('160401','YYMMDD') AND p.purdate <= to_date('160630','YYMMDD') AND c.cusno = p.cusno)"

String q1 = "SELECT	c.cusno,c.cname, c.address, p.purdate, i.itemno, i.description, i.price, i.shipcost," +
		"p.quantity, (i.price*p.quantity) as total_price, (i.shipcost*p.quantity) as total_shipping," +
		"(i.price*p.quantity + i.shipcost*p.quantity) as overall_charge, p.cardno as credit_card" +
		"FROM Customers c, Purchase p, Items i" +
		"WHERE p.purdate >= to_date('160401','YYMMDD')" +
		"AND p.purdate <= to_date('160630','YYMMDD')" +
		"AND c.cusno = p.cusno AND i.itemno = p.itemno";


String q2 = "SELECT c.cusno FROM Customers c, Purchase p WHERE p.purdate >= to_date('160401','YYMMDD')" +
			"AND p.purdate <= to_date('160630','YYMMDD') AND c.cusno = p.cusno";
 String q2 = "SELECT c.cusno,c.cname,c.address FROM Customers c, Purchase p WHERE p.purdate >= to_date('160401','YYMMDD') AND p.purdate <= to_date('160630','YYMMDD') AND c.cusno = p.cusno";


System.out.println("Quarter Purchases:" + quarterSum.getString("quarter_purchases") + ", Overall Charges:" +  quarterSum.getString("overall_charge") + ", Average Charge:" +  quarterSum.getString("average_charge")); //Print the current row

System.out.println(custPurchaseDetail.getString("purdate") + "\t\t" +  custPurchaseDetail.getString("itemno") + "\t\t" +  custPurchaseDetail.getString("description")+ "\t\t" +  custPurchaseDetail.getString("price")+ "\t\t" +  custPurchaseDetail.getString("shipcost")+ "\t\t" +  custPurchaseDetail.getString("quantity")+ "\t\t" +  custPurchaseDetail.getString("total_price")+ "\t\t" +  custPurchaseDetail.getString("total_shipping")+ "\t\t" +  custPurchaseDetail.getString("overall_charge")+ "\t\t" +  custPurchaseDetail.getString("credit_card")); //Print the current row

p.purdate, i.itemno, i.description, i.price, i.shipcost,p.quantity, (i.price*p.quantity) as total_price, (i.shipcost*p.quantity) as total_shipping, (i.price*p.quantity + i.shipcost*p.quantity) as overall_charge, p.cardno as credit_card
 System.out.println("Date\tItemNo\tDesc\tPrice\tShip\tQty\tT_Price\tT_Ship\tTotal\tCredit");

while (custPurchaseDetail.next() )
        {
        System.out.println(custPurchaseDetail.getString("purdate") + "\t\t" +  custPurchaseDetail.getString("itemno") + "\t\t" +  custPurchaseDetail.getString("description")+ "\t\t" +  custPurchaseDetail.getString("price")+ "\t\t" +  custPurchaseDetail.getString("shipcost")+ "\t\t" +  custPurchaseDetail.getString("quantity")+ "\t\t" +  custPurchaseDetail.getString("total_price")+ "\t\t" +  custPurchaseDetail.getString("total_shipping")+ "\t\t" +  custPurchaseDetail.getString("overall_charge")+ "\t\t" +  custPurchaseDetail.getString("credit_card")); //Print the current row

System.out.println("Date\tItemNo\tDesc\tPrice\tShip\tQty\tT_Price\tT_Ship\tTotal\tCredit");


Statement stmt = null;
	String strQuery = 
	"SELECT u.uid, firstName, lastName, address1, address2, city, postCode, email, phone, ug.groupName as userGroup "
	+"FROM user u, usergroup ug WHERE uid='"+userName+"' AND password='"+password+"' AND groupName IN"
	+" (SELECT groupName FROM usergroup WHERE groupid =(SELECT groupid FROM usergroup_mapping WHERE uid=u.uid))";
	stmt = conn.createStatement();
	rs = stmt.executeQuery( strQuery);



 
SELECT	c.cusno,c.cname, c.address SUM(p.quantity) as customer_purchases,
		SUM(p.quantity*(i.price+i.shipcost)) as overall_charge,
		(SUM(p.quantity*(i.price+i.shipcost))/SUM(p.quantity)) as average_charge
FROM	Customers c, Purchase p, Items i
WHERE	p.purdate >= to_date('160401','YYMMDD')
AND 	p.purdate <= to_date('160630','YYMMDD')
AND 	c.cusno = p.cusno
AND 	i.itemno = p.itemno
GROUP BY c.cusno, c.cname, c.address

2a supplierSum
SELECT s.supno, s.supname, s.location, SUM(p.quantity) as numProcurements, SUM(p.quantity*(cs.cost)) as overall_charge, (SUM(p.quantity*(cs.cost))/SUM(p.quantity)) as average 
FROM Suppliers s, Procurement p, Items i, canSupply cs 
WHERE p.pdate >= to_date('160401','YYMMDD')
AND p.pdate <= to_date('160630','YYMMDD')
AND p.supno = s.supno AND p.itemno = i.itemno AND cs.supno = p.supno AND cs.itemno = p.itemno
GROUP BY s.supno, s.supname, s.location

String supSum = "SELECT s.supno, s.supname, s.location, SUM(p.quantity) as numProcurements, SUM(p.quantity*(cs.cost)) as overall_charge, (SUM(p.quantity*(cs.cost))/SUM(p.quantity)) as average  FROM Suppliers s, Procurement p, Items i, canSupply cs  WHERE p.pdate >= to_date('160401','YYMMDD') AND p.pdate <= to_date('160630','YYMMDD') AND p.supno = s.supno AND p.itemno = i.itemno AND cs.supno = p.supno AND cs.itemno = p.itemno GROUP BY s.supno, s.supname, s.location";

2b supplierDetail
SELECT s.supno, p.transno, p.pdate, i.itemno, i.description, p.quantity, p.quantity*cs.cost as total_cost
FROM Suppliers s, Procurement p, Items i, canSupply cs 
WHERE p.pdate >= to_date('160401','YYMMDD')
AND p.pdate <= to_date('160630','YYMMDD')
AND p.supno = ? AND p.itemno = i.itemno AND cs.supno = p.supno AND cs.itemno = p.itemno

String supDetail = "SELECT s.supno, p.transno, p.pdate, i.itemno, i.description, p.quantity, p.quantity*cs.cost as total_cost FROM Suppliers s, Procurement p, Items i, canSupply cs WHERE p.pdate >= to_date('160401','YYMMDD') AND p.pdate <= to_date('160630','YYMMDD') AND p.supno = ? AND p.itemno = i.itemno AND cs.supno = p.supno AND cs.itemno = p.itemno";
PreparedStatement preparedStatement1 = null;
preparedStatement1 = conn.prepareStatement(supDetail);

2c procureSum

SELECT	SUM(p.quantity) as quarter_purchases, SUM(p.quantity*cs.cost) as overall_charge, (SUM(p.quantity*cs.cost))/SUM(p.quantity)) as average_charge
FROM Suppliers s, Procurement p, Items i, canSupply cs 
WHERE p.pdate >= to_date('160401','YYMMDD')
AND p.pdate <= to_date('160630','YYMMDD')
AND p.supno = s.supno AND p.itemno = i.itemno AND cs.supno = p.supno AND cs.itemno = p.itemno
String proSum = "SELECT	SUM(p.quantity) as quarter_purchases, SUM(p.quantity*cs.cost) as overall_charge, (SUM(p.quantity*cs.cost))/SUM(p.quantity)) as average_charge FROM Suppliers s, Procurement p, Items i, canSupply cs  WHERE p.pdate >= to_date('160401','YYMMDD') AND p.pdate <= to_date('160630','YYMMDD') AND p.supno = s.supno AND p.itemno = i.itemno AND cs.supno = p.supno AND cs.itemno = p.itemno";

1d notActiveSup
SELECT	s.supno, s.supname
FROM 	Suppliers s
WHERE 	s.supno NOT IN (
SELECT	s.supno
FROM Suppliers s, Procurement p, Items i, canSupply cs 
WHERE p.pdate >= to_date('160401','YYMMDD')
AND p.pdate <= to_date('160630','YYMMDD')
AND p.supno = s.supno AND p.itemno = i.itemno AND cs.supno = p.supno AND cs.itemno = p.itemno)
String notActiveSup = "SELECT s.supno, s.supname FROM Suppliers s WHERE s.supno NOT IN ( SELECT s.supno FROM Suppliers s, Procurement p, Items i, canSupply cs  WHERE p.pdate >= to_date('160401','YYMMDD') AND p.pdate <= to_date('160630','YYMMDD') AND p.supno = s.supno AND p.itemno = i.itemno AND cs.supno = p.supno AND cs.itemno = p.itemno)";



Statement stmt4 = conn.createStatement(); 
Statement stmt5 = conn.createStatement(); 
Statement stmt6 = conn.createStatement(); 
String supSum = "SELECT s.supno, s.supname, s.location, SUM(p.quantity) as numProcurements, SUM(p.quantity*(cs.cost)) as overall_charge, (SUM(p.quantity*(cs.cost))/SUM(p.quantity)) as average  FROM Suppliers s, Procurement p, Items i, canSupply cs  WHERE p.pdate >= to_date('160401','YYMMDD') AND p.pdate <= to_date('160630','YYMMDD') AND p.supno = s.supno AND p.itemno = i.itemno AND cs.supno = p.supno AND cs.itemno = p.itemno GROUP BY s.supno, s.supname, s.location";
String supDetail = "SELECT s.supno, p.transno, p.pdate, i.itemno, i.description, p.quantity, p.quantity*cs.cost as total_cost FROM Suppliers s, Procurement p, Items i, canSupply cs WHERE p.pdate >= to_date('160401','YYMMDD') AND p.pdate <= to_date('160630','YYMMDD') AND p.supno = ? AND p.itemno = i.itemno AND cs.supno = p.supno AND cs.itemno = p.itemno";
PreparedStatement preparedStatement1 = null;
preparedStatement1 = conn.prepareStatement(supDetail);
String proSum = "SELECT	SUM(p.quantity) as quarter_purchases, SUM(p.quantity*cs.cost) as overall_charge, (SUM(p.quantity*cs.cost))/SUM(p.quantity)) as average_charge FROM Suppliers s, Procurement p, Items i, canSupply cs  WHERE p.pdate >= to_date('160401','YYMMDD') AND p.pdate <= to_date('160630','YYMMDD') AND p.supno = s.supno AND p.itemno = i.itemno AND cs.supno = p.supno AND cs.itemno = p.itemno";
String notActiveSup = "SELECT s.supno, s.supname FROM Suppliers s WHERE s.supno NOT IN ( SELECT s.supno FROM Suppliers s, Procurement p, Items i, canSupply cs  WHERE p.pdate >= to_date('160401','YYMMDD') AND p.pdate <= to_date('160630','YYMMDD') AND p.supno = s.supno AND p.itemno = i.itemno AND cs.supno = p.supno AND cs.itemno = p.itemno)";

ResultSet supplierSum = stmt4.executeQuery(supSum);
ResultSet supProSum = stmt5.executeQuery(proSum);
ResultSet notActiveSupplier = stmt6.executeQuery(notActiveSup);

while (supplierSum.next())
{
	System.out.println("Supplier Number:" + supplierSum.getString("supno")  + ", Name:"  + supplierSum.getString("supname") + ", Location:" + supplierSum.getString("location"));
	System.out.println();
	String currentSupno = supplierSum.getString("supno");
	preparedStatement1.setString(1, currentSupno);
	ResultSet procureDetail = preparedStatement1.executeQuery();
	  System.out.println("TransNo\tDate\t\t\t\tItemNo\t\t\tDesc\t\t\t\t\tQty\t\tTotal_Cost");
	  while (procureDetail.next())
	  {
	  	System.out.println(procureDetail.getString("transno") + "\t" +procureDetail.getString("pdate") + "\t\t" +  procureDetail.getString("itemno") + "\t\t" +  procureDetail.getString("description")+ "\t\t" +  procureDetail.getString("quantity")+ "\t\t" +  procureDetail.getString("total_cost");
	  }
	  System.out.println("Supplier procurements:" + supplierSum.getString("numProcurements") + ", Overall Charge:" + supplierSum.getString("overall_charge") + ", Average Charge:" + supplierSum.getString("average"));
}

while (proSum.next())
{
	System.out.println("Supplier procurements:" + supProSum.getString("quarter_purchases") + ", Overall Charges:" +  supProSum.getString("overall_charge") + ", Average Charge:" +  supProSum.getString("average_charge"));

}

System.out.println("The following suppliers were not active in this period:");
        while (notActiveSupplier.next())
        {
        System.out.println(notActiveSupplier.getString("supno") + "\t" + notActiveSupplier.getString("supname"));
        }
        System.out.println();