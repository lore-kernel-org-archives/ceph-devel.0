From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: bluestore blobs
Date: Fri, 19 Aug 2016 14:16:30 +0000
Message-ID: <BLUPR0201MB1524465AA4D57D68A7D1503FE8160@BLUPR0201MB1524.namprd02.prod.outlook.com>
References: <alpine.DEB.2.11.1608171407220.17762@piezo.us.to>
 <BLUPR0201MB1524D88B4FD92E208DF840B0E8150@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608181459500.2394@piezo.us.to>
 <BLUPR0201MB1524E3013146AF4A4EFA573FE8160@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608191344500.14754@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sn1nam02on0080.outbound.protection.outlook.com ([104.47.36.80]:35872
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755189AbcHSOQf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 19 Aug 2016 10:16:35 -0400
In-Reply-To: <alpine.DEB.2.11.1608191344500.14754@piezo.us.to>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com]
> Sent: Friday, August 19, 2016 6:53 AM
> To: Allen Samuels <Allen.Samuels@sandisk.com>
> Cc: ceph-devel@vger.kernel.org
> Subject: RE: bluestore blobs
>=20
> On Fri, 19 Aug 2016, Allen Samuels wrote:
> > > -----Original Message-----
> > > From: Sage Weil [mailto:sweil@redhat.com]
> > > Sent: Thursday, August 18, 2016 8:10 AM
> > > To: Allen Samuels <Allen.Samuels@sandisk.com>
> > > Cc: ceph-devel@vger.kernel.org
> > > Subject: RE: bluestore blobs
> > >
> > > On Thu, 18 Aug 2016, Allen Samuels wrote:
> > > > > From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> > > > > owner@vger.kernel.org] On Behalf Of Sage Weil
> > > > > Sent: Wednesday, August 17, 2016 7:26 AM
> > > > > To: ceph-devel@vger.kernel.org
> > > > > Subject: bluestore blobs
> > > > >
> > > > > I think we need to look at other changes in addition to the
> > > > > encoding performance improvements.  Even if they end up being
> > > > > good enough, these changes are somewhat orthogonal and at least
> > > > > one of them should give us something that is even faster.
> > > > >
> > > > > 1. I mentioned this before, but we should keep the encoding
> > > > > bluestore_blob_t around when we load the blob map.  If it's not
> > > > > changed, don't reencode it.  There are no blockers for
> > > > > implementing this
> > > currently.
> > > > > It may be difficult to ensure the blobs are properly marked dirty=
...
> > > > > I'll see if we can use proper accessors for the blob to enforce
> > > > > this at compile time.  We should do that anyway.
> > > >
> > > > If it's not changed, then why are we re-writing it? I'm having a
> > > > hard time thinking of a case worth optimizing where I want to
> > > > re-write the oNode but the blob_map is unchanged. Am I missing
> something obvious?
> > >
> > > An onode's blob_map might have 300 blobs, and a single write only
> > > updates one of them.  The other 299 blobs need not be reencoded, just
> memcpy'd.
> >
> > As long as we're just appending that's a good optimization. How often
> > does that happen? It's certainly not going to help the RBD 4K random
> > write problem.
>=20
> It won't help the (l)extent_map encoding, but it avoids almost all of the=
 blob
> reencoding.  A 4k random write will update one blob out of ~100 (or
> whatever it is).
>=20
> > > > > 2. This turns the blob Put into rocksdb into two memcpy stages:
> > > > > one to assemble the bufferlist (lots of bufferptrs to each
> > > > > untouched
> > > > > blob) into a single rocksdb::Slice, and another memcpy somewhere
> > > > > inside rocksdb to copy this into the write buffer.  We could
> > > > > extend the rocksdb interface to take an iovec so that the first
> > > > > memcpy isn't needed (and rocksdb will instead iterate over our
> > > > > buffers and copy them directly into its write buffer).  This is
> > > > > probably a pretty small piece of the overall time... should
> > > > > verify with a profiler
> > > before investing too much effort here.
> > > >
> > > > I doubt it's the memcpy that's really the expensive part. I'll bet
> > > > it's that we're transcoding from an internal to an external
> > > > representation on an element by element basis. If the iovec scheme
> > > > is going to help, it presumes that the internal data structure
> > > > essentially matches the external data structure so that only an
> > > > iovec copy is required. I'm wondering how compatible this is with
> > > > the current concepts of lextext/blob/pextent.
> > >
> > > I'm thinking of the xattr case (we have a bunch of strings to copy
> > > verbatim) and updated-one-blob-and-kept-99-unchanged case: instead
> > > of memcpy'ing them into a big contiguous buffer and having rocksdb
> > > memcpy
> > > *that* into it's larger buffer, give rocksdb an iovec so that they
> > > smaller buffers are assembled only once.
> > >
> > > These buffers will be on the order of many 10s to a couple 100s of by=
tes.
> > > I'm not sure where the crossover point for constructing and then
> > > traversing an iovec vs just copying twice would be...
> > >
> >
> > Yes this will eliminate the "extra" copy, but the real problem is that
> > the oNode itself is just too large. I doubt removing one extra copy is
> > going to suddenly "solve" this problem. I think we're going to end up
> > rejiggering things so that this will be much less of a problem than it
> > is now -- time will tell.
>=20
> Yeah, leaving this one for last I think... until we see memcpy show up in=
 the
