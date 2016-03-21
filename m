From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: Adding compression support for bluestore.
Date: Mon, 21 Mar 2016 15:14:30 +0000
Message-ID: <CY1PR0201MB189754639EB3F2E219CF0E6EE88F0@CY1PR0201MB1897.namprd02.prod.outlook.com>
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
 <56F00022.9020307@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0083.outbound.protection.outlook.com ([157.56.110.83]:45504
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755999AbcCUPOd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Mar 2016 11:14:33 -0400
In-Reply-To: <56F00022.9020307@mirantis.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>, Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: Igor Fedotov [mailto:ifedotov@mirantis.com]
> Sent: Monday, March 21, 2016 7:08 AM
> To: Allen Samuels <Allen.Samuels@sandisk.com>; Sage Weil
> <sage@newdream.net>
> Cc: ceph-devel <ceph-devel@vger.kernel.org>
> Subject: Re: Adding compression support for bluestore.
>=20
> Allen,
>=20
> please find my comment inline
>=20
> On 19.03.2016 6:14, Allen Samuels wrote:
> > If we're going to both allow compression and delayed overwrite we s=
imply
> have to handle the case where new data actually overlaps with previou=
s data
> -- recursively. If I understand the current code, it handles exactly =
one layer of
> overlay which is always stored in KV store. We need to generalize thi=
s data
> structure. I'm going to outline a proposal, which If I get wrong, I b=
eg
> forgiveness -- I'm not as familiar with this code as I would like, es=
pecially the
> ref-counted shared extent stuff. But I'm going to blindly dive in and=
 assume
> that Sage will correct me when I go off the tracks -- and therefore e=
nd up
> learning how all of this stuff REALLY works.
> >
> > I propose that the current bluestore_extent_t and bluestore_overlay=
_t  be
> essentially unified into a single structure with a typemark to distin=
guish
> between being in KV store or in raw block storage. Here's an example:=
 (for
> this discussion, BLOCK_SIZE is 4K and is the minimum physical I/O siz=
e).
> That's a good idea to have uniform structure.
> However it's not cleat to me if you are suggesting to have single con=
tainer for
> both locations. I think you aren't.
> In this case  most probably you don't need to have 'location' inside =
the
> structure. It's rather an uncommon case when instances from different
> locations are mixed and processed togather. And code that deals with =
it
> usually is aware of structure instance's origin. Even if that's not t=
rue
> - additional external parameter can be provided.
> > Struct bluestore_extent_t {
> >     Uint64_t logical_size;			// size of data before any
> compression. MUST BE AN INTEGER MULTIPLE of BLOCK_SIZE (and !=3D 0)
> >     Uint64_t physical_size;                              // size of=
 data on physical media
> (yes, this is unneeded when location =3D=3D KV, the serialize/deseria=
lize could
> compress this out --  but this is an unneeded optimization
> >     Uint64_t location:1;                                    // valu=
es (in ENUM form) are "KV"
> and "BLOCK"
> >     Uint64_t compression_alg:4;                  // compression alg=
orithm...
> >     Uint64_t otherflags:xx;                             // round it=
 out.
> >     Uint64_t media_address;                        // forms Key whe=
n location =3D=3D KV
> block address when location =3D=3D BLOCK
> >     Vector<uint32_t> checksums;              // Media checksums. Se=
e
> commentary on this below.
> > };
> >
> > This allows any amount of compressed or uncompressed data to be
> identified in either a KV key or a block store.
> >
> > W.r.t. the vector of checksums.  There is lots of flexibility here =
which
> probably isn't worth dealing with. The simplest solution is to always=
 generate
> a checksum for each BLOCK_SIZE-sized I/O independent of whether the d=
ata
> is compressed or not and independent of any physical I/O size. This m=
eans
> that data integrity on a read is checked AFTER decompression. This ha=
s a
> side-effect of requiring the decompressor to be "safe" in the presenc=
e of
> incorrect/corrupted data [not all decompressors have this property].
> Alternatively for compressed data we use a single checksum (regardles=
s of
> size) that covers only the compressed data. This allows the checksum =
to be
> checked before decompression. The second scheme has somewhat better
> performance as it checksums data AFTER compression (i.e., less data).
> Another potentially important flag here is to suppress bluestore chec=
ksum
> generation and checking -- some compression/decompression algorithms
> already do their own data integrity checks and it's silly to pay for =
that twice.
> Also, for data where a low BER is tolerable you might entertain the n=
otion of
> skipping checksum generation. A null vector of checksums would certai=
nly
> describe these situations (a flag could be added too).
> Sounds good in general. But I'd prefer to start checksum implementati=
on
> discussions from the goals and use cases - for what purposes we are p=
lanning
> to use them? What procedures benefit from that use? And how they do
> that?
> May be we should have a separate topic for that?

Making a separate discussion thread is a good idea. I was simply pointi=
ng out some of the interactions between checksums and compression. I ag=
ree that having a goals and use cases discussion is the best place to s=
tart.

>=20
> > Once this unification is complete, you no longer need both "block_m=
ap"
> and "overlap_map" in onode_t. you just have an extent map. But in ord=
er to
> handle the lazy-recovery overlap schemes described above you must
> provide some kind of "priority" information so that when you have two
> extents that overlap you know which has the live data and which has t=
he
> dead data. This is very easy to express in the onode_t data structure=
 simply
> by making the extent map be an array of maps. The indexes in the arra=
y
> implicitly provide the priority ordering that you need. Now, when an =
write
> operation that generates the lazy-recovery scheme happens it just exp=
ands
> the size of the array and inserts the new extent there. Here's an exa=
mple.
> >
> > First we write blocks 0..10. This leaves the map[0] with one extent=
(0..10).
> > Now we lazy-overwrite blocks 2 and 3. We create map[1] and insert
> extent(2..3). But map[0] still contains extent(0..10).
> > We can even lazy-overwrite block 3. We create map[2] and insert
> > extent(3). Map[1] still has extent(2..3) and Map[0] still has exten=
t(0..10);
> Now we write block 50. That extent could technically go into any inde=
x of the
> map.
> >
> > Yes, searching this data structure for the correct information IS m=
ore
> > complicated than the current simple maps. But it's not hopelessly
> > complicated and ought to be something that a good unit test can pre=
tty
> > much exhaustively cover with a little bit of thought. [I've skipped
> > over thinking about refcounted extents as I don't fully understand
> > those yet -- but they shouldn't be a fundamental problem]
> That's an interesting proposal but I can see following caveats here (=
I beg
> pardon I  misunderstood something):
> 1) Potentially uncontrolled extent map growth when extensive (over)wr=
iting
> takes place.

Yes, a na=EFve insertion policy could lead to uncontrolled growth, but =
I don't think this needs to be the case. I assume that when you add an =
"extent", you won't increase the size of the array unnecessarily, i.e.,=
 if the new extent doesn't overlap an existing extent then there's no r=
eason to increase the size of the map array -- actually you want to ins=
ert the new extent at the <smallest> array index that doesn't overlap, =
only increasing the array size when that's not possible. I'm not 100% c=
ertain of the worst case, but I believe that it's limited to the ratio =
between the largest extent and the smallest extent. (i.e., if we assume=
 writes are no larger than -- say -- 1MB and the smallest are 4K, then =
I think the max depth of the array is 1M/4K =3D> 2^8, 256. Which is ugl=
y but not awful -- since this is probably a contrived case. This might =
be a reason to limit the largest extent size to something a bit smaller=
 (say 256K)...

> 2) Read/Lookup algorithmic complexity. To find valid block (or detect
> overwrite) one should sequentially enumerate the full array. Given 1)=
 that
