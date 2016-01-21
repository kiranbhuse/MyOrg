public class WebServiceHelper implements IWebService {
	public String getData(String query) {
		LeadOperationsConsume.getContentPost(query);
		
		return null;
	}
}