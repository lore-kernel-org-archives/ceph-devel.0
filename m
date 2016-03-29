From: Sage Weil <sage@newdream.net>
Subject: Re: Adding compression support for bluestore.
Date: Tue, 29 Mar 2016 16:19:39 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1603291602330.6473@cpach.fuggernut.com>
References: <56C1FCF3.4030505@mirantis.com> <CACJqLyb=X1i7tsYeKOEJRdJEEMBGvgW817eY5Bo9YBXDszUDmw@mail.gmail.com> <56C3BAA3.3070804@mirantis.com> <CY1PR0201MB1897E7F1DE04B5E4577B16EDE8A00@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1602220718380.13988@cpach.fuggernut.com> <56CDF40C.9060405@mirantis.com> <CY1PR0201MB1897BC7052AD6F7FB01DCAB4E8A50@CY1PR0201MB1897.namprd02.prod.outlook.com> <56D08E30.20308@mirantis.com> <alpine.DEB.2.11.1603151243030.32086@cpach.fuggernut.com>
 <56E9A727.1030400@mirantis.com> <alpine.DEB.2.11.1603161515360.14377@cpach.fuggernut.com> <56EACAAD.90002@mirantis.com> <alpine.DEB.2.11.1603171123090.14377@cpach.fuggernut.com> <56EC248E.3060502@mirantis.com> <CY1PR0201MB1897035E6E09FE518ACC2DDCE88D0@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <56F013FB.4040002@mirantis.com> <alpine.DEB.2.11.1603211141560.23875@cpach.fuggernut.com> <56F3E157.2090004@mirantis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33222 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932470AbcC2UTu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Mar 2016 16:19:50 -0400
In-Reply-To: <56F3E157.2090004@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 24 Mar 2016, Igor Fedotov wrote:
> Sage, Allen et. al.
> 
> Please find some follow-up on our discussion below.
> 
> Your past and future comments are highly appreciated.
> 
> WRITE/COMPRESSION POLICY and INTERNAL BLUESTORE STRUCTURES OVERVIEW.
> 
> Used terminology:
> Extent - basic allocation unit. Variable in size, maximum size is limited by
> lblock length (see below), alignment: min_alloc_unit param (configurable,
> expected range: 4-64 Kb .
> Logical Block (lblock) - standalone traceable data unit. Min size unspecified.
> Alignment unspecified. Max size limited by max_logical_unit param
> (configurable, expected range: 128-512 Kb)
> 
> Compression to be applied on per-extent basis.
> Multiple lblocks can refer specific region within a single extent.

This (and the what's below) sound right to me.  My main concern is around 
naming.  I don't much like "extent" vs "lblock" (which is which?).  Maybe 
extent and extent_ref?

Also, I don't think we need the size limits you mention above.  When 
compression is enabled, we'll limit the size of the disk extents by 
policy, but the structures themselves needn't enforce that.  Similarly, I 
don't think the lblocks (extent refs?  logical extents?) need a max size 
either.

Anyway, right now we have bluestore_extent_t.  I'd suggest maybe

	bluestore_pextent_t and bluestore_lextent_t
or
	bluestore_extent_t and bluestore_extent_ref_t

?

> POTENTIAL COMPRESSION APPLICATION POLICIES
> 
> 1) Read/Merge/Write at initial commit phase. (RMW)
> General approach:
> New write request triggers partially overlapped lblock(s)
> reading/decompression followed by their merge into a set of new lblocks. Then
> compression is (optionally) applied. Resulting lblocks overwrite existing
> ones.
> For non-overlapping/fully overlapped lblocks read/merge steps are simply
> bypassed.
> - Read, merge and final compression take place prior to write commit ack that
> can impact write operation latency.
> 
> 2) Deferred RMW for partial overlaps. (DRMW)
> General approach:
> Non-overlapping/fully overlapped lblocks handled similar to simple RMW.
> For partially overlapped lblocks one should use Write-Ahead Log to defer RMW
> procedure until write commit ack return.
> - Write operation latency can still be high in some cases (
> non-overlapped/fully overlapped writes).
> - WAL can grow significantly.
> 
> 3) Writing new lblocks over new extents. (LBlock Bedding?)
> General approach:
> Write request creates new lblock(s) that use freshly allocated extents.
> Overlapped regions within existing lblocks are occluded.
> Previously existing extents are preserved for some time (or while being used)
> depending on the cleanup policy.
> Compression to be performed before write commit ack return.
> - Write operation latency is still affected by the compression.
> - Store space usage is usually higher.
> 
> 4) Background compression (BCOMP)
> General approach:
> Write request to be handled using any of the above policies (or their
> combination) with no compression applied. Stored extents are compressed by
> some background process independently from the client write flow.
> Merging new uncompressed lblock with already compressed one can be tricky
> here.
> + Write operation latency isn't affected by the compression.
> - Double disk write occurs
> 
> To provide better user experience above-mentioned policies can be used
> together depending on the write pattern.
> 
> INTERNAL DATA STRUCTURES TO TRACK OBJECT CONTENT.
> 
> To track object content we need to introduce following 2 collections:
> 
> 1) LBlock map:
> That's a logical offset mapping to a region within an extent:
> LOFFS -> {
>   EXTENT_REF       - reference to an underlying extent, e.g. pointer for
> in-memory representation or extent ID for "on-disk" one
>   X_OFFS, X_LEN,   - region descriptor within an extent: relative offset and
> region length
>   LFLAGS           - some associated flags for the lblock. Any usage???
> }
> 
> 2) Extent collection:
> Each entry describes an allocation unit within storage space. Compression to
> be applied on per-extent basis thus extent's logical volume can be greater
> than it's physical size.
> 
> {
>   P_OFFS            - physical block address
>   SIZE              - actual stored data length
>   EFLAGS            - flags associated with the extent
>   COMPRESSION_ALG   - An applied compression algorithm id if any
>   CHECKSUM(s)       - Pre-/Post compression checksums. Use cases TBD.
>   REFCOUNT          - Number of references to this entry
> }

