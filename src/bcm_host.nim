#[
  https://raspberrypi.stackexchange.com/questions/36121/fatal-error-bcm-host-h-no-such-file-or-directory-compilation-terminated

  sudo apt-get install libraspberrypi-dev raspberrypi-kernel-headers
  
  Peripheral Addresses
    https://www.raspberrypi.org/documentation/hardware/raspberrypi/peripheral_addresses.md
    -I/opt/vc/include -L/opt/vc/lib -lbcm_host
]#
{.passL: "-lbcm_host -L/opt/vc/lib", passC:"-I/opt/vc/include" .}

proc bcm_host_get_peripheral_address*(): cuint {.importc: "bcm_host_get_peripheral_address", header: "bcm_host.h".}

proc bcm_host_get_peripheral_size*(): cuint {.importc: "bcm_host_get_peripheral_size", header: "bcm_host.h".}

proc bcm_host_get_sdram_address*(): cuint {.importc: "bcm_host_get_sdram_address", header: "bcm_host.h".}

type BCM_HOST_BOARD_TYPE* {.pure.} = enum
  MODELA = 0,
  MODELB = 1,
  MODELAPLUS = 2,
  MODELBPLUS = 3,
  PI2MODELB = 4,
  ALPHA = 5,
  CM = 6,
  CM2 = 7,
  PI3MODELB = 8,
  PI0 = 9,
  CM3 = 0xa,
  CUSTOM = 0xb,
  PI0W = 0xc,
  PI3MODELBPLUS = 0xd,
  PI3MODELAPLUS = 0xe,
  FPGA = 0xf,
  CM3PLUS = 0x10,
  PI4MODELB = 0x11,

proc bcm_host_get_model_type*(): cint {.importc: "bcm_host_get_model_type", header: "bcm_host.h".}

#[ Returns 1 if model is  Pi4 ]#
proc bcm_host_is_model_pi4*(): cint {.importc: "bcm_host_is_model_pi4", header: "bcm_host.h".}

#[ Returns 1 if fkms is active (dtoverlay=v3d-fkms-vc4) ]#
proc bcm_host_is_fkms_active*(): cint {.importc: "bcm_host_is_fkms_active", header: "bcm_host.h".}

#[ Returns 1 if kms is active (dtoverlay=v3d-kms-vc4) ]#
proc bcm_host_is_kms_active*(): cint {.importc: "bcm_host_is_kms_active", header: "bcm_host.h".}

#[ returns the processor ID ]#
#[ const
  BCM_HOST_PROCESSOR_BCM2835* = 0
  BCM_HOST_PROCESSOR_BCM2836* = 1
  BCM_HOST_PROCESSOR_BCM2837* = 2
  BCM_HOST_PROCESSOR_BCM2838* = 3 ]#

type BCM_HOST_PROCESSOR* {.pure.} = enum
  BCM2835 = 0,
  BCM2836 = 1,
  BCM2837 = 2,
  BCM2838 = 3

proc bcm_host_get_processor_id*(): cint {.importc: "bcm_host_get_processor_id", header: "bcm_host.h".}




when isMainModule:
  import strutils

  echo "bcm_host_get_peripheral_address\n", toHex(bcm_host_get_peripheral_address())

  echo "bcm_host_get_peripheral_size\n", bcm_host_get_peripheral_size()

  echo "bcm_host_get_sdram_address\n", toHex(bcm_host_get_sdram_address())

  echo "board type", 
    BCM_HOST_BOARD_TYPE(bcm_host_get_model_type())

  echo "is Pi4? ", bool(bcm_host_is_model_pi4())

  echo "bcm_host_get_processor_id\n", 
    BCM_HOST_PROCESSOR(bcm_host_get_processor_id())