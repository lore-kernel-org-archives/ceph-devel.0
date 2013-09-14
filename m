From: Loic Dachary <loic@dachary.org>
Subject: Re: CEPH Erasure Encoding + OSD Scalability
Date: Sat, 14 Sep 2013 20:04:39 +0200
Message-ID: <5234A537.609@dachary.org>
References: <3472A07E6605974CBC9BC573F1BC02E494B06990@PLOXCHG04.cern.ch> <51D73960.3070303@dachary.org> <CAGhffvx5-xmprT-vL1VNrz12+pJSikg1WsUqy_JRdW0JNm5auQ@mail.gmail.com> <51D8827E.8030906@dachary.org> <3472A07E6605974CBC9BC573F1BC02E494B06E64@PLOXCHG04.cern.ch> <5211F508.3030706@dachary.org> <CAGhffvwB87a+1294BjmPrfu0a9hYdu17N-eHOvYCHWMXDLcJmA@mail.gmail.com> <521698D8.5020009@dachary.org> <CAGhffvxW9sG5LtcF-tU1YGkCMAQUfh2WW_3N=f=-vWs48vyxkQ@mail.gmail.com> <52190C65.2090204@dachary.org>,<5219EF44.7050603@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4A525F387@PLOXCHG03.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig31A93348AB6EBF90CD36E07B"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:34824 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753554Ab3INSEn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 14 Sep 2013 14:04:43 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4A525F387@PLOXCHG03.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig31A93348AB6EBF90CD36E07B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable


Hi Andreas,

On 14/09/2013 16:59, Andreas Joachim Peters wrote:> Hi Loic,
>
> I finally run/read the code of the erasure encoding.

Great !

> What I noticed is, that in your implementation you always copy the data=
 to encode once because you add a padding block to the bufferlist and the=
n call "out.c_str()", which calls bufferlist::rebuild and then new with t=
he full size of all chunks and the it copies the input data. Please corre=
ct me if I am wrong ... couldn't you just allocate the additional redunda=
ncy chunks and return bufferptr pointing into the 'in' bufferlist ?

I assume you're referring to

https://github.com/ceph/ceph/blob/e9e53912503259326a7877bda31c4360302c2c3=
4/src/osd/ErasureCodePluginJerasure/ErasureCodeJerasure.cc#L78

and indeed it implies an extra copy because of the padding. The optimizat=
ion you're suggesting, if I get it right would only require an extra copy=
 of the last data chunk. The code would extract the char * from in with c=
_str() before padding ( hence no rebuild ). Feed data[] with pointers to =
this but the last one if it requires padding. Allocate + copy a chunk + p=
ad the last chunk if necessary. The allocated area can be made big enough=
 to accomodate for the coding chunks. That would reduce the copy to the m=
inimum. It also means that the returned bufferlist has to properly refere=
nce the input buffer and that the caller must not modify the content of *=
in* after calling encode otherwise it may have a side effect on the *enco=
ded* result because they really are the same pointer.

>
> Another question is, why 'in' in the encode function is a list of buffe=
rs? Maybe this is the natural interface object in CEPH IO, don't know ...=
 the implementation would concatenate them and produce chunks for the mer=
ged block ...

You guess right. Initially I had the encode function accept a bufferptr i=
nstead of a bufferlist but it's not the preferred API data structure to c=
onvey a buffer.

> I will try to run a benchmark to see, if the additional copy has a visi=
ble impact on the performance, however it looks unnecessary.

Indeed there should be a way to avoid this extra copy.

> I am also more or less finished with the 3 + (3XOR) implementation ... =
will do also a benchmark with this and let you know the result.

Cool !

> Last question  a little bit out of context, I did some benchmark about =
librados and latency. I see a latency of 1ms to read/stat objects of very=
 small size (5 bytes in this case). If we (re-)write such an object with =
a 3-fold replica configuration on a 10 GBit setup with 1000 disks I see a=
 latency of 80 ms per object. If I append it is 75 ms. If we do a massive=
 test with the benchmark tool the total object creation rate saturates at=
 20kHz which is ok however the individual latency is higher than I would =
expect ?
>
> Is there something in the OSD delaying communication since I don't beli=
eve it takes 80 ms to sync 5 bytes on an idle pool to a harddisk with a n=
etwork roundtrip time of far less than a ms ?

I suggest you start a separate thread for this, chances are your question=
 will not be noticed otherwise.

Cheers

