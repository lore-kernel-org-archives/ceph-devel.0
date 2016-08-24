From: Mark Nelson <mnelson@redhat.com>
Subject: Re: bluestore blobs REVISITED
Date: Wed, 24 Aug 2016 15:47:19 -0500
Message-ID: <2cb7e3b7-1e34-c13d-f3ba-8107385dacb7@redhat.com>
References: <BLUPR0201MB15245F1EA4B70EF5761981AFE8170@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608211601350.14754@piezo.us.to>
 <2F51EC8C-D280-4DFF-8FF6-4AC97071A7D5@sandisk.com>
 <BLUPR0201MB15245054714F66FC2AB92935E8E80@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608222158190.25681@piezo.us.to>
 <BLUPR0201MB152454CA00246E35A1AE08C0E8E80@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608222249560.25681@piezo.us.to>
 <BLUPR0201MB1524C52747AF115A4C178D0FE8E80@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608231548080.25678@piezo.us.to>
 <BLUPR0201MB152475F2D6907CAD2E594FC6E8EB0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608231918460.25678@piezo.us.to>
 <BLUPR0201MB1524808F8F4763BB50517C12E8EA0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608241759180.25678@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754978AbcHXUsb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 24 Aug 2016 16:48:31 -0400
In-Reply-To: <alpine.DEB.2.11.1608241759180.25678@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Allen Samuels <Allen.Samuels@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 08/24/2016 01:15 PM, Sage Weil wrote:
> On Wed, 24 Aug 2016, Allen Samuels wrote:
>>>>> From: Sage Weil [mailto:sweil@redhat.com]
>>>>> Sent: Tuesday, August 23, 2016 12:03 PM
>>>>> To: Allen Samuels <Allen.Samuels@sandisk.com>
>>>>> Cc: ceph-devel@vger.kernel.org
>>>>> Subject: RE: bluestore blobs REVISITED
>>>>>
>>>>> I just got the onode, including the full lextent map, down to ~1500 bytes.
>>>>> The lextent map encoding optimizations went something like this:
>>>>>
>>>>> - 1 blobid bit to indicate that this lextent starts where the last one ended.
>>>>> (6500->5500)
>>>>>
>>>>> - 1 blobid bit to indicate offset is 0; 1 blobid bit to indicate
>>>>> length is same as previous lextent.  (5500->3500)
>>>>>
>>>>> - make blobid signed (1 bit) and delta encode relative to previous blob.
>>>>> (3500->1500).  In practice we'd get something between 1500 and 3500
>>>>> because blobids won't have as much temporal locality as my test
>>> workload.
>>>>> OTOH, this is really important because blobids will also get big
>>>>> over time (we don't (yet?) have a way to reuse blobids and/or keep
>>>>> them unique to a hash key, so they grow as the osd ages).
>>>>
>>>> This seems fishy to me, my mental model for the blob_id suggests that
>>>> it must be at least 9 bits (for a random write workload) in size (1K
>>>> entries randomly written lead to an average distance of 512, which
>>>> means
>>>> 10 bits to encode -- plus the other optimizations bits). Meaning that
>>>> you're going to have two bytes for each lextent, meaning at least 2048
>>>> bytes of lextent plus the remainder of the oNode. So, probably more
>>>> like
>>>> 2500 bytes.
>>>>
>>>> Am I missing something?
>>>
>>> Yeah, it'll be ~2 bytes in general, not 1, so closer to 2500 bytes.  I this is still
>>> enough to get us under 4K of metadata if we make pg_stat_t encoding
>>> space-efficient (and possibly even without out).
>
> Repeating this test with random IO gives onodes that are more like 6-7k, I
> think just because there are too many significant bits in the blob id.
>
> So, I think we can scratch options #1 and #2 off the list.

hrmf. I was still holding out hope #2 would be good enough.  Oh well.  I 
still remain very concerned about CPU usage, but we'll see where we are 
at once the dust settles.

Mark

