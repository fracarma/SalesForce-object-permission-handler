@isTest
private class ObjectPermissionHandlerTest {
	
	@isTest static void getInstanceNoUserIdSystemAdminTest() {
		ObjectPermissionHandler objPermissionHandler = ObjectPermissionHandler.getInstance();

		Boolean res = objPermissionHandler.getUserPermission('Account', 'create');
		System.assertEquals(TRUE, res);
	}

	@isTest static void getInstanceWithUserIdSystemAdminTest() {
		ObjectPermissionHandler objPermissionHandler = ObjectPermissionHandler.getInstance(UserInfo.getUserId());

		Boolean res = objPermissionHandler.getUserPermission('Account', 'create');
		System.assertEquals(TRUE, res);
	}
	
	@isTest
	private static void otherUserRunAsSystemAdminTest() {
		User user = UtilTest.createUser('Chatter Free User');

		insert user;
		
		ObjectPermissionHandler objPermissionHandler = ObjectPermissionHandler.getInstance(user.Id);

		Boolean res = objPermissionHandler.getUserPermission('Account', 'create');
		System.assertEquals(FALSE, res);
	}

	@isTest
	private static void otherUserRunAsChatterTest() {
		User user = UtilTest.createUser('Chatter Free User');

		insert user;
		
		System.runAs(user){
			ObjectPermissionHandler objPermissionHandler = ObjectPermissionHandler.getInstance();

			Boolean res = objPermissionHandler.getUserPermission('Account', 'create');
			System.assertEquals(FALSE, res);
		}

	}

	@isTest
	private static void getUserPermissionMapTest() {
		ObjectPermissionHandler objPermissionHandler = ObjectPermissionHandler.getInstance(UserInfo.getUserId());
		system.debug('@@start ');
		Map<String,Map<String,Boolean>> userPermissionMap = objPermissionHandler.getUserPermissionMap();
		system.debug('@@stop ');
		System.assertEquals(true, userPermissionMap.get('Account').get('view all'));
	}

	@isTest
	private static void getUserPermissionMapChooseObjects() {
		ObjectPermissionHandler objPermissionHandler = ObjectPermissionHandler.getInstance(UserInfo.getUserId());

		Map<String,Map<String,Boolean>> userPermissionMap = objPermissionHandler.getUserPermissionMap(new Set<String>{'Account','Lead'});
		System.assertEquals(true, userPermissionMap.get('Account').get('view all'));
	}

	@isTest
	private static void getUserPermissionMapChatterUserTest() {

		User user = UtilTest.createUser('Chatter Free User');

		insert user;
		
		System.runAs(user){
			ObjectPermissionHandler objPermissionHandler = ObjectPermissionHandler.getInstance(UserInfo.getUserId());

			Map<String,Map<String,Boolean>> userPermissionMap = objPermissionHandler.getUserPermissionMap();
			System.assertEquals(false, userPermissionMap.get('Account').get('view all'));
		}
	}


	@isTest
	private static void coverExceptionTest() {
		Boolean res;

		res = false;
		try{
			ObjectPermissionHandler objPermissionHandler = ObjectPermissionHandler.getInstance(null);
		} catch(customException e){
			res = true;
		}
		
		System.assertEquals(true, res);
		

		res = false;
		try{
			User user = UtilTest.createUser('Chatter Free User');
			//not insert the user
			ObjectPermissionHandler objPermissionHandler = ObjectPermissionHandler.getInstance(null);
		} catch(customException e){
			res = true;
		}
		
		System.assertEquals(true, res);


		ObjectPermissionHandler objPermissionHandler = ObjectPermissionHandler.getInstance();
		
		
		res = false;
		try{
				objPermissionHandler.getUserPermission(null,'create');
			
		} catch(customException e){
			res = true;
		}
		
		System.assertEquals(true, res);

		res = false;
		try{
				objPermissionHandler.getUserPermission('Account',null);
			
		} catch(customException e){
			res = true;
		}
		
		System.assertEquals(true, res);
		res = false;
		try{
				objPermissionHandler.getUserPermission('Asdf','Create');
			
		} catch(customException e){
			res = true;
		}
		
		System.assertEquals(true, res);
		res = false;
		try{
				objPermissionHandler.getUserPermission('Asdf','create');
			
		} catch(customException e){
			res = true;
		}
		
		System.assertEquals(true, res);

		res = false;
		try{
				objPermissionHandler.getUserPermissionMap(new Set<String>{'Asdf'});
			
		} catch(customException e){
			res = true;
		}
		
		System.assertEquals(true, res);


	}

	
	
}