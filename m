From: Valery Tschopp <valery.tschopp@switch.ch>
Subject: Re: radosgw + s3 + keystone + Browser-Based POST bug
Date: Mon, 02 Feb 2015 10:49:35 +0100
Message-ID: <54CF482F.4010208@switch.ch>
References: <54CA50CF.5010109@switch.ch>	<87k3054irn.fsf@gmail.com> <CABBk=J-Z1e70oWoAz7x9Gd7AnE-6bAk1sGQ3t97MmA6dRyZ4-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms010407060305050206030801"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from iberico.switch.ch ([130.59.108.143]:57775 "EHLO
	iberico.switch.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754199AbbBBJtx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Feb 2015 04:49:53 -0500
In-Reply-To: <CABBk=J-Z1e70oWoAz7x9Gd7AnE-6bAk1sGQ3t97MmA6dRyZ4-Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@redhat.com>, Abhishek L <abhishek.lekshmanan@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms010407060305050206030801
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 29/01/15 18:28 , Yehuda Sadeh wrote:
[...]
>> Looks like you may be hitting http://tracker.ceph.com/issues/10062,
>> where s3 POST requests were failing with keystone. There is a patch th=
at
>> is merged in master[1] that addresses this. We would also love
>> to see this ported back to firefly/giant.
>
> I just set it to get backported for firefly and giant.
>
> Thanks,
> Yehuda

Thanks a lot.

Do you have an ETA for the backport in firefly to be released?

Cheers,
Valery


>>
>> [1] https://github.com/ceph/ceph/pull/3251
>>
>>
>> Regards
>> --
>> Abhishek

--=20
SWITCH
--------------------------
Valery Tschopp, Software Engineer, Peta Solutions
Werdstrasse 2, P.O. Box, 8021 Zurich, Switzerland
email: valery.tschopp@switch.ch phone: +41 44 268 1544