Yep (modulo naming).

> The possible container for this collection can be a mapping: id -> extent. It
> looks like such mapping is required during on-disk to in-memory representation
> transform as smart pointer seems to be enough for in-memory use.

Given the structures are small I'm not sure smart pointers are worth it.. 
Maybe just a simple vector (or maybe flat_map) for the extents?  Lookup 
will be fast.

> SAMPLE MAP TRANSFORMATION FOR LBLOCK BEDDING POLICY ( all values in Kb )
> 
> Config parameters:
> min_alloc_unit = 4
> max_logical_unit = 64
> 
> --------------------------------------------------------
> ****** Step 0 :
> ->Write(0, 50), no compression
> ->Write(100, 60), no compression
> 
> Resulting maps:
> LBLOCK map ( OFFS: { EXT_REF, X_OFFS, X_LEN}  ):
> 0:   {EO1, 0, 50}
> 100: {EO2, 0, 60}
> 
> EXTENT map ( ID: { P_OFFS, SIZE, ALG, REFCOUNT}  ):
> EO1: { POFFS_1, 50, NONE, 1}   //totally allocated 52 Kb
> EO2: { POFFS_2, 60, NONE, 1}   //totally allocated 60 Kb
> 
> 
> Where POFFS_1, POFFS_2 - physical addresses for allocated extents.
> 
> ****** Step 1
> ->Write(25, 100), compressed
> 
> Resulting maps:
> LBLOCK map ( OFFS: { EXT_REF, X_OFFS, X_LEN}  ):
> 0:     {EO1, 0, 25}
> 25:    {EO3, 0, 64}   //compressed into 20K
> 79:    {EO4, 0, 36}   //compressed into 15K
> 125:   {EO2, 25, 35}
> 
> EXTENT map ( ID: { P_OFFS, SIZE, ALG, REFCOUNT}  ):
> EO1: { POFFS_1, 50, NONE, 1}   //totally allocated 52 Kb
> EO2: { POFFS_2, 60, NONE, 1}   //totally allocated 60 Kb
> EO3: { POFFS_3, 20, ZLIB, 1}   //totally allocated 24 Kb
> EO4: { POFFS_4, 15, ZLIB, 1}   //totally allocated 16 Kb
> 
> As one can see new entries at offset 25 & 79  have appeared and previous
> entries have been altered (including the map key (100->125) for the last
> entry).
> No physical extents reallocation took place though - just new ones (EO3 & EO4)
> have been allocated.
> Please note that client accessible data for block EO2 are actually stored at
> P_OFFS_2 + X_OFF and have 35K only despite the fact that extent has 60K total.
> The same for block EO1 - valid data length is 25K only.
> Extent EO3 actually stores 20K of compressed data corresponding to 64K raw
> one.
> Extent EO4 actually stores 15K of compressed data corresponding to 36K raw
> one.
> Single 100K write has been splitted into 2 lblocks to address max_logical_unit
> constraint

