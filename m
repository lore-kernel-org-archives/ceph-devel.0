From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Adding compression support for bluestore.
Date: Wed, 30 Mar 2016 15:28:52 +0300
Message-ID: <56FBC684.6090700@mirantis.com>
References: <56C1FCF3.4030505@mirantis.com>
 <CACJqLyb=X1i7tsYeKOEJRdJEEMBGvgW817eY5Bo9YBXDszUDmw@mail.gmail.com>
 <56C3BAA3.3070804@mirantis.com>
 <CY1PR0201MB1897E7F1DE04B5E4577B16EDE8A00@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1602220718380.13988@cpach.fuggernut.com>
 <56CDF40C.9060405@mirantis.com>
 <CY1PR0201MB1897BC7052AD6F7FB01DCAB4E8A50@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <56D08E30.20308@mirantis.com>
 <alpine.DEB.2.11.1603151243030.32086@cpach.fuggernut.com>
 <56E9A727.1030400@mirantis.com>
 <alpine.DEB.2.11.1603161515360.14377@cpach.fuggernut.com>
 <56EACAAD.90002@mirantis.com>
 <alpine.DEB.2.11.1603171123090.14377@cpach.fuggernut.com>
 <56EC248E.3060502@mirantis.com>
 <CY1PR0201MB1897035E6E09FE518ACC2DDCE88D0@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <56F013FB.4040002@mirantis.com>
 <alpine.DEB.2.11.1603211141560.23875@cpach.fuggernut.com>
 <56F3E157.2090004@mirantis.com>
 <alpine.DEB.2.11.1603291602330.6473@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:36575 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbcC3M2z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Mar 2016 08:28:55 -0400
Received: by mail-lb0-f180.google.com with SMTP id qe11so30694739lbc.3
        for <ceph-devel@vger.kernel.org>; Wed, 30 Mar 2016 05:28:54 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1603291602330.6473@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>



