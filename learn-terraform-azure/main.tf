# Configure the Azure provider
   terraform {
     required_version = "0.12.28"
     required_providers {
       azurerm = {
   #      source   = "hashicorp/azurerm"
         version  = ">= 2.0.0"
         features = {}
     }
       azuread = {
        version = "=0.7.0"
     }
   }
 }

data "azuread_user" "tony_mccallion" {
   	user_principal_name = 	"tonymccallion@nomsdigitechoutlook.onmicrosoft.com" 
#	object_id = "aec9421b-330c-4d14-b42c-0d61b4509825"	
   }

data "azuread_group" "Import_AD_Group1" {
#    name = "Digital Studio - Asset & Performance Analysts"
    object_id = "2d1f2627-7393-4d54-9635-8e53f2733a67"
  }
 
 resource "azuread_group_member" "Import_AD_Group1_tony_mccallion" {
    	group_object_id   = data.azuread_group.Import_AD_Group1.id
    	member_object_id  = data.azuread_user.tony_mccallion.id

 lifecycle {
      create_before_destroy = true
 }
}