Hmm, as a matter of policy, we might want to force alignment of the 
extents to max_logical_unit.  I think that might reduce fragmentation 
over time.

> ****** Step 2
> ->Write(70, 65), no compression
> 
> LBLOCK map ( OFFS: { EXT_REF, X_OFFS, X_LEN}  ):
> 0:     {EO1, 0, 25}
> 25:    {EO3, 0, 45}
> 70:    {EO5, 0, 65}
> -125:   {EO4, 36, 0} -> to be removed as it's totally overwritten ( see X_LEN
> = 0 )
> 135:   {EO2, 35, 25}
> 
> EXTENT map ( ID: { P_OFFS, SIZE, ALG, REFCOUNT}  ):
> EO1: { POFFS_1, 50, NONE, 1}   //totally allocated 52 Kb
> EO2: { POFFS_2, 60, NONE, 1}   //totally allocated 60 Kb
> EO3: { POFFS_3, 20, ZLIB, 1}   //totally allocated 24 Kb
> -EO4: { POFFS_4, 15, ZLIB, 0}  //totally allocated 16 Kb, can be released as
> refcount = 0
> EO5: { POFFS_5, 65, NONE, 1}   //totally allocated 68 Kb
> 
> Entry at at offset 25 entry has been altered and entry at offset 125 to be
> removed. The latter can be done both immediately on map alteration and by some
> background cleanup procedure.
> 
> 
> ****** Step 3
> ->Write(100, 60), compressed to 30K
> 
> LBLOCK map ( OFFS: { EXT_REF, X_OFFS, X_LEN}  ):
> 0:     {EO1, 0, 25}
> 25:    {EO3, 0, 45}
> 70:    {EO5, 0, 65}
> 100:   {EO6, 0, 60}
> -160:   {EO2, 60, 0} -> to be removed as it's totally overwritten ( see X_LEN
> = 0 )
> 
> EXTENT map ( ID: { P_OFFS, SIZE, ALG, REFCOUNT}  ):
> EO1: { POFFS_1, 50, NONE, 1}   //totally allocated 52 Kb
> EO2: { POFFS_2, 60, NONE, 1}   //totally allocated 60 Kb
> EO3: { POFFS_3, 20, ZLIB, 1}   //totally allocated 24 Kb
> -EO5: { POFFS_5, 65, NONE, 0}  //totally allocated 68 Kb, can be released as
> refcount = 0
> EO6: { POFFS_6, 30, ZLIB, 1}   //totally allocated 32 Kb
> 
> Entry at offset 100 has been altered and entry at offset 160 to be removed.
> 
> ****** Step 4
> ->Write(0, 25), no compression
> 
> LBLOCK map ( OFFS: { EXT_REF, X_OFFS, X_LEN}  ):
> 0:     {EO7, 0, 25}
> -25:     {EO1, 25, 0}   -> to be removed
> 25:    {EO3, 0, 45}
> 70:    {EO5, 0, 65}
> 100:   {EO6, 0, 60}
> -160:   {EO2, 60, 0} -> to be removed as it's totally overwritten ( see X_LEN
> = 0 )
> 
> EXTENT map ( ID: { P_OFFS, SIZE, ALG, REFCOUNT}  ):
> -EO1: { POFFS_1, 50, NONE, 1}   //totally allocated 52 Kb, can be released as
> refcount = 0
> EO2: { POFFS_2, 60, NONE, 1}   //totally allocated 60 Kb
> EO3: { POFFS_3, 20, ZLIB, 1}   //totally allocated 24 Kb
> EO6: { POFFS_6, 30, ZLIB, 1}   //totally allocated 32 Kb
> EO7: { POFFS_7, 25, None, 1}   //totally allocated 38 Kb
> 
> Entry at offset 0 has been overwritten and to be removed.
> 
> IMPLMENTATION ROADMAP

