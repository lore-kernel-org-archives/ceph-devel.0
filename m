From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Adding compression support for bluestore.
Date: Wed, 30 Mar 2016 15:32:51 +0300
Message-ID: <56FBC773.90006@mirantis.com>
References: <56C1FCF3.4030505@mirantis.com> <56C3BAA3.3070804@mirantis.com>
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
 <CY1PR0201MB18978DB59BEB7C5DF68E346EE8870@CY1PR0201MB1897.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:33688 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbcC3Mcy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Mar 2016 08:32:54 -0400
Received: by mail-lb0-f179.google.com with SMTP id u8so30867144lbk.0
        for <ceph-devel@vger.kernel.org>; Wed, 30 Mar 2016 05:32:53 -0700 (PDT)
In-Reply-To: <CY1PR0201MB18978DB59BEB7C5DF68E346EE8870@CY1PR0201MB1897.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>, Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On 29.03.2016 23:45, Allen Samuels wrote:
>> -----Original Message-----
>> From: Sage Weil [mailto:sage@newdream.net]
>> Sent: Tuesday, March 29, 2016 1:20 PM
>> To: Igor Fedotov <ifedotov@mirantis.com>
>> Cc: Allen Samuels <Allen.Samuels@sandisk.com>; ceph-devel <ceph-
>> devel@vger.kernel.org>
>> Subject: Re: Adding compression support for bluestore.
>>
>> On Thu, 24 Mar 2016, Igor Fedotov wrote:
>>> Sage, Allen et. al.
>>>
>>> Please find some follow-up on our discussion below.
>>>
>>> Your past and future comments are highly appreciated.
>>>
>>> WRITE/COMPRESSION POLICY and INTERNAL BLUESTORE STRUCTURES
>> OVERVIEW.
>>> Used terminology:
>>> Extent - basic allocation unit. Variable in size, maximum size is
>>> limited by lblock length (see below), alignment: min_alloc_unit param
>>> (configurable, expected range: 4-64 Kb .
>>> Logical Block (lblock) - standalone traceable data unit. Min size unspecified.
>>> Alignment unspecified. Max size limited by max_logical_unit param
>>> (configurable, expected range: 128-512 Kb)
>>>
>>> Compression to be applied on per-extent basis.
>>> Multiple lblocks can refer specific region within a single extent.
>> This (and the what's below) sound right to me.  My main concern is around
>> naming.  I don't much like "extent" vs "lblock" (which is which?).  Maybe
>> extent and extent_ref?
>>
>> Also, I don't think we need the size limits you mention above.  When
>> compression is enabled, we'll limit the size of the disk extents by policy, but
>> the structures themselves needn't enforce that.  Similarly, I don't think the
>> lblocks (extent refs?  logical extents?) need a max size either.
>>
>> Anyway, right now we have bluestore_extent_t.  I'd suggest maybe
>>
>> 	bluestore_pextent_t and bluestore_lextent_t or
>> 	bluestore_extent_t and bluestore_extent_ref_t
>>
>> ?
> I prefer the lextent and pextent variant.
+1
>
> Can't we move all of these into a namespace, i.e., bluestore::lextent_t, bluestore::pextent_t, bluestore::onode_t, bluestore::bdev_label_t, etc.. That way the code within Bluestore itself doesn't have to keep redundantly repeating itself with super-long type names...
+1
but I'd suggest to have a standalone activity for that code refactor.
>>> POTENTIAL COMPRESSION APPLICATION POLICIES
>>>
>>> 1) Read/Merge/Write at initial commit phase. (RMW) General approach:
>>> New write request triggers partially overlapped lblock(s)
>>> reading/decompression followed by their merge into a set of new
>>> lblocks. Then compression is (optionally) applied. Resulting lblocks
>>> overwrite existing ones.
>>> For non-overlapping/fully overlapped lblocks read/merge steps are
>>> simply bypassed.
>>> - Read, merge and final compression take place prior to write commit
>>> ack that can impact write operation latency.
>>>
>>> 2) Deferred RMW for partial overlaps. (DRMW) General approach:
>>> Non-overlapping/fully overlapped lblocks handled similar to simple RMW.
>>> For partially overlapped lblocks one should use Write-Ahead Log to
>>> defer RMW procedure until write commit ack return.
>>> - Write operation latency can still be high in some cases (
>>> non-overlapped/fully overlapped writes).
>>> - WAL can grow significantly.
>>>
>>> 3) Writing new lblocks over new extents. (LBlock Bedding?) General
>>> approach:
>>> Write request creates new lblock(s) that use freshly allocated extents.
>>> Overlapped regions within existing lblocks are occluded.
>>> Previously existing extents are preserved for some time (or while
>>> being used) depending on the cleanup policy.
>>> Compression to be performed before write commit ack return.
>>> - Write operation latency is still affected by the compression.
>>> - Store space usage is usually higher.
>>>
>>> 4) Background compression (BCOMP)
>>> General approach:
>>> Write request to be handled using any of the above policies (or their
>>> combination) with no compression applied. Stored extents are
>>> compressed by some background process independently from the client
>> write flow.
>>> Merging new uncompressed lblock with already compressed one can be
>>> tricky here.
>>> + Write operation latency isn't affected by the compression.
>>> - Double disk write occurs
>>>
>>> To provide better user experience above-mentioned policies can be used
>>> together depending on the write pattern.
>>>
>>> INTERNAL DATA STRUCTURES TO TRACK OBJECT CONTENT.
>>>
>>> To track object content we need to introduce following 2 collections:
>>>
>>> 1) LBlock map:
>>> That's a logical offset mapping to a region within an extent:
>>> LOFFS -> {
>>>    EXTENT_REF       - reference to an underlying extent, e.g. pointer for
>>> in-memory representation or extent ID for "on-disk" one
>>>    X_OFFS, X_LEN,   - region descriptor within an extent: relative offset and
>>> region length
>>>    LFLAGS           - some associated flags for the lblock. Any usage???
>>> }
>>>
>>> 2) Extent collection:
>>> Each entry describes an allocation unit within storage space.
>>> Compression to be applied on per-extent basis thus extent's logical
>>> volume can be greater than it's physical size.
>>>
>>> {
>>>    P_OFFS            - physical block address
>>>    SIZE              - actual stored data length
>>>    EFLAGS            - flags associated with the extent
>>>    COMPRESSION_ALG   - An applied compression algorithm id if any
>>>    CHECKSUM(s)       - Pre-/Post compression checksums. Use cases TBD.
>>>    REFCOUNT          - Number of references to this entry
>>> }
>> Yep (modulo naming).
>>
>>> The possible container for this collection can be a mapping: id ->
>>> extent. It looks like such mapping is required during on-disk to
>>> in-memory representation transform as smart pointer seems to be enough
>> for in-memory use.
>>
>> Given the structures are small I'm not sure smart pointers are worth it..
>> Maybe just a simple vector (or maybe flat_map) for the extents?  Lookup will
>> be fast.
>>
> Smart pointers don't work well in the code. The deallocation of the pextent is more than just freeing the memory when the lextent reference count goes to zero -- It also includes the updating of a transaction to mutate the KV store to match the deallocation. Thus the destructor needs a reference to the KeyValueDB::transaction, which isn't really clean and easy to arrange (you'll have to hide it in the object, or some other ugly hack). From a coding perspective, I think you'll just have manually managed reference counts with explicit deallocation calls that pass in the right parameters.
Agree.


