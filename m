From: Loic Dachary <loic@dachary.org>
Subject: Re: CEPH Erasure Encoding + OSD Scalability
Date: Sun, 25 Aug 2013 13:49:24 +0200
Message-ID: <5219EF44.7050603@dachary.org>
References: <3472A07E6605974CBC9BC573F1BC02E494B06990@PLOXCHG04.cern.ch> <51D73960.3070303@dachary.org> <CAGhffvx5-xmprT-vL1VNrz12+pJSikg1WsUqy_JRdW0JNm5auQ@mail.gmail.com> <51D8827E.8030906@dachary.org> <3472A07E6605974CBC9BC573F1BC02E494B06E64@PLOXCHG04.cern.ch> <5211F508.3030706@dachary.org> <CAGhffvwB87a+1294BjmPrfu0a9hYdu17N-eHOvYCHWMXDLcJmA@mail.gmail.com> <521698D8.5020009@dachary.org> <CAGhffvxW9sG5LtcF-tU1YGkCMAQUfh2WW_3N=f=-vWs48vyxkQ@mail.gmail.com> <52190C65.2090204@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig579D16364CE9B58E77AF1B99"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:58594 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756240Ab3HYLt3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 25 Aug 2013 07:49:29 -0400
In-Reply-To: <52190C65.2090204@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas-Joachim Peters <andreas.joachim.peters@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig579D16364CE9B58E77AF1B99
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 24/08/2013 21:41, Loic Dachary wrote:
>=20
>=20
> On 24/08/2013 15:30, Andreas-Joachim Peters wrote:
>> Hi Loic,=20
>> I will start to review =20
>=20
> Cool :-)
>=20
> ...maybe you can briefly explain few things beforehand:
>>
>> 1) the buffer management  .... who allocates the output buffers for th=
e encoding? Are they always malloced or does it use some generic CEPH buf=
fer recyling functionality?=20
>=20
> The output bufferlist is allocated by the pluing and it is the responsi=
bility of the caller to deallocate them. I will write doxygen documentati=
on
> https://github.com/ceph/ceph/pull/518/files#r5966727

Hi Andreas,

The documentation added today in
https://github.com/dachary/ceph/blob/wip-5878/src/osd/ErasureCodeInterfac=
e.h
will hopefully clarify things. It requires an understanding of https://gi=
thub.com/ceph/ceph/blob/master/src/include/buffer.h

Let me know if you have more questions.

>=20
>> 2) do you support to retrieve partial blocks or only the full 4M block=
? are decoded blocks cached for some time?
>=20
> This is outside of the scope of https://github.com/ceph/ceph/pull/518/f=
iles : the plugin can handle encode/decode of 128 bytes or 4M in the same=
 way.
>=20
>> 3) do you want to tune the 2+1 basic code for performance or is it jus=
t proof of concept? If yes, then you should move over the encoding buffer=
 with *ptr++ and use the largest available vector size for the used platf=
orm to perform XOR operations. I will send you an improved version of the=
 loop if you want ...
>=20
> The 2+1 is just a proof of concept. I completed a first implementation =
of the jerasure plugin https://github.com/ceph/ceph/pull/538/files which =
is meant to be used as a default.=20
>=20
>> 4) if you are interested I can write also code for a (3+3) plugin whic=
h tolerates 2-3 lost stripes. (one has to add P3=3DA^B^C to my [3,2] prop=
osal). Atleast it reduces the overhead from 3-fold replication from 300% =
=3D> 200% ...
>=20
> It would be great to have such a plugin :-)
>=20
>> 5) will you add CRC32C checksums to the blocks (4M block or 4k pages?)=
 or will this be a CEPH generic functionality for any kind of block?
>=20
> The idea is to have a CRC32C checksum per object / shard ( as described=
 in http://ceph.com/docs/master/dev/osd_internals/erasure_coding/#glossar=
y ) : it is the only way for scrubbing to figure out if a given shard is =
not corrupted and not too expensive since erasure coded pool only support=
 full writes + append and not partial writes that would require to re-cal=
culate the CRC32C for the whole shard each time one byte is changed.
>=20
>> 6) do you put a kind of header or magic into the encoded blocks to ver=
ify that your input blocks are actually corresponding?
>=20
> This has not been decided yet but I think it would be sensible to use t=
he object attributes ( either xattr or leveldb ) to store meta informatio=
n instead of creating a file format specifically designed for erasure cod=
e.
>=20
> Cheers
>=20
>> Cheers Andreas.
>>
>>
>>
>>
>> On Fri, Aug 23, 2013 at 1:03 AM, Loic Dachary <loic@dachary.org <mailt=
o:loic@dachary.org>> wrote:
>>
>>
>>
>>     On 22/08/2013 23:42, Andreas-Joachim Peters wrote:> Hi Loic,
>>     > sorry for the late reply, I was on vacation ...  you are right, =
I did a simple logical mistake since I assumed you loose only the data st=
ripes but never the parity stripes which is a very wrong assumption.
>>     >
>>     > So for testing you probably could just implement (2+1) and then =
move to jerasure or dual parity (4+2) where you build horizontal and diag=
onal parities.
>>     >
>>
>>     Hi Andreas,
>>
>>     That's what I did :-) It would be great if you could review the pr=
oposed implementation at https://github.com/ceph/ceph/pull/518/files . I'=
ll keep working on https://github.com/dachary/ceph/commit/83845a66ae1cba6=
3c122c0ef7658b97b474c2bd2 tomorrow to create the jerasure plugin but it's=
 not ready for review yet.
