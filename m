From: Loic Dachary <loic@dachary.org>
Subject: a home for backport snippets
Date: Thu, 5 Nov 2015 14:20:09 +0100
Message-ID: <563B5789.7050006@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="RjB6hnwii7FNCEugVqSBMX2Df3VQC7g5V"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:55316 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1031209AbbKENUQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Nov 2015 08:20:16 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>, Abhishek L <abhishek.lekshmanan@gmail.com>
Cc: Nathan Cutler <ncutler@suse.cz>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RjB6hnwii7FNCEugVqSBMX2Df3VQC7g5V
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Today, Nathan and I briefly discussed the idea of collecting the backport=
 snippets that are archived in the wiki at http://tracker.ceph.com/projec=
ts/ceph-releases/wiki/HOWTO. We all have copies on our local disks and al=
though they don't diverge much, this is not very sustainable. It was real=
ly good as we established the backport workflows. And it would have been =
immensely painful to maintain a proper software while we were changing th=
e workflow on a regular basis. But it looks like we now have something st=
able.

Early this year ceph-workbench[1] was started with the idea of helping wi=
th backports. It is a mostly empty shell we can now use to collect all th=
e snippets we have. Instead of adding set-release[2] to the script direct=
ory of Ceph, it would be a subcommand of ceph-workbench, like so:

  ceph-workbench set-release --token $github_token --key $redmine_key

What do you think ?

Cheers

[1] https://pypi.python.org/pypi/ceph-workbench
[2] https://github.com/ceph/ceph/pull/6466
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--RjB6hnwii7FNCEugVqSBMX2Df3VQC7g5V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlY7V4kACgkQ8dLMyEl6F20IpgCgg5BiDbSRBBmnqvBWTd5Xd1/f
BwsAn04tno/oOvghjjdlWIjk6jLLorPb
=wQ67
-----END PGP SIGNATURE-----

--RjB6hnwii7FNCEugVqSBMX2Df3VQC7g5V--
