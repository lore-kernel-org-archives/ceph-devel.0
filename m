From: Loic Dachary <loic@dachary.org>
Subject: [Backport] assigning a pull request when asking permission to merge
Date: Sun, 06 Sep 2015 23:47:13 +0200
Message-ID: <55ECB461.6020805@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Ui6DW2bgD4MRlQFM0bNpcKqbI1R9osDAd"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:50619 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752178AbbIFVrQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 6 Sep 2015 17:47:16 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek.lekshmanan@gmail.com>, Abhishek Varshney <abhishek.varshney@flipkart.com>, Nathan Cutler <ncutler@suse.cz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ui6DW2bgD4MRlQFM0bNpcKqbI1R9osDAd
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Today I realized that when we ask for permission to merge [1], we don't u=
sually assign the pull request to the person who is supposed to answer. T=
his may not be of consequence if thre is just one pull request to look at=
=2E But it's not uncommon to have half a dozen such pull requests after a=
 suite passed. When the person reads her/his mail, a few are addressed an=
d more often than not the rest is postponed for when there is time.=20

Only they don't show up anywhere in the person list of TODO things, there=
fore it's frequent that we have to send a reminder. Instead, it's probabl=
y easier on everyone if we assign the pull request to the person next to =
act in that specific case. It's not something I usually do for pull reque=
sts that are assigned to me, because it's the best way for me to complete=
ly forget about such pull requests. But in this case, since each pull req=
uest is linked to an issue and since we scrub these issues at least on a =
weekly basis, there is no risk of us forgetting.

What do you think ?

Cheers

P.S. I did that for all pending hammer pull requests, we'll see if that i=
mproves things ;-)

[1] http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_merge_commi=
ts_from_the_integration_branch

---
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--Ui6DW2bgD4MRlQFM0bNpcKqbI1R9osDAd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXstGEACgkQ8dLMyEl6F205VQCeNBgs/WB6afnRdwJGOa1Kf/cL
JBEAoJlDcgqcglw+U34O1258O2CwYryV
=dvS4
-----END PGP SIGNATURE-----

--Ui6DW2bgD4MRlQFM0bNpcKqbI1R9osDAd--
