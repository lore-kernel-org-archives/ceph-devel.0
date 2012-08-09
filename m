From: Samuel Just <sam.just@inktank.com>
Subject: Re: cannot startup one of the osd
Date: Thu, 9 Aug 2012 16:02:09 -0700
Message-ID: <CA+4uBUZ0FFkofmUcUTnbxx5ZduVsQOQTGZsbkArXSwxSJ_byaA@mail.gmail.com>
References: <60E83269D669544E8069A09CB69135EA011DB4@GDC-CLDMBX-P02.whq.wistron>
	<CA+4uBUZgZXJ8TZz4T3OFeVYmNgvwXg0Ye6jwjrwXpPKbXufXbw@mail.gmail.com>
	<60E83269D669544E8069A09CB69135EA01245B@GDC-CLDMBX-P02.whq.wistron>
	<CA+4uBUY1bT869XyzoqoDVENwpKzPe8eCDsQEBO0JeVit7jfadg@mail.gmail.com>
	<60E83269D669544E8069A09CB69135EA01C2C4@GDC-CLDMBX-P02.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:38098 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759874Ab2HIXCK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Aug 2012 19:02:10 -0400
Received: by vcbfk26 with SMTP id fk26so961328vcb.19
        for <ceph-devel@vger.kernel.org>; Thu, 09 Aug 2012 16:02:10 -0700 (PDT)
In-Reply-To: <60E83269D669544E8069A09CB69135EA01C2C4@GDC-CLDMBX-P02.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wiwynn.com
Cc: ceph-devel@vger.kernel.org

Sorry for the delayed response, I managed to miss the previous emails.

The above crash has likely been fixed in current stable.  Specifically
ec5cd6def9817039704b6cc010f2797a700d8500
should take care of that bug.

I just looked at the original problem.  The issue appears to be pgs
stuck in backfill (a recovery state).  If this is still happening, it
would be helpful to have osd logs from the primary osd for one of the
stuck pgs.

To determine whether there are any pgs stuck in backfill:

ceph pg dump | grep backfill

If you see a line that looks like:

2.313   68      7       75      7       272797696       221272  221272
 active+recovering+degraded+backfill     2012-08-03 08:24:04.440515
  1829'31229      3494'58940      [5,18]  [5,18]1170'21318
2012-07-30 18:53:34.620143

