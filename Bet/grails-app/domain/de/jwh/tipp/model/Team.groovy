package de.jwh.tipp.model

class Team {

	String name
	String code
	byte[] pic
	String picType
	
    static constraints = {
		pic nullable:true,  maxSize: 1024 * 1024 * 5
		picType nullable:true
		code maxLength:3, nullable:false
    }
	
	@Override
	public String toString() {
		return name;
	}
	

}
