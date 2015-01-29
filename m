From: Loic Dachary <loic@dachary.org>
Subject: rgw backports to giant update
Date: Thu, 29 Jan 2015 01:48:57 +0100
Message-ID: <54C98379.7030100@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Bmf16U7ejD0mUV4aOEiIAhMxTPxlfWart"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:48819 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754755AbbA2BZA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Jan 2015 20:25:00 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Bmf16U7ejD0mUV4aOEiIAhMxTPxlfWart
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Yehuda,

Unless I'm mistaken there currently are no rgw issues scheduled to be bac=
kported to giant (i.e. with the giant word in the backport field of the i=
ssue)[1] that have already been backported to firefly, as part of the v0.=
80.8[2] release or after[3]. You mentionned that about 18 patches backpor=
ted to firefly should also be backported to giant and I was hoping to fin=
d which one exactly thanks to the backport field.

I'll go thru the rgw backports found in v0.80.8 to figure out which one s=
hould be in giant. I don't need anything righ now, this is just an update=
 to let you know things are making progress.

Cheers

[1] inventory of the pending giant v0.87.1 release http://tracker.ceph.co=
m/issues/10501
[2] inventory of the firefly v0.80.8 commits http://tracker.ceph.com/issu=
es/10639
[3] inventory of the pending firefly v0.80.9 release http://tracker.ceph.=
com/issues/10641

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre



--Bmf16U7ejD0mUV4aOEiIAhMxTPxlfWart
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTJg3kACgkQ8dLMyEl6F21YxQCgom8xqYe3JQ0rClGPc3XU32d/
YuUAn16LN6U7KBtn6Zs5RDH4Zb2/WDFb
=mb/C
-----END PGP SIGNATURE-----

--Bmf16U7ejD0mUV4aOEiIAhMxTPxlfWart--
