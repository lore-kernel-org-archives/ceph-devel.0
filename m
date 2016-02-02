From: Sage Weil <sage@newdream.net>
Subject: Re: OSD crash when one of the PGs have problem
Date: Tue, 2 Feb 2016 08:25:36 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1602020817330.28963@cpach.fuggernut.com>
References: <BLUPR0201MB190873C2ABA683E6917C6FDAE2C20@BLUPR0201MB1908.namprd02.prod.outlook.com> <alpine.DEB.2.11.1601201032160.4600@cpach.fuggernut.com> <BLUPR0201MB1908F3598E40E0CC0B0152FBE2C20@BLUPR0201MB1908.namprd02.prod.outlook.com>
 <CO1PR02MB2088442793034A5376349AEF4C20@CO1PR02MB208.namprd02.prod.outlook.com> <BLUPR0201MB19088F5F2DA004C0F8896820E2C20@BLUPR0201MB1908.namprd02.prod.outlook.com> <D2C55D0B.AA98%evgeniy.firsov@sandisk.com> <D2C56E87.AB14%evgeniy.firsov@sandisk.com>
 <D2D52FF0.AE48%evgeniy.firsov@sandisk.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42834 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932720AbcBBNZW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Feb 2016 08:25:22 -0500
In-Reply-To: <D2D52FF0.AE48%evgeniy.firsov@sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Evgeniy Firsov <Evgeniy.Firsov@sandisk.com>
Cc: Varada Kari <Varada.Kari@sandisk.com>, Somnath Roy <Somnath.Roy@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 1 Feb 2016, Evgeniy Firsov wrote:
> I filed a PR which fixes the bug: https://github.com/ceph/ceph/pull/7470
> 
> But there are at least two questions which need clarification:
> 1. I expect, and my tests confirm so far, that FileStore::_touch call is
> NOT used on fast path. But there is an opinion that it might.

The depends entirely on the librados client... they might send a 'touch' 
op and expect it to be fast.  We shouldn't do the fdcache.clear() in the 
general case.  Note that simply restarting the OSD clears it, and it is 
pretty unlikely we'll have a directory deleted and repaired on a running 
ceph-osd daemon in quick enough succession to be in the cache anyway.

> 2. Does the fix need write_if_dirty part, which writes metadata besides
> version info, such as epoch? The question is because PG::_init doesn't
> have this part and writes version info only.

It's looks right as-is to me!

sage


