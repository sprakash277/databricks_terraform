// ##############################################################          
// ##                                                          ##
// ##                                                          ##
// ##         MODIFY VARIABLES BELOW THIS                      ##
// ##                                                          ##
// ##                                                          ##
// ############################################################## 

//  ADD the workspace_prefix below
workspace_prefix = "sumit-europe-hub-spoke" 



// ##############################################################          
// ##                                                          ##
// ##                                                          ##
// ##          DO NOT MODIFY VARIABLES BELOW THIS              ##
// ##         BELOW VALUES  FOR UDR IN WEST EUROPE             ##
// ##                                                          ##
// ############################################################## 

hubcidr          = "10.3.0.0/23"
spokecidr        = "10.4.0.0/23"
no_public_ip     = true
rglocation       = "westeurope"             // Resource Group Location
dbfs_prefix      = "dbfs"

sccip-1          =  "23.97.201.41/32"      // get scc ip from nslookup 
sccip-2          =  "51.138.96.158/32" 
                   // Keep scc value as same if only one ip is available for this region
metastoreip      =  [
  "104.40.169.187",
 "13.69.105.208"
          ] 
webappip         =  [
  "52.232.19.246/32",    // Keep webapp value as same if only one ip is available for this region
  "40.74.30.80/32"
          ]  
firewallfqdn     = [                                                      // dbfs rule will be added - depends on dbfs storage name
  "dbartifactsprodwesteu.blob.core.windows.net",                         //databricks artifacts
  "dbartifactsprodnortheu.blob.core.windows.net",                       //databricks artifacts secondary
  "dblogprodwesteurope.blob.core.windows.net",                         //log blob
  "prod-westeurope-observabilityeventhubs.servicebus.windows.net",    //eventhub
  "cdnjs.com"                                                        //ganglia
]

// ##############################################################          
// ##                                                          ##
// ##                                                          ##
// ##         DO NOT MODIFY VARIABLES BELOW THIS               ##
// ##               UC RELATED CHANGES                         ##
// ##                                                          ##
// ############################################################## 

//Unity Catalog Specific Configs
create_metastore        = false
metastore_storage_name  = "metastorewithfirewall"
metastore_storage_id    = "/subscriptions/3f2e4d32-8e8d-46d6-82bc-5bb8d962328b/resourceGroups/sumit-sa-west-europe-rg/providers/Microsoft.Storage/storageAccounts/metastorewithfirewall"
uc_metastore_id         = "0fe7e61b-cfc9-4c6c-a2fe-a84069f131c5"
catalog_name            = "tf_generated"
schema_name             = "demo"
metastore_rg_name       = "sumit-sa-west-europe-rg"
