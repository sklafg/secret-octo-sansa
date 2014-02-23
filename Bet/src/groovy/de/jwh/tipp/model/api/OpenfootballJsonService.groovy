package de.jwh.tipp.model.api

import groovy.json.JsonSlurper;

class OpenfootballJsonService implements JsonService {

	@Override
	public void getTeams(String url) {
		def jsonSlurper = new JsonSlurper();
		def reader = new BufferedReader()
		def parsedData = jsonSlurper.parseText(url);
		
	}

	@Override
	public void getRounds(String url) {
		// TODO Auto-generated method stub

	}

	@Override
	public void getRound(String url, int id) {
		// TODO Auto-generated method stub

	}
}
