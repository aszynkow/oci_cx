resource oci_core_volume vol_app_attachment01 {
  count = local.do_attach_count
  availability_domain = local.ad
  #block_volume_replicas_deletion = <<Optional value not found in discovery>>
  compartment_id = var.compartment_ocid
  display_name = join(var.env_name,["vol",var.app_vm_hostname[count.index],count.index])
  is_auto_tune_enabled = "false"
  #kms_key_id = <<Optional value not found in discovery>>
  size_in_gbs = var.vol_size_in_gbs[count.index]
  #volume_backup_id = <<Optional value not found in discovery>>
  vpus_per_gb = var.vol_vpus_per_gb[count.index]
}

resource oci_core_volume_attachment appvolumeattachment01 {
  count = local.do_attach_count #- 1 
  attachment_type = "paravirtualized"
  device          = var.vm_device
  display_name    = join(var.env_name,["volat",var.app_vm_hostname[count.index],count.index])
  #encryption_in_transit_type = <<Optional value not found in discovery>>
  instance_id                         = oci_core_instance.appvm[count.index].id
  is_pv_encryption_in_transit_enabled = "false"
  is_read_only                        = "false"
  is_shareable = "false"
  #use_chap = <<Optional value not found in discovery>>
  volume_id = oci_core_volume.vol_app_attachment01[count.index].id
  #depends_on = [oci_core_volume_attachment.mastervolatt1,oci_core_volume_attachment.mastervolatt2,]
}