>>
>>     Cheers
>>
>>     > Cheers Andreas.
>>     >
>>     >
>>     >
>>     >
>>     >
>>     > On Mon, Aug 19, 2013 at 12:35 PM, Loic Dachary <loic@dachary.org=
 <mailto:loic@dachary.org> <mailto:loic@dachary.org <mailto:loic@dachary.=
org>>> wrote:
>>     >
>>     >     Hi Andreas,
>>     >
>>     >     Trying to write minimal code as you suggested, for an exampl=
e plugin. My first attempt at writing an erasure coding function. I don't=
 get how you can rebuild P1 + A from P2 + B + C. I must be missing someth=
ing obvious :-)
>>     >
>>     >     Cheers
>>     >
>>     >     On 07/07/2013 23:04, Andreas Joachim Peters wrote:
>>     >     >
>>     >     > Hi Loic,
>>     >     > I don't think there is a better generic implementation. Ju=
st made a benchmark .. the Jerasure library with algorithm 'cauchy_good' =
gives 1.1 GB/s (Xeon 2.27 GHz) on a single core for a 4+2 encoding w=3D32=
=2E Just to give a feeling if you do 10+4 it is 300 MB/s .... there is a =
specialized implementation in QFS (Hadoop in C++) for (M+3) ... for curio=
sity I will make a benchmark with this to compare with Jerasure ...
>>     >     >
>>     >     > In any case I would do an optimized implementation for 3+2=
 which would be probably the most performant implementation having the sa=
me reliability like standard 3-fold replication in CEPH using only 53% of=
 the space.
>>     >     >
>>     >     > 3+2 is trivial since you encode (A,B,C) with only two pari=
ty operations
>>     >     > P1 =3D A^B
>>     >     > P2 =3D B^C
>>     >     > and reconstruct with one or two parity operations:
>>     >     > A =3D P1^B
>>     >     > B =3D P1^A
>>     >     > B =3D P2^C
>>     >     > C =3D P2^B
>>     >     > aso.
>>     >     >
>>     >     > You can write this as a simple loop using advanced vector =
extensions on Intel (AVX). I can paste a benchmark tomorrow.
>>     >     >
>>     >     > Considering the crc32c-intel code you added ... I would pr=
ovide a function which provides a crc32c checksum and detects if it can d=
o it using SSE4.2 or implements just the standard algorithm e.g if you ru=
n in a virtual machine you need this emulation ...
>>     >     >
>>     >     > Cheers Andreas.
>>     >     > ________________________________________
>>     >     > From: Loic Dachary [loic@dachary.org <mailto:loic@dachary.=
org> <mailto:loic@dachary.org <mailto:loic@dachary.org>>]
>>     >     > Sent: 06 July 2013 22:47
>>     >     > To: Andreas Joachim Peters
>>     >     > Cc: ceph-devel@vger.kernel.org <mailto:ceph-devel@vger.ker=
nel.org> <mailto:ceph-devel@vger.kernel.org <mailto:ceph-devel@vger.kerne=
l.org>>
>>     >     > Subject: Re: CEPH Erasure Encoding + OSD Scalability
>>     >     >
>>     >     > Hi Andreas,
>>     >     >
>>     >     > Since it looks like we're going to use jerasure-1.2, we wi=
ll be able to try (C)RS using
>>     >     >
>>     >     > https://github.com/tsuraan/Jerasure/blob/master/src/cauchy=
=2Ec
>>     >     > https://github.com/tsuraan/Jerasure/blob/master/src/cauchy=
=2Eh
>>     >     >
>>     >     > Do you know of a better / faster implementation ? Is there=
 a tradeoff between (C)RS and RS ?
>>     >     >
>>     >     > Cheers
>>     >     >
>>     >     > On 06/07/2013 15:43, Andreas-Joachim Peters wrote:
>>     >     >> HI Loic,
>>     >     >> (C)RS stands for the Cauchy Reed-Solomon codes which are =
based on pure parity operations, while the standard Reed-Solomon codes ne=
ed more multiplications and are slower.
>>     >     >>
>>     >     >> Considering the checksumming ... for comparison the CRC32=
 code from libz run's on a 8-core Xeon at ~730 MB/s for small block sizes=
 while SSE4.2 CRC32C checksum run's at ~2GByte/s.
