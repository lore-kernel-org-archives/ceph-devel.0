From: Michael Menge <michael.menge@zdv.uni-tuebingen.de>
Subject: understanding cephx
Date: Mon, 14 Jan 2013 16:17:46 +0100
Message-ID: <20130114161746.57302w31pt6asj2y@webmail.uni-tuebingen.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary="=_3mkmx3ywkkkkk";
 protocol="application/pkcs7-signature";
 micalg="sha1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx09.uni-tuebingen.de ([134.2.3.2]:34347 "EHLO
	mx09.uni-tuebingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757048Ab3ANPiY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Jan 2013 10:38:24 -0500
Received: from wm03.uni-tuebingen.de (wm03.uni-tuebingen.de [134.2.3.21])
	by mx09.uni-tuebingen.de (8.13.6/8.13.6) with ESMTP id r0EFHkY6026801
	for <ceph-devel@vger.kernel.org>; Mon, 14 Jan 2013 16:17:46 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--=_3mkmx3ywkkkkk
Content-Type: text/plain;
 charset=UTF-8;
 DelSp="Yes";
 format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

before I get to my questions, I want to thank for the good work done
with ceph. I learned about ceph in an Admin-Magazin article [1]
and was supprised how easy it was to setup ceph by following the
article. Trying new software and not hitting any error/warning or
other problems is a very rare incident and I was verry impressed
by the easy installation and configuration.

Later on I had some smaler problems as i tried to increase the number
of mon, ods an by adding an standby mds. But i managed to figure it
out using manpages and the web.

Now I have a problem that I don't know how to fix.

First some informations about my setup
ceph version 0.47.2 (commit:8bf9fde89bd6ebc4b0645b2fe02dadb1c17ad372)

ceph.conf
------------
[global]
         ; Enable authentication between hosts within the cluster.
         auth supported =3D cephx
         keyring =3D /etc/ceph/$name.keyring

[mon]

         mon data =3D /srv/mon.$id

[mds]

[osd]
         osd data =3D /srv/osd.$id
         osd journal =3D /srv/osd.$id.journal
         osd journal size =3D 1000

[mon.b]
         host =3D hpb020102
         mon addr =3D 10.23.3.2:6789

[mon.c]
         host =3D hpb020103
         mon addr =3D 10.23.3.3:6789


[mon.d]
         host =3D hpb020104
         mon addr =3D 10.23.3.4:6789

[mon.e]
         host =3D hpb020105
         mon addr =3D 10.23.3.5:6789

[mon.f]
         host =3D hpb020106
         mon addr =3D 10.23.3.6:6789
[osd.2]
         host =3D hpb020102

[osd.3]
         host =3D hpb020103

[osd.4]
         host =3D hpb020104

[osd.5]
         host =3D hpb020105

[osd.6]
         host =3D hpb020106

[mds.a]
         host =3D hpb020104

[mds.b]
         host =3D hpb020105
         mds standby replay =3D true
------------
/srv/osd.* are on xfs  partition


Befor my holiday I found logs that indicated that there might
be a problem with one of my mds which is still present

     2013-01-14 15:32:41.943304   mds e515692: 1/1/1 up =20
{0=3Da=3Dup:active}, 1 up:standby-replay, 5 up:oneshot-replay(laggy or =20
crashed)

I tried to increase the log-level and get some debug infos.
After my holiday i found that the ceph-logs mostly the mon log had
filled my / filesystem. First I thougth that the debugging was still
active but at a closer look, I found that somehow the mon. key could
not be found by mon.e

2013-01-14 15:44:52.007632 7fad1e728700  0 mon.e@3(probing) e3  =20
couldn't get secret for mon service
2013-01-14 15:44:52.007655 7fad17ee9700  0 mon.e@3(probing) e3  =20
couldn't get secret for mon service
2013-01-14 15:44:52.007659 7fad1e728700  0 mon.e@3(probing) e3 no =20
installed auth entries!
2013-01-14 15:44:52.007662 7fad17ee9700  0 mon.e@3(probing) e3 no =20
installed auth entries!
2013-01-14 15:44:52.007860 7fad17ee9700  0 -- 10.23.3.5:6789/0 >> =20
10.23.3.3:6789/0 pipe(0x8e7190 sd=3D19 pgs=3D0 cs=3D0 l=3D0
).connect got BADAUTHORIZER
2013-01-14 15:44:52.007860 7fad1e728700  0 -- 10.23.3.5:6789/0 >> =20
10.23.3.2:6789/0 pipe(0x8e6870 sd=3D18 pgs=3D0 cs=3D0 l=3D0
).connect got BADAUTHORIZER

So i guess, by trying to get some more informations I somehow
manged to delete the mon. key. I was unable the retieve the history
because of the full filesystem.

So I tried to use "ceph auth" and ceph-authtool to (re-)add the mon. key
but only managed that mon.d is now too unable the authenticate.

Sofar I know that I don't understand how cephx is working.

