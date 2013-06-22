From: Loic Dachary <loic@dachary.org>
Subject: Re: Comments on Ceph distributed parity implementation
Date: Sat, 22 Jun 2013 10:26:44 +0200
Message-ID: <51C55FC4.7050205@dachary.org>
References: <20130614201327.70240@gmx.com> <51BB9FC3.8040102@dachary.org> <622F4407872BA447A16110F65453358C01A4D3D29CB3@FMSAMAIL.fmsa.local> <loom.20130616T214215-201@post.gmane.org> <51BE2EB1.2020807@dachary.org> <622F4407872BA447A16110F65453358C01A4D3D29CEE@FMSAMAIL.fmsa.local> <51C00FDB.6030803@polytech.univ-nantes.fr> <3E438C2F-0779-4824-9C05-ABE4B5803E05@cs.utk.edu> <51C34932.4080304@dachary.org> <622F4407872BA447A16110F65453358C01A4D8066EE7@FMSAMAIL.fmsa.local> <51C40EDD.9090909@dachary.org> <622F4407872BA447A16110F65453358C01A4D8066F49@FMSAMAIL.fmsa.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig86867D64916C4DF55FD16B6D"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:37377 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204Ab3FVI0r (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 22 Jun 2013 04:26:47 -0400
In-Reply-To: <622F4407872BA447A16110F65453358C01A4D8066F49@FMSAMAIL.fmsa.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Paul Von-Stamwitz <PVonStamwitz@us.fujitsu.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Harvey Skinner <hpmpec2a@gmail.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig86867D64916C4DF55FD16B6D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable


>> The first, simplest implementation is likely to be fit to use with RGW=
 and
>> probably too slow to use with RBD. Do you think we should try to optim=
ize
>> for RBD right now ?
>=20
> Yes, RGW is the obvious best candidate for the first implementation. We=
 don't need to implement for RBD and CephFS now, but we should consider h=
ow the design would handle other applications in the future. The alternat=
ive is to optimize purely for RGW and provide an API/plug-in capability s=
uggested by Harvey Skinner to make way for optimized solutions for other =
applications.
>=20

I agree that the design should make room to plug in optimizations in the =
future. I've tried to figure out where the API/plug-in should fit.=20

a) pluggable placement group
b) pluggable erasure code library

The pluggable placement group capability is what I'm working on right now=
=2E It requires some re-architecture of the current code and the API is s=
tarting to emerge. The implementation should eventually be in a separate =
shared library ( say ErasureCodePG ) loaded at run time and selected with=
 a configuration option when creating a pool. I suspect that experimentin=
g with new optimization strategies is going to be done by hacking Erasure=
CodePG and create new pools using it.=20

Let say we find a way to optimize for RBD and implement that in the RBDEr=
asureCodePG placement group. And we configure the RBD pool to use this pl=
acement group backend while keeping the ErasureCodePG placement group bac=
kend for RGW. Later on it may make sense to merge the two or make sure th=
ey share similar code for maintainance purposes. But that probably leaves=
 all the room we need to experiment until a general solution is found.

The pluggable erasure code library API will be something like what is des=
cribed in http://pad.ceph.com/p/Erasure_encoding_as_a_storage_backend

    context(k, m, reed-solomon|...) =3D> context* c=20
    encode(context* c, void* data) =3D> void* chunks[k+m]
    decode(context* c, void* chunk[k+m], int* indices_of_erased_chunks) =3D=
> void* data // erased chunks are not used
    repair(context* c, void* chunk[k+m], int* indices_of_erased_chunks) =3D=
> void* chunks[k+m] // erased chunks are rebuilt

It won't be enough for hierarchical codes but they don't seem to be consi=
dered attractive at the moment. It should be enough for LRC ( http://anrg=
=2Eusc.edu/~maheswaran/Xorbas.pdf ) since it only requires an additional =
argument to the context ( the number of chunks required to do a local rep=
air ).

The need for another API ( in addition to pluggable placement groups and =
pluggable erasure code library ) may appear in the future. I can't see it=
 right now. I try to refrain from over-engineering while making sure we d=
on't need to re-architecture because something obvious was overlooked. Th=
is discussion is helping a lot :-)=20

What do you think ?

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.



--------------enig86867D64916C4DF55FD16B6D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlHFX8QACgkQ8dLMyEl6F23tSQCfUZx+d+YMP1ZUE8/pbpbKNPxE
HKgAoJJL2/2aZvx60bFub/8oe1XChTiS
=0MDo
-----END PGP SIGNATURE-----

--------------enig86867D64916C4DF55FD16B6D--
