From: Loic Dachary <loic@dachary.org>
Subject: Re: FAILED assert(peer_missing.count(fromshard))
Date: Fri, 16 Jan 2015 19:16:04 +0100
Message-ID: <54B95564.3030703@dachary.org>
References: <54B93EAD.2040200@dachary.org> <CA+4uBUbcQ8OTg=SMnVN7tA5fGqmcqair=kSKKawGtf_+MDSYSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="dAAp9sUqnFsV6hm8oiEpxDeapImgMtNEr"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:41977 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751492AbbAPSQG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Jan 2015 13:16:06 -0500
In-Reply-To: <CA+4uBUbcQ8OTg=SMnVN7tA5fGqmcqair=kSKKawGtf_+MDSYSA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sjust@redhat.com
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dAAp9sUqnFsV6hm8oiEpxDeapImgMtNEr
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 16/01/2015 19:10, Samuel Just wrote:
> 1) The part where you add the operator<< and change the debug output lo=
oks good.
> 2) The other part looks like it should be an assert?  Or it should
> complain to the central log so that it causes the test to fail at
> least?

Yes.

I'd rather have it report to central log for now instead of asserting. If=
 it asserts it will be impossible to know if it is the source of the prob=
lem or not. If it does not assert and the problem does not show up anymor=
e, it will mean that the origin of this specific problem is that we have =
a bad peer in the ok peers. If it asserts, it may mean that sometime a ba=
d peer is among the good peers but not necessarily that this is the sourc=
e of the problem. If it does not assert and the problem persist it will m=
ean that we have two problems : a bad peer in good peers and the peer_mis=
sing assert, as separate issues.

Does that make sense ?

> 1 and 2 should be separate commits.

Ok.

> -Sam
>=20
> On Fri, Jan 16, 2015 at 8:39 AM, Loic Dachary <loic@dachary.org> wrote:=

>> Hi Sam,
>>
>> In the context of http://tracker.ceph.com/issues/10524 FAILED assert(p=
eer_missing.count(fromshard)) I propose to add some information for when =
it happens:
>>
>> https://github.com/ceph/ceph/pull/3389
>>
>> If what happens really is that a bad peer ends up being added with in =
missing_loc.add_location, that will be a useful information. I tried a nu=
mber of scenarios and could not find the right conditions to reproduce th=
e problem locally. Hopefully this additional information will show me whe=
re to go :-)
>>
>> Cheers
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--dAAp9sUqnFsV6hm8oiEpxDeapImgMtNEr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlS5VWQACgkQ8dLMyEl6F237vwCfU8rl9MpoVf3sd2FmBrmio1V5
1H0An1AX62A73Bp0398VjfxAFmKA9Gvi
=o0+N
-----END PGP SIGNATURE-----

--dAAp9sUqnFsV6hm8oiEpxDeapImgMtNEr--
