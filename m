From: Loic Dachary <loic@dachary.org>
Subject: Re: add stop_scrub command for ceph
Date: Mon, 23 Mar 2015 09:42:34 +0100
Message-ID: <550FD1FA.6040604@dachary.org>
References: <CANE=7sXF+_s7eOaLCsLW9scwrdbpfzGWqVfz86u399PCs1eNAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="E2OiBhh98Be75dxO6vLgwDWC8ebxSBwfs"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:34809 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751985AbbCWIml (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Mar 2015 04:42:41 -0400
In-Reply-To: <CANE=7sXF+_s7eOaLCsLW9scwrdbpfzGWqVfz86u399PCs1eNAQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xinze Chi <xmdxcxz@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E2OiBhh98Be75dxO6vLgwDWC8ebxSBwfs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I like the idea of a fine grain scrub control :-)

Cheers

On 23/03/2015 08:47, Xinze Chi wrote:
> hi ceph:
>=20
>     Currently, there is not a command which can stop scrubbing when
> the pg is doing scrub or deep
> scrub. What about add a command to support it ? I think this s every
> used for system administrator.
>=20
>      I have add a issue to track it. http://tracker.ceph.com/issues/112=
02.
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--E2OiBhh98Be75dxO6vLgwDWC8ebxSBwfs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUP0foACgkQ8dLMyEl6F219XwCgmYoFwUdrl8XlDVWd47f7lW8t
ewgAn3KJNhl9GRf8T/kDa1R/lm7RTYi3
=vh5G
-----END PGP SIGNATURE-----

--E2OiBhh98Be75dxO6vLgwDWC8ebxSBwfs--
