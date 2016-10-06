From: Daniel Schwager <Daniel.Schwager-keXbdk0DRdY@public.gmane.org>
Subject: Re: Ceph + VMWare
Date: Thu, 6 Oct 2016 06:13:56 +0000
Message-ID: <5C4B841CCF894A4CBD8B13E25E2A575F2458B1BE@exchange2.dtnet.de>
References: <CAAZbbf1HGbZVbB1m5vPd+afWb0pZz4haQhua4FcQa-31FPg=0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1091650376=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAAZbbf1HGbZVbB1m5vPd+afWb0pZz4haQhua4FcQa-31FPg=0g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: 'Patrick McGarry' <pmcgarry-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, 'Ceph-User' <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, 'Ceph Devel' <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

This is an S/MIME signed message

--===============1091650376==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg="sha1"; boundary="----64B327CD2C2F0AA768D68445BBD74DA9"

This is an S/MIME signed message

------64B327CD2C2F0AA768D68445BBD74DA9
Content-Language: de-DE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

we are using Ceph (jewel 10.2.2, 10GBit Ceph frontend/backend, 3 nodes, eac=
h 8 OSD's and 2 journal SSD's)=20
in out VMware environment especially for test environments and templates - =
but currently=20
not for productive machines (because of missing FC-redundancy & performance=
).

On our Linux based SCST 4GBit fiber channel proxy, 16 ceph-rbd  devices (no=
n-caching, in total 10 TB)=20
creating a LVM (stripped) volume which is published as a FC-target to our V=
Mware cluster.=20
Looks fine, works stable. But currently the proxy is not redundant (only on=
e head).
Performance is ok (a), but not that good than our IBM Storwize 3700 SAN (16=
 HDD's).
Especially for small IO's (4k), the IBM is twice as fast as Ceph.=20

Native ceph integration to VMware would be great (-:

Best regards
Daniel

(a) Atto Benchmark screenshots - IBM Storwize 37000 vs. Ceph
https://dtnet.storage.dtnetcloud.com/d/684b330eea/

-------------------------------------------------------------------
DT Netsolution GmbH   -   Tal=E4ckerstr. 30    -    D-70437 Stuttgart
Gesch=E4ftsf=FChrer: Daniel Schwager, Stefan H=F6rz - HRB Stuttgart 19870
Tel: +49-711-849910-32, Fax: -932 - Mailto:daniel.schwager-keXbdk0DRdY@public.gmane.org

> -----Original Message-----
> From: ceph-users [mailto:ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org] On Behalf Of =
Patrick McGarry
> Sent: Wednesday, October 05, 2016 8:33 PM
> To: Ceph-User; Ceph Devel
> Subject: [ceph-users] Ceph + VMWare
>=20
> Hey guys,
>=20
> Starting to buckle down a bit in looking at how we can better set up
> Ceph for VMWare integration, but I need a little info/help from you
> folks.
>=20
> If you currently are using Ceph+VMWare, or are exploring the option,
> I'd like some simple info from you:
>=20
> 1) Company
> 2) Current deployment size
> 3) Expected deployment growth
> 4) Integration method (or desired method) ex: iscsi, native, etc
>=20
> Just casting the net so we know who is interested and might want to
> help us shape and/or test things in the future if we can make it
> better. Thanks.
>=20

