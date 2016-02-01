From: Walker H Haddock <whaddock@uab.edu>
Subject: RE: failure to activate with Infernalis on CentOS 7.2.1511
Date: Mon, 1 Feb 2016 01:49:45 +0000
Message-ID: <25cc55b3e34c414a922b2a5c1767a4f3@UABEX2.ad.uab.edu>
References: <4414b446d5d3404d91b7da6bae452153@UABEX2.ad.uab.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=SHA1; boundary="----=_NextPart_000_0525_01D15C60.8658FE10"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from uabex3.ad.uab.edu ([138.26.5.144]:39173 "EHLO UABEX3.ad.uab.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933276AbcBABtr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 31 Jan 2016 20:49:47 -0500
In-Reply-To: <4414b446d5d3404d91b7da6bae452153@UABEX2.ad.uab.edu>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Walker H Haddock <whaddock@uab.edu>, Ceph Development <ceph-devel@vger.kernel.org>

------=_NextPart_000_0525_01D15C60.8658FE10
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello ceph developers.

I have made some progress. Using the documentation for the latest release of
ceph-deploy and using the ceph-deploy create command instead of the
prepare/activate sequence as documented on master in the quick start, I was
able to get passed the problem with the key that I had reported. However,
the OSDs were not starting.

After looking through the systemd scripts and reading the
/etc/sysconfig/ceph setting for CEPH_AUTO_RESTART_ON_UPGRADE=no and changing
the value to yes, I have been able to create OSDs.

Now my problem is trying to create more than 56 OSDs on the same host. The
57th OSD does not start. I get the following in /var/log/messages:
Jan 31 17:24:04 everest-0-1 flock: ceph-disk: Running command:
/usr/sbin/ceph-disk activate /dev/sdbj1
Jan 31 17:24:04 everest-0-1 systemd: start request repeated too quickly for
ceph-disk@-dev-sdbj1.service
Jan 31 17:24:04 everest-0-1 systemd: Failed to start Ceph disk activation:
/dev/sdbj1.
Jan 31 17:24:04 everest-0-1 systemd: ceph-disk@-dev-sdbj1.service failed.

Thanks

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org
[mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Walker H Haddock
Sent: Friday, January 29, 2016 3:14 PM
To: Ceph Development
Subject: failure to activate with Infernalis on CentOS 7.2.1511

I am getting the following authentication error when running ceph-deploy
activate after running ceph-deploy prepare.

I have installed the back ported version of ceph-disk:
http://tracker.ceph.com/issues/14080

ceph.x86_64                                               1:9.2.0-0.el7
Linux everest-1-3 3.18.13 #1 SMP Sat May 16 17:14:47 EDT 2015 x86_64 x86_64
x86_64 GNU/Linux

ceph-deploy --overwrite-conf osd prepare --fs-type btrfs
everest-0-0:/dev/sdf:/dev/sdc

ceph-deploy osd activate everest-0-0:/dev/sdf1:/dev/sdc1

eph osd tree
ID WEIGHT   TYPE NAME            UP/DOWN REWEIGHT PRIMARY-AFFINITY 
-1 10.91599 root default                                           
-2 10.91599     host everest-0-0                                   
 0  5.45799         osd.0           down        0          1.00000 
 1  5.45799         osd.1            DNE        0 


ceph-deploy activate output:
[cephadmin@everest-1-3 ceph-everest]$ ceph-deploy osd activate
everest-0-0:/dev/sdf1:/dev/sdc1
[ceph_deploy.conf][DEBUG ] found configuration file at:
/home/cephadmin/.cephdeploy.conf
[ceph_deploy.cli][INFO  ] Invoked (1.5.31): /usr/bin/ceph-deploy osd
activate everest-0-0:/dev/sdf1:/dev/sdc1
[ceph_deploy.cli][INFO  ] ceph-deploy options:
[ceph_deploy.cli][INFO  ]  username                      : None
[ceph_deploy.cli][INFO  ]  verbose                       : False
[ceph_deploy.cli][INFO  ]  overwrite_conf                : False
[ceph_deploy.cli][INFO  ]  subcommand                    : activate
[ceph_deploy.cli][INFO  ]  quiet                         : False
[ceph_deploy.cli][INFO  ]  cd_conf                       :
<ceph_deploy.conf.cephdeploy.Conf instance at 0x1140ea8>
[ceph_deploy.cli][INFO  ]  cluster                       : ceph
[ceph_deploy.cli][INFO  ]  func                          : <function osd at
0x1135320>
[ceph_deploy.cli][INFO  ]  ceph_conf                     : None
[ceph_deploy.cli][INFO  ]  default_release               : False
[ceph_deploy.cli][INFO  ]  disk                          : [('everest-0-0',
'/dev/sdf1', '/dev/sdc1')]
[ceph_deploy.osd][DEBUG ] Activating cluster ceph disks
everest-0-0:/dev/sdf1:/dev/sdc1
[everest-0-0][DEBUG ] connection detected need for sudo
[everest-0-0][DEBUG ] connected to host: everest-0-0 
[everest-0-0][DEBUG ] detect platform information from remote host
[everest-0-0][DEBUG ] detect machine type
[everest-0-0][DEBUG ] find the location of an executable
[ceph_deploy.osd][INFO  ] Distro info: CentOS Linux 7.2.1511 Core
[ceph_deploy.osd][DEBUG ] activating host everest-0-0 disk /dev/sdf1
[ceph_deploy.osd][DEBUG ] will use init type: systemd
[everest-0-0][INFO  ] Running command: sudo ceph-disk -v activate
--mark-init systemd --mount /dev/sdf1
[everest-0-0][WARNIN] DEBUG:ceph-disk:get_dm_uuid /dev/sdf1 uuid path is
/sys/dev/block/8:81/dm/uuid
[everest-0-0][WARNIN] DEBUG:ceph-disk:get_dm_uuid /dev/sdf1 uuid path is
/sys/dev/block/8:81/dm/uuid
[everest-0-0][WARNIN] INFO:ceph-disk:Running command: /sbin/sgdisk -i 1
/dev/sdf
[everest-0-0][WARNIN] INFO:ceph-disk:Running command: /sbin/blkid -p -s TYPE
-o value -- /dev/sdf1
[everest-0-0][WARNIN] INFO:ceph-disk:Running command: /usr/bin/ceph-conf
--cluster=ceph --name=osd. --lookup osd_mount_options_btrfs
[everest-0-0][WARNIN] INFO:ceph-disk:Running command: /usr/bin/ceph-conf
--cluster=ceph --name=osd. --lookup osd_fs_mount_options_btrfs
[everest-0-0][WARNIN] DEBUG:ceph-disk:Mounting /dev/sdf1 on
/var/lib/ceph/tmp/mnt.E7nJsK with options noatime,user_subvol_rm_allowed
[everest-0-0][WARNIN] INFO:ceph-disk:Running command: /usr/bin/mount -t
btrfs -o noatime,user_subvol_rm_allowed -- /dev/sdf1
/var/lib/ceph/tmp/mnt.E7nJsK
[everest-0-0][WARNIN] INFO:ceph-disk:Running command: /sbin/restorecon
/var/lib/ceph/tmp/mnt.E7nJsK
[everest-0-0][WARNIN] DEBUG:ceph-disk:Cluster uuid is
fdb615fe-cd40-4690-afd0-d63a2260da24
[everest-0-0][WARNIN] INFO:ceph-disk:Running command: /usr/bin/ceph-osd
--cluster=ceph --show-config-value=fsid
[everest-0-0][WARNIN] DEBUG:ceph-disk:Cluster name is ceph
[everest-0-0][WARNIN] DEBUG:ceph-disk:OSD uuid is
c5a11f43-7ac8-4f20-bc17-531c02e4773d
[everest-0-0][WARNIN] DEBUG:ceph-disk:OSD id is 0
[everest-0-0][WARNIN] DEBUG:ceph-disk:Marking with init system systemd
[everest-0-0][WARNIN] DEBUG:ceph-disk:Authorizing OSD key...
[everest-0-0][WARNIN] INFO:ceph-disk:Running command: /usr/bin/ceph
--cluster ceph --name client.bootstrap-osd --keyring
/var/lib/ceph/bootstrap-osd/ceph.keyring auth add osd.0 -i
/var/lib/ceph/tmp/mnt.E7nJsK/keyring osd allow * mon allow profile osd
[everest-0-0][WARNIN] Error EINVAL: entity osd.0 exists but key does not
match
[everest-0-0][WARNIN] ERROR:ceph-disk:Failed to activate



------=_NextPart_000_0525_01D15C60.8658FE10
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
xCZU7wO94CTLVBowHQYDVR0OBBYEFImCZ33EnSZwAEu0UEh83j2uBG59MA4GA1UdDwEB/wQEAwIB
BjAPBgNVHRMBAf8EBTADAQH/MBEGA1UdIAQKMAgwBgYEVR0gADBEBgNVHR8EPTA7MDmgN6A1hjNo
dHRwOi8vY3JsLnVzZXJ0cnVzdC5jb20vQWRkVHJ1c3RFeHRlcm5hbENBUm9vdC5jcmwwNQYIKwYB
BQUHAQEEKTAnMCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0GCSqGSIb3
DQEBBQUAA4IBAQABvJzjYyiw8zEBwt973WKgAZ0jMQ+cknNTUeofTPrWn8TKL2d+eDMPdBa5kYeR
9Yom+mRwANge+QsEYlCHk4HU2vUj2zS7hVa0cDRueIM3HoUcxREVkl+HF72sav3xwtHMiV+xfPA+
UfI183zsYJhrOivg79+zfYbrtRv1W+yifJgT1wBQudEtc94DeHThBYUxXsuauZ2UxrmUN3Vy3ET7
Z+jw+iUeUqfaJelH4KDHPKBOsQo2+3dIn++Xivu0/uOUFKiDvFwtP9JgcWDuwnGCDOmINuPaILSj
oGyqlku4gI51ykkH9jsUut/cBdmf2+Cy5k2geCbn5y1uf1/GHogVMIIE6jCCA9KgAwIBAgIQJ5o/
CcavxpGv2uo3G++mbzANBgkqhkiG9w0BAQUFADCBrjELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAlVU
MRcwFQYDVQQHEw5TYWx0IExha2UgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3b3Jr
MSEwHwYDVQQLExhodHRwOi8vd3d3LnVzZXJ0cnVzdC5jb20xNjA0BgNVBAMTLVVUTi1VU0VSRmly
c3QtQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBFbWFpbDAeFw0xMTAyMTEwMDAwMDBaFw0yMDA1
MzAxMDQ4MzhaMGQxCzAJBgNVBAYTAlVTMRIwEAYDVQQKEwlJbnRlcm5ldDIxETAPBgNVBAsTCElu
Q29tbW9uMS4wLAYDVQQDEyVJbkNvbW1vbiBTdGFuZGFyZCBBc3N1cmFuY2UgQ2xpZW50IENBMIIB
IjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0+AVAnv5doLp/pGW8/AeIWi1DWEwvgmXZt0d
I6f7H4Z4OuaXasfBpH+JTbOeWbM4Cx85ImsCKBK/KZbRNfSVKmwGmBwZZFymfkVuIGuRuHQPPFPI
gxlrEaPHLIUFHofUy6AIBQYuZok9eKeDk1S32Bfq0+59ZtQ03onKGf03ytCD3lFo2Fr1dOvdggJa
+iDOqs9AK9PInoXpgTOb1vFPkUXZjTMpHF0HmoXp/8kSskwMQirtMPTX3Jm1zwuA6nnepyNin7Xp
lqLWshpF0NgTHZJ59ISBPbYVj+5vLBrG7F2sk48LR006OwnV3gYiOhGVkG9Oex9yLieRMz6IV8K/
CQIDAQABo4IBSzCCAUcwHwYDVR0jBBgwFoAUiYJnfcSdJnAAS7RQSHzePa4Ebn0wHQYDVR0OBBYE
FOjXvZaq3dAI76Eznl5ZmDwSt5uRMA4GA1UdDwEB/wQEAwIBBjASBgNVHRMBAf8ECDAGAQH/AgEA
MBEGA1UdIAQKMAgwBgYEVR0gADBYBgNVHR8EUTBPME2gS6BJhkdodHRwOi8vY3JsLnVzZXJ0cnVz
dC5jb20vVVROLVVTRVJGaXJzdC1DbGllbnRBdXRoZW50aWNhdGlvbmFuZEVtYWlsLmNybDB0Bggr
BgEFBQcBAQRoMGYwPQYIKwYBBQUHMAKGMWh0dHA6Ly9jcnQudXNlcnRydXN0LmNvbS9VVE5BZGRU
cnVzdENsaWVudF9DQS5jcnQwJQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnVzZXJ0cnVzdC5jb20w
DQYJKoZIhvcNAQEFBQADggEBAA7ttuA4nzpoogHB8ITlJu78gdLXjMkbJEOgybGF5p/k4CrRRN7y
oHCtiBgoSJYTEkdJ+co5o1fXzVOFTbf3Lx/Zq1N6aQdOyEK/4uxeO3v0PrKkSZaRFnv5T2peQnIx
0dNDoTkFiT7LtdHpPhHGhHXONb/1Leiiq/WkAU5wHCZlqxbDvTLmKRAva2qySNZwBgb1KOhUfswQ
xWmuEekF6zs4wWJa0B4Y6VxNU/j1KuHdkjWE+iWPH8cjWRr4oiWlVmLi3jis1N8zV2IBOCpRKjtM
uUewcenJIcFhjtJjrbpJKyIArDY1EEgOXsHsHbHbYl6TA+rlUEjvUashivtgxcIwggW5MIIEoaAD
AgECAhEAzfalh4vwS3F2ln7a5ZLSOzANBgkqhkiG9w0BAQUFADBkMQswCQYDVQQGEwJVUzESMBAG
A1UEChMJSW50ZXJuZXQyMREwDwYDVQQLEwhJbkNvbW1vbjEuMCwGA1UEAxMlSW5Db21tb24gU3Rh
bmRhcmQgQXNzdXJhbmNlIENsaWVudCBDQTAeFw0xNDA0MjkwMDAwMDBaFw0xOTA0MjkyMzU5NTla
MIHqMQ4wDAYDVQQREwUzNTI5NDEsMCoGA1UEChMjVW5pdmVyc2l0eSBvZiBBbGFiYW1hIGF0IEJp
cm1pbmdoYW0xHTAbBgNVBAkTFDE5MTkgVW5pdmVyc2l0eSBCbHZkMRowGAYDVQQJExEyMDMgQ3Vk
d29ydGggSGFsbDELMAkGA1UECBMCQUwxEzARBgNVBAcTCkJpcm1pbmdoYW0xCzAJBgNVBAYTAlVT
MR8wHQYDVQQDExZIYW1wdG9uIFdhbGtlciBIYWRkb2NrMR8wHQYJKoZIhvcNAQkBFhB3aGFkZG9j
a0B1YWIuZWR1MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAy7pyG4sSKP2MUu+KSZNR
wO5r1D98escShJM9lvdVaKytPE7wW+XE9yQqhv3gfv1hmU76qZJqODOgPe9C/pIg/Fyp3x6dHutr
9QyRax/qRJWZIh0M0t44cQQIh7kbJ7Ie7+L0i0BDNYxi120+h9MrTDnC2p6qu/uvXX+UP8YjpmS3
o7udWdDU7PzyL7X4NrWcQcaN8B89wJCfEi8p0Ixjw/KYQ2zo75Y164EBT9j6rEARsk39MCF9cCGq
gEWeW2Xm24rMO/tp5nXesbkw1oC36pSkCYjMMc0yigm69NAB0X0BsVqmGKYqDqGURfFEVzg7ZETe
D2OYmCSXjTaKOu0DUQIDAQABo4IB3TCCAdkwHwYDVR0jBBgwFoAU6Ne9lqrd0AjvoTOeXlmYPBK3
m5EwHQYDVR0OBBYEFO7z6Xhtaxf3yMOrvwKJTiJT5e6+MA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMB
Af8EAjAAMB0GA1UdJQQWMBQGCCsGAQUFBwMEBggrBgEFBQcDAjBqBgNVHSAEYzBhMF8GDSsGAQQB
riMBBAMDAAEwTjBMBggrBgEFBQcCARZAaHR0cHM6Ly93d3cuaW5jb21tb24ub3JnL2NlcnQvcmVw
b3NpdG9yeS9jcHNfc3RhbmRhcmRfY2xpZW50LnBkZjBOBgNVHR8ERzBFMEOgQaA/hj1odHRwOi8v
Y3JsLmluY29tbW9uLm9yZy9JbkNvbW1vblN0YW5kYXJkQXNzdXJhbmNlQ2xpZW50Q0EuY3JsMIGA
BggrBgEFBQcBAQR0MHIwSgYIKwYBBQUHMAKGPmh0dHA6Ly9jZXJ0LmluY29tbW9uLm9yZy9JbkNv
bW1vblN0YW5kYXJkQXNzdXJhbmNlQ2xpZW50Q0EuY3J0MCQGCCsGAQUFBzABhhhodHRwOi8vb2Nz
cC5pbmNvbW1vbi5vcmcwGwYDVR0RBBQwEoEQd2hhZGRvY2tAdWFiLmVkdTANBgkqhkiG9w0BAQUF
AAOCAQEAtYdr1h1CdaEQskDysr9aqFpnZTRNcIRhcd3zInxi3IWITtsOsDShdi3vZnMuLmTfHWO1
fvvO2dnOHSXU7pFg3Guyaw9BW/MNpmn07Y5SWJdqkojbz7fAh1p+gn5zABUotrLjqovWkfTvkrUp
q/8nim+RlhkGITCcyHUBXEtfVTWzpIRLBHHsxwaS51YrOzSbpNjlFwNPR8IslOndVUxUN2L0GLT5
cZin8M5Ow7VGII3wpLOQNCo1IWPMUJHvyxiQAkc+wWJnnD9n1oDOr0WdMTrf7rmtAW9o+zbHT5VX
QLZEiubGbKHnbRJ8TT+3GL1aZI2IH8TYE5ACgOB0kLyV/zGCA8cwggPDAgEBMHkwZDELMAkGA1UE
BhMCVVMxEjAQBgNVBAoTCUludGVybmV0MjERMA8GA1UECxMISW5Db21tb24xLjAsBgNVBAMTJUlu
Q29tbW9uIFN0YW5kYXJkIEFzc3VyYW5jZSBDbGllbnQgQ0ECEQDN9qWHi/BLcXaWftrlktI7MAkG
BSsOAwIaBQCgggIjMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE2
MDIwMTAxNDk0MVowIwYJKoZIhvcNAQkEMRYEFENgneJSF7t5efDj/zevRMdrZ6pWMIGIBgkrBgEE
AYI3EAQxezB5MGQxCzAJBgNVBAYTAlVTMRIwEAYDVQQKEwlJbnRlcm5ldDIxETAPBgNVBAsTCElu
Q29tbW9uMS4wLAYDVQQDEyVJbkNvbW1vbiBTdGFuZGFyZCBBc3N1cmFuY2UgQ2xpZW50IENBAhEA
zfalh4vwS3F2ln7a5ZLSOzCBigYLKoZIhvcNAQkQAgsxe6B5MGQxCzAJBgNVBAYTAlVTMRIwEAYD
VQQKEwlJbnRlcm5ldDIxETAPBgNVBAsTCEluQ29tbW9uMS4wLAYDVQQDEyVJbkNvbW1vbiBTdGFu
ZGFyZCBBc3N1cmFuY2UgQ2xpZW50IENBAhEAzfalh4vwS3F2ln7a5ZLSOzCBqwYJKoZIhvcNAQkP
MYGdMIGaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCgYIKoZIhvcNAwcwCwYJYIZIAWUDBAEC
MA4GCCqGSIb3DQMCAgIAgDAHBgUrDgMCBzANBggqhkiG9w0DAgIBQDANBggqhkiG9w0DAgIBKDAH
BgUrDgMCGjALBglghkgBZQMEAgMwCwYJYIZIAWUDBAICMAsGCWCGSAFlAwQCATANBgkqhkiG9w0B
AQEFAASCAQAZJPmSYRVc3S3a5peNgsW7n+LjVumHP47IuAXi/amdbu+YciE5b1AR80l0jkF54BsT
znbPMFZPw967Dq/o/0s36CmQ50iI+Yxml0m7prvl5yEtz8f+OLACpEykVq56IZruLwGi38MXBHgJ
urfDesXZxok0O3+1KDW2ZKHMchvNixVKlo3I6SX2gRn37lzOo02rg/YtsMi1T+/F15Odu8/Jc+Xi
mxQplgJWnGbsICAFv7KLB8u2Xs0KitAzYQmk8klMLKK4gfhvffxsptSp/LaaSx+4m/rGfos7+yed
d4w7BoxiFVFxdOsB/Ye1X04/zDUgs6B6jIL2Xc9L0Wj7svr9AAAAAAAA

------=_NextPart_000_0525_01D15C60.8658FE10--
