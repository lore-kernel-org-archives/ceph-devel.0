From: Loic Dachary <loic@dachary.org>
Subject: Re: Tools and archive to check for non regression of erasure coded
 content
Date: Mon, 15 Sep 2014 10:45:05 +0200
Message-ID: <5416A711.7030402@dachary.org>
References: <54142F89.4060804@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4AE7C82EB@CERNXCHG44.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="HJDMuxjguIPuPpccfWocJVoRi07cp8CHT"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:52163 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752451AbaIOIpT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Sep 2014 04:45:19 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE7C82EB@CERNXCHG44.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HJDMuxjguIPuPpccfWocJVoRi07cp8CHT
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable


Hi Andreas,


On 15/09/2014 09:27, Andreas Joachim Peters wrote:> Hi Loic,
> I saw (if i am not mistaken) that you actually test only encoding ... s=
o your idea is to guarantee that the encoding results in the same output =
and the encoding/decoding functionality is validated by the unit tests in=
 each new version?=20

You are correct: it only partially checks the encoding. It should also tr=
y decoding with various combinations of erasures and check that the conte=
nt can actually be reconstructed. I did not go after that because the exi=
sting unit tests already perform this verification. But it should also be=
 done in this context because the code may have changed in a way that mak=
es backward compatibility slightly different when it comes to decoding wi=
th erasures. Since the unit tests focus on the version currently develope=
d, there is a chance that a subtle difference is missed.

> In principle this restricts the encoding to never change the alignment =
in the future, which might be not optimal. We might get larger registers =
in the future on new CPUs and the alignment might change or they might de=
al perfectly with 1-byte alignments. I suggest  to make sure that the new=
 version can decode the old format, but it does not need to imply that it=
 encodes it in exactly the same way ... this is slighly more complicated =
however I would feel more comfortable if you would do the brute-force dec=
oding check in this infrastructure for all plug-ins and leave the flexibi=
lity to change the encoding format in the future.

This is a very good point. I'm not sure what the correct answer is but I =
would also be inclined to leave it until we face a format change.

Cheers

>=20
> Cheers Andreas.
>=20
> ________________________________________
> From: ceph-devel-owner@vger.kernel.org [ceph-devel-owner@vger.kernel.or=
g] on behalf of Loic Dachary [loic@dachary.org]
> Sent: 13 September 2014 13:50
> To: Ceph Development
> Subject: Tools and archive to check for non regression of erasure coded=
 content
>=20
> Hi Ceph,
>=20
> An erasure coded object stored in Firefly when it was first introduced =
must be decoded by all versions after Firefly. The encoding is done by er=
asure code plugins[1] and they evolve over time[2]. There needs to be a t=
ool to check that all content encoded by a given version of the plugin ca=
n also be encoded by all subsequent versions of the same plugin.
>=20
> The general idea is to archive objects created with a given Ceph versio=
n and check them will all subsequent versions, via a teuthology workunit =
run on all supported distributions and architectures.
>=20
> The ceph_erasure_code_non_regression command[3] creates an object and s=
tore it on disk or read an object from disk and checks that it can be rea=
d. It is used to create objects for all relevant variations of parameters=
 of a given erasure code plugin. For instance:
>=20
> ceph_erasure_code_non_regression --stripe-width 4651 --parameter packet=
size=3D32 --plugin jerasure --parameter technique=3Dblaum_roth --paramete=
r k=3D6 --parameter m=3D2 --create --base ../../ceph-erasure-code-corpus/=
v0.85-764-gf3a1532
> ceph_erasure_code_non_regression --stripe-width 4651 --parameter packet=
size=3D32 --plugin jerasure --parameter technique=3Dliber8tion --paramete=
r k=3D6 --parameter m=3D2 --create --base ../../ceph-erasure-code-corpus/=
v0.85-764-gf3a1532
> etc.
>=20
> The script[4] and the objects are archived in a repository [5] that can=
 be checked by later Ceph versions. The same script is used for checking =
and creating the objects so that there is no risk of confusion. These scr=
ipts are stored per version because a given script is developed for a giv=
en version of the plugins.
>=20
> The encode-decode-non-regression.sh[6] workunit uses these scripts when=
 run from teuthology[7] and will run all of them, up to and including the=
 currently running ceph version. This ultimately ensures that all archive=
d objects can be read on all supported distributions and architectures.
>=20
> See also http://tracker.ceph.com/issues/9420 which is the ticket associ=
ated to this work.
>=20
> Although this all sound sensible to me right now, I would be very inter=
ested to hear about ideas to make this easier or better :-)
>=20
> Cheers
>=20
> [1] firefly erasure code plugins https://github.com/ceph/ceph/tree/fire=
fly/src/erasure-code
> [2] giant erasure code plugins https://github.com/ceph/ceph/tree/v0.85/=
src/erasure-code
> [3] ceph_erasure_code_non_regression https://github.com/dachary/ceph/co=
mmit/497a82b2b3113dae724a43d8d4c7e430acf44120
> [4] non-regression.sh https://github.com/dachary/ceph-erasure-code-corp=
us/blob/master/v0.80.5-226-g71d2562/non-regression.sh
> [5] ceph-erasure-code-corpus https://github.com/dachary/ceph-erasure-co=
de-corpus
> [6] encode-decode-non-regression.sh https://github.com/dachary/ceph/com=
mit/4f7a9f83fb1f037662861e8782c9b90566dcaa31
> [7] non regression workload https://github.com/ceph/ceph-qa-suite/pull/=
136
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--HJDMuxjguIPuPpccfWocJVoRi07cp8CHT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQWpxEACgkQ8dLMyEl6F22imQCgm5m+jEamfuyZyWfQmJjF4xsv
ZBkAn3krQns3GDd1WER+uIWGJFUPlpoL
=ObC+
-----END PGP SIGNATURE-----

--HJDMuxjguIPuPpccfWocJVoRi07cp8CHT--
