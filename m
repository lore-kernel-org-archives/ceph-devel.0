From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: About ceph_clock_now()
Date: Mon, 25 Jan 2016 15:14:51 -0500
Message-ID: <20160125201451.GC2818@ultraspiritum.redhat.com>
References: <alpine.DEB.2.11.1601130846500.26381@cpach.fuggernut.com>
 <56A4C8D2.6020303@digiware.nl>
 <20160125000337.GA19230@ultraspiritum.redhat.com>
 <56A5E61E.80705@digiware.nl>
 <2002283349.16405061.1453715910495.JavaMail.zimbra@redhat.com>
 <56A5FF84.8080107@digiware.nl>
 <20160125172252.GA2818@ultraspiritum.redhat.com>
 <56A66099.4030501@digiware.nl>
 <1523354716.24670379.1453744826329.JavaMail.zimbra@redhat.com>
 <56A679BB.4090801@digiware.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KDt/GgjP6HVcx58l"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34946 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756906AbcAYUOw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 25 Jan 2016 15:14:52 -0500
Content-Disposition: inline
In-Reply-To: <56A679BB.4090801@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Matt Benjamin <mbenjamin@redhat.com>, Erwan Velu <evelu@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>


--KDt/GgjP6HVcx58l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25/01/2016, Willem Jan Withagen wrote:
> 1)
> Currently the code in Adam's looks like:
> #if defined(CLOCK_MONOTONIC_COARSE)
>         // Linux systems have _COARSE clocks.
>         clock_gettime(CLOCK_MONOTONIC_COARSE, &ts);
> #elif defined(CLOCK_MONOTONIC_FAST)
>         // BSD systems have _FAST clocks.
>         clock_gettime(CLOCK_MONOTONIC_FAST, &ts);
> #else
>         // And if we find neither, you may wish to consult your system's
>         // documentation.
> #warning Falling back to CLOCK_MONOTONIC, may be slow.
>         clock_gettime(CLOCK_MONOTONIC, &ts);
> #endif
>=20
> And this is repeated in a few more locations.
> Moreover, it will be required to do that a few times everytime
> clock_getime is used.

I was originally thinking of just specifying the time constant, but I figur=
ed
that somehow somewhere someone might want to compile on a system without
clock_gettime. (Windows? I don't know.) Or use the fasttime library or some=
thing
where just switching out the constant wouldn't work.

I wouldn't worry about people having to do this every tie they call
clock_gettime, though, since they really ought to be going through the C++ =
Clock
abstraction. (At least, in the context of the Ceph codebase.)

--=20
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9

--KDt/GgjP6HVcx58l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQF8BAEBCgBmBQJWpoI1XxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXREMUY1QjNFRjgyQTI1NjIxNkVERDQxQUNF
OEIyRUY4QzA3NUU1RTIzAAoJEOiy74wHXl4j3wQH/1GBzzMYMOWVkxvxSU16HtZn
YY/soOb3QciIcxSRBFYvC9/Whup8q9OaWIsRLYWfHuIULy5NRh1/BMvo+ASlols1
o5xOpWeqUlHOntmEAPfm7Xi5fgvzgDMWCtQ8noSlKRr4rFAk9pi+Wscdn5nVMNOo
c6fvAWkw/AUH5juWitVSpxxNCNEeZM6cfkO3OU74Vm911Qw0aIhF8TTtlE+VEvMV
8OUKp/U4ve1Et4f6o6Qj4dLbWvBGG8+66Q2NBcqRX+QjQN1LeEoXjekzJ4A0sTeP
6hddaleRYjyukDjocmXmu/NT6cH6jQxsaMHlfQzutMD40ATHIrdFXbiA0biDZjI=
=eQ6o
-----END PGP SIGNATURE-----

--KDt/GgjP6HVcx58l--