> profile.
>=20
> > > > > 3. Even if we do the above, we're still setting a big (~4k or
> > > > > more?) key into rocksdb every time we touch an object, even when
> > > > > a tiny
> >
> > See my analysis, you're looking at 8-10K for the RBD random write case
> > -- which I think everybody cares a lot about.
> >
> > > > > amount of metadata is getting changed.  This is a consequence of
> > > > > embedding all of the blobs into the onode (or bnode).  That
> > > > > seemed like a good idea early on when they were tiny (i.e., just
> > > > > an extent), but now I'm not so sure.  I see a couple of different
> options:
> > > > >
> > > > > a) Store each blob as ($onode_key+$blobid).  When we load the
> > > > > onode, load the blobs too.  They will hopefully be sequential in
> > > > > rocksdb (or definitely sequential in zs).  Probably go back to us=
ing an
> iterator.
> > > > >
> > > > > b) Go all in on the "bnode" like concept.  Assign blob ids so
> > > > > that they are unique for any given hash value.  Then store the
> > > > > blobs as $shard.$poolid.$hash.$blobid (i.e., where the bnode is
> > > > > now).  Then when clone happens there is no onode->bnode
> > > > > migration magic happening--we've already committed to storing
> > > > > blobs in separate keys.  When we load the onode, keep the
> > > > > conditional bnode loading we already have.. but when the bnode
> > > > > is loaded load up all the blobs for the hash key.  (Okay, we
> > > > > could fault in blobs individually, but that code will be more
> > > > > complicated.)
> >
> > I like this direction. I think you'll still end up demand loading the
> > blobs in order to speed up the random read case. This scheme will
> > result in some space-amplification, both in the lextent and in the
> > blob-map, it's worth a bit of study too see how bad the metadata/data
> > ratio becomes (just as a guess, $shard.$poolid.$hash.$blobid is
> > probably 16 +
> > 16 + 8 + 16 bytes in size, that's ~60 bytes of key for each Blob --
> > unless your KV store does path compression. My reading of RocksDB sst
> > file seems to indicate that it doesn't, I *believe* that ZS does [need
> > to confirm]). I'm wondering if the current notion of local vs. global
> > blobs isn't actually beneficial in that we can give local blobs
> > different names that sort with their associated oNode (which probably
> > makes the space-amp worse) which is an important optimization. We do
> > need to watch the space amp, we're going to be burning DRAM to make KV
> > accesses cheap and the amount of DRAM is proportional to the space amp.
>=20
> I got this mostly working last night... just need to sort out the clone c=
ase (and
> clean up a bunch of code).  It was a relatively painless transition to ma=
ke,
> although in its current form the blobs all belong to the bnode, and the b=
node
> if ephemeral but remains in memory until all referencing onodes go away.
> Mostly fine, except it means that odd combinations of clone could leave l=
ots
> of blobs in cache that don't get trimmed.  Will address that later.
>=20
> I'll try to finish it up this morning and get it passing tests and posted=
.
>=20
> > > > > In both these cases, a write will dirty the onode (which is back
> > > > > to being pretty small.. just xattrs and the lextent map) and 1-3
> > > > > blobs (also
> > > now small keys).
> >
> > I'm not sure the oNode is going to be that small. Looking at the RBD
> > random 4K write case, you're going to have 1K entries each of which
> > has an offset, size and a blob-id reference in them. In my current
> > oNode compression scheme this compresses to about 1 byte per entry.
> > However, this optimization relies on being able to cheaply renumber
> > the blob-ids, which is no longer possible when the blob-ids become
> > parts of a key (see above). So now you'll have a minimum of 1.5-3
> > bytes extra for each blob-id (because you can't assume that the blob-id=
s
> become "dense"
> > anymore) So you're looking at 2.5-4 bytes per entry or about 2.5-4K
> > Bytes of lextent table. Worse, because of the variable length encoding
> > you'll have to scan the entire table to deserialize it (yes, we could
> > do differential editing when we write but that's another discussion).
> > Oh and I forgot to add the 200-300 bytes of oNode and xattrs :). So
> > while this looks small compared to the current ~30K for the entire
> > thing oNode/lextent/blobmap, it's NOT a huge gain over 8-10K of the
> > compressed oNode/lextent/blobmap scheme that I published earlier.
> >
> > If we want to do better we will need to separate the lextent from the
> > oNode also. It's relatively easy to move the lextents into the KV
> > store itself (there are two obvious ways to deal with this, either use
> > the native offset/size from the lextent itself OR create 'N' buckets
> > of logical offset into which we pour entries -- both of these would
> > add somewhere between 1 and 2 KV look-ups per operation -- here is
> > where an iterator would probably help.
> >
> > Unfortunately, if you only process a portion of the lextent (because
> > you've made it into multiple keys and you don't want to load all of
> > them) you no longer can re-generate the refmap on the fly (another key
> > space optimization). The lack of refmap screws up a number of other
> > important algorithms -- for example the overlapping blob-map thing, etc=
.
> > Not sure if these are easy to rewrite or not -- too complicated to
> > think about at this hour of the evening.
>=20
> Yeah, I forgot about the extent_map and how big it gets.  I think, though=
,
> that if we can get a 4mb object with 1024 4k lextents to encode the whole
> onode and extent_map in under 4K that will be good enough.  The blob
> update that goes with it will be ~200 bytes, and benchmarks aside, the 4k
> random write 100% fragmented object is a worst case.

Yes, it's a worst-case. But it's a "worst-case-that-everybody-looks-at" vs.=
 a "worst-case-that-almost-nobody-looks-at".

I'm still concerned about having an oNode that's larger than a 4K block.


>
> Anyway, I'll get the blob separation branch working and we can go from
> there...
>=20
> sage
