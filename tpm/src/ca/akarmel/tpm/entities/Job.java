package ca.akarmel.tpm.entities;

public class Job {

	private int id;
	private int customer_id;
	private String customerName;
	private String custAddress;
	private String custPhoneOne;
	private String date;
	private String notes;
	
	public Job(){		
	}
	public Job(int id, int customer_id, String customerName, String custAddress, String custPhoneOne, String date, String notes) {
		this.id = id;
		this.customer_id = customer_id;
		this.customerName = customerName;
		this.custAddress = custAddress;
		this.custPhoneOne = custPhoneOne;
		this.date = date;
		this.notes = notes;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getCustomer_id() {
		return customer_id;
	}

	public void setCustomer_id(int customer_id) {
		this.customer_id = customer_id;
	}	

	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public String getCustAddress() {
		return custAddress;
	}
	public void setCustAddress(String custAddress) {
		this.custAddress = custAddress;
	}	
	public String getCustPhoneOne() {
		return custPhoneOne;
	}
	public void setCustPhoneOne(String custPhoneOne) {
		this.custPhoneOne = custPhoneOne;
	}
	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}
}
