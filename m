From: Loic Dachary <loic@dachary.org>
Subject: Re: Review request : Erasure Code plugin loader implementation
Date: Sun, 18 Aug 2013 22:05:01 +0200
Message-ID: <521128ED.1080605@dachary.org>
References: <5210F429.2020805@dachary.org> <alpine.DEB.2.00.1308181031580.1479@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig673C019810020376BDD661C5"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:53604 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633Ab3HRUFG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 18 Aug 2013 16:05:06 -0400
In-Reply-To: <alpine.DEB.2.00.1308181031580.1479@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig673C019810020376BDD661C5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sage,

Unless I misunderstood something ( which is still possible at this stage =
;-) decode() is used both for recovery of missing chunks and retrieval of=
 the original buffer. Decoding the M data chunks is a special case of dec=
oding N <=3D M chunks out of the M+K chunks that were produced by encode(=
). It can be used to recover parity chunks as well as data chunks.

https://github.com/dachary/ceph/blob/wip-4929/doc/dev/osd_internals/erasu=
re-code.rst#erasure-code-library-abstract-api

    map<int, buffer> decode(const set<int> &want_to_read, const map<int, =
buffer> &chunks)

    decode chunks to read the content of the want_to_read chunks and retu=
rn a map associating the chunk number with its decoded content. For insta=
nce, in the simplest case M=3D2,K=3D1 for an encoded payload of data A an=
d B with parity Z, calling

    decode([1,2], { 1 =3D> 'A', 2 =3D> 'B', 3 =3D> 'Z' })
    =3D> { 1 =3D> 'A', 2 =3D> 'B' }

    If however, the chunk B is to be read but is missing it will be:

    decode([2], { 1 =3D> 'A', 3 =3D> 'Z' })
    =3D> { 2 =3D> 'B' }

Cheers

On 18/08/2013 19:34, Sage Weil wrote:
> On Sun, 18 Aug 2013, Loic Dachary wrote:
>> Hi Ceph,
>>
>> I've implemented a draft of the Erasure Code plugin loader in the cont=
ext of http://tracker.ceph.com/issues/5878. It has a trivial unit test an=
d an example plugin. It would be great if someone could do a quick review=
=2E The general idea is that the erasure code pool calls something like:
>>
>> ErasureCodePlugin::factory(&erasure_code, "example", parameters)
>>
>> as shown at
>>
>> https://github.com/ceph/ceph/blob/5a2b1d66ae17b78addc14fee68c73985412f=
3c8c/src/test/osd/TestErasureCode.cc#L28
>>
>> to get an object implementing the interface
>>
>> https://github.com/ceph/ceph/blob/5a2b1d66ae17b78addc14fee68c73985412f=
3c8c/src/osd/ErasureCodeInterface.h
>>
>> which matches the proposal described at
>>
>> https://github.com/dachary/ceph/blob/wip-4929/doc/dev/osd_internals/er=
asure-code.rst#erasure-code-library-abstract-api
>>
>> The draft is at
>>
>> https://github.com/ceph/ceph/commit/5a2b1d66ae17b78addc14fee68c7398541=
2f3c8c
>>
>> Thanks in advance :-)
>=20
> I haven't been following this discussion too closely, but taking a look=
=20
> now, the first 3 make sense, but
>=20
>     virtual map<int, bufferptr> decode(const set<int> &want_to_read, co=
nst=20
> map<int, bufferptr> &chunks) =3D 0;
>=20
> it seems like this one should be more like
>=20
>     virtual int decode(const map<int, bufferptr> &chunks, bufferlist *o=
ut);
>=20
> As in, you'd decode the chunks you have to get the actual data.  If you=
=20
> want to get (missing) chunks for recovery, you'd do
>=20
>   minimum_to_decode(...);  // see what we need
>   <fetch those chunks from other nodes>
>   decode(...);   // reconstruct original buffer
>   encode(...);   // encode missing chunks from original data
>=20
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig673C019810020376BDD661C5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlIRKO0ACgkQ8dLMyEl6F21eHgCgwRyPh/NoC/dcrfknsCQ2Rzj/
WVMAnidSmISpjQR8Q189RwQMPPqFbjyg
=5eXk
-----END PGP SIGNATURE-----

--------------enig673C019810020376BDD661C5--
