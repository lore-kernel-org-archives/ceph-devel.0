From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Adding compression support for bluestore.
Date: Wed, 24 Feb 2016 21:18:52 +0300
Message-ID: <56CDF40C.9060405@mirantis.com>
References: <56C1FCF3.4030505@mirantis.com>
 <CACJqLyb=X1i7tsYeKOEJRdJEEMBGvgW817eY5Bo9YBXDszUDmw@mail.gmail.com>
 <56C3BAA3.3070804@mirantis.com>
 <CY1PR0201MB1897E7F1DE04B5E4577B16EDE8A00@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1602220718380.13988@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:34285 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbcBXSSr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Feb 2016 13:18:47 -0500
Received: by mail-lb0-f179.google.com with SMTP id of3so15270213lbc.1
        for <ceph-devel@vger.kernel.org>; Wed, 24 Feb 2016 10:18:46 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1602220718380.13988@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Allen Samuels <Allen.Samuels@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Allen, Sage

thanks a lot for interesting input.

May I have some clarification and highlight some caveats though?

1) Allen, are you suggesting to have permanent logical blocks layout=20
established after the initial writing?
Please find what I mean at the example below ( logical offset/size are=20
provided only for the sake of simplicity).
Imagine client has performed multiple writes that created following map=
=20
<logical offset, logical size>:
<0, 100>
<100, 50>
<150, 70>
<230, 70>
and an overwrite request <120,70> is coming.
The question is if resulting mapping to be the same or should be update=
d=20
as below:
<0,100>
<100, 20>    //updated extent
<120, 100> //new extent
<220, 10>   //updated extent
<230, 70>

2) In fact "Application units" that write requests delivers to BlueStor=
e=20
are pretty( or even completely) distorted by Ceph internals (Caching=20
infra, striping, EC). Thus there is a chance we are dealing with a=20
broken picture and suggested modification brings no/minor benefit.

3) Sage - could you please elaborate the per-extent checksum use case -=
=20
how are we planing to use that?

Thanks,
Igor.

On 22.02.2016 15:25, Sage Weil wrote:
> On Fri, 19 Feb 2016, Allen Samuels wrote:
>> This is a good start to an architecture for performing compression.
>>
>> I am concerned that it's a bit too simple at the expense of potentia=
lly
>> significant performance. In particular, I believe it's often ineffic=
ient
>> to force compression to be performed in block sizes and alignments t=
hat
>> may not match the application's usage.
>>
>>   I think that extent mapping should be enhanced to include the full
>>   tuple: <Logical offset, Logical Size, Physical offset, Physical si=
ze,
>>   compression algo>
> I agree.
>  =20
>> With the full tuple, you can compress data in the natural units of t=
he
>> application (which is most likely the size of the write operation th=
at
>> you received) and on its natural alignment (which will eliminate a l=
ot
>> of expensive-and-hard-to-handle partial overwrites) rather than the
>> proposal of a fixed size compression block on fixed boundaries.
>>
>> Using the application's natural block size for performing compressio=
n
>> may allow you a greater choice of compression algorithms. For exampl=
e,
>> if you're doing 1MB object writes, then you might want to be using
>> bzip-ish algorithms that have large compression windows rather than =
the
>> 32-K limited zlib algorithm or the 64-k limited snappy. You wouldn't
>> want to do that if all compression was limited to a fixed 64K window=
=2E
>>
>> With this extra information a number of interesting algorithm choice=
s
>> become available. For example, in the partial-overwrite case you can
>> just delay recovering the partially overwritten data by having an ex=
tent
>> that overlaps a previous extent.
> Yep.
>
>> One objection to the increased extent tuple is that amount of
>> space/memory it would consume. This need not be the case, the existi=
ng
>> BlueStore architecture stores the extent map in a serialized format
>> different from the in-memory format. It would be relatively simple t=
o
>> create multiple serialization formats that optimize for the typical
>> cases of when the logical space is contiguous (i.e., logical offset =
is
>> previous logical offset + logical size) and when there's no compress=
ion
>> (logical size =3D=3D physical size). Only the deserialized in-memory=
 format
>> of the extent table has the fully populated tuples. In fact this is =
a
>> desirable optimization for the current bluestore regardless of wheth=
er
>> this compression proposal is adopted or not.
> Yeah.
>
> The other bit we should probably think about here is how to store
> checksums.  In the compressed extent case, a simple approach would be=
 to
