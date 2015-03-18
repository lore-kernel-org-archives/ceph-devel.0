From: Loic Dachary <loic@dachary.org>
Subject: Ceph stable releases home page
Date: Wed, 18 Mar 2015 22:34:51 +0100
Message-ID: <5509EF7B.1010908@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="kqDxhsko0O6Jfs12A2raKE0WArIpd2FGu"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:60502 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755796AbbCRVey (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Mar 2015 17:34:54 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id A87694210B
	for <ceph-devel@vger.kernel.org>; Wed, 18 Mar 2015 22:34:51 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kqDxhsko0O6Jfs12A2raKE0WArIpd2FGu
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

The Ceph stable releases now have a home page : http://tracker.ceph.com/p=
rojects/ceph-releases/. It is intended to be a convenient landing page fo=
r people working on backports (listed as "Developers") and for people int=
erested in following the progress of a given release. It contains links t=
o the pending issues being backported to the next stable release:
=09
    dumpling pending issues http://tracker.ceph.com/projects/ceph/issues?=
query_id=3D71
    firefly pending issues http://tracker.ceph.com/projects/ceph/issues?q=
uery_id=3D75
    giant pending issues http://tracker.ceph.com/projects/ceph/issues?que=
ry_id=3D68

If an issue is not listed where it should, feel free to comment on it and=
 ask that it is included.

There is one issue per release (http://tracker.ceph.com/projects/ceph-rel=
eases/issues) and the description is updated when progress is made.

For instance, the latest Firefly being prepared (v0.80.10) is at http://t=
racker.ceph.com/issues/11090. The Workflow part of the description ( http=
://tracker.ceph.com/issues/11090#Workflow ) list the chronological steps =
and lines marked with IN PROGRESS show at which stage it is. The inventor=
y ( http://tracker.ceph.com/issues/11090#Inventory ) groups all pull requ=
ests, issues, commits collected from the tracker, the git repository and =
git hub pull requests ( as cross referenced by http://workbench.dachary.o=
rg/dachary/ceph-workbench ). The inventory also lists the GO / NO GO deci=
sion of each Ceph component lead ( as listed at http://ceph.com/docs/mast=
er/dev/development-workflow/#resolving-bug-reports-and-implementing-featu=
res ).=20

The bulk of the description is the analysis of teuthology integration tes=
ts, grouped by project. For instance the RADOS tests (http://tracker.ceph=
=2Ecom/issues/11090#rados) show two runs and no regression. The second ru=
n was necessary because external factors interfered with the tests (machi=
nes broke, DNS problems etc.). The RBD run was good the first time ( http=
://tracker.ceph.com/issues/11090#rbd ). And the RGW run revealed that a t=
est had to be adapted ( http://tracker.ceph.com/issues/11090#rgw ). In a =
nutshell, the more lines there are for a given run, the more troubles had=
 to be solved.

I'd be happy to answer any question you may have and hopefully clarify ho=
w backports are being done and what to expect for the next point release.=


Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--kqDxhsko0O6Jfs12A2raKE0WArIpd2FGu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUJ73sACgkQ8dLMyEl6F23HYACfUaLGSluzqHCxL3sprCQBvw1O
jlAAnRnLrjachhJKvBw2UVvfgjdQuZfH
=2a0X
-----END PGP SIGNATURE-----

--kqDxhsko0O6Jfs12A2raKE0WArIpd2FGu--
