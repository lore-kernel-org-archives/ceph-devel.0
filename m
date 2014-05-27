From: Loic Dachary <loic@dachary.org>
Subject: Re: durability model
Date: Tue, 27 May 2014 16:24:16 +0200
Message-ID: <5384A010.4080300@dachary.org>
References: <1401131148.7008.YahooMailNeo@web165003.mail.bf1.yahoo.com> <CAHxYaFN6R3F6Tn0Vnh9N+pAXhOT8F7+gYLTzTgonn==GJUpX_w@mail.gmail.com> <1401197435.39621.YahooMailNeo@web165002.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="snRcx02WKc7mSS1PCf940Ol6RpGuEK3AQ"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:50173 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbaE0OYp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 May 2014 10:24:45 -0400
In-Reply-To: <1401197435.39621.YahooMailNeo@web165002.mail.bf1.yahoo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Koleos Fuskus <koleosfuscus@yahoo.com>
Cc: Kyle Bader <kyle@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--snRcx02WKc7mSS1PCf940Ol6RpGuEK3AQ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 27/05/2014 15:30, Koleos Fuskus wrote:> Hi Kyle,
> Thanks for your answer!
> I have other questions regarding the model. Sorry, I accumulated differ=
ent doubts and the e-mail is a bit long.
>=20
> 1. What will be erasure model unit? Is it a pool or a placement group? =
I cannot see the best option here yet, probably because my inexperience w=
ith Ceph.

A pool.=20

> 2. Crush_ruleset for erasured pools: Are these crush-ruleset impacting =
on the reliability model? Should I define a default crush-ruleset?=20

Unless I'm mistaken, the crush ruleset is only relevant to the durability=
 model to the extent that it defines the failure domain. If a ruleset req=
uires that no two shards of a given placement group (i.e. no two shards o=
f a given object since a placement group is a set of object that share th=
e same OSD for a given shard) are on the same host, it will lead to a mod=
el that is different from a ruleset that requires that no two shards are =
in the same datacenter.

> 3. Metadata: Jerasure creates metadata files. How are those files store=
d in ceph (what kind of redundancy)? Should I care about them? I guess th=
e jerasure metafiles are not important. If all objects stored in a pool s=
hare the same erasure-code-k and erasure-code-m, then is easy to re-gener=
ate the metadata file. However, if metadata file is lost and the pool con=
tains erasured objects with different k and m, then repairing data will n=
ot be possible. Should I ignore this problem? Could you confirm that each=
 pool has the same erasure parameters?

Jerasure does not create a metadata file.

> 4. Number of PG for an erasured-pool. The total PGs in the case of repl=
ication is calculated with this formula: Total PGs=3D (OSDs * 100)/Replic=
as.
>
> Should I replace Replicas for the stretch factor (storage overhead) in =
the case of erasure?
>=20
> 5.Parameters - Default values:
> erasure-code-k (default 4)
> erasure-code-m (default 2)
>=20
> OSD (default 200)
> PG (default 100 x OSD)
> stripes (default ????)


I proposed an update to the documentation to clarify this : https://githu=
b.com/ceph/ceph/pull/1856 . Does it look sensible to you ?

Cheers

> 6. Units
> It is hardcoded on the reliable tool:
> KiB =3D 1000
> MiB =3D KiB * 1000
> GiB =3D MiB * 1000
> TiB =3D GiB * 1000
> PiB =3D TiB * 1000
>=20
> Why KiB is 1000 when should be 1024?

> Best,=20
> Koleosfuscus
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--snRcx02WKc7mSS1PCf940Ol6RpGuEK3AQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOEoBcACgkQ8dLMyEl6F22T1gCfcdsYWoMjOYb5JmYS3YMnCzom
u58AnRwM5G5VFXJg/Kzl2E9+mocFZhOh
=69od
-----END PGP SIGNATURE-----

--snRcx02WKc7mSS1PCf940Ol6RpGuEK3AQ--
