From: Loic Dachary <loic@dachary.org>
Subject: Re: ISA erasure code plugin and cache
Date: Mon, 04 Aug 2014 14:37:14 +0200
Message-ID: <53DF7E7A.5040509@dachary.org>
References: <53DF750B.6080107@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4AE75711F@CERNXCHG43.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="8PiR6kNTrfsX40OFF1prOIL0p9ORcBxKU"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53449 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751117AbaHDMhV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Aug 2014 08:37:21 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE75711F@CERNXCHG43.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: "Ma, Jianpeng" <jianpeng.ma@intel.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8PiR6kNTrfsX40OFF1prOIL0p9ORcBxKU
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 04/08/2014 14:15, Andreas Joachim Peters wrote:> Hi Loic,=20
>=20
> the background relevant to your comments have (unfortunately) never bee=
n answered on the mailing list.=20
>=20
> The cache is written in a way, that it is useful for a fixed (k,m) comb=
ination and thread-safe.
>=20
> So, if there is one instance of the plugin per pool, it is the right im=
plementation. If there is (as you write) one instance for each PG in any =
pool, it is sort of 'stupid' because the same encoding table is stored fo=
r each PG seperatly.

I would not called it stupid ;-) Just not as efficient as if the cache wa=
s by all PGs. Without cache the decode table has to be calculated for eac=
h object in the placement group and there are a lot of objects. The table=
 may be duplicated hundreds of time so it has an impact on the memory foo=
tprint, but it should not have a visible impact on the decode performance=
s. An optimisation of your implementation to save memory would be nice, b=
ut it is not critical.

How large are the decode tables ?

> So if the final statement is to create one plugin instance per PG, I wi=
ll change it accordingly and shared encoding & decoding tables for a fixe=
d (k,m), if not it can stay.=20
>=20
> Just need to know that ... this boils down to the fact, that encoding &=
 decoding should not be considered 'stateless'.
>=20
> Cheers Andreas.
>=20
>=20
> ________________________________________
> From: Loic Dachary [loic@dachary.org]
> Sent: 04 August 2014 13:56
> To: Andreas Joachim Peters
> Cc: Ma, Jianpeng; Ceph Development
> Subject: ISA erasure code plugin and cache
>=20
> Hi,
>=20
> Here is how I understand the current code:
>=20
> When an OSD is missing, recovery is required and the primary OSD will c=
ollect the available chunks to do so. It will then call the decode method=
 via ECUtil::decode which is a small wrapper around the corresponding Era=
sureCodeInterface::decode method.
>=20
>    https://github.com/ceph/ceph/blob/master/src/osd/ECBackend.cc#L361
>=20
> The ISA plugin will then use the isa_decode method to perform the work
>=20
>    https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/Erasur=
eCodeIsa.cc#L212
>=20
> and will be repeatedly called until all objects in the PGs that were re=
lying on the missing OSD are recovered. To avoid computing the decoding t=
able for each object, it is stored in a LRU cache
>=20
>    https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/Erasur=
eCodeIsa.cc#L480
>=20
> and copied in the stack if already there:
>=20
>    https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/Erasur=
eCodeIsa.cc#L433
>=20
> Each PG has a separate instance of ErasureCodeIsa, obtained when it is =
created:
>=20
>    https://github.com/ceph/ceph/blob/master/src/osd/PGBackend.cc#L292
>=20
> It means that data members of each ErasureCodeIsa are copied as many ti=
mes as there are PGs. If an OSD handles participates in 200 PG that belon=
g to an erasure coded pool configured to use ErasureCodeIsa, the data mem=
bers will be duplicated 200 times.
>=20
> It is good practice to make it so that the encode/decode methods of Era=
sureCodeIsa are thread safe. In the jerasure plugin these methods have no=
 side effect on the object. In the isa plugin the LRU cache storing the d=
ecode tables is modified by the decode method and guarded by a mutex:
>=20
>    get https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/Er=
asureCodeIsa.cc#L281
>    put https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/Er=
asureCodeIsa.cc#L310
>=20
> Please correct me if I'm mistaken ;-) I've not reviewed the code yet an=
d try to find problems, I just wanted to make sure I get the intention be=
fore doing so.
>=20
> Cheers
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--8PiR6kNTrfsX40OFF1prOIL0p9ORcBxKU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPffnoACgkQ8dLMyEl6F2151QCdGg1lB/sbWqbYsOkO+ZJtG0oQ
vIIAn0Ts3tMY+H8IB/4h7TuKf3JJC4BA
=90Y1
-----END PGP SIGNATURE-----

--8PiR6kNTrfsX40OFF1prOIL0p9ORcBxKU--
