@isTest
private class mapUtilsTest {
	@isTest
	private static void createMapOfListTest() {
		List<Account> sObjectList = new List<Account>();
		Account a1 = AccountUtils.createDefaultTestAccount();
		Account a2 = AccountUtils.createDefaultTestAccount();

		insert a1;
		insert a2;
		List<Opportunity> oppList = new List<Opportunity>();
		
		for(Integer i = 0; i < 10; i++) {
			Opportunity opp = OpportunityUtils.createDefaultTestOpportunity();
			opp.AccountId = a1.Id;
			oppList.add(opp);
		}
		for(Integer i = 0; i < 5; i++) {
			Opportunity opp = OpportunityUtils.createDefaultTestOpportunity();
			opp.AccountId = a2.Id;
			oppList.add(opp);
		}
		
		Map<String,List<Opportunity>> mapResBlank = (Map<String,List<Opportunity>>) mapUtils.createMapOfList(null, 'AccountId');
		System.assertEquals(0, mapResBlank.keyset().size());
		
		Map<String,List<Opportunity>> mapRes = (Map<String,List<Opportunity>>) mapUtils.createMapOfList(oppList, 'AccountId');
		System.assertEquals(10, mapRes.get(a1.Id).size());
		System.assertEquals(5, mapRes.get(a2.Id).size());

	}	

	@isTest
	private static void createMapOfListTestToFail() {
		List<Account> sObjectList = new List<Account>();
		Account a1 = AccountUtils.createDefaultTestAccount();
		Account a2 = AccountUtils.createDefaultTestAccount();

		insert a1;
		insert a2;
		List<Opportunity> oppList = new List<Opportunity>();
		
		for(Integer i = 0; i < 10; i++) {
			Opportunity opp = OpportunityUtils.createDefaultTestOpportunity();
			opp.AccountId = a1.Id;
			oppList.add(opp);
		}
		for(Integer i = 0; i < 5; i++) {
			Opportunity opp = OpportunityUtils.createDefaultTestOpportunity();
			opp.AccountId = a2.Id;
			oppList.add(opp);
		}

		Boolean res = false;
		try{
			Map<String,List<Opportunity>> mapRes = (Map<String,List<Opportunity>>) mapUtils.createMapOfList(oppList, '');
		} catch(CustomException e){
			res = true;
		}

		System.assertEquals(true, res);

		res = false;
		
		try {
			oppList[0].AccountId = null;
			Map<String,List<Opportunity>> mapRes = (Map<String,List<Opportunity>>) mapUtils.createMapOfList(oppList, 'AccountId');
		} catch (CustomException e) {
			system.debug('@@Exception on '+e.getStackTraceString()+' : '+e.getMessage());
			res = true;
		}
		System.assertEquals(true, res);

	}

	@isTest
	private static void createMapOfObjectsTest() {
		List<Account> sObjectList = new List<Account>();
		Account a1 = AccountUtils.createDefaultTestAccount();
		Account a2 = AccountUtils.createDefaultTestAccount();

		insert a1;
		insert a2;
		List<Opportunity> oppList = new List<Opportunity>();
		
		for(Integer i = 0; i < 10; i++) {
			Opportunity opp = OpportunityUtils.createDefaultTestOpportunity();
			opp.AccountId = a1.Id;
			oppList.add(opp);
		}
		for(Integer i = 0; i < 5; i++) {
			Opportunity opp = OpportunityUtils.createDefaultTestOpportunity();
			opp.AccountId = a2.Id;
			oppList.add(opp);
		}
		
		Map<String,sObject> mapResBlank = mapUtils.createMapOfObjects(null, 'AccountId');
		System.assertEquals(0, mapResBlank.keyset().size());
		
		Map<String,sObject> mapRes = mapUtils.createMapOfObjects(oppList, 'AccountId');
		System.assertNotEquals(null, mapRes.get(a1.Id));
		System.assertNotEquals(null, mapRes.get(a2.Id));

	}

	@isTest
	private static void createMapOfObjectsTestToFail() {
		List<Account> sObjectList = new List<Account>();
		Account a1 = AccountUtils.createDefaultTestAccount();
		Account a2 = AccountUtils.createDefaultTestAccount();

		insert a1;
		insert a2;
		List<Opportunity> oppList = new List<Opportunity>();
		
		for(Integer i = 0; i < 10; i++) {
			Opportunity opp = OpportunityUtils.createDefaultTestOpportunity();
			opp.AccountId = a1.Id;
			oppList.add(opp);
		}
		for(Integer i = 0; i < 5; i++) {
			Opportunity opp = OpportunityUtils.createDefaultTestOpportunity();
			opp.AccountId = a2.Id;
			oppList.add(opp);
		}

		Boolean res = false;
		try{
			Map<String,sObject> mapRes = mapUtils.createMapOfObjects(oppList, '');
		} catch(CustomException e){
			res = true;
		}

		System.assertEquals(true, res);

		res = false;
		
		try {
			oppList[0].AccountId = null;
			Map<String,sObject> mapRes = mapUtils.createMapOfObjects(oppList, 'AccountId');
		} catch (CustomException e) {
			system.debug('@@Exception on '+e.getStackTraceString()+' : '+e.getMessage());
			res = true;
		}
		System.assertEquals(true, res);

	}

	@isTest
	private static void removeElementsNotInTest() {
		Map<String,String> stringMap = new Map<String,String>();
		stringMap.put('aKey','aEl');
		stringMap.put('bKey','bEl');
		Set<String> stringSet = new Set<String>{'bKey'};

		try {
			mapUtils.removeElementsNotInSet(null, stringSet);
		} catch (Exception e) {
			system.debug('@@Exception on '+e.getStackTraceString()+' : '+e.getMessage());
		}
		
		mapUtils.removeElementsNotInSet(stringMap, stringSet);
		System.assert(!stringMap.containsKey('aKey'));
		System.assert(stringMap.containsKey('bKey'));
		
		mapUtils.removeElementsNotInSet(stringMap, null);
		System.assert(!stringMap.containsKey('bKey'));

	}	
}