------64B327CD2C2F0AA768D68445BBD74DA9
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIPnAYJKoZIhvcNAQcCoIIPjTCCD4kCAQExCzAJBgUrDgMCGgUAMAsGCSqGSIb3
DQEHAaCCDR0wggZdMIIFRaADAgECAhQb6XdyFZbLzJJs2FXqzp6LQ+uGODANBgkq
hkiG9w0BAQsFADBUMQswCQYDVQQGEwJDSDEVMBMGA1UEChMMU3dpc3NTaWduIEFH
MS4wLAYDVQQDEyVTd2lzc1NpZ24gUGVyc29uYWwgR29sZCBDQSAyMDE0IC0gRzIy
MB4XDTE2MDIxMjEwNTgyMFoXDTE5MDIxMjEwNTgyMFowgYsxCzAJBgNVBAYTAkRF
MRswGQYDVQQIExJCYWRlbi1XdWVydHRlbWJlcmcxHDAaBgNVBAoTE0RUIE5ldHNv
bHV0aW9uIEdtYkgxJzAlBgkqhkiG9w0BCQEWGGRhbmllbC5zY2h3YWdlckBkdG5l
dC5kZTEYMBYGA1UEAxMPRGFuaWVsIFNjaHdhZ2VyMIIBIjANBgkqhkiG9w0BAQEF
AAOCAQ8AMIIBCgKCAQEAwMDIZxVhT52+/4KLGuyQMZAveBZeXS/cuwRFQznXKC5I
h19jXGnRLzAZN/ywRpZLlXueEWVqgHH7RZKFBcDSYy7brbRKAALZ/4d9VAz/Hzdy
rbgsK9IgOIWBa1i8itL99lmlWy3qmL0ZxqMTs8rNAgtwjefdjSMsq1wK6vX0XD4i
9t6hTEivlj2Ye0Vrap5e0YX4gYIkpRTOiLnWq5/qZneEzOQ4fOloYAA0V1/zEfSl
oxBJ21aURXWWE8hgeaWadn6bKwbVHpsIEjmV+J3HKORQGH1tvcRerldx1m492Q1e
Yu5hS8XgKIeLh2A5mrJ8JgZzQ+SDJhY5UirN63LDvwIDAQABo4IC7TCCAukwIwYD
VR0RBBwwGoEYZGFuaWVsLnNjaHdhZ2VyQGR0bmV0LmRlMA4GA1UdDwEB/wQEAwID
+DA1BgNVHSUELjAsBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQBgjcKAwQGCisG
AQQBgjcUAgIwHQYDVR0OBBYEFA1GpbhRCOLiKQPTNoe9CmgLYXrfMB8GA1UdIwQY
MBaAFNoy+Un4UcyYcWYM2c6225I/CUvvMIH/BgNVHR8EgfcwgfQwR6BFoEOGQWh0
dHA6Ly9jcmwuc3dpc3NzaWduLm5ldC9EQTMyRjk0OUY4NTFDQzk4NzE2NjBDRDlD
RUI2REI5MjNGMDk0QkVGMIGooIGloIGihoGfbGRhcDovL2RpcmVjdG9yeS5zd2lz
c3NpZ24ubmV0L0NOPURBMzJGOTQ5Rjg1MUNDOTg3MTY2MENEOUNFQjZEQjkyM0Yw
OTRCRUYlMkNPPVN3aXNzU2lnbiUyQ0M9Q0g/Y2VydGlmaWNhdGVSZXZvY2F0aW9u
TGlzdD9iYXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50MF8GA1Ud
IARYMFYwVAYJYIV0AVkBAgEGMEcwRQYIKwYBBQUHAgEWOWh0dHA6Ly9yZXBvc2l0
b3J5LnN3aXNzc2lnbi5jb20vU3dpc3NTaWduLUdvbGQtQ1AtQ1BTLnBkZjCB1wYI
KwYBBQUHAQEEgcowgccwZAYIKwYBBQUHMAKGWGh0dHA6Ly9zd2lzc3NpZ24ubmV0
L2NnaS1iaW4vYXV0aG9yaXR5L2Rvd25sb2FkL0RBMzJGOTQ5Rjg1MUNDOTg3MTY2
MENEOUNFQjZEQjkyM0YwOTRCRUYwXwYIKwYBBQUHMAGGU2h0dHA6Ly9nb2xkLXBl
cnNvbmFsLWcyLm9jc3Auc3dpc3NzaWduLm5ldC9EQTMyRjk0OUY4NTFDQzk4NzE2
NjBDRDlDRUI2REI5MjNGMDk0QkVGMA0GCSqGSIb3DQEBCwUAA4IBAQCXS/MwiGtS
Gngb9DYqNRnH5LbGlXDtXI/ltjYrj8FfED0LmZmaNrhWdMecERMuy6fGaGHj4uw2
k+cjH/NYNcQYyk1HLO1P+CKd8R2gCV+bJ9nWloMPCFam+h6aWgAjIxidI58WlxOZ
1U8bXO6H7DX+yHnbGGpICP73+T4w4uwr7h66j/1UxcDv1Fm2LdPBa7nKm6kMGZj0
Ns8eiKb/hTqGanYidRZJRm0FX45owQlqZpzKO64c1Az678MGCudd9IjYu/wd3Ep8
YaHxFva8G3zxkTjDlxBBjSqIN2nuauMvpODfklvPCqEPrO3ksfURLl3QyKRoFORV
KFPEpVy+Uuc4MIIGuDCCBKCgAwIBAgIPGReV3CJ0GxId21RMXMvcMA0GCSqGSIb3
DQEBCwUAMEUxCzAJBgNVBAYTAkNIMRUwEwYDVQQKEwxTd2lzc1NpZ24gQUcxHzAd
BgNVBAMTFlN3aXNzU2lnbiBHb2xkIENBIC0gRzIwHhcNMTQwOTE5MTQxMDI1WhcN
MjkwOTE1MTQxMDI1WjBUMQswCQYDVQQGEwJDSDEVMBMGA1UEChMMU3dpc3NTaWdu
IEFHMS4wLAYDVQQDEyVTd2lzc1NpZ24gUGVyc29uYWwgR29sZCBDQSAyMDE0IC0g
RzIyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnrf0T2JFsx4NPb+T
UBInPgv9nUyF9dMJh7sQL66HybrB2devqNc1+Gq+fFT4tfBa9hbI+xqRRqCO0LoQ
OJ3v3XMlOzQ3zTL+b3wgDvs/d8tZ7LWGOSYF480/rL1aaBIQFlrE62GDQvcmkH/C
8QxsSS+T+ga2FQhC/Br/btveNcP6cz87WyshF8IU/7sOKYqh3o5mbxI641R1u3+z
aiGq8A9620pSoW3b9P1Mf5t4z51ifqb+/QsYtDt60dw+mVES6sk8cl9VRLejcuiX
FyVJaj7YyITior33buzheHvzZdxaQSgeq0mIrvmXqtplZoqXQ12irR7xhuf/w9Ut
FBbqCwIDAQABo4IClDCCApAwDgYDVR0PAQH/BAQDAgEGMBIGA1UdEwEB/wQIMAYB
Af8CAQAwHQYDVR0OBBYEFNoy+Un4UcyYcWYM2c6225I/CUvvMB8GA1UdIwQYMBaA
FFsle5akZVF+uDnzwHhmXug65/DuMIH/BgNVHR8EgfcwgfQwR6BFoEOGQWh0dHA6
Ly9jcmwuc3dpc3NzaWduLm5ldC81QjI1N0I5NkE0NjU1MTdFQjgzOUYzQzA3ODY2
NUVFODNBRTdGMEVFMIGooIGloIGihoGfbGRhcDovL2RpcmVjdG9yeS5zd2lzc3Np
Z24ubmV0L0NOPTVCMjU3Qjk2QTQ2NTUxN0VCODM5RjNDMDc4NjY1RUU4M0FFN0Yw
RUUlMkNPPVN3aXNzU2lnbiUyQ0M9Q0g/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlz
dD9iYXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50MF8GA1UdIARY
MFYwVAYJYIV0AVkBAgEGMEcwRQYIKwYBBQUHAgEWOWh0dHA6Ly9yZXBvc2l0b3J5
LnN3aXNzc2lnbi5jb20vU3dpc3NTaWduLUdvbGQtQ1AtQ1BTLnBkZjCBxgYIKwYB
BQUHAQEEgbkwgbYwZAYIKwYBBQUHMAKGWGh0dHA6Ly9zd2lzc3NpZ24ubmV0L2Nn
aS1iaW4vYXV0aG9yaXR5L2Rvd25sb2FkLzVCMjU3Qjk2QTQ2NTUxN0VCODM5RjND
MDc4NjY1RUU4M0FFN0YwRUUwTgYIKwYBBQUHMAGGQmh0dHA6Ly9vY3NwLnN3aXNz
c2lnbi5uZXQvNUIyNTdCOTZBNDY1NTE3RUI4MzlGM0MwNzg2NjVFRTgzQUU3RjBF
RTANBgkqhkiG9w0BAQsFAAOCAgEArevbqCOPH6va0x4oEb4UviyXJzIokl5MjRAD
lGMDFXaKm52mU+IZlJ9PjcqBiEXhjjD1oR8uV5aVRWXH+auI6JgQZz5L+u2a309b
Du3bcineP45vZ+nAuoDvulmx2nqjloCOturaks727w/nHCoz723eYH46fg//q/a5
QnOoBe+WIiZWT71TcycX4hiVcPwVqB53tL9IM2qe2balnCpZKorZWVHQXYWSO5MI
Baw/iMOwCCpflDRU75TruHPjfE4Bu4U9Nm3NBt3zcc5ykcQ8ZbJzkWLnSi2LY8r7
1Ulc3jxqyWOZQbgS14x/BzVQj4Rk9+X8KovGpooAFVIBR/bdU/z2IdZlENgoPNpJ
okuEH5OS6UZSyNmhhXjI2QGXn91G+QV4++kreVz6heVOhDPgOoOfRXLYG9O/9wqP
MthmUQgcTrymp57bPpM0zIYpHxcKfxhoYprQdO3LuU1F2xkZE2vFLWVB9ugHzXd1
ADIKrrGgJXPfMluXT9wK8BzTcI5cOqhESt4Awq5q9fmiW3OUAROL0Ca0Z/sRQcvv
J/ewlZvLdsymcfjV6JtN7/IBgIJ4D/Js4DRWCwAv1jhBiEGsRAlhiJmep//U1HEa
T9oredt9PYS1iKbkcMuDEtPuYXrQ+8OQmMEwMbOFboZMMTOVNOenLH+EiG6BUnow
TwqqjtAxggJHMIICQwIBATBsMFQxCzAJBgNVBAYTAkNIMRUwEwYDVQQKEwxTd2lz
c1NpZ24gQUcxLjAsBgNVBAMTJVN3aXNzU2lnbiBQZXJzb25hbCBHb2xkIENBIDIw
MTQgLSBHMjICFBvpd3IVlsvMkmzYVerOnotD64Y4MAkGBSsOAwIaBQCggbEwGAYJ
KoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTYxMDA2MDYx
MzU2WjAjBgkqhkiG9w0BCQQxFgQUx3oM8aDkH093FJ3Zo5ejgQ9xI8QwUgYJKoZI
hvcNAQkPMUUwQzAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcN
AwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwDQYJKoZIhvcNAQEBBQAEggEA
vpm8qW7qgOtddHbXyMvpFjzW9hKCIshXtVEn2JJohva9WmZbt0T0yMF9AMsEO83y
jmYW4PRYs2sOvOizy5U7h5wj3jxVsO4nZgq5DugilB/oa1Ovmb3JT9tcwK8++i8U
+LdaDGK3Uffi9ciWYZ7A02aJH3V5djlNQQy5wwPQN6upY5zb0QjHrql030stU141
Y6C83ZWW25hAqNvr7y5E9OWY3aP66rK3ZfXDKgRiorKh5E2el9d2CS7kExoJpN5P
eJ68mT6u8NFGjwzacfvZepEsl5C0IbnVdERKFFzeIgEnq7+O4uWtzKJ4yAaLtsHb
i3Lu1yWofuwgZY+hVgtHrw==

------64B327CD2C2F0AA768D68445BBD74DA9--


--===============1091650376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1091650376==--