> just add the checksum (either compressed, uncompressed, or both) to t=
he
> extent tuple, since the extent will generally need to be read in its
> entirety anyway.  For uncompressed extents, that's not the case, and
> having an independent map of checksums over smaller block sizes makes
> sense, but that doesn't play well with the variable alignment/extent =
size
> approach.  I kind of sucks to have multiple formats here, but if we c=
an
> hide it behind the in-memory representation and/or interface (so that=
,
> e.g., each extent has a checksum block size and a vector of checksums=
) we
> can optimize the encoding however we like without affecting other cod=
e.
>
> sage
>
>>
>> Allen Samuels
>> Software Architect, Fellow, Systems and Software Solutions
>>
>> 2880 Junction Avenue, San Jose, CA 95134
>> T: +1 408 801 7030| M: +1 408 780 6416
>> allen.samuels@SanDisk.com
>>
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger=
=2Ekernel.org] On Behalf Of Igor Fedotov
>> Sent: Tuesday, February 16, 2016 4:11 PM
>> To: Haomai Wang <haomaiwang@gmail.com>
>> Cc: ceph-devel <ceph-devel@vger.kernel.org>
>> Subject: Re: Adding compression support for bluestore.
>>
>> Hi Haomai,
>> Thanks for your comments.
>> Please find my response inline.
>>
>> On 2/16/2016 5:06 AM, Haomai Wang wrote:
>>> On Tue, Feb 16, 2016 at 12:29 AM, Igor Fedotov <ifedotov@mirantis.c=
om> wrote:
>>>> Hi guys,
>>>> Here is my preliminary overview how one can add compression suppor=
t
>>>> allowing random reads/writes for bluestore.
>>>>
>>>> Preface:
>>>> Bluestore keeps object content using a set of dispersed extents
>>>> aligned by 64K (configurable param). It also permits gaps in objec=
t
>>>> content i.e. it prevents storage space allocation for object data
>>>> regions unaffected by user writes.
>>>> A sort of following mapping is used for tracking stored object
>>>> content disposition (actual current implementation may differ but
>>>> representation below seems to be sufficient for our purposes):
>>>> Extent Map
>>>> {
>>>> < logical offset 0 -> extent 0 'physical' offset, extent 0 size > =
=2E..
>>>> < logical offset N -> extent N 'physical' offset, extent N size > =
}
>>>>
>>>>
>>>> Compression support approach:
>>>> The aim is to provide generic compression support allowing random
>>>> object read/write.
>>>> To do that compression engine to be placed (logically - actual
>>>> implementation may be discussed later) on top of bluestore to "int=
ercept"
>>>> read-write requests and modify them as needed.
>>>> The major idea is to split object content into fixed size logical
>>>> blocks ( MAX_BLOCK_SIZE,  e.g. 1Mb). Blocks are compressed
>>>> independently. Due to compression each block can potentially occup=
y
>>>> smaller store space comparing to their original size. Each block i=
s
>>>> addressed using original data offset ( AKA 'logical offset' above =
).
>>>> After compression is applied each block is written using the exist=
ing
>>>> bluestore infra. In fact single original write request may affect
>>>> multiple blocks thus it transforms into multiple sub-write request=
s.
>>>> Block logical offset, compressed block data and compressed data le=
ngth are the parameters for injected sub-write requests.
>>>> As a result stored object content:
>>>> a) Has gaps
>>>> b) Uses less space if compression was beneficial enough.
>>>>
>>>> Overwrite request handling is pretty simple. Write request data is
>>>> splitted into fully and partially overlapping blocks. Fully
>>>> overlapping blocks are compressed and written to the store (given =
the
>>>> extended write functionality described below). For partially
>>>> overwlapping blocks ( no more than 2 of them
>>>> - head and tail in general case)  we need to retrieve already stor=
ed
>>>> blocks, decompress them, merge the existing and received data into=
 a
>>>> block, compress it and save to the store using new size.
>>>> The tricky thing for any written block is that it can be both long=
er
>>>> and shorter than previously stored one.  However it always has upp=
er
>>>> limit
>>>> (MAX_BLOCK_SIZE) since we can omit compression and use original bl=
ock
>>>> if compression ratio is poor. Thus corresponding bluestore extent =
for
>>>> this block is limited too and existing bluestore mapping doesn't
>>>> suffer: offsets are permanent and are equal to originally ones pro=
vided by the caller.
>>>> The only extension required for bluestore interface is to provide =
an
>>>> ability to remove existing extents( specified by logical offset,
>>>> size). In other words we need write request semantics extension (
>>>> rather by introducing an additional extended write method). Curren=
tly
>>>> overwriting request can either increase allocated space or leave i=
t
>>>> unaffected only. And it can have arbitrary offset,size parameters
>>>> pair. Extended one should be able to squeeze store space ( e.g. by
>>>> removing existing extents for a block and allocating reduced set o=
f
>>>> new ones) as well. And extended write should be applied to a speci=
fic
>>>> block only, i.e. logical offset to be aligned with block start off=
set
>>>> and size limited to MAX_BLOCK_SIZE. It seems this is pretty simple=
 to
