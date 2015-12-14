From: Loic Dachary <loic@dachary.org>
Subject: Stable release HOWTO: hunt for lost page
Date: Mon, 14 Dec 2015 15:20:12 +0100
Message-ID: <566ED01C.2020306@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="cFBmQ36VegOEcPjEUutrrn8ccRXNjWmhB"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:49831 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750898AbbLNOUO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Dec 2015 09:20:14 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>, Abhishek L <abhishek.lekshmanan@gmail.com>, Abhishek Varshney <abhishek.varshney@flipkart.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cFBmQ36VegOEcPjEUutrrn8ccRXNjWmhB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

It looks like we've lost http://tracker.ceph.com/projects/ceph-releases/w=
iki/HOWTO_triage_incoming_backport_pull_requests . We can re-write it, of=
 course, it's not that complex. But looking at the index I can't find it =
( http://tracker.ceph.com/projects/ceph-releases/wiki/index ) and the act=
ivity backlog ( http://tracker.ceph.com/projects/ceph-releases/activity?u=
tf8=3D%E2%9C%93&show_issues=3D1&show_wiki_edits=3D1 ) does not show an ev=
ent when a page is deleted.=20

I suppose it's an accident and I propose we disable the page deletion fea=
ture to avoid such mistakes in the future (pages can be renamed to things=
 like REMOVE-ME instead ;-).

What do you think ?

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--cFBmQ36VegOEcPjEUutrrn8ccRXNjWmhB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZu0BwACgkQ8dLMyEl6F234PACeIXqevuHYNaD4hrmZQjDGWmVW
fZcAoLLoR8YEFU4Nm9XEoOKLFI9VMzV+
=/NXK
-----END PGP SIGNATURE-----

--cFBmQ36VegOEcPjEUutrrn8ccRXNjWmhB--