> might be very ineffective.

Only requires one log2 lookup for each index of the array.

> 3) It's not dealing with unaligned overwrites. What happens when some
> block is partially overwritten?

I'm not sure I understand what cases you're referring to. Can you give =
an example?

>=20
> I'm going to publish a bit different approach that hopefully handles =
these
> issues promptly. Stay tuned..

Great! Looking forward to seeing it.=20

> >
> > This data structure fully enables any of the combinations of compre=
ssion
> and overwriting that we've discussed. In particular it allows free in=
termixing
> of compressed and non-compressed data and fully supports any kind of
> delay-merging of compressed data (lazy space recovery) with data bein=
g
> written to either KV store or block store.
> >
> > BTW, I'm not sure how the current in-memory WAL queue is recovered
> after a crash/restart. Presumably there's an entry in the KV store to=
 denote
> the presence of the WAL queue entry. That logical may require modific=
ation
> for cases where we are delaying the merge but the overlay data is act=
ually in
> block storage. This might require some minor re-tweaking with this pr=
oposal.
> >
> > A question for Sage:
> >
> > Does the current WAL logic attempt to induce delay for the merging?=
 It
> seems like there are potentially lots of situations where multiple ov=
erwrite
> are happening to the same object but are dispersed in time (slightly)=
=2E Do we
> attempt to merge this in the WAL queue?
> >
> >
> > Allen Samuels
> > Software Architect, Fellow, Systems and Software Solutions
> >
> > 2880 Junction Avenue, San Jose, CA 95134
> > T: +1 408 801 7030| M: +1 408 780 6416 allen.samuels@SanDisk.com
> >
> >> -----Original Message-----
> >> From: Igor Fedotov [mailto:ifedotov@mirantis.com]
> >> Sent: Friday, March 18, 2016 10:54 AM
> >> To: Sage Weil <sage@newdream.net>
> >> Cc: Allen Samuels <Allen.Samuels@sandisk.com>; ceph-devel <ceph-
> >> devel@vger.kernel.org>
> >> Subject: Re: Adding compression support for bluestore.
> >>
> >>
> >>
> >> On 17.03.2016 18:33, Sage Weil wrote:
> >>> I'd say "maybe". It's easy to say we should focus on read
> >>> performance now, but as soon as we have "support for compression"
> >>> everybody is going to want to turn it on on all of their clusters=
 to
