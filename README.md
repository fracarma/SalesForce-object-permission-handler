# SalesForce-object-permission-handler

Class that contains methods to retrieve SObject Permissions for a specific user. Useful in Custom VisualForce Pages to create *maintainable* rendered condition.
It uses a Singleton pattern to avoid query repeating.


## Technical Documentation

### `public with sharing class ObjectPermissionHandler`

### `public static ObjectPermissionHandler getInstance()`

 * **Returns:** the instance of ObjectPermissionHandler with the current user set

### `public static ObjectPermissionHandler getInstance(Id userId)`

 * **Returns:** the instance of ObjectPermissionHandler

### `public Boolean getUserPermission(String objectAPIName, String permission)`

 * **Parameters:**
   * `objectAPIName` — the API name of the object
   * `permission` — which kind of permission we are checking. Accepted values are 'create','read','edit','delete','view all','modify all'.
 * **Returns:** return true if the specified user has the specified permission for that object

### `public Map<String,Map<String,Boolean>> getUserPermissionMap ()`

 * **Returns:** The map is intended to be used on two step: 1. Choose object 2. Choose permission type.

     Pay attention: both object name and permission type are case sensitive!

     accepted value for permission type are 'create','read','edit','delete','view all','modify all'.
 * **Example:**    
```
ObjectPermissionHandler objPermissionHandler = ObjectPermissionHandler.getInstance();
Map<String,Map<String,Boolean>> userPermissionMap = objPermissionHandler.getUserPermissionMap();
System.assertEquals(false, userPermissionMap.get('Account').get('view all'));
```
