From: Udo Waechter <udo.waechter@uni-osnabrueck.de>
Subject: Re: (un)stability of ceph
Date: Mon, 23 May 2011 15:58:33 +0200
Message-ID: <3C4FC482-1309-4C1B-AC84-48E8BB532513@uni-osnabrueck.de>
References: <C424A186-75DB-4CC5-A662-A538E7D5BA4C@uni-osnabrueck.de> <Pine.LNX.4.64.1105201238250.25242@cobra.newdream.net> <loom.20110523T103350-311@post.gmane.org>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: multipart/signed; boundary=Apple-Mail-7--713084644; protocol="application/pkcs7-signature"; micalg=sha1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from vm135.rz.uni-osnabrueck.de ([131.173.16.10]:60373 "EHLO
	smtp-auth.serv.Uni-Osnabrueck.DE" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754776Ab1EWN6i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Mon, 23 May 2011 09:58:38 -0400
Received: from slick.chaos (xdslbq254.osnanet.de [85.8.71.254] (may be forged))
	(authenticated bits=0)
	by smtp-auth.serv.Uni-Osnabrueck.DE (8.13.8/8.13.8) with ESMTP id p4NDwXwI012036
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <ceph-devel@vger.kernel.org>; Mon, 23 May 2011 15:58:35 +0200
In-Reply-To: <loom.20110523T103350-311@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Developers <ceph-devel@vger.kernel.org>


--Apple-Mail-7--713084644
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=iso-8859-1

Hi, and thanks for tha anwser.

On 23.05.2011, at 10:55, Fyodor Ustinov wrote:

> Sage Weil <sage <at> newdream.net> writes:
>=20
>> Based on your requirements, it sounds like Ceph is a good fit.  As =
for=20
>> status, here is the latest update:
Yes, as I understand the FS-market now, there is a big big void space in =
scalable-fast and future-ready Filesystems. With lustre being somehow =
unsupported/non-free whatever and all other alternatives not having =
those great features (especially kernel support) than ceph has. I think =
that it will become very quickly a filesystem with a big userbase. I =
can't wait for it to be released.

>>=20
>> - Ceph is not yet ready for production however, we are confident that =
we=20
>>  are only a few months away
>> - We have not experienced any data loss on our pseudo-production=20
>>  test clusters for quite some time now.
>> - We (DreamHost) have expanded the core team on Ceph to 7 people who =
are
>>  primarily working on stability and performance
>> - Each month more and more people are digging in and getting involved =
in=20
>>  the project which we hope will accelerate development further
>> - We are very close to launching a hosted beta of the object store =
layer=20
>>  which will help us identify foundational issues
>=20
I'll gladly help with testing.=20

> Requests from "user" :)
>=20
> 1. Stop "featuring". ceph does all what need. :)
+1

> And most important:
> 3. Please, please, please, make documentation. I get along without the
> "crushtool: add --reweight-item" - I know how to use the "vi". But I =
do not know
> the meaning of the secret parameter "weight".
Yes please, so many projects lack good documentation nowadays in the "we =
have a wiki now" century.
Having a wiki is great, but putting the burden on the community which =
has to find out the hard way how the software works does never reveal a =
good documentation if at all.

Thanks,
udo.

--=20
:: udo waechter - root@zoide.net :: N 52=BA16'30.5" E 8=BA3'10.1"
:: genuine input for your ears: http://auriculabovinari.de=20
::                          your eyes: http://ezag.zoide.net
::                          your brain: http://zoide.net





