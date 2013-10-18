From: Loic Dachary <loic@dachary.org>
Subject: Re: PGBackend: Multiple PG implementations.
Date: Sat, 19 Oct 2013 01:16:37 +0200
Message-ID: <5261C155.8000500@dachary.org>
References: <CAKD2hyG6giBDQ0ue9hD723Eq0Bk+1rAKgb9NzdjHJBW5DoRxdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="aPi3HQcQrRuAlj8jDDPUs9xFoNkFVMu8I"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:39866 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754832Ab3JRXQj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Oct 2013 19:16:39 -0400
In-Reply-To: <CAKD2hyG6giBDQ0ue9hD723Eq0Bk+1rAKgb9NzdjHJBW5DoRxdQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?TGx1w61zIFDDoG1pZXMgaSBKdcOhcmV6?= <llpamies@pamies.cat>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aPi3HQcQrRuAlj8jDDPUs9xFoNkFVMu8I
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Llu=C3=ADs,

David Zafman and Samuel Just are working to re-architecture the core of C=
eph so that and ErasureCodedBackend can be implemented. You can browse th=
eir commits to see what they are up to. The transcript of the last CDS su=
mmit will also give you a general view of the direction in which it is he=
ading :=20

http://wiki.ceph.com/01Planning/CDS/Emperor/Transcript_:_Erasure_coded_st=
orage_backend_%28step_2%29

and a more recent interview of Samuel Just will give you a short update :=


http://dachary.org/?p=3D2320

I'm not the best qualified to comment on the generic part of your patches=
, but I think it overlaps with the work being done.

Cheers

On 19/10/2013 01:05, Llu=C3=ADs P=C3=A0mies i Ju=C3=A1rez wrote:
> Hello,
>=20
> I was looking at the work done to re-architecture the OSD backend.
> Since it seems that it allows now to have more than one PG
> implementation I decided to subclass PG and PGBackend to create an
> alternative implementation to ReplicatedPG and ReplicatedBackend.
> However, I noticed a couple of problems:
>=20
> * All methods in watch.h and watch.cc expect ReplicatedPG objects
> instead of generic PG objects.
> * New pools created in the OSDMonitor are created as replicated pools
> (g_pool_t::TYPE_REP). This is a hardcoded value.
>=20
> I made a few changes to solve these two issues that allowed me to have
> more than one PG implementation running without problems. You can find
> the changes here:
>=20
> https://github.com/ceph/ceph/pull/744
>=20
> Are these changes useful for the re-architecture of the OSD ?
>=20
> PS: Implementing and running an alternative PG requires other changes
> in the CrushCompiler and other header files.
>=20
> Best,
> Lluis
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--aPi3HQcQrRuAlj8jDDPUs9xFoNkFVMu8I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJhwVUACgkQ8dLMyEl6F21xawCZAePgNLvNg/pIFDwpYwfLsL/B
RgcAnjj5a82bZPUWC/r8w4tzIuFH/rSe
=kaTX
-----END PGP SIGNATURE-----

--aPi3HQcQrRuAlj8jDDPUs9xFoNkFVMu8I--
