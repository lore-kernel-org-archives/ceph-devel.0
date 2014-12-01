From: Loic Dachary <loic@dachary.org>
Subject: Re: gf-complete alignment constraints
Date: Tue, 02 Dec 2014 00:26:14 +0100
Message-ID: <547CF916.1020604@dachary.org>
References: <547CBE6C.5040801@dachary.org>	<CA+AFVBhkg6C9+seEYFdm34_yi++aV-XHPXw2iiLm9mj+=QMJ+w@mail.gmail.com>	<547CE1EE.5080306@dachary.org>	<547CEC24.2010807@dachary.org> <CA+AFVBi2zLfMLFX7sx+ZhTpjn5buFhkj+s7-+gyQfWojfrJrrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="3PLA3fbuImVot3VIt0SF8u0cbKT0NHcla"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:46076 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932484AbaLAX0Q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Dec 2014 18:26:16 -0500
In-Reply-To: <CA+AFVBi2zLfMLFX7sx+ZhTpjn5buFhkj+s7-+gyQfWojfrJrrA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Greenan <kmgreen2@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3PLA3fbuImVot3VIt0SF8u0cbKT0NHcla
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 01/12/2014 23:36, Kevin Greenan wrote:
> No problem.  Let me know if you need any help!

Thanks ! When investigating this problem I stumbled upon exit(1) in gf-co=
mplete and came up with a patch to replace them with assert(0):

https://github.com/ceph/gf-complete/pull/1/files

When exit(1) is called Ceph just stops with no useful information (the st=
derr does not in the ceph logs) while assert(0) is caught and shows a nic=
e stack trace. It's not high priority though ;-)

Cheers

>=20
> -kevin
>=20
> On Mon, Dec 1, 2014 at 2:31 PM, Loic Dachary <loic@dachary.org <mailto:=
loic@dachary.org>> wrote:
>=20
>     You can ignore this thread, the problem is not in gf-complete or je=
rasure ;-)
>=20
>     Sorry for the noise
>=20
>     On 01/12/2014 22:47, Loic Dachary wrote:
>     >
>     >
>     > On 01/12/2014 22:01, Kevin Greenan wrote:
>     >> Hey Loic,
>     >>
>     >> Makes sense.  I can have a look tonight.
>     >
>     > I'm actually mistaken, confused the first argument with the secon=
d one :-/ I'll keep looking.
>     >
>     >>
>     >> Thanks!
>     >> -kevin
>     >>
>     >> On Mon, Dec 1, 2014 at 11:15 AM, Loic Dachary <loic@dachary.org =
<mailto:loic@dachary.org> <mailto:loic@dachary.org <mailto:loic@dachary.o=
rg>>> wrote:
>     >>
>     >>     Hi Kevin,
>     >>
>     >>     I've hit the following stack trace (and I can reproduce it w=
hich is nice ;-)
>     >>
>     >>     #0  __GI_exit (status=3D1) at exit.c:104
>     >>     #1  0x00007ffff18f3312 in gf_set_region_data (rd=3D0x7fffd9b=
8b0a0, gf=3D0x485dd40, src=3D0x4a7b31f, dest=3D0x4d25800, bytes=3D2048, v=
al=3D143, xor=3D1, align=3D16) at erasure-code/jerasure/gf-complete/src/g=
f.c:817
>     >>     #2  0x00007ffff1932364 in gf_w8_split_multiply_region_sse (g=
f=3D0x485dd40, src=3D0x4a7b31f, dest=3D0x4d25800, val=3D143, bytes=3D2048=
, xor=3D1) at erasure-code/jerasure/gf-complete/src/gf_w8.c:1071
>     >>     #3  0x00007ffff18db9cc in galois_w08_region_multiply (region=
=3D0x4a7b31f "", multby=3D143, nbytes=3D2048, r2=3D0x4d25800 "root:x:0:\n=
daemon:x:1:\nbin:x:2:\nsys:x:3:\nadm:x:4:loic,swift,syslog\ntty:x:5:\ndis=
k:x:6:\nlp:x:7:\nmail:x:8:\nnews:x:9:\nuucp:x:10:\nman:x:12:\nproxy:x:13:=
\nkmem:x:15:\ndialout:x:20:\nfax:x:21:\nvoice:x:22:\ncdrom:x"..., add=3D1=
) at erasure-code/jerasure/jerasure/src/galois.c:295
>     >>     #4  0x00007ffff18ddb42 in jerasure_matrix_dotprod (k=3D2, w=3D=
8, matrix_row=3D0x47fa558, src_ids=3D0x0, dest_id=3D3, data_ptrs=3D0x7fff=
d9b8b260, coding_ptrs=3D0x7fffd9b8b270, size=3D2048) at erasure-code/jera=
sure/jerasure/src/jerasure.c:626
>     >>
>     >>     https://github.com/ceph/gf-complete/blob/v1/src/gf.c#L811 in=
deed checks that src=3D0x4a7b31f, dest=3D0x4d25800 are aligned and finds =
they are not. If I'm not mistaken src comes from https://github.com/ceph/=
jerasure/blob/v2/src/galois.c#L294 which will allocate it via https://git=
hub.com/ceph/jerasure/blob/v2/src/galois.c#L292 i.e https://github.com/ce=
ph/jerasure/blob/v2/src/galois.c#L191 and then https://github.com/ceph/je=
rasure/blob/v2/src/galois.c#L175 which does a malloc that does not enforc=
e alignment.
>     >>
>     >>     Should we relax the requirements or make sure https://github=
=2Ecom/ceph/jerasure/blob/v2/src/galois.c#L175 uses a logic similar to ht=
tps://github.com/ceph/ceph/blob/giant/src/common/buffer.cc#L235 ?
>     >>
>     >>     Cheers
>     >>     --
>     >>     Lo=C3=AFc Dachary, Artisan Logiciel Libre
>     >>
>     >>
>     >
>=20
>     --
>     Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--3PLA3fbuImVot3VIt0SF8u0cbKT0NHcla
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlR8+RYACgkQ8dLMyEl6F214ygCgs1m+Q3KrKf2Ki0G96jrvluwl
o6IAnA7z1WfAWIwsC6f9QNoIFIy3Ufge
=gFex
-----END PGP SIGNATURE-----

--3PLA3fbuImVot3VIt0SF8u0cbKT0NHcla--