"ceph auth list" shows the same key for mon. on all servers.
But as it takes longer on hpb020104 and hpb020105 I guess it
will contact some other mon servers as mon.d and mon.e are out
of quorum.

How can i get informations about the mon. key for mon.d and mon.e
if they are not running / out of quorum?
How can I add/change the mon. key?

"/etc/ceph/" has keyrings for admin client.admin mds.* ods.* but none
for mon. or mon.*
Is this correct?


Best regards

    Michael Menge





[1] =20
http://www.admin-magazin.de/Das-Heft/2012/03/Der-RADOS-Objectstore-und-Ceph=
-Teil-1/%28language%29/ger-DE


---------------------------------------------------------------------------=
-----

M.Menge                                Tel.: (49) 7071/29-70316
Universit=C3=A4t T=C3=BCbingen                   Fax.: (49) 7071/29-5912
Zentrum f=C3=BCr Datenverarbeitung          mail: =20
michael.menge@zdv.uni-tuebingen.de
W=C3=A4chterstra=C3=9Fe 76
72074 T=C3=BCbingen
--=_3mkmx3ywkkkkk
Content-Type: application/pkcs7-signature;
 name="smime.p7s"
Content-Description: S/MIME Signatur
Content-Disposition: attachment;
 filename="smime.p7s"
Content-Transfer-Encoding: base64

