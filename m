From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Bluestore assert
Date: Tue, 6 Sep 2016 15:29:37 +0000
Message-ID: <BL2PR02MB21153CECC2C7A52CBE6DF349F4F90@BL2PR02MB2115.namprd02.prod.outlook.com>
References: <BL2PR02MB2115443F5ACA3459E2CEBFBAF41D0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <CY1PR02MB21235A07222322180C0E2BDFF4EA0@CY1PR02MB2123.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608242132460.25681@piezo.us.to>
    <BL2PR02MB21154C4E291C96D597444649F4E00@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608311318350.19032@piezo.us.to>
  <BL2PR02MB21153A76E39772A143A638EEF4E50@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1609021627100.31624@piezo.us.to>
 <BL2PR02MB2115D290C0F978DB7B2D1DD4F4E50@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1609021749210.31624@piezo.us.to>
 <BL2PR02MB2115DE43126DFD3E07D18684F4E50@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1609021925520.31624@piezo.us.to>
 <BL2PR02MB211595930224CC5D83806B9BF4E50@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1609022024110.31624@piezo.us.to>
  <BL2PR02MB21154E779E52E87B49864166F4F90@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1609061327070.31624@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-dm3nam03on0053.outbound.protection.outlook.com ([104.47.41.53]:2464
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936409AbcIFP3l (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 6 Sep 2016 11:29:41 -0400
In-Reply-To: <alpine.DEB.2.11.1609061327070.31624@piezo.us.to>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Sage,
Please find the entire 0/20 log in the following location for the first ass=
ert.

https://github.com/somnathr/ceph/blob/master/ceph-osd.3.log

This may not be helpful, I will try to reproduce this with debug_bluefs =3D=
 10/20.

Thanks & Regards
Somnath

-----Original Message-----
From: Sage Weil [mailto:sweil@redhat.com]=20
Sent: Tuesday, September 06, 2016 6:28 AM
To: Somnath Roy
Cc: Mark Nelson; ceph-devel
Subject: RE: Bluestore assert

On Tue, 6 Sep 2016, Somnath Roy wrote:
> Sage,
> Here is one of the assert that I can reproduce consistently while I was r=
unning with big runway values and for 10 hours of 4K RW without preconditio=
ning.
>=20
> 1.=20
>=20
> in thread 7f9de27ff700 thread_name:rocksdb:bg7
>=20
>  ceph version 11.0.0-1946-g9a5cfe2 (9a5cfe2e8e8c79b976c34e593993d74b58fce=
885)
>  1: (()+0xa0d94e) [0x55aa63cd194e]
>  2: (()+0x113d0) [0x7f9df56723d0]
>  3: (gsignal()+0x38) [0x7f9df33f7418]
>  4: (abort()+0x16a) [0x7f9df33f901a]
>  5: (()+0x2dbd7) [0x7f9df33efbd7]
>  6: (()+0x2dc82) [0x7f9df33efc82]
>  7: (BlueFS::_compact_log_async(std::unique_lock<std::mutex>&)+0x1d43) [0=
x55aa63abea33]
>  8: (BlueFS::sync_metadata()+0x38b) [0x55aa63abef0b]
>  9: (BlueRocksDirectory::Fsync()+0xd) [0x55aa63ad303d]
>  10: (rocksdb::CompactionJob::Run()+0xe86) [0x55aa63ca3c96]
>  11: (rocksdb::DBImpl::BackgroundCompaction(bool*, rocksdb::JobContext*, =
rocksdb::LogBuffer*, void*)+0x9c0) [0x55aa63b91c50]
>  12: (rocksdb::DBImpl::BackgroundCallCompaction(void*)+0xbf) [0x55aa63b9e=
abf]
>  13: (rocksdb::ThreadPool::BGThread(unsigned long)+0x1d9) [0x55aa63c556b9=
]
>  14: (()+0x991753) [0x55aa63c55753]
>  15: (()+0x76fa) [0x7f9df56686fa]
>  16: (clone()+0x6d) [0x7f9df34c8b5d]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed=
 to interpret this.
>=20
> I was able to root cause it as a async log compaction bug. Here is my ana=
lysis..
>=20
> Here is the log snippet (for the crashing thread) it dumped with debug_bl=
uefs =3D 0/20.
>=20
>    -95> 2016-09-05 18:09:38.242895 7f8d7a3f5700 10 bluefs _compact_log_as=
ync remove 0x32100000 of [1:0x3f2d900000+100000,0:0x1e7700000+19000000]
>    -94> 2016-09-05 18:09:38.242903 7f8d7a3f5700 10 bluefs _compact_log_as=
ync remove old log extent 1:0x3f2d900000+100000
>    -93> 2016-09-05 18:09:38.242905 7f8d7a3f5700 10 bluefs _compact_log_as=
ync remove old log extent 0:0x1e7700000+19000000
>    -92> 2016-09-05 18:09:38.242907 7f8d7a3f5700 10 bluefs _compact_log_as=
ync remove old log extent 0:0x1e7700000+19000000
>=20
> So, last two entries of the extent is similar and it is corrupted because=
 we didn't check whether vector is empty in the following loop. We are tryi=
ng to use front() on the empty vector which is undefined and later it is cr=
ashed while we are using begin() with vector erase. Begin() with empty vect=
or can't be dereferenced.
>=20
>   dout(10) << __func__ << " remove 0x" << std::hex << old_log_jump_to << =
std::dec
> 	   << " of " << log_file->fnode.extents << dendl;
>   uint64_t discarded =3D 0;
>   vector<bluefs_extent_t> old_extents;
>   while (discarded < old_log_jump_to) {
>     bluefs_extent_t& e =3D log_file->fnode.extents.front();
>     bluefs_extent_t temp =3D e;
>     if (discarded + e.length <=3D old_log_jump_to) {
>       dout(10) << __func__ << " remove old log extent " << e << dendl;
>       discarded +=3D e.length;
>       log_file->fnode.extents.erase(log_file->fnode.extents.begin());
>     } else {
>       dout(10) << __func__ << " remove front of old log extent " << e << =
dendl;
>       uint64_t drop =3D old_log_jump_to - discarded;
>       temp.length =3D drop;
>       e.offset +=3D drop;
>       e.length -=3D drop;
>       discarded +=3D drop;
>       dout(10) << __func__ << "   kept " << e << " removed " << temp << d=
endl;
>     }
>     old_extents.push_back(temp);
>   }
>=20
> But, question is other than adding an empty check for the vector do we ne=
ed to do anything else ? Why in this case after ~7 hours old_log_jump_to is=
 bigger than the content of extent vector (because of bigger runway config =
?) ?

Exactly--it shouldn't be.  old_log_jump_to *must* be less than the=20
totally allocated extents.  It should equal just the extents that were=20
present/used *prior* to us ensuring that runway is allocated.  Do you=20
have a bit more log?  We need to see why it was big enough to empty out=20
the vector...

> 2. Here is another assert during recovery , which I was not able reproduc=
e again later. The 0/20 log is not saying anything on the thread unfortunat=
ely !!

Hrm, hard to say what's going on there.  My guess is a secondary effect=20
from the above.  At least we should rule it out.

sage

>=20
> 2016-09-02 19:04:35.261856 7ff3e43fe700  0 -- 10.60.194.11:0/227385 >> 10=
.60.194.11:6822/227085 pipe(0x7ff38604a000 sd=3D38 :34638 s=3D1 pgs=3D0 cs=
=3D0 l=3D1 c=3D0x7ff386013900).fault
> 2016-09-02 19:04:35.262428 7ff3e43fe700  0 -- 10.60.194.11:0/227385 >> 10=
.60.194.11:6822/227085 pipe(0x7ff38604a000 sd=3D38 :34682 s=3D1 pgs=3D0 cs=
=3D0 l=3D1 c=3D0x7ff386013900).connect claims to be 10.60.194.11:6822/12262=
53 not 10.60.194.11:6822/227085 - wrong node!
> 2016-09-02 19:04:35.263045 7ff3ae1fc700  0 -- 10.60.194.11:6832/1227385 >=
> 10.60.194.10:6805/937878 pipe(0x7fee55871000 sd=3D36 :45296 s=3D2 pgs=3D5=
0 cs=3D1 l=3D0 c=3D0x7ff3aa87c640).fault, initiating reconnect
> 2016-09-02 19:04:35.263477 7ff3e31fc700  0 -- 10.60.194.11:6832/1227385 >=
> 10.60.194.10:6805/937878 pipe(0x7fee55871000 sd=3D36 :45348 s=3D1 pgs=3D5=
0 cs=3D2 l=3D0 c=3D0x7ff3aa87c640).connect got RESETSESSION
> 2016-09-02 19:04:35.270038 7ff3c5ff4700  0 -- 10.60.194.11:6832/1227385 s=
ubmit_message MOSDPGPushReply(1.235 22 [PushReplyOp(1:ac44029e:::rbd_data.1=
0176b8b4567.00000000001bb8db:head),PushReplyOp(1:ac44036d:::rbd_data.10176b=
8b4567.00000000005a5365:head),PushReplyOp(1:ac440604:::rbd_data.10176b8b456=
7.000000000043d177:head),PushReplyOp(1:ac440608:::rbd_data.10176b8b4567.000=
00000002aba83:head),PushReplyOp(1:ac44089f:::rbd_data.10176b8b4567.00000000=
00710e5d:head),PushReplyOp(1:ac4409cd:::rbd_data.10176b8b4567.0000000000689=
b0d:head),PushReplyOp(1:ac440c37:::rbd_data.10176b8b4567.00000000002d1db3:h=
ead),PushReplyOp(1:ac440e0b:::rbd_data.10176b8b4567.00000000009801e1:head)]=
) v2 remote, 10.60.194.11:6829/227799, failed lossy con, dropping message 0=
x7ff245058380
> 2016-09-02 19:04:35.282823 7ff3e43fe700  0 -- 10.60.194.11:0/227385 >> 10=
.60.194.11:6822/227085 pipe(0x7ff38604a000 sd=3D43 :34694 s=3D1 pgs=3D0 cs=
=3D0 l=3D1 c=3D0x7ff386013900).connect claims to be 10.60.194.11:6822/12262=
53 not 10.60.194.11:6822/227085 - wrong node!
> 2016-09-02 19:04:35.293903 7ff3e43fe700  0 -- 10.60.194.11:0/227385 >> 10=
.60.194.11:6822/227085 pipe(0x7ff38604a000 sd=3D38 :34696 s=3D1 pgs=3D0 cs=
=3D0 l=3D1 c=3D0x7ff386013900).connect claims to be 10.60.194.11:6822/12262=
53 not 10.60.194.11:6822/227085 - wrong node!
> 2016-09-02 19:04:39.366837 7ff3befe6700  0 log_channel(cluster) log [INF]=
 : 1.130 continuing backfill to osd.5 from (20'392769,22'395772] MIN to 22'=
395772
> 2016-09-02 19:04:39.367262 7ff3c17eb700  0 log_channel(cluster) log [INF]=
 : 1.39a continuing backfill to osd.4 from (20'383603,22'386606] MIN to 22'=
386606
> 2016-09-02 19:04:39.368695 7ff3c2fee700  0 log_channel(cluster) log [INF]=
 : 1.253 continuing backfill to osd.1 from (20'386883,22'389884] MIN to 22'=
389884
> 2016-09-02 19:04:39.408083 7ff3c17eb700  0 log_channel(cluster) log [INF]=
 : 1.70 continuing backfill to osd.1 from (20'388673,22'391675] MIN to 22'3=
91675
> 2016-09-02 19:04:39.408152 7ff3bf7e7700  0 log_channel(cluster) log [INF]=
 : 1.2bd continuing backfill to osd.1 from (20'389889,22'392892] MIN to 22'=
392892
> 2016-09-02 19:04:40.617675 7ff3b51fc700  0 -- 10.60.194.11:6832/1227385 >=
> 10.60.194.11:6801/226086 pipe(0x7fef0ebfe000 sd=3D85 :6832 s=3D0 pgs=3D0 =
cs=3D0 l=3D0 c=3D0x7ff20d7ce280).accept connect_seq 0 vs existing 0 state c=
onnecting
> 2016-09-02 19:04:40.617770 7ff3b62fd700  0 -- 10.60.194.11:6832/1227385 >=
> 10.60.194.11:6801/226086 pipe(0x7ff37b01a000 sd=3D86 :43610 s=3D4 pgs=3D0=
 cs=3D0 l=3D0 c=3D0x7ff37b01c140).connect got RESETSESSION but no longer co=
nnecting
> 2016-09-02 19:04:41.197663 7ff3c0fea700  0 log_channel(cluster) log [INF]=
 : 1.1ed continuing backfill to osd.0 from (20'393177,22'396182] MIN to 22'=
396182
> 2016-09-02 19:04:41.197689 7ff3c2fee700  0 log_channel(cluster) log [INF]=
 : 1.3fa continuing backfill to osd.0 from (20'391286,22'394289] MIN to 22'=
394289
> 2016-09-02 19:04:41.197736 7ff3c37ef700  0 log_channel(cluster) log [INF]=
 : 1.290 continuing backfill to osd.0 from (20'389914,22'392915] MIN to 22'=
392915
> 2016-09-02 19:04:41.197752 7ff3c37ef700  0 log_channel(cluster) log [INF]=
 : 1.290 continuing backfill to osd.13 from (20'389914,22'392915] MIN to 22=
'392915
> 2016-09-02 19:04:41.197759 7ff3bffe8700  0 log_channel(cluster) log [INF]=
 : 1.260 continuing backfill to osd.0 from (20'388867,22'391871] MIN to 22'=
391871
> 2016-09-02 19:04:41.405458 7ff39f7ff700 -1 os/bluestore/BlueStore.cc: In =
function 'void BlueStore::OnodeSpace::add(const ghobject_t&, BlueStore::Ono=
deRef)' thread 7ff39f7ff700 time 2016-09-02 19:04:41.387802
> os/bluestore/BlueStore.cc: 1065: FAILED assert(onode_map.count(oid) =3D=
=3D 0)
>=20
>  ceph version 11.0.0-1946-g9a5cfe2 (9a5cfe2e8e8c79b976c34e593993d74b58fce=
885)
>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)=
+0x80) [0x557bda1c9750]
>  2: (BlueStore::OnodeSpace::add(ghobject_t const&, boost::intrusive_ptr<B=
lueStore::Onode>)+0x4bf) [0x557bd9d9cd0f]
>  3: (BlueStore::Collection::get_onode(ghobject_t const&, bool)+0x63e) [0x=
557bd9d9d3ae]
>  4: (BlueStore::get_omap_iterator(boost::intrusive_ptr<ObjectStore::Colle=
ctionImpl>&, ghobject_t const&)+0xc5) [0x557bd9da2c45]
>  5: (BlueStore::get_omap_iterator(coll_t const&, ghobject_t const&)+0x7a)=
 [0x557bd9d7e50a]
>  6: (OSDriver::get_next(std::__cxx11::basic_string<char, std::char_traits=
<char>, std::allocator<char> > const&, std::pair<std::__cxx11::basic_string=
<char, std::char_traits<char>, std::allocator<char> >, ceph::buffer::list>*=
)+0x45) [0x557bd9af2305]
>  7: (SnapMapper::get_next_object_to_trim(snapid_t, hobject_t*)+0x482) [0x=
557bd9af2bf2]
>  8: (ReplicatedPG::TrimmingObjects::react(ReplicatedPG::SnapTrim const&)+=
0x4ac) [0x557bd9bfd8fc]
>  9: (boost::statechart::simple_state<ReplicatedPG::TrimmingObjects, Repli=
catedPG::SnapTrimmer, boost::mpl::list<mpl_::na, mpl_::na, mpl_::na, mpl_::=
na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, m=
pl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::=
na, mpl_::na>, (boost::statechart::history_mode)0>::react_impl(boost::state=
chart::event_base const&, void const*)+0xc8) [0x557bd9c42418]
>  10: (boost::statechart::state_machine<ReplicatedPG::SnapTrimmer, Replica=
tedPG::NotTrimming, std::allocator<void>, boost::statechart::null_exception=
_translator>::process_queued_events()+0x139) [0x557bd9c2d299]
>  11: (boost::statechart::state_machine<ReplicatedPG::SnapTrimmer, Replica=
tedPG::NotTrimming, std::allocator<void>, boost::statechart::null_exception=
_translator>::process_event(boost::statechart::event_base const&)+0x111) [0=
x557bd9c2d541]
>  12: (ReplicatedPG::snap_trimmer(unsigned int)+0x468) [0x557bd9ba1258]
>  13: (OSD::ShardedOpWQ::_process(unsigned int, ceph::heartbeat_handle_d*)=
+0x750) [0x557bd9a727b0]
>  14: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x89f) [0=
x557bda1b65cf]
>  15: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x557bda1b9c90=
]
>  16: (Thread::entry_wrapper()+0x75) [0x557bda1a9065]
>  17: (()+0x76fa) [0x7ff402b126fa]
>  18: (clone()+0x6d) [0x7ff400972b5d]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed=
 to interpret this.
>=20
> Thanks & Regards
> Somnath
>=20
> -----Original Message-----
> From: Somnath Roy=20
> Sent: Friday, September 02, 2016 1:27 PM
> To: 'Sage Weil'
> Cc: Mark Nelson; ceph-devel
> Subject: RE: Bluestore assert
>=20
> Yes, did that with similar ratio, see below,  max =3D 400MB , min =3D 100=
MB.
> Will see how it goes, thanks..
>=20
> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com]
> Sent: Friday, September 02, 2016 1:25 PM
> To: Somnath Roy
> Cc: Mark Nelson; ceph-devel
> Subject: RE: Bluestore assert
>=20
> On Fri, 2 Sep 2016, Somnath Roy wrote:
> > Sage,
> > I am running with big runway values now (min 100 MB, max 400MB) and wil=
l keep you posted on this.
> > One point, if I give this big runway values, the allocation will be ver=
y frequent (and probably unnecessarily for most of the cases) , no harm wit=
h that ?
>=20
> I think it'll actually be less frequent, since it allocates bluefs_max_lo=
g_runway at a time.  Well, assuming you set that tunable as high well!
>=20
> sage
>=20
> >=20
> > Thanks & Regards
> > Somnath
> >=20
> > -----Original Message-----
> > From: Sage Weil [mailto:sweil@redhat.com]
> > Sent: Friday, September 02, 2016 12:27 PM
> > To: Somnath Roy
> > Cc: Mark Nelson; ceph-devel
> > Subject: RE: Bluestore assert
> >=20
> > On Fri, 2 Sep 2016, Somnath Roy wrote:
> > > Sage,
> > > It is probably the universal compaction that is generating bigger fil=
es, other than that I don't see the following tuning will be generating lar=
ge files.
> > > I will try some universal compaction tuning related to file size and =
confirm.
> > > Yeah, big bluefs_min_log_runway value will probably shield the assert=
 for now , but, I am afraid since we don't have control to the file size , =
we can't possibly sure about the value we should be giving with bluefs_min_=
log_runway for assert not to hit in future long runs.
> > > Can't we do like this ?
> > >=20
> > > //Basically, checking the length of the log as well if (runway <
> > > g_conf->bluefs_min_log_runway) || (runway < log_writer
> > > ->buffer.length() {  //allocate }
> >=20
> > Oh, I see what you mean.  Yeah, I'll add that in--certainly doesn't hur=
t.
> >=20
> > And I think just configuring a long runway won't hurt either (e.g., 100=
MB).
> >=20
> > That's probably enough to be safe, but once we fix the flush thing I me=
ntioned that will make this go away.
> >=20
> > s
> >=20
> > >=20
> > > Thanks & Regards
> > > Somnath
> > >=20
> > > -----Original Message-----
> > > From: Sage Weil [mailto:sweil@redhat.com]
> > > Sent: Friday, September 02, 2016 10:57 AM
> > > To: Somnath Roy
> > > Cc: Mark Nelson; ceph-devel
> > > Subject: RE: Bluestore assert
> > >=20
> > > On Fri, 2 Sep 2016, Somnath Roy wrote:
> > > > Here is my rocksdb option :
> > > >=20
> > > >         bluestore_rocksdb_options =3D "max_write_buffer_number=3D16=
,min_write_buffer_number_to_merge=3D2,recycle_log_file_num=3D16,compaction_=
threads=3D32,flusher_threads=3D8,max_background_compactions=3D32,max_backgr=
ound_flushes=3D8,max_bytes_for_level_base=3D5368709120,write_buffer_size=3D=
83886080,level0_file_num_compaction_trigger=3D4,level0_slowdown_writes_trig=
ger=3D400,level0_stop_writes_trigger=3D800,stats_dump_period_sec=3D10,compa=
ction_style=3DkCompactionStyleUniversal"
> > > >=20
> > > > one discrepancy I can see here on max_bytes_for_level_base , it=20
> > > > should be same as level 0 size. Initially, I had bigger=20
> > > > min_write_buffer_number_to_merge and that's how I calculated. Now,=
=20
> > > > level 0 size is the following
> > > >=20
> > > > write_buffer_size * min_write_buffer_number_to_merge *=20
> > > > level0_file_num_compaction_trigger =3D 80MB * 2 * 4 =3D ~640MB
> > > >=20
> > > > I should adjust max_bytes_for_level_base to the similar value proba=
bly.
> > > >=20
> > > > Please find the level 10 log here. The log I captured during replay=
 (crashed again) after it crashed originally because of the same reason.
> > > >=20
> > > > https://drive.google.com/file/d/0B7W-S0z_ymMJSnA3R2dyellYZ0U/view?
> > > > us
> > > > p=3D
> > > > sharing
> > > >=20
> > > > Thanks for the explanation , I got it now why it is trying to=20
> > > > flush inode 1.
> > > >=20
> > > > But, shouldn't we check the length as well during runway check=20
> > > > rather than just relying on bluefs_min_log_runway only.
> > >=20
> > > That's what this does:
> > >=20
> > >   uint64_t runway =3D log_writer->file->fnode.get_allocated() -=20
> > > log_writer->pos;
> > >=20
> > > Anyway, I think I see what's going on.  There are a ton of _fsync and=
 _flush_range calls that have to flush the fnode, and the fnode is pretty b=
ig (maybe 5k?) because it has so many extents (your tunables are generating=
 really big files).
> > >=20
> > > I think this is just a matter of the runway configurable being too sm=
all for your configuration.  Try bumping bluefs_min_log_runway by 10x.
> > >=20
> > > Well, actually, we could improve this a bit.  Right now rocksdb is ca=
lling lots of flush on a bit sst, and a final fsync at the end.  Bluefs is =
logging the updated fnode every time the flush changes the file size, and t=
hen only writing it to disk when the final fsync happens.  Instead, it coul=
d/should put the dirty fnode on a list and only at log flush time flush app=
end the latest fnodes to the log and write it out.
> > >=20
> > > I'll add it to the trello board.  I think it's not that big a deal..=
=20
> > > except when you have really big files.
> > >=20
> > > sage
> > >=20
> > >=20
> > >  >
> > > > Thanks & Regards
> > > > Somnath
> > > >=20
> > > > -----Original Message-----
> > > > From: Sage Weil [mailto:sweil@redhat.com]
> > > > Sent: Friday, September 02, 2016 9:35 AM
> > > > To: Somnath Roy
> > > > Cc: Mark Nelson; ceph-devel
> > > > Subject: RE: Bluestore assert
> > > >=20
> > > >=20
> > > >=20
> > > > On Fri, 2 Sep 2016, Somnath Roy wrote:
> > > >=20
> > > > > Sage,
> > > > > Tried to do some analysis on the inode assert, following looks su=
spicious.
> > > > >=20
> > > > >    -10> 2016-08-31 17:55:56.921075 7faf14fff700 10 bluefs _fsync =
0x7faf12075140 file(ino 693 size 0x19c2c265 mtime 2016-08-31 17:55:56.91903=
8 bdev 1 extents [1:0x6e500000+100000,1:0x6e700000+100000,1:0x6ea00000+2000=
00,1:0x6ed00000+200000,1:0x6f000000+200000,1:0x6f300000+200000,1:0x6f600000=
+200000,1:0x6f900000+200000,1:0x6fc00000+200000,1:0x6ff00000+100000,1:0x701=
00000+200000,1:0x70400000+200000,1:0x70700000+200000,1:0x70a00000+100000,1:=
0x70c00000+200000,1:0x70f00000+100000,1:0x71100000+200000,1:0x71400000+2000=
00,1:0x71700000+200000,1:0x71a00000+100000,1:0x71c00000+100000,1:0x71e00000=
+100000,1:0x72000000+100000,1:0x72200000+200000,1:0x72500000+200000,1:0x728=
00000+100000,1:0x72a00000+100000,1:0x72c00000+200000,1:0x72f00000+100000,1:=
0x73100000+200000,1:0x73400000+100000,1:0x73600000+200000,1:0x73900000+2000=
00,1:0x73c00000+200000,1:0x73f00000+200000,1:0x74300000+200000,1:0x74600000=
+200000,1:0x74900000+200000,1:0x74c00000+200000,1:0x74f00000+100000,1:0x751=
00000+100000,1!
 :0!
>  x7!
> >  53!
> > >  00!
> > > >  000+100000,1:0x75600000+100000,1:0x75800000+100000,1:0x75a00000+20=
0000,1:0x75d00000+100000,1:0x75f00000+100000,1:0x76100000+100000,1:0x764000=
00+200000,1:0x76700000+200000,1:0x76a00000+300000,1:0x76e00000+200000,1:0x7=
7100000+100000,1:0x77300000+100000,1:0x77500000+100000,1:0x77700000+300000,=
1:0x77b00000+200000,1:0x77e00000+200000,1:0x78100000+100000,1:0x78300000+20=
0000,1:0x78600000+200000,1:0x78900000+100000,1:0x78c00000+100000,1:0x78e000=
00+100000,1:0x79000000+100000,1:0x79200000+100000,1:0x79400000+200000,1:0x7=
9700000+100000,1:0x79900000+200000,1:0x79c00000+200000,1:0x79f00000+100000,=
1:0x7a100000+200000,1:0x7a400000+200000,1:0x7a700000+100000,1:0x7a900000+20=
0000,1:0x7ac00000+100000,1:0x7ae00000+100000,1:0x7b000000+100000,1:0x7b2000=
00+200000,1:0x7b500000+100000,1:0x7b800000+200000,1:0x7bb00000+100000,1:0x7=
bd00000+200000,1:0x7c000000+100000,1:0x7c200000+200000,1:0x7c500000+100000,=
1:0x7c700000+100000,1:0x7c900000+200000,1:0x7cc00000+100000,1:0x7ce00000+10=
0000,1:0x7d000!
 00!
>  0+!
> >  10!
> > >  00!
> > > > =20
> > > > 00,1:0x7d200000+100000,1:0x7d400000+100000,1:0x7d600000+100000,1:0
> > > > x7
> > > > d8
> > > > 00000+10e00000])
> > > > >     -9> 2016-08-31 17:55:56.921117 7faf14fff700 10 bluefs _flush =
0x7faf12075140 no dirty data on file(ino 693 size 0x19c2c265 mtime 2016-08-=
31 17:55:56.919038 bdev 1 extents [1:0x6e500000+100000,1:0x6e700000+100000,=
1:0x6ea00000+200000,1:0x6ed00000+200000,1:0x6f000000+200000,1:0x6f300000+20=
0000,1:0x6f600000+200000,1:0x6f900000+200000,1:0x6fc00000+200000,1:0x6ff000=
00+100000,1:0x70100000+200000,1:0x70400000+200000,1:0x70700000+200000,1:0x7=
0a00000+100000,1:0x70c00000+200000,1:0x70f00000+100000,1:0x71100000+200000,=
1:0x71400000+200000,1:0x71700000+200000,1:0x71a00000+100000,1:0x71c00000+10=
0000,1:0x71e00000+100000,1:0x72000000+100000,1:0x72200000+200000,1:0x725000=
00+200000,1:0x72800000+100000,1:0x72a00000+100000,1:0x72c00000+200000,1:0x7=
2f00000+100000,1:0x73100000+200000,1:0x73400000+100000,1:0x73600000+200000,=
1:0x73900000+200000,1:0x73c00000+200000,1:0x73f00000+200000,1:0x74300000+20=
0000,1:0x74600000+200000,1:0x74900000+200000,1:0x74c00000+200000,1:0x74f000=
00+100000,1:0x!
 75!
>  10!
> >  00!
> > >  00!
> > > >  +100000,1:0x75300000+100000,1:0x75600000+100000,1:0x75800000+10000=
0,1:0x75a00000+200000,1:0x75d00000+100000,1:0x75f00000+100000,1:0x76100000+=
100000,1:0x76400000+200000,1:0x76700000+200000,1:0x76a00000+300000,1:0x76e0=
0000+200000,1:0x77100000+100000,1:0x77300000+100000,1:0x77500000+100000,1:0=
x77700000+300000,1:0x77b00000+200000,1:0x77e00000+200000,1:0x78100000+10000=
0,1:0x78300000+200000,1:0x78600000+200000,1:0x78900000+100000,1:0x78c00000+=
100000,1:0x78e00000+100000,1:0x79000000+100000,1:0x79200000+100000,1:0x7940=
0000+200000,1:0x79700000+100000,1:0x79900000+200000,1:0x79c00000+200000,1:0=
x79f00000+100000,1:0x7a100000+200000,1:0x7a400000+200000,1:0x7a700000+10000=
0,1:0x7a900000+200000,1:0x7ac00000+100000,1:0x7ae00000+100000,1:0x7b000000+=
100000,1:0x7b200000+200000,1:0x7b500000+100000,1:0x7b800000+200000,1:0x7bb0=
0000+100000,1:0x7bd00000+200000,1:0x7c000000+100000,1:0x7c200000+200000,1:0=
x7c500000+100000,1:0x7c700000+100000,1:0x7c900000+200000,1:0x7cc00000+10000=
0,1:0x7ce00000!
 +1!
>  00!
> >  00!
> > >  0,!
> > > > =20
> > > > 1:0x7d000000+100000,1:0x7d200000+100000,1:0x7d400000+100000,1:0x7d
> > > > 60
> > > > 00
> > > > 00+100000,1:0x7d800000+10e00000])
> > > > >     -8> 2016-08-31 17:55:56.921137 7faf14fff700 10 bluefs wait_fo=
r_aio 0x7faf12075140
> > > > >     -7> 2016-08-31 17:55:56.931541 7faf14fff700 10 bluefs wait_fo=
r_aio 0x7faf12075140 done in 0.010402
> > > > >     -6> 2016-08-31 17:55:56.931551 7faf14fff700 20 bluefs _fsync =
file metadata was dirty (31278) on file(ino 693 size 0x19c2c265 mtime 2016-=
08-31 17:55:56.919038 bdev 1 extents [1:0x6e500000+100000,1:0x6e700000+1000=
00,1:0x6ea00000+200000,1:0x6ed00000+200000,1:0x6f000000+200000,1:0x6f300000=
+200000,1:0x6f600000+200000,1:0x6f900000+200000,1:0x6fc00000+200000,1:0x6ff=
00000+100000,1:0x70100000+200000,1:0x70400000+200000,1:0x70700000+200000,1:=
0x70a00000+100000,1:0x70c00000+200000,1:0x70f00000+100000,1:0x71100000+2000=
00,1:0x71400000+200000,1:0x71700000+200000,1:0x71a00000+100000,1:0x71c00000=
+100000,1:0x71e00000+100000,1:0x72000000+100000,1:0x72200000+200000,1:0x725=
00000+200000,1:0x72800000+100000,1:0x72a00000+100000,1:0x72c00000+200000,1:=
0x72f00000+100000,1:0x73100000+200000,1:0x73400000+100000,1:0x73600000+2000=
00,1:0x73900000+200000,1:0x73c00000+200000,1:0x73f00000+200000,1:0x74300000=
+200000,1:0x74600000+200000,1:0x74900000+200000,1:0x74c00000+200000,1:0x74f=
00000+100000,1!
 :0!
>  x7!
> >  51!
> > >  00!
> > > >  000+100000,1:0x75300000+100000,1:0x75600000+100000,1:0x75800000+10=
0000,1:0x75a00000+200000,1:0x75d00000+100000,1:0x75f00000+100000,1:0x761000=
00+100000,1:0x76400000+200000,1:0x76700000+200000,1:0x76a00000+300000,1:0x7=
6e00000+200000,1:0x77100000+100000,1:0x77300000+100000,1:0x77500000+100000,=
1:0x77700000+300000,1:0x77b00000+200000,1:0x77e00000+200000,1:0x78100000+10=
0000,1:0x78300000+200000,1:0x78600000+200000,1:0x78900000+100000,1:0x78c000=
00+100000,1:0x78e00000+100000,1:0x79000000+100000,1:0x79200000+100000,1:0x7=
9400000+200000,1:0x79700000+100000,1:0x79900000+200000,1:0x79c00000+200000,=
1:0x79f00000+100000,1:0x7a100000+200000,1:0x7a400000+200000,1:0x7a700000+10=
0000,1:0x7a900000+200000,1:0x7ac00000+100000,1:0x7ae00000+100000,1:0x7b0000=
00+100000,1:0x7b200000+200000,1:0x7b500000+100000,1:0x7b800000+200000,1:0x7=
bb00000+100000,1:0x7bd00000+200000,1:0x7c000000+100000,1:0x7c200000+200000,=
1:0x7c500000+100000,1:0x7c700000+100000,1:0x7c900000+200000,1:0x7cc00000+10=
0000,1:0x7ce00!
 00!
>  0+!
> >  10!
> > >  00!
> > > > =20
> > > > 00,1:0x7d000000+100000,1:0x7d200000+100000,1:0x7d400000+100000,1:0
> > > > x7
> > > > d6
> > > > 00000+100000,1:0x7d800000+10e00000]), flushing log
> > > > >=20
> > > > > The above looks good, it is about to call _flush_and_sync_log() a=
fter this.
> > > >=20
> > > > Yes, although this file is huge (0x19c2c265 =3D 432194149 ~ 400MB).=
.. What rocksdb options did you pass in?  I'm guessing this is a log file, =
but we generally want those smallish (maybe 16MB - 64MB, so that L0 SST gen=
eration isn't too slow).
> > > >=20
> > > > >     -5> 2016-08-31 17:55:56.931588 7faf14fff700 10 bluefs _flush_=
and_sync_log txn(seq 31278 len 0x50e146 crc 0x58a6b9ab)
> > > > >     -4> 2016-08-31 17:55:56.933951 7faf14fff700 10 bluefs _pad_bl=
 padding with 0xe94 zeros
> > > > >     -3> 2016-08-31 17:55:56.934079 7faf14fff700 20 bluefs flush_b=
dev
> > > > >     -2> 2016-08-31 17:55:56.934257 7faf14fff700 10 bluefs _flush =
0x7faf2e824140 0xce9000~50f000 to file(ino 1 size 0xce9000 mtime 0.000000 b=
dev 0 extents [0:0xba00000+500000,0:0xfd00000+c00000])
> > > > >     -1> 2016-08-31 17:55:56.934274 7faf14fff700 10 bluefs _flush_=
range 0x7faf2e824140 pos 0xce9000 0xce9000~50f000 to file(ino 1 size 0xce90=
00 mtime 0.000000 bdev 0 extents [0:0xba00000+500000,0:0xfd00000+c00000])
> > > > >      0> 2016-08-31 17:55:56.939745 7faf14fff700 -1
> > > > > os/bluestore/BlueFS.cc: In function 'int=20
> > > > > BlueFS::_flush_range(BlueFS::FileWriter*, uint64_t, uint64_t)'
> > > > > thread
> > > > > 7faf14fff700 time 2016-08-31 17:55:56.934282
> > > > > os/bluestore/BlueFS.cc: 1390: FAILED assert(h->file->fnode.ino=20
> > > > > !=3D
> > > > > 1)
> > > > >=20
> > > > >  ceph version 11.0.0-1946-g9a5cfe2
> > > > > (9a5cfe2e8e8c79b976c34e593993d74b58fce885)
> > > > >  1: (ceph::__ceph_assert_fail(char const*, char const*, int,=20
> > > > > char
> > > > > const*)+0x80) [0x56073c27c7d0]
> > > > >  2: (BlueFS::_flush_range(BlueFS::FileWriter*, unsigned long,=20
> > > > > unsigned
> > > > > long)+0x1d69) [0x56073bf4e109]
> > > > >  3: (BlueFS::_flush(BlueFS::FileWriter*, bool)+0xa7)=20
> > > > > [0x56073bf4e2d7]
> > > > >  4: (BlueFS::_flush_and_sync_log(std::unique_lock<std::mutex>&,
> > > > > unsigned long, unsigned long)+0x443) [0x56073bf4fe13]
> > > > >  5: (BlueFS::_fsync(BlueFS::FileWriter*,
> > > > > std::unique_lock<std::mutex>&)+0x35b) [0x56073bf5140b]
> > > > >  6: (BlueRocksWritableFile::Sync()+0x62) [0x56073bf68be2]
> > > > >  7: (rocksdb::WritableFileWriter::SyncInternal(bool)+0x2d1)
> > > > > [0x56073c0f24b1]
> > > > >  8: (rocksdb::WritableFileWriter::Sync(bool)+0xf0)
> > > > > [0x56073c0f3960]
> > > > >  9:=20
> > > > > (rocksdb::CompactionJob::FinishCompactionOutputFile(rocksdb::Sta
> > > > > tu s const&, rocksdb::CompactionJob::SubcompactionState*)+0x4e6)
> > > > > [0x56073c1354c6]
> > > > >  10:=20
> > > > > (rocksdb::CompactionJob::ProcessKeyValueCompaction(rocksdb::Comp
> > > > > ac
> > > > > ti
> > > > > on
> > > > > Job::SubcompactionState*)+0x14ea) [0x56073c137c8a]
> > > > >  11: (rocksdb::CompactionJob::Run()+0x479) [0x56073c138c09]
> > > > >  12: (rocksdb::DBImpl::BackgroundCompaction(bool*,
> > > > > rocksdb::JobContext*, rocksdb::LogBuffer*, void*)+0x9c0)=20
> > > > > [0x56073c0275d0]
> > > > >  13: (rocksdb::DBImpl::BackgroundCallCompaction(void*)+0xbf)
> > > > > [0x56073c03443f]
> > > > >  14: (rocksdb::ThreadPool::BGThread(unsigned long)+0x1d9)=20
> > > > > [0x56073c0eb039]
> > > > >  15: (()+0x9900d3) [0x56073c0eb0d3]
> > > > >  16: (()+0x76fa) [0x7faf3d1106fa]
> > > > >  17: (clone()+0x6d) [0x7faf3af70b5d]
> > > > >=20
> > > > >=20
> > > > > Now, as you can see it is calling _flush() with inode 1 , why ? i=
s this expected ?
> > > >=20
> > > > Yes.  The metadata for the log file is dirty (the file size changed=
), so bluefs is flushing it's journal (ino 1) to update the fnode.
> > > >=20
> > > > But this is very concerning:
> > > >=20
> > > > >     -2> 2016-08-31 17:55:56.934257 7faf14fff700 10 bluefs _flush
> > > > > 0x7faf2e824140 0xce9000~50f000 to file(ino 1 size 0xce9000 mtime
> > > > > 0.000000 bdev 0 extents [0:0xba00000+500000,0:0xfd00000+c00000])
> > > >=20
> > > > 0xce9000~50f000 is a ~5 MB write.  Why would we ever write that muc=
h to the bluefs metadata journal at once?  That's why it's blowign the runw=
ay. =20
> > > > We have ~17MB allocated (0:0xba00000+500000,0:0xfd00000+c00000), we=
're at offset ~13MB, and we're writing ~5MB.
> > > >=20
> > > > > Question :
> > > > > ------------
> > > > >=20
> > > > > 1. Why we are using the existing log_write to do a runway check ?
> > > > >=20
> > > > > https://github.com/ceph/ceph/blob/master/src/os/bluestore/BlueFS
> > > > > .c
> > > > > c#
> > > > > L1
> > > > > 280
> > > > >=20
> > > > > Shouldn't the log_writer needs to be reinitialed with the FileWri=
ter rocksdb sent with sync call ?
> > > >=20
> > > > It's the bluefs journal writer.. that's the runway we're worried ab=
out.
> > > >=20
> > > > > 2. The runway check is not considering the request length , so,=20
> > > > > why it is not expecting to allocate here=20
> > > > > (https://github.com/ceph/ceph/blob/master/src/os/bluestore/BlueFS=
.
> > > > > cc
> > > > > #L
> > > > > 1388)
> > > > >=20
> > > > > If the snippet is not sufficient, let me know if you want me to u=
pload the level 10 log or need 20/20 log to proceed further.
> > > >=20
> > > > The level 10 log is probably enough...
> > > >=20
> > > > Thanks!
> > > > sage
> > > >=20
> > > > >=20
> > > > > Thanks & Regards
> > > > > Somnath
> > > > >=20
> > > > >=20
> > > > > -----Original Message-----
> > > > > From: Somnath Roy
> > > > > Sent: Thursday, September 01, 2016 3:59 PM
> > > > > To: 'Sage Weil'
> > > > > Cc: Mark Nelson; ceph-devel
> > > > > Subject: RE: Bluestore assert
> > > > >=20
> > > > > Sage,
> > > > > Created the following pull request on rocksdb repo, please take a=
 look.
> > > > >=20
> > > > > https://github.com/facebook/rocksdb/pull/1313
> > > > >=20
> > > > > The fix is working fine for me.
> > > > >=20
> > > > > Thanks & Regards
> > > > > Somnath
> > > > >=20
> > > > > -----Original Message-----
> > > > > From: Sage Weil [mailto:sweil@redhat.com]
> > > > > Sent: Wednesday, August 31, 2016 6:20 AM
> > > > > To: Somnath Roy
> > > > > Cc: Mark Nelson; ceph-devel
> > > > > Subject: RE: Bluestore assert
> > > > >=20
> > > > > On Tue, 30 Aug 2016, Somnath Roy wrote:
> > > > > > Sage,
> > > > > > I did some debugging on the rocksdb bug., here is my findings.
> > > > > >=20
> > > > > > 1. The log file number is added to log_recycle_files and *not* =
in log_delete_files from the following if loop, which is expected.
> > > > > >=20
> > > > > > https://github.com/facebook/rocksdb/blob/56dd03411534d0957a6f6
> > > > > > 98
> > > > > > f4
> > > > > > 60
> > > > > > 60
> > > > > > 9bf7cea4b63/db/db_impl.cc#L854
> > > > > >=20
> > > > > > 2. But, it is there in the candidate list in the following loop=
.
> > > > > >=20
> > > > > > https://github.com/facebook/rocksdb/blob/56dd03411534d0957a6f6
> > > > > > 98
> > > > > > f4
> > > > > > 60
> > > > > > 60
> > > > > > 9bf7cea4b63/db/db_impl.cc#L1000
> > > > > >=20
> > > > > >=20
> > > > > > 3. This means it is added in full_scan_candidate_files from=20
> > > > > > the following  from a full scan (?)
> > > > > >=20
> > > > > > https://github.com/facebook/rocksdb/blob/56dd03411534d0957a6f6
> > > > > > 98
> > > > > > f4
> > > > > > 60
> > > > > > 60
> > > > > > 9bf7cea4b63/db/db_impl.cc#L834
> > > > > >=20
> > > > > > Added some log entries to verify , need to wait 6 hours :-(
> > > > > >=20
> > > > > > 4. Probably, #3 is not unusual , but the check in the following=
 seems not sufficient to keep the file.
> > > > > >=20
> > > > > > https://github.com/facebook/rocksdb/blob/56dd03411534d0957a6f6
> > > > > > 98
> > > > > > f4
> > > > > > 60
> > > > > > 60
> > > > > > 9bf7cea4b63/db/db_impl.cc#L1013
> > > > > >=20
> > > > > > Again, added some log to see the state.log_number during that t=
ime. BTW, I have seen the following check probably noop as state.prev_log_n=
umber is always coming 0.
> > > > > >=20
> > > > > > (number =3D=3D state.prev_log_number)
> > > > > >=20
> > > > > > 5. So, the quick solution I am thinking is to put a check to se=
e if the log is in recycle list and avoid deleting from the above part (?).
> > > > >=20
> > > > > That seems reasonable.  I suggest coding this up and submitting a=
 PR to github.com/facebook/rocksdb, and ask in the comment if there is a be=
tter solution.
> > > > >=20
> > > > > Probably the recycle list should be turned into a set so that the=
 check is O(log n)...
> > > > >=20
> > > > > Thanks!
> > > > > sage
> > > > >=20
> > > > >=20
> > > > > >=20
> > > > > > Let me know what you think.
> > > > > >=20
> > > > > > Thanks & Regards
> > > > > > Somnath
> > > > > > -----Original Message-----
> > > > > > From: Somnath Roy
> > > > > > Sent: Sunday, August 28, 2016 7:37 AM
> > > > > > To: 'Sage Weil'
> > > > > > Cc: 'Mark Nelson'; 'ceph-devel'
> > > > > > Subject: RE: Bluestore assert
> > > > > >=20
> > > > > > Sage,
> > > > > > Some updates on this.
> > > > > >=20
> > > > > > 1. The issue is reproduced with the latest rocksdb master as we=
ll.
> > > > > >=20
> > > > > > 2. The issue is *not happening* if I run disabling rocksdb log =
recycling. This proves our root cause is right.
> > > > > >=20
> > > > > > 3. Running some more performance tests by disabling log recycli=
ng , but, initial impression is, it is introducing spikes and output is not=
 as stable as enabling log recycling.
> > > > > >=20
> > > > > > 4. Created a rocksdb issue for this
> > > > > > (https://github.com/facebook/rocksdb/issues/1303)
> > > > > >=20
> > > > > > Thanks & Regards
> > > > > > Somnath
> > > > > >=20
> > > > > >=20
> > > > > > -----Original Message-----
> > > > > > From: Somnath Roy
> > > > > > Sent: Thursday, August 25, 2016 2:35 PM
> > > > > > To: 'Sage Weil'
> > > > > > Cc: 'Mark Nelson'; 'ceph-devel'
> > > > > > Subject: RE: Bluestore assert
> > > > > >=20
> > > > > > Sage,
> > > > > > Hope you are able to download the log I shared via google doc.
> > > > > > It seems the bug is around this portion.
> > > > > >=20
> > > > > > 2016-08-25 00:44:03.348710 7f7c117ff700  4 rocksdb: adding log
> > > > > > 254 to recycle list
> > > > > >=20
> > > > > > 2016-08-25 00:44:03.348722 7f7c117ff700  4 rocksdb: adding log
> > > > > > 256 to recycle list
> > > > > >=20
> > > > > > 2016-08-25 00:44:03.348725 7f7c117ff700  4 rocksdb: (Original=20
> > > > > > Log Time
> > > > > > 2016/08/25-00:44:03.347467) [default] Level-0 commit table
> > > > > > #258 started
> > > > > > 2016-08-25 00:44:03.348727 7f7c117ff700  4 rocksdb: (Original=20
> > > > > > Log Time
> > > > > > 2016/08/25-00:44:03.348225) [default] Level-0 commit table #258=
:=20
> > > > > > memtable #1 done
> > > > > > 2016-08-25 00:44:03.348729 7f7c117ff700  4 rocksdb: (Original=20
> > > > > > Log Time
> > > > > > 2016/08/25-00:44:03.348227) [default] Level-0 commit table #258=
:=20
> > > > > > memtable #2 done
> > > > > > 2016-08-25 00:44:03.348730 7f7c117ff700  4 rocksdb: (Original=20
> > > > > > Log Time
> > > > > > 2016/08/25-00:44:03.348239) EVENT_LOG_v1 {"time_micros":=20
> > > > > > 1472111043348233, "job": 88, "event": "flush_finished", "lsm_st=
ate":=20
> > > > > > [3, 4, 0, 0, 0, 0, 0], "immutable_memtables": 0}
> > > > > > 2016-08-25 00:44:03.348735 7f7c117ff700  4 rocksdb: (Original=20
> > > > > > Log Time
> > > > > > 2016/08/25-00:44:03.348297) [default] Level summary: base=20
> > > > > > level
> > > > > > 1 max bytes base 5368709120 files[3 4 0 0 0 0 0] max score
> > > > > > 0.75
> > > > > >=20
> > > > > > 2016-08-25 00:44:03.348751 7f7c117ff700  4 rocksdb: [JOB 88] Tr=
y to delete WAL files size 131512372, prev total WAL file size 131834601, n=
umber of live WAL files 3.
> > > > > >=20
> > > > > > 2016-08-25 00:44:03.348761 7f7c117ff700 10 bluefs unlink=20
> > > > > > db.wal/000256.log
> > > > > > 2016-08-25 00:44:03.348766 7f7c117ff700 20 bluefs _drop_link=20
> > > > > > had refs
> > > > > > 1 on file(ino 19 size 0x3f3ddd9 mtime 2016-08-25
> > > > > > 00:41:26.298423 bdev
> > > > > > 0 extents
> > > > > > [0:0xc500000+200000,0:0xcb00000+800000,0:0xd700000+700000,0:0x
> > > > > > e2
> > > > > > 00
> > > > > > 00
> > > > > > 0+
> > > > > > 800000,0:0xee00000+800000,0:0xfa00000+800000,0:0x10600000+7000
> > > > > > 00
> > > > > > ,0
> > > > > > :0
> > > > > > x1
> > > > > > 1100000+700000,0:0x11c00000+800000,0:0x12800000+100000])
> > > > > > 2016-08-25 00:44:03.348775 7f7c117ff700 20 bluefs _drop_link=20
> > > > > > destroying file(ino 19 size 0x3f3ddd9 mtime 2016-08-25
> > > > > > 00:41:26.298423 bdev 0 extents=20
> > > > > > [0:0xc500000+200000,0:0xcb00000+800000,0:0xd700000+700000,0:0x
> > > > > > e2
> > > > > > 00
> > > > > > 00
> > > > > > 0+
> > > > > > 800000,0:0xee00000+800000,0:0xfa00000+800000,0:0x10600000+7000
> > > > > > 00
> > > > > > ,0
> > > > > > :0
> > > > > > x1
> > > > > > 1100000+700000,0:0x11c00000+800000,0:0x12800000+100000])
> > > > > > 2016-08-25 00:44:03.348794 7f7c117ff700 10 bluefs unlink=20
> > > > > > db.wal/000254.log
> > > > > > 2016-08-25 00:44:03.348796 7f7c117ff700 20 bluefs _drop_link=20
> > > > > > had refs
> > > > > > 1 on file(ino 18 size 0x3f3d402 mtime 2016-08-25
> > > > > > 00:41:26.299110 bdev
> > > > > > 0 extents
> > > > > > [0:0x6500000+400000,0:0x6d00000+700000,0:0x7800000+800000,0:0x
> > > > > > 84
> > > > > > 00
> > > > > > 00
> > > > > > 0+
> > > > > > 800000,0:0x9000000+800000,0:0x9c00000+700000,0:0xa700000+900000=
,0:
> > > > > > 0x
> > > > > > b4
> > > > > > 00000+800000,0:0xc000000+500000])
> > > > > > 2016-08-25 00:44:03.348803 7f7c117ff700 20 bluefs _drop_link=20
> > > > > > destroying file(ino 18 size 0x3f3d402 mtime 2016-08-25
> > > > > > 00:41:26.299110 bdev 0 extents=20
> > > > > > [0:0x6500000+400000,0:0x6d00000+700000,0:0x7800000+800000,0:0x
> > > > > > 84
> > > > > > 00
> > > > > > 00
> > > > > > 0+
> > > > > > 800000,0:0x9000000+800000,0:0x9c00000+700000,0:0xa700000+900000=
,0:
> > > > > > 0x
> > > > > > b4
> > > > > > 00000+800000,0:0xc000000+500000])
> > > > > >=20
> > > > > > So, log 254 is added to the recycle list and at the same time i=
t is added for deletion. It seems there is a race condition in this portion=
 (?).
> > > > > >=20
> > > > > > I was going through the rocksdb code and I found the following.
> > > > > >=20
> > > > > > 1. DBImpl::FindObsoleteFiles is the one that is responsible for=
 populating log_recycle_files and log_delete_files. It is also deleting ent=
ries from alive_log_files_. But, this is always under mutex_ lock.
> > > > > >=20
> > > > > > 2. Log is deleted from DBImpl::DeleteObsoleteFileImpl which is =
*not* under lock , but iterating over log_delete_files. This is fishy but i=
t shouldn't be the reason for same log number end up in two list.
> > > > > >=20
> > > > > > 3. I saw all the places but the following  place alive_log_file=
s_ (within DBImpl::WriteImpl)  is accessed without lock.
> > > > > >=20
> > > > > > 4625       alive_log_files_.back().AddSize(log_entry.size());  =
=20
> > > > > >=20
> > > > > > Can it be reintroducing the same log number (254) , I am not su=
re.
> > > > > >=20
> > > > > > Summary, it seems a rocksb bug and making recycle_log_file_num =
=3D 0 should *bypass* that. I need to check the performance impact for this=
 though.
> > > > > >=20
> > > > > > Should I post this to rocksdb community or any other place from=
 where I can get response from rocksdb folks ?
> > > > > >=20
> > > > > > Thanks & Regards
> > > > > > Somnath
> > > > > >=20
> > > > > >=20
> > > > > > -----Original Message-----
> > > > > > From: Somnath Roy
> > > > > > Sent: Wednesday, August 24, 2016 2:52 PM
> > > > > > To: 'Sage Weil'
> > > > > > Cc: Mark Nelson; ceph-devel
> > > > > > Subject: RE: Bluestore assert
> > > > > >=20
> > > > > > Sage,
> > > > > > Thanks for looking , glad that we figured out something :-)..
> > > > > > So, you want me to reproduce this with only debug_bluefs =3D 20=
/20 ? Don't need bluestore log ?
> > > > > > Hope my root partition doesn't get full , this crash happened=20
> > > > > > after
> > > > > > 6 hours :-) ,
> > > > > >=20
> > > > > > Thanks & Regards
> > > > > > Somnath
> > > > > >=20
> > > > > > -----Original Message-----
> > > > > > From: Sage Weil [mailto:sweil@redhat.com]
> > > > > > Sent: Wednesday, August 24, 2016 2:34 PM
> > > > > > To: Somnath Roy
> > > > > > Cc: Mark Nelson; ceph-devel
> > > > > > Subject: RE: Bluestore assert
> > > > > >=20
> > > > > > On Wed, 24 Aug 2016, Somnath Roy wrote:
> > > > > > > Sage, It is there in the following github link I posted=20
> > > > > > > earlier..You can see 3 logs there..
> > > > > > >=20
> > > > > > > https://github.com/somnathr/ceph/commit/b69811eb2b87f25cf017
> > > > > > > b3
> > > > > > > 9c
> > > > > > > 68
> > > > > > > 7d
> > > > > > > 88
> > > > > > > a1b28fcc39
> > > > > >=20
> > > > > > Ah sorry, got it.
> > > > > >=20
> > > > > > And looking at the crash and code the weird error you're gettin=
g makes perfect sense: it's coming from the ReuseWritableFile() function (w=
hich gets and error on rename and returns that).  It shouldn't ever fail, s=
o there is either a bug in the bluefs code or the rocksdb recycling code.
> > > > > >=20
> > > > > > I think we need a full bluefs log leading up to the crash so we=
 can find out what happened to the file that is missing...
> > > > > >=20
> > > > > > sage
> > > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > >  >
> > > > > > > Thanks & Regards
> > > > > > > Somnath
> > > > > > >=20
> > > > > > >=20
> > > > > > > -----Original Message-----
> > > > > > > From: Sage Weil [mailto:sweil@redhat.com]
> > > > > > > Sent: Wednesday, August 24, 2016 1:43 PM
> > > > > > > To: Somnath Roy
> > > > > > > Cc: Mark Nelson; ceph-devel
> > > > > > > Subject: RE: Bluestore assert
> > > > > > >=20
> > > > > > > On Wed, 24 Aug 2016, Somnath Roy wrote:
> > > > > > > > Sage,
> > > > > > > > I got the db assert log from submit_transaction in the foll=
owing location.
> > > > > > > >=20
> > > > > > > > https://github.com/somnathr/ceph/commit/b69811eb2b87f25cf0
> > > > > > > > 17
> > > > > > > > b3
> > > > > > > > 9c
> > > > > > > > 68
> > > > > > > > 7d
> > > > > > > > 88
> > > > > > > > a1b28fcc39
> > > > > > > >=20
> > > > > > > > This is the log with level 1/20 and with my hook of printin=
g rocksdb::writebatch transaction. I have uploaded 3 osd logs and a common =
pattern before crash is the following.
> > > > > > > >=20
> > > > > > > >    -34> 2016-08-24 02:37:22.074321 7ff151fff700  4 rocksdb:=
=20
> > > > > > > > reusing log 266 from recycle list
> > > > > > > >=20
> > > > > > > >    -33> 2016-08-24 02:37:22.074332 7ff151fff700 10 bluefs r=
ename db.wal/000266.log -> db.wal/000271.log
> > > > > > > >    -32> 2016-08-24 02:37:22.074338 7ff151fff700 20 bluefs r=
ename dir db.wal (0x7ff18bdfdec0) file 000266.log not found
> > > > > > > >    -31> 2016-08-24 02:37:22.074341 7ff151fff700  4 rocksdb:=
 [default] New memtable created with log file: #271. Immutable memtables: 0=
.
> > > > > > > >=20
> > > > > > > > It is trying to rename the wal file it seems and old file i=
s not found. You can see the transaction printed in the log along with erro=
r code like this.
> > > > > > >=20
> > > > > > > How much of the log do you have? Can you post what you have s=
omewhere?
> > > > > > >=20
> > > > > > > Thanks!
> > > > > > > sage
> > > > > > >=20
> > > > > > >=20
> > > > > > > >=20
> > > > > > > >    -30> 2016-08-24 02:37:22.074486 7ff151fff700 -1 rocksdb:=
=20
> > > > > > > > submit_transaction error: NotFound:  code =3D 1=20
> > > > > > > > rocksdb::WriteBatch =3D Put( Prefix =3D M key =3D
> > > > > > > > 0x0000000000001483'.0000000087.00000000000000035303')
> > > > > > > > Put( Prefix =3D M key =3D 0x0000000000001483'._info') Put(=
=20
> > > > > > > > Prefix =3D O key =3D
> > > > > > > > '--'0x800000000000000137863de5'.!=3Drbd_data.105b6b8b4567.0=
0
> > > > > > > > 00
> > > > > > > > 00
> > > > > > > > 00
> > > > > > > > 00
> > > > > > > > 89
> > > > > > > > ac
> > > > > > > > e7!'0xfffffffffffffffeffffffffffffffff)
> > > > > > > > Delete( Prefix =3D B key =3D 0x000004e73ae72000) Put( Prefi=
x =3D=20
> > > > > > > > B key =3D
> > > > > > > > 0x000004e73af72000) Merge( Prefix =3D T key =3D
> > > > > > > > 'bluestore_statfs')
> > > > > > > >=20
> > > > > > > > Hope my decoding of the key is proper, I have reused pretty=
_binary_string() of Bluestore after removing 1st 2 bytes of the key which i=
s prefix and a '0'.
> > > > > > > >=20
> > > > > > > > Any suggestion on the next step of root causing this db ass=
ert if log rename is not enough hint ?
> > > > > > > >=20
> > > > > > > > BTW, I ran this time with bluefs_compact_log_sync =3D true =
and without commenting the inode number asserts. I didn't hit those asserts=
 as well as no corruption  so far. Seems like bug of async compaction. Will=
 try to reproduce with verbose log that one later.
> > > > > > > >=20
> > > > > > > > Thanks & Regards
> > > > > > > > Somnath
> > > > > > > >=20
> > > > > > > > -----Original Message-----
> > > > > > > > From: Somnath Roy
> > > > > > > > Sent: Tuesday, August 23, 2016 7:46 AM
> > > > > > > > To: 'Sage Weil'
> > > > > > > > Cc: Mark Nelson; ceph-devel
> > > > > > > > Subject: RE: Bluestore assert
> > > > > > > >=20
> > > > > > > > I was running my tests for 2 hours and it happened within t=
hat time.
> > > > > > > > I will try to reproduce with 1/20.
> > > > > > > >=20
> > > > > > > > Thanks & Regards
> > > > > > > > Somnath
> > > > > > > >=20
> > > > > > > > -----Original Message-----
> > > > > > > > From: Sage Weil [mailto:sweil@redhat.com]
> > > > > > > > Sent: Tuesday, August 23, 2016 6:46 AM
> > > > > > > > To: Somnath Roy
> > > > > > > > Cc: Mark Nelson; ceph-devel
> > > > > > > > Subject: RE: Bluestore assert
> > > > > > > >=20
> > > > > > > > On Mon, 22 Aug 2016, Somnath Roy wrote:
> > > > > > > > > Sage,
> > > > > > > > > I think there are some bug introduced recently in the=20
> > > > > > > > > BlueFS and I am getting the corruption like this which I =
was not facing earlier.
> > > > > > > >=20
> > > > > > > > My guess is the async bluefs compaction.  You can set 'blue=
fs compact log sync =3D true' to disable it.
> > > > > > > >=20
> > > > > > > > Any idea how long do you have to run to reproduce?  I'd lov=
e to see a bluefs log leading up to it.  If it eats too much disk space, yo=
u could do debug bluefs =3D 1/20 so that it only dumps recent history on cr=
ash.
> > > > > > > >=20
> > > > > > > > Thanks!
> > > > > > > > sage
> > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > >    -5> 2016-08-22 15:55:21.248558 7fb68f7ff700  4 rocksdb=
: EVENT_LOG_v1 {"time_micros": 1471906521248538, "job": 3, "event": "compac=
tion_started", "files_L0": [2115, 2102, 2087, 2069, 2046], "files_L1": [], =
"files_L2": [], "files_L3": [], "files_L4": [], "files_L5": [], "files_L6":=
 [1998, 2007, 2013, 2019, 2026, 2032, 2039, 2043, 2052, 2060], "score": 1.5=
, "input_data_size": 1648188401}
> > > > > > > > >     -4> 2016-08-22 15:55:27.209944 7fb6ba94d8c0  0 <cls> =
cls/hello/cls_hello.cc:305: loading cls_hello
> > > > > > > > >     -3> 2016-08-22 15:55:27.213612 7fb6ba94d8c0  0 <cls> =
cls/cephfs/cls_cephfs.cc:202: loading cephfs_size_scan
> > > > > > > > >     -2> 2016-08-22 15:55:27.213627 7fb6ba94d8c0  0 _get_c=
lass not permitted to load kvs
> > > > > > > > >     -1> 2016-08-22 15:55:27.214620 7fb6ba94d8c0 -1 osd.0 =
0 failed to load OSD map for epoch 321, got 0 bytes
> > > > > > > > >      0> 2016-08-22 15:55:27.216111 7fb6ba94d8c0 -1 osd/OS=
D.h:=20
> > > > > > > > > In function 'OSDMapRef OSDService::get_map(epoch_t)'=20
> > > > > > > > > thread
> > > > > > > > > 7fb6ba94d8c0 time 2016-08-22 15:55:27.214638
> > > > > > > > > osd/OSD.h: 999: FAILED assert(ret)
> > > > > > > > >=20
> > > > > > > > >  ceph version 11.0.0-1688-g6f48ee6
> > > > > > > > > (6f48ee6bc5c85f44d7ca4c984f9bef1339c2bea4)
> > > > > > > > >  1: (ceph::__ceph_assert_fail(char const*, char const*,=20
> > > > > > > > > int, char
> > > > > > > > > const*)+0x80) [0x5617f2a99e80]
> > > > > > > > >  2: (OSDService::get_map(unsigned int)+0x5d)=20
> > > > > > > > > [0x5617f2395fdd]
> > > > > > > > >  3: (OSD::init()+0x1f7e) [0x5617f233d3ce]
> > > > > > > > >  4: (main()+0x2fe0) [0x5617f229d1f0]
> > > > > > > > >  5: (__libc_start_main()+0xf0) [0x7fb6b7196830]
> > > > > > > > >  6: (_start()+0x29) [0x5617f22eb909]
> > > > > > > > >=20
> > > > > > > > > OSDs are not coming up (after a restart) and eventually I=
 had to recreate the cluster.
> > > > > > > > >=20
> > > > > > > > > Thanks & Regards
> > > > > > > > > Somnath
> > > > > > > > >=20
> > > > > > > > > -----Original Message-----
> > > > > > > > > From: Somnath Roy
> > > > > > > > > Sent: Monday, August 22, 2016 3:01 PM
> > > > > > > > > To: 'Sage Weil'
> > > > > > > > > Cc: Mark Nelson; ceph-devel
> > > > > > > > > Subject: RE: Bluestore assert
> > > > > > > > >=20
> > > > > > > > > "compaction_style=3DkCompactionStyleUniversal"  in the bl=
uestore_rocksdb_options .
> > > > > > > > > Here is the option I am using..
> > > > > > > > >=20
> > > > > > > > >         bluestore_rocksdb_options =3D "max_write_buffer_n=
umber=3D16,min_write_buffer_number_to_merge=3D2,recycle_log_file_num=3D16,c=
ompaction_threads=3D32,flusher_threads=3D8,max_background_compactions=3D32,=
max_background_flushes=3D8,max_bytes_for_level_base=3D5368709120,write_buff=
er_size=3D83886080,level0_file_num_compaction_trigger=3D4,level0_slowdown_w=
rites_trigger=3D400,level0_stop_writes_trigger=3D800,stats_dump_period_sec=
=3D10,compaction_style=3DkCompactionStyleUniversal"
> > > > > > > > >=20
> > > > > > > > > Here is another one after 4 hours of 4K RW :-)...Sorry to=
 bombard you with all these , I am adding more log for the next time if I h=
it it..
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > >      0> 2016-08-22 17:37:24.730817 7f8e7afff700 -1
> > > > > > > > > os/bluestore/BlueFS.cc: In function 'int=20
> > > > > > > > > BlueFS::_read_random(BlueFS::FileReader*, uint64_t, size_=
t, char*)'
> > > > > > > > > thread 7f8e7afff700 time 2016-08-22 17:37:24.722706
> > > > > > > > > os/bluestore/BlueFS.cc: 845: FAILED assert(r =3D=3D 0)
> > > > > > > > >=20
> > > > > > > > >  ceph version 11.0.0-1688-g3fcc89c
> > > > > > > > > (3fcc89c7ab4c92e6c4564e29f4e1a663db36acc0)
> > > > > > > > >  1: (ceph::__ceph_assert_fail(char const*, char const*,=20
> > > > > > > > > int, char
> > > > > > > > > const*)+0x80) [0x5581ed453cb0]
> > > > > > > > >  2: (BlueFS::_read_random(BlueFS::FileReader*, unsigned=20
> > > > > > > > > long, unsigned long, char*)+0x836) [0x5581ed11c1b6]
> > > > > > > > >  3: (BlueRocksRandomAccessFile::Read(unsigned long,=20
> > > > > > > > > unsigned long, rocksdb::Slice*, char*) const+0x20)=20
> > > > > > > > > [0x5581ed13f840]
> > > > > > > > >  4: (rocksdb::RandomAccessFileReader::Read(unsigned
> > > > > > > > > long, unsigned long, rocksdb::Slice*, char*)
> > > > > > > > > const+0x83f) [0x5581ed2c6f4f]
> > > > > > > > >  5:=20
> > > > > > > > > (rocksdb::ReadBlockContents(rocksdb::RandomAccessFileRea
> > > > > > > > > de
> > > > > > > > > r* , rocksdb::Footer const&, rocksdb::ReadOptions=20
> > > > > > > > > const&, rocksdb::BlockHandle const&,=20
> > > > > > > > > rocksdb::BlockContents*, rocksdb::Env*, bool,=20
> > > > > > > > > rocksdb::Slice const&, rocksdb::PersistentCacheOptions=20
> > > > > > > > > const&,
> > > > > > > > > rocksdb::Logger*)+0x358) [0x5581ed291c18]
> > > > > > > > >  6: (()+0x94fd54) [0x5581ed282d54]
> > > > > > > > >  7:=20
> > > > > > > > > (rocksdb::BlockBasedTable::NewDataBlockIterator(rocksdb:
> > > > > > > > > :B lo ck Ba se dT ab le::Rep*, rocksdb::ReadOptions=20
> > > > > > > > > const&, rocksdb::Slice const&,
> > > > > > > > > rocksdb::BlockIter*)+0x60c) [0x5581ed284b3c]
> > > > > > > > >  8: (rocksdb::BlockBasedTable::Get(rocksdb::ReadOptions
> > > > > > > > > const&, rocksdb::Slice const&, rocksdb::GetContext*,
> > > > > > > > > bool)+0x508) [0x5581ed28ba68]
> > > > > > > > >  9: (rocksdb::TableCache::Get(rocksdb::ReadOptions
> > > > > > > > > const&, rocksdb::InternalKeyComparator const&,=20
> > > > > > > > > rocksdb::FileDescriptor const&, rocksdb::Slice const&,=20
> > > > > > > > > rocksdb::GetContext*, rocksdb::HistogramImpl*, bool,
> > > > > > > > > int)+0x158) [0x5581ed252118]
> > > > > > > > >  10: (rocksdb::Version::Get(rocksdb::ReadOptions const&,=
=20
> > > > > > > > > rocksdb::LookupKey const&,=20
> > > > > > > > > std::__cxx11::basic_string<char, std::char_traits<char>,=
=20
> > > > > > > > > std::allocator<char> >*, rocksdb::Status*,=20
> > > > > > > > > rocksdb::MergeContext*, bool*, bool*, unsigned
> > > > > > > > > long*)+0x4f8) [0x5581ed25c458]
> > > > > > > > >  11: (rocksdb::DBImpl::GetImpl(rocksdb::ReadOptions
> > > > > > > > > const&, rocksdb::ColumnFamilyHandle*, rocksdb::Slice=20
> > > > > > > > > const&, std::__cxx11::basic_string<char,=20
> > > > > > > > > std::char_traits<char>, std::allocator<char> >*,
> > > > > > > > > bool*)+0x5fa) [0x5581ed1f3f7a]
> > > > > > > > >  12: (rocksdb::DBImpl::Get(rocksdb::ReadOptions const&,=20
> > > > > > > > > rocksdb::ColumnFamilyHandle*, rocksdb::Slice const&,=20
> > > > > > > > > std::__cxx11::basic_string<char, std::char_traits<char>,=
=20
> > > > > > > > > std::allocator<char> >*)+0x22) [0x5581ed1f4182]
> > > > > > > > >  13: (RocksDBStore::get(std::__cxx11::basic_string<char,
> > > > > > > > > std::char_traits<char>, std::allocator<char> > const&,=20
> > > > > > > > > std::__cxx11::basic_string<char, std::char_traits<char>,=
=20
> > > > > > > > > std::allocator<char> > const&,
> > > > > > > > > ceph::buffer::list*)+0x157) [0x5581ed1d21d7]
> > > > > > > > >  14: (BlueStore::Collection::get_onode(ghobject_t
> > > > > > > > > const&,
> > > > > > > > > bool)+0x55b) [0x5581ed02802b]
> > > > > > > > >  15:=20
> > > > > > > > > (BlueStore::_txc_add_transaction(BlueStore::TransContext
> > > > > > > > > *,
> > > > > > > > > ObjectStore::Transaction*)+0x1e49) [0x5581ed0318a9]
> > > > > > > > >  16:=20
> > > > > > > > > (BlueStore::queue_transactions(ObjectStore::Sequencer*,
> > > > > > > > > std::vector<ObjectStore::Transaction,
> > > > > > > > > std::allocator<ObjectStore::Transaction> >&,=20
> > > > > > > > > std::shared_ptr<TrackedOp>,
> > > > > > > > > ThreadPool::TPHandle*)+0x362) [0x5581ed032bc2]
> > > > > > > > >  17:=20
> > > > > > > > > (ReplicatedPG::queue_transactions(std::vector<ObjectStore=
:
> > > > > > > > > :T ra ns ac ti on ,
> > > > > > > > > std::allocator<ObjectStore::Transaction>
> > > > > > > > > >&,
> > > > > > > > > std::shared_ptr<OpRequest>)+0x81) [0x5581ecea5e51]
> > > > > > > > >  18:=20
> > > > > > > > > (ReplicatedBackend::sub_op_modify(std::shared_ptr<OpRequ
> > > > > > > > > es
> > > > > > > > > t>
> > > > > > > > > )+
> > > > > > > > > 0x
> > > > > > > > > d3
> > > > > > > > > 9)
> > > > > > > > > [0x5581ecef89e9]
> > > > > > > > >  19:=20
> > > > > > > > > (ReplicatedBackend::handle_message(std::shared_ptr<OpReq
> > > > > > > > > ue
> > > > > > > > > st
> > > > > > > > > >)
> > > > > > > > > +0
> > > > > > > > > x2
> > > > > > > > > fb
> > > > > > > > > )
> > > > > > > > > [0x5581ecefeb4b]
> > > > > > > > >  20:=20
> > > > > > > > > (ReplicatedPG::do_request(std::shared_ptr<OpRequest>&,
> > > > > > > > > ThreadPool::TPHandle&)+0xbd) [0x5581ece4c63d]
> > > > > > > > >  21: (OSD::dequeue_op(boost::intrusive_ptr<PG>,
> > > > > > > > > std::shared_ptr<OpRequest>,
> > > > > > > > > ThreadPool::TPHandle&)+0x409) [0x5581eccdd2e9]
> > > > > > > > >  22:=20
> > > > > > > > > (PGQueueable::RunVis::operator()(std::shared_ptr<OpReque
> > > > > > > > > st
> > > > > > > > > >
> > > > > > > > > const&)+0x52) [0x5581eccdd542]
> > > > > > > > >  23: (OSD::ShardedOpWQ::_process(unsigned int,
> > > > > > > > > ceph::heartbeat_handle_d*)+0x73f) [0x5581eccfd30f]
> > > > > > > > >  24:=20
> > > > > > > > > (ShardedThreadPool::shardedthreadpool_worker(unsigned
> > > > > > > > > int)+0x89f) [0x5581ed440b2f]
> > > > > > > > >  25:=20
> > > > > > > > > (ShardedThreadPool::WorkThreadSharded::entry()+0x10)
> > > > > > > > > [0x5581ed4441f0]
> > > > > > > > >  26: (Thread::entry_wrapper()+0x75) [0x5581ed4335c5]
> > > > > > > > >  27: (()+0x76fa) [0x7f8ed9e4e6fa]
> > > > > > > > >  28: (clone()+0x6d) [0x7f8ed7caeb5d]
> > > > > > > > >  NOTE: a copy of the executable, or `objdump -rdS <execut=
able>` is needed to interpret this.
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > Thanks & Regards
> > > > > > > > > Somnath
> > > > > > > > >=20
> > > > > > > > > -----Original Message-----
> > > > > > > > > From: Sage Weil [mailto:sweil@redhat.com]
> > > > > > > > > Sent: Monday, August 22, 2016 2:57 PM
> > > > > > > > > To: Somnath Roy
> > > > > > > > > Cc: Mark Nelson; ceph-devel
> > > > > > > > > Subject: RE: Bluestore assert
> > > > > > > > >=20
> > > > > > > > > On Mon, 22 Aug 2016, Somnath Roy wrote:
> > > > > > > > > > FYI, I was running rocksdb by enabling universal style=
=20
> > > > > > > > > > compaction during this time.
> > > > > > > > >=20
> > > > > > > > > How are you selecting universal compaction?
> > > > > > > > >=20
> > > > > > > > > sage
> > > > > > > > > PLEASE NOTE: The information contained in this electronic=
 mail message is intended only for the use of the designated recipient(s) n=
amed above. If the reader of this message is not the intended recipient, yo=
u are hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is str=
ictly prohibited. If you have received this communication in error, please =
notify the sender by telephone or e-mail (as shown above) immediately and d=
estroy any and all copies of this message in your possession (whether hard =
copies or electronically stored copies).
> > > > > > > > > --
> > > > > > > > > To unsubscribe from this list: send the line "unsubscribe=
 ceph-devel"=20
> > > > > > > > > in the body of a message to majordomo@vger.kernel.org=20
> > > > > > > > > More majordomo info at=20
> > > > > > > > > http://vger.kernel.org/majordomo-info.html
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > --
> > > > > > > > To unsubscribe from this list: send the line "unsubscribe c=
eph-devel"=20
> > > > > > > > in the body of a message to majordomo@vger.kernel.org More=
=20
> > > > > > > > majordomo info at=20
> > > > > > > > http://vger.kernel.org/majordomo-info.html
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > --
> > > > > > > To unsubscribe from this list: send the line "unsubscribe cep=
h-devel"=20
> > > > > > > in the body of a message to majordomo@vger.kernel.org More=20
> > > > > > > majordomo info at http://vger.kernel.org/majordomo-info.html
> > > > > > >=20
> > > > > > >=20
> > > > > >=20
> > > > > >=20
> > > > >=20
> > > > >=20
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l"=20
> > > > in the body of a message to majordomo@vger.kernel.org More=20
> > > > majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > >=20
> > > >=20
> > >=20
> > >=20
> >=20
> >=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
