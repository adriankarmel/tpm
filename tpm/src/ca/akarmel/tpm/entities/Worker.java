package ca.akarmel.tpm.entities;

public class Worker {
	
	private int id;
	private String FirstName;
	private String LastName;
	private String Email;
	private String Phone;
	private String HourRate;
	private String Category;
	private String Comments;	
	private String Inactive;
	
	public Worker() {
		
	}

	public Worker(int id, String firstName, String lastName, String email, String phone, String hourRate,
			String category, String comments, String inactive) {
		this.id = id;
		this.FirstName = firstName;
		this.LastName = lastName;
		this.Email = email;
		this.Phone = phone;
		this.HourRate = hourRate;
		this.Category = category;
		this.Comments = comments;
		this.Inactive = inactive;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFirstName() {
		return FirstName;
	}

	public void setFirstName(String firstName) {
		FirstName = firstName;
	}

	public String getLastName() {
		return LastName;
	}

	public void setLastName(String lastName) {
		LastName = lastName;
	}

	public String getEmail() {
		return Email;
	}

	public void setEmail(String email) {
		Email = email;
	}

	public String getPhone() {
		return Phone;
	}

	public void setPhone(String phone) {
		Phone = phone;
	}

	public String getHourRate() {
		return HourRate;
	}

	public String getCategory() {
		return Category;
	}

	public void setCategory(String category) {
		Category = category;
	}

	public void setHourRate(String hourRate) {
		HourRate = hourRate;
	}

	public String getComments() {
		return Comments;
	}

	public void setComments(String comments) {
		Comments = comments;
	}

	public String getInactive() {
		return Inactive;
	}

	public void setInactive(String inactive) {
		Inactive = inactive;
	}
}