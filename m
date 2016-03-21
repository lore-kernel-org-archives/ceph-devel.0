From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Adding compression support for bluestore.
Date: Mon, 21 Mar 2016 17:07:30 +0300
Message-ID: <56F00022.9020307@mirantis.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:35692 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755429AbcCUOH0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Mar 2016 10:07:26 -0400
Received: by mail-lb0-f176.google.com with SMTP id bc4so127140961lbc.2
        for <ceph-devel@vger.kernel.org>; Mon, 21 Mar 2016 07:07:25 -0700 (PDT)
In-Reply-To: <CY1PR0201MB1897035E6E09FE518ACC2DDCE88D0@CY1PR0201MB1897.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>, Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Allen,

please find my comment inline

On 19.03.2016 6:14, Allen Samuels wrote:
> If we're going to both allow compression and delayed overwrite we simply have to handle the case where new data actually overlaps with previous data -- recursively. If I understand the current code, it handles exactly one layer of overlay which is always stored in KV store. We need to generalize this data structure. I'm going to outline a proposal, which If I get wrong, I beg forgiveness -- I'm not as familiar with this code as I would like, especially the ref-counted shared extent stuff. But I'm going to blindly dive in and assume that Sage will correct me when I go off the tracks -- and therefore end up learning how all of this stuff REALLY works.
>
> I propose that the current bluestore_extent_t and bluestore_overlay_t  be essentially unified into a single structure with a typemark to distinguish between being in KV store or in raw block storage. Here's an example: (for this discussion, BLOCK_SIZE is 4K and is the minimum physical I/O size).
That's a good idea to have uniform structure.
However it's not cleat to me if you are suggesting to have single 
container for both locations. I think you aren't.
In this case  most probably you don't need to have 'location' inside the 
structure. It's rather an uncommon case when instances from different 
locations are mixed and processed togather. And code that deals with it 
usually is aware of structure instance's origin. Even if that's not true 
- additional external parameter can be provided.
> Struct bluestore_extent_t {
>     Uint64_t logical_size;			// size of data before any compression. MUST BE AN INTEGER MULTIPLE of BLOCK_SIZE (and != 0)
>     Uint64_t physical_size;                              // size of data on physical media (yes, this is unneeded when location == KV, the serialize/deserialize could compress this out --  but this is an unneeded optimization
>     Uint64_t location:1;                                    // values (in ENUM form) are "KV" and "BLOCK"
>     Uint64_t compression_alg:4;                  // compression algorithm...
>     Uint64_t otherflags:xx;                             // round it out.
>     Uint64_t media_address;                        // forms Key when location == KV block address when location == BLOCK
>     Vector<uint32_t> checksums;              // Media checksums. See commentary on this below.
> };
>
> This allows any amount of compressed or uncompressed data to be identified in either a KV key or a block store.
>
> W.r.t. the vector of checksums.  There is lots of flexibility here which probably isn't worth dealing with. The simplest solution is to always generate a checksum for each BLOCK_SIZE-sized I/O independent of whether the data is compressed or not and independent of any physical I/O size. This means that data integrity on a read is checked AFTER decompression. This has a side-effect of requiring the decompressor to be "safe" in the presence of incorrect/corrupted data [not all decompressors have this property]. Alternatively for compressed data we use a single checksum (regardless of size) that covers only the compressed data. This allows the checksum to be checked before decompression. The second scheme has somewhat better performance as it checksums data AFTER compression (i.e., less dat
 a). Another potentially important flag here is to suppress bluestore checksum generation and checking -- some compression/decompression algorithms already do their own data integrity checks and it's silly to pay for that twice. Also, for data where a low BER is tolerable you might entertain the notion of skipping checksum generation. A null vector of checksums would certainly describe these situations (a flag could be added too).
Sounds good in general. But I'd prefer to start checksum implementation 
discussions from the goals and use cases - for what purposes we are 
planning to use them? What procedures benefit from that use? And how 
they do that?
May be we should have a separate topic for that?

> Once this unification is complete, you no longer need both "block_map" and "overlap_map" in onode_t. you just have an extent map. But in order to handle the lazy-recovery overlap schemes described above you must provide some kind of "priority" information so that when you have two extents that overlap you know which has the live data and which has the dead data. This is very easy to express in the onode_t data structure simply by making the extent map be an array of maps. The indexes in the array implicitly provide the priority ordering that you need. Now, when an write operation that generates the lazy-recovery scheme happens it just expands the size of the array and inserts the new extent there. Here's an example.
>
> First we write blocks 0..10. This leaves the map[0] with one extent(0..10).
> Now we lazy-overwrite blocks 2 and 3. We create map[1] and insert extent(2..3). But map[0] still contains extent(0..10).
> We can even lazy-overwrite block 3. We create map[2] and insert extent(3). Map[1] still has extent(2..3) and Map[0] still has extent(0..10);
> Now we write block 50. That extent could technically go into any index of the map.
>
> Yes, searching this data structure for the correct information IS more complicated than the current simple maps. But it's not hopelessly complicated and ought to be something that a good unit test can pretty much exhaustively cover with a little bit of thought. [I've skipped over thinking about refcounted extents as I don't fully understand those yet -- but they shouldn't be a fundamental problem]
That's an interesting proposal but I can see following caveats here (I 
beg pardon I  misunderstood something):
1) Potentially uncontrolled extent map growth when extensive 
(over)writing takes place.
2) Read/Lookup algorithmic complexity. To find valid block (or detect 
overwrite) one should sequentially enumerate the full array. Given 1) 
that might be very ineffective.
3) It's not dealing with unaligned overwrites. What happens when some 
block is partially overwritten?

