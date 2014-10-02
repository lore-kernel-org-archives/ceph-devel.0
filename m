From: Dmitry Smirnov <onlyjob@debian.org>
Subject: Re: issue #8752 (inconsistent PGs on RBD caching pool)
Date: Thu, 02 Oct 2014 23:47:13 +1000
Message-ID: <3415192.gCaj5vu5sy@debstor>
References: <alpine.DEB.2.00.1409191642270.19460@cobra.newdream.net> <1545276.B1zDlULSSV@debstor> <alpine.DEB.2.00.1409211900410.27396@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1441124.5xFbHFSNId"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:43747 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498AbaJBNr1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Oct 2014 09:47:27 -0400
Received: by mail-pa0-f54.google.com with SMTP id ey11so2419995pad.41
        for <ceph-devel@vger.kernel.org>; Thu, 02 Oct 2014 06:47:26 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1409211900410.27396@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org


--nextPart1441124.5xFbHFSNId
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Sun, 21 Sep 2014 19:01:52 Sage Weil wrote:
> This is one we have never seen in our QA environment, and no real lea=
ds.

I'm much surprised about this... Is it really that unusual to use repli=
cated=20
caching pool in front of RBD erasure pool? All my OSDs are Btrfs-based =
and=20
recently I've upgraded all kernels (i.e. kernel RBD clients) to 3.16.3.=


Unlike some shifty issues that may be hard to replicate this particular=
 one=20
was very persistent and noticeable, no effort to reproduce at all. I've=
 been =20
observing it for several months already...

It is unlikely that I have anything special in my v0.80.5 cluster's=20
configuration...


> There are a couple slightly different scrub issues that pop up
> occasionally that we are trying to nail down, but this one is a bit
> different.  Being able to reliably reproduce it and generate logs is =
the
> usual strategy...

Please advise what kind of logs could be useful. Something like "(debug=
 ms =3D=20
1, debug osd =3D 20)" from primary OSD where inconsistent PG lies at a =
time when=20
"scrub" command is given?

Thanks.

=2D-=20
All the best,
 Dmitry Smirnov.

--nextPart1441124.5xFbHFSNId
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAABCAAGBQJULVdmAAoJEFK2u9lTlo0bHJYQAK4PJINRQC9NOYc5AvJtBZFg
IllY1qHVSXoVbb56xz/ZwnmAo5kVIeCLHSV7R3C488znAcgF4+M72j0vavzTFnAf
fhoohlYj4ky5qZIVYbVdEOInEyr3j+Zplb8IP73xcEVzxTeZ9Hu9YAlNLcnq0Dum
z/y6AESc81QZTNeavxBubBhiHdDmJ8Xx++rEsW45WWcml0Kpxwwr5Wb7rq0c1Vjw
UhXOabRS8FPx8uhsuWEnaa639q8i7fzQQLHnaKJth51frBPo3+tChvu0BVs7U1HT
Pa+8CFx+C7qvoiFr1M/ep0lbMyRnOIEvj2Di/tpICm2wgbXb3hKweHLQ3/UsIJxH
t6ftbwddj3NyRUzp+/Svm59zJC9e6wgqrxcGV+bRm4eCvb75Muyg71H0botP7q34
4GITLybjAb955n7iAxk5XIN3R1vHa1YhLG06iHWHwrkI40lj9aOQDxoC03gCRFC1
BqBW/MbPD5V4ouGgrGuCA2fr24UL9/hHNAum2MKofn6ThM0KMYNafC5GeRuL5Eqa
z6R9VpQ3nfGGkfNqnRgTXq5/n8YdwxEhowU0m7GX3Zf62OcTKhsudTajYqlXcjjx
MDysB2HMr5Vfh4mdIi5/xmtE62RGg65xs2sHuys49sYFph5UZMmlDCxpEmWds+YJ
XWzjIC1zfSxSesHu5/xR
=5nYo
-----END PGP SIGNATURE-----

--nextPart1441124.5xFbHFSNId--