> Cheers, Andreas.
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
> ________________________________________
> From: Loic Dachary [loic@dachary.org]
> Sent: 25 August 2013 13:49
> To: Andreas Joachim Peters
> Cc: Ceph Development
> Subject: Re: CEPH Erasure Encoding + OSD Scalability
>
> On 24/08/2013 21:41, Loic Dachary wrote:
>>
>>
>> On 24/08/2013 15:30, Andreas-Joachim Peters wrote:
>>> Hi Loic,
>>> I will start to review
>>
>> Cool :-)
>>
>> ...maybe you can briefly explain few things beforehand:
>>>
>>> 1) the buffer management  .... who allocates the output buffers for t=
he encoding? Are they always malloced or does it use some generic CEPH bu=
ffer recyling functionality?
>>
>> The output bufferlist is allocated by the pluing and it is the respons=
ibility of the caller to deallocate them. I will write doxygen documentat=
ion
>> https://github.com/ceph/ceph/pull/518/files#r5966727
>
> Hi Andreas,
>
> The documentation added today in
> https://github.com/dachary/ceph/blob/wip-5878/src/osd/ErasureCodeInterf=
ace.h
> will hopefully clarify things. It requires an understanding of https://=
github.com/ceph/ceph/blob/master/src/include/buffer.h
>
> Let me know if you have more questions.
>
>>
>>> 2) do you support to retrieve partial blocks or only the full 4M bloc=
k? are decoded blocks cached for some time?
>>
>> This is outside of the scope of https://github.com/ceph/ceph/pull/518/=
files : the plugin can handle encode/decode of 128 bytes or 4M in the sam=
e way.
>>
>>> 3) do you want to tune the 2+1 basic code for performance or is it ju=
st proof of concept? If yes, then you should move over the encoding buffe=
r with *ptr++ and use the largest available vector size for the used plat=
form to perform XOR operations. I will send you an improved version of th=
e loop if you want ...
>>
>> The 2+1 is just a proof of concept. I completed a first implementation=
 of the jerasure plugin https://github.com/ceph/ceph/pull/538/files which=
 is meant to be used as a default.
>>
>>> 4) if you are interested I can write also code for a (3+3) plugin whi=
ch tolerates 2-3 lost stripes. (one has to add P3=3DA^B^C to my [3,2] pro=
posal). Atleast it reduces the overhead from 3-fold replication from 300%=
 =3D> 200% ...
>>
>> It would be great to have such a plugin :-)
>>
>>> 5) will you add CRC32C checksums to the blocks (4M block or 4k pages?=
) or will this be a CEPH generic functionality for any kind of block?
>>
>> The idea is to have a CRC32C checksum per object / shard ( as describe=
d in http://ceph.com/docs/master/dev/osd_internals/erasure_coding/#glossa=
ry ) : it is the only way for scrubbing to figure out if a given shard is=
 not corrupted and not too expensive since erasure coded pool only suppor=
t full writes + append and not partial writes that would require to re-ca=
lculate the CRC32C for the whole shard each time one byte is changed.
>>
>>> 6) do you put a kind of header or magic into the encoded blocks to ve=
rify that your input blocks are actually corresponding?
>>
>> This has not been decided yet but I think it would be sensible to use =
the object attributes ( either xattr or leveldb ) to store meta informati=
on instead of creating a file format specifically designed for erasure co=
de.
>>
>> Cheers
>>
>>> Cheers Andreas.
>>>
>>>
>>>
>>>
>>> On Fri, Aug 23, 2013 at 1:03 AM, Loic Dachary <loic@dachary.org <mail=
to:loic@dachary.org>> wrote:
>>>
>>>
>>>
>>>     On 22/08/2013 23:42, Andreas-Joachim Peters wrote:> Hi Loic,
>>>     > sorry for the late reply, I was on vacation ...  you are right,=
 I did a simple logical mistake since I assumed you loose only the data s=
tripes but never the parity stripes which is a very wrong assumption.
>>>     >
>>>     > So for testing you probably could just implement (2+1) and then=
 move to jerasure or dual parity (4+2) where you build horizontal and dia=