--Apple-Mail-7--713084644
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIFvDCCBbgw
ggSgoAMCAQICBBFL38MwDQYJKoZIhvcNAQEFBQAwgZExCzAJBgNVBAYTAkRFMSAwHgYDVQQKExdV
bml2ZXJzaXRhZXQgT3NuYWJydWVjazEWMBQGA1UECxMNUmVjaGVuemVudHJ1bTEjMCEGA1UEAxMa
VW5pLU9zbmFicnVlY2sgUlotQ0EgRy0wMDIxIzAhBgkqhkiG9w0BCQEWFGNhQHVuaS1vc25hYnJ1
ZWNrLmRlMB4XDTExMDExMTEzNTkxNloXDTE0MDExMDEzNTkxNlowdTELMAkGA1UEBhMCREUxIDAe
BgNVBAoTF1VuaXZlcnNpdGFldCBPc25hYnJ1ZWNrMS0wKwYDVQQLEyRJbnN0aXR1dCBmdWVyIEtv
Z25pdGlvbnN3aXNzZW5zY2hhZnQxFTATBgNVBAMTDFVkbyBXYWVjaHRlcjCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAMzwGDb1f+gvEgItMj+Lm5fT9BECvgDFEhx7XxJGlNxkr0buUKMa
/A2wpQ1yw5Gl4ggdwbtVxrPcLdKHoHf+KQH59tx8Ji9/1qJTjjIYIHxMYXOd6R1SmP92kyiS4kpK
QDy6Xm26fdeahLX5RSjxbpZ6oQXQ7RShlwLUtuVZvOtGQ03R3uRtRlVuUKSd/7pRG6sknv/P7VRJ
yy+D9btr43++37+wWIjfdVppaPw8Nf3IND8SaJb4stKjLMeK4Lpd/kVZVMT15UPYT39P9DHg7ujM
6eXvm4BwW/DNgwQ1ua8Bi6IJBskyZpnekicPG5rSP60o8++mY/p1RvgXKx2JhMcCAwEAAaOCAjEw
ggItMAkGA1UdEwQCMAAwCwYDVR0PBAQDAgXgMCkGA1UdJQQiMCAGCCsGAQUFBwMCBggrBgEFBQcD
BAYKKwYBBAGCNxQCAjAdBgNVHQ4EFgQUsvYGd06HCiDO6mL2Mt5Jpdwzm/0wHwYDVR0jBBgwFoAU
qh/YdxVumeRfkNbsYyZOGepnFFAwawYDVR0RBGQwYoEedWRvLndhZWNodGVyQHVuaS1vc25hYnJ1
ZWNrLmRlgRN1ZG8ud2FlY2h0ZXJAdW9zLmRlgRp1d2FlY2h0ZUB1bmktb3NuYWJydWVjay5kZYEP
dXdhZWNodGVAdW9zLmRlMIGPBgNVHR8EgYcwgYQwQKA+oDyGOmh0dHA6Ly9jZHAxLnBjYS5kZm4u
ZGUvdW5pLW9zbmFicnVlY2stY2EvcHViL2NybC9jYWNybC5jcmwwQKA+oDyGOmh0dHA6Ly9jZHAy
LnBjYS5kZm4uZGUvdW5pLW9zbmFicnVlY2stY2EvcHViL2NybC9jYWNybC5jcmwwgagGCCsGAQUF
BwEBBIGbMIGYMEoGCCsGAQUFBzAChj5odHRwOi8vY2RwMS5wY2EuZGZuLmRlL3VuaS1vc25hYnJ1
ZWNrLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNydDBKBggrBgEFBQcwAoY+aHR0cDovL2NkcDIucGNh
LmRmbi5kZS91bmktb3NuYWJydWVjay1jYS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZIhvcN
AQEFBQADggEBAAMO/VwWkb3a+5x2XVHvVqIZehBXnXgYXYOt8okm7YPj9yS2BgPmHTzSRGREDagi
/Bd/sSW0mXGJ+xXPX2EkT2oBNVqFiL+ZeCF62KPcro7q0wkp5/YnRZ1m2b04PpQ7FT5mUKgeiyk6
JUE68xnDGAdJghqqJag4511291FdBHQ/4i/0EodFX5Jax4Ie8s5XslhLbsbatqb0k/Dz8FTXsby1
55RwvLTOEj4EqHeNVw8XfO43SCwupXNTzaQ/O3zfeTP8CD/8vXNQwVzcW6x/hf2gQH13huchqb6+
LcKY1Lcn1JffUyxO+/cIKTG5VDGGEp6u+DmyrNZUU35qkblfFUkxggOBMIIDfQIBATCBmjCBkTEL
MAkGA1UEBhMCREUxIDAeBgNVBAoTF1VuaXZlcnNpdGFldCBPc25hYnJ1ZWNrMRYwFAYDVQQLEw1S
ZWNoZW56ZW50cnVtMSMwIQYDVQQDExpVbmktT3NuYWJydWVjayBSWi1DQSBHLTAwMjEjMCEGCSqG
SIb3DQEJARYUY2FAdW5pLW9zbmFicnVlY2suZGUCBBFL38MwCQYFKw4DAhoFAKCCAbswGAYJKoZI
hvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTEwNTIzMTM1ODMzWjAjBgkqhkiG
9w0BCQQxFgQUe9QeZ2u59o+qOPRMyaU82Wx3uCIwgasGCSsGAQQBgjcQBDGBnTCBmjCBkTELMAkG
A1UEBhMCREUxIDAeBgNVBAoTF1VuaXZlcnNpdGFldCBPc25hYnJ1ZWNrMRYwFAYDVQQLEw1SZWNo
ZW56ZW50cnVtMSMwIQYDVQQDExpVbmktT3NuYWJydWVjayBSWi1DQSBHLTAwMjEjMCEGCSqGSIb3
DQEJARYUY2FAdW5pLW9zbmFicnVlY2suZGUCBBFL38Mwga0GCyqGSIb3DQEJEAILMYGdoIGaMIGR
MQswCQYDVQQGEwJERTEgMB4GA1UEChMXVW5pdmVyc2l0YWV0IE9zbmFicnVlY2sxFjAUBgNVBAsT
DVJlY2hlbnplbnRydW0xIzAhBgNVBAMTGlVuaS1Pc25hYnJ1ZWNrIFJaLUNBIEctMDAyMSMwIQYJ
KoZIhvcNAQkBFhRjYUB1bmktb3NuYWJydWVjay5kZQIEEUvfwzANBgkqhkiG9w0BAQEFAASCAQBX
WvaNsCyT7gPEMiPFRSuGYXyJ1HQnDs0yMo3SwUBOLzxnxGmtMa/P+i+JD1C5bMZL6thiMTzoSlQb
GVfAsnqcvNCSnsFIkSotrKu9/SUtZPiLA+dIG13R01S/tIO9j7UnKqZQahi08PetWIXl/zizYC5a
bt72nuk9xDzziGvtJNwrd7K+E8PbFTNqxoVDG5Rk4Ybb3ZDDJS6YjetRvAfsQaAi4luyVKqffmTX
oq39w9kIMYrt26VNgkEly4WcXBcBsnSyau2m36N3idxTYuKAUyKAWQpLgz+IbbPWj/zvOIyjJryt
qEg7mNK3khI76s52jk4ASCq+YnpOBh/pT65uAAAAAAAA

--Apple-Mail-7--713084644--