you can conclude that osd.5 is the primary for pg 2.313 and it is
currently in backfill.  If that state persists for more than an hour
for that pg, the pg is most likely stuck.  If you can provide an osd
log from osd start to that point with osd logging at 20 (add 'debug
osd = 20' to the appropriate osd section of the ceph.conf) we should
be able to figure out what is happening.

You could also reply with the output of 'ceph pg <pgid> query' where
pgid in this case would be 2.313.  It's much easier to get than the
log and might be enough to diagnose the problem.

It's possible that the original problem is also fixed in stable.

Let me know what you find,
-Sam

On Wed, Aug 8, 2012 at 8:23 PM,  <Eric_YH_Chen@wiwynn.com> wrote:
> Dear Samuel:
>
> I met similar issue from different scenario.
>
> Reproduce way:
> Step 1. Remove one disk directly (hot plug) and wait for the cluster remove the osd.
> Step 2. Put the original disk back to system and reboot.
>
> You can download the osd map / osd dump / pg dump via the link below.
> https://dl.dropbox.com/u/35107741/ceph/bug.tar.gz
>
> You can get the full log of ceph-osd.3.log here
> https://dl.dropbox.com/u/35107741/ceph/ceph-osd.3.tar.gz
>
> ========= partial of ceph-osd.3.log
> 2012-08-06 13:59:20.523379 7f5f4365b700 -1 *** Caught signal (Aborted) **  in thread 7f5f4365b700
>
>  ceph version 0.48argonaut (commit:c2b20ca74249892c8e5e40c12aa14446a2bf2030)
>  1: /usr/bin/ceph-osd() [0x6e900a]
>  2: (()+0xfcb0) [0x7f5f51a54cb0]
>  3: (gsignal()+0x35) [0x7f5f50630445]
>  4: (abort()+0x17b) [0x7f5f50633bab]
>  5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f5f50f7e69d]
>  6: (()+0xb5846) [0x7f5f50f7c846]
>  7: (()+0xb5873) [0x7f5f50f7c873]
>  8: (()+0xb596e) [0x7f5f50f7c96e]
>  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x282) [0x79f662]
>  10: (OSD::unreg_last_pg_scrub(pg_t, utime_t)+0x149) [0x638929]
>  11: (PG::proc_primary_info(ObjectStore::Transaction&, pg_info_t const&)+0x5e) [0x629abe]
>  12: (PG::RecoveryState::ReplicaActive::react(PG::RecoveryState::MInfoRec const&)+0x4a) [0x62a15a]
> 13: (boost::statechart::detail::reaction_result boost::statechart::simple_state<PG::RecoveryState::ReplicaActive, PG::R ecoveryState::Started, boost::mpl::list<mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na>, (boost::statechart::history_mode)0>::local_react_impl_non_empty::local_react_impl<boost::mpl::list3<boost::statechart::custom_reaction<PG::RecoveryState::MQuery>, boost::statechart::custom_reaction<PG::RecoveryState::MInfoRec>, boost::statechart::custom_reaction<PG::RecoveryState::MLogRec> >, boost::statechart::simple_state<PG::RecoveryState::ReplicaActive, PG::RecoveryState::Started, boost::mpl::list<mpl_::na, mpl_::na, mpl_::na, mp
 l_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na>, (boost::statechart::history_mode)0> >(boost::statechart::simple_state<PG::RecoveryState::ReplicaActive, PG::RecoveryState::Started, boost::mpl::list<mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na>, (boost::statechart::history_mode)0>&, boost::statechart::event_base const&, void const*)+0x130) [0x63d1d0]