gonal parities.
>>>     >
>>>
>>>     Hi Andreas,
>>>
>>>     That's what I did :-) It would be great if you could review the p=
roposed implementation at https://github.com/ceph/ceph/pull/518/files . I=
'll keep working on https://github.com/dachary/ceph/commit/83845a66ae1cba=
63c122c0ef7658b97b474c2bd2 tomorrow to create the jerasure plugin but it'=
s not ready for review yet.
>>>
>>>     Cheers
>>>
>>>     > Cheers Andreas.
>>>     >
>>>     >
>>>     >
>>>     >
>>>     >
>>>     > On Mon, Aug 19, 2013 at 12:35 PM, Loic Dachary <loic@dachary.or=
g <mailto:loic@dachary.org> <mailto:loic@dachary.org <mailto:loic@dachary=
=2Eorg>>> wrote:
>>>     >
>>>     >     Hi Andreas,
>>>     >
>>>     >     Trying to write minimal code as you suggested, for an examp=
le plugin. My first attempt at writing an erasure coding function. I don'=
t get how you can rebuild P1 + A from P2 + B + C. I must be missing somet=
hing obvious :-)
>>>     >
>>>     >     Cheers
>>>     >
>>>     >     On 07/07/2013 23:04, Andreas Joachim Peters wrote:
>>>     >     >
>>>     >     > Hi Loic,
>>>     >     > I don't think there is a better generic implementation. J=
ust made a benchmark .. the Jerasure library with algorithm 'cauchy_good'=
 gives 1.1 GB/s (Xeon 2.27 GHz) on a single core for a 4+2 encoding w=3D3=
2. Just to give a feeling if you do 10+4 it is 300 MB/s .... there is a s=
pecialized implementation in QFS (Hadoop in C++) for (M+3) ... for curios=
ity I will make a benchmark with this to compare with Jerasure ...
>>>     >     >
>>>     >     > In any case I would do an optimized implementation for 3+=
2 which would be probably the most performant implementation having the s=
ame reliability like standard 3-fold replication in CEPH using only 53% o=
f the space.
>>>     >     >
>>>     >     > 3+2 is trivial since you encode (A,B,C) with only two par=
ity operations
>>>     >     > P1 =3D A^B
>>>     >     > P2 =3D B^C
>>>     >     > and reconstruct with one or two parity operations:
>>>     >     > A =3D P1^B
>>>     >     > B =3D P1^A
>>>     >     > B =3D P2^C
>>>     >     > C =3D P2^B
>>>     >     > aso.
>>>     >     >
>>>     >     > You can write this as a simple loop using advanced vector=
 extensions on Intel (AVX). I can paste a benchmark tomorrow.
>>>     >     >
>>>     >     > Considering the crc32c-intel code you added ... I would p=
rovide a function which provides a crc32c checksum and detects if it can =
do it using SSE4.2 or implements just the standard algorithm e.g if you r=
un in a virtual machine you need this emulation ...
>>>     >     >
>>>     >     > Cheers Andreas.
>>>     >     > ________________________________________
>>>     >     > From: Loic Dachary [loic@dachary.org <mailto:loic@dachary=
=2Eorg> <mailto:loic@dachary.org <mailto:loic@dachary.org>>]
>>>     >     > Sent: 06 July 2013 22:47
>>>     >     > To: Andreas Joachim Peters
>>>     >     > Cc: ceph-devel@vger.kernel.org <mailto:ceph-devel@vger.ke=
rnel.org> <mailto:ceph-devel@vger.kernel.org <mailto:ceph-devel@vger.kern=
el.org>>
>>>     >     > Subject: Re: CEPH Erasure Encoding + OSD Scalability
>>>     >     >
>>>     >     > Hi Andreas,
>>>     >     >
>>>     >     > Since it looks like we're going to use jerasure-1.2, we w=
ill be able to try (C)RS using
>>>     >     >
>>>     >     > https://github.com/tsuraan/Jerasure/blob/master/src/cauch=
y.c
>>>     >     > https://github.com/tsuraan/Jerasure/blob/master/src/cauch=
y.h
>>>     >     >
>>>     >     > Do you know of a better / faster implementation ? Is ther=
e a tradeoff between (C)RS and RS ?
>>>     >     >
>>>     >     > Cheers
>>>     >     >
>>>     >     > On 06/07/2013 15:43, Andreas-Joachim Peters wrote:
>>>     >     >> HI Loic,
>>>     >     >> (C)RS stands for the Cauchy Reed-Solomon codes which are=
 based on pure parity operations, while the standard Reed-Solomon codes n=
eed more multiplications and are slower.
>>>     >     >>
>>>     >     >> Considering the checksumming ... for comparison the CRC3=
2 code from libz run's on a 8-core Xeon at ~730 MB/s for small block size=
s while SSE4.2 CRC32C checksum run's at ~2GByte/s.
>>>     >     >>
>>>     >     >> Cheers Andreas.
>>>     >     >>
>>>     >     >>
>>>     >     >>
>>>     >     >>
>>>     >     >> On Fri, Jul 5, 2013 at 11:23 PM, Loic Dachary <loic@dach=
ary.org <mailto:loic@dachary.org> <mailto:loic@dachary.org <mailto:loic@d=
achary.org>> <mailto:loic@dachary.org <mailto:loic@dachary.org> <mailto:l=
oic@dachary.org <mailto:loic@dachary.org>>>> wrote:
>>>     >     >>
>>>     >     >>     Hi Andreas,
>>>     >     >>
>>>     >     >>     On 04/07/2013 23:01, Andreas Joachim Peters wrote:> =
Hi Loic,
>>>     >     >>     > thanks for the responses!
>>>     >     >>     >
>>>     >     >>     > Maybe this is useful for your erasure code discuss=
ion:
>>>     >     >>     >
>>>     >     >>     > as an example in our RS implementation we chunk a =
data block of e.g. 4M into 4 data chunks of 1M. Then we create a 2 parity=
 chunks.
