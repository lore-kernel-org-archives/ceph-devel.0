From: Loic Dachary <loic@dachary.org>
Subject: Nightlies and dumpling
Date: Fri, 08 May 2015 22:45:53 +0200
Message-ID: <554D2081.7040503@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="h6oroFaIda9hQWcJI80n4QLIL2fg3Tg7i"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:60157 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752871AbbEHUp7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 May 2015 16:45:59 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Alistair Israel <aisrael@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h6oroFaIda9hQWcJI80n4QLIL2fg3Tg7i
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I was going through the checklist to retire a release, to verify nothing =
was left behind for Dumpling

   http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_retire_a_sta=
ble_release

and from the nightlies crontab that you published, I found

http://tracker.ceph.com/projects/ceph-releases/wiki/Typica

10 18 * * 0,4 teuthology-suite -v -c giant -k distro -m typica -s upgrade=
/dumpling-firefly-x --filter ubuntu_

and

http://tracker.ceph.com/projects/ceph-releases/wiki/Sepia

10 17 * * 2,4,7 teuthology-suite -v -c next -k distro -m plana,burnupi,mi=
ra -s upgrade/dumpling-firefly-x --filter ubuntu_

13 19 * * 7 teuthology-suite -v -c firefly -k distro -m vps -s upgrade/du=
mpling-x ~/vps.yaml

15 18 * * 3,6 teuthology-suite -v -c giant -k distro -m vps -s upgrade/du=
mpling-firefly-x ~/vps.yaml


You can also remove from Sepia the lines commented out:

#removed the line below b/c the suite 'upgrade/dumpling-firefly-x' on vps=
 runs out of memory on hammer, YuriW 3/29/15
#15 17 * * 1,3 teuthology-suite -v -c hammer -k distro -m vps -s upgrade/=
dumpling-firefly-x --suite-branch hammer ~/vps.yaml

#removed the line below b/c the suite 'upgrade/dumpling-firefly-x' on vps=
 runs out of memory on next, YuriW 3/29/15
#15 17 * * 0,2,4,6 teuthology-suite -v -c next -k distro -m vps -s upgrad=
e/dumpling-firefly-x --suite-branch hammer ~/vps.yaml

Maybe there is a reason for scheduling them, even though Dumpling is reti=
red. But in case it was just overlooked, maybe you can save some computin=
g power in the labs :-0

Cheers
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--h6oroFaIda9hQWcJI80n4QLIL2fg3Tg7i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVNIIEACgkQ8dLMyEl6F22P0QCcDlWDKRDoOexEL9sE199E39Ix
WxYAnApLgX/Bb8tHw8Zy9TVOU0qiCtVr
=u+4K
-----END PGP SIGNATURE-----

--h6oroFaIda9hQWcJI80n4QLIL2fg3Tg7i--
