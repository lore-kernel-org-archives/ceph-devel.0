From: Loic Dachary <loic@dachary.org>
Subject: Re: Review request : Erasure Code plugin loader implementation
Date: Mon, 19 Aug 2013 17:06:59 +0200
Message-ID: <52123493.80803@dachary.org>
References: <5210F429.2020805@dachary.org> <alpine.DEB.2.00.1308181031580.1479@cobra.newdream.net> <521128ED.1080605@dachary.org> <alpine.DEB.2.00.1308181654560.1479@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8E097CABC725CDC15256FB20"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:42905 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108Ab3HSPHD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Aug 2013 11:07:03 -0400
In-Reply-To: <alpine.DEB.2.00.1308181654560.1479@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8E097CABC725CDC15256FB20
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 19/08/2013 02:01, Sage Weil wrote:
> On Sun, 18 Aug 2013, Loic Dachary wrote:
>> Hi Sage,
>>
>> Unless I misunderstood something ( which is still possible at this sta=
ge ;-) decode() is used both for recovery of missing chunks and retrieval=
 of the original buffer. Decoding the M data chunks is a special case of =
decoding N <=3D M chunks out of the M+K chunks that were produced by enco=
de(). It can be used to recover parity chunks as well as data chunks.
>>
>> https://github.com/dachary/ceph/blob/wip-4929/doc/dev/osd_internals/er=
asure-code.rst#erasure-code-library-abstract-api
>>
>>     map<int, buffer> decode(const set<int> &want_to_read, const map<in=
t, buffer> &chunks)
>>
>>     decode chunks to read the content of the want_to_read chunks and r=
eturn a map associating the chunk number with its decoded content. For in=
stance, in the simplest case M=3D2,K=3D1 for an encoded payload of data A=
 and B with parity Z, calling
>>
>>     decode([1,2], { 1 =3D> 'A', 2 =3D> 'B', 3 =3D> 'Z' })
>>     =3D> { 1 =3D> 'A', 2 =3D> 'B' }
>>
>>     If however, the chunk B is to be read but is missing it will be:
>>
>>     decode([2], { 1 =3D> 'A', 3 =3D> 'Z' })
>>     =3D> { 2 =3D> 'B' }
>=20
> Ah, I guess this works when some of the chunks contain the original=20
> data (as with a parity code).  There are codes that don't work that way=
,=20
> although I suspect we won't use them.
>=20
> Regardless, I wonder if we should generalize slightly and have some=20
> methods work in terms of (offset,length) of the original stripe to=20
> generalize that bit.  Then we would have something like
>=20
>      map<int, buffer> transcode(const set<int> &want_to_read, const map=
<int,=20
>             buffer>& chunks);
>=20
> to go from chunks -> chunks (as we would want to do with, say, a LRC-li=
ke=20
> code where we can rebuild some shards from a subset of the other shards=
). =20
> And then also have
>=20
>      int decode(const map<int, buffer>& chunks, unsigned offset,=20
>          unsigned len, bufferlist *out);

This function would be implemented more or less as:

  set<int> want_to_read =3D range_to_chunks(offset, len) // compute what =
chunks must be retrieved
  set<int> available =3D the up set
  set<int> minimum =3D minimum_to_decode(want_to_read, available);
  map<int, buffer> available_chunks =3D retrieve_chunks_from_osds(minimum=
);
  map<int, buffer> chunks =3D transcode(want_to_read, available_chunks); =
// repairs if necessary
  out =3D bufferptr(concat_chunks(chunks), offset - offset of the first c=
hunk, len)

or do you have something else in mind ?

>=20
> that recovers the original data.
>=20
> In our case, the read path would use decode, and for recovery we would =
use=20
> transcode. =20
>=20
> We'd also want to have alternate minimum_to_decode* methods, like
>=20
>     virtual set<int> minimum_to_decode(unsigned offset, unsigned len, c=
onst=20
>          set<int> &available_chunks) =3D 0;

I also have a convenience wrapper in mind for this but I feel I'm missing=
 something.

Cheers

>=20
> What do you think?
>=20
> sage
>=20
>=20
>=20
>=20
>>
>> Cheers
>>
>> On 18/08/2013 19:34, Sage Weil wrote:
>>> On Sun, 18 Aug 2013, Loic Dachary wrote:
>>>> Hi Ceph,
>>>>
>>>> I've implemented a draft of the Erasure Code plugin loader in the co=
ntext of http://tracker.ceph.com/issues/5878. It has a trivial unit test =
and an example plugin. It would be great if someone could do a quick revi=
ew. The general idea is that the erasure code pool calls something like:
>>>>
>>>> ErasureCodePlugin::factory(&erasure_code, "example", parameters)
>>>>
>>>> as shown at
>>>>
>>>> https://github.com/ceph/ceph/blob/5a2b1d66ae17b78addc14fee68c7398541=
2f3c8c/src/test/osd/TestErasureCode.cc#L28
>>>>
>>>> to get an object implementing the interface
>>>>
>>>> https://github.com/ceph/ceph/blob/5a2b1d66ae17b78addc14fee68c7398541=
2f3c8c/src/osd/ErasureCodeInterface.h
>>>>
>>>> which matches the proposal described at
>>>>
>>>> https://github.com/dachary/ceph/blob/wip-4929/doc/dev/osd_internals/=
erasure-code.rst#erasure-code-library-abstract-api
>>>>
>>>> The draft is at
>>>>
>>>> https://github.com/ceph/ceph/commit/5a2b1d66ae17b78addc14fee68c73985=
412f3c8c
>>>>
>>>> Thanks in advance :-)
>>>
>>> I haven't been following this discussion too closely, but taking a lo=
ok=20
>>> now, the first 3 make sense, but
>>>
>>>     virtual map<int, bufferptr> decode(const set<int> &want_to_read, =
const=20
>>> map<int, bufferptr> &chunks) =3D 0;
>>>
>>> it seems like this one should be more like
>>>
>>>     virtual int decode(const map<int, bufferptr> &chunks, bufferlist =
*out);
>>>
>>> As in, you'd decode the chunks you have to get the actual data.  If y=
ou=20
>>> want to get (missing) chunks for recovery, you'd do
>>>
>>>   minimum_to_decode(...);  // see what we need
>>>   <fetch those chunks from other nodes>
>>>   decode(...);   // reconstruct original buffer
>>>   encode(...);   // encode missing chunks from original data
>>>
>>> sage
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --=20
>> Lo?c Dachary, Artisan Logiciel Libre
>> All that is necessary for the triumph of evil is that good people do n=
othing.
>>
>>
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


--------------enig8E097CABC725CDC15256FB20
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlISNJMACgkQ8dLMyEl6F21+XgCeLeZqASmrXrTWPOTJ7YaeV1I6
X1IAoJdWr7yRrI9gHHnKzmETMzvbQt9O
=Mp8k
-----END PGP SIGNATURE-----

--------------enig8E097CABC725CDC15256FB20--