>>>> add - most of the functionality for extent append/removal if alrea=
dy present.
>>>>
>>>> To provide reading and (over)writing compression engine needs to
>>>> track additional block mapping:
>>>> Block Map
>>>> {
>>>> < logical offset 0 -> compression method, compressed block 0 size =
>
>>>> ...
>>>> < logical offset N -> compression method, compressed block N size =
> }
>>>> Please note that despite the similarity with the original bluestor=
e
>>>> extent map the difference is in record granularity: 1Mb vs 64Kb. T=
hus
>>>> each block mapping record might have multiple corresponding extent=
 mapping records.
>>>>
>>>> Below is a sample of mappings transform for a pair of overwrites.
>>>> 1) Original mapping ( 3 Mb were written before, compress ratio 2 f=
or
>>>> each
>>>> block)
>>>> Block Map
>>>> {
>>>>    0 -> zlib, 512Kb
>>>>    1Mb -> zlib, 512Kb
>>>>    2Mb -> zlib, 512Kb
>>>> }
>>>> Extent Map
>>>> {
>>>>    0 -> 0, 512Kb
>>>>    1Mb -> 512Kb, 512Kb
>>>>    2Mb -> 1Mb, 512Kb
>>>> }
>>>> 1.5Mb allocated [ 0, 1.5 Mb] range )
>>>>
>>>> 1) Result mapping ( after overwriting 1Mb data at 512 Kb offset,
>>>> compress ratio 1 for both affected blocks) Block Map {
>>>>    0 -> none, 1Mb
>>>>    1Mb -> none, 1Mb
>>>>    2Mb -> zlib, 512Kb
>>>> }
>>>> Extent Map
>>>> {
>>>>    0 -> 1.5Mb, 1Mb
>>>>    1Mb -> 2.5Mb, 1Mb
>>>>    2Mb -> 1Mb, 512Kb
>>>> }
>>>> 2.5Mb allocated ( [1Mb, 3.5 Mb] range )
>>>>
>>>> 2) Result mapping ( after (over)writing 3Mb data at 1Mb offset,
>>>> compress ratio 4 for all affected blocks) Block Map {
>>>>    0 -> none, 1Mb
>>>>    1Mb -> zlib, 256Kb
>>>>    2Mb -> zlib, 256Kb
>>>>    3Mb -> zlib, 256Kb
>>>> }
>>>> Extent Map
>>>> {
>>>>    0 -> 1.5Mb, 1Mb
>>>>    1Mb -> 0Mb, 256Kb
>>>>    2Mb -> 0.25Mb, 256Kb
>>>>    3Mb -> 0.5Mb, 256Kb
>>>> }
>>>> 1.75Mb allocated (  [0Mb-0.75Mb] [1.5 Mb, 2.5 Mb )
>>>>
>>> Thanks for Igore!
>>>
>>> Maybe I'm missing something, is it compressed inline not offline?
>> That's about inline compression.
>>> If so, I guess we need to provide with more flexible controls to
>>> upper, like explicate compression flag or compression unit.
>> Yes I agree. We need a sort of control for compression - on per obje=
ct or per pool basis...
>> But at the overview above I was more concerned about algorithmic asp=
ect i.e. how to implement random read/write handling for compressed obj=
ects.
>> Compression management from the user side can be considered a bit la=
ter.
>>
>>>> Any comments/suggestions are highly appreciated.
>>>>
>>>> Kind regards,
>>>> Igor.
>>>>
>>>>
>>>>
>>>>
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el"
>>>> in the body of a message to majordomo@vger.kernel.org More majordo=
mo
>>>> info at  http://vger.kernel.org/majordomo-info.html
>> Thanks,
>> Igor
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in the body of a message to majordomo@vger.kernel.org More majordomo =
info at  http://vger.kernel.org/majordomo-info.html
>> PLEASE NOTE: The information contained in this electronic mail messa=
ge is intended only for the use of the designated recipient(s) named ab=
ove. If the reader of this message is not the intended recipient, you a=
re hereby notified that you have received this message in error and tha=
t any review, dissemination, distribution, or copying of this message i=
s strictly prohibited. If you have received this communication in error=
, please notify the sender by telephone or e-mail (as shown above) imme=
diately and destroy any and all copies of this message in your possessi=
on (whether hard copies or electronically stored copies).
>> N?????r??y??????X??=C7=A7v???)=DE=BA{.n?????z?]z????ay?=1D=CA=87=DA=99=
??j=07??f???h?????=1E?w???=0C???j:+v???w????????=07????zZ+???????j"????=
i

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