--------------ms010407060305050206030801
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIILjTCC
BZowggSCoAMCAQICFGooCvNGIygxyVtCwp0kxKgswzXjMA0GCSqGSIb3DQEBCwUAMH8xCzAJ
BgNVBAYTAkJNMRkwFwYDVQQKExBRdW9WYWRpcyBMaW1pdGVkMSUwIwYDVQQLExxSb290IENl
cnRpZmljYXRpb24gQXV0aG9yaXR5MS4wLAYDVQQDEyVRdW9WYWRpcyBSb290IENlcnRpZmlj
YXRpb24gQXV0aG9yaXR5MB4XDTE0MDUzMDE4NTAxM1oXDTIxMDMxNzE4MzMzM1owYzELMAkG
A1UEBhMCQ0gxLDAqBgNVBAoTI1F1b1ZhZGlzIFRydXN0bGluayBTd2l0emVybGFuZCBMdGQu
MSYwJAYDVQQDEx1RdW9WYWRpcyBTd2lzcyBBZHZhbmNlZCBDQSBHMjCCAiIwDQYJKoZIhvcN
AQEBBQADggIPADCCAgoCggIBALKB7kQHlk/9+eTjso+B0Sm6IF327uVx0tbF4Ys62u9hinnZ
9rAp42CbehCiAriA9DEEwPZZrTzSc4+jfTtTOtBAB7fuUUImpeUulUGW5WqNB0+mT2CzK5xq
U3Cy00EeaPXGheBR9NeFOtFaCQC7EaEYv2h2Pb71DFvBXLCOKSByJ2wPNWajbeZdzfEpaKTo
EinfNsON9NPKK0hf40iUOJozHCrovlA+drOsTZ42xImsebDP8h7eCbxoNXLXj6ATWycTDoIr
bH82dxFyX9Zx1oGNA3ffwMc3m78Ukjzg0y3nzLQFiIfdXfMXqq+e2bifRbbXqMddzLIMeZIg
QMylsCm4A6H+OFGP4Fer0r9Webc+CFYkAdd6Zt5LgDHSxcxSusLyZBRb444Qs40TYv6h0bT7
VzCecsPYIQmZcIhygIuxAvU6nvOYXxdc4TEtlS1Hveg2LWwizwhzeas6WfyyHPy1WQuUqZKy
SveKVQpCfsznMpfsXpYqVsDdXLiHP4gzKMQwCDZwDE267owoSd6hSuUZSIQmfGO8WZax6DAV
FVsFxl6lFX5xfR3dpWJWJ5R6S02NQaxetEF4ANKofuOPjYh2UDonQxy/oec+O5if6FTxfJHY
SHJylV9bOwDcu4qZJ+pB+3LWo00TpOzFvtgIFsS36KOec0dAnVc1X+NHnCDfAgMBAAGjggEo
MIIBJDASBgNVHRMBAf8ECDAGAQH/AgEAMBEGA1UdIAQKMAgwBgYEVR0gADBxBggrBgEFBQcB
AQRlMGMwKgYIKwYBBQUHMAGGHmh0dHA6Ly9vY3NwLnF1b3ZhZGlzZ2xvYmFsLmNvbTA1Bggr
BgEFBQcwAoYpaHR0cDovL3RydXN0LnF1b3ZhZGlzZ2xvYmFsLmNvbS9xdnJjYS5jcnQwDgYD
VR0PAQH/BAQDAgEGMB8GA1UdIwQYMBaAFItLbe3TKbkGGew5Oanwl4Rqy+/fMDgGA1UdHwQx
MC8wLaAroCmGJ2h0dHA6Ly9jcmwucXVvdmFkaXNnbG9iYWwuY29tL3F2cmNhLmNybDAdBgNV
HQ4EFgQUoCBtbUldukqF03cgsnq4iw7t1Z0wDQYJKoZIhvcNAQELBQADggEBAK4xXrlQLdGS
ttYCFU5Y3xUpLVqb7SxFMcLfv2i54ksC/dpaQ0v2QOVMLSb5w2IrX8hD+9XGk+2WioVupYvh
W0iWpq7NIs5C5I0K5E9+0wOQd/kiBtwcR7IIyLnPtkzxDe2GUNJXq8L4XyWFDUI0HxgIcv30
G0AbCFCzdmffcVCMKC6oBiwCRuY6RcxRIn1R+WsAuEjphc9SqfvgmllW7aU0npSBfOV31Clh
XcTXfROPHWN1wIHKcMvuJtyjlVX0IEXFQZ2hGIEmv2WiZU/LObutknLmHH6qg2c0agNK0mSU
sXt6iAophkbGDL0MkOZR692YGJJpRg2bMI6knCBeVyYwggXrMIID06ADAgECAhQRn7xkPrs0
MUd4/0Px3JWxZJSUfzANBgkqhkiG9w0BAQsFADBjMQswCQYDVQQGEwJDSDEsMCoGA1UEChMj
UXVvVmFkaXMgVHJ1c3RsaW5rIFN3aXR6ZXJsYW5kIEx0ZC4xJjAkBgNVBAMTHVF1b1ZhZGlz
IFN3aXNzIEFkdmFuY2VkIENBIEcyMB4XDTE0MTIyMjEwMDIxM1oXDTE3MTIyMjEwMDIwOVow
XDELMAkGA1UEBhMCQ0gxEDAOBgNVBAgTB1p1ZXJpY2gxEDAOBgNVBAcTB1p1ZXJpY2gxDzAN
BgNVBAoTBlNXSVRDSDEYMBYGA1UEAwwPVmFsw6lyeSBUc2Nob3BwMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAvD9VQFhasJg69t/6wX5sa5jYoo+Dce1nJ1mMF5DBSINc6PTh
3A9H8bBozo5o7w6gkmY3ZvfF6Mu2lIbftVj/jhmiv212lc4BWPquh6Va/17YZWCGD+rjRwHQ
04SyEnkojcy3F4ouZUsbCBn8JIxK/Wh4D62pxPzjwX6XV+lr3ySU1g0IwkrphFVls+jHBZ5D
0DKpbsCPJpjaYu8WhyrDXDzgUUYmeq4uoNOj4sCdMP+cgMmvJ1hAmcq7NmYX7PcQVDoPP82b
eGOT3ghoTAPAQnOxuIKd6YhRbpkqeosJL0oFxKzuyFA2Khp25WVB5ywYXg79c8ibn40JJBDP
9z4yvwIDAQABo4IBnDCCAZgwIwYDVR0RBBwwGoEYdmFsZXJ5LnRzY2hvcHBAc3dpdGNoLmNo
MHQGCCsGAQUFBwEBBGgwZjAqBggrBgEFBQcwAYYeaHR0cDovL29jc3AucXVvdmFkaXNnbG9i
YWwuY29tMDgGCCsGAQUFBzAChixodHRwOi8vdHJ1c3QucXVvdmFkaXNnbG9iYWwuY29tL3F2
Y2hhZGcyLmNydDBPBgNVHSAESDBGMEQGCisGAQQBvlgBgUgwNjA0BggrBgEFBQcCARYoaHR0
cDovL3d3dy5xdW92YWRpc2dsb2JhbC5jb20vcmVwb3NpdG9yeTAOBgNVHQ8BAf8EBAMCBaAw
HQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFKAgbW1JXbpKhdN3
ILJ6uIsO7dWdMDsGA1UdHwQ0MDIwMKAuoCyGKmh0dHA6Ly9jcmwucXVvdmFkaXNnbG9iYWwu
Y29tL3F2Y2hhZGcyLmNybDAdBgNVHQ4EFgQUxI5Ghm/l+YxHk8uRcSfZjLOhpPIwDQYJKoZI
hvcNAQELBQADggIBABUFi5RUqxn8iXpeEgw1xBY/rOP80WWnTe4wlqRcdSbBNIPB/ybfcNlw
ZR95xtzs6C/F1TF9qJOlXgx8YSbAb7gohCukF7DA2vUXOUn+tuU2/MuXEEPBLNEoXZrlurp/
akAaPr2P5B73yfx0PooxDI9xu/Ex5gsl2kxzl711bIRtdCofTPJeddWWy17H7UIBQK63XeLj
q2ebKoP5jwqE42zKG4eiNC9x2UMVtyqTvaDv98coXiAdsPUfTNPsh7XCUNXGMGXgnK8EYYwz
zfM8XMkxJsM6qzkCfA7esqk3wa+6D5uBKiisQlc8tvDtjgBPIxqQb5phfxsqy5ezQ9ghVTZM
YDXz7K2a7sh5xpqQLynoH90ASxG/wkHdpoAbCPezAIj8aIbHWyqnkLsVnrAQgJdJCS0cuIIj
LLmKY0HFExOz6m0zzY+UJMT364qKat1NYuY1LN8iBydQDhHnESATm46xhUCGF4F5SBqKIkW0
hS/PradkNzJ90V6EMqLFq6c6y4SXYPflelmaA2/R/wWEubAR+ZxHUd2vgcO2pYAy5k73YRAk
l398ffNRMj6azLbZ8gKw6XyXki8L0SbJi2wimEzvG0NwJYSFUEakA/Okj+r+1mNGWOkA5waD
AJKius3VrOk4oUWO5cNscBFxrQmbp7YM0MIOyBjI5bRrNtUVDSj8MYICcDCCAmwCAQEwezBj
MQswCQYDVQQGEwJDSDEsMCoGA1UEChMjUXVvVmFkaXMgVHJ1c3RsaW5rIFN3aXR6ZXJsYW5k
IEx0ZC4xJjAkBgNVBAMTHVF1b1ZhZGlzIFN3aXNzIEFkdmFuY2VkIENBIEcyAhQRn7xkPrs0
MUd4/0Px3JWxZJSUfzAJBgUrDgMCGgUAoIHLMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTE1MDIwMjA5NDkzNVowIwYJKoZIhvcNAQkEMRYEFMGLiyeIaY9L
eZLVtMsWUf7IwIhqMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcw
DQYIKoZIhvcNAwICASgwDQYJKoZIhvcNAQEBBQAEggEAcPpUDCRoRHaLvuL+F8rHPabkInXb
C7IvTn+bH2ZfO2ej3bVcmHCFty5n9eVO96UwPH2LleEbjhKXwlziNUQ8omxmLW08EdUaOZQc
VUUc1q04iDuZ4BD2WHWfP4TuUzX41D7a+qu8akx27RemDR5LhkNEe3PAV/x8vr8S2kAwXBQO
Xdnnaa/XhKyTSlO0HtAz5wsuWETQz6DoF4ZaKoZtdNiWdgbccPdsO333z5OPe/kvlywZLUOw
OSUMfUDm0qO4RiEiZnqvmuURRNeWlvBOggyJc2sGByoEcIYOTkqft/7aGMbiakdJp4h55Usu
5lgyzMiFkasOcs2H77QDN0tRMAAAAAAAAA==
--------------ms010407060305050206030801--
