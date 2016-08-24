From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: bluestore blobs REVISITED
Date: Wed, 24 Aug 2016 03:52:55 +0000
Message-ID: <BLUPR0201MB1524808F8F4763BB50517C12E8EA0@BLUPR0201MB1524.namprd02.prod.outlook.com>
References: <BLUPR0201MB15245F1EA4B70EF5761981AFE8170@BLUPR0201MB1524.namprd02.prod.outlook.com>,<alpine.DEB.2.11.1608211601350.14754@piezo.us.to>
 <2F51EC8C-D280-4DFF-8FF6-4AC97071A7D5@sandisk.com>
 <BLUPR0201MB15245054714F66FC2AB92935E8E80@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608222158190.25681@piezo.us.to>
 <BLUPR0201MB152454CA00246E35A1AE08C0E8E80@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608222249560.25681@piezo.us.to>
 <BLUPR0201MB1524C52747AF115A4C178D0FE8E80@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608231548080.25678@piezo.us.to>
 <BLUPR0201MB152475F2D6907CAD2E594FC6E8EB0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608231918460.25678@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2nam03on0046.outbound.protection.outlook.com ([104.47.42.46]:13152
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750758AbcHXEJj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 24 Aug 2016 00:09:39 -0400
In-Reply-To: <alpine.DEB.2.11.1608231918460.25678@piezo.us.to>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com]
> Sent: Tuesday, August 23, 2016 3:40 PM
> To: Allen Samuels <Allen.Samuels@sandisk.com>
> Cc: ceph-devel@vger.kernel.org
> Subject: RE: bluestore blobs REVISITED
>=20
> On Tue, 23 Aug 2016, Allen Samuels wrote:
> > > -----Original Message-----
> > > From: Sage Weil [mailto:sweil@redhat.com]
> > > Sent: Tuesday, August 23, 2016 12:03 PM
> > > To: Allen Samuels <Allen.Samuels@sandisk.com>
> > > Cc: ceph-devel@vger.kernel.org
> > > Subject: RE: bluestore blobs REVISITED
> > >
> > > I just got the onode, including the full lextent map, down to ~1500 b=
ytes.
> > > The lextent map encoding optimizations went something like this:
> > >
> > > - 1 blobid bit to indicate that this lextent starts where the last on=
e ended.
> > > (6500->5500)
> > >
> > > - 1 blobid bit to indicate offset is 0; 1 blobid bit to indicate
> > > length is same as previous lextent.  (5500->3500)
> > >
> > > - make blobid signed (1 bit) and delta encode relative to previous bl=
ob.
> > > (3500->1500).  In practice we'd get something between 1500 and 3500
> > > because blobids won't have as much temporal locality as my test
> workload.
> > > OTOH, this is really important because blobids will also get big
> > > over time (we don't (yet?) have a way to reuse blobids and/or keep
> > > them unique to a hash key, so they grow as the osd ages).
> >
> > This seems fishy to me, my mental model for the blob_id suggests that
> > it must be at least 9 bits (for a random write workload) in size (1K
> > entries randomly written lead to an average distance of 512, which
> > means
> > 10 bits to encode -- plus the other optimizations bits). Meaning that
> > you're going to have two bytes for each lextent, meaning at least 2048
> > bytes of lextent plus the remainder of the oNode. So, probably more
> > like
> > 2500 bytes.
> >
> > Am I missing something?
>=20
> Yeah, it'll be ~2 bytes in general, not 1, so closer to 2500 bytes.  I th=
is is still
> enough to get us under 4K of metadata if we make pg_stat_t encoding
> space-efficient (and possibly even without out).
>=20
> > > https://github.com/liewegas/ceph/blob/wip-bluestore-
> > > blobwise/src/os/bluestore/bluestore_types.cc#L826
> > >
> > > This makes the metadata update for a 4k write look like
> > >
> > >   1500 byte onode update
> > >   20 byte blob update
> > >   182 byte + 847(*) byte omap updates (pg log)
> > >
> > >   * pg _info key... def some room for optimization here I think!
> > >
> > > In any case, this is pretty encouraging.  I think we have a few optio=
ns:
> > >
> > > 1) keep extent map in onode and (re)encode fully each time (what I
> > > have now).  blobs live in their own keys.
> > >
> > > 2) keep extent map in onode but shard it in memory and only reencode
> > > the
> > > part(s) that get modified.  this will alleviate the cpu concerns
> > > around a more complex encoding.  no change to on-disk format.
> > >
> >
> > This will save some CPU, but the write-amp is still pretty bad unless
> > you get the entire commit to < 4K bytes on Rocks.
> >
> > > 3) join lextents and blobs (Allen's proposal) and dynamically bin
> > > based on the encoded size.
> > >
> > > 4) #3, but let shard_size=3D0 in onode (or whatever) put it inline
> > > with onode, so that simple objects avoid any additional kv op.
> >
> > Yes, I'm still of the mind that this is the best approach. I'm not
> > sure it's really that hard because most of the "special" cases can be
> > dealt with in a common brute-force way (because they don't happen too
> often).
>=20
> Yep.  I think my next task is to code this one up.  Before I start, thoug=
h, I want
> to make sure I'm doing the most reasonable thing.  Please
> review:
>=20
> Right now the blobwise branch has (unshared and) shared blobs in their ow=
n
> key.  Shared blobs only update when they are occluded and their ref_map
> changes.  If it weren't for that, we could go back to cramming them toget=
her
> in a single bnode key, but I'm I think we'll do better with them as separ=
ate
> blob keys.  This helps small reads (we don't load all blobs), hurts large=
 reads
> (we read them all from separate keys instead of all at once), and of cour=
se
> helps writes because we only update a single small blob record.
>=20
> The onode will get a extent_map_shard_size, which is measured in bytes
> and tells us how the map is chunked into keys.  If it's 0, the whole map =
will
> stay inline in the onode.  Otherwise, [0..extent_map_shard_size) is in th=
e
> first key, [extent_map_shard_size, extent_map_shard_size*2) is in the
> second, etc.

I've been thinking about this. I definitely like the '0' case where the lex=
tent and potentially the local blob are inline with the oNode. That'll cert=
ainly accelerate lots of Object and CephFS stuff. All options should implem=
ent this.

I've been thinking about the lextent sharding/binning/paging problem. Menta=
lly, I see two different ways to do it:

(1) offset-based fixed binning -- I think this is what you described, i.e.,=
 the lextent table is recast into fixed offset ranges.
(2) Dynamic binning. In this case, the ranges of lextent that are stored as=
 a set of ranges (interval-set) each entry in the interval set represents a=
 KV key and contains some arbitrary number of lextent entries within (bound=
aries are a dynamic decision)

The downside of (1) is that you're going to have logical extents that cross=
 the fixed bins (and sometimes MULTIPLE fixed bins). Handling this is just =
plain ugly in the code -- all sorts of special cases crop up for things lik=
e local-blobs that used to be unshared, now are sorta-shared (between the t=
wo 'split' lextent entries). Then there are the cases where single lextents=
 cross 2, 3, 10 shards.... UGLY UGLY UGLY.=20

A secondary problem (quite possibly a non-problem) is that the sizes of the=
 chunks of encoded lextent don't necessarily divide up particularly evenly.=
 Hot spots in objects will cause this problem.

Method (2) sounds more complicated, but I actually think it's dramatically =
LESS complicated to implement -- because we're going to brute force our way=
 around a lot of problem. First off, none of the ugly issues of splitting a=
n lextent crop up -- by definition -- since we're chunking the map on whole=
 lextent boundaries. I think from an implementation perspective you can bre=
ak this down into some relatively simple logic.

Basically from an implementation perspective, at the start of the operation=
 (read or write), you compare the incoming offset with the interval-set in =
the oNode and page in the portions of the lextent table that are required (=
required=3D> for uncompressed is just the range in the incoming operation, =
for compressed I think you need to have the lextent before and after the in=
coming operation range to make the "depth limiting" code work correctly).
For a read, you're always done at this point in time.
For a write, you'll have the problem of updating the lextent table with wha=
tever changes have been made. There are basically two sub-cases for the upd=
ate:=20
(a) updated lextent chunk (or chunks!) are sufficiently similar that you wa=
nt to maintain the current "chunking" values (more on this below). This is =
the easy case, just reserialize the chunk (or chunks) of the lextent that a=
re changed (again, because of over-fetching in the compression case the cha=
nged range might not =3D=3D the fetched range)=20
(b) You decide that re-chunking is required.  There are lots of cases of sp=
lits and joins of chunks -- more ugly code. However because the worst-case =
size of the lextent isn't really THAT large (and the frequency of re-chunki=
ng should be relatively low).  My recommendation is that we ONLY implement =
the complete re-chunking case. In other words, if you look at the chunking =
and you don't like it -- rather than spending time figuring out a bunch of =
splits and joins (sorta reminds me of FIleStore directory splits) just read=
 in the remainder of the lextent into memory and re-chunk the entire darn t=