>  14: (boost::statechart::simple_state<PG::RecoveryState::ReplicaActive, PG::RecoveryState::Started, boost::mpl::list<mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na>, (boost::statechart::history_mode)0>::react_impl(boost::statechart::event_base const&, void const*)+0x81) [0x63d2c1]
>  15: (boost::statechart::state_machine<PG::RecoveryState::RecoveryMachine, PG::RecoveryState::Initial, std::allocator<void>, boost::statechart::null_exception_translator>::send_event(boost::statechart::event_base const&)+0x5b) [0x634feb]
>  16: (boost::statechart::state_machine<PG::RecoveryState::RecoveryMachine, PG::RecoveryState::Initial, std::allocator<void>, boost::statechart::null_exception_translator>::process_event(boost::statechart::event_base const&)+0x11) [0x635081]
>  17: (PG::RecoveryState::handle_info(int, pg_info_t&, PG::RecoveryCtx*)+0x177) [0x60cd47]
>  18: (OSD::handle_pg_info(std::tr1::shared_ptr<OpRequest>)+0x665) [0x5caf95]
>  19: (OSD::dispatch_op(std::tr1::shared_ptr<OpRequest>)+0x2a0) [0x5ce600]
>  20: (OSD::_dispatch(Message*)+0x191) [0x5d47f1]
>  21: (OSD::ms_dispatch(Message*)+0x153) [0x5d50f3]
>  22: (SimpleMessenger::dispatch_entry()+0x92b) [0x77f2bb]
>  23: (SimpleMessenger::DispatchThread::entry()+0xd) [0x741c7d]
>  24: (()+0x7e9a) [0x7f5f51a4ce9a]
>  25: (clone()+0x6d) [0x7f5f506ec4bd]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
> -----Original Message-----
> From: Eric YH Chen/WYHQ/Wiwynn
> Sent: Friday, August 03, 2012 9:37 AM
> To: 'Samuel Just'
> Cc: ceph-devel@vger.kernel.org; Chris YT Huang/WYHQ/Wiwynn; Victor CY Chang/WYHQ/Wiwynn
> Subject: RE: cannot startup one of the osd
>
> Dear Samuel:
>
> I will try to reproduce it again.
> Before that, I can provide osdmap/osd dump/pg dump to you first.
>
> However, I had followed the document to remove the crash osd(osd.22) and add another new osd(osd.24).
> And I also try to remove unfound object.
> Therefore, it may not the correct information that you want.
> http://ceph.com/docs/master/ops/manage/failures/osd/#unfound-objects
>
> Anyway, I will try to reproduce it again and provide new data to you.
>
> -----Original Message-----
> From: Samuel Just [mailto:sam.just@inktank.com]
> Sent: Thursday, August 02, 2012 2:44 AM
> To: Eric YH Chen/WYHQ/Wiwynn
> Cc: ceph-devel@vger.kernel.org; Chris YT Huang/WYHQ/Wiwynn; Victor CY Chang/WYHQ/Wiwynn
> Subject: Re: cannot startup one of the osd
>
> I'm not sure how the crash could have happened.  Can you reproduce the crash with logging on? (debug osd = 20 and debug filestore = 20).
> Also, can you gzip up the current/omap directory on the crashed osd and post it?  It seems that one of the ondisk structures may have been corrupted.
>
> Even with that, the cluster should have recovered.  Can you post:
> 1) The osdmap.  This can be obtained by running
>        ceph osd getmap -o <outfile>
>     where outfile is the name of the file into which you want the map to be written.
>
> 2) The output of
>        ceph osd dump
> 3) The output of
>        ceph pg dump
>
> Thanks
> -Sam
>
> On Wed, Aug 1, 2012 at 1:11 AM,  <Eric_YH_Chen@wiwynn.com> wrote:
>> Hi, Samuel:
>>
>> And the ceph cluster stays at a not healthy status. How could we fix it?
>> There are 230 object unfound and we cannot access some rbd devices now.
>> It would hang at "rbd info <image_name>".
>>
>> root@ubuntu:~$ ceph -s
>>    health HEALTH_WARN 96 pgs backfill; 96 pgs degraded; 96 pgs
>> recovering; 96 pgs stuck unclean; recovery 4978/138644 de graded (3.590%); 230/69322 unfound (0.332%)
>>    monmap e1: 3 mons at
>> {006=192.168.200.84:6789/0,008=192.168.200.86:6789/0,009=192.168.200.87:6789/0}, election epoch 6, quorum 0,1,2 006,008,009
>>    osdmap e2944: 24 osds: 23 up, 23 in
>>     pgmap v297084: 4608 pgs: 4512 active+clean, 50
>> active+recovering+degraded+remapped+backfill, 46 active+recovering+de
>> graded+backfill; 257 GB data, 952 GB used, 19367 GB / 21390 GB avail;
>> graded+4978/138644 degraded (3.590%); 230/69322 unfound (
>> 0.332%)
>>    mdsmap e1: 0/0/1 up
>>
>>
>> -----Original Message-----
>> From: Eric YH Chen/WYHQ/Wiwynn
>> Sent: Wednesday, August 01, 2012 9:01 AM
>> To: 'Samuel Just'
>> Cc: ceph-devel@vger.kernel.org; Chris YT Huang/WYHQ/Wiwynn; Victor CY
>> Chang/WYHQ/Wiwynn
>> Subject: RE: cannot startup one of the osd
>>
>> Hi, Samuel:
>>
>> It happens every startup, I cannot fix it now.
>>
>> -----Original Message-----
>> From: Samuel Just [mailto:sam.just@inktank.com]
>> Sent: Wednesday, August 01, 2012 1:36 AM
>> To: Eric YH Chen/WYHQ/Wiwynn
>> Cc: ceph-devel@vger.kernel.org; Chris YT Huang/WYHQ/Wiwynn; Victor CY
>> Chang/WYHQ/Wiwynn
>> Subject: Re: cannot startup one of the osd
>>
>> This crash happens on each startup?
>> -Sam
>>
>> On Tue, Jul 31, 2012 at 2:32 AM,  <Eric_YH_Chen@wiwynn.com> wrote:
>>> Hi, all:
>>>
>>> My Environment:  two servers, and 12 hard-disk on each server.
>>>                  Version: Ceph 0.48, Kernel: 3.2.0-27
>>>
>>> We create a ceph cluster with 24 osd, 3 monitors
>>> Osd.0 ~ osd.11 is on server1
>>> Osd.12 ~ osd.23 is on server2
>>> Mon.0 is on server1
>>> Mon.1 is on server2
>>> Mon.2 is on server3 which has no osd
>>>
>>> root@ubuntu:~$ ceph -s
>>>    health HEALTH_WARN 227 pgs degraded; 93 pgs down; 93 pgs peering; 85 pgs recovering; 82 pgs stuck inactive; 255 pgs stuck unclean; recovery 4808/138644 degraded (3.468%); 202/69322 unfound (0.291%); 1/24 in osds are down
>>>    monmap e1: 3 mons at {006=192.168.200.84:6789/0,008=192.168.200.86:6789/0,009=192.168.200.87:6789/0}, election epoch 564, quorum 0,1,2 006,008,009
>>>    osdmap e1911: 24 osds: 23 up, 24 in
>>>     pgmap v292031: 4608 pgs: 4251 active+clean, 85 active+recovering+degraded, 37 active+remapped, 58 down+peering, 142 active+degraded, 35 down+replay+peering; 257 GB data, 948 GB used, 19370 GB / 21390 GB avail; 4808/138644 degraded (3.468%); 202/69322 unfound (0.291%)
>>>    mdsmap e1: 0/0/1 up
>>>
>>> I find one of the osd cannot startup anymore. Before that, I am testing HA of Ceph cluster.
>>>
>>> Step1:  shutdown server1, wait 5 min
>>> Step2:  bootup server1, wait 5 min until ceph enter health status
>>> Step3:  shutdown server2, wait 5 min
>>> Step4:  bootup server2, wait 5 min until ceph enter health status
>>> Repeat Step1~ Step4 several times, then I met this problem.
>>>
>>>
>>> Log of ceph-osd.22.log
>>> 2012-07-31 17:18:15.120678 7f9375300780  0
>>> filestore(/srv/disk10/data) mount found snaps <>
>>> 2012-07-31 17:18:15.122081 7f9375300780  0
>>> filestore(/srv/disk10/data)
>>> mount: enabling WRITEAHEAD journal mode: btrfs not detected
>>> 2012-07-31 17:18:15.128544 7f9375300780  1 journal _open
>>> /srv/disk10/journal fd 23: 6442450944 bytes, block size 4096 bytes,
>>> directio = 1, aio = 0
>>> 2012-07-31 17:18:15.257302 7f9375300780  1 journal _open
>>> /srv/disk10/journal fd 23: 6442450944 bytes, block size 4096 bytes,
>>> directio = 1, aio = 0
>>> 2012-07-31 17:18:15.273163 7f9375300780  1 journal close
>>> /srv/disk10/journal
>>> 2012-07-31 17:18:15.274395 7f9375300780 -1
>>> filestore(/srv/disk10/data) limited size xattrs --
>>> filestore_xattr_use_omap enabled
>>> 2012-07-31 17:18:15.275169 7f9375300780  0
>>> filestore(/srv/disk10/data) mount FIEMAP ioctl is supported and
>>> appears to work
>>> 2012-07-31 17:18:15.275180 7f9375300780  0
>>> filestore(/srv/disk10/data) mount FIEMAP ioctl is disabled via
>>> 'filestore fiemap' config option
>>> 2012-07-31 17:18:15.275312 7f9375300780  0
>>> filestore(/srv/disk10/data) mount did NOT detect btrfs
>>> 2012-07-31 17:18:15.276060 7f9375300780  0
>>> filestore(/srv/disk10/data) mount syncfs(2) syscall fully supported
>>> (by glib and kernel)
>>> 2012-07-31 17:18:15.276154 7f9375300780  0
>>> filestore(/srv/disk10/data) mount found snaps <>
>>> 2012-07-31 17:18:15.277031 7f9375300780  0
>>> filestore(/srv/disk10/data)
>>> mount: enabling WRITEAHEAD journal mode: btrfs not detected
>>> 2012-07-31 17:18:15.280906 7f9375300780  1 journal _open
>>> /srv/disk10/journal fd 32: 6442450944 bytes, block size 4096 bytes,
>>> directio = 1, aio = 0
>>> 2012-07-31 17:18:15.307761 7f9375300780  1 journal _open
>>> /srv/disk10/journal fd 32: 6442450944 bytes, block size 4096 bytes,
>>> directio = 1, aio = 0
>>> 2012-07-31 17:18:19.466921 7f9360a97700  0 --
>>> 192.168.200.82:6830/18744 >> 192.168.200.83:0/3485583732
>>> pipe(0x45bd000 sd=34 pgs=0 cs=0 l=0).accept peer addr is really
>>> 192.168.200.83:0/3485583732 (socket is 192.168.200.83:45653/0)
>>> 2012-07-31 17:18:19.671681 7f9363a9d700 -1 os/DBObjectMap.cc: In
>>> function 'virtual bool DBObjectMap::DBObjectMapIteratorImpl::valid()'
>>> thread 7f9363a9d700 time 2012-07-31 17:18:19.670082
>>> os/DBObjectMap.cc: 396: FAILED assert(!valid || cur_iter->valid())
>>>
>>> ceph version 0.48argonaut
>>> (commit:c2b20ca74249892c8e5e40c12aa14446a2bf2030)
>>>  1: /usr/bin/ceph-osd() [0x6a3123]
>>>  2: (ReplicatedPG::send_push(int, ObjectRecoveryInfo,
>>> ObjectRecoveryProgress, ObjectRecoveryProgress*)+0x684) [0x53f314]
>>>  3: (ReplicatedPG::push_start(ReplicatedPG::ObjectContext*, hobject_t
>>> const&, int, eversion_t, interval_set<unsigned long>&,
>>> std::map<hobject_t, interval_set<unsigned long>,
>>> std::less<hobject_t>, std::allocator<std::pair<hobject_t const,
>>> interval_set<unsigned long>
>>> > > >&)+0x333) [0x54c873]
>>>  4: (ReplicatedPG::push_to_replica(ReplicatedPG::ObjectContext*,
>>> hobject_t const&, int)+0x343) [0x54cdc3]
>>>  5: (ReplicatedPG::recover_object_replicas(hobject_t const&,
>>> eversion_t)+0x35f) [0x5527bf]
>>>  6: (ReplicatedPG::wait_for_degraded_object(hobject_t const&,
>>> std::tr1::shared_ptr<OpRequest>)+0x17b) [0x55406b]
>>>  7: (ReplicatedPG::do_op(std::tr1::shared_ptr<OpRequest>)+0x9de)
>>> [0x56305e]
>>>  8: (PG::do_request(std::tr1::shared_ptr<OpRequest>)+0x199)
>>> [0x5fda89]
>>>  9: (OSD::dequeue_op(PG*)+0x238) [0x5bf668]
>>>  10: (ThreadPool::worker()+0x605) [0x796d55]
>>>  11: (ThreadPool::WorkThread::entry()+0xd) [0x5d5d0d]
>>>  12: (()+0x7e9a) [0x7f9374794e9a]
>>>  13: (clone()+0x6d) [0x7f93734344bd]
>>>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
>>>
>>> --- begin dump of recent events ---
>>>    -21> 2012-07-31 17:18:15.114905 7f9375300780  0 ceph version 0.48argonaut (commit:c2b20ca74249892c8e5e40c12aa14446a2bf2030), process ceph-osd, pid 18744
>>>    -20> 2012-07-31 17:18:15.118038 7f9375300780 -1 filestore(/srv/disk10/data) limited size xattrs -- filestore_xattr_use_omap enabled
>>>    -19> 2012-07-31 17:18:15.119172 7f9375300780  0 filestore(/srv/disk10/data) mount FIEMAP ioctl is supported and appears to work
>>>    -18> 2012-07-31 17:18:15.119185 7f9375300780  0 filestore(/srv/disk10/data) mount FIEMAP ioctl is disabled via 'filestore fiemap' config option
>>>    -17> 2012-07-31 17:18:15.119339 7f9375300780  0 filestore(/srv/disk10/data) mount did NOT detect btrfs
>>>    -16> 2012-07-31 17:18:15.120567 7f9375300780  0 filestore(/srv/disk10/data) mount syncfs(2) syscall fully supported (by glibc and kernel)
>>>    -15> 2012-07-31 17:18:15.120678 7f9375300780  0 filestore(/srv/disk10/data) mount found snaps <>
>>>    -14> 2012-07-31 17:18:15.122081 7f9375300780  0 filestore(/srv/disk10/data) mount: enabling WRITEAHEAD journal mode:btrfs not detected
>>>    -13> 2012-07-31 17:18:15.128544 7f9375300780  1 journal _open /srv/disk10/journal fd 23: 6442450944 bytes, block size 4096 bytes, directio = 1, aio = 0
>>>    -12> 2012-07-31 17:18:15.257302 7f9375300780  1 journal _open /srv/disk10/journal fd 23: 6442450944 bytes, block size 4096 bytes, directio = 1, aio = 0
>>>    -11> 2012-07-31 17:18:15.273163 7f9375300780  1 journal close /srv/disk10/journal
>>>    -10> 2012-07-31 17:18:15.274395 7f9375300780 -1 filestore(/srv/disk10/data) limited size xattrs -- filestore_xattr_use_omap enabled
>>>     -9> 2012-07-31 17:18:15.275169 7f9375300780  0 filestore(/srv/disk10/data) mount FIEMAP ioctl is supported and appea
>>>     -8> 2012-07-31 17:18:15.275180 7f9375300780  0 filestore(/srv/disk10/data) mount FIEMAP ioctl is disabled via 'filestore fiemap' config option
>>>     -7> 2012-07-31 17:18:15.275312 7f9375300780  0 filestore(/srv/disk10/data) mount did NOT detect btrfs
>>>     -6> 2012-07-31 17:18:15.276060 7f9375300780  0 filestore(/srv/disk10/data) mount syncfs(2) syscall fully supported (by glibc and kernel)
>>>     -5> 2012-07-31 17:18:15.276154 7f9375300780  0 filestore(/srv/disk10/data) mount found snaps <>
>>>     -4> 2012-07-31 17:18:15.277031 7f9375300780  0 filestore(/srv/disk10/data) mount: enabling WRITEAHEAD journal mode: btrfs not detected
>>>     -3> 2012-07-31 17:18:15.280906 7f9375300780  1 journal _open /srv/disk10/journal fd 32: 6442450944 bytes, block size 4096 bytes, directio = 1, aio = 0
>>>     -2> 2012-07-31 17:18:15.307761 7f9375300780  1 journal _open /srv/disk10/journal fd 32: 6442450944 bytes, block size 4096 bytes, directio = 1, aio = 0
>>>     -1> 2012-07-31 17:18:19.466921 7f9360a97700  0 -- 192.168.200.82:6830/18744 >> 192.168.200.83:0/3485583732 pipe(0x45bd000 sd=34 pgs=0 cs=0 l=0).accept peer addr is really 192.168.200.83:0/3485583732 (socket is 192.168.200.83:45653/0)
>>>      0> 2012-07-31 17:18:19.671681 7f9363a9d700 -1 os/DBObjectMap.cc:
>>> In function 'virtual bool
>>> DBObjectMap::DBObjectMapIteratorImpl::valid()' thread 7f9363a9d700
>>> time 2012-07-31 17:18:19.670082
>>> os/DBObjectMap.cc: 396: FAILED assert(!valid || cur_iter->valid())
>>>
>>>
>>>  ceph version 0.48argonaut
>>> (commit:c2b20ca74249892c8e5e40c12aa14446a2bf2030)
>>>  1: /usr/bin/ceph-osd() [0x6a3123]
>>>  2: (ReplicatedPG::send_push(int, ObjectRecoveryInfo,
>>> ObjectRecoveryProgress, ObjectRecoveryProgress*)+0x684) [0x53f314]
>>>  3: (ReplicatedPG::push_start(ReplicatedPG::ObjectContext*, hobject_t
>>> const&, int, eversion_t, interval_set<unsigned long>&,
>>> std::map<hobject_t, interval_set<unsigned long>,
>>> std::less<hobject_t>, std::allocator<std::pair<hobject_t const,
>>> interval_set<unsigned long>
>>> > > >&)+0x333) [0x54c873]
>>>  4: (ReplicatedPG::push_to_replica(ReplicatedPG::ObjectContext*,
>>> hobject_t const&, int)+0x343) [0x54cdc3]
>>>  5: (ReplicatedPG::recover_object_replicas(hobject_t const&,
>>> eversion_t)+0x35f) [0x5527bf]
>>>  6: (ReplicatedPG::wait_for_degraded_object(hobject_t const&,
>>> std::tr1::shared_ptr<OpRequest>)+0x17b) [0x55406b]
>>>  7: (ReplicatedPG::do_op(std::tr1::shared_ptr<OpRequest>)+0x9de)
>>> [0x56305e]
>>>  8: (PG::do_request(std::tr1::shared_ptr<OpRequest>)+0x199)
>>> [0x5fda89]
>>>  9: (OSD::dequeue_op(PG*)+0x238) [0x5bf668]
>>>  10: (ThreadPool::worker()+0x605) [0x796d55]
>>>  11: (ThreadPool::WorkThread::entry()+0xd) [0x5d5d0d]
>>>  12: (()+0x7e9a) [0x7f9374794e9a]
>>>  13: (clone()+0x6d) [0x7f93734344bd]
>>>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
>>>
>>> --- end dump of recent events ---
>>> 2012-07-31 17:18:19.673801 7f9363a9d700 -1 *** Caught signal
>>> (Aborted)
>>> **  in thread 7f9363a9d700
>>>
>>>  ceph version 0.48argonaut
>>> (commit:c2b20ca74249892c8e5e40c12aa14446a2bf2030)
>>>  1: /usr/bin/ceph-osd() [0x6e900a]
>>>  2: (()+0xfcb0) [0x7f937479ccb0]
>>>  3: (gsignal()+0x35) [0x7f9373378445]
>>>  4: (abort()+0x17b) [0x7f937337bbab]
>>>  5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f9373cc669d]
>>>  6: (()+0xb5846) [0x7f9373cc4846]
>>>  7: (()+0xb5873) [0x7f9373cc4873]
>>>  8: (()+0xb596e) [0x7f9373cc496e]
>>>  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>>> const*)+0x282) [0x79f662]
>>>  10: /usr/bin/ceph-osd() [0x6a3123]
>>>  11: (ReplicatedPG::send_push(int, ObjectRecoveryInfo,
>>> ObjectRecoveryProgress, ObjectRecoveryProgress*)+0x684) [0x53f314 ]
>>>  12: (ReplicatedPG::push_start(ReplicatedPG::ObjectContext*,
>>> hobject_t const&, int, eversion_t, interval_set<unsigned lo
>>> ng>&, std::map<hobject_t, interval_set<unsigned long>,
>>> ng>std::less<hobject_t>, std::allocator<std::pair<hobject_t const, i
>>> nterval_set<unsigned long> > > >&)+0x333) [0x54c873]
>>>  13: (ReplicatedPG::push_to_replica(ReplicatedPG::ObjectContext*,
>>> hobject_t const&, int)+0x343) [0x54cdc3]
>>>  14: (ReplicatedPG::recover_object_replicas(hobject_t const&,
>>> eversion_t)+0x35f) [0x5527bf]
>>>  15: (ReplicatedPG::wait_for_degraded_object(hobject_t const&,
>>> std::tr1::shared_ptr<OpRequest>)+0x17b) [0x55406b]
>>>  16: (ReplicatedPG::do_op(std::tr1::shared_ptr<OpRequest>)+0x9de)
>>> [0x56305e]
>>>  17: (PG::do_request(std::tr1::shared_ptr<OpRequest>)+0x199)
>>> [0x5fda89]
>>>  18: (OSD::dequeue_op(PG*)+0x238) [0x5bf668]
>>>  19: (ThreadPool::worker()+0x605) [0x796d55]
>>>  20: (ThreadPool::WorkThread::entry()+0xd) [0x5d5d0d]
>>>  21: (()+0x7e9a) [0x7f9374794e9a]
>>>  22: (clone()+0x6d) [0x7f93734344bd]
>>>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
>>> --- begin dump of recent events ---
>>>      0> 2012-07-31 17:18:19.673801 7f9363a9d700 -1 *** Caught signal
>>> (Aborted) **  in thread 7f9363a9d700
>>>
>>>  ceph version 0.48argonaut
>>> (commit:c2b20ca74249892c8e5e40c12aa14446a2bf2030)
>>>  1: /usr/bin/ceph-osd() [0x6e900a]
>>>  2: (()+0xfcb0) [0x7f937479ccb0]
>>>  3: (gsignal()+0x35) [0x7f9373378445]
>>>  4: (abort()+0x17b) [0x7f937337bbab]
>>>  5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f9373cc669d]
>>>  6: (()+0xb5846) [0x7f9373cc4846]
>>>  7: (()+0xb5873) [0x7f9373cc4873]
>>>  8: (()+0xb596e) [0x7f9373cc496e]
>>>  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>>> const*)+0x282) [0x79f662]
>>>  10: /usr/bin/ceph-osd() [0x6a3123]
>>>  11: (ReplicatedPG::send_push(int, ObjectRecoveryInfo,
>>> ObjectRecoveryProgress, ObjectRecoveryProgress*)+0x684) [0x53f314]
>>>  12: (ReplicatedPG::push_start(ReplicatedPG::ObjectContext*,
>>> hobject_t const&, int, eversion_t, interval_set<unsigned long>&,
>>> std::map<hobject_t, interval_set<unsigned long>,
>>> std::less<hobject_t>, std::allocator<std::pair<hobject_t const,
>>> interval_set<unsigned long>
>>> > > >&)+0x333) [0x54c873]
>>>  13: (ReplicatedPG::push_to_replica(ReplicatedPG::ObjectContext*,
>>> hobject_t const&, int)+0x343) [0x54cdc3]
>>>  14: (ReplicatedPG::recover_object_replicas(hobject_t const&,
>>> eversion_t)+0x35f) [0x5527bf]
>>>  15: (ReplicatedPG::wait_for_degraded_object(hobject_t const&,
>>> std::tr1::shared_ptr<OpRequest>)+0x17b) [0x55406b]
>>>  16: (ReplicatedPG::do_op(std::tr1::shared_ptr<OpRequest>)+0x9de)
>>> [0x56305e]
>>>  17: (PG::do_request(std::tr1::shared_ptr<OpRequest>)+0x199)
>>> [0x5fda89]
>>>  18: (OSD::dequeue_op(PG*)+0x238) [0x5bf668]
>>>  19: (ThreadPool::worker()+0x605) [0x796d55]
>>>  20: (ThreadPool::WorkThread::entry()+0xd) [0x5d5d0d]
>>>  21: (()+0x7e9a) [0x7f9374794e9a]
>>>  22: (clone()+0x6d) [0x7f93734344bd]
>>>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
>>>
>>> --- end dump of recent events ---
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>> in the body of a message to majordomo@vger.kernel.org More majordomo
>>> info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
