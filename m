From: Loic Dachary <loic@dachary.org>
Subject: State of the erasure code pyramid plugin
Date: Thu, 30 Jan 2014 09:04:15 +0100
Message-ID: <52EA077F.4070402@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="2N2cteqWXw1KioHMKov3sx3epgotVU78X"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:56695 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbaA3IEQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jan 2014 03:04:16 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas-Joachim Peters <andreas.joachim.peters@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2N2cteqWXw1KioHMKov3sx3epgotVU78X
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Your last comment made me realize I took an approach that is more complex=
 than needed (the decode_chunks / encode_chunks methods are not necessary=
), which results in something that is also sub-optimal (it decodes too mu=
ch and has no way to limit decoding to what is strictly necessary althoug=
h this is precisely the point of the pyramid plugin). I see how to resolv=
e it (rewrite recursion in terms of the encode()/decode() API instead of =
the encode_chunks()/decode_chunks() API and I'm half way thru). But since=
 the feature freeze is Friday and given than it's not the only topic I ca=
re about, it is probably better to postpone.=20

I'm quite happy that we now have a sound implementation plan. Even more t=
hat the current API is good enough. What remains to be done is:

* Rewrite of https://github.com/ceph/ceph/pull/1142 with encode()/decode(=
)
* Complete the XOR plugin https://github.com/apeters1971/ceph/tree/wip-xo=
r
* Implement a way ( moving the primary in the same datacenter as a failin=
g OSD ? ) for pools to take advantage of the provided locality

I reorganized the tasks under http://tracker.ceph.com/issues/7266 to keep=
 track of this.=20

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--2N2cteqWXw1KioHMKov3sx3epgotVU78X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLqB38ACgkQ8dLMyEl6F20OnwCcCESDZuerEriSroRJNvdaRW5x
ZawAnRbH4Es5KLXdb2W5/qlG9Qm8Unue
=XznP
-----END PGP SIGNATURE-----

--2N2cteqWXw1KioHMKov3sx3epgotVU78X--
