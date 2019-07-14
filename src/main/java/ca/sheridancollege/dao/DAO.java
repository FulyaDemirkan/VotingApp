package ca.sheridancollege.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Random;
import java.util.TreeMap;

import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

import com.github.javafaker.Faker;

import ca.sheridancollege.beans.Address;
import ca.sheridancollege.beans.Vote;
import ca.sheridancollege.beans.Voter;

public class DAO {
	
	SessionFactory sessionFactory = new Configuration()
			.configure("hibernate.cfg.xml")
			.buildSessionFactory();
	
	private int voterCount;
	private List<String> parties;
	private List<String> ageGroups;
	
	public DAO()
	{
		parties = new ArrayList<String>();
		parties.add("Liberal Party");
		parties.add("Conservative Party");
		parties.add("New Democratic Party");
		parties.add("Bloc Quebecois");
		parties.add("Green Party");
		
		ageGroups = new ArrayList<String>();
		ageGroups.add("18 - 30");
		ageGroups.add("30 - 45");
		ageGroups.add("45 - 60");
		ageGroups.add("60+");
	}
	
	// INITAL DATA LOAD METHODS
		public void createVoters(int count) {
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			
			Faker faker = new Faker(new Locale("en-CA"));
			
			voterCount = count;
			
			for (int i = 1; i <= voterCount; i++) {
				
				Random r = new Random();
				int randomSin = r.nextInt((999999999 - 100000000) + 1) + 100000000;

				if(!isRegistered(randomSin))
				{
					Voter voter = new Voter(randomSin, faker.name().firstName(), faker.name().lastName(), faker.date().birthday(18, 85), 
							(new Address(faker.address().streetAddress(), faker.address().city(), faker.address().zipCode(), faker.address().state())));
					session.save(voter);
				}
			}
			session.getTransaction().commit();
			session.close();
		}
		
		public void addRandomVotes(int ratio) {
			
			long voteCount = getRegisteredVoterCount() * ratio / 100;
			

			long votes = getVoteCount();
			
			while(votes < voteCount)
			{
				String randParty = getRandomParty();
				int randVoterSin = getRandomVoter();
				
				if(randVoterSin != -1)
				{
					addVote(randVoterSin, randParty);
					votes = getVoteCount();
				}
				else
				{
					break;
				}
			}
		}
		
		private int getRandomVoter()
		{
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			
			int randomSin;

			Query query = session.createQuery("SELECT sin FROM Voter WHERE vote_id IS NULL");
			List<Integer> voterList = (List<Integer>)query.getResultList();
			
			if(voterList.size() > 0)
			{
				int rand = (int) Math.floor(Math.random() * voterList.size());
				randomSin = voterList.get(rand);
			}
			else
			{
				randomSin = -1;
			}
			
			session.getTransaction().commit();
			session.close();
			
			return randomSin;
		}
		
		private String getRandomParty()
		{
			String vote = "";
			
			int rand = (int)Math.floor(Math.random() * 5);
			
			switch (rand) {
			case 0:
				vote = "Liberal Party";
				break;
			case 1:
				vote = "Conservative Party";
				break;
			case 2:
				vote = "New Democratic Party";
				break;
			case 3:
				vote = "Bloc Quebecois";
				break;
			case 4:
				vote = "Green Party";
				break;
			}
			
			return vote;
		}
		
		// MAIN METHODS
		public void addVoter(Voter voter) {
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			
			session.save(voter);
			
			session.getTransaction().commit();
			session.close();
		}
		
		public void addVote(int sin, String party) {
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			
			Vote vote = new Vote(party);
			session.save(vote);
			
			Voter voter = (Voter)session.get(Voter.class, sin);
			voter.setVote(vote);
			
			vote.setVoter(voter);
			
			session.getTransaction().commit();
			session.close();
		}
		
		public Voter getVoter(int sin) {
			Session session = sessionFactory.openSession();
			session.beginTransaction();

			Voter voter = (Voter)session.get(Voter.class, sin);
		
			session.getTransaction().commit();
			session.close();
			
			return voter;
		}
		
		public boolean isEligible(Voter voter) {
			
			return voter.getVote() == null;
		}
		
		public boolean isRegistered(int sin) {
			
			Session session = sessionFactory.openSession();
			session.beginTransaction();

			Voter voter = (Voter)session.get(Voter.class, sin);
		
			session.getTransaction().commit();
			session.close();
			
			return (voter != null);
		}
		
		public List<Voter> getVoters()
		{
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			
			Query query = session.createQuery("FROM Voter");
			List<Voter> voterList = (List<Voter>)query.getResultList();
			
			session.getTransaction().commit();
			session.close();
			
			return voterList;
		}
		
		public long getRegisteredVoterCount()
		{
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			
			CriteriaBuilder cb = session.getCriteriaBuilder();
			CriteriaQuery<Long> criteria = cb.createQuery(Long.class);
			
			Root<Voter> root = criteria.from(Voter.class);
			
			criteria.select(cb.count(root));
			
			long voterCount = session.createQuery(criteria).getSingleResult();
			
			session.getTransaction().commit();
			session.close();
			
			return voterCount;
		}
		
