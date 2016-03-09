From: Abhishek L <abhishek@suse.com>
Subject: Re: master build failure with boost 1.60
Date: Wed, 09 Mar 2016 10:57:35 +0100
Message-ID: <86io0wrn1s.fsf@linux-stsn.suse>
References: <20160307144944.GA21590@pxe-sup5.sup.suse.de> <CAANLjFq3bC+-3LZ4PzyqY5W5pSfHGVQp=BAW986M67P2g8K+dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:60471 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932AbcCIJ6K (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Wed, 9 Mar 2016 04:58:10 -0500
In-reply-to: <CAANLjFq3bC+-3LZ4PzyqY5W5pSfHGVQp=BAW986M67P2g8K+dA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Karol Mroz <kmroz@suse.com>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Robert LeBlanc writes:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> Karol,
>
> I think I may have already resolved this with a patch I was already
> working on. Can you pull in https://github.com/ceph/ceph/pull/7984 and
> see if it resolves the issue?

I tried applying 7984 atop of current master, it was still failing, on
similar errors with WeightedPriorityQueue, here is a log http://ix.io/pYl

Regards
Abhishek
>
> Thanks,
> -----BEGIN PGP SIGNATURE-----
> Version: Mailvelope v1.3.6
> Comment: https://www.mailvelope.com
>
> wsFcBAEBCAAQBQJW3zreCRDmVDuy+mK58QAAiX0P/RB6HZOaBiDkh89z37wf
> LG+sMH84PigUiGQ/dW4NpPC96pBfpOeKYxU0ZFjV1A2jkfjGxKsqNr6gSioE
> wnaN8u5emoND5nb/O4psm+9EQguLcSsfLVvt+1JCOUMdRibrZVfBsjJ1hfhu
> rE6exUGmabR+sTgC0fL2Rd00+FLN4SeqYiEkH/YhRMPoX7sNAgrwlj6z2N7E
> nS8aUZTZVzHxoWh+QwLdKuE6QSd8EPh9L2BQhqjrhERPh4SyG5XfK97p77O+
> dSOiAYx1Ecz1qjHQEI6Ml5pPAKTqJSEhFOgDdDguYzN1E+uBb8eJSB0ZB6M3
> hPbuEKIg/nVa06LL2ZMgRpkC327xjtPnSsExDGfR4fEN9zv3TCMmJ9X+YDrS
> dAKItZCss64CXOWATHhx1LKBHusl4Cu9y8EZL80/coKJuqfQs0OCnjmGoxHF
> xwqp7AaiKu5jh6sNRT/VbJxvuWTz9/G5iznjphXyk/zVeit5SYjK5HozIC6y
> em7H+kcQJl/JluA82bixtM5j+o+kcx9h3Jxbymf2g6XlFQMSQ6V3l3N/AO79
> yXXpiBUrRInP8YzQvCjPLREPWPQTSadRdAUfaE4NSu9ZC9/TtoTyrf0NutUT
> /qUfEXCOQJSNuXIelo1Fp0WKCgE31zPcgGnBroejTZs+A5LlMzWLcsKZaKh0
> qIzs
> =3DxE7o
> -----END PGP SIGNATURE-----
> ----------------
> Robert LeBlanc
> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>
>
> On Mon, Mar 7, 2016 at 7:49 AM, Karol Mroz <kmroz@suse.com> wrote:
>> Hi folks,
>>
>> We've recently hit a build failure on ceph master for which Abhishek has=
 opened
>> a bug: http://tracker.ceph.com/issues/14998.
>>
>> Our rolling distribution (openSUSE Tumbleweed) has pushed out boost 1.60
>> which looks to be at the heart of the failure. Is boost 1.60 to be suppo=
rted in
>> Jewel?
>>
>> Thanks!
>>
>> --
>> Regards,
>> Karol


=2D-=20
Abhishek

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"; name="signature.asc"; description="Digital signature"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJW3/OaAAoJEPnwZB8bZe1fHYsH/Awu5hNWZOtmDwcrpSUWOiEC
3YSvOsTTWe6POWzIhKXTD/z0msC/Sne87kWpMBFPOc/0RUDLMvsoNGP02SJtPGpc
Na4M4l0BeJwfuXnboIXnJUsA73Te92S3XfNdpMzDtliG8T9+kbw8Db6QG57MJXxa
SCCRaTpUsgItbnekKABsRX9UaY2UvmuYGoec9oa+zHYucHaxTrWOX/4cjuPFGwiH
wIbcBdyYSbgnc1LI3k6C9F7ldgqh2wORZH7up8aRPi1TrJDUokTNjUX8Ho9nL41M
VLK6lqAcSISgU8YbcGJAS5R1BTCnBMQR0igvYVkWSHqyW4Eum6qYS8zYbI5tUPI=
=GRgC
-----END PGP SIGNATURE-----
--=-=-=--
