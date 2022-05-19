resource oci_core_network_security_group nsglb01 {
  compartment_id = var.compartment_ocid
  display_name = local.nsglb1_name
  vcn_id = local.Okit_Vcn001_id
}

resource oci_core_network_security_group_security_rule nsglb01_network_security_group_security_rule_3 {
  description               = "LB egress"
  destination               = var.sub01_ip_range
  destination_type          = "CIDR_BLOCK"
  direction                 = "EGRESS"
  network_security_group_id = oci_core_network_security_group.nsglb01.id
  protocol                  = "6"
  #source = <<Optional value not found in discovery>>
  source_type = ""
  stateless   = "false"
  tcp_options {
    destination_port_range {
      max = "8080"
      min = "8080"
    }
    #source_port_range = <<Optional value not found in discovery>>
  }
}

resource oci_core_network_security_group_security_rule nsglb01_network_security_group_security_rule_4 {
  #description = <<Optional value not found in discovery>>
  #destination = <<Optional value not found in discovery>>
  destination_type          = ""
  direction                 = "INGRESS"
  network_security_group_id = oci_core_network_security_group.nsglb01.id
  protocol                  = "6"
  source                    = var.public_ip_range
  source_type               = "CIDR_BLOCK"
  stateless                 = "false"
  tcp_options {
    destination_port_range {
      max = "8080"
      min = "8080"
    }
    #source_port_range = <<Optional value not found in discovery>>
  }
}