>>>     >     >>     >
>>>     >     >>     > Data & parity chunks are split into 4k blocks and =
these 4k blocks get a CRC32C block checksum each (SSE4.2 CPU extension =3D=
> MIT library or BTRFS). This creates 0.1% volume overhead (4 bytes per 4=
096 bytes) - nothing compared to the parity overhead ...
>>>     >     >>     >
>>>     >     >>     > You can now easily detect data corruption using th=
e local checksums and avoid to read any parity information and (C)RS deco=
ding if there is no corruption detected. Moreover CRC32C computation is d=
istributed over several (in this case 4) machines while (C)RS decoding wo=
uld run on a single machine where you assemble a block ... and CRC32C is =
faster than (C)RS decoding (with SSE4.2) ...
>>>     >     >>
>>>     >     >>     What does (C)RS mean ? (C)Reed-Solomon ?
>>>     >     >>
>>>     >     >>     > In our case we write this checksum information sep=
arate from the original data ... while in a block-based storage like CEPH=
 it would be probably inlined in the data chunk.
>>>     >     >>     > If an OSD detects to run on BRTFS or ZFS one could=
 disable automatically the CRC32C code.
>>>     >     >>
>>>     >     >>     Nice. I did not know that was built-in :-)
>>>     >     >>     https://github.com/dachary/ceph/blob/wip-4929/doc/de=
v/osd_internals/erasure-code.rst#scrubbing
>>>     >     >>
>>>     >     >>     > (wouldn't CRC32C be also useful for normal CEPH bl=
ock replication? )
>>>     >     >>
>>>     >     >>     I don't know the details of scrubbing but it seems C=
RC is already used by deep scrubbing
>>>     >     >>
>>>     >     >>     https://github.com/ceph/ceph/blob/master/src/osd/PG.=
cc#L2731
>>>     >     >>
>>>     >     >>     Cheers
>>>     >     >>
>>>     >     >>     > As far as I know with the RS CODEC we use you can =
either miss stripes (data =3D0) in the decoding process but you cannot in=
ject corrupted stripes into the decoding process, so the block checksummi=
ng is important.
>>>     >     >>     >
>>>     >     >>     > Cheers Andreas.
>>>     >     >>
>>>     >     >>     --
>>>     >     >>     Lo=EFc Dachary, Artisan Logiciel Libre
>>>     >     >>     All that is necessary for the triumph of evil is tha=
t good people do nothing.
>>>     >     >>
>>>     >     >>
>>>     >     >
>>>     >     > --
>>>     >     > Lo=EFc Dachary, Artisan Logiciel Libre
>>>     >     > All that is necessary for the triumph of evil is that goo=
d people do nothing.
>>>     >     >
>>>     >     > --
>>>     >     > To unsubscribe from this list: send the line "unsubscribe=
 ceph-devel" in
>>>     >     > the body of a message to majordomo@vger.kernel.org <mailt=
o:majordomo@vger.kernel.org> <mailto:majordomo@vger.kernel.org <mailto:ma=
jordomo@vger.kernel.org>>
>>>     >     > More majordomo info at  http://vger.kernel.org/majordomo-=
info.html
>>>     >     >
>>>     >
>>>     >     --
>>>     >     Lo=EFc Dachary, Artisan Logiciel Libre
>>>     >     All that is necessary for the triumph of evil is that good =
people do nothing.
>>>     >
>>>     >
>>>
>>>     --
>>>     Lo=EFc Dachary, Artisan Logiciel Libre
>>>     All that is necessary for the triumph of evil is that good people=
 do nothing.
>>>
>>>
>>
>
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
> All that is necessary for the triumph of evil is that good people do no=
thing.
>

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig31A93348AB6EBF90CD36E07B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlI0pTcACgkQ8dLMyEl6F21edgCfZcCiIwSiUKL66/N7IesAb7BC
lHIAnAqEWGT4FyzB1sdueZnja0qyQM3V
=xRgY
-----END PGP SIGNATURE-----

--------------enig31A93348AB6EBF90CD36E07B--
