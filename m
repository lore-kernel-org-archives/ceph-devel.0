From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: wip-denc
Date: Wed, 14 Sep 2016 17:53:43 +0000
Message-ID: <BL2PR02MB2115084F58D03E2AE932733FF4F10@BL2PR02MB2115.namprd02.prod.outlook.com>
References: <alpine.DEB.2.11.1609132104590.19761@piezo.us.to>
 <a89da24e-7791-ef4a-acce-9f653eaac08e@redhat.com>
 <BL2PR02MB2115A35131A2704721503480F4F10@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1609141408550.19761@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-dm3nam03on0073.outbound.protection.outlook.com ([104.47.41.73]:36832
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750815AbcINRxq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 14 Sep 2016 13:53:46 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Mark Nelson <mnelson@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Sage,
Quick update : with latest master with your BufferSpace fix memory issue is=
 resolved it seems , 2 hours now and not seeing much growth :-)
Regarding performance drop , will keep you posted..

Thanks & Regards
Somnath

-----Original Message-----
From: Somnath Roy=20
Sent: Wednesday, September 14, 2016 7:51 AM
To: 'Sage Weil'
Cc: Mark Nelson; ceph-devel@vger.kernel.org
Subject: RE: wip-denc

I am using stupid allocator and bitmap freelist..
I will try to see what is happening there..

-----Original Message-----
From: Sage Weil [mailto:sweil@redhat.com]
Sent: Wednesday, September 14, 2016 7:10 AM
To: Somnath Roy
Cc: Mark Nelson; ceph-devel@vger.kernel.org
Subject: RE: wip-denc

On Wed, 14 Sep 2016, Somnath Roy wrote:
> Sage/Mark,
> I cherry-picked the 5 commits related to memory leak from the pull reques=
t and it seems to be *fixing* the memory issue so far in my setup. Got the =
following crash though.
>=20
> /root/ceph-master/src/os/bluestore/BlueStore.h: 319: FAILED
> assert(bc.empty())

I've pushed a fix for this to the branch.  (It wasn't ~SharedBlob(), but th=
e BufferSpace cache data that had to get freed under the correct lock.)

I'm not sure about the StupidAllocator one, though... probably not related.=
  What options are you running with?  I've testing with defaults, which use=
 BitmapAllocator for both bluefs and bluestore...

Thanks!
sage


