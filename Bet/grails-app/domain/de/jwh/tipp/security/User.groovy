package de.jwh.tipp.security

class User {

	transient springSecurityService

	String username
	String lastname
	String firstname
	String password
	String mail
	Byte[] pic
	String picType
	boolean enabled = true
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired

	static transients = ['springSecurityService']

	static constraints = {
		username blank: false, unique: true
		password blank: false
		mail  email: true , unique:true 
		pic nullable:true,  maxSize: 1024 * 1024 * 10
		picType nullable:true
		lastname blank:false
		firstname blank:false
	}

	static mapping = {
		password column: '`password`'
	}

	Set<Role> getAuthorities() {
		UserRole.findAllByUser(this).collect { it.role } as Set
	}

	def beforeInsert() {
		encodePassword()
	}

	def beforeUpdate() {
		if (isDirty('password')) {
			encodePassword()
		}
	}

	protected void encodePassword() {
		password = springSecurityService.encodePassword(password)
	}
	
	@Override
	public String toString() {
		return username;
	}
}
