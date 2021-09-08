/**
 * MergingService
 *
 *
 * @history
 *
 * Date       | Version | Remarks
 * ---------- | ------- | -----------------------------------------
 * 25/09/2018 |  1.0.0  | 
 *
 *
 **/
public class MergingService {
    
    public static Map<Id, String> mergeFields(String body, List<SObject> objetList, String objectAPIName)
    {
        Map<Id, String> bodiesBySobjectId = new Map<Id, String>();

        if(objetList.size()==0)
            return bodiesBySobjectId;

        Map<String, String> data = new Map<String, String>();

        SET<ID> listIds = new SET<ID>();
        for(SObject sobj : objetList)
        {
            listIds.add(((Id)sobj.get('Id')));
        }
        
        Map<String,Schema.SObjectField> fields = objetList.get(0).getSObjectType().getDescribe().fields.getMap();
        String sobjectName = objetList.get(0).getSObjectType().getDescribe().getName();
        String query = 'SELECT ';
        for(Integer i = 0 ; i < fields.values().size(); i++)
        {
            query += fields.values().get(i).getDescribe().getName();    
            if(i != fields.values().size()-1)
                query+=', ';
        }
        query += ' FROM ' + sobjectName + ' WHERE ID IN :listIds';
        
        system.debug('query : ' + query);
        
        Map<Id, SObject> current_sobj_with_fields = new Map<Id, SObject>(Database.query(query));
        
        for(Id key : current_sobj_with_fields.keySet())
        {
            SObject current_sobj = current_sobj_with_fields.get(key);
            data = new Map<String, String>();
            
            for(Schema.SObjectField field : fields.values())
            {
                String fieldName = field.getDescribe().getName();
                data.put((sobjectName+'.'+fieldName).toUpperCase(), String.valueOf(current_sobj.get(fieldName)));
            }
            
            bodiesBySobjectId.put(key,merging(body,data,objectAPIName));
        }
        
        return bodiesBySobjectId;
    }
    
    private static String merging(String body,Map<String,String> obj, String objectAPIName)
    {
        //[A-Za-z_.]
        Matcher m = Pattern.compile('(\\{![a-zA-Z][a-zA-Z0-9_.]+\\})').matcher(body);
        System.debug('the map  : ' + obj);
        while(m.find())
        {

            String merge_field = m.group(0);
            String merge_field_upper = merge_field.toUpperCase();
            String field = merge_field_upper.substring(2,merge_field_upper.length()-1);
            system.debug(field);
            String objectName = (field.split('\\.')).get(0);
            String value;
            value = (String) obj.get(field);

            if(value!=null)
                body = body.replace(merge_field,value);
            else if(objectName.toUpperCase() == objectAPIName.toUpperCase())
                body = body.replace(merge_field,'');
        }
        system.debug('---> body: ' + body);
        return body;
    }
    
}