I'm going to publish a bit different approach that hopefully handles 
these issues promptly. Stay tuned..
>
> This data structure fully enables any of the combinations of compression and overwriting that we've discussed. In particular it allows free intermixing of compressed and non-compressed data and fully supports any kind of delay-merging of compressed data (lazy space recovery) with data being written to either KV store or block store.
>
> BTW, I'm not sure how the current in-memory WAL queue is recovered after a crash/restart. Presumably there's an entry in the KV store to denote the presence of the WAL queue entry. That logical may require modification for cases where we are delaying the merge but the overlay data is actually in block storage. This might require some minor re-tweaking with this proposal.
>
> A question for Sage:
>
> Does the current WAL logic attempt to induce delay for the merging? It seems like there are potentially lots of situations where multiple overwrite are happening to the same object but are dispersed in time (slightly). Do we attempt to merge this in the WAL queue?
>
>
> Allen Samuels
> Software Architect, Fellow, Systems and Software Solutions
>
> 2880 Junction Avenue, San Jose, CA 95134
> T: +1 408 801 7030| M: +1 408 780 6416
> allen.samuels@SanDisk.com
>
>> -----Original Message-----
>> From: Igor Fedotov [mailto:ifedotov@mirantis.com]
>> Sent: Friday, March 18, 2016 10:54 AM
>> To: Sage Weil <sage@newdream.net>
>> Cc: Allen Samuels <Allen.Samuels@sandisk.com>; ceph-devel <ceph-
>> devel@vger.kernel.org>
>> Subject: Re: Adding compression support for bluestore.
>>
>>
>>
>> On 17.03.2016 18:33, Sage Weil wrote:
>>> I'd say "maybe". It's easy to say we should focus on read performance
>>> now, but as soon as we have "support for compression" everybody is
>>> going to want to turn it on on all of their clusters to spend less
>>> money on hard disks. That will definitely include RBD users, where
>>> write latency is very important. I'm hesitant to take an architectural
>>> direction that locks us in. With something layered over BlueStore I
>>> think we're forced to do it all in the initial phase; with the
>>> monolithic approach that integrates it into BlueStore's write path we
>>> have the option to do either one--perhaps based on the particular
>>> request or hints or whatever.
>>>>>>> What do you think?
>>>>>>>
>>>>>>> It would be nice to choose a simpler strategy for the first pass
>>>>>>> that handles a subset of write patterns (i.e., sequential writes,
>>>>>>> possibly
>>>>>>> unaligned) that is still a step in the direction of the more
>>>>>>> robust strategy we expect to implement after that.
>>>>>>>
>>>>>> I'd probably agree but.... I don't see a good way how one can
>>>>>> implement compression for specific write patterns only.
>>>>>> We need to either ensure that these patterns are used exclusively (
>>>>>> append only / sequential only flags? ) or provide some means to
>>>>>> fall back to regular mode when inappropriate write occurs.
>>>>>> Don't think both are good and/or easy enough.
>>>>> Well, if we simply don't implement a garbage collector, then for
>>>>> sequential+aligned writes we don't end up with stuff that needs
>>>>> sequential+garbage
>>>>> collection.  Even the sequential case might be doable if we make it
>>>>> possible to fill the extent with a sequence of compressed strings
>>>>> (as long as we haven't reached the compressed length, try to restart
>>>>> the decompression stream).
>>>> It's still unclear to me if such specific patterns should be
>>>> exclusively applied to the object. E.g. by using specific object creation
>> mode mode.
>>>> Or we should detect them automatically and be able to fall back to
>>>> regular write ( i.e. disable compression )  when write doesn't
>>>> conform to the supported pattern.
>>> I think initially supporting only the append workload is a simple
>>> check for whether the offset == the object size (and maybe whether it
>>> is aligned).  No persistent flags or hints needed there.
>> Well, but issues appear immediately after some overwrite request takes
>> place.
>> How to handle overwrites? To do compression for the overwritten or not?
>> If not - we need some way to be able to merge compressed and
>> uncompressed blocks. And so on and so forth IMO it's hard (or even
>> impossible) to apply compression for specific write patterns only unless you
>> prohibit other ones.
>> We can support a subset of compression policies ( i.e. ways how we resolve
>> compression issues: RMW at init phase, lazy overwrite, WAL use, etc ) but
>> not a subset of write patterns.
>>
>>>> And I'm not following the idea about "a sequence of compressed
>>>> strings". Could you please elaborate?
>>> Let's say we have 32KB compressed_blocks, and the client is doing 1000
>>> byte appends.  We will allocate a 32 chunk on disk, and only fill it
>>> with say ~500 bytes of compressed data.  When the next write comes
>>> around, we could compress it too and append it to the block without
>>> decompressing the previous string.
>>>
>>> By string I mean that each compression cycle looks something like
>>>
>>>    start(...)
>>>    while (more data)
>>>      compress_some_stuff(...)
>>>    finish(...)
>>>
>>> i.e., there's a header and maybe a footer in the compressed string.
>>> If we are decompressing and the decompressor says "done" but there is
>>> more data in our compressed block, we could repeat the process until
>>> we get to the end of the compressed data.
>> Got it, thanks for clarification
>>> But it might not matter or be worth it.  If the compressed blocks are
>>> smallish then decompressing, appending, and recompressing isn't going
>>> to be that expensive anyway.  I'm mostly worried about small appends,
>>> e.g. by rbd mirroring (imaging 4 KB writes + some metadata) or the MDS
>> journal.
>> That's mainly about small appends not small writes, right?
>>
>> At this point I agree with Allen that we need variable policies to handle
>> compression. Most probably we wouldn't be able to create single one that
>> fits perfect for any write pattern.
>> The only concern about that is the complexity of such a task...
>>> sage
>> Thanks,
>> Igor


