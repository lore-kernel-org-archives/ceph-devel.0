From: Loic Dachary <loic@dachary.org>
Subject: Stable releases team call for participation
Date: Sat, 01 Aug 2015 10:26:21 +0200
Message-ID: <55BC82AD.4070603@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="kEW2sWoaJ7WwJlO3jOMibmnenLpd09a5v"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:59847 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751066AbbHAI00 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 1 Aug 2015 04:26:26 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: Abhishek L <abhishek.lekshmanan@gmail.com>, Nathan Cutler <ncutler@suse.cz>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kEW2sWoaJ7WwJlO3jOMibmnenLpd09a5v
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

TL;DR: If you have one day a week to work on the next Ceph stable release=
s [1] your help would be most welcome.

The Ceph "Long Term Stable" (LTS) releases - currently firefly[3] and ham=
mer[4] - are used by individuals, non-profits, government agencies and co=
mpanies for their production Ceph clusters. They are also used when Ceph =
is integrated into larger products, such as hardware appliances. Ceph pac=
kages for a range of supported distribution are available at http://ceph.=
com/. Before the packages for a new stable release are published, they ar=
e carefully tested for potential regressions or upgrade problems. The Cep=
h project makes every effort to ensure the packages published at http://c=
eph.com/ can be used and upgraded in production.

The Stable release team[5] plays an essential role in the making of each =
Ceph stable release. In addition to maintaining an inventory of bugfixes =
that are in various stages of backporting[6], in most cases we do the act=
ual backporting ourselves[7]. We also run integration tests involving hun=
dreds of machines[8] and analyze the test results when they fail[9]. The =
developers of the bugfixes only hear from us when we're stuck or to make =
the final decision whether to merge a backport into the stable branch. Ou=
r process is well documented[1] and participating is a relaxing experienc=
e (IMHO ;-). Every month or so we have the satisfaction of seeing a new s=
table release published.

Nathan Cutler (SUSE) drives the next Firefly release[10] and Abhishek Lek=
shmanan (Reliance Jio Infocomm Ltd.) drives the next Hammer release[11]. =
Loic Dachary (Red Hat), one of the Ceph core developers, oversees the pro=
cess and provides help and advice when necessary. After these two release=
s are published (which should happen in the next few weeks), the roles wi=
ll change and we would like to invite you to participate. If you're emplo=
yed by a company using Ceph or doing business with it, maybe your manager=
 could agree to give back to the Ceph community in this way. You can join=
 at any time and you will be mentored while the ongoing releases complete=
=2E When the time comes (and if you feel ready), you will be offered a se=
at to drive the next release.

Cheers

[1] Ceph Stable releases home page http://tracker.ceph.com/projects/ceph-=
releases/wiki/HOWTO
[2] Ceph Releases timeline http://ceph.com/docs/master/releases/
[3] Firefly v0.80.10 http://ceph.com/docs/master/release-notes/#v0-80-10-=
firefly
[4] Hammer v0.94.2 http://ceph.com/docs/master/release-notes/#v0-94-2-ham=
mer
[5] Stable release team http://tracker.ceph.com/projects/ceph-releases
[6] Hammer backports http://tracker.ceph.com/projects/ceph/issues?query_i=
d=3D78
[7] Backporting commits http://tracker.ceph.com/projects/ceph-releases/wi=
ki/HOWTO_backport_commits
[8] Integration tests http://tracker.ceph.com/projects/ceph-releases/wiki=
/HOWTO_run_integration_and_upgrade_tests
[9] Forensic analysis of integration tests http://tracker.ceph.com/projec=
ts/ceph-releases/wiki/HOWTO_forensic_analysis_of_integration_and_upgrade_=
tests
[10] Firefly v0.80.11 http://tracker.ceph.com/issues/11644
[11] Hammer v0.94.3 http://tracker.ceph.com/issues/11990

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--kEW2sWoaJ7WwJlO3jOMibmnenLpd09a5v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlW8gq0ACgkQ8dLMyEl6F20TeACgnsNSmO20QW4A1wHg9YeaHuvZ
FlUAoLAXaEy3lsvSXD2n/xM0nrol1sAX
=9Omy
-----END PGP SIGNATURE-----

--kEW2sWoaJ7WwJlO3jOMibmnenLpd09a5v--
