public with sharing class mapUtils {

	 /*******************************************************************************************************
	    * @description create a map indexed by a field from a list of SObject
	    * @param listOfObjects the list of SObject that will be used to generate the map 
	    * @param fieldToBeIndexed the API Name of the SObject field that will be used for indexing
	    * @return a map of type Map<String,SObject> which contains the indexed element of listOfObjects
	    * @example
	    *	Validate_Opportunity__mdt configList = [SELECT MasterLabel, Connectivity_Product_uniqueness__c, Opportunity_Uniqueness__c, Valid_Customer_Connectivity__c FROM Validate_Opportunity__mdt];
		*	Map<String, sObject> configMap = mapUtils.createMapOfObjects(configList, 'MasterLabel');
		*	Validate_Opportunity__mdt config = (Validate_Opportunity__mdt) configMap.get('XML');
	    */
	public static Map<String,SObject> createMapOfObjects(SObject[] listOfObjects, String fieldToBeIndexed){
		

		Map<String,SObject> res = new Map<String, SObject>();

		if(listOfObjects == null || listOfObjects.size() == 0){
			return res;
		}

		if(String.isBlank(fieldToBeIndexed)){
			throw new customException('An index field API Name have to be provided');
		}


		for(SObject el: listOfObjects){
			
			String elStringToIndex = (String) el.get(fieldToBeIndexed);

			if(elStringToIndex == null){
				throw new customException('the index field '+ fieldToBeIndexed +' is null for the element: ' + el.Id);
			}
			res.put(elStringToIndex,el);
		}

		return res;
	}

	
	 /*******************************************************************************************************
	    * @description create a map indexed by a field from a list of SObject
	    * @param listOfObjects the list of SObject that will be used to generate the map 
	    * @param fieldToBeIndexed the API Name of the SObject field that will be used for indexing
	    * @return a map of type Map<String,List<SObject>> which contains the indexed element of listOfObjects
	    * @example
	    *  List<Account> sObjectList = new List<Account>();
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

			Map<String,List<Opportunity>> mapRes = (Map<String,List<Opportunity>>) mapUtils.createMapOfList(oppList, 'AccountId');
			System.assertEquals(10, mapRes.get(a1.Id).size());
			System.assertEquals(5, mapRes.get(a2.Id).size());
	    */
	public static Map<String,List<SObject>> createMapOfList(SObject[] listOfObjects, String fieldToBeIndexed){
		

		Map<String, List<SObject>> res = new Map<String, List<SObject>>();

		if(listOfObjects == null || listOfObjects.size() == 0){
			return res;
		}

		if(String.isBlank(fieldToBeIndexed)){
			throw new customException('An index field API Name have to be provided');
		}


		for(SObject el: listOfObjects){
			
			String elStringToIndex = (String) el.get(fieldToBeIndexed);

			if(elStringToIndex == null){
				throw new customException('the index field '+ fieldToBeIndexed +' is null for the element: ' + el.Id);
			}

			List<SObject> resExistingList = res.get(elStringToIndex);
			
			if(resExistingList == null){
				List<SObject> resNewList = new List<SObject>();
				resNewList.add(el);
				res.put(elStringToIndex, resNewList);
			} else {
				res.get(elStringToIndex).add(el);
			}

		}

		return res;
	}

	/**
	 * @description Remove elements that are not contained in a Set
	 * @param inputMap	the map.
	 * @param elementsToLeaveSet the elements that will be leaved in the map. If null, remove all.
	 * @example Map<String,String> stringMap = new Map<String,String>();
	 *	stringMap.put('aKey','aEl');
	*	stringMap.put('bKey','bEl');
	*	Set<String> stringSet = new Set<String>{'bKey'};
	*
	*		try {
	*			mapUtils.removeElementsNotInSet(null, stringSet);
	*		} catch (Exception e) {
	*		system.debug('@@Exception on '+e.getStackTraceString()+' : '+e.getMessage());
	*	}
	*	
	*	mapUtils.removeElementsNotInSet(stringMap, stringSet);
	*	System.assert(!stringMap.containsKey('aKey'));
	*	System.assert(stringMap.containsKey('bKey'));
	 **/
	public static void removeElementsNotInSet (Map<String, Object> inputMap, Set<String> elementsToLeaveSet){
		
		if(inputMap == null){
			throw new customException('The inputMap cannot be null');
		}

		if(elementsToLeaveSet == null){
			inputMap.clear();
			return;
		}

		for(String key: inputMap.keySet()){
            if(!elementsToLeaveSet.contains(key)){
                inputMap.remove(key);
            }
        }
	}
}