hing. As long as the frequency of this is low it should be cheap enough (a =
max-size lextent table isn't THAT big). Keeping the frequency of chunking l=
ow should be doable by a policy with some hysteresis, i.e., something like =
if a chunk is > 'N' bytes do a splitting-rechunk, but only if it's smaller =
than N/2 bytes do a joining-rechunk.... Something like that...=20

Nothing in the odisk structures prevents future code from implementing a mo=
re sophisticated split/join chunking scheme. In fact, I recommend that the =
oNode interval_set of the lextent chunks be decorated with the serialized s=
izes of each chunk so as to make that future algorithm much easier to imple=
ment (since it'll know the sizes of all of the serialized chunks). In other=
 words, when it comes time to update the oNode/lextent, do the lextent chun=
ks FIRST and use the generated sizes of the serialized lextents to put into=
 the chunking table in the oNode. Have the sizes of all of the chunks avail=
able (without having to consult the KV store) will make the policy decision=
 about when to re-chunk fairly easy to do and allow the future optimizer to=
 make more intelligent decisions about balancing the chunk-boundaries -- th=
e extra data is pretty small and likely worth it (IMO).

I strongly believe that (2) is the way to go.

>=20
> In memory, we can pull this out of the onode_t struct and manage it in
> Onode where we can keep track of which parts of loaded, dirty, etc.
>=20
> For each map chunk, we can do the inline blob trick.  Unfortunately we ca=
n
> only do this for 'unshared' blobs where shared is now shared across
> extent_map shards and not across objects.  We can conservatively estimate
> this by just looking at the blob size w/o looking at other lextents, at l=
east.

Some thoughts here. In the PMR and Flash world, isn't it the case that blob=
s are essentially immutable once they are global?

(In the SMR world, I know they'll be modified in order to "relocate" a chun=
k -- possibly invalidating the immutable assumption).

Why NOT pull the blob up into the lextent -- as a copy? If it's immutable, =
what's the harm? Yes, the stored metadata now expands by the reference coun=
t of a cloned blob, but if you can eliminate an extra KV fetch, I'm of the =
opinion that this seems like a desireable time/space tradeoff.... Just a th=
ought :)

BTW, here's potentially a really important thing that I just realized.... F=
or a global blob, you want to make the blob_id something like #HashID.#LBA,=
 that way when you're trying to do the SMR backpointer thing, you can minim=
ize the number of bNodes you search for to find this LBA address (something=
 like that :)) -- naturally this fails for blobs with multiple pextents -- =
