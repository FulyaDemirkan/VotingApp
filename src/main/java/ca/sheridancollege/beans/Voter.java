package ca.sheridancollege.beans;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Embedded;
import javax.validation.constraints.NotBlank;

import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;

import lombok.*;

@NoArgsConstructor
@AllArgsConstructor
@Data

@Entity
public class Voter implements Serializable {
	@Id
	private int sin;
	
	private String firstName;
	private String lastName;
	private Date birthday;
	
	@Embedded
	private Address Address;
	
	@OneToOne
	private Vote vote;

	public Voter(int sin, String firstName, String lastName, Date birthday, ca.sheridancollege.beans.Address address) {
		this.sin = sin;
		this.firstName = firstName;
		this.lastName = lastName;
		this.birthday = birthday;
		Address = address;
	}
}
