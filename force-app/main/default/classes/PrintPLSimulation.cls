public class PrintPLSimulation{
    
    public Contact contact {get; set;}
    public Simulation__c simulation {get; set;}
    public Map<String, Object> values {get; set;}
    
    List<Schema.SObjectField>  objectFields;
    public Map<String, String> fieldsName {get; set;}
    Map<String, String> fieldsNameByObject {get; set;}
    List<String> fieldsFound;
    
    public Layout layout {get; set;}
    
    List<String> fieldsToRemove; //List of all fields to remove from layout
    
    public Map<String, String> fieldsType {get; set;} //Field.Name --> Field.Type
    
    public Map<String, String> fieldsHelpText {get; set;} //Field.Name --> Field.HelpText
    
    
    public PrintPLSimulation(ApexPages.StandardController stdCtrl) {
        simulation = (Simulation__c) stdCtrl.getRecord();
        
        if(simulation != NULL) {
            simulation = [SELECT Contact__c
                          FROM Simulation__c 
                          WHERE Id = : simulation.Id];
            
            if(simulation.Contact__c != NULL){
                //Layout & stuffs
                fieldsFound = new List<String>();
                layout = new Layout('Contact & Simulation Layout');
                getLayout();
                
                //Fields
                fieldsName = new Map<String, String>();
                fieldsNameByObject = new Map<String, String>();
                getContactFields();
                getSimulationFields();
                
                //Values
                values = new Map<String, Object>();
                getValues();
            }
        }
    }
    
    public void getContactFields() {
        fieldsType = new Map<String, String>();
        fieldsHelpText = new Map<String, String>();
        
        String query = 'SELECT ';
        objectFields = Schema.getGlobalDescribe().get('Contact').getDescribe().fields.getMap().Values();
        
        //Fields' names
        for (Schema.SObjectField field : objectFields) {
            String name = field.getDescribe().getName();
            
            if (fieldsFound.contains(name)) {
                query += name + ', ';
                fieldsName.put(name, field.getDescribe().getLabel().replace('ID', ''));
                fieldsNameByObject.put(name, 'Contact');
                
                //Check Field's type
                if (String.valueof(field.getDescribe().getType()) == 'REFERENCE') {
                    if (field.getDescribe().isCustom()) name = name.replace('__c', '__r');
                    else name = name.replace('Id', '');
                    name += '.Name';
                    query += name + ', ';
                    fieldsName.put(name, field.getDescribe().getLabel().replace('ID', ''));
                    fieldsNameByObject.put(name, 'Contact');
                }
                
                //SAVE FIELD'S TYPE
                fieldsType.put(name, String.valueof(field.getDescribe().getType()));
                
                //SAVE FIELD'S HELP TEXT
                String helpText = String.valueOf(field.getDescribe().getInlineHelpText());
                if(helpText == NULL) helpText = '';
                fieldsHelpText.put(name, helpText);
            }
        }
        
        //Remove last comma
        if (query.substring(query.length() - 2, query.length()) == ', ') {
            query = query.substring(0, query.length() - 2);
        }
        
        //CONTACT OWNER INFORMATIONS
        query += ', Owner.Email, Owner.MobilePhone, Owner.Phone, Owner.Street, Owner.City, Owner.Country ';
        
        //FROM
        query += ' FROM Contact ';
        
        //WHERE
        query += ' WHERE id = \'' + simulation.Contact__c + '\'';
        System.debug('**** Query: ' + query);
        
        //Execute query
        try {
            contact = database.query(query);
        } catch (QueryException ex) {
            System.debug('ERROR!!!! ' + ex.getMessage());
        }
        
    }
    
    
    public void getSimulationFields() {
        String query = 'SELECT ';
        objectFields = Schema.getGlobalDescribe().get('Simulation__c').getDescribe().fields.getMap().Values();
        
        //Fields' names
        for (Schema.SObjectField field : objectFields) {
            String name = field.getDescribe().getName();
            
            if (fieldsFound.contains(name) && name != 'Name' && name != 'OwnerId' && name != 'MCI_User_ID__c') {
                query += name + ', ';
                fieldsName.put(name, field.getDescribe().getLabel().replace('ID', ''));
                fieldsNameByObject.put(name, 'Simulation');
                
                //Check Field's type
                if (String.valueof(field.getDescribe().getType()) == 'REFERENCE') {
                    if (field.getDescribe().isCustom()) name = name.replace('__c', '__r');
                    else name = name.replace('Id', '');
                    name += '.Name';
                    query += name + ', ';
                    fieldsName.put(name, field.getDescribe().getLabel().replace('ID', ''));
                    fieldsNameByObject.put(name, 'Simulation');
                }
                
                //SAVE FIELD'S TYPE
                fieldsType.put(name, String.valueof(field.getDescribe().getType()));
                
                //SAVE FIELD'S HELP TEXT
                String helpText = String.valueOf(field.getDescribe().getInlineHelpText());
                if(helpText == NULL) helpText = '';
                fieldsHelpText.put(name, helpText);
            }
        }
        
        //Remove last comma
        if (query.substring(query.length() - 2, query.length()) == ', ') {
            query = query.substring(0, query.length() - 2);
        }
        
        //FROM
        query += ' FROM Simulation__c';
        
        //WHERE
        query += ' WHERE Id =\'' + simulation.Id +'\'';
        System.debug('**** Query: ' + query);
        
        //Execute query
        try {
            simulation = database.query(query);
        } catch (QueryException ex) {
            System.debug('ERROR!!!! ' + ex.getMessage());
        }
        
    }
    
    public void getValues() {
        System.debug('*** GET VALUES');
        fieldsToRemove = new List<String>();
        
        sObject obj;
        for (String field : fieldsName.KeySet()) {
            System.debug('--> field : ' + field);
            Object value = NULL;
            if(fieldsNameByObject.get(field) == 'Contact') obj = contact;
            else if(fieldsNameByObject.get(field) == 'Simulation' && simulation != NULL) obj = simulation;
            else continue;
            
            if(obj != NULL){
                if (field.Contains('__r')) {
                    field = field.replace('.Name', '');
                    if (obj.get(field.replace('__r', '__c')) != NULL) {
                        value = obj.getSObject(field).get('Name');
                    }
                    field = field.replace('__r', '__c');
                } else if (field.Contains('.Name')) {
                    if (contact.get(field.replace('.Name', 'Id')) != NULL) {
                        value = obj.getSObject(field.replace('.Name', '')).get('Name');
                    }
                    field = field.replace('.Name', '');
                    field += 'Id';
                } else value = obj.get(field);
                
                //if(value == NULL) value = 'emptyValue';
                System.debug('--> value : ' + value);
                
                //CHECK VALUE IF NULL OR EMPTY OR EQUALS ZERO, AUCUN OR FALSE
                if (value == NULL || value == '' || value == 'Non requis' || value == 'Aucun' || value == 0 || value == false) {
                    fieldsToRemove.add(field);
                    System.debug('+ fields to remove');
                } 
                else if (fieldsType.get(field) == 'PERCENT') value += '%';
                else if (fieldsType.get(field) == 'CURRENCY') value = toCurrency(String.valueOf(value));
                else if(fieldsType.get(field) == 'DATE') value = toDate(String.valueOf(value));
                else if(fieldsType.get(field) == 'BOOLEAN') value = 'Oui';
                
                values.put(field, value);
            }
        }
        
        rebuildLayout();
    }
    
    
    public void getLayout() {
        List<String> layoutsName = new List<String> {Label.Contact_Layout_FullName, Label.Simulation_Layout_FullName};
            
            List<Metadata.Metadata> mtLayouts =
            Metadata.Operations.retrieve(Metadata.MetadataType.Layout, layoutsName);
        for(Metadata.Metadata mtLayout : mtLayouts) layout.sections.addAll(getSections(((Metadata.Layout) mtLayout).layoutSections));
    }
    
    public List<Section> getSections(List<Metadata.LayoutSection> lySections) {
        List<Section> sections = new List<Section>();
        
        //SECTIONS TO HIDE
        List<String> sectionsToHide = Label.Recap_SectionsToHide.split(',');
        
        for (Metadata.LayoutSection lySection : lySections) {
            if (!sectionsToHide.contains(lySection.label)) {
                Section section = new Section(lySection.label, lySection.detailHeading, lySection.editHeading, lySection.style + '');
                section.columns = getColumn(lySection.layoutColumns);
                
                //IF CONTACT INFORMATION  ---> CHANGE LABEL
                if (lySection.label == 'Contact Information' || lySection.label == 'Informations sur le contact') section.Label = 'INFOS CLIENT';
                
                sections.add(section);
            }
        }
        return sections;
    }
    
    public List<Column> getColumn(List<Metadata.LayoutColumn> lyColumns) {
        List<Column> columns = new List<Column>();
        for (Metadata.LayoutColumn lyColumn : lyColumns) {
            List<String> fields = getColumnFields(lyColumn.layoutItems);
            if (fields.size() > 0) {
                columns.add(new Column(fields));
            }
        }
        return columns;
    }
    
    public List<String> getColumnFields(List<Metadata.LayoutItem> lyItems) {
        List<String> fields = new List<String>();
        if (lyItems != NULL) {
            for (Metadata.LayoutItem item : lyItems) {
                //if(item.emptySpace!=NULL) item.field = 'emptySpace';
                if (item.field != NULL) fields.add(item.field);
            }
        }
        fieldsFound.addAll(fields);
        return fields;
    }
    
    
    
    // RE-BUILD LAYOUT'S SECTIONS: REMOVE ALL COLUMNS WHICH HAVE FIELDS WITH EMPTY VALUE AND HIDE SECTION WITH NO FIELDS
    // NESTED LOOP :/
    public void rebuildLayout() {
        System.debug('rebuildLayout');
        for (Section section : layout.Sections) {
            List<Column> columnsToRemove = new List<Column>();
            for (Column col : section.Columns) {
                for (String field : fieldsToRemove) {
                    System.debug('field : ' + field);
                    Integer index = col.fields.indexOf(field);
                    System.debug('index : ' + index);
                    if (index != -1) col.fields.remove(index);
                }
                
                if (col.fields.size() == 0) columnsToRemove.add(col);
            }
            
            for (Column col : columnsToRemove) {
                Integer index = section.columns.indexOf(col);
                if (index != -1) section.columns.remove(index);
            }
            
            if (section.columns.size() == 0) section.toHide = true;
        }
        
    }
    
    //FORMAT STRING TO CURRENCY
    public Object toCurrency(String value) {
        Object cur = '';
        Decimal curDec = Decimal.valueOf(value);
        List<String> args = new String[] {'0', 'number', '###.###.##0,00'};
            cur = String.format(curDec.format(), args) + ' DH';
        return cur;
    }
    
    //FORMAT STRING TO DATE
    public Object toDate(String value) {
        Object valueToDate = '';
        Date ddate = Date.valueOf(value);
        List<String> args = new String[] {'0', 'date', 'dd/MM/yyyy'};
            valueToDate = String.format(ddate.format(), args);
        return valueToDate;
    }
    
    
    /* WRAPPER CLASSES */
    
    //Layout
    public Class Layout {
        public String Name {get; set;}
        public String Label {get; set;}
        public List<Section> Sections {get; set;}
        public Map<String, List<String>> RelatedList {get; set;}
        public List<String> CustomButtons {get; set;}
        public List<String> QuickActions {get; set;}
        
        public Layout(String name) {
            this.Name = name;
            this.Sections = new List<Section>();
            this.RelatedList = new Map<String, List<String>>();
            this.CustomButtons = new List<String>();
            this.QuickActions = new List<String>();
        }
    }
    
    //Section
    public class Section {
        public String Label {get; set;}
        public Boolean DetailHeading {get; set;}
        public Boolean EditHeading {get; set;}
        public String Style {get; set;}
        public List<Column> Columns {get; set;}
        
        public Boolean toHide {get; set;}
        
        public Section(String Label, Boolean DetailHeading, Boolean EditHeading, String Style) {
            this.Label = label;
            this.DetailHeading = DetailHeading;
            this.EditHeading = EditHeading;
            this.Style = Style;
            this.Columns = new List<Column>();
            this.toHide = false;
        }
        
    }
    
    //Column
    public class Column {
        public List<String> fields {get; set;}
        
        public Column(List<String> fields) {
            this.fields = fields;
        }
    }
    
    
}