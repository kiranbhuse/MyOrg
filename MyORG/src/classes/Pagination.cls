//https://www.minddigital.com/how-to-create-pagination-within-salesforce/

public with sharing class Pagination {
	private integer totalRecs = 0;
	private integer OffsetSize = 0;
	private integer LimitSize= 5;
	private String query;
	
	public Pagination(Integer tr, String q) {
		totalRecs = tr;
		query = q;
	}
	
	public List<DataWrapper> getDatalist() {
		//List<SObject> lstData = Database.Query('SELECT Name, website, AnnualRevenue, description, Type FROM account LIMIT :LimitSize OFFSET :OffsetSize');
		List<SObject> lstData = Database.Query(query);



		return null;
	}
	
	public void FirstPage() {
		OffsetSize = 0;
	}
	
	public void previous() {
		OffsetSize = OffsetSize - LimitSize;
	}
	
	public void next() {
		OffsetSize = OffsetSize + LimitSize;
	}
	
	public void LastPage() {
		OffsetSize = totalrecs - math.mod(totalRecs, LimitSize);
	}
	
	public boolean getprev() {
		if(OffsetSize == 0)
			return true;
		else
		return false;
	}
	
	public boolean getnxt() {
		if((OffsetSize + LimitSize) > totalRecs)
			return true;
		else
			return false;
	}
	
	public class DataWrapper {
		
	}
}