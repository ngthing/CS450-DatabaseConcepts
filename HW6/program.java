import java.sql.*;  //Import the java SQL library

class MyProg     //Create a new class to encapsulate the program
{
 
 public static void SQLError (Exception e)   //Our function for handling SQL errors
 {
	System.out.println("ORACLE error detected:");
	e.printStackTrace();	
 }

public static void main (String args[])  //The main function
{

 try {                                        //Keep an eye open for errors
       
       String driverName = "oracle.jdbc.driver.OracleDriver";
       Class.forName(driverName);

       System.out.println("Connecting   to Oracle...");  

       String url = "jdbc:oracle:thin:@apollo.ite.gmu.edu:1521:ite10g";
       Connection conn = DriverManager.getConnection(url,"tnguy138","Raltiv");

       System.out.println("Connected!");

// First Report       
       Statement stmt = conn.createStatement();   //Create a new statement
       Statement stmt1 = conn.createStatement();
	Statement stmt2 = conn.createStatement(); 
	Statement stmt3 = conn.createStatement(); 
       //Now we execute our query and store the results in the myresults object:
       System.out.println("Customer Activity for the Quarter April 1 - June 30, 2016"); // Print report header
	 System.out.println();
	String cusDetail = "SELECT  p.purdate, i.itemno, i.description, i.price, i.shipcost,p.quantity, (i.price*p.quantity) as total_price, (i.shipcost*p.quantity) as total_shipping, (i.price*p.quantity + i.shipcost*p.quantity) as overall_charge, p.cardno as credit_card FROM  Purchase p, Items i WHERE p.purdate >= to_date('160401','YYMMDD') AND p.purdate <= to_date('160630','YYMMDD') AND p.cusno = ? AND i.itemno = p.itemno";

	String cusSum = "SELECT c.cusno,c.cname, c.address, SUM(p.quantity) as customer_purchases, SUM(p.quantity*(i.price+i.shipcost)) as overall_charge,(SUM(p.quantity*(i.price+i.shipcost))/SUM(p.quantity)) as average_charge FROM Customers c, Purchase p, Items i WHERE p.purdate >= to_date('160401','YYMMDD') AND p.purdate <= to_date('160630','YYMMDD') AND c.cusno = p.cusno AND i.itemno = p.itemno GROUP BY c.cusno,c.cname, c.address";
	String qsum = "SELECT SUM(p.quantity) as quarter_purchases, SUM(p.quantity*(i.price+i.shipcost)) as overall_charge, (SUM(p.quantity*(i.price+i.shipcost))/SUM(p.quantity)) as average_charge FROM Customers c, Purchase p, Items i WHERE p.purdate >= to_date('160401','YYMMDD') AND p.purdate <= to_date('160630','YYMMDD') AND c.cusno = p.cusno AND i.itemno = p.itemno";

	String notactive = "SELECT c.cusno, c.cname FROM Customers c WHERE c.cusno NOT IN (SELECT c.cusno FROM Customers c, Purchase p WHERE p.purdate >= to_date('160401','YYMMDD') AND p.purdate <= to_date('160630','YYMMDD') AND c.cusno = p.cusno)";
	PreparedStatement preparedStatement = null;
	preparedStatement = conn.prepareStatement(cusDetail);
      	ResultSet custPurchaseSum = stmt1.executeQuery(cusSum);
	ResultSet quarterSum = stmt2.executeQuery(qsum);	
   	ResultSet notActiveCust = stmt3.executeQuery(notactive); 
	
	 while (custPurchaseSum.next()) //pass to the next row and loop until the last 
       {
	System.out.println("Customer Number:" + custPurchaseSum.getString("cusno") + ", Name:" +  custPurchaseSum.getString("cname") + ", Address:" +  custPurchaseSum.getString("address")); //Print the current row
	System.out.println();
	String currentCusno = custPurchaseSum.getString("cusno");
	preparedStatement.setString(1,currentCusno);
	ResultSet custPurchaseDetail = preparedStatement.executeQuery(); 

	System.out.println("Date\t\t\tItemNo\t\tDesc\t\t\t\t\tPrice\tShip\tQty\tT_Price\tT_Ship\tTotal\tCredit");
	while (custPurchaseDetail.next() )
	{
	System.out.println(custPurchaseDetail.getString("purdate") + "\t" +  custPurchaseDetail.getString("itemno") + "\t" +  custPurchaseDetail.getString("description")+ "\t" +  custPurchaseDetail.getString("price")+ "\t" +  custPurchaseDetail.getString("shipcost")+ "\t" +  custPurchaseDetail.getString("quantity")+ "\t" +  custPurchaseDetail.getString("total_price")+ "\t" +  custPurchaseDetail.getString("total_shipping")+ "\t" +  custPurchaseDetail.getString("overall_charge")+ "\t" +  custPurchaseDetail.getString("credit_card")); //Print the current row
	
	}
	System.out.println("Customer Purchases:" + custPurchaseSum.getString("customer_purchases") + ", Overall Charges:" +  custPurchaseSum.getString("overall_charge") + ", Average Charge:" +  custPurchaseSum.getString("average_charge"));	
        System.out.println();
	}
	
	while( quarterSum.next()) 
	{
	System.out.println("Quarter Purchases:" + quarterSum.getString("quarter_purchases") + ", Overall Charges:" +  quarterSum.getString("overall_charge") + ", Average Charge:" +  quarterSum.getString("average_charge"));		
 	}
	System.out.println("The following customers were not active in this period:");
	while (notActiveCust.next())
	{
	System.out.println(notActiveCust.getString("cusno") + "\t" + notActiveCust.getString("cname"));
	}
	System.out.println();
	
// Second report: 
	System.out.println("Supplier Activity in the Quarter April 1 - June 30, 2015");
	System.out.println();
	Statement stmt4 = conn.createStatement(); 
	Statement stmt5 = conn.createStatement(); 
	Statement stmt6 = conn.createStatement(); 
	String supSum = "SELECT s.supno, s.supname, s.location, SUM(p.quantity) as numProcurements, SUM(p.quantity*(cs.cost)) as overall_charge, (SUM(p.quantity*(cs.cost))/SUM(p.quantity)) as average  FROM Suppliers s, Procurement p, Items i, canSupply cs  WHERE p.pdate >= to_date('160401','YYMMDD') AND p.pdate <= to_date('160630','YYMMDD') AND p.supno = s.supno AND p.itemno = i.itemno AND cs.supno = p.supno AND cs.itemno = p.itemno GROUP BY s.supno, s.supname, s.location";
	String supDetail = "SELECT DISTINCT p.supno, p.transno, p.pdate, i.itemno, i.description, p.quantity, p.quantity*cs.cost as total_cost FROM Suppliers s, Procurement p, Items i, canSupply cs WHERE p.pdate >= to_date('160401','YYMMDD') AND p.pdate <= to_date('160630','YYMMDD') AND p.supno = ? AND p.itemno = i.itemno AND cs.supno = p.supno AND cs.itemno = p.itemno";
	PreparedStatement preparedStatement1 = null;
	preparedStatement1 = conn.prepareStatement(supDetail);
	String proSum = "SELECT	SUM(p.quantity) as quarter_purchases, SUM(p.quantity*cs.cost) as overall_charge, (SUM(p.quantity*cs.cost)/SUM(p.quantity)) as average_charge FROM Suppliers s, Procurement p, Items i, canSupply cs  WHERE p.pdate >= to_date('160401','YYMMDD') AND p.pdate <= to_date('160630','YYMMDD') AND p.supno = s.supno AND p.itemno = i.itemno AND cs.supno = p.supno AND cs.itemno = p.itemno";
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
	  System.out.println("TransNo\tDate\t\t\tItemNo\t\tDesc\t\t\t\t\tQty\t\tTotal_Cost");
	  while (procureDetail.next())
	  {
	  System.out.println(procureDetail.getString("transno") + "\t" +procureDetail.getString("pdate") + "\t" +  procureDetail.getString("itemno") + "\t" +  procureDetail.getString("description")+ "\t" +  procureDetail.getString("quantity")+ "\t\t" +  procureDetail.getString("total_cost"));  
	
	}
	  System.out.println("Supplier procurements:" + supplierSum.getString("numProcurements") + ", Overall Charge:" + supplierSum.getString("overall_charge") + ", Average Charge:" + supplierSum.getString("average"));
	System.out.println();
	}
	while (supProSum.next())
	{
	System.out.println("Supplier procurements:" + supProSum.getString("quarter_purchases") + ", Overall Charges:" +  supProSum.getString("overall_charge") + ", Average Charge:" +  supProSum.getString("average_charge"));

	}
	System.out.println();	
	System.out.println("The following suppliers were not active in this period:");
        while (notActiveSupplier.next())
        {
        System.out.println(notActiveSupplier.getString("supno") + "\t" + notActiveSupplier.getString("supname"));
        }
        System.out.println();
	
        conn.close();  // Close our connection.

      }
       catch (Exception e) {SQLError(e);} //if any error occurred in the try..catch block, call the SQLError function

}
}