MIIUjwYJKoZIhvcNAQcCoIIUgDCCFHwCAQExCzAJBgUrDgMCGgUAMAsGCSqGSIb3DQEHAaCCEf8w
ggUlMIIEDaADAgECAgIA9TANBgkqhkiG9w0BAQUFADB3MQswCQYDVQQGEwJERTEfMB0GA1UEChMW
VW5pdmVyc2l0YWV0IFR1ZWJpbmdlbjEdMBsGA1UECxMUTG9jYWxTVUItVU5JVFVFLUNBMDExKDAm
BgNVBAMTH0xvY2FsU1VCLVVOSVRVRS1DQTAxIENBLUNlcnQgMDEwHhcNMTAwODI2MTMzMDU0WhcN
MTUwODI1MTMzMDU0WjB1MQswCQYDVQQGEwJERTEfMB0GA1UEChMWVW5pdmVyc2l0YWV0IFR1ZWJp
bmdlbjEWMBQGA1UEAxMNTWljaGFlbCBNZW5nZTEtMCsGCSqGSIb3DQEJARYebWljaGFlbC5tZW5n
ZUB1bmktdHVlYmluZ2VuLmRlMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxcH6IOtd
pM1ndNX02ScqbAkKBdylcE9F6/cp/IiZF/BxzJoXJoNNls5SY/4IX2Wkx1p5YT9G8XaR1QA2iF/f
Y5r6+hPb03R+dc4CJm8sO6Lve1h3UYtQoEnC36ITKePAILgVnc1+7FChsRy/elvGWd+ypI4a2B+y
Bow2b6ljvJlqyG66G2X+0qn4nC4Sd2oCF/iXP+k12SJh+aBPJiBwC8UUqXLM/DVNNGjuk7nGlHq5
ta4TQvL1JWv4ouRI1mgFB5Xidq30lHUtSxYaXa0naD+efHbPsJE6oQMvJUxegzaGwRa2Jln7HDF7
a+8ruEmDilvHk3ZtaVxND+wB9cHk8QIDAQABo4IBuzCCAbcwHQYDVR0OBBYEFBpkw8IAL/0lmOkT
9TOXEs4p7RVvMIGZBgNVHSMEgZEwgY6AFNZouQqJUvlMZTfaTQXBVKMGGqSvoXOkcTBvMQswCQYD
VQQGEwJERTEfMB0GA1UEChMWVW5pdmVyc2l0YWV0IFR1ZWJpbmdlbjEYMBYGA1UECxMPTG9jYWwt
VU5JVFVFLUNBMSUwIwYDVQQDExxMb2NhbC1VTklUVUUtQ0EgUm9vdC1DZXJ0IDAxggECMAwGA1Ud
EwEB/wQCMAAwCwYDVR0PBAQDAgSwMCkGA1UdEQQiMCCBHm1pY2hhZWwubWVuZ2VAdW5pLXR1ZWJp
bmdlbi5kZTAJBgNVHRIEAjAAMFUGA1UdHwROMEwwSqBIoEaGRGh0dHA6Ly93d3cuY2EudW5pLXR1
ZWJpbmdlbi5kZS93aWRlcnJ1Zi9jcmwtTG9jYWxTVUItVU5JVFVFLUNBMDEuY3JsMFIGCCsGAQUF
BwEBBEYwRDBCBggrBgEFBQcwAoY2aHR0cDovL3d3dy5jYS51bmktdHVlYmluZ2VuLmRlL2FpYS9s
b2NhbHN1YndlYmNhMDEuY3J0MA0GCSqGSIb3DQEBBQUAA4IBAQB4878yw2g8IzMc/j8lOa7ZLGby
M6CoKT6zabVM/QXtXhfdKu3T2+Q/B0ypbH4qVGR3xOT7pvieEuHUA+hsddwPuxFbDhZ+bAypk7HD
PP7foXULLdfDPr3H1UW7umxtTGBsvCPBiiKZQWLemCcbz5DdRIQidrssCdJkfaEL61bJj0YT0gCG
O1t5hcskQH03701EhmEURH0kvV1eEV24qEhIjr/xrAMw8Ij3hPCW0Xe82DdQXg5BVTk9oGf/9Kw6
YJeU+LfwuiZU18X6foScm319oN3HYaE4RzMhxoOUceYU/NBnxm/OKsr+wh4FRzZYOszfhpYFuNVY
R3ikxLJoHV0rMIIFCjCCA/KgAwIBAgIECeagADANBgkqhkiG9w0BAQUFADBaMQswCQYDVQQGEwJE
RTETMBEGA1UEChMKREZOLVZlcmVpbjEQMA4GA1UECxMHREZOLVBLSTEkMCIGA1UEAxMbREZOLVZl
cmVpbiBQQ0EgR2xvYmFsIC0gRzAxMB4XDTA3MDIwNTEyMjYyNloXDTE5MDIwNDAwMDAwMFowdzEL
MAkGA1UEBhMCREUxHzAdBgNVBAoTFlVuaXZlcnNpdGFldCBUdWViaW5nZW4xHDAaBgNVBAMTE0ds
b2JhbC1VTklUVUUtQ0EgMDExKTAnBgkqhkiG9w0BCQEWGnVuaXR1ZS1jYUB1bmktdHVlYmluZ2Vu
LmRlMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAstu5y8Xi/5mzRLhv+viYrQ/c/CIL
ZeelQ6zZtE55lDBDXYqBWaInwCTG+Su8/tdJRyk7EDYMsjpzTESUDa9kYgvb28Llwlnbu4VBveEo
4jnpZnf/fo7yfcscJESl6Zif7TIWXBtgkNU/CvkWNMzylbCT+k/vfIfSYaWrAbUIWAVBNcZTPU0D
2bYKPz82XZ57Z0t1hKlYPuutSChmtWuwSwMU9CeScuwEbP9X16fveLdT4B9ntKmRpWnCPZHsDmvC
PfU7HsZJFbIbUwoxjrSWTK0cP6I3mHrrdWl3h/INTNAHQYAmGGmn70As58T7eYj3W2QbltW9igAo
lPsKRvJxKQIDAQABo4IBuTCCAbUwDwYDVR0TAQH/BAUwAwEB/zALBgNVHQ8EBAMCAQYwHQYDVR0O
BBYEFLDBu2g1f+LWQZwaca/g/EE0zcOoMB8GA1UdIwQYMBaAFEm3xs/oPR9/6kR7Eyn38QpwPt5k
MCUGA1UdEQQeMByBGnVuaXR1ZS1jYUB1bmktdHVlYmluZ2VuLmRlMIGIBgNVHR8EgYAwfjA9oDug
OYY3aHR0cDovL2NkcDEucGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1jYS9wdWIvY3JsL2NhY3JsLmNy
bDA9oDugOYY3aHR0cDovL2NkcDIucGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1jYS9wdWIvY3JsL2Nh
Y3JsLmNybDCBogYIKwYBBQUHAQEEgZUwgZIwRwYIKwYBBQUHMAKGO2h0dHA6Ly9jZHAxLnBjYS5k
Zm4uZGUvZ2xvYmFsLXJvb3QtY2EvcHViL2NhY2VydC9jYWNlcnQuY3J0MEcGCCsGAQUFBzAChjto
dHRwOi8vY2RwMi5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNy
dDANBgkqhkiG9w0BAQUFAAOCAQEAabQg/8E0LpmKYvAPoK9XFXK3y1lmlTIWg6L0UZzyy0O2Gv8p
/ryXsnp8sEPqoPJ5wZGcqukzU0eRHPdb4VigreeuYMZNMcfp9+ldWmG9Jzk/5a4OXNh9FbWokOeI
15odtWw0ldZ9pmj3HSK+R+996BTF3AA7n5lTNQjkIDp16ovbpD7LQO37/AchQ7ZMNvIMeSwe7Vl/
znPaU6vNs50n1H8Tz1varD8G5glqqX96fT23AloL8++PmkfW6d6eL3rEQIE9XpzDqm4aIMB5ose/
URHv5lotawCKdUR0gv3dJNEEpBGbVvX4noF0whz8xx/OTqfiU52VTdLEr3qULlJ9OzCCBCEwggMJ
oAMCAQICAgDHMA0GCSqGSIb3DQEBBQUAMHExCzAJBgNVBAYTAkRFMRwwGgYDVQQKExNEZXV0c2No
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
NO+AlFc+t2Qoypo6yTFPMMguhEbJXr8=

--=_3mkmx3ywkkkkk--
