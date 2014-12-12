From: Thorsten Behrens <tbehrens@suse.com>
Subject: Re: crush: straw is dead, long live straw2
Date: Fri, 12 Dec 2014 10:14:08 +0100
Message-ID: <20141212091408.GN4150@thinkpad.thebehrens.net>
References: <alpine.DEB.2.00.1412081516010.18281@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="prC3/KjdfqNV7evK"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:42820 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965336AbaLLJRV (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Fri, 12 Dec 2014 04:17:21 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1412081516010.18281@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org


--prC3/KjdfqNV7evK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sage Weil wrote:
> Calculating the ln() function is a bit annoying because it is a floating=
=20
> point function and CRUSH is all fixed-point arithmetic (integer-based). =
=20
> The current draft implementation uses a 128 KB lookup table (2 bytes per=
=20
> entry for 16 bits of input precision).  It seems to be about 25% slower=
=20
> than the original straw code in my simple microbenchmark, but I'm not sur=
e=20
> that's a number we should trust since it loops through a zillion inputs=
=20
> and will pull most of the lookup table into the processor caches.
>=20
> We could probably try a few others things:
>=20
[snip]

My Hacker's Delight copy has a number of further variants (on
pp. 215), unfortunately only covering log_2 (which is trivially the
number of leading zeros in the binary representation) and log_10. But
since the logarithms are simply related by a multiplicative constant,
something clever might be doable here with a bit of thinking.

Cheers,

-- Thorsten

--prC3/KjdfqNV7evK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQJ8BAEBCgBmBQJUirHgXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRDREI0NTE4NDRDMTFEMjY1NDlFM0FCNzgx
QzE2REZEQjMwRjRGNERGAAoJEBwW39sw9PTfr3UQAMop08m03gDHNVvduvWUP1d2
O7/1msOu9Ay+yBUl5s7kswBaZynOliB+MchaTcJxpUcKZIvRyjO0b7dgTBfvCF+S
rTyuzrFNb2SMU+mx0CHlv+Vp0bWT5n8BV1ry09pp9EPF/VFvwigPFV9UAEugCSeY
3oTJl0YMEX3LZaviScHcOBY4Ana7NBHaKHxwwamt6fgni3hPoA5SrZ3gz8FCiM3g
eXhmij5X6E9Ht36hVZKWnjfncXavl2hsGJdxs+DBEQwn1XzE6olJT3r24cx22Iuv
GXygLuEQenH0mG8qVTN4cdP9ota0E8UNVjadaM1HFs64/euNOa1ELNHHSvVuvgOl
PE8q2gXnaaDMEPvfsT6HzD8f57+NUqQfl9fVqgalR577QRIk5XcrceHTlvbMsqKD
RNT/vOhOuXae64ylx2fyY6Okk/NOc6E3dlwNLMI3cNrSAJCcnl/Yxi3waFAItyGK
D+exDgY/jAz7o4+xBc4K4eF/on3pXgK5RVdBq3wWHsQq3npxMGaZdrSvWFYRsBKA
/W1z2eOqJlgEs9LEiUoRV+70ql0B65uAjp8/LqUb5oh7aJ31I4KjUtnDuiTTCE4C
kVTM78Fw1AuZBo8/rPvPjWCA9Aehg7F10SVM1eTpAETT+w0WSJw+IqlHVAGIGaNt
gYekFXNJE1CqlcBE3lJe
=7C3Q
-----END PGP SIGNATURE-----

--prC3/KjdfqNV7evK--