.5) Code and review the new data structures.  Include fields and flags for 
both compressoin and checksums.
 
> 1) Refactor current Bluestore implementation to introduce the suggested
> twin-structure design.
> This will support raw data READ/WRITE without compression. Major policy to
> implement is lblock bedding.
> As an additional option DRMW to be implemented to provide a solution equal to
> the current implementation. This might be useful for performance comparison.
>
> 2) Add basic compression support using lblock bedding policy.
> This will lack most of management/statistics features too.
> 
> 3) Add compression management/statistics. Design to be discussed.
> 
> 4) Add check sum support. Goals and design to be discussed.

This sounds good to me!

FWIW, I think #1 is going to be the hard part.  Once we establish that the 
disk extents are somewhat immutable (because they are compressed or there 
is a coarse checksum or whatever) we'll have to restructure _do_write, 
_do_zero, _do_truncate, and _do_wal_op.  Those four are dicey.

sage



> 5) Add RMW/DRMW policies [OPTIONAL]
> 
> 6) Add background task support for compression/defragmentation/cleanup.
> 
> 
> Thanks,
> Igor.
> 
> On 21.03.2016 18:50, Sage Weil wrote:
> > On Mon, 21 Mar 2016, Igor Fedotov wrote:
> > > On 19.03.2016 6:14, Allen Samuels wrote:
> > > > If we're going to both allow compression and delayed overwrite we simply
> > > > have to handle the case where new data actually overlaps with previous
> > > > data
> > > > -- recursively. If I understand the current code, it handles exactly
> > > > one
> > > > layer of overlay which is always stored in KV store. We need to
> > > > generalize
> > > > this data structure. I'm going to outline a proposal, which If I get
> > > > wrong,
> > > > I beg forgiveness -- I'm not as familiar with this code as I would like,
> > > > especially the ref-counted shared extent stuff. But I'm going to blindly
> > > > dive in and assume that Sage will correct me when I go off the tracks --
> > > > and
> > > > therefore end up learning how all of this stuff REALLY works.
> > > > 
> > > > I propose that the current bluestore_extent_t and bluestore_overlay_t
> > > > be
> > > > essentially unified into a single structure with a typemark to
> > > > distinguish
> > > > between being in KV store or in raw block storage. Here's an example:
> > > > (for
> > > > this discussion, BLOCK_SIZE is 4K and is the minimum physical I/O size).
> > > > 
> > > > Struct bluestore_extent_t {
> > > >      Uint64_t logical_size;			// size of data before
> > > > any
> > > > compression. MUST BE AN INTEGER MULTIPLE of BLOCK_SIZE (and != 0)
> > > >      Uint64_t physical_size;                              // size of
> > > > data on
> > > > physical media (yes, this is unneeded when location == KV, the
> > > > serialize/deserialize could compress this out --  but this is an
> > > > unneeded
> > > > optimization
> > > >      Uint64_t location:1;                                    // values
> > > > (in
> > > > ENUM form) are "KV" and "BLOCK"
> > > >      Uint64_t compression_alg:4;                  // compression
> > > > algorithm...
> > > >      Uint64_t otherflags:xx;                             // round it
> > > > out.
> > > >      Uint64_t media_address;                        // forms Key when
> > > > location == KV block address when location == BLOCK
> > > >      Vector<uint32_t> checksums;              // Media checksums. See
> > > > commentary on this below.
> > > > };
> > > > 
> > > > This allows any amount of compressed or uncompressed data to be
> > > > identified
> > > > in either a KV key or a block store.
> > > > 
> > > As promised please find a competing proposal for extent map structure. It
> > > can
> > > be used for handling unaligned overlapping writes of both
> > > compressed/uncompressed data. It seems it's applicable for any compression
> > > policy but my primary intention was to allow overwrites that use totally
> > > different extents without the touch to the existing(overwritten) ones.
> > > I.e.
> > > that's what Sage explained this way some time ago:
> > > 
> > > "b) we could just leave the overwritten extents alone and structure the
> > > block_map so that they are occluded.  This will 'leak' space for some
> > > write patterns, but that might be okay given that we can come back later
> > > and clean it up, or refine our strategy to be smarter."
> > > 
> > > Nevertheless the corresponding infrastructure seems to be applicable for
> > > different use cases too.
> > > 
> > > At first let's consider simple raw data overwrite case. No compression,
> > > checksums, flags at this point for the sake of simplicity.
> > > Block map entry to be defined as follows:
> > > OFFS:  < EXT_OFFS, EXT_LEN, X_OFFS, X_LEN>
> > > where
> > > EXT_OFFS, EXT_LEN - allocated extent offset and size, AKA physical address
> > > and
> > > size.
> > > X_OFFS - relative offset within the block where valid (not overwritten)
> > > data
> > > starts. Full data offset = OFFS + X_OFFS
> > > X_LEN - valid data size.
> > > Invariant: Block length == X_OFFS + X_LEN
> > > 
> > > Let's consider sample block map transform:
> > > --------------------------------------------------------
> > > ****** Step 0 (two incoming writes of 50 Kb at offset 0 and 100K):
> > > ->Write(0,50)
> > > ->Write(100, 50)
> > > 
> > > Resulting block map ( OFFS: {EXT_OFFS, EXT_LEN, X_OFFS, X_LEN}  ):
> > > 0:      {EO1, 50, 0, 50}
> > > 100: {EO2, 50, 0, 50}
> > > 
> > > Where EO1, EO2 - physical addresses for allocated extents.
> > > Two new entries have been inserted.
> > > 
> > > ****** Step 1 ( overwrite that partially overlaps both existing blocks ):
> > > ->Write(25,100)
> > > 
> > > Resulting block map ( OFFS: {EXT_OFFS, EXT_LEN, X_OFFS, X_LEN}  ):
> > > 0:      {EO1, 50, 0, 25}
> > > 25:    {EO3, 100, 0, 100}
> > > 125: {EO2, 50, 25, 25}
> > > 
> > > As one can see new entry at offset 25 has appeared and previous entries
> > > have
> > > been altered (including the map key (100->125) for the last entry). No
> > > physical extents reallocation took place though - just a new one at E03
> > > has
> > > been allocated.
> > > Please note that client accessible data for block EO2 are actually stored
> > > at
> > > EO2 + X_OFF(=25) and have 25K only despite the fact that extent has 50K
> > > total.
> > > The same for block EO1 - valid data length = 25K only.
> > > 
> > > 
> > > ****** Step 2 ( overwrite that partially overlaps existing blocks once
> > > again):
> > > ->Write(70, 65)
> > > 
> > > Resulting block map ( OFFS: {EXT_OFFS, EXT_LEN, X_OFFS, X_LEN}  ):
> > > 0:      {EO1, 50, 0, 25}
> > > 25:    {EO3, 100, 0, 45}
> > > 70:    {EO4, 65, 0, 65}
> > > 135: {EO2, 50, 35, 15}
> > > 
> > > Yet another new entry. Overlapped block entries at 25 & 125 were altered.
> > > 
> > > ****** Step 3 ( overwrite that partially overlaps one block and totally
> > > overwrite the last one):
> > > ->Write(100, 60)
> > > 
> > > Resulting block map ( OFFS: {EXT_OFFS, EXT_LEN, X_OFFS, X_LEN}  ):
> > > 0:      {EO1, 50, 0, 25}
> > > 25:    {EO3, 100, 0, 45}
> > > 70:    {EO4, 65, 0, 35}
> > > 100: {EO5, 60, 0, 60}
> > > -140: {EO2, 50, 50, 0}  -> to be removed as it's totally overwritten ( see
> > > X_LEN = 0 )
> > > 
> > > Entry for EO4 have been altered and entry EO2 to be removed. The latter
> > > can be
> > > done both immediately on map alteration and by some background cleanup
> > > procedure.
> > > 
> > > ****** Step 4 ( overwrite that totally overlap the first block):
> > > ->Write(0, 25)
> > > 
> > > Resulting block map ( OFFS: {EXT_OFFS, EXT_LEN, X_OFFS, X_LEN}  ):
> > > 0:      {EO6, 25, 0, 25}
> > > - 0:      {EO1, 50, 25, 0}  -> to be removed
> > > 25:    {EO3, 100, 0, 45}
> > > 70:    {EO4, 65, 0, 35}
> > > 100: {EO5, 60, 0, 60}
> > > 
> > > Entry for EO1 has been overwritten and to be removed.
> > > 
> > > --------------------------------------------------------------------------------------
> > > 
> > > Extending this block map for compression is trivial - we need to introduce
> > > compression algorithm flag to the map. And vary EXT_LEN (and actual
> > > physical
> > > allocation) depending on the actual compression ratio.
> > > E.g. with ratio=3 (60K reduced to 20K) the record from the last step turn
> > > into
> > > :
> > > 100: {EO5, 20, 0, 60}
> > > 
> > > Other compression aspects handled by the corresponding policies ( e.g.
> > > when
> > > perform the compression ( immediately, lazily or totally in background )
> > > or
> > > how to merge neighboring compressed blocks ) probably don't impact the
> > > structure of the map entry - they just shuffle the entries.
> > This is much simpler!  There is one case we need to address that I don't
> > see above, though.  Consider,
> > 
> > - write 0~1048576, and compress it
> > - write 16384~4096
> > 
> > When we split the large extent into two pieces, the resulting extent map,
> > as per above, would be something like
> > 
> > 0:      {EO1, 1048576, 0, 4096, zlib}
> > 4096:   {E02, 16384, 0, 4096, uncompressed}
> > 16384:	{E01, 1048576, 20480, 1028096, zlib}
> > 
> > ...which is fine, except that it's the *same* compressed extent, which
> > means the code that decides that the physical extent is no longer
> > referenced and can be released needs to ensure that no other extents in
> > the map reference it.  I think that's an O(n) pass across the map when
> > releasing.
> > 
> > Also, if we add in checksums, then we'd be duplicating them in the two
> > instances that reference the raw extent.
> > 
> > I wonder if it makes sense to break this into two structures.. one that
> > lists the raw extents, and another that maps them into the logical space.
> > So that there is one record for {E01, 1048576, zlib, checksums}, and then
> > the block map is more like
> > 
> > 0:      {E0, 0, 4096}
> > 4096:   {E1, 0, 4096}
> > 16384:	{E0, 20480, 1028096}
> > 
> > and
> > 
> > 0: E01, 1048576, 0, 4096, zlib, checksums
> > 1: E02, 16384, 0, 4096, uncompressed, checksums
> > 
> > ?
> > 
> > sage
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