>>     >     >>
>>     >     >> Cheers Andreas.
>>     >     >>
>>     >     >>
>>     >     >>
>>     >     >>
>>     >     >> On Fri, Jul 5, 2013 at 11:23 PM, Loic Dachary <loic@dacha=
ry.org <mailto:loic@dachary.org> <mailto:loic@dachary.org <mailto:loic@da=
chary.org>> <mailto:loic@dachary.org <mailto:loic@dachary.org> <mailto:lo=
ic@dachary.org <mailto:loic@dachary.org>>>> wrote:
>>     >     >>
>>     >     >>     Hi Andreas,
>>     >     >>
>>     >     >>     On 04/07/2013 23:01, Andreas Joachim Peters wrote:> H=
i Loic,
>>     >     >>     > thanks for the responses!
>>     >     >>     >
>>     >     >>     > Maybe this is useful for your erasure code discussi=
on:
>>     >     >>     >
>>     >     >>     > as an example in our RS implementation we chunk a d=
ata block of e.g. 4M into 4 data chunks of 1M. Then we create a 2 parity =
chunks.
>>     >     >>     >
>>     >     >>     > Data & parity chunks are split into 4k blocks and t=
hese 4k blocks get a CRC32C block checksum each (SSE4.2 CPU extension =3D=
> MIT library or BTRFS). This creates 0.1% volume overhead (4 bytes per 4=
096 bytes) - nothing compared to the parity overhead ...
>>     >     >>     >
>>     >     >>     > You can now easily detect data corruption using the=
 local checksums and avoid to read any parity information and (C)RS decod=
ing if there is no corruption detected. Moreover CRC32C computation is di=
stributed over several (in this case 4) machines while (C)RS decoding wou=
ld run on a single machine where you assemble a block ... and CRC32C is f=
aster than (C)RS decoding (with SSE4.2) ...
>>     >     >>
>>     >     >>     What does (C)RS mean ? (C)Reed-Solomon ?
>>     >     >>
>>     >     >>     > In our case we write this checksum information sepa=
rate from the original data ... while in a block-based storage like CEPH =
it would be probably inlined in the data chunk.
>>     >     >>     > If an OSD detects to run on BRTFS or ZFS one could =
disable automatically the CRC32C code.
>>     >     >>
>>     >     >>     Nice. I did not know that was built-in :-)
>>     >     >>     https://github.com/dachary/ceph/blob/wip-4929/doc/dev=
/osd_internals/erasure-code.rst#scrubbing
>>     >     >>
>>     >     >>     > (wouldn't CRC32C be also useful for normal CEPH blo=
ck replication? )
>>     >     >>
>>     >     >>     I don't know the details of scrubbing but it seems CR=
C is already used by deep scrubbing
>>     >     >>
>>     >     >>     https://github.com/ceph/ceph/blob/master/src/osd/PG.c=
c#L2731
>>     >     >>
>>     >     >>     Cheers
>>     >     >>
>>     >     >>     > As far as I know with the RS CODEC we use you can e=
ither miss stripes (data =3D0) in the decoding process but you cannot inj=
ect corrupted stripes into the decoding process, so the block checksummin=
g is important.
>>     >     >>     >
>>     >     >>     > Cheers Andreas.
>>     >     >>
>>     >     >>     --
>>     >     >>     Lo=EFc Dachary, Artisan Logiciel Libre
>>     >     >>     All that is necessary for the triumph of evil is that=
 good people do nothing.
>>     >     >>
>>     >     >>
>>     >     >
>>     >     > --
>>     >     > Lo=EFc Dachary, Artisan Logiciel Libre
>>     >     > All that is necessary for the triumph of evil is that good=
 people do nothing.
>>     >     >
>>     >     > --
>>     >     > To unsubscribe from this list: send the line "unsubscribe =
ceph-devel" in
>>     >     > the body of a message to majordomo@vger.kernel.org <mailto=
:majordomo@vger.kernel.org> <mailto:majordomo@vger.kernel.org <mailto:maj=
ordomo@vger.kernel.org>>
>>     >     > More majordomo info at  http://vger.kernel.org/majordomo-i=
nfo.html
>>     >     >
>>     >
>>     >     --
>>     >     Lo=EFc Dachary, Artisan Logiciel Libre
>>     >     All that is necessary for the triumph of evil is that good p=
eople do nothing.
>>     >
>>     >
>>
>>     --
>>     Lo=EFc Dachary, Artisan Logiciel Libre
>>     All that is necessary for the triumph of evil is that good people =
do nothing.
>>
>>
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig579D16364CE9B58E77AF1B99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlIZ70QACgkQ8dLMyEl6F22E7gCfaUQEjCp9+ULW1ay3gewEJFEa
QOYAnjKxL8BPYd3GG7J1Uig3ZsS5zdMK
=H3cX
-----END PGP SIGNATURE-----

--------------enig579D16364CE9B58E77AF1B99--
