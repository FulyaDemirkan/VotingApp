package ca.sheridancollege.beans;

import java.io.Serializable;

import javax.persistence.Transient;

import lombok.*;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Address implements Serializable {
	private String streetName;
	private String city;
	private String postalCode;
	private String province;
	
	@Transient
	private String[] provinces = {"Alberta", "British Columbia", "Manitoba", "New Brunswick", "Newfoundland and Labrador", "Northwest Territories", "Nova Scotia", "Nunavut", "Ontario", "Prince Edward Island", "Quebec", "Saskatchewan", "Yukon"};
	
	public Address(String streetName, String city, String postalCode, String province) {
		this.streetName = streetName;
		this.city = city;
		this.postalCode = postalCode;
		this.province = province;
	}
}
