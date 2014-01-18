From: David Moreau Simard <dmsimard@iweb.com>
Subject: Re: A python client module to ceph-rest-api: python-cephclient
Date: Sat, 18 Jan 2014 21:15:19 +0000
Message-ID: <83EFB06E-90BC-43BF-BC80-121B2C332C69@iweb.com>
References: <BA2BA357-AF49-4488-A470-D8BD2DF64C43@iweb.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
	boundary="Apple-Mail=_3BB88D82-A645-4730-9C51-ECFF5A14D328";
	protocol="application/pkcs7-signature"; micalg=sha1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from otto.privatedns.com ([70.38.127.135]:52427 "EHLO
	otto.privatedns.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbaARVPV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 18 Jan 2014 16:15:21 -0500
Received: from courriel.corp.iweb.com (courriel.corp.iweb.com [184.107.120.4]) by otto.privatedns.com with ESMTP id MG7fSrUDXDcwFTGX for <ceph-devel@vger.kernel.org>; Sat, 18 Jan 2014 16:15:20 -0500 (EST)
In-Reply-To: <BA2BA357-AF49-4488-A470-D8BD2DF64C43@iweb.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

--Apple-Mail=_3BB88D82-A645-4730-9C51-ECFF5A14D328
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

I wish I had more time to work on this, it=92s fun.

I just cut a new release which makes the client and wrapper more =
feature-complete around GET API calls:
https://github.com/dmsimard/python-cephclient#release-notes

It would be awesome to get feedback from you guys !

David Moreau Simard
IT Architecture Specialist

On Jan 12, 2014, at 7:26 PM, David Moreau Simard <dmsimard@iweb.com> =
wrote:

> Hi !
>=20
> I=92m glad to announce the immediate availability of the first release =
of python-cephclient on pypi:
> https://pypi.python.org/pypi/python-cephclient
>=20
> The library is licensed under Apache v2 and is also available on =
github:
> https://github.com/dmsimard/python-cephclient
>=20
> The status of the module:
> - Most GET calls to the API are implemented, still need to get a few =
ones that I haven=92t been able to get working properly.
> - No PUT calls have been implemented yet, I guess you could say it is =
=93read only=94 right now. (This is just a matter of time)
> - Supports and handles JSON, XML and Plain text responses.
> - Built in the context of being used as a wrapper to ceph-rest-api for =
web interfaces or monitoring plugins
> - Will be the core module behind the open source ceph interface =
initiative Kraken: https://github.com/krakendash/krakendash
>=20
> I am currently the only person working on this and would gladly =
appreciate any feedback you guys may have.
>=20
> Let me know if you have any questions !
>=20
> David Moreau Simard
> IT Architecture Specialist


--Apple-Mail=_3BB88D82-A645-4730-9C51-ECFF5A14D328
Content-Disposition: attachment; filename="smime.p7s"
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIFyzCCBccw
ggSvoAMCAQICE2gAAAAlTSqRMPLA9dwAAAAAACUwDQYJKoZIhvcNAQEFBQAwWzETMBEGCgmSJomT
8ixkARkWA2NvbTEUMBIGCgmSJomT8ixkARkWBGl3ZWIxFDASBgoJkiaJk/IsZAEZFgRjb3JwMRgw
FgYDVQQDEw9pV2ViIFByaXZhdGUgQ0EwHhcNMTMxMDA5MTQ0MTEzWhcNMTQxMDA5MTQ0MTEzWjCB
pzETMBEGCgmSJomT8ixkARkWA2NvbTEUMBIGCgmSJomT8ixkARkWBGl3ZWIxFDASBgoJkiaJk/Is
ZAEZFgRjb3JwMQ0wCwYDVQQLEwRpV2ViMRUwEwYDVQQLEwxVdGlsaXNhdGV1cnMxHDAaBgNVBAMT
E0RhdmlkIE1vcmVhdSBTaW1hcmQxIDAeBgkqhkiG9w0BCQEWEWRtc2ltYXJkQGl3ZWIuY29tMIIB
IjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA1pL1SRc7cXSxopnjy0qbF99Dj0qqisXSlijo
BlYI6/lGqX87WKMw21z/QoBtNA44hymnoCnoUWU+d2y1THNZSht3VazyD88p+akM2GA5FKpkPOJE
XxVxY0rRtHbod6Zoc3S3/X//Vy/sBgR+vIdkqiIF1vL+pNJkOiO3dUSgfJxYk/Jb4YY2YOyTGN+2
15XMGs9npZwdUvkpibKv2yHt7D6YIsEaLZmXPt9PBv7E+KEwzmOFDGzkdv5Q4vy6YIAmb7ZGXrOE
Drcq4JXszs+W76+Zp8qP/BpNRf8k2v/jISr5ure6ljFJlE9Dv+YjLJsDbBIsy8aF4UjJtcTuV1Aq
TQIDAQABo4ICNTCCAjEwHQYDVR0OBBYEFN1qo0k+ke0yKqRgjKsICOpPGusAMB8GA1UdIwQYMBaA
FBZN0rMIOIBekYO3FEAbmpunVW5UMEcGA1UdHwRAMD4wPKA6oDiGNmh0dHA6Ly9jZXJ0cy5jb3Jw
Lml3ZWIuY29tL2NybC9pV2ViJTIwUHJpdmF0ZSUyMENBLmNybDCBygYIKwYBBQUHAQEEgb0wgbow
gbcGCCsGAQUFBzAChoGqbGRhcDovLy9DTj1pV2ViJTIwUHJpdmF0ZSUyMENBLENOPUFJQSxDTj1Q
dWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPWNv
cnAsREM9aXdlYixEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29iamVjdENsYXNzPWNlcnRpZmlj
YXRpb25BdXRob3JpdHkwFwYJKwYBBAGCNxQCBAoeCABVAHMAZQByMA4GA1UdDwEB/wQEAwIFoDAp
BgNVHSUEIjAgBgorBgEEAYI3CgMEBggrBgEFBQcDBAYIKwYBBQUHAwIwPwYDVR0RBDgwNqAhBgor
BgEEAYI3FAIDoBMMEWRtc2ltYXJkQGl3ZWIuY29tgRFkbXNpbWFyZEBpd2ViLmNvbTBEBgkqhkiG
9w0BCQ8ENzA1MA4GCCqGSIb3DQMCAgIAgDAOBggqhkiG9w0DBAICAIAwBwYFKw4DAgcwCgYIKoZI
hvcNAwcwDQYJKoZIhvcNAQEFBQADggEBAF/zSBP3IPUygfC0zb8qZGqzX6gUCjlPetbLC8JF4u5m
0krzNgWE+QjESpXKW9u4KV9ixVh6jw6i7pSGWNrIWXQTIg5527Ap8WF281f79KkE6rtnOuiffoZX
0K4AbRuPbV5891wCE+yFyivewHwNwoqWXa8BuQ4x5leTrUabzGk0N7j3MbA+cY7QdSiZ63zpmBy/
g/fMZmqdc/LfSlT65uzizx8x6y+SzlH9YNdBOhymiF67QMczZB54zr3KHkH4xOHUYhT302vRc8uS
XOtb4CnPloPsVtHvTWMLAdRjReUP1JAiO+FcnSMr+Z17HXfzHerBBigdtuxyCiKGU/Y+s5wxggME
MIIDAAIBATByMFsxEzARBgoJkiaJk/IsZAEZFgNjb20xFDASBgoJkiaJk/IsZAEZFgRpd2ViMRQw
EgYKCZImiZPyLGQBGRYEY29ycDEYMBYGA1UEAxMPaVdlYiBQcml2YXRlIENBAhNoAAAAJU0qkTDy
wPXcAAAAAAAlMAkGBSsOAwIaBQCgggFnMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTE0MDExODIxMTUyMFowIwYJKoZIhvcNAQkEMRYEFKRvlg3kbs6lzvW1z3131AzH
8dzMMIGBBgkrBgEEAYI3EAQxdDByMFsxEzARBgoJkiaJk/IsZAEZFgNjb20xFDASBgoJkiaJk/Is
ZAEZFgRpd2ViMRQwEgYKCZImiZPyLGQBGRYEY29ycDEYMBYGA1UEAxMPaVdlYiBQcml2YXRlIENB
AhNoAAAAJU0qkTDywPXcAAAAAAAlMIGDBgsqhkiG9w0BCRACCzF0oHIwWzETMBEGCgmSJomT8ixk
ARkWA2NvbTEUMBIGCgmSJomT8ixkARkWBGl3ZWIxFDASBgoJkiaJk/IsZAEZFgRjb3JwMRgwFgYD
VQQDEw9pV2ViIFByaXZhdGUgQ0ECE2gAAAAlTSqRMPLA9dwAAAAAACUwDQYJKoZIhvcNAQEBBQAE
ggEAd3kVpknHD4ASqys6HUo/7KHiMISslShx6bTKOFOdxShdGmPf5JaskugukpmRHU4batlkqUbI
/Niug1pJUpnjXImBTx1fFxI4+1OMCKkl6mWkwb7eBEz+7AtrGEBgdQiHyZiwEk3SDDslg2QY4lig
laovKl5pt13EqLQ2kOv5WQqXebxPOlHKvvFodl4sAv88Jm+eNezcsTkW0tgYFK623UYPwQFH4NXb
e5D8RAPbm9wnTkH9ThTRbAwpDt9mhx5yASdvziM785/Z+2ZdQ0oGIIRoPQKqMYZ9rdAEsXbxHeeX
zRP35sgcqKJwlIjNXifpC6jkTYJchgvZ4jQoXTXRGQAAAAAAAA==

--Apple-Mail=_3BB88D82-A645-4730-9C51-ECFF5A14D328--
