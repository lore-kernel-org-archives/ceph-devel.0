From: Udo Waechter <udo.waechter@uni-osnabrueck.de>
Subject: (un)stability of ceph
Date: Thu, 19 May 2011 18:04:12 +0200
Message-ID: <C424A186-75DB-4CC5-A662-A538E7D5BA4C@uni-osnabrueck.de>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: multipart/signed; boundary=Apple-Mail-9--1051145035; protocol="application/pkcs7-signature"; micalg=sha1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from vm135.rz.uni-osnabrueck.de ([131.173.16.10]:43764 "EHLO
	smtp-auth.serv.Uni-Osnabrueck.DE" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932850Ab1ESQ3g (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 19 May 2011 12:29:36 -0400
Received: from slick.chaos (xdslbi135.osnanet.de [85.8.89.135] (may be forged))
	(authenticated bits=0)
	by smtp-auth.serv.Uni-Osnabrueck.DE (8.13.8/8.13.8) with ESMTP id p4JG4DFK009275
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <ceph-devel@vger.kernel.org>; Thu, 19 May 2011 18:04:14 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Developers <ceph-devel@vger.kernel.org>


--Apple-Mail-9--1051145035
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=iso-8859-1

Hi there.
I'm new to the list, but am following the development of ceph for a =
while now. Great project. It really looks like the next big things.

After researching parallel/shared filesystems for a last year, we tried =
to implement lustre. This project basically died for us with Oracle's =
aquirement of sun and all the confusion that came afterwards. Anyway, we =
then decided for another FS, which now turns out to be an error of the =
big kind. Its unstable und unreliable.

Now, I am in the bad position to quickly have to switch to another FS. =
Before I start implementing another FS, I would like to ask about the =
status of ceph.
I know that it is not supposed to be used in an production environment. =
Nevertheless, I am inclined to give ceph a try. Our plans were to switch =
to ceph anyway as soon as it is considered stable.
Our usage scenarios are these:

* multiple OSDs, multiple MDs.
* shared storage for KVM and XEN (does not need to be Rados Block =
device, can be images as we have it now)
** the VM-servers are interconnected via internal 2x1Gbit nics and also =
have 1Gbit nic to the external LAN.
** traffic for vm-images or RBD should go over internal NICS (can ceph =
handle such a scenario?).
* shared storage for user data. workloads are not very high, but =
potentially many clients (currently 100-200)
** POSIX compatibity is a must (directory permissions, primary and =
secondary group access, for personal files and working group files)
** speed is not of great importance, our LAN is 1Gbit.
** Workstations are Debian/Ubuntu Linux (most of them) and OS X, the =
fewest are Windows. Is it possible (without great hassle) to reexport =
ceph volumes via nfs/samba (for OS X, windows)

Our storage server currenlty are: 2x Dell R510 with 12x1TB (one of =
them), 12x2TB (the second), 16Gbs ram and a i7QuadCore. A third (with =
12x2Tb) and fourth are on their way. These would make OSDs and MDses, I =
guess.

What are your opinions? Is ceph considered unstable in all use-cases, or =
would a moderate work-load work even in production environments? Are =
there any compatibility-breaking updates on their way?

I would rather start using ceph now, even if it is not 100% performant. =
As long as it is 99% stable and data-loss or corruption is not really =
expected....=20

Thanks for your thoughts,
udo.
--=20
:: udo waechter - root@zoide.net :: N 52=BA16'30.5" E 8=BA3'10.1"
:: genuine input for your ears: http://auriculabovinari.de=20
::                          your eyes: http://ezag.zoide.net
::                          your brain: http://zoide.net





--Apple-Mail-9--1051145035
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
hvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTEwNTE5MTYwNDEzWjAjBgkqhkiG
9w0BCQQxFgQUXCPZy4fNGSeY9E2p15KstXyvf/UwgasGCSsGAQQBgjcQBDGBnTCBmjCBkTELMAkG
A1UEBhMCREUxIDAeBgNVBAoTF1VuaXZlcnNpdGFldCBPc25hYnJ1ZWNrMRYwFAYDVQQLEw1SZWNo
ZW56ZW50cnVtMSMwIQYDVQQDExpVbmktT3NuYWJydWVjayBSWi1DQSBHLTAwMjEjMCEGCSqGSIb3
DQEJARYUY2FAdW5pLW9zbmFicnVlY2suZGUCBBFL38Mwga0GCyqGSIb3DQEJEAILMYGdoIGaMIGR
MQswCQYDVQQGEwJERTEgMB4GA1UEChMXVW5pdmVyc2l0YWV0IE9zbmFicnVlY2sxFjAUBgNVBAsT
DVJlY2hlbnplbnRydW0xIzAhBgNVBAMTGlVuaS1Pc25hYnJ1ZWNrIFJaLUNBIEctMDAyMSMwIQYJ
KoZIhvcNAQkBFhRjYUB1bmktb3NuYWJydWVjay5kZQIEEUvfwzANBgkqhkiG9w0BAQEFAASCAQCJ
4ZE0CL1BDpJDXOHaldU9SoEFknhnqJwuJiQnyGKZRHNAcGfnNrapDjcanMD47pDH5fRJxoH14anN
PMd26mdqPwSAt3aFXZFFWhqK6cu2ASJXW4usScbzde/h6fEXza0bR5TfjAwjd8HasQJrTZVgjjHg
lFkehX1PZGux50FbHx0sdbpuf6VwfkiCAfbM/swuGBpifh4plgHd4p1LUOyAEFj+5xAGrzXhpmjg
kSehA4me38rKj+ta3COz17Grz/tDe74vFzEYC0OCArKExkFlQvm2CXb+A7BuPIOk3pJvFtNxXzsk
H1XirvT8RO6AsrRrN29+GitPYcmVVCCtikB6AAAAAAAA

--Apple-Mail-9--1051145035--