>
>>>>> 3) join lextents and blobs (Allen's proposal) and dynamically bin
>>>>> based on the encoded size.
>>>>>
>>>>> 4) #3, but let shard_size=0 in onode (or whatever) put it inline
>>>>> with onode, so that simple objects avoid any additional kv op.
>>>>
>>>> Yes, I'm still of the mind that this is the best approach. I'm not
>>>> sure it's really that hard because most of the "special" cases can be
>>>> dealt with in a common brute-force way (because they don't happen too
>>> often).
>>>
>>> Yep.  I think my next task is to code this one up.  Before I start, though, I want
>>> to make sure I'm doing the most reasonable thing.  Please
>>> review:
>>>
>>> Right now the blobwise branch has (unshared and) shared blobs in their own
>>> key.  Shared blobs only update when they are occluded and their ref_map
>>> changes.  If it weren't for that, we could go back to cramming them together
>>> in a single bnode key, but I'm I think we'll do better with them as separate
>>> blob keys.  This helps small reads (we don't load all blobs), hurts large reads
>>> (we read them all from separate keys instead of all at once), and of course
>>> helps writes because we only update a single small blob record.
>>>
>>> The onode will get a extent_map_shard_size, which is measured in bytes
>>> and tells us how the map is chunked into keys.  If it's 0, the whole map will
>>> stay inline in the onode.  Otherwise, [0..extent_map_shard_size) is in the
>>> first key, [extent_map_shard_size, extent_map_shard_size*2) is in the
>>> second, etc.
>>
>> I've been thinking about this. I definitely like the '0' case where the lextent and potentially the local blob are inline with the oNode. That'll certainly accelerate lots of Object and CephFS stuff. All options should implement this.
>>
>> I've been thinking about the lextent sharding/binning/paging problem. Mentally, I see two different ways to do it:
>>
>> (1) offset-based fixed binning -- I think this is what you described, i.e., the lextent table is recast into fixed offset ranges.
>> (2) Dynamic binning. In this case, the ranges of lextent that are stored as a set of ranges (interval-set) each entry in the interval set represents a KV key and contains some arbitrary number of lextent entries within (boundaries are a dynamic decision)
>>
>> The downside of (1) is that you're going to have logical extents that cross the fixed bins (and sometimes MULTIPLE fixed bins). Handling this is just plain ugly in the code -- all sorts of special cases crop up for things like local-blobs that used to be unshared, now are sorta-shared (between the two 'split' lextent entries). Then there are the cases where single lextents cross 2, 3, 10 shards.... UGLY UGLY UGLY.
>>
>> A secondary problem (quite possibly a non-problem) is that the sizes of the chunks of encoded lextent don't necessarily divide up particularly evenly. Hot spots in objects will cause this problem.
>>
>> Method (2) sounds more complicated, but I actually think it's dramatically LESS complicated to implement -- because we're going to brute force our way around a lot of problem. First off, none of the ugly issues of splitting an lextent crop up -- by definition -- since we're chunking the map on whole lextent boundaries. I think from an implementation perspective you can break this down into some relatively simple logic.
>>
>> Basically from an implementation perspective, at the start of the operation (read or write), you compare the incoming offset with the interval-set in the oNode and page in the portions of the lextent table that are required (required=> for uncompressed is just the range in the incoming operation, for compressed I think you need to have the lextent before and after the incoming operation range to make the "depth limiting" code work correctly).
>> For a read, you're always done at this point in time.
>> For a write, you'll have the problem of updating the lextent table with whatever changes have been made. There are basically two sub-cases for the update:
>> (a) updated lextent chunk (or chunks!) are sufficiently similar that you want to maintain the current "chunking" values (more on this below). This is the easy case, just reserialize the chunk (or chunks) of the lextent that are changed (again, because of over-fetching in the compression case the changed range might not == the fetched range)
>> (b) You decide that re-chunking is required.  There are lots of cases of splits and joins of chunks -- more ugly code. However because the worst-case size of the lextent isn't really THAT large (and the frequency of re-chunking should be relatively low).  My recommendation is that we ONLY implement the complete re-chunking case. In other words, if you look at the chunking and you don't like it -- rather than spending time figuring out a bunch of splits and joins (sorta reminds me of FIleStore directory splits) just read in the remainder of the lextent into memory and re-chunk the entire darn thing. As long as the frequency of this is low it should be cheap enough (a max-size lextent table isn't THAT big). Keeping the frequency of chunking low should be doable by a policy with some hyste
 resis, i.e., something like if a chunk is > 'N' bytes do a splitting-rechunk, but only if it's smaller than N/2 bytes do a joining-rechunk.... Something like that...
>>
>> Nothing in the odisk structures prevents future code from implementing a more sophisticated split/join chunking scheme. In fact, I recommend that the oNode interval_set of the lextent chunks be decorated with the serialized sizes of each chunk so as to make that future algorithm much easier to implement (since it'll know the sizes of all of the serialized chunks). In other words, when it comes time to update the oNode/lextent, do the lextent chunks FIRST and use the generated sizes of the serialized lextents to put into the chunking table in the oNode. Have the sizes of all of the chunks available (without having to consult the KV store) will make the policy decision about when to re-chunk fairly easy to do and allow the future optimizer to make more intelligent decisions about balancin
 g the chunk-boundaries -- the extra data is pretty small and likely worth it (IMO).
>>
>> I strongly believe that (2) is the way to go.
>
> Yep, agreed!
>
>>> In memory, we can pull this out of the onode_t struct and manage it in
>>> Onode where we can keep track of which parts of loaded, dirty, etc.
>>>
>>> For each map chunk, we can do the inline blob trick.  Unfortunately we can
>>> only do this for 'unshared' blobs where shared is now shared across
>>> extent_map shards and not across objects.  We can conservatively estimate
>>> this by just looking at the blob size w/o looking at other lextents, at least.
>>
>> Some thoughts here. In the PMR and Flash world, isn't it the case that blobs are essentially immutable once they are global?
>>
>> (In the SMR world, I know they'll be modified in order to "relocate" a chunk -- possibly invalidating the immutable assumption).
>>
>> Why NOT pull the blob up into the lextent -- as a copy? If it's immutable, what's the harm? Yes, the stored metadata now expands by the reference count of a cloned blob, but if you can eliminate an extra KV fetch, I'm of the opinion that this seems like a desireable time/space tradeoff.... Just a thought :)
>>
>> BTW, here's potentially a really important thing that I just realized.... For a global blob, you want to make the blob_id something like #HashID.#LBA, that way when you're trying to do the SMR backpointer thing, you can minimize the number of bNodes you search for to find this LBA address (something like that :)) -- naturally this fails for blobs with multiple pextents -- But we can outlaw this case in the SMR world (space is basically ALWAYS sequential in the SMR world :)).
>
> Hrm.  This is frustrating.  Being able to do *blob* backpointers and only
> update blobs for SMR compaction is really appealing, but that means a flag
> that prevents blob inline-copying on SMR.  This makes me nervous because
> there will be yet another permutation in the mix: fully inline blob,
> external with inline copy (use external one if updating ref_map), and
> fully external.
>
> And if we do the inline copy, there isn't actually any purpose to most of
> the external copy except the ref_map.
>
> OTOH, with currently workloads at least we expect that cloned/shared blobs
> will be pretty rare, so perhaps we should ignore this and keep object hash
> (not blob) backpointers for SMR.
>
> In that case, we should focus instead on sharing the ref_map *only* and
> always inline the forward pointers for the blob.  This is closer to what
> we were originally doing with the enode.  In fact, we could go back to the
> enode approach were it's just a big extent_ref_map and only used to defer
> deallocations until all refs are retired.  The blob is then more ephemeral
> (local to the onode, immutable copy if cloned), and we can more easily
> rejigger how we store it.
>
> We'd still have a "ref map" type structure for the blob, but it would only
> be used for counting the lextents that reference it, and we can
> dynamically build it when we load the extent map.  If we impose the
> restriction that whatever the map sharding approach we take we never share
> a blob across a shard, we the blobs are always local and "ephemeral"
> in the sense we've been talking about.  The only downside here, I think,
> is that the write path needs to be smart enough to not create any new blob
> that spans whatever the current map sharding is (or, alternatively,
> trigger a resharding if it does so).
>
>
> Anyway, the main practical item that has me grumbling about this
> is that having extent_map in the onode_t means we have lots of helpers
> nad associated unit tests in test_bluestore_types.cc and making the
> extent map into a more dynamic structure (with pointers instead of ids
> etc) pulls it up a level above _types.{cc,h} and makes unit tests harder
> to write.  OTOH, the more complex structure probably needs its own tests
> to ensure we do the paging properly anyway, so here goes...
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
