From: Loic Dachary <loic@dachary.org>
Subject: Re: [PATCH v3 1/4] buffer: add an aligned buffer with less alignment
 than a page
Date: Thu, 02 Oct 2014 16:17:44 +0200
Message-ID: <542D5E88.40409@dachary.org>
References: <1410796508-28711-1-git-send-email-j@jannau.net> <1411994072-18850-1-git-send-email-j@jannau.net> <1411994072-18850-2-git-send-email-j@jannau.net> <54295E26.4080705@dachary.org> <20141002121212.GN2542@jannau.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="067169Rlu99BqKI1rKRKHlDFp6utvVL0U"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:36657 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752424AbaJBORu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Oct 2014 10:17:50 -0400
In-Reply-To: <20141002121212.GN2542@jannau.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--067169Rlu99BqKI1rKRKHlDFp6utvVL0U
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 02/10/2014 14:12, Janne Grunau wrote:
> Hi,
>=20
> On 2014-09-29 15:27:02 +0200, Loic Dachary wrote:
>>
>> I think the implementation of the bufferlist n_align_sized functions i=
s missing. That showed when adding unit tests for them
>=20
> yes, I didn't saw the need for it.

Then the declaration should be removed don't you think ?

>=20
>> https://github.com/dachary/ceph/commit/fd01824f1681edd0ec029b02318b6c4=
0b923c156
>>
>> Feel free to pick up where I left, I won't work on them any more today=
 ;-)
>=20
> Did you continue to work on them? If not I'll start from there now.
>=20

I was busy elsewhere, it's all yours if you want them :-)

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--067169Rlu99BqKI1rKRKHlDFp6utvVL0U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQtXogACgkQ8dLMyEl6F20DDQCcDca0ckraHeQjqRlVOHE9k619
cy8Anj+ZZlBb1QED3Vex2USc49xKTDG4
=jLSv
-----END PGP SIGNATURE-----

--067169Rlu99BqKI1rKRKHlDFp6utvVL0U--
