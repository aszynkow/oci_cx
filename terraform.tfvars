env_name = "dev"
do_bastion_sessions = false
do_mount = false
do_attach = true
do_public_lbs = true
#VMS
app_vm_count = 2
app_osv = "8"
app_vm_hostname = ["appvm","appvm"]
app_vm_shape = ["VM.Standard.E3.Flex","VM.Standard.E3.Flex"]
app_boot_volume_size_in_gbs = ["50","50"]
app_vm_state = ["RUNNING","RUNNING"]
app_memoery_in_gbs = ["32","32"]
app_ocpus = ["4","4"]   
vol_size_in_gbs = ["100","100"]  
vol_vpus_per_gb = ["10","10"]
app_fds = ["FAULT-DOMAIN-1","FAULT-DOMAIN-2"]
vm_source_image_id = ["ocid1.image.oc1.ap-sydney-1.aaaaaaaapqsy6ahc3yfvsmoao6js5cjprvlyvabflnpsre7fmefakfmdvnga",
    "ocid1.image.oc1.ap-sydney-1.aaaaaaaapqsy6ahc3yfvsmoao6js5cjprvlyvabflnpsre7fmefakfmdvnga"]
vm_source_type = ["image","image"]#bootVolume