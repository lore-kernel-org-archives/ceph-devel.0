From: Sage Weil <sage@inktank.com>
Subject: Re: still crashing osds with next branch
Date: Wed, 20 Jun 2012 10:35:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206201034120.14284@cobra.newdream.net>
References: <4FE19FF2.2090302@profihost.ag> <4FE1D06A.1080906@profihost.ag>
 <4FE2062A.7060508@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37295 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753231Ab2FTRfw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jun 2012 13:35:52 -0400
In-Reply-To: <4FE2062A.7060508@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 20 Jun 2012, Stefan Priebe wrote:
> Nobody an idea? Should i open up bugs in tracker?

Let's open up bugs.  If they are reproducible, debug osd = 20 logs would 
be awesome!

Also, the crash you mentioned in your earlier email we did see: 

	http://tracker.newdream.net/issues/2599

If you have logs from that crash, those would also be helpful.

Thanks!
sage


> 
> Am 20.06.2012 15:30, schrieb Stefan Priebe - Profihost AG:
> > Mhm always the same osd's are crashing now again. Mostly while shutting
> > down or restarting a KVM machine.
> > 
> > This time:
> > ####### Server 1 ########################
> >       0> 2012-06-20 11:59:06.499813 7f1664052700 -1 *** Caught signal
> > (Segmentation fault) **
> >   in thread 7f1664052700
> > 
> >   ceph version 0.47.2-521-g88c7629
> > (commit:88c7629e041699c25a7c91114bd1ac4ffc64c3eb)
> >   1: /usr/bin/ceph-osd() [0x70e429]
> >   2: (()+0xeff0) [0x7f16714d5ff0]
> >   3: (OSD::disconnect_session_watches(OSD::Session*)+0x418) [0x5c80b8]
> >   4: (OSD::ms_handle_reset(Connection*)+0x13b) [0x5c88db]
> >   5: (SimpleMessenger::dispatch_entry()+0x1145) [0x72ca85]
> >   6: (SimpleMessenger::DispatchThread::entry()+0xd) [0x719dad]
> >   7: (()+0x68ca) [0x7f16714cd8ca]
> >   8: (clone()+0x6d) [0x7f166fb51c0d]
> >   NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> > needed to interpret this.
> > 
> > --- end dump of recent events ---
> > 
> > 
> > And the
> > ####### Server 2 ########################
> > 
> >   thread 7ff933ef4700 time 2012-06-20 15:20:12.450641
> > osd/ReplicatedPG.cc: 968: FAILED assert(obc->registered)
> > 
> >   ceph version 0.47.2-521-g88c7629
> > (commit:88c7629e041699c25a7c91114bd1ac4ffc64c3eb)
> >   1: (ReplicatedPG::do_op(std::tr1::shared_ptr<OpRequest>)+0x34a0)
> > [0x56c3c0]
> >   2: (PG::do_request(std::tr1::shared_ptr<OpRequest>)+0x1af) [0x61e8cf]
> >   3: (OSD::dequeue_op(PG*)+0x39a) [0x5b43ca]
> >   4: (ThreadPool::worker()+0xb38) [0x7bbf78]
> >   5: (ThreadPool::WorkThread::entry()+0xd) [0x5f1dad]
> >   6: (()+0x68ca) [0x7ff9444768ca]
> >   7: (clone()+0x6d) [0x7ff942afac0d]
> >   NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> > needed to interpret this.
> > 
> >       0> 2012-06-20 15:20:12.466828 7ff939800700 -1 ./common/Mutex.h: In
> > function 'void Mutex::Lock(bool)' thread 7ff939800700 time 2
> > 012-06-20 15:20:12.466152
> > ./common/Mutex.h: 110: FAILED assert(r == 0)
> > 
> >   ceph version 0.47.2-521-g88c7629
> > (commit:88c7629e041699c25a7c91114bd1ac4ffc64c3eb)
> >   1: /usr/bin/ceph-osd() [0x51a05d]
> >   2: (ReplicatedPG::C_OSD_OndiskWriteUnlock::finish(int)+0x2a) [0x579c3a]
> >   3: (FileStore::_finish_op(FileStore::OpSequencer*)+0x2dc) [0x68422c]
> >   4: (ThreadPool::worker()+0xbb7) [0x7bbff7]
> >   5: (ThreadPool::WorkThread::entry()+0xd) [0x5f1dad]
> >   6: (()+0x68ca) [0x7ff9444768ca]
> >   7: (clone()+0x6d) [0x7ff942afac0d]
> >   NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> > needed to interpret this.
> > 
> > --- end dump of recent events ---
> > 2012-06-20 15:20:12.511987 7ff933ef4700 -1 *** Caught signal (Aborted) **
> >   in thread 7ff933ef4700
> > 
> >   ceph version 0.47.2-521-g88c7629
> > (commit:88c7629e041699c25a7c91114bd1ac4ffc64c3eb)
> >   1: /usr/bin/ceph-osd() [0x70e429]
> >   2: (()+0xeff0) [0x7ff94447eff0]
> >   3: (gsignal()+0x35) [0x7ff942a5d225]
> >   4: (abort()+0x180) [0x7ff942a60030]
> >   5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7ff9432f1dc5]
> >   6: (()+0xcb166) [0x7ff9432f0166]
> >   7: (()+0xcb193) [0x7ff9432f0193]
> >   8: (()+0xcb28e) [0x7ff9432f028e]
> >   9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> > const*)+0x940) [0x78ae90]
> >   10: (ReplicatedPG::do_op(std::tr1::shared_ptr<OpRequest>)+0x34a0)
> > [0x56c3c0]
> >   11: (PG::do_request(std::tr1::shared_ptr<OpRequest>)+0x1af) [0x61e8cf]
> >   12: (OSD::dequeue_op(PG*)+0x39a) [0x5b43ca]
> >   13: (ThreadPool::worker()+0xb38) [0x7bbf78]
> >   14: (ThreadPool::WorkThread::entry()+0xd) [0x5f1dad]
> >   15: (()+0x68ca) [0x7ff9444768ca]
> >   16: (clone()+0x6d) [0x7ff942afac0d]
> >   NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> > needed to interpret this.
> > 
> > --- begin dump of recent events ---
> >       0> 2012-06-20 15:20:12.511987 7ff933ef4700 -1 *** Caught signal
> > (Aborted) **
> >   in thread 7ff933ef4700
> > 
> >   ceph version 0.47.2-521-g88c7629
> > (commit:88c7629e041699c25a7c91114bd1ac4ffc64c3eb)
> >   1: /usr/bin/ceph-osd() [0x70e429]
> >   2: (()+0xeff0) [0x7ff94447eff0]
> >   3: (gsignal()+0x35) [0x7ff942a5d225]
> >   4: (abort()+0x180) [0x7ff942a60030]
> >   5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7ff9432f1dc5]
> >   6: (()+0xcb166) [0x7ff9432f0166]
> >   7: (()+0xcb193) [0x7ff9432f0193]
> >   8: (()+0xcb28e) [0x7ff9432f028e]
> >   9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> > const*)+0x940) [0x78ae90]
> >   10: (ReplicatedPG::do_op(std::tr1::shared_ptr<OpRequest>)+0x34a0)
> > [0x56c3c0]
> >   11: (PG::do_request(std::tr1::shared_ptr<OpRequest>)+0x1af) [0x61e8cf]
> >   12: (OSD::dequeue_op(PG*)+0x39a) [0x5b43ca]
> >   13: (ThreadPool::worker()+0xb38) [0x7bbf78]
> >   14: (ThreadPool::WorkThread::entry()+0xd) [0x5f1dad]
> >   15: (()+0x68ca) [0x7ff9444768ca]
> >   16: (clone()+0x6d) [0x7ff942afac0d]
> >   NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> > needed to interpret this.
> > 
> > --- end dump of recent events ---
> > 
> > 
> > Am 20.06.2012 12:03, schrieb Stefan Priebe - Profihost AG:
> > > Hello list,
> > > 
> > > i'm still seeing osd crashes with next branch under KVM load. If you
> > > need the core dump please tell me.
> > > 
> > > Here are TWO different crashes.
> > > 
> > > Here are the last log lines:
> > > 
> > > ########### CRASH 1 ###########
> > > 
> > > -3> 2012-06-20 11:59:06.446836 7f1660f4b700 0 osd.13 105 pg[4.64b( v
> > > 105'29708 (103'28588,105'29708] n=25 ec=56 les/c 105/105 104/104/104)
> > > [13] r=0 lpr=104 mlcod 105'29708 active+degraded] watch:
> > > oi.user_version=28492
> > > -2> 2012-06-20 11:59:06.496350 7f166074a700 0 osd.13 105 pg[4.64b( v
> > > 105'29709 (103'28588,105'29709] n=25 ec=56 les/c 105/105 104/104/104)
> > > [13] r=0 lpr=104 mlcod 105'29709 active+degraded] watch:
> > > ctx->obc=0x9f94840 cookie=1 oi.version=29709 ctx->at_version=105'29710
> > > -1> 2012-06-20 11:59:06.496386 7f166074a700 0 osd.13 105 pg[4.64b( v
> > > 105'29709 (103'28588,105'29709] n=25 ec=56 les/c 105/105 104/104/104)
> > > [13] r=0 lpr=104 mlcod 105'29709 active+degraded] watch:
> > > oi.user_version=28492
> > > 0> 2012-06-20 11:59:06.499813 7f1664052700 -1 *** Caught signal
> > > (Segmentation fault) **
> > > in thread 7f1664052700
> > > 
> > > ceph version 0.47.2-521-g88c7629
> > > (commit:88c7629e041699c25a7c91114bd1ac4ffc64c3eb)
> > > 1: /usr/bin/ceph-osd() [0x70e429]
> > > 2: (()+0xeff0) [0x7f16714d5ff0]
> > > 3: (OSD::disconnect_session_watches(OSD::Session*)+0x418) [0x5c80b8]
> > > 4: (OSD::ms_handle_reset(Connection*)+0x13b) [0x5c88db]
> > > 5: (SimpleMessenger::dispatch_entry()+0x1145) [0x72ca85]
> > > 6: (SimpleMessenger::DispatchThread::entry()+0xd) [0x719dad]
> > > 7: (()+0x68ca) [0x7f16714cd8ca]
> > > 8: (clone()+0x6d) [0x7f166fb51c0d]
> > > NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed
> > > to interpret this.
> > > 
> > > --- end dump of recent events ---
> > > 
> > > 
> > > ########### CRASH 2 ###########
> > > 
> > > 0> 2012-06-20 11:56:46.339027 7f39d5c0a700 -1 ./common/Mutex.h: In
> > > function 'void Mutex::Lock(bool)' thread 7f39d5c0a700 time 2012-06-20
> > > 11:56:46.338403
> > > ./common/Mutex.h: 110: FAILED assert(r == 0)
> > > 
> > > ceph version 0.47.2-521-g88c7629
> > > (commit:88c7629e041699c25a7c91114bd1ac4ffc64c3eb)
> > > 1: /usr/bin/ceph-osd() [0x51a05d]
> > > 2: (ReplicatedPG::C_OSD_OndiskWriteUnlock::finish(int)+0x2a) [0x579c3a]
> > > 3: (FileStore::_finish_op(FileStore::OpSequencer*)+0x2dc) [0x68422c]
> > > 4: (ThreadPool::worker()+0xbb7) [0x7bbff7]
> > > 5: (ThreadPool::WorkThread::entry()+0xd) [0x5f1dad]
> > > 6: (()+0x68ca) [0x7f39e10818ca]
> > > 7: (clone()+0x6d) [0x7f39df705c0d]
> > > NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed
> > > to interpret this.
> > > 
> > > --- end dump of recent events ---
> > > 2012-06-20 11:56:46.355013 7f39d5c0a700 -1 *** Caught signal (Aborted) **
> > > in thread 7f39d5c0a700
> > > 
> > > ceph version 0.47.2-521-g88c7629
> > > (commit:88c7629e041699c25a7c91114bd1ac4ffc64c3eb)
> > > 1: /usr/bin/ceph-osd() [0x70e429]
> > > 2: (()+0xeff0) [0x7f39e1089ff0]
> > > 3: (gsignal()+0x35) [0x7f39df668225]
> > > 4: (abort()+0x180) [0x7f39df66b030]
> > > 5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f39dfefcdc5]
> > > 6: (()+0xcb166) [0x7f39dfefb166]
> > > 7: (()+0xcb193) [0x7f39dfefb193]
> > > 8: (()+0xcb28e) [0x7f39dfefb28e]
> > > 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> > > const*)+0x940) [0x78ae90]
> > > 10: /usr/bin/ceph-osd() [0x51a05d]
> > > 11: (ReplicatedPG::C_OSD_OndiskWriteUnlock::finish(int)+0x2a) [0x579c3a]
> > > 12: (FileStore::_finish_op(FileStore::OpSequencer*)+0x2dc) [0x68422c]
> > > 13: (ThreadPool::worker()+0xbb7) [0x7bbff7]
> > > 14: (ThreadPool::WorkThread::entry()+0xd) [0x5f1dad]
> > > 15: (()+0x68ca) [0x7f39e10818ca]
> > > 16: (clone()+0x6d) [0x7f39df705c0d]
> > > NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed
> > > to interpret this.
> > > 
> > > --- begin dump of recent events ---
> > > 0> 2012-06-20 11:56:46.355013 7f39d5c0a700 -1 *** Caught signal
> > > (Aborted) **
> > > in thread 7f39d5c0a700
> > > 
> > > ceph version 0.47.2-521-g88c7629
> > > (commit:88c7629e041699c25a7c91114bd1ac4ffc64c3eb)
> > > 1: /usr/bin/ceph-osd() [0x70e429]
> > > 2: (()+0xeff0) [0x7f39e1089ff0]
> > > 3: (gsignal()+0x35) [0x7f39df668225]
> > > 4: (abort()+0x180) [0x7f39df66b030]
> > > 5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f39dfefcdc5]
> > > 6: (()+0xcb166) [0x7f39dfefb166]
> > > 7: (()+0xcb193) [0x7f39dfefb193]
> > > 8: (()+0xcb28e) [0x7f39dfefb28e]
> > > 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> > > const*)+0x940) [0x78ae90]
> > > 10: /usr/bin/ceph-osd() [0x51a05d]
> > > 11: (ReplicatedPG::C_OSD_OndiskWriteUnlock::finish(int)+0x2a) [0x579c3a]
> > > 12: (FileStore::_finish_op(FileStore::OpSequencer*)+0x2dc) [0x68422c]
> > > 13: (ThreadPool::worker()+0xbb7) [0x7bbff7]
> > > 14: (ThreadPool::WorkThread::entry()+0xd) [0x5f1dad]
> > > 15: (()+0x68ca) [0x7f39e10818ca]
> > > 16: (clone()+0x6d) [0x7f39df705c0d]
> > > NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed
> > > to interpret this.
> > > 
> > > --- end dump of recent events ---
> > > 
> > > Stefan
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