> >>> spend less money on hard disks. That will definitely include RBD
> >>> users, where write latency is very important. I'm hesitant to tak=
e
> >>> an architectural direction that locks us in. With something layer=
ed
> >>> over BlueStore I think we're forced to do it all in the initial
> >>> phase; with the monolithic approach that integrates it into
> >>> BlueStore's write path we have the option to do either one--perha=
ps
> >>> based on the particular request or hints or whatever.
> >>>>>>> What do you think?
> >>>>>>>
> >>>>>>> It would be nice to choose a simpler strategy for the first p=
ass
> >>>>>>> that handles a subset of write patterns (i.e., sequential
> >>>>>>> writes, possibly
> >>>>>>> unaligned) that is still a step in the direction of the more
> >>>>>>> robust strategy we expect to implement after that.
> >>>>>>>
> >>>>>> I'd probably agree but.... I don't see a good way how one can
> >>>>>> implement compression for specific write patterns only.
> >>>>>> We need to either ensure that these patterns are used exclusiv=
ely
> >>>>>> ( append only / sequential only flags? ) or provide some means=
 to
> >>>>>> fall back to regular mode when inappropriate write occurs.
> >>>>>> Don't think both are good and/or easy enough.
> >>>>> Well, if we simply don't implement a garbage collector, then fo=
r
> >>>>> sequential+aligned writes we don't end up with stuff that needs
> >>>>> sequential+garbage
> >>>>> collection.  Even the sequential case might be doable if we mak=
e
> >>>>> it possible to fill the extent with a sequence of compressed
> >>>>> strings (as long as we haven't reached the compressed length, t=
ry
> >>>>> to restart the decompression stream).
> >>>> It's still unclear to me if such specific patterns should be
> >>>> exclusively applied to the object. E.g. by using specific object
> >>>> creation
> >> mode mode.
> >>>> Or we should detect them automatically and be able to fall back =
to
> >>>> regular write ( i.e. disable compression )  when write doesn't
> >>>> conform to the supported pattern.
> >>> I think initially supporting only the append workload is a simple
> >>> check for whether the offset =3D=3D the object size (and maybe wh=
ether
> >>> it is aligned).  No persistent flags or hints needed there.
> >> Well, but issues appear immediately after some overwrite request
> >> takes place.
> >> How to handle overwrites? To do compression for the overwritten or=
 not?
> >> If not - we need some way to be able to merge compressed and
> >> uncompressed blocks. And so on and so forth IMO it's hard (or even
> >> impossible) to apply compression for specific write patterns only
> >> unless you prohibit other ones.
> >> We can support a subset of compression policies ( i.e. ways how we
> >> resolve compression issues: RMW at init phase, lazy overwrite, WAL
> >> use, etc ) but not a subset of write patterns.
> >>
> >>>> And I'm not following the idea about "a sequence of compressed
> >>>> strings". Could you please elaborate?
> >>> Let's say we have 32KB compressed_blocks, and the client is doing
> >>> 1000 byte appends.  We will allocate a 32 chunk on disk, and only
> >>> fill it with say ~500 bytes of compressed data.  When the next wr=
ite
> >>> comes around, we could compress it too and append it to the block
> >>> without decompressing the previous string.
> >>>
> >>> By string I mean that each compression cycle looks something like
> >>>
> >>>    start(...)
> >>>    while (more data)
> >>>      compress_some_stuff(...)
> >>>    finish(...)
> >>>
> >>> i.e., there's a header and maybe a footer in the compressed strin=
g.
> >>> If we are decompressing and the decompressor says "done" but ther=
e
> >>> is more data in our compressed block, we could repeat the process
> >>> until we get to the end of the compressed data.
> >> Got it, thanks for clarification
> >>> But it might not matter or be worth it.  If the compressed blocks
> >>> are smallish then decompressing, appending, and recompressing isn=
't
> >>> going to be that expensive anyway.  I'm mostly worried about smal=
l
> >>> appends, e.g. by rbd mirroring (imaging 4 KB writes + some metada=
ta)
> >>> or the MDS
> >> journal.
> >> That's mainly about small appends not small writes, right?
> >>
> >> At this point I agree with Allen that we need variable policies to
> >> handle compression. Most probably we wouldn't be able to create
> >> single one that fits perfect for any write pattern.
> >> The only concern about that is the complexity of such a task...
> >>> sage
> >> Thanks,
> >> Igor
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
