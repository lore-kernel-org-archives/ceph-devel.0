From: =?ISO-8859-1?Q?Jo=E3o_Eduardo_Lu=EDs?= <jecluis@gmail.com>
Subject: Re: TOO SLOW data write speed and delete.. NEED HELP
Date: Tue, 13 Mar 2012 19:33:40 +0000
Message-ID: <4F5FA114.7070806@gmail.com>
References: <loom.20120313T113524-750@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCAB23848FD68C486E14D38A6"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:33239 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753866Ab2CMTdp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Mar 2012 15:33:45 -0400
Received: by gghe5 with SMTP id e5so944994ggh.19
        for <ceph-devel@vger.kernel.org>; Tue, 13 Mar 2012 12:33:45 -0700 (PDT)
In-Reply-To: <loom.20120313T113524-750@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: madhusudhana <madhusudhana.u.acharya@gmail.com>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCAB23848FD68C486E14D38A6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/13/2012 10:39 AM, madhusudhana wrote:
> Hi all,
> Can someone PLEASE help me to understand why data copying (simple cp
> or rsync) is SO slow in CEPH ? And delete command (\rm -rf) for removin=
g
> a small (175M) directory is taking so much of time. Because of this,
> i am not able to complete evaluation of ceph using my actual workload. =

>=20
> I am hereby requesting all to help me in finding out the reason for=20
> slow write/delete in my ceph cluster. I am really trying hard to=20
> complete the evaluation with actual workload but not able to copy the
> data whats required for evaluation to ceph cluster bcz of slow copy.
>=20
> I really appreciate any help on this.
>=20
> Thanks in advance
> Madhusudhan
>=20

Hi Madhusudhan,

Are you using Btrfs? And are you taking snapshots while you're
performing those operations?

--=20
Jo=E3o Eduardo Lu=EDs
gpg key: 477C26E5 from pool.keyserver.eu


--------------enigCAB23848FD68C486E14D38A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJPX6EUAAoJEJ9vvxhHfCblamwH/AmXQkDDCHTCBijDHnm87fYx
hXrVAYVQBR8zqUMOWwtwvSvgpMMaWWbKXJNvb76KZa/2w8mMBhOm4wV/LyzOE9uc
kPmNnqkcrjAoT/Q1lLh9VXB7fDANLWZvDs3mdH+yt8ahXyuV3ihYjh4LxcFhqbD3
cXDjxUhO61qOTw2h6tEx1gz13dnbqnhAX+A4DPeJXmIFe/DhcjYppAeK1NYaryLC
xIJBeDMQvx9r1b8P3UY5UeHP/2d34HFZ3nE/K1Hm45WBrgo1PF/8cb/eRep+2fJ3
uURHn6/8tgXYOZ/UzC5p0uXnTUT64pi9ElproEWHoy0hfgO4si9Np049LDc49TQ=
=y8m1
-----END PGP SIGNATURE-----

--------------enigCAB23848FD68C486E14D38A6--
