package ca.akarmel.tpm.entities;

public class Customer {
	
	private int id;
	private String FirstName;
	private String LastName;
	private String Address;
	private int CountryId;
	private int ProvinceId;
	private String PostalCode;	
	private String PhoneOne;
	private String PhoneTwo;
	private String Email;
	private String Comments;
	private String Inactive;
	
	public Customer() {
		
	}

	public Customer(int id, String firstName, String lastName, String address, int countryId, int provinceId,
			String postalCode, String phoneOne, String phoneTwo, String email, String comments, String inactive) {
	
		this.id = id;
		this.FirstName = firstName;
		this.LastName = lastName;
		this.Address = address;
		this.CountryId = countryId;
		this.ProvinceId = provinceId;
		this.PostalCode = postalCode;
		this.PhoneOne = phoneOne;
		this.PhoneTwo = phoneTwo;
		this.Email = email;
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

	public String getAddress() {
		return Address;
	}

	public void setAddress(String address) {
		Address = address;
	}

	public int getCountryId() {
		return CountryId;
	}

	public void setCountryId(int countryId) {
		CountryId = countryId;
	}

	public int getProvinceId() {
		return ProvinceId;
	}

	public void setProvinceId(int provinceId) {
		ProvinceId = provinceId;
	}

	public String getPostalCode() {
		return PostalCode;
	}

	public void setPostalCode(String postalCode) {
		PostalCode = postalCode;
	}

	public String getPhoneOne() {
		return PhoneOne;
	}

	public void setPhoneOne(String phoneOne) {
		PhoneOne = phoneOne;
	}

	public String getPhoneTwo() {
		return PhoneTwo;
	}

	public void setPhoneTwo(String phoneTwo) {
		PhoneTwo = phoneTwo;
	}

	public String getEmail() {
		return Email;
	}

	public void setEmail(String email) {
		Email = email;
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