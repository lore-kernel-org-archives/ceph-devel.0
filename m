From: David Moreau Simard <dmsimard@iweb.com>
Subject: A python client module to ceph-rest-api: python-cephclient
Date: Mon, 13 Jan 2014 00:26:14 +0000
Message-ID: <BA2BA357-AF49-4488-A470-D8BD2DF64C43@iweb.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
	boundary="Apple-Mail=_72CF3C79-C45D-45B1-A13A-590E2310AE5B";
	protocol="application/pkcs7-signature"; micalg=sha1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from otto.privatedns.com ([70.38.127.135]:50597 "EHLO
	otto.privatedns.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbaAMA0R (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 12 Jan 2014 19:26:17 -0500
Received: from courriel.corp.iweb.com (courriel.corp.iweb.com [184.107.120.4]) by otto.privatedns.com with ESMTP id wPcFK4a9WCXDdhvJ for <ceph-devel@vger.kernel.org>; Sun, 12 Jan 2014 19:26:16 -0500 (EST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

--Apple-Mail=_72CF3C79-C45D-45B1-A13A-590E2310AE5B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

Hi !

I=92m glad to announce the immediate availability of the first release =
of python-cephclient on pypi:
https://pypi.python.org/pypi/python-cephclient

The library is licensed under Apache v2 and is also available on github:
https://github.com/dmsimard/python-cephclient

The status of the module:
- Most GET calls to the API are implemented, still need to get a few =
ones that I haven=92t been able to get working properly.
- No PUT calls have been implemented yet, I guess you could say it is =
=93read only=94 right now. (This is just a matter of time)
- Supports and handles JSON, XML and Plain text responses.
- Built in the context of being used as a wrapper to ceph-rest-api for =
web interfaces or monitoring plugins
- Will be the core module behind the open source ceph interface =
initiative Kraken: https://github.com/krakendash/krakendash

I am currently the only person working on this and would gladly =
appreciate any feedback you guys may have.

Let me know if you have any questions !

David Moreau Simard
IT Architecture Specialist=

--Apple-Mail=_72CF3C79-C45D-45B1-A13A-590E2310AE5B
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
hvcNAQkFMQ8XDTE0MDExMzAwMjYxNVowIwYJKoZIhvcNAQkEMRYEFLgu3mdnBEqHEo/SzNobhInr
YXMKMIGBBgkrBgEEAYI3EAQxdDByMFsxEzARBgoJkiaJk/IsZAEZFgNjb20xFDASBgoJkiaJk/Is
ZAEZFgRpd2ViMRQwEgYKCZImiZPyLGQBGRYEY29ycDEYMBYGA1UEAxMPaVdlYiBQcml2YXRlIENB
AhNoAAAAJU0qkTDywPXcAAAAAAAlMIGDBgsqhkiG9w0BCRACCzF0oHIwWzETMBEGCgmSJomT8ixk
ARkWA2NvbTEUMBIGCgmSJomT8ixkARkWBGl3ZWIxFDASBgoJkiaJk/IsZAEZFgRjb3JwMRgwFgYD
VQQDEw9pV2ViIFByaXZhdGUgQ0ECE2gAAAAlTSqRMPLA9dwAAAAAACUwDQYJKoZIhvcNAQEBBQAE
ggEAF4yQPNibadM95wydpSnwjQljdwwlFTZzQjtrz4Kyzj/4gejTm3h7u9Q9ZxqMMAYNbzS48/bb
kyEgExYixiyXdi8vfMAkM0YfTEfscEMxFX3sd8ALYaxHlPLkpmqDAUCJnHczVBQnVQ613PwpoyQn
n7ANrAz16ovRPhFVmqbtw4puYVFA8e97CQlg8FXXDNtAC2c6kRAmF7t/7qZfb6KqZcpxKzOlFc2v
LUC592udbzxBRCk4S2ljjUrnD8xBeUWPt7lBacT24Vkj6MGKuW/LW9ZMamKILRHtgSUyW8hUu2X8
v5bVd2vks005YCjKRfTsRtj3Gpa3QmyK8/lHePXmdQAAAAAAAA==

--Apple-Mail=_72CF3C79-C45D-45B1-A13A-590E2310AE5B--
