package ca.sheridancollege.beans;

import java.io.Serializable;

import javax.persistence.*;

import lombok.*;

@NoArgsConstructor
@AllArgsConstructor
@Data

@Entity
public class Vote implements Serializable {
	@Id
	@GeneratedValue
	private int id;
	private String party;
	
	@Transient
	private String[] parties = {"Liberal Party","Conservative Party","New Democratic Party","Bloc Quebecois","Green Party"};
	
	@OneToOne
	private Voter voter;
	
	public Vote(String party) {
		this.party = party;
	}
}
