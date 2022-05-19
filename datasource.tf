# ------ Retrieve Regional / Cloud Data
# -------- Get a list of Availability Domains
data "oci_identity_availability_domains" "AvailabilityDomains" {
    compartment_id = var.compartment_ocid
}
data "template_file" "AvailabilityDomainNames" {
    count    = length(data.oci_identity_availability_domains.AvailabilityDomains.availability_domains)
    template = data.oci_identity_availability_domains.AvailabilityDomains.availability_domains[count.index]["name"]
}
# -------- Get a list of Fault Domains
data "oci_identity_fault_domains" "FaultDomainsAD1" {
    availability_domain = element(data.oci_identity_availability_domains.AvailabilityDomains.availability_domains, 0)["name"]
    compartment_id = var.compartment_ocid
}
data "oci_identity_fault_domains" "FaultDomainsAD2" {
    availability_domain = element(data.oci_identity_availability_domains.AvailabilityDomains.availability_domains, 1)["name"]
    compartment_id = var.compartment_ocid
}
data "oci_identity_fault_domains" "FaultDomainsAD3" {
    availability_domain = element(data.oci_identity_availability_domains.AvailabilityDomains.availability_domains, 2)["name"]
    compartment_id = var.compartment_ocid
}
# -------- Get Home Region Name
data "oci_identity_region_subscriptions" "RegionSubscriptions" {
    tenancy_id = var.tenancy_ocid
}
data "oci_identity_region_subscriptions" "HomeRegion" {
    tenancy_id = var.tenancy_ocid
    filter {
        name = "is_home_region"
        values = [true]
    }
}

data "oci_core_images" "app_Okit_In001Images" {
    compartment_id           = var.compartment_ocid
    operating_system         = var.app_os#"Oracle Linux"
    operating_system_version = var.app_osv#"8"
    shape                    = var.app_image_shape

  # exclude GPU specific images
  #filter {
   # name   = "display_name"
    #values = ["^Oracle-Linux-7.8-([\\.0-9]+)-([\\.0-9-]+)$"]
    #regex  = true
  #}
}

# ------ Get List Service OCIDs
data "oci_core_services" "RegionServices" {
}

# ------ Get List Images
data "oci_core_images" "InstanceImages" {
    compartment_id           = var.compartment_ocid
}

data "oci_identity_regions" "Regions" {
}

data oci_core_vcns vcns {
   compartment_id = var.netwrok_compartment_id
   display_name = var.existing_vcn_name
}


data "oci_core_service_gateways" "service_gateways" {
    #Required
    compartment_id = var.netwrok_compartment_id

    #Optional
    vcn_id = local.Okit_Vcn001_id
}

data "oci_core_nat_gateways" "nat_gateways" {
    #Required
    compartment_id = var.netwrok_compartment_id

    #Optional
    vcn_id = local.Okit_Vcn001_id
}

data "oci_core_internet_gateways" "internet_gateways" {
    #Required
    compartment_id = var.netwrok_compartment_id

    #Optional
    vcn_id = local.Okit_Vcn001_id
}

data"oci_core_volumes" "app_volumes" { 
    compartment_id    = var.compartment_ocid

   filter {
    name   = "display_name"
    values = ["appvol[\\.0-9]"]
    regex  = true
  }
}

data"oci_core_volumes" "web_volumes" { 
    compartment_id    = var.compartment_ocid

   filter {
    name   = "display_name"
    values = ["webvol[\\.0-9]"]
    regex  = true
  }
}

data "oci_core_boot_volumes" "web_boot_volumes" {
availability_domain = element(data.oci_identity_availability_domains.AvailabilityDomains.availability_domains, 2)["name"]
compartment_id    = var.compartment_ocid

   filter {
    name   = "display_name"
    values = ["\\*webvm[\\.0-9]"]
    regex  = true
  }
}

data "oci_core_boot_volumes" "app_boot_volumes" {
availability_domain = element(data.oci_identity_availability_domains.AvailabilityDomains.availability_domains, 2)["name"]
compartment_id    = var.compartment_ocid

   filter {
    name   = "display_name"
    values = ["\\*appvm[\\.0-9]"]
    regex  = true
  }
}