>  ceph version v11.0.0-2254-g8c52058
> (8c52058bc8a0f060e06037196627c19b7d258f1f)
>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> const*)+0x80) [0x55d6cde26ef0]
>  2: (BlueStore::SharedBlob::~SharedBlob()+0x82) [0x55d6cdbabee2]
>  3: (BlueStore::SharedBlob::put()+0x17d) [0x55d6cdb581dd]
>  4: (BlueStore::Onode::put()+0x1e8) [0x55d6cdbaca88]
>  5: (BlueStore::TwoQCache::trim(unsigned long, unsigned long)+0x7b3)=20
> [0x55d6cdb6e6d3]
>  6:=20
> (BlueStore::getattr(boost::intrusive_ptr<ObjectStore::CollectionImpl>&
> , ghobject_t const&, char const*, ceph::buffer::ptr&)+0x120)=20
> [0x55d6cdb93810]
>  7: (PGBackend::objects_get_attr(hobject_t const&,=20
> std::__cxx11::basic_string<char, std::char_traits<char>,=20
> std::allocator<char> > const&, ceph::buffer::list*)+0x106)=20
> [0x55d6cd970216]
>  8: (ReplicatedPG::get_object_context(hobject_t const&, bool,=20
> std::map<std::__cxx11::basic_string<char, std::char_traits<char>,=20
> std::allocator<char> >, ceph::buffer::list,=20
> std::less<std::__cxx11::basic_string<char, std::char_traits<char>,=20
> std::allocator<char> > >,=20
> std::allocator<std::pair<std::__cxx11::basic_string<char,
> std::char_traits<char>, std::allocator<char> > const,=20
> ceph::buffer::list> > >*)+0x92e) [0x55d6cd8f0cee]
>  9: (ReplicatedPG::prep_object_replica_pushes(hobject_t const&,=20
> eversion_t, PGBackend::RecoveryHandle*)+0x1a4) [0x55d6cd8f9654]
>  10: (ReplicatedPG::recover_replicas(unsigned long,
> ThreadPool::TPHandle&)+0x1093) [0x55d6cd937d83]
>  11: (ReplicatedPG::start_recovery_ops(unsigned long,=20
> ThreadPool::TPHandle&, unsigned long*)+0xd86) [0x55d6cd9406a6]
>  12: (OSD::do_recovery(PG*, unsigned int, unsigned long,
> ThreadPool::TPHandle&)+0x426) [0x55d6cd7b2f96]
>  13: (OSD::ShardedOpWQ::_process(unsigned int,
> ceph::heartbeat_handle_d*)+0x5bf) [0x55d6cd7b3b6f]
>  14: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x7f9)=20
> [0x55d6cde2bca9]
>  15: (ShardedThreadPool::WorkThreadSharded::entry()+0x10)
> [0x55d6cde2f060]
>  16: (()+0x76fa) [0x7fd9251296fa]
>  17: (clone()+0x6d) [0x7fd923a14b5d]
>=20
>=20
> I comment out the following commit as it seems a double delete from BlueS=
tore::SharedBlob::put() (?).
>=20
> 681c368c3e809c3291430582bc5d11f9cc44b4ca
>=20
> Another point, probably, not related to leak fix, but, in the latest mast=
er (+ your 1st 5 commits) I am hitting the following assert after OSD resta=
rt. If I run IO for some time..
>=20
> Thread 1 "ceph-osd" received signal SIGABRT, Aborted.
> 0x00007ffff47fd418 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/unix=
/sysv/linux/raise.c:54
> 54      ../sysdeps/unix/sysv/linux/raise.c: No such file or directory.
> (gdb) bt
> #0  0x00007ffff47fd418 in __GI_raise (sig=3Dsig@entry=3D6) at
> ../sysdeps/unix/sysv/linux/raise.c:54
> #1  0x00007ffff47ff01a in __GI_abort () at abort.c:89
> #2  0x0000555555fa114b in ceph::__ceph_assert_fail (assertion=3Dassertion=
@entry=3D0x5555562460ed "rm.empty()",
>     file=3Dfile@entry=3D0x555556245fd8 "/root/ceph-master/src/os/bluestor=
e/StupidAllocator.cc", line=3Dline@entry=3D305,
>     func=3Dfunc@entry=3D0x5555562462c0
> <StupidAllocator::init_rm_free(unsigned long, unsigned=20
> long)::__PRETTY_FUNCTION__> "virtual void=20
> StupidAllocator::init_rm_free(uint64_t, uint64_t)") at
> /root/ceph-master/src/common/assert.cc:78
> #3  0x0000555555df6d5c in StupidAllocator::init_rm_free (this=3D0x55555f0=
6f7a0, offset=3D<optimized out>, length=3D<optimized out>)
>     at /root/ceph-master/src/os/bluestore/StupidAllocator.cc:305
> #4  0x0000555555dd33aa in BlueFS::mount (this=3D0x55555f266580) at
> /root/ceph-master/src/os/bluestore/BlueFS.cc:366
> #5  0x0000555555d017e5 in BlueStore::_open_db=20
> (this=3Dthis@entry=3D0x55555f162000, create=3Dcreate@entry=3Dfalse) at
> /root/ceph-master/src/os/bluestore/BlueStore.cc:3008
> #6  0x0000555555d1c02d in BlueStore::mount (this=3D0x55555f162000) at
> /root/ceph-master/src/os/bluestore/BlueStore.cc:3659
> #7  0x0000555555924ef3 in OSD::init (this=3D0x55555f14a000) at
> /root/ceph-master/src/osd/OSD.cc:2025
> #8  0x00005555558838ff in main (argc=3D<optimized out>, argv=3D<optimized
> out>) at /root/ceph-master/src/ceph_osd.cc:609
>=20
> Thanks & Regards
> Somnath
>=20
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org=20
> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Mark Nelson
> Sent: Tuesday, September 13, 2016 4:46 PM
> To: Sage Weil; ceph-devel@vger.kernel.org
> Subject: Re: wip-denc
>=20
>=20
>=20
> On 09/13/2016 04:17 PM, Sage Weil wrote:
> > Hi everyone,
> >
> > Okay, I have a new wip-denc branch working and ready for some review:
> >
> > https://github.com/ceph/ceph/pull/11027
> >
> > Highlights:
> >
> > - This includes appender/iterator changes to buffer* to speed up=20
> > encoding and decoding (fewer bounds checks, simpler structures).
> >
> > - Accordingly, classes/types using the new-style have different=20
> > arguments types for encode/decode.  There is also a new
> > bound_encode() method that is used to calculate how big of a buffer to =
preallocate.
> >
> > - Most of the important helpers for doing types have new versions=20
> > that work with the new framework (e.g., the ENCODE_START macro has a=20
> > new DENC_START counterpart).
> >
> > - There is also a mechanism that lets you define the bound_encode,=20
> > encode, and decode methods all in one go using some template magic.
> > This only works for pretty simple types, but it is handy.  It looks lik=
e so:
> >
> >   struct foo_t {
> >     uint32_t a, b;
> >     ...
> >     DENC(foo_t, v, p) {
> >       DENC_START(1, 1, p);
> >       denc(v.a, p);
> >       denc(v.b, p);
> >       ...
> >       DENC_FINISH(p);
> >     }
> >   };
> >   WRITE_CLASS_DENC(foo_t)
> >
> >
> > - For new-style types, a new 'denc' function that is overload to do=20
> > either bound_encode, encode, or decode (based on argument types) is def=
ined.
> > That means that
> >
> >   ::denc(v, p);
> >
> > will work for size_t& p, bufferptr::iterator& p, or=20
> > bufferlist::contiguous_appender& p.  This facilitates the DENC=20
> > definitions above.
> >
> > - There is glue to invoke new-style encode/decode when old-style
> > encode() and decode() are invoked, provided a denc_traits<T> is defined=
.
> >
> > - Most of the common containers are there list, vector, set, map,=20
> > pair, but others need to be converted.
> >
> > - Currently, we're a bit aggressive about using the new-style over=20
> > the old-style when we have the change.  For example, if you have
> >
> >   vector<int32_t> foo;
> >   ::encode(foo, bl);
> >
> > it will see that it knows how to do int32_t new-style and invoke the=20
> > new-style vector<> code.  I think this is going to be a net win,=20
> > since we avoid doing bounds checks on append for every element (and=20
> > the bound_encode is O(1) for thees base types).  On the other hand,=20
> > it is currently smart enough to not use new-style for individual=20
> > integer types, like so
> >
> >   int32_t v;
> >   ::encode(v, bl);
> >
> > although I suspect after the optimizer gets done with it the=20
> > generated machine code is almost identical.
> >
> > - Most of the key bluestore types are converted over so that we can=20
> > do some benchmarking.
> >
> > An overview is at the top of the new denc.h header here:
> >
> > https://github.com/liewegas/ceph/blob/wip-denc/src/include/denc.h#L5
> > 5
> >
> > I think I've captured the best of Allen's, Varada's, and Sam's=20
> > various approaches, but we'll see how it behaves.  Let me know what you=
 think!
>=20
> So far this is working pretty well!  It's not even crashing anymore.=20
> :D
>=20
> Just recapping from IRC for ceph-devel: Overall append overhead is lower =
than it was before, but not as low as we got it in the old code by creating=
 a single appender all the way from ENCODE_START to ENCODE_FINISH and (manu=
ally) estimating the memory to allocate across the whole thing.  On the oth=
er hand we are faster overall now with the extentmap sharding, so we're on =
the right track!  Here we're calling encode_some potentially many times in =
ExtentMap::update and creating a new appender for each encode_some call.  N=
ot sure if we are flushing multiple times or only at the end, but buffer::l=
ist::append is still consuming a decent chunk of CPU, and encode_some itsel=
f is too. I'm suspicious of the c_str() calls and pbl->append(bufferptr(bp,=
 0, l) even though they aren't being explicitly singled out by perf.  In an=
y event there's probably some tweaking to do here.
>=20
> Beyond that I don't have much to report yet.  Rb_tree_increment in encode=
_spanning_blobs and BitMapAreaLeaf::child_check_n_lock are starting to show=
 up as bigger % consumers than they used to, so that's good news.
>=20
> FWIW, it looks like we are getting about a 1-4% performance improvement o=
ver master from this in my CPU limited case.  So far memory usage is still =
pretty high, with OSDs using about 5.3GB of RSS per OSD at the end of a 5 m=
inute randwrite test.
>=20
> Mark
>=20
> >
> > Thanks-
> > sage
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > in the body of a message to majordomo@vger.kernel.org More majordomo=20
> > info at  http://vger.kernel.org/majordomo-info.html
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at  http://vger.kernel.org/majordomo-info.html
> PLEASE NOTE: The information contained in this electronic mail message is=
 intended only for the use of the designated recipient(s) named above. If t=
he reader of this message is not the intended recipient, you are hereby not=
ified that you have received this message in error and that any review, dis=
semination, distribution, or copying of this message is strictly prohibited=
. If you have received this communication in error, please notify the sende=
r by telephone or e-mail (as shown above) immediately and destroy any and a=
ll copies of this message in your possession (whether hard copies or electr=
onically stored copies).
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
