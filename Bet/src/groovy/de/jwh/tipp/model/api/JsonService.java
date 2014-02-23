package de.jwh.tipp.model.api;

public interface JsonService {

	void getTeams(String url);
	void getRounds(String url);
	void getRound(String url, int id);
	
}
