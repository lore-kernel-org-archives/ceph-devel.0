From: Dmitry Smirnov <onlyjob@debian.org>
Subject: Re: issue 8747 / 9011
Date: Mon, 22 Sep 2014 11:13:49 +1000
Message-ID: <1545276.B1zDlULSSV@debstor>
References: <alpine.DEB.2.00.1409191642270.19460@cobra.newdream.net> <2949490.exWB3TExxB@debstor> <alpine.DEB.2.00.1409211227510.27396@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4065131.A9DlpCGn8V"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:38833 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbaIVBOA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Sep 2014 21:14:00 -0400
Received: by mail-pa0-f44.google.com with SMTP id eu11so2541036pac.31
        for <ceph-devel@vger.kernel.org>; Sun, 21 Sep 2014 18:14:00 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1409211227510.27396@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org


--nextPart4065131.A9DlpCGn8V
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Sun, 21 Sep 2014 12:28:23 Sage Weil wrote:
> Is there any possibility of enabling logging on your osds (debug ms =3D=
 1,
> debug osd =3D 20) so that we can capture this?

I'll put it on my TODO list but I won't be able to do it anytime soon..=
.

Meanwhile is there any chance for #8752 to get some attention? It is re=
garding=20
inconsistent PGs on RBD caching pool. Thanks.

=2D-=20
Cheers,
 Dmitry Smirnov
 GPG key : 4096R/53968D1B

--nextPart4065131.A9DlpCGn8V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAABCAAGBQJUH3fTAAoJEFK2u9lTlo0b+gYP/2Fo0EqjeD2xYMXd38vBz2hO
DzFK1Jk/AWTkl1ht3xVAYL7I6tssPAf3KvkRNbg/D2G+AQSgGva/mdQY3CsSt0Zx
gtjGuAInAss0zHK7uEabDduTY3jFdfbBRlrHtsaJ3SFr8OMIwHK/ThFcQVD4KWR3
zxL81+KHgvwLbzPLVCBOB5U/q0mpnnqj2/G/gTUQeL65nEA1wxlJwfldVfWQJTux
3FSh62r5N/6AoMxMtZw/xhd295iiZdZnTl49SIjMEXEYf+NQ8Lk4HiODWfiQ6T2n
AoCdNOyRUa7tQrShUW/4F03hnK080kI36nO9f5I91f1WQ/CkNrg8vSso8W/XyFv8
asUM+mbtXs5DBlngtBzoSMOanmHtPTXCl5ij1keov99NwmD+V0t0Fl4Va9xLIvJd
UDj6YWN2EarFtWDPNmP3y/mAzzfxT6JVA6r1BEP+oXQZQFiq2315O/ARKq2t8K5R
UhWTnGRGEvFmlcPNyeec2iiQRfNh++ZTAr5MQZ/5NM+3HL61aDiRttKtoesS+MSo
L7OWlbBx/1Ike/jiwrEP/ke/jiWHfcs8Jk4s6SIS+mft5QY1WlF1I9Zjs8qwP9e8
X8XS5xmLsGrx6FkAduVGwQdMfeN3iP5itZsLQ7EDhsn4bwEqG4vK90SHFbKvdNqy
rTzBzxdCXL3QFdiwmTLS
=3wZH
-----END PGP SIGNATURE-----

--nextPart4065131.A9DlpCGn8V--

