From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Adding compression support for bluestore.
Date: Mon, 21 Mar 2016 21:01:14 +0300
Message-ID: <56F036EA.5060401@mirantis.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:35448 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757172AbcCUSBl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Mar 2016 14:01:41 -0400
Received: by mail-lb0-f175.google.com with SMTP id bc4so131385712lbc.2
        for <ceph-devel@vger.kernel.org>; Mon, 21 Mar 2016 11:01:40 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1603211141560.23875@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>



On 21.03.2016 18:50, Sage Weil wrote:
> On Mon, 21 Mar 2016, Igor Fedotov wrote:
>> On 19.03.2016 6:14, Allen Samuels wrote:
>>> If we're going to both allow compression and delayed overwrite we simply
>>> have to handle the case where new data actually overlaps with previous data
>>> -- recursively. If I understand the current code, it handles exactly one
>>> layer of overlay which is always stored in KV store. We need to generalize
>>> this data structure. I'm going to outline a proposal, which If I get wrong,
>>> I beg forgiveness -- I'm not as familiar with this code as I would like,
>>> especially the ref-counted shared extent stuff. But I'm going to blindly
>>> dive in and assume that Sage will correct me when I go off the tracks -- and
>>> therefore end up learning how all of this stuff REALLY works.
>>>
>>> I propose that the current bluestore_extent_t and bluestore_overlay_t  be
>>> essentially unified into a single structure with a typemark to distinguish
>>> between being in KV store or in raw block storage. Here's an example: (for
>>> this discussion, BLOCK_SIZE is 4K and is the minimum physical I/O size).
>>>
>>> Struct bluestore_extent_t {
>>>      Uint64_t logical_size;			// size of data before any
>>> compression. MUST BE AN INTEGER MULTIPLE of BLOCK_SIZE (and != 0)
>>>      Uint64_t physical_size;                              // size of data on
>>> physical media (yes, this is unneeded when location == KV, the
>>> serialize/deserialize could compress this out --  but this is an unneeded
>>> optimization
>>>      Uint64_t location:1;                                    // values (in
>>> ENUM form) are "KV" and "BLOCK"
>>>      Uint64_t compression_alg:4;                  // compression algorithm...
>>>      Uint64_t otherflags:xx;                             // round it out.
>>>      Uint64_t media_address;                        // forms Key when
>>> location == KV block address when location == BLOCK
>>>      Vector<uint32_t> checksums;              // Media checksums. See
>>> commentary on this below.
>>> };
>>>
>>> This allows any amount of compressed or uncompressed data to be identified
>>> in either a KV key or a block store.
>>>
>> As promised please find a competing proposal for extent map structure. It can
>> be used for handling unaligned overlapping writes of both
>> compressed/uncompressed data. It seems it's applicable for any compression
>> policy but my primary intention was to allow overwrites that use totally
>> different extents without the touch to the existing(overwritten) ones. I.e.
>> that's what Sage explained this way some time ago:
>>
>> "b) we could just leave the overwritten extents alone and structure the
>> block_map so that they are occluded.  This will 'leak' space for some
>> write patterns, but that might be okay given that we can come back later
>> and clean it up, or refine our strategy to be smarter."
>>
>> Nevertheless the corresponding infrastructure seems to be applicable for
>> different use cases too.
>>
>> At first let's consider simple raw data overwrite case. No compression,
>> checksums, flags at this point for the sake of simplicity.
>> Block map entry to be defined as follows:
>> OFFS:  < EXT_OFFS, EXT_LEN, X_OFFS, X_LEN>
>> where
>> EXT_OFFS, EXT_LEN - allocated extent offset and size, AKA physical address and
>> size.
>> X_OFFS - relative offset within the block where valid (not overwritten) data
>> starts. Full data offset = OFFS + X_OFFS
>> X_LEN - valid data size.
>> Invariant: Block length == X_OFFS + X_LEN
>>
>> Let's consider sample block map transform:
>> --------------------------------------------------------
>> ****** Step 0 (two incoming writes of 50 Kb at offset 0 and 100K):
>> ->Write(0,50)
>> ->Write(100, 50)
>>
>> Resulting block map ( OFFS: {EXT_OFFS, EXT_LEN, X_OFFS, X_LEN}  ):
>> 0:      {EO1, 50, 0, 50}
>> 100: {EO2, 50, 0, 50}
>>
>> Where EO1, EO2 - physical addresses for allocated extents.
>> Two new entries have been inserted.
>>
>> ****** Step 1 ( overwrite that partially overlaps both existing blocks ):
>> ->Write(25,100)
>>
>> Resulting block map ( OFFS: {EXT_OFFS, EXT_LEN, X_OFFS, X_LEN}  ):
>> 0:      {EO1, 50, 0, 25}
>> 25:    {EO3, 100, 0, 100}
>> 125: {EO2, 50, 25, 25}
>>
>> As one can see new entry at offset 25 has appeared and previous entries have
>> been altered (including the map key (100->125) for the last entry). No
>> physical extents reallocation took place though - just a new one at E03 has
>> been allocated.
>> Please note that client accessible data for block EO2 are actually stored at
>> EO2 + X_OFF(=25) and have 25K only despite the fact that extent has 50K total.
>> The same for block EO1 - valid data length = 25K only.
>>
>>
>> ****** Step 2 ( overwrite that partially overlaps existing blocks once again):
>> ->Write(70, 65)
>>
>> Resulting block map ( OFFS: {EXT_OFFS, EXT_LEN, X_OFFS, X_LEN}  ):
>> 0:      {EO1, 50, 0, 25}
>> 25:    {EO3, 100, 0, 45}
>> 70:    {EO4, 65, 0, 65}
>> 135: {EO2, 50, 35, 15}
>>
>> Yet another new entry. Overlapped block entries at 25 & 125 were altered.
>>
>> ****** Step 3 ( overwrite that partially overlaps one block and totally
>> overwrite the last one):
>> ->Write(100, 60)
>>
>> Resulting block map ( OFFS: {EXT_OFFS, EXT_LEN, X_OFFS, X_LEN}  ):
>> 0:      {EO1, 50, 0, 25}
>> 25:    {EO3, 100, 0, 45}
>> 70:    {EO4, 65, 0, 35}
>> 100: {EO5, 60, 0, 60}
>> -140: {EO2, 50, 50, 0}  -> to be removed as it's totally overwritten ( see
>> X_LEN = 0 )
>>
>> Entry for EO4 have been altered and entry EO2 to be removed. The latter can be
>> done both immediately on map alteration and by some background cleanup
>> procedure.
>>
>> ****** Step 4 ( overwrite that totally overlap the first block):
>> ->Write(0, 25)
>>
>> Resulting block map ( OFFS: {EXT_OFFS, EXT_LEN, X_OFFS, X_LEN}  ):
>> 0:      {EO6, 25, 0, 25}
>> - 0:      {EO1, 50, 25, 0}  -> to be removed
>> 25:    {EO3, 100, 0, 45}
>> 70:    {EO4, 65, 0, 35}
>> 100: {EO5, 60, 0, 60}
>>
>> Entry for EO1 has been overwritten and to be removed.
>> --------------------------------------------------------------------------------------
>>
>> Extending this block map for compression is trivial - we need to introduce
>> compression algorithm flag to the map. And vary EXT_LEN (and actual physical
>> allocation) depending on the actual compression ratio.
>> E.g. with ratio=3 (60K reduced to 20K) the record from the last step turn into
>> :
>> 100: {EO5, 20, 0, 60}
>>
>> Other compression aspects handled by the corresponding policies ( e.g. when
>> perform the compression ( immediately, lazily or totally in background ) or
>> how to merge neighboring compressed blocks ) probably don't impact the
>> structure of the map entry - they just shuffle the entries.
> This is much simpler!  There is one case we need to address that I don't
> see above, though.  Consider,
>
> - write 0~1048576, and compress it
> - write 16384~4096
Good catch! I really missed this case.
> When we split the large extent into two pieces, the resulting extent map,
> as per above, would be something like
>
> 0:      {EO1, 1048576, 0, 4096, zlib}
> 4096:   {E02, 16384, 0, 4096, uncompressed}
> 16384:	{E01, 1048576, 20480, 1028096, zlib}
>
> ...which is fine, except that it's the *same* compressed extent, which
> means the code that decides that the physical extent is no longer
> referenced and can be released needs to ensure that no other extents in
> the map reference it.  I think that's an O(n) pass across the map when
> releasing.
>
> Also, if we add in checksums, then we'd be duplicating them in the two
> instances that reference the raw extent.
>
> I wonder if it makes sense to break this into two structures.. one that
> lists the raw extents, and another that maps them into the logical space.
> So that there is one record for {E01, 1048576, zlib, checksums}, and then
> the block map is more like
>
> 0:      {E0, 0, 4096}
> 4096:   {E1, 0, 4096}
> 16384:	{E0, 20480, 1028096}
>
> and
>
> 0: E01, 1048576, 0, 4096, zlib, checksums
> 1: E02, 16384, 0, 4096, uncompressed, checksums
Sounds good!
> ?
>
> sage

Thanks,
Igor