On 29.03.2016 23:19, Sage Weil wrote:
> On Thu, 24 Mar 2016, Igor Fedotov wrote:
>> Sage, Allen et. al.
>>
>> Please find some follow-up on our discussion below.
>>
>> Your past and future comments are highly appreciated.
>>
>> WRITE/COMPRESSION POLICY and INTERNAL BLUESTORE STRUCTURES OVERVIEW.
>>
>> Used terminology:
>> Extent - basic allocation unit. Variable in size, maximum size is limited by
>> lblock length (see below), alignment: min_alloc_unit param (configurable,
>> expected range: 4-64 Kb .
>> Logical Block (lblock) - standalone traceable data unit. Min size unspecified.
>> Alignment unspecified. Max size limited by max_logical_unit param
>> (configurable, expected range: 128-512 Kb)
>>
>> Compression to be applied on per-extent basis.
>> Multiple lblocks can refer specific region within a single extent.
> This (and the what's below) sound right to me.  My main concern is around
> naming.  I don't much like "extent" vs "lblock" (which is which?).  Maybe
> extent and extent_ref?
>
> Also, I don't think we need the size limits you mention above.  When
> compression is enabled, we'll limit the size of the disk extents by
> policy, but the structures themselves needn't enforce that.  Similarly, I
> don't think the lblocks (extent refs?  logical extents?) need a max size
> either.
Actually structures themselves don't have explicit limits except length 
fields width. But I'd prefer to enforce such a limit in the code ( add a 
policy?) that handles write (or perform merge ) to avoid huge 
l(p)extents for both compressed and uncompressed cases.
The rationale for that is potentially ineffective space usage. Partially 
overlapped writes occlude previous extents thus the larger they are the 
more probable such occluding take place and more space is wasted. 
Moreover IMHO leaving the control over extent granularity ( if we don't 
enforce any limit they totally depend on the user write pattern) isn't a 
good idea in any case.

> Anyway, right now we have bluestore_extent_t.  I'd suggest maybe
>
> 	bluestore_pextent_t and bluestore_lextent_t
> or
> 	bluestore_extent_t and bluestore_extent_ref_t
>
> ?
+1 to Allen for pextent & lextent.

>> POTENTIAL COMPRESSION APPLICATION POLICIES
>>
>> 1) Read/Merge/Write at initial commit phase. (RMW)
>> General approach:
>> New write request triggers partially overlapped lblock(s)
>> reading/decompression followed by their merge into a set of new lblocks. Then
>> compression is (optionally) applied. Resulting lblocks overwrite existing
>> ones.
>> For non-overlapping/fully overlapped lblocks read/merge steps are simply
>> bypassed.
>> - Read, merge and final compression take place prior to write commit ack that
>> can impact write operation latency.
>>
>> 2) Deferred RMW for partial overlaps. (DRMW)
>> General approach:
>> Non-overlapping/fully overlapped lblocks handled similar to simple RMW.
>> For partially overlapped lblocks one should use Write-Ahead Log to defer RMW
>> procedure until write commit ack return.
>> - Write operation latency can still be high in some cases (
>> non-overlapped/fully overlapped writes).
>> - WAL can grow significantly.
>>
>> 3) Writing new lblocks over new extents. (LBlock Bedding?)
>> General approach:
>> Write request creates new lblock(s) that use freshly allocated extents.
>> Overlapped regions within existing lblocks are occluded.
>> Previously existing extents are preserved for some time (or while being used)
>> depending on the cleanup policy.
>> Compression to be performed before write commit ack return.
>> - Write operation latency is still affected by the compression.
>> - Store space usage is usually higher.
>>
>> 4) Background compression (BCOMP)
>> General approach:
>> Write request to be handled using any of the above policies (or their
>> combination) with no compression applied. Stored extents are compressed by
>> some background process independently from the client write flow.
>> Merging new uncompressed lblock with already compressed one can be tricky
>> here.
>> + Write operation latency isn't affected by the compression.
>> - Double disk write occurs
>>
>> To provide better user experience above-mentioned policies can be used
>> together depending on the write pattern.
>>
>> INTERNAL DATA STRUCTURES TO TRACK OBJECT CONTENT.
>>
>> To track object content we need to introduce following 2 collections:
>>
>> 1) LBlock map:
>> That's a logical offset mapping to a region within an extent:
>> LOFFS -> {
>>    EXTENT_REF       - reference to an underlying extent, e.g. pointer for
>> in-memory representation or extent ID for "on-disk" one
>>    X_OFFS, X_LEN,   - region descriptor within an extent: relative offset and
>> region length
>>    LFLAGS           - some associated flags for the lblock. Any usage???
>> }
>>
>> 2) Extent collection:
>> Each entry describes an allocation unit within storage space. Compression to
>> be applied on per-extent basis thus extent's logical volume can be greater
>> than it's physical size.
>>
>> {
>>    P_OFFS            - physical block address
>>    SIZE              - actual stored data length
>>    EFLAGS            - flags associated with the extent
>>    COMPRESSION_ALG   - An applied compression algorithm id if any
>>    CHECKSUM(s)       - Pre-/Post compression checksums. Use cases TBD.
>>    REFCOUNT          - Number of references to this entry
>> }
> Yep (modulo naming).
>
>> The possible container for this collection can be a mapping: id -> extent. It
>> looks like such mapping is required during on-disk to in-memory representation
>> transform as smart pointer seems to be enough for in-memory use.
> Given the structures are small I'm not sure smart pointers are worth it..
> Maybe just a simple vector (or maybe flat_map) for the extents?  Lookup
> will be fast.
OK. Sounds reasonable.
I'd prefer a map.
>> SAMPLE MAP TRANSFORMATION FOR LBLOCK BEDDING POLICY ( all values in Kb )
>>
>> Config parameters:
>> min_alloc_unit = 4
>> max_logical_unit = 64
>>
>> --------------------------------------------------------
>> ****** Step 0 :
>> ->Write(0, 50), no compression
>> ->Write(100, 60), no compression
>>
>> Resulting maps:
>> LBLOCK map ( OFFS: { EXT_REF, X_OFFS, X_LEN}  ):
>> 0:   {EO1, 0, 50}
>> 100: {EO2, 0, 60}
>>
>> EXTENT map ( ID: { P_OFFS, SIZE, ALG, REFCOUNT}  ):
>> EO1: { POFFS_1, 50, NONE, 1}   //totally allocated 52 Kb
>> EO2: { POFFS_2, 60, NONE, 1}   //totally allocated 60 Kb
>>
>>
>> Where POFFS_1, POFFS_2 - physical addresses for allocated extents.
>>
>> ****** Step 1
>> ->Write(25, 100), compressed
>>
>> Resulting maps:
>> LBLOCK map ( OFFS: { EXT_REF, X_OFFS, X_LEN}  ):
>> 0:     {EO1, 0, 25}
>> 25:    {EO3, 0, 64}   //compressed into 20K
>> 79:    {EO4, 0, 36}   //compressed into 15K
>> 125:   {EO2, 25, 35}
>>
>> EXTENT map ( ID: { P_OFFS, SIZE, ALG, REFCOUNT}  ):
>> EO1: { POFFS_1, 50, NONE, 1}   //totally allocated 52 Kb
>> EO2: { POFFS_2, 60, NONE, 1}   //totally allocated 60 Kb
>> EO3: { POFFS_3, 20, ZLIB, 1}   //totally allocated 24 Kb
>> EO4: { POFFS_4, 15, ZLIB, 1}   //totally allocated 16 Kb
>>
>> As one can see new entries at offset 25 & 79  have appeared and previous
>> entries have been altered (including the map key (100->125) for the last
>> entry).
>> No physical extents reallocation took place though - just new ones (EO3 & EO4)
>> have been allocated.
>> Please note that client accessible data for block EO2 are actually stored at
>> P_OFFS_2 + X_OFF and have 35K only despite the fact that extent has 60K total.
>> The same for block EO1 - valid data length is 25K only.
>> Extent EO3 actually stores 20K of compressed data corresponding to 64K raw
>> one.
>> Extent EO4 actually stores 15K of compressed data corresponding to 36K raw
>> one.
>> Single 100K write has been splitted into 2 lblocks to address max_logical_unit
>> constraint
> Hmm, as a matter of policy, we might want to force alignment of the
> extents to max_logical_unit.  I think that might reduce fragmentation
> over time.
Yep
>
>> ****** Step 2
>> ->Write(70, 65), no compression
>>
>> LBLOCK map ( OFFS: { EXT_REF, X_OFFS, X_LEN}  ):
>> 0:     {EO1, 0, 25}
>> 25:    {EO3, 0, 45}
>> 70:    {EO5, 0, 65}
>> -125:   {EO4, 36, 0} -> to be removed as it's totally overwritten ( see X_LEN
>> = 0 )
>> 135:   {EO2, 35, 25}
>>
>> EXTENT map ( ID: { P_OFFS, SIZE, ALG, REFCOUNT}  ):
>> EO1: { POFFS_1, 50, NONE, 1}   //totally allocated 52 Kb
>> EO2: { POFFS_2, 60, NONE, 1}   //totally allocated 60 Kb
>> EO3: { POFFS_3, 20, ZLIB, 1}   //totally allocated 24 Kb
>> -EO4: { POFFS_4, 15, ZLIB, 0}  //totally allocated 16 Kb, can be released as
>> refcount = 0
>> EO5: { POFFS_5, 65, NONE, 1}   //totally allocated 68 Kb
>>
>> Entry at at offset 25 entry has been altered and entry at offset 125 to be
>> removed. The latter can be done both immediately on map alteration and by some
>> background cleanup procedure.
>>
>>
>> ****** Step 3
>> ->Write(100, 60), compressed to 30K
>>
>> LBLOCK map ( OFFS: { EXT_REF, X_OFFS, X_LEN}  ):
>> 0:     {EO1, 0, 25}
>> 25:    {EO3, 0, 45}
>> 70:    {EO5, 0, 65}
>> 100:   {EO6, 0, 60}
>> -160:   {EO2, 60, 0} -> to be removed as it's totally overwritten ( see X_LEN
>> = 0 )
>>
>> EXTENT map ( ID: { P_OFFS, SIZE, ALG, REFCOUNT}  ):
>> EO1: { POFFS_1, 50, NONE, 1}   //totally allocated 52 Kb
>> EO2: { POFFS_2, 60, NONE, 1}   //totally allocated 60 Kb
>> EO3: { POFFS_3, 20, ZLIB, 1}   //totally allocated 24 Kb
>> -EO5: { POFFS_5, 65, NONE, 0}  //totally allocated 68 Kb, can be released as
>> refcount = 0
>> EO6: { POFFS_6, 30, ZLIB, 1}   //totally allocated 32 Kb
>>
>> Entry at offset 100 has been altered and entry at offset 160 to be removed.
>>
>> ****** Step 4
>> ->Write(0, 25), no compression
>>
>> LBLOCK map ( OFFS: { EXT_REF, X_OFFS, X_LEN}  ):
>> 0:     {EO7, 0, 25}
>> -25:     {EO1, 25, 0}   -> to be removed
>> 25:    {EO3, 0, 45}
>> 70:    {EO5, 0, 65}
>> 100:   {EO6, 0, 60}
>> -160:   {EO2, 60, 0} -> to be removed as it's totally overwritten ( see X_LEN
>> = 0 )
>>
>> EXTENT map ( ID: { P_OFFS, SIZE, ALG, REFCOUNT}  ):
>> -EO1: { POFFS_1, 50, NONE, 1}   //totally allocated 52 Kb, can be released as
>> refcount = 0
>> EO2: { POFFS_2, 60, NONE, 1}   //totally allocated 60 Kb
>> EO3: { POFFS_3, 20, ZLIB, 1}   //totally allocated 24 Kb
>> EO6: { POFFS_6, 30, ZLIB, 1}   //totally allocated 32 Kb
>> EO7: { POFFS_7, 25, None, 1}   //totally allocated 38 Kb
>>
>> Entry at offset 0 has been overwritten and to be removed.
>>
>> IMPLMENTATION ROADMAP
> .5) Code and review the new data structures.  Include fields and flags for
> both compressoin and checksums.
>   
Would you like to have new data structures completely ready at this 
stage? With all checksum/compression/flag fields present?
As for me I'd prefer to add them incrementally when specific feature ( 
compression, checksum verification etc.) is implemented.
It might be hard to design all of them at once. And probably blocks the 
implementation until all the discussions completion.

>> 1) Refactor current Bluestore implementation to introduce the suggested
>> twin-structure design.
>> This will support raw data READ/WRITE without compression. Major policy to
>> implement is lblock bedding.
>> As an additional option DRMW to be implemented to provide a solution equal to
>> the current implementation. This might be useful for performance comparison.
>>
>> 2) Add basic compression support using lblock bedding policy.
>> This will lack most of management/statistics features too.
>>
>> 3) Add compression management/statistics. Design to be discussed.
>>
>> 4) Add check sum support. Goals and design to be discussed.
> This sounds good to me!
>
> FWIW, I think #1 is going to be the hard part.  Once we establish that the
> disk extents are somewhat immutable (because they are compressed or there
> is a coarse checksum or whatever) we'll have to restructure _do_write,
> _do_zero, _do_truncate, and _do_wal_op.  Those four are dicey.
Totally agree.

> sage
>
Thanks,
Igor