But we can outlaw this case in the SMR world (space is basically ALWAYS seq=
uential in the SMR world :)).

>=20
> I think we can also do a bit better than Varada's current map<> used duri=
ng
> encode/decode.  As we iterate over the map, we can store the ephemeral
> blob id *for this encoding* in the Blob (not blob_t), and use the low bit=
 of the
> blob id to indicate it is an ephemeral id vs a real one.  On decode we ca=
n size
> a vector at start and fill it with BlobRef entries as we go to avoid a dy=
namic
> map<> or other structure.  Another nice thing here is that we only have t=
o
> assign global blobids when we are stored in a blob key instead of inline =
in the
> map, which makes the blob ids smaller (with fewer significant bits).

I *think* you're describing exactly the algorithm that I published earlier =
(Varada's code should only require the map<> on encode). I used somewhat di=
fferent terminology (i.e., 'positional' encoding of the blob_id for local b=
lobs -- but I think it's the same thing). During decode blob_ids are assign=
ed sequentially, so a vector (or a deque) is what you want to use. Clever c=
oding would allow us to promote the size of the vector to the front of the =
object (This is something that I had considered regularizing for the enc_de=
c framework, i.e., a value computed at the end of an encode that's made ava=
ilable earlier in the byte-stream before the corresponding decode (sorry, n=
o varint :) )

>=20
> The Bnode then goes from a map of all blobs for the hash to a map of only
> shared (between shards or objects) for the hash--i.e., those blobs that h=
ave
> a blobid.  I think to make this work we then also need to change the in-
> memory lextent map from map<uint64_t,bluestore_lextent_t> to
> map<uint64_t,Lextent> so that we can handle the local vs remote pointer
> cases and for the local ones keep store the BlobRef right there.  This'll=
 be
> marginally more complex to code (no 1:1 mapping of in-memory to encoded
> structures) but it should be faster (one less in-memory map lookup).
>=20
> Anyway, that's the my current plan. Any thoughts before I start?
> sage
