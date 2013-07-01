From: Loic Dachary <loic@dachary.org>
Subject: Erasure coding library API
Date: Tue, 02 Jul 2013 01:00:19 +0200
Message-ID: <51D20A03.1030204@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6808857DEE6526D9263FB773"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:52148 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755100Ab3GAXAV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Jul 2013 19:00:21 -0400
Received: from [10.8.0.22] (unknown [10.8.0.22])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id 5433326394
	for <ceph-devel@vger.kernel.org>; Tue,  2 Jul 2013 01:00:20 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6808857DEE6526D9263FB773
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Today Sam pointed out that the API for LRC ( Xorbas Hadoop Project Page, =
Locally Repairable Codes (LRC) http://smahesh.com/HadoopUSC/ for instance=
 ) would need to be different from the one initialy proposed:

    context(k, m, reed-solomon|...) =3D> context* c=20
    encode(context* c, void* data) =3D> void* chunks[k+m]
    decode(context* c, void* chunk[k+m], int* indices_of_erased_chunks) =3D=
> void* data // erased chunks are
not used
    repair(context* c, void* chunk[k+m], int* indices_of_erased_chunks) =3D=
> void* chunks[k+m] // erased
chunks are rebuilt

The decode function must allow for partial read:

    decode(context* c, int offset, int length, void* chunk[k+m], int* ind=
ices_of_erased_chunks, int* missing_chunks) =3D> void* data=20

If there are not enough chunks to recover the desired data range [offset,=
 offset+length) the function returns NULL and sets missing_chunks to the =
list of chunks that must be retrieved in order to be able to read the des=
ired data.

If decode is called to read just 1 chunk and it is missing, reed-solomon =
would return on error and ask for all other chunks to repair. If the unde=
rlying library implements LRC, it would ask for a subset of the chunks.=20

An implementation allowing only full reads and using jerasure ( which doe=
s not do LRC ) requires that offset is always zero, length is the size of=
 the object and returns a copy of indices_of_erased_chunks if there are n=
ot enough chunks to rebuild the missing ones.=20

Comments are welcome :-)

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig6808857DEE6526D9263FB773
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlHSCgMACgkQ8dLMyEl6F21msgCdGEvoY8OcidZ9kwlK4kdgyyrv
sP8An2kxLWjGlHrsP63Nyyp7UmjDrLZM
=LMjB
-----END PGP SIGNATURE-----

--------------enig6808857DEE6526D9263FB773--