> 
> 
> Thank you.
> 
> On 1/20/16, 5:07 PM, "Evgeniy Firsov" <Evgeniy.Firsov@sandisk.com> wrote:
> 
> >The same test case fail with stock Jewel branch too.
> >
> >On 1/20/16, 5:02 PM, "ceph-devel-owner@vger.kernel.org on behalf of
> >Evgeniy Firsov" <ceph-devel-owner@vger.kernel.org on behalf of
> >Evgeniy.Firsov@sandisk.com> wrote:
> >
> >>I am able to reproduce the problem even with current, unmodified master.
> >>
> >>Test case:
> >>1. Start 2 OSDs, 8 PGs, pool size = 2
> >>2. Run write workload for some time.
> >>3. Stop workload
> >>4. rm -rf dev/osd0/current/0.2_head/*
> >>5. ceph osd scrub 0
> >>6. ceph pg repair 0.2
> >>7. Restart OSD.
> >>8. Get "error (17) File exists not handled on operation"
> >>
> >>On 1/20/16, 9:30 AM, "ceph-devel-owner@vger.kernel.org on behalf of
> >>Varada
> >>Kari" <ceph-devel-owner@vger.kernel.org on behalf of
> >>Varada.Kari@sandisk.com> wrote:
> >>
> >>>Somnath,
> >>>
> >>>There are no xfs errors here.
> >>>
> >>>Varada
> >>>
> >>>> -----Original Message-----
> >>>> From: Somnath Roy
> >>>> Sent: Wednesday, January 20, 2016 10:34 PM
> >>>> To: Varada Kari <Varada.Kari@sandisk.com>; Sage Weil
> >>>> <sage@newdream.net>
> >>>> Cc: ceph-devel@vger.kernel.org
> >>>> Subject: RE: OSD crash when one of the PGs have problem
> >>>> 
> >>>> You are saying xfs is throwing errors in the dmesg, so, this could be
> >>>>a
> >>>>reason
> >>>> why ceph is not able to read PG metadata for leveldb->xfs, isn't it ?
> >>>> 
> >>>> Thanks & Regards
> >>>> Somnath
> >>>> 
> >>>> -----Original Message-----
> >>>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> >>>> owner@vger.kernel.org] On Behalf Of Varada Kari
> >>>> Sent: Wednesday, January 20, 2016 8:02 AM
> >>>> To: Sage Weil
> >>>> Cc: ceph-devel@vger.kernel.org
> >>>> Subject: RE: OSD crash when one of the PGs have problem
> >>>> 
> >>>> Yes Sage. Applied Somnath's write path changes on top the jewel branch
> >>>> (two weeks old) and jemalloc. Haven't tried with latest changes
> >>>>though.
> >>>>With
> >>>> the same code, we are not able hit this issue again, when retried.
> >>>>Not
> >>>>sure if
> >>>> we are hitting any race in committing change here.
> >>>> 
> >>>> Varada
> >>>> 
> >>>> > -----Original Message-----
> >>>> > From: Sage Weil [mailto:sage@newdream.net]
> >>>> > Sent: Wednesday, January 20, 2016 9:04 PM
> >>>> > To: Varada Kari <Varada.Kari@sandisk.com>
> >>>> > Cc: ceph-devel@vger.kernel.org
> >>>> > Subject: Re: OSD crash when one of the PGs have problem
> >>>> >
> >>>> > On Wed, 20 Jan 2016, Varada Kari wrote:
> >>>> > > Hi all,
> >>>> > >
> >>>> > >
> >>>> > > Sorry for the long mail. Wanted to give more information in the
> >>>>mail.
> >>>> > >
> >>>> > > We are seeing an issue in our test cluster when an osd is stopped
> >>>> > > gracefully
> >>>> > and restarted after the maintenance.
> >>>> > > Please note, haven't used any no out option for the cluster.
> >>>> > > After the reboot, not able to one of the PG, and no drive problems
> >>>> > > are
> >>>> > read errors are logged in dmesg/kernel logs. But we are not able to
> >>>> > read the head object of PG for some reason, sorry of lack of logs we
> >>>> > are running with debugs with 0/0 and build with jemalloc enabled for
> >>>> > testing. Hence a customized version.
> >>>> > >
> >>>> > > <snip>
> >>>> > > 2015-12-27 13:14:39.684307 7f5ae47ff700 -1 osd.1 405 *** Got
> >>>>signal
> >>>> > > Terminated ***
> >>>> > > 2015-12-27 13:14:39.779307 7f5ae47ff700  0 osd.1 405
> >>>>prepare_to_stop
> >>>> > > telling mon we are shutting down
> >>>> > > 2016-01-04 10:46:13.966959 7fad39d1e800  0 ceph version
> >>>> > > 10.0.0(7eb76e73fd5b6e990ceba9d45e5a1fec92145fa5), process
> >>>>ceph-osd,
> >>>> > > pid 6975
> >>>> > > 2016-01-04 10:46:14.007516 7fad39d1e800  0
> >>>> > > filestore(/var/lib/ceph/osd/ceph-1) backend xfs (magic 0x58465342)
> >>>> > > 2016-01-04 10:46:14.008565 7fad39d1e800  0
> >>>> > > genericfilestorebackend(/var/lib/ceph/osd/ceph-1) detect_features:
> >>>> > > FIEMAP ioctl is disabled via 'filestore fiemap' config option
> >>>> > > 2016-01-04 10:46:14.008573 7fad39d1e800  0
> >>>> > > genericfilestorebackend(/var/lib/ceph/osd/ceph-1) detect_features:
> >>>> > > SEEK_DATA/SEEK_HOLE is disabled via 'filestore seek data hole'
> >>>> > > config option
> >>>> > > 2016-01-04 10:46:14.008601 7fad39d1e800  0
> >>>> > > genericfilestorebackend(/var/lib/ceph/osd/ceph-1) detect_features:
> >>>> > > splice is supported
> >>>> > > 2016-01-04 10:46:14.008882 7fad39d1e800  0
> >>>> > > genericfilestorebackend(/var/lib/ceph/osd/ceph-1) detect_features:
> >>>> > > syncfs(2) syscall fully supported (by glibc and kernel)
> >>>> > > 2016-01-04 10:46:14.008921 7fad39d1e800  0
> >>>> > > xfsfilestorebackend(/var/lib/ceph/osd/ceph-1) detect_features:
> >>>> > > extsize is supported and your kernel >= 3.5
> >>>> > > 2016-01-04 10:46:14.339253 7fad39d1e800  0
> >>>> > > filestore(/var/lib/ceph/osd/ceph-1) mount: enabling WRITEAHEAD
> >>>> > > journal
> >>>> > > mode: checkpoint is not enabled
> >>>> > > 2016-01-04 10:46:14.532510 7fad39d1e800  0 <cls>
> >>>> > > cls/hello/cls_hello.cc:305: loading cls_hello
> >>>> > > 2016-01-04 10:46:14.534168 7fad39d1e800  0 <cls>
> >>>> > > cls/cephfs/cls_cephfs.cc:136: loading cephfs_size_scan
> >>>> > > 2016-01-04 10:46:14.535626 7fad39d1e800  0 osd.1 405 crush map has
> >>>> > > features 1107558400, adjusting msgr requires for clients
> >>>> > > 2016-01-04 10:46:14.535634 7fad39d1e800  0 osd.1 405 crush map has
> >>>> > > features 1107558400 was 8705, adjusting msgr requires for mons
> >>>> > > 2016-01-04 10:46:14.535639 7fad39d1e800  0 osd.1 405 crush map has
> >>>> > > features 1107558400, adjusting msgr requires for osds
> >>>> > > 2016-01-04 10:46:14.954060 7fad39d1e800  0 osd.1 405 load_pgs
> >>>> > > 2016-01-04 10:46:15.634892 7fad39d1e800 -1 osd.1 405 load_pgs
> >>>>unable
> >>>> > > to peek at 1.29e metadata, skipping
> >>>> >
> >>>> > It looks like the pg's metadata didn't commit properly.  It doesn't
> >>>> > find it on startup, skips the pg, and then crashes below when it
> >>>>tries
> >>>> > to create it and the collection already exists.
> >>>> >
> >>>> > Are there any changes applied on top of upstream filestore?  Also,
> >>>>is
> >>>> > this reproducible on a later version of the code?
> >>>> >
> >>>> > > 2016-01-04 10:46:16.334253 7fad39d1e800  0 osd.1 405 load_pgs
> >>>>opened
> >>>> > > 158 pgs
> >>>> > > 2016-01-04 10:46:16.336960 7fad39d1e800 -1 osd.1 405
> >>>>log_to_monitors
> >>>> > > {default=true}
> >>>> > > 2016-01-04 10:46:16.702999 7fad273be700  0
> >>>> > > filestore(/var/lib/ceph/osd/ceph-1)  error (17) File exists not
> >>>> > > handled on operation 0x7fad2c83f1c0 (201318686.0.0, or op 0,
> >>>> > > counting from 0)
> >>>> > > 2016-01-04 10:46:16.703014 7fad273be700  0
> >>>> > > filestore(/var/lib/ceph/osd/ceph-1) unexpected error code
> >>>> > > 2016-01-04 10:46:16.703017 7fad273be700  0
> >>>> > filestore(/var/lib/ceph/osd/ceph-1)  transaction dump:
> >>>> > > {
> >>>> > >     "ops": [
> >>>> > >         {
> >>>> > >             "op_num": 0,
> >>>> > >             "op_name": "mkcoll",
> >>>> > >             "collection": "1.29e_head"
> >>>> > >         },
> >>>> > >         {
> >>>> > >             "op_num": 1,
> >>>> > >             "op_name": "coll_hint",
> >>>> > >             "collection": "1.29e_head",
> >>>> > >             "type": 1,
> >>>> > >             "pg_num": 800,
> >>>> > >             "expected_num_objects": 0
> >>>> > >         },
> >>>> > >         {
> >>>> > >             "op_num": 2,
> >>>> > >             "op_name": "touch",
> >>>> > >             "collection": "1.29e_head",
> >>>> > >             "oid": "1\/0000029e\/\/head"
> >>>> > >         },
> >>>> > >         {
> >>>> > >             "op_num": 3,
> >>>> > >             "op_name": "omap_setkeys",
> >>>> > >             "collection": "1.29e_head",
> >>>> > >             "oid": "1\/0000029e\/\/head",
> >>>> > >             "attr_lens": {
> >>>> > >                 "_infover": 1
> >>>> > >             }
> >>>> > >         },
> >>>> > >         {
> >>>> > >             "op_num": 4,
> >>>> > >             "op_name": "touch",
> >>>> > >             "collection": "1.29e_head",
> >>>> > >             "oid": "1\/0000029e\/\/head"
> >>>> > >         },
> >>>> > >         {
> >>>> > >             "op_num": 5,
> >>>> > >             "op_name": "omap_setkeys",
> >>>> > >             "collection": "1.29e_head",
> >>>> > >             "oid": "1\/0000029e\/\/head",
> >>>> > >             "attr_lens": {
> >>>> > >                 "_biginfo": 196,
> >>>> > >                 "_epoch": 4,
> >>>> > >                 "_info": 847,
> >>>> > >                 "can_rollback_to": 12,
> >>>> > >                 "rollback_info_trimmed_to": 12
> >>>> > >             }
> >>>> > >         }
> >>>> > >     ]
> >>>> > > }
> >>>> > >
> >>>> > > 2016-01-04 10:46:16.731323 7fad273be700 -1 os/FileStore.cc: In
> >>>> > > function 'unsigned int
> >>>> > > FileStore::_do_transaction(ObjectStore::Transaction&, uint64_t,
> >>>>int,
> >>>> > > ThreadPool::TPHandle*)' thread 7fad273be700 time 2016-01-04
> >>>> > > 10:46:16.703103
> >>>> > > os/FileStore.cc: 3017: FAILED assert(0 == "unexpected error")
> >>>> > >
> >>>> > >  ceph version 10.0.0 (7eb76e73fd5b6e990ceba9d45e5a1fec92145fa5)
> >>>> > >  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> >>>> > > const*)+0x8b) [0x7fad39846a6b]
> >>>> > >  2: (FileStore::_do_transaction(ObjectStore::Transaction&,
> >>>>unsigned
> >>>> > > long, int, ThreadPool::TPHandle*)+0xa48) [0x7fad3968bf58]
> >>>> > >  3:
> >>>> > > (FileStore::_do_transactions(std::list<ObjectStore::Transaction*,
> >>>> > > std::allocator<ObjectStore::Transaction*> >&, unsigned long,
> >>>> > > ThreadPool::TPHandle*)+0x64) [0x7fad396932a4]
> >>>> > >  4: (FileStore::_do_op(FileStore::OpSequencer*,
> >>>> > > ThreadPool::TPHandle&)+0x2c3) [0x7fad39693583]
> >>>> > >  5: (ThreadPool::worker(ThreadPool::WorkThread*)+0xa56)
> >>>> > > [0x7fad398384e6]
> >>>> > >  6: (ThreadPool::WorkThread::entry()+0x10) [0x7fad398393b0]
> >>>> > >  7: (()+0x8182) [0x7fad38609182]
> >>>> > >  8: (clone()+0x6d) [0x7fad367fc47d]
> >>>> > > <snip>
> >>>> > >
> >>>> > >  On the reboot, because of the journal reply, we didn't see any
> >>>> > > transaction
> >>>> > dump issues this time, but we are seeing the following problem.
> >>>> > >
> >>>> > >  <snip>
> >>>> > > 2016-01-04 10:47:09.302400 7f8190a3c800  0 ceph version 10.0.0
> >>>> > > (7eb76e73fd5b6e990ceba9d45e5a1fec92145fa5), process ceph-osd, pid
> >>>> > 9488
> >>>> > > 2016-01-04 10:47:09.310055 7f8190a3c800  0
> >>>> > > filestore(/var/lib/ceph/osd/ceph-1) backend xfs (magic 0x58465342)
> >>>> > > 2016-01-04 10:47:09.310379 7f8190a3c800  0
> >>>> > > genericfilestorebackend(/var/lib/ceph/osd/ceph-1) detect_features:
> >>>> > > FIEMAP ioctl is disabled via 'filestore fiemap' config option
> >>>> > > 2016-01-04 10:47:09.310384 7f8190a3c800  0
> >>>> > > genericfilestorebackend(/var/lib/ceph/osd/ceph-1) detect_features:
> >>>> > > SEEK_DATA/SEEK_HOLE is disabled via 'filestore seek data hole'
> >>>> > > config option
> >>>> > > 2016-01-04 10:47:09.310398 7f8190a3c800  0
> >>>> > > genericfilestorebackend(/var/lib/ceph/osd/ceph-1) detect_features:
> >>>> > > splice is supported
> >>>> > > 2016-01-04 10:47:09.310869 7f8190a3c800  0
> >>>> > > genericfilestorebackend(/var/lib/ceph/osd/ceph-1) detect_features:
> >>>> > > syncfs(2) syscall fully supported (by glibc and kernel)
> >>>> > > 2016-01-04 10:47:09.310935 7f8190a3c800  0
> >>>> > > xfsfilestorebackend(/var/lib/ceph/osd/ceph-1) detect_features:
> >>>> > > extsize is supported and your kernel >= 3.5
> >>>> > > 2016-01-04 10:47:09.322795 7f8190a3c800  0
> >>>> > > filestore(/var/lib/ceph/osd/ceph-1) mount: enabling WRITEAHEAD
> >>>> > > journal
> >>>> > > mode: checkpoint is not enabled
> >>>> > > 2016-01-04 10:47:09.322828 7f8190a3c800  0
> >>>> > > filestore(/var/lib/ceph/osd/ceph-1) disabling wbthrottle(
> >>>> > > filestore_wbthrottle_enable = 0 ) since do_fast_sync is enabled
> >>>> > > 2016-01-04 10:47:09.327861 7f8183ee0700  0
> >>>> > > filestore(/var/lib/ceph/osd/ceph-1) ## Fast sync is enabled ##
> >>>> > > 2016-01-04 10:47:09.392333 7f8190a3c800  0 <cls>
> >>>> > > cls/hello/cls_hello.cc:305: loading cls_hello
> >>>> > > 2016-01-04 10:47:09.393968 7f8190a3c800  0 <cls>
> >>>> > > cls/cephfs/cls_cephfs.cc:136: loading cephfs_size_scan
> >>>> > > 2016-01-04 10:47:09.394528 7f8190a3c800  0 osd.1 410 crush map has
> >>>> > > features 1107558400, adjusting msgr requires for clients
> >>>> > > 2016-01-04 10:47:09.394536 7f8190a3c800  0 osd.1 410 crush map has
> >>>> > > features 1107558400 was 8705, adjusting msgr requires for mons
> >>>> > > 2016-01-04 10:47:09.394552 7f8190a3c800  0 osd.1 410 crush map has
> >>>> > > features 1107558400, adjusting msgr requires for osds
> >>>> > > 2016-01-04 10:47:09.458215 7f8190a3c800  0 osd.1 410 load_pgs
> >>>> > > 2016-01-04 10:47:10.935841 7f8190a3c800  0 osd.1 410 load_pgs
> >>>>opened
> >>>> > > 159 pgs
> >>>> > > 2016-01-04 10:47:10.936696 7f8190a3c800 -1 osd.1 410
> >>>>log_to_monitors
> >>>> > > {default=true}
> >>>> > > 2016-01-04 10:47:13.942139 7f8190a3c800  0 osd.1 410 done with
> >>>>init,
> >>>> > > starting boot process
> >>>> > > 2016-01-04 10:47:14.117463 7f817d1f3700  0 --
> >>>> > > 10.242.43.141:6825/9488
> >>>> > > >> 10.242.43.143:6821/40041 pipe(0x7f8141c0e000 sd=83 :6825 s=0
> >>>> > > >> pgs=0
> >>>> > > cs=0 l=0 c=0x7f8141c14180).accept connect_seq 0 vs existing 0
> >>>>state
> >>>> > > connecting
> >>>> > > 2016-01-04 10:47:15.649791 7f812eefe700  0 --
> >>>> > > 10.242.43.141:6825/9488
> >>>> > > >> 10.242.43.141:6801/6106 pipe(0x7f8141c0e000 sd=93 :6825 s=0
> >>>>pgs=0
> >>>> > > cs=0 l=0 c=0x7f8141c14480).accept connect_seq 0 vs existing 0
> >>>>state
> >>>> > > connecting
> >>>> > > 2016-01-04 10:47:15.649826 7f812edfd700  0 --
> >>>> > > 10.242.43.141:6825/9488
> >>>> > > >> 10.242.43.141:6821/6925 pipe(0x7f8141c1c000 sd=137 :6825 s=0
> >>>> > > >> pgs=0
> >>>> > > cs=0 l=0 c=0x7f8141c14780).accept connect_seq 0 vs existing 0
> >>>>state
> >>>> > > connecting
> >>>> > > 2016-01-04 10:47:15.924059 7f81527ed700 -1 osd/PGLog.h: In
> >>>>function
> >>>> > > 'void PGLog::IndexedLog::claim_log_and_clear_rollback_info(const
> >>>> > > pg_log_t&)' thread 7f81527ed700 time 2016-01-04 10:47:15.906256
> >>>> > > osd/PGLog.h: 89: FAILED assert(rollback_info_trimmed_to_riter ==
> >>>> > > log.rbegin())
> >>>> > >
> >>>> > >  ceph version 10.0.0 (7eb76e73fd5b6e990ceba9d45e5a1fec92145fa5)
> >>>> > >  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> >>>> > > const*)+0x8b) [0x7f8190564a6b]
> >>>> > >  2: (PG::RecoveryState::Stray::react(PG::MLogRec const&)+0xa21)
> >>>> > > [0x7f8190173971]
> >>>> > >  3: (boost::statechart::simple_state<PG::RecoveryState::Stray,
> >>>> > > PG::RecoveryState::Started, boost::mpl::list<mpl_::na, mpl_::na,
> >>>> > > mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
> >>>> > > mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
> >>>> > > mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na>,
> >>>> > > 
> >>>>(boost::statechart::history_mode)0>::react_impl(boost::statechart::e
> >>>> > > ve nt_base const&, void const*)+0x1f4) [0x7f81901ad584]
> >>>> > >  4:
> >>>> > >
> >>>> (boost::statechart::state_machine<PG::RecoveryState::RecoveryMachine
> >>>> > > , PG::RecoveryState::Initial, std::allocator<void>,
> >>>> > > 
> >>>>boost::statechart::null_exception_translator>::send_event(boost::sta
> >>>> > > te chart::event_base const&)+0x5b) [0x7f8190197bab]
> >>>> > >  5: (PG::handle_peering_event(std::shared_ptr<PG::CephPeeringEvt>,
> >>>> > > PG::RecoveryCtx*)+0x1ce) [0x7f81901412ce]
> >>>> > >  6: (OSD::process_peering_events(std::list<PG*,
> >>>>std::allocator<PG*>
> >>>> > > > const&, ThreadPool::TPHandle&)+0x267) [0x7f81900cb677]
> >>>> > >  7: (OSD::PeeringWQ::_process(std::list<PG*, std::allocator<PG*> >
> >>>> > > const&, ThreadPool::TPHandle&)+0x18) [0x7f819010fed8]
> >>>> > >  8: (ThreadPool::worker(ThreadPool::WorkThread*)+0xa56)
> >>>> > > [0x7f81905564e6]
> >>>> > >  9: (ThreadPool::WorkThread::entry()+0x10) [0x7f81905573b0]
> >>>> > >  10: (()+0x8182) [0x7f818f327182]
> >>>> > >  11: (clone()+0x6d) [0x7f818d51a47d]
> >>>> > >  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> >>>> > > needed
> >>>> > to interpret this.
> >>>> > > <snip>
> >>>> > >
> >>>> > >  Whenever we restart the osd, we are hitting the problem and not
> >>>> > > able to
> >>>> > get the osd up. Tried pg repair, which bails saying primary osd
> >>>>down.
> >>>> > >  Are there any repair techniques available to get this corrected?
> >>>> >
> >>>> > Most likely deleting the pg directory will be sufficient to clear it
> >>>>up.
> >>>> >
> >>>> > sage
> >>>> 
> >>>> --
> >>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> >>>>in the
> >>>> body of a message to majordomo@vger.kernel.org More majordomo info at
> >>>> http://vger.kernel.org/majordomo-info.html
> >>>--
> >>>To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>>the body of a message to majordomo@vger.kernel.org
> >>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>--
> >>To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>the body of a message to majordomo@vger.kernel.org
> >>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> 
