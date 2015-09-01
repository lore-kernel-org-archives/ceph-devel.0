From: Loic Dachary <loic@dachary.org>
Subject: Replacing Pending Backports with Backports in the Ceph bug queue
 - no subprojects
Date: Tue, 01 Sep 2015 23:24:27 +0200
Message-ID: <55E6178B.8050501@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="HMQlOkSdhw8k1VltTh7aoDxm4DdEE7hNE"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:47773 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752633AbbIAVY3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Sep 2015 17:24:29 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HMQlOkSdhw8k1VltTh7aoDxm4DdEE7hNE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Sam,

I modified the http://tracker.ceph.com/projects/ceph/issues?query_id=3D47=
 "Bug queue - no subprojects" to not display the "Pending Backports" and =
include the "Backport" tracker instead. Now that there is a separate Back=
port tracker, the backporting activity that used to be logged in "Pending=
 Backports" issues is now logged in the matching "Backport" issue(s) and =
that seemed more appropriate.

If you think this is not a good idea let me know and I'll revert.

Cheers

P.S. I know you're on vacation, this is a message for when you're back ;-=
)

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--HMQlOkSdhw8k1VltTh7aoDxm4DdEE7hNE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXmF4sACgkQ8dLMyEl6F20/+QCfRhymkYcIPuVRfkqgqL1LInJN
10AAmwXtmcNC1fi9coFlsRnn1FmR5k4g
=8ZZf
-----END PGP SIGNATURE-----

--HMQlOkSdhw8k1VltTh7aoDxm4DdEE7hNE--
