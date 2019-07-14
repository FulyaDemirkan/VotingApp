package ca.sheridancollege;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ThreadLocalRandom;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import ca.sheridancollege.beans.Vote;
import ca.sheridancollege.beans.Voter;
import ca.sheridancollege.dao.DAO;


@Controller
public class HomeController {
	DAO dao = new DAO();
	
	@RequestMapping("/")
	public String goHome() {
		return "home";
	}

	// ADD RANDOM VOTERS
	@RequestMapping("/addRandomVoters")
	public String addRandomVoters(Model model, @RequestParam int voterCount)
	{
		dao.createVoters(voterCount);
		
		model.addAttribute("generatedVotersMessage", "Voters are successfully added.");
		
		return "home";
	}
	
	// ADD RANDOM VOTES
	@RequestMapping("/addRandomVotes")
	public String addRandomVotes(Model model, @RequestParam String ratio)
	{
		if(dao.getRegisteredVoterCount() == 0)
		{
			model.addAttribute("generatedVotesMessage", "No vote added: There is no registered voter");
		}
		else if(dao.getNotVotedVoterCount() != 0)
		{
			if(ratio.equals("random"))
			{
				int randomRatio = ThreadLocalRandom.current().nextInt(60, 80 + 1);
				dao.addRandomVotes(randomRatio);
			}
			else
			{
				dao.addRandomVotes(Integer.parseInt(ratio));
			}
			
			model.addAttribute("generatedVotesMessage", "Votes are successfully added.");
		}
		else
		{
			model.addAttribute("generatedVotesMessage", "All the voters are already voted.");
		}
		
		return "home";
	}
		
	// GO TO ADDVOTER
	@RequestMapping("/addVoter")
	public String goAddVoter(Model model)
	{
		Voter voter = new Voter();
		model.addAttribute("voter", voter);
		
		return "addVoter";
	}
	
	// REGISTER A VOTER
	@RequestMapping("/registerVoter")
	public String addVoter(Model model, @ModelAttribute Voter voter)
	{
		if(voter.getSin() >= 100000000 && voter.getSin() <= 999999999)
		{
			if(!dao.isRegistered(voter.getSin()))
			{
				synchronized(Voter.class)
				{
					dao.addVoter(voter);
				}
				
				voter = new Voter();
	            model.addAttribute("addVoterMessage", "Voter is registered.");
			}
			else
			{
				model.addAttribute("addVoterMessage", "A voter with this SIN number is already registered.");
			}
		}
		else
		{
			model.addAttribute("addVoterMessage", "SIN is not valid.");
		}
		
		model.addAttribute("voter", voter);
				
		return "addVoter";
	}
	
	// GO TO VOTING
	@RequestMapping("/voting")
	public String goVoting(Model model)
	{
		Voter voter = null;
		Vote vote = new Vote();
		
		model.addAttribute("voter", voter);
		model.addAttribute("vote", vote);
		
		return "voting";
	}
	
	// SEARCH FOR SIN
	@RequestMapping("/searchSIN")
	public String searchSIN(Model model, @RequestParam int sin)
	{
		Voter voter = dao.getVoter(sin);
	
		if(voter == null)
		{
			model.addAttribute("searchMessage", "This is not a registered SIN!");
		} 
		else if(dao.isEligible(voter))
		{
			model.addAttribute("searchMessage", "");
			model.addAttribute("voter", voter);			
		}
		else if(!dao.isEligible(voter))
		{
			model.addAttribute("searchMessage", "This voter has already voted!");
		}
		
		Vote vote = new Vote();
		model.addAttribute("vote", vote);	
		
		return "voting";
	}

	// ADD A VOTE
	@RequestMapping("/addVote")
	public String addVote(Model model, @ModelAttribute Vote vote, @RequestParam int voterSin)
	{
		dao.addVote(voterSin, vote.getParty());
		
		model.addAttribute("voteMessage", "Your vote is successfully added.");
		
		vote = new Vote();
		
		model.addAttribute("vote", vote);

		return "voting";
	}
	
	// DISPLAY VOTERS
	@RequestMapping("/registeredVoters")
	public String displayRegisteredVoters(Model model)
	{
		List<Voter> voterList = dao.getVoters();

		if(!voterList.isEmpty())
		{
			model.addAttribute("voterList", voterList);
		}
		else
		{
			model.addAttribute("resultMessage", "No registered voters found.");
		}
		
		return "registeredVoters";
	}
	
	// GO EDITVOTER
	@RequestMapping("/edit/{sin}")
	public String goEditVoter(Model model, @PathVariable int sin)
	{
		Voter voter = dao.getVoter(sin);
		if(voter != null)
		{
			model.addAttribute("voter", voter);
			
			return "editVoter";
		}
		else
		{
			List<Voter> voterList = dao.getVoters();

			if(!voterList.isEmpty())
			{
				model.addAttribute("voterList", voterList);
			}
			else
			{
				model.addAttribute("resultMessage", "No registered voters found.");
			}
			
			return "registeredVoters";
		}
	}
	
	// EDIT VOTER
	@RequestMapping("/editVoter")
	public String editVoter(Model model, Voter voter)
	{
		dao.editVoter(voter);
		
		model.addAttribute("voter", voter);
		model.addAttribute("editVoterMessage", "Voter is updated.");
		
		return "editVoter";
	}
	
	// GO DELETEVOTER
	@RequestMapping("/delete/{sin}")
	public String goDeleteVoter(Model model, @PathVariable int sin)
	{
		Voter voter = dao.getVoter(sin);
		if(voter != null)
		{
			model.addAttribute("voter", voter);
			
			return "deleteVoter";
		}
		else
		{
			List<Voter> voterList = dao.getVoters();

			if(!voterList.isEmpty())
			{
				model.addAttribute("voterList", voterList);
			}
			else
			{
				model.addAttribute("resultMessage", "No registered voters found.");
			}
			
			return "registeredVoters";
		}
	}
		
	// DELETE VOTER
	@RequestMapping("/deleteVoter")
	public String deleteVoterBySin(Model model, Voter voter)
	{
		dao.deleteVoterBySin(voter.getSin());
		
		voter = new Voter();
		model.addAttribute("voter", voter);
		model.addAttribute("deleteVoterMessage", "Voter is deleted.");
		
		return "deleteVoter";
	}	
	
	// DISPLAY STATS
	@RequestMapping("/stats")
	public String displayStats(Model model)
	{
		HashMap<String, ArrayList<Float>> voteResults = dao.getVoteDistributionRatio();
		model.addAttribute("voteResults", voteResults);
		
		float votePercentage = (float)dao.getVoteCount() / dao.getRegisteredVoterCount();
		model.addAttribute("votePercentage", votePercentage);
		
		Map<String, ArrayList<Float>> ageDistribution = dao.getVotedVotersByAgeGroup();
		model.addAttribute("ageDistribution", ageDistribution);
		
		return "stats";
	}
}
