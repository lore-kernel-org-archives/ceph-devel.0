From: Tim Bell <Tim.Bell@cern.ch>
Subject: RE: mds fails to start on SL6
Date: Fri, 6 Jul 2012 19:07:36 +0000
Message-ID: <5D7F9996EA547448BC6C54C8C5AAF4E565342B69@CERNXCHG01.cern.ch>
References: <DC5475EA-BEE8-4623-BFE7-C6BBB68C8C35@tchpc.tcd.ie>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=SHA1; boundary="----=_NextPart_000_0455_01CD5BBB.5E08F630"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx32.cern.ch ([137.138.144.178]:17295 "EHLO
	CERNMX32.cern.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757823Ab2GFTNC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jul 2012 15:13:02 -0400
In-Reply-To: <DC5475EA-BEE8-4623-BFE7-C6BBB68C8C35@tchpc.tcd.ie>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jimmy Tang <jtang@tchpc.tcd.ie>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

------=_NextPart_000_0455_01CD5BBB.5E08F630
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit


Does SL6 have the kernel level required ?

Tim

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Jimmy Tang
> Sent: 06 July 2012 17:43
> To: ceph-devel@vger.kernel.org
> Subject: mds fails to start on SL6
> 
> Hi All,
> 
> I was giving ceph 0.48 a try on SL6x, the OSD's startup okay, but the mds
fails
> to start, below is a snippet of the error,
> 
> 
> 2012-07-06 16:38:17.838055 7f2d6828d700 -1 mds.-1.0 *** got signal
> Terminated ***
> 2012-07-06 16:38:17.838139 7f2d6828d700  1 mds.-1.0 suicide.  wanted
> down:dne, now up:boot
> 2012-07-06 16:38:17.839020 7f2d6828d700 -1 osdc/Objecter.cc: In function
> 'void Objecter::shutdown()' thread 7f2d6828d700 time 2012-07-06
> 16:38:17.838156
> osdc/Objecter.cc: 221: FAILED assert(initialized)
> 
>  ceph version 0.48argonaut
> (commit:c2b20ca74249892c8e5e40c12aa14446a2bf2030)
>  1: (Objecter::shutdown()+0x170) [0x6e2e20]
>  2: (MDS::suicide()+0xc9) [0x4ad829]
>  3: (MDS::handle_signal(int)+0x1bb) [0x4b447b]
>  4: (SignalHandler::entry()+0x283) [0x803d53]
>  5: /lib64/libpthread.so.0() [0x3b3ea077f1]
>  6: (clone()+0x6d) [0x3b3e6e5ccd]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed
> to interpret this.
> 
> --- begin dump of recent events ---
>     -3> 2012-07-06 16:37:57.786954 7f2d6b496760  0 ceph version
0.48argonaut
> (commit:c2b20ca74249892c8e5e40c12aa14446a2bf2030), process ceph-mds,
> pid 12537
>     -2> 2012-07-06 16:38:17.838055 7f2d6828d700 -1 mds.-1.0 *** got signal
> Terminated ***
>     -1> 2012-07-06 16:38:17.838139 7f2d6828d700  1 mds.-1.0 suicide.
wanted
> down:dne, now up:boot
>      0> 2012-07-06 16:38:17.839020 7f2d6828d700 -1 osdc/Objecter.cc: In
> function 'void Objecter::shutdown()' thread 7f2d6828d700 time 2012-07-06
> 16:38:17.838156
> osdc/Objecter.cc: 221: FAILED assert(initialized)
> 
>  ceph version 0.48argonaut
> (commit:c2b20ca74249892c8e5e40c12aa14446a2bf2030)
>  1: (Objecter::shutdown()+0x170) [0x6e2e20]
>  2: (MDS::suicide()+0xc9) [0x4ad829]
>  3: (MDS::handle_signal(int)+0x1bb) [0x4b447b]
>  4: (SignalHandler::entry()+0x283) [0x803d53]
>  5: /lib64/libpthread.so.0() [0x3b3ea077f1]
>  6: (clone()+0x6d) [0x3b3e6e5ccd]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed
> to interpret this.
> 
> --- end dump of recent events ---
> 2012-07-06 16:38:17.840237 7f2d6828d700 -1 *** Caught signal (Aborted) **
> in thread 7f2d6828d700
> 
>  ceph version 0.48argonaut
> (commit:c2b20ca74249892c8e5e40c12aa14446a2bf2030)
>  1: /usr/bin/ceph-mds() [0x803309]
>  2: /lib64/libpthread.so.0() [0x3b3ea0f4a0]
>  3: (gsignal()+0x35) [0x3b3e632885]
>  4: (abort()+0x175) [0x3b3e634065]
>  5: (__gnu_cxx::__verbose_terminate_handler()+0x12d) [0x3b432bea7d]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed
> to interpret this.
> 
> --- begin dump of recent events ---
>      0> 2012-07-06 16:38:17.840237 7f2d6828d700 -1 *** Caught signal
> (Aborted) **  in thread 7f2d6828d700
> 
>  ceph version 0.48argonaut
> (commit:c2b20ca74249892c8e5e40c12aa14446a2bf2030)
>  1: /usr/bin/ceph-mds() [0x803309]
>  2: /lib64/libpthread.so.0() [0x3b3ea0f4a0]
>  3: (gsignal()+0x35) [0x3b3e632885]
>  4: (abort()+0x175) [0x3b3e634065]
>  5: (__gnu_cxx::__verbose_terminate_handler()+0x12d) [0x3b432bea7d]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed
> to interpret this.
> 
> --- end dump of recent events ---
> 
> 
> 
> 
> 
> Regards,
> Jimmy Tang
> 
> --
> Senior Software Engineer, Digital Repository of Ireland (DRI) Trinity
Centre
> for High Performance Computing, Lloyd Building, Trinity College Dublin,
> Dublin 2, Ireland.
> http://www.tchpc.tcd.ie/
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html

------=_NextPart_000_0455_01CD5BBB.5E08F630
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
dHRwOi8vY2EuY2Vybi5jaC9jYS9jcmwvQ0VSTiUyMFJvb3QlMjBDQS5jcmyGgbZsZGFwOi8vL0NO
PUNFUk4lMjBSb290JTIwQ0EsQ049Y2VybnJvb3RjYSxDTj1DRFAsQ049UHVibGljJTIwS2V5JTIw
U2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1jZXJuLERDPWNoP2NlcnRp
ZmljYXRlUmV2b2NhdGlvbkxpc3Q/YmFzZT9vYmplY3RDbGFzcz1jUkxEaXN0cmlidXRpb25Qb2lu
dDCCAQQGCCsGAQUFBwEBBIH3MIH0MEQGCCsGAQUFBzAChjhodHRwOi8vY2EuY2Vybi5jaC9jYS9j
cmwvY2VybnJvb3RjYV9DRVJOJTIwUm9vdCUyMENBLmNydDCBqwYIKwYBBQUHMAKGgZ5sZGFwOi8v
L0NOPUNFUk4lMjBSb290JTIwQ0EsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENO
PVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9Y2VybixEQz1jaD9jQUNlcnRpZmljYXRlP2Jh
c2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhvcml0eTANBgkqhkiG9w0BAQUFAAOCAQEA
HxM7znmKISp3Ziap1XYgqmd/LUgcTjj7ClB1uFGNYwX2DF252fZHhUBZSv4OV+GmTzQRB18NHiqU
FbDIRD1kK78fE/3+xsLVPiTUIZICvbZ3s5h8WM1oBAvTF2YX2MxUsDCBepEipZZlE5zd+bhdRJ0/
PuuHWo3vshFXKZjN+KfBcNduf1qSp0ZsDadGJFJOrjLYumOrzkx7bcyDeT+npRqGrfLGnTKq1Z2j
DcxvIRlL0pGIr2AbO5rAD7sJl4C7yJF1j1vjAxbPseSs8e+WR793NlqCoFMS+SmR/UKoke7fD+mA
X2Fukqc8hkYuEBzf4ji4V2dOkemj5YyxDp+NSTCCBxQwggX8oAMCAQICCjMbcQYAAgAA084wDQYJ
KoZIhvcNAQEFBQAwWTESMBAGCgmSJomT8ixkARkWAmNoMRQwEgYKCZImiZPyLGQBGRYEY2VybjEt
MCsGA1UEAxMkQ0VSTiBUcnVzdGVkIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTExMTIwMzA3
NTkxNVoXDTEyMTIwMjA3NTkxNVowgYgxEjAQBgoJkiaJk/IsZAEZFgJjaDEUMBIGCgmSJomT8ixk
ARkWBGNlcm4xFjAUBgNVBAsTDU9yZ2FuaWMgVW5pdHMxDjAMBgNVBAsTBVVzZXJzMRAwDgYDVQQD
Ewd0aW1iZWxsMQ8wDQYDVQQDEwYzNzM3NDExETAPBgNVBAMTCFRpbSBCZWxsMIGfMA0GCSqGSIb3
DQEBAQUAA4GNADCBiQKBgQDUckM33tJzIn8S1NrX/UIMUKgMT5Utw+m8x4ZKZYtJGjX5TNuKADcs
BDCodcrrbx8ZnjIXKeNGDax1v7G9/z7e0Kt5XfbZgMqZIhFHAr3uUsj4Y9nZokwOxV9QjiT6xCAd
TLU1txRRlLGOCBQxwEXjMhB1nB5Y+QsSG/41GEO2YQIDAQABo4IEMDCCBCwwDgYDVR0PAQH/BAQD
AgWgMD0GCSsGAQQBgjcVBwQwMC4GJisGAQQBgjcVCIO90AmC7Y0Nhu2LK4He9TeFgNBiHoW/ugOE
xMxMAgFkAgEJMHgGCSqGSIb3DQEJDwRrMGkwDgYIKoZIhvcNAwICAgCAMA4GCCqGSIb3DQMEAgIA
gDALBglghkgBZQMEASowCwYJYIZIAWUDBAEtMAsGCWCGSAFlAwQBAjALBglghkgBZQMEAQUwBwYF
Kw4DAgcwCgYIKoZIhvcNAwcwHQYDVR0OBBYEFHvA3mZwR/KGvlMGldaKAflwe/8DMB8GA1UdIwQY
MBaAFJjMktBGMDaMsO2YDXJRqUdM3b4hMIIBMgYDVR0fBIIBKTCCASUwggEhoIIBHaCCARmGR2h0
dHA6Ly9jYS5jZXJuLmNoL2NhL2NybC9DRVJOJTIwVHJ1c3RlZCUyMENlcnRpZmljYXRpb24lMjBB
dXRob3JpdHkuY3JshoHNbGRhcDovLy9DTj1DRVJOJTIwVHJ1c3RlZCUyMENlcnRpZmljYXRpb24l
MjBBdXRob3JpdHksQ049Q0VSTlBLSSxDTj1DRFAsQ049UHVibGljJTIwS2V5JTIwU2VydmljZXMs
Q049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1jZXJuLERDPWNoP2NlcnRpZmljYXRlUmV2
b2NhdGlvbkxpc3Q/YmFzZT9vYmplY3RDbGFzcz1jUkxEaXN0cmlidXRpb25Qb2ludDCCAS8GCCsG
AQUFBwEBBIIBITCCAR0wgcUGCCsGAQUFBzAChoG4bGRhcDovLy9DTj1DRVJOJTIwVHJ1c3RlZCUy
MENlcnRpZmljYXRpb24lMjBBdXRob3JpdHksQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZp
Y2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9Y2VybixEQz1jaD9jQUNlcnRpZmlj
YXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhvcml0eTBTBggrBgEFBQcwAoZH
aHR0cDovL2NhLmNlcm4uY2gvY2EvY3JsL0NFUk4lMjBUcnVzdGVkJTIwQ2VydGlmaWNhdGlvbiUy
MEF1dGhvcml0eS5jcnQwKQYDVR0lBCIwIAYIKwYBBQUHAwIGCCsGAQUFBwMEBgorBgEEAYI3CgME
MBcGA1UdIAQQMA4wDAYKKwYBBAFgCgIBATA1BgkrBgEEAYI3FQoEKDAmMAoGCCsGAQUFBwMCMAoG
CCsGAQUFBwMEMAwGCisGAQQBgjcKAwQwPQYDVR0RBDYwNKAgBgorBgEEAYI3FAIDoBIMEHRpbS5i
ZWxsQGNlcm4uY2iBEFRpbS5CZWxsQGNlcm4uY2gwDQYJKoZIhvcNAQEFBQADggEBADcK0C2ZCvrm
BjQLzi3o5OUCNHB2994eOnjKmsCc7cu0/BfC1IanB73IIpzp23qziuHjv+pOwGUm709sqUF6tcJZ
7lcAsIwPMTyR51ynAmpzwsvEnUpGOnr6Fd7wbQdnNb23qvgyxCL48ALq3duwoCpa/FddDFWtumF6
48Ywx381qqwtrGg33j2Oh5CwdjB4ozHj4xLV2VPTlXoNtw/EuU6PNOYEgdswBfN0w1THvXlK1qyT
FFwAY8xPRNJEzoHjiBpvd2tz70as7qF492uTNXv8sPCgzppVaS9iKcx9Ln945kq0+FkoEXESK2S3
ZrExcTjvRaHYlMdGh3V8mXVYkygxggMOMIIDCgIBATBnMFkxEjAQBgoJkiaJk/IsZAEZFgJjaDEU
MBIGCgmSJomT8ixkARkWBGNlcm4xLTArBgNVBAMTJENFUk4gVHJ1c3RlZCBDZXJ0aWZpY2F0aW9u
IEF1dGhvcml0eQIKMxtxBgACAADTzjAJBgUrDgMCGgUAoIIB/TAYBgkqhkiG9w0BCQMxCwYJKoZI
hvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xMjA3MDYxOTA3MzVaMCMGCSqGSIb3DQEJBDEWBBTtMnMi
XCkwUaoo1uVtPfO0JlX5zTB2BgkrBgEEAYI3EAQxaTBnMFkxEjAQBgoJkiaJk/IsZAEZFgJjaDEU
MBIGCgmSJomT8ixkARkWBGNlcm4xLTArBgNVBAMTJENFUk4gVHJ1c3RlZCBDZXJ0aWZpY2F0aW9u
IEF1dGhvcml0eQIKMxtxBgACAADTzjB4BgsqhkiG9w0BCRACCzFpoGcwWTESMBAGCgmSJomT8ixk
ARkWAmNoMRQwEgYKCZImiZPyLGQBGRYEY2VybjEtMCsGA1UEAxMkQ0VSTiBUcnVzdGVkIENlcnRp
ZmljYXRpb24gQXV0aG9yaXR5AgozG3EGAAIAANPOMIGrBgkqhkiG9w0BCQ8xgZ0wgZowCwYJYIZI
AWUDBAEqMAsGCWCGSAFlAwQBFjAKBggqhkiG9w0DBzALBglghkgBZQMEAQIwDgYIKoZIhvcNAwIC
AgCAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgFAMA0GCCqGSIb3DQMCAgEoMAcGBSsOAwIaMAsGCWCG
SAFlAwQCAzALBglghkgBZQMEAgIwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIGAXmH6O2uw
bdOXACTjrgygDcWuQ6vedAVmnU6i3Nlut0tJGuKVJUn/E3pvB2sZKML65WoWilIMejtCOkKu3+r2
Lj99ws0ajijBA+eJnlgkUDN/9dwEE3vCsKa0z3N9/vN5mlFDUXrk710XBUR5VqLYR081WnBUDAFV
CQ1kmNPmxAAAAAAAAAA=

------=_NextPart_000_0455_01CD5BBB.5E08F630--