		public long getVoteCount()
		{
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			
			CriteriaBuilder cb = session.getCriteriaBuilder();
			CriteriaQuery<Long> criteria = cb.createQuery(Long.class);
			
			Root<Vote> root = criteria.from(Vote.class);
			
			criteria.select(cb.count(root));
			
			long voteCount = session.createQuery(criteria).getSingleResult();
			
			session.getTransaction().commit();
			session.close();
			
			return voteCount;
		}
		
		public long getNotVotedVoterCount()
		{
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			
			CriteriaBuilder cb = session.getCriteriaBuilder();
			CriteriaQuery<Long> criteria = cb.createQuery(Long.class);
			
			Root<Voter> root = criteria.from(Voter.class);
			
			criteria.select(cb.count(root)).where(cb.isNull(root.get("vote")));
			
			long NotVotedVoterCount = session.createQuery(criteria).getSingleResult();
			
			session.getTransaction().commit();
			session.close();
			
			return NotVotedVoterCount;
		}
		
		public HashMap<String, ArrayList<Float>> getVoteDistributionRatio()
		{
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			
			CriteriaBuilder cb = session.getCriteriaBuilder();
			CriteriaQuery<Long> criteria = cb.createQuery(Long.class);
			
			Root<Vote> root = criteria.from(Vote.class);
			
			HashMap<String, ArrayList<Float>> votingResults = new HashMap<String, ArrayList<Float>>();

			float totalVotes = (float)getVoteCount();
			
			for (int i = 0; i < parties.size(); i++) {
				criteria.select(cb.count(root.get("party"))).where(cb.equal(root.get("party"), parties.get(i)));
				
				float partyVoteCount = (float)session.createQuery(criteria).getSingleResult();
				float percentage = (float)(partyVoteCount / totalVotes);

				ArrayList<Float> voteResults = new ArrayList<Float>();
				voteResults.add(partyVoteCount);
				voteResults.add(percentage);
				
				votingResults.put(parties.get(i), voteResults);
			}
					
			session.getTransaction().commit();
			session.close();
			
			return votingResults;
		}
		
		public Map<String, ArrayList<Float>> getVotedVotersByAgeGroup()
		{
			Session session = sessionFactory.openSession();
			session.beginTransaction();
				
			CriteriaBuilder cb = session.getCriteriaBuilder();
			CriteriaQuery<Long> criteria = cb.createQuery(Long.class);
			Root<Voter> root = criteria.from(Voter.class);
			
			List<String> condition = new ArrayList<String>();
			condition.add("< 30");
			condition.add("BETWEEN 30 AND 45");
			condition.add("BETWEEN 46 AND 60");
			condition.add("> 60");
			
			HashMap<String, ArrayList<Float>> ageDistributionUnOrdered = new HashMap<String, ArrayList<Float>>();
			
			for (int i = 0; i < condition.size(); i++) {
				Query query = session.createQuery("SELECT COUNT(*) FROM Voter WHERE TIMESTAMPDIFF(Year, birthday, CURDATE()) " + condition.get(i) + " AND vote_id IS NOT NULL");
				float VotedAgeCount = Float.parseFloat(query.getSingleResult().toString());
				
				query = session.createQuery("SELECT COUNT(*) FROM Voter WHERE TIMESTAMPDIFF(Year, birthday, CURDATE()) " + condition.get(i));
				float EligibleAgeCount = Float.parseFloat(query.getSingleResult().toString());
				
				float votePercentage = (float)VotedAgeCount / EligibleAgeCount;
				
				ArrayList<Float> ageGroupResults = new ArrayList<Float>();
				ageGroupResults.add(VotedAgeCount);
				ageGroupResults.add(EligibleAgeCount);
				ageGroupResults.add(votePercentage);
				
				ageDistributionUnOrdered.put(ageGroups.get(i), ageGroupResults);
			}
			
			Map<String, ArrayList<Float>> ageDistribution = new TreeMap<String, ArrayList<Float>>(ageDistributionUnOrdered);

			session.getTransaction().commit();
			session.close();
			
			return ageDistribution;
		}
		
		public int editVoter(Voter voter)
		{
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			
			Voter existingVoter = (Voter)session.get(Voter.class, voter.getSin());

			existingVoter.setSin(voter.getSin());
			existingVoter.setFirstName(voter.getFirstName());
			existingVoter.setLastName(voter.getLastName());
			existingVoter.setBirthday(voter.getBirthday());
			existingVoter.setAddress(voter.getAddress());
			
			session.getTransaction().commit();
			session.close();
			
			return existingVoter.getSin();
		}
		
		public int deleteVoterBySin(int sin)
		{
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			
			Query query = session.createQuery("FROM Vote WHERE voter_sin =: sin");
			query.setParameter("sin", sin);
			
			List<Vote> deletedVote = (List<Vote>)query.getResultList();
			if(deletedVote.size() != 0)
			{
				session.delete(deletedVote.get(0));
			}
			
			Voter deletedVoter = (Voter)session.get(Voter.class, sin);
			
			session.delete(deletedVoter);
			
			session.getTransaction().commit();
			session.close();
			
			return sin;
		}
}

