From: Loic Dachary <loic@dachary.org>
Subject: Re: rationale for a PGLog::merge_old_entry case
Date: Tue, 04 Jun 2013 14:14:05 +0200
Message-ID: <51ADDA0D.5010007@dachary.org>
References: <51AB2803.9010807@dachary.org> <CA+4uBUaN7p8kJw5o8i0L9WxQ5j9UmrAb09N6a8jFiQAWkVYSpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig604710DB5D35ABEE153DF2BF"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:52592 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471Ab3FDMOJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Jun 2013 08:14:09 -0400
In-Reply-To: <CA+4uBUaN7p8kJw5o8i0L9WxQ5j9UmrAb09N6a8jFiQAWkVYSpg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig604710DB5D35ABEE153DF2BF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sam,

Thanks for the explanation. I misread the third case, my description was =
incorrect. I amended https://github.com/ceph/ceph/pull/340 accordingly.

Cheers

On 06/03/2013 10:28 PM, Samuel Just wrote:
> In all three cases, we know the authoritative log does not contain an
> entry for oe.soid, therefore:
>=20
> If oe.prior_version > log.tail, we must already have processed an
> earlier entry for that object resulting in the object being correctly
> marked missing (or not) (specifically, the entry for
> oe.prior_version).
>=20
> If log.tail >=3D oe.prior_version > eversion_t(), the missing entry
> should have need set at oe.prior_version (revise_need).
> oe.prior_version cannot be divergent because all divergent entries
> must fall within the log (otherwise, we would have backfilled).
>=20
> If oe.prior_version =3D=3D eversion_t(), the object no longer exists, a=
nd
> the object should be removed from the missing set.
>=20
> Hope that helps.
> -Sam
>=20
> On Sun, Jun 2, 2013 at 4:09 AM, Loic Dachary <loic@dachary.org> wrote:
>> Hi Sam,
>>
>> TL;DR:
>>
>> When there no new entry, what is the rationale for merge_old_entry to =
remove the object from missing only if the tail is eversion_t() and the o=
bject prior_version is also eversion_t() ?
>> https://github.com/dachary/ceph/blob/f58299db098d5f18c817b516fa6ffaa76=
245e57d/src/osd/PGLog.cc#L330
>>
>> Long version:
>>
>> The conditions are created with:
>>
>>     info.log_tail =3D eversion_t();
>>     oe.soid.hash =3D 1;
>>     oe.op =3D pg_log_entry_t::DELETE;
>>     oe.prior_version =3D eversion_t();
>>
>>     missing.add(oe.soid, eversion_t(1,1), eversion_t());
>>
>> as shown in
>> https://github.com/dachary/ceph/blob/f58299db098d5f18c817b516fa6ffaa76=
245e57d/src/test/osd/TestPGLog.cc#L467
>> I double checked with gdb and when called with
>>
>> EXPECT_FALSE(merge_old_entry(t, oe, info, remove_snap, dirty_log));
>> https://github.com/dachary/ceph/blob/f58299db098d5f18c817b516fa6ffaa76=
245e57d/src/test/osd/TestPGLog.cc#L481
>>
>> it reaches
>>
>> missing.rm(oe.soid, missing.missing[oe.soid].need);
>> https://github.com/dachary/ceph/blob/f58299db098d5f18c817b516fa6ffaa76=
245e57d/src/osd/PGLog.cc#L330
>>
>> and the expected side effects are observed:
>>
>>     EXPECT_FALSE(dirty_log);
>>     EXPECT_TRUE(remove_snap.empty());
>>     EXPECT_TRUE(t.empty());
>>     EXPECT_FALSE(missing.have_missing());
>>     EXPECT_TRUE(log.empty());
>>     EXPECT_EQ(0U, ondisklog.length());
>> https://github.com/dachary/ceph/blob/f58299db098d5f18c817b516fa6ffaa76=
245e57d/src/test/osd/TestPGLog.cc#L483
>>
>> Cheers
>>
>> --
>> Lo=EFc Dachary, Artisan Logiciel Libre
>> All that is necessary for the triumph of evil is that good people do n=
othing.
>>

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig604710DB5D35ABEE153DF2BF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlGt2g0ACgkQ8dLMyEl6F20DWwCgifmulD2g1zZ9sQe1TaYN9nud
qw8An2wRY7SL/bbmNUG8sHym0R+usCHL
=Qr65
-----END PGP SIGNATURE-----

--------------enig604710DB5D35ABEE153DF2BF--
