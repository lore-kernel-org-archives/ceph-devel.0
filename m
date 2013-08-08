From: Loic Dachary <loic@dachary.org>
Subject: teuthology : ulimit: error
Date: Thu, 08 Aug 2013 23:52:53 +0200
Message-ID: <52041335.9040009@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFA74C86EA8AD0D3CF79ACEF8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:45097 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758094Ab3HHVw4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Aug 2013 17:52:56 -0400
Received: from [10.8.0.22] (unknown [10.8.0.22])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id 6A4D826394
	for <ceph-devel@vger.kernel.org>; Thu,  8 Aug 2013 23:52:54 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFA74C86EA8AD0D3CF79ACEF8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Trying to use Ubuntu precise virtual machines as teuthology targets ( mak=
ing sure they have 2GB of RAM because ceph-test-dbg will not even install=
 with 1GB of RAM ;-) and installing the key with

wget -q -O- 'https://ceph.com/git/?p=3Dceph.git;a=3Dblob_plain;f=3Dkeys/r=
elease.asc' | sudo apt-key add -

teuthology runs with=20

=2E/virtualenv/bin/teuthology job.yaml

where job.yaml is

check-locks: false
roles:
- - mon.a
  - mon.c
  - osd.0
- - mon.b
  - osd.1
  - client.0
tasks:
- install:
   project: ceph
   branch: wip-5510
- ceph:
   fs: ext4
- workunit:
    clients:
      all:
      - filestore/filestore.sh
targets:
   ubuntu@91.121.254.229: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDOSit20Ey=
Z2AKCvk2tnMsdQ6LmVRutvBmZb0awV9Z2EduJa0fYPrReYRb9ZhGRq2PJe0zgpFPKr8s4gGay=
+tL0+dFkju5uyABqMGeITlJCifd+RhM0MCVllgIzekDwVb0n6ydTS8k7GVFyYv8ZC0TPgbfcD=
cEtSEgqJNRJ0o1Bh8swuTn+cipanNDRVK39tOqJdfptUxak+TD+5QY8CGFdXdEQYP7VsYJ+jQ=
Hw73O2xbuPgfv5Shbmt+qGWLToxFqKca3owMtkvFeONgYUdujgg9qr7Q9p0+HhCFCXB8v4N2I=
7NSbWNdpGqyJLdLqwJ70gEeNlOhm5F7IsXfVxTapB
   ubuntu@91.121.254.237: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCXVzhedOR=
tmEmCeZJ4Ssg8wfqpYyH9W/Aa+j6CvPHSAkzZ48zXqVBATxm6S8sIIqfKkz1hWpNssx6uUotb=
m8k/ZatMddsd932+Di136l/HUhp6O8iIFze56kjWpyDpRPw2MM0V+OKmsiHZDfMj9ATt6ChgX=
fRsm23MUlmnoFHvtfwvFBnvBjcZPN7qxMpFHDamZzACNvnis/OINJrud9VprOgjhZZ7mxcTbc=
VZaVgcTcnyC4b9d9PRrMG2aCv0BO1eb/qnlmSogQPfoKEORJcwaUcLgabww+Taa9hJSZ9l8yE=
Qamj+XIgr6yzGKgCvlG4lTdHM2tQdpgATZvR7/pBz

and produces the following output

INFO:teuthology.orchestra.run.err:[91.121.254.229]: /home/ubuntu/cephtest=
/lo1308082328/adjust-ulimits: 4: ulimit: error setting limit (Operation n=
ot permitted)=20

and the full output is at

http://pastealacon.com/32957

as if

/home/ubuntu/cephtest/lo1308082328/adjust-ulimits ceph-coverage /home/ubu=
ntu/cephtest/lo1308082328/archive/coverage monmaptool --create --clobber =
--add a 91.121.254.229:6789 --add c 91.121.254.229:6790 --add b 91.121.25=
4.237:6789 --print /home/ubuntu/cephtest/lo1308082328/monmap'=20

was run without a leading sudo. I tried running sudo adjust-ulimits echo =
foo manually on the target and it works.

I would very much appreciate a hint ;-)

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enigFA74C86EA8AD0D3CF79ACEF8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlIEEzUACgkQ8dLMyEl6F22PZwCgtOX5ND2ueGsWwZ3MRtgk5EZY
5DUAmwUW7m6G+wVJbk3BZm1AEnwj3et6
=EhTi
-----END PGP SIGNATURE-----

--------------enigFA74C86EA8AD0D3CF79ACEF8--
