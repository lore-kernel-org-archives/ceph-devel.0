From: Sage Weil <sweil@redhat.com>
Subject: RE: bluestore blobs REVISITED
Date: Tue, 23 Aug 2016 19:39:38 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1608231918460.25678@piezo.us.to>
References: <BLUPR0201MB15245F1EA4B70EF5761981AFE8170@BLUPR0201MB1524.namprd02.prod.outlook.com>,<alpine.DEB.2.11.1608211601350.14754@piezo.us.to> <2F51EC8C-D280-4DFF-8FF6-4AC97071A7D5@sandisk.com> <BLUPR0201MB15245054714F66FC2AB92935E8E80@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608222158190.25681@piezo.us.to> <BLUPR0201MB152454CA00246E35A1AE08C0E8E80@BLUPR0201MB1524.namprd02.prod.outlook.com> <alpine.DEB.2.11.1608222249560.25681@piezo.us.to> <BLUPR0201MB1524C52747AF115A4C178D0FE8E80@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608231548080.25678@piezo.us.to> <BLUPR0201MB152475F2D6907CAD2E594FC6E8EB0@BLUPR0201MB1524.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33778 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751710AbcHWTjl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 23 Aug 2016 15:39:41 -0400
In-Reply-To: <BLUPR0201MB152475F2D6907CAD2E594FC6E8EB0@BLUPR0201MB1524.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 23 Aug 2016, Allen Samuels wrote:
> > -----Original Message-----
> > From: Sage Weil [mailto:sweil@redhat.com]
> > Sent: Tuesday, August 23, 2016 12:03 PM
> > To: Allen Samuels <Allen.Samuels@sandisk.com>
> > Cc: ceph-devel@vger.kernel.org
> > Subject: RE: bluestore blobs REVISITED
> > 
> > I just got the onode, including the full lextent map, down to ~1500 bytes.
> > The lextent map encoding optimizations went something like this:
> > 
> > - 1 blobid bit to indicate that this lextent starts where the last one ended.
> > (6500->5500)
> > 
> > - 1 blobid bit to indicate offset is 0; 1 blobid bit to indicate length is same as
> > previous lextent.  (5500->3500)
> > 
> > - make blobid signed (1 bit) and delta encode relative to previous blob.
> > (3500->1500).  In practice we'd get something between 1500 and 3500
> > because blobids won't have as much temporal locality as my test workload.
> > OTOH, this is really important because blobids will also get big over time (we
> > don't (yet?) have a way to reuse blobids and/or keep them unique to a hash
> > key, so they grow as the osd ages).
> 
> This seems fishy to me, my mental model for the blob_id suggests that it 
> must be at least 9 bits (for a random write workload) in size (1K 
> entries randomly written lead to an average distance of 512, which means 
> 10 bits to encode -- plus the other optimizations bits). Meaning that 
> you're going to have two bytes for each lextent, meaning at least 2048 
> bytes of lextent plus the remainder of the oNode. So, probably more like 
> 2500 bytes.
> 
> Am I missing something?

Yeah, it'll be ~2 bytes in general, not 1, so closer to 2500 bytes.  I 
this is still enough to get us under 4K of metadata if we make pg_stat_t 
encoding space-efficient (and possibly even without out).

> > https://github.com/liewegas/ceph/blob/wip-bluestore-
> > blobwise/src/os/bluestore/bluestore_types.cc#L826
> > 
> > This makes the metadata update for a 4k write look like
> > 
> >   1500 byte onode update
> >   20 byte blob update
> >   182 byte + 847(*) byte omap updates (pg log)
> > 
> >   * pg _info key... def some room for optimization here I think!
> > 
> > In any case, this is pretty encouraging.  I think we have a few options:
> > 
> > 1) keep extent map in onode and (re)encode fully each time (what I have
> > now).  blobs live in their own keys.
> > 
> > 2) keep extent map in onode but shard it in memory and only reencode the
> > part(s) that get modified.  this will alleviate the cpu concerns around a more
> > complex encoding.  no change to on-disk format.
> > 
> 
> This will save some CPU, but the write-amp is still pretty bad unless 
> you get the entire commit to < 4K bytes on Rocks.
> 
> > 3) join lextents and blobs (Allen's proposal) and dynamically bin 
> > based on the encoded size.
> > 
> > 4) #3, but let shard_size=0 in onode (or whatever) put it inline with onode, so
> > that simple objects avoid any additional kv op.
> 
> Yes, I'm still of the mind that this is the best approach. I'm not sure 
> it's really that hard because most of the "special" cases can be dealt 
> with in a common brute-force way (because they don't happen too often).

Yep.  I think my next task is to code this one up.  Before I start, 
though, I want to make sure I'm doing the most reasonable thing.  Please 
review:

Right now the blobwise branch has (unshared and) shared blobs in their own 
key.  Shared blobs only update when they are occluded and their ref_map 
changes.  If it weren't for that, we could go back to cramming them 
together in a single bnode key, but I'm I think we'll do better with them 
as separate blob keys.  This helps small reads (we don't load all blobs), 
hurts large reads (we read them all from separate keys instead of all at 
once), and of course helps writes because we only update a single small 
blob record.

The onode will get a extent_map_shard_size, which is measured in bytes and 
tells us how the map is chunked into keys.  If it's 0, the whole map will 
stay inline in the onode.  Otherwise, [0..extent_map_shard_size) is in the 
first key, [extent_map_shard_size, extent_map_shard_size*2) is in the 
second, etc.

In memory, we can pull this out of the onode_t struct and manage it in 
Onode where we can keep track of which parts of loaded, dirty, etc.

For each map chunk, we can do the inline blob trick.  Unfortunately we can 
only do this for 'unshared' blobs where shared is now shared across 
extent_map shards and not across objects.  We can conservatively 
estimate this by just looking at the blob size w/o looking at other 
lextents, at least.

I think we can also do a bit better than Varada's current map<> used 
during encode/decode.  As we iterate over the map, we can store the 
ephemeral blob id *for this encoding* in the Blob (not blob_t), and use 
the low bit of the blob id to indicate it is an ephemeral id vs a real 
one.  On decode we can size a vector at start and fill it with BlobRef 
entries as we go to avoid a dynamic map<> or other structure.  Another 
nice thing here is that we only have to assign global blobids when we are 
stored in a blob key instead of inline in the map, which makes the blob 
ids smaller (with fewer significant bits).

The Bnode then goes from a map of all blobs for the hash to a map of only 
shared (between shards or objects) for the hash--i.e., those blobs that 
have a blobid.  I think to make this work we then also need to change the 
in-memory lextent map from map<uint64_t,bluestore_lextent_t> to 
map<uint64_t,Lextent> so that we can handle the local vs remote pointer 
cases and for the local ones keep store the BlobRef right there.  This'll 
be marginally more complex to code (no 1:1 mapping of in-memory to encoded 
structures) but it should be faster (one less in-memory map lookup).

Anyway, that's the my current plan. Any thoughts before I start?
sage
