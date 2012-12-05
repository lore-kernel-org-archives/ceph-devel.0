From: Sage Weil <sage@inktank.com>
Subject: Re: A couple of OSD-crashes after serious network trouble
Date: Wed, 5 Dec 2012 06:54:04 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212050650540.17270@cobra.newdream.net>
References: <50BF2CCB.3000302@filoo.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36464 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754393Ab2LEOyF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Dec 2012 09:54:05 -0500
In-Reply-To: <50BF2CCB.3000302@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oliver Francke <Oliver.Francke@filoo.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 5 Dec 2012, Oliver Francke wrote:
> Hi *,
> 
> around midnight yesterday we faced some layer-2 network problems. OSD's
> started to lose heartbeats and so on. Slow requests... you name it.
> So, after all OSD's doing their work, we had in sum around 6 of them crashed,
> 2 had to be restarted after first start. Should be 8 crashes in total.

The recover_got() crash has definitely been resolved in the recent code.   
The others are hard to read since they've been sorted/summed; the full 
backtrace is better for identifying the crash.  Do you have those 
available?

Thanks!
sage


 > 
> Typical output:
> 
> 
> === 8-< ===
> --- begin dump of recent events ---
>    -10> 2012-12-04 23:35:26.623091 7f1db7895700  5 filestore(/data/osd6-1)
> _do_op 0x21035870 seq 111010292 osr(65.72 0x9e13570)/0x9e13570 start
>     -9> 2012-12-04 23:35:26.623995 7f1db7895700  5 filestore(/data/osd6-1)
> _do_op 0x21035500 seq 111010294 osr(10.3 0x5b5c170)/0x5b5c170 start
>     -8> 2012-12-04 23:35:26.624013 7f1db6893700  5 --OSD::tracker-- reqid:
> client.290626.0:798537, seq: 151093878, time: 2012-12-04 23:35:26.624012,
> event: sub_op_applied, request: osd_sub_op(client.290626.0:798537 65.72
> c9612472/rb.0.2d5e5.39bd39.000000000652/head//65 [] v 8084'770407
> snapset=0=[]:[] snapc=0=[]) v7
>     -7> 2012-12-04 23:35:26.624047 7f1db8096700  5 filestore(/data/osd6-1)
> _do_op 0x21035c80 seq 111010293 osr(65.72 0x9e13570)/0x9e13570 start
>     -6> 2012-12-04 23:35:26.624119 7f1db6893700  5 --OSD::tracker-- reqid:
> client.290626.0:798537, seq: 151093878, time: 2012-12-04 23:35:26.624119,
> event: done, request: osd_sub_op(client.290626.0:798537 65.72
> c9612472/rb.0.2d5e5.39bd39.000000000652/head//65 [] v 8084'770407
> snapset=0=[]:[] snapc=0=[]) v7
>     -5> 2012-12-04 23:35:26.624953 7f1db6893700  5 --OSD::tracker-- reqid:
> client.290626.0:798549, seq: 151093879, time: 2012-12-04 23:35:26.624953,
> event: sub_op_applied, request: osd_sub_op(client.290626.0:798549 65.72
> c9612472/rb.0.2d5e5.39bd39.000000000652/head//65 [] v 8084'770408
> snapset=0=[]:[] snapc=0=[]) v7
>     -4> 2012-12-04 23:35:26.625017 7f1db6893700  5 --OSD::tracker-- reqid:
> client.290626.0:798549, seq: 151093879, time: 2012-12-04 23:35:26.625017,
> event: done, request: osd_sub_op(client.290626.0:798549 65.72
> c9612472/rb.0.2d5e5.39bd39.000000000652/head//65 [] v 8084'770408
> snapset=0=[]:[] snapc=0=[]) v7
>     -3> 2012-12-04 23:35:26.626220 7f1db7895700  5 filestore(/data/osd6-1)
> _do_op 0x21035f00 seq 111010296 osr(6.7 0x5ca4570)/0x5ca4570 start
>     -2> 2012-12-04 23:35:26.626218 7f1db8096700  5 filestore(/data/osd6-1)
> _do_op 0x21035e10 seq 111010295 osr(10.3 0x5b5c170)/0x5b5c170 start
>     -1> 2012-12-04 23:35:26.652283 7f1daed81700  5
> throttle(msgr_dispatch_throttler-cluster 0x2791560) get 1049621 (0 -> 1049621)
>      0> 2012-12-04 23:35:26.654669 7f1db1f89700 -1 *** Caught signal (Aborted)
> **
>  in thread 7f1db1f89700
> 
>  ceph version 0.48.2argonaut (commit:3e02b2fad88c2a95d9c0c86878f10d1beb780bfe)
>  1: /usr/bin/ceph-osd() [0x6edaba]
>  2: (()+0xfcb0) [0x7f1dc34c7cb0]
>  3: (gsignal()+0x35) [0x7f1dc208e425]
>  4: (abort()+0x17b) [0x7f1dc2091b8b]
>  5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f1dc29e769d]
>  6: (()+0xb5846) [0x7f1dc29e5846]
>  7: (()+0xb5873) [0x7f1dc29e5873]
>  8: (()+0xb596e) [0x7f1dc29e596e]
>  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> const*)+0x1de) [0x7a82fe]
>  10: (ReplicatedPG::recover_got(hobject_t, eversion_t)+0x4ae) [0x52b5ee]
>  11: (ReplicatedPG::submit_push_complete(ObjectRecoveryInfo&,
> ObjectStore::Transaction*)+0x470) [0x52ddd0]
>  12:
> (ReplicatedPG::handle_pull_response(std::tr1::shared_ptr<OpRequest>)+0x4d4)
> [0x54b124]
>  13: (ReplicatedPG::sub_op_push(std::tr1::shared_ptr<OpRequest>)+0x98)
> [0x54bef8]
>  14: (ReplicatedPG::do_sub_op(std::tr1::shared_ptr<OpRequest>)+0x3f7)
> [0x54c3a7]
>  15: (PG::do_request(std::tr1::shared_ptr<OpRequest>)+0x9f) [0x60073f]
>  16: (OSD::dequeue_op(PG*)+0x238) [0x5bfaf8]
>  17: (ThreadPool::worker()+0x4d5) [0x79f835]
>  18: (ThreadPool::WorkThread::entry()+0xd) [0x5d87cd]
>  19: (()+0x7e9a) [0x7f1dc34bfe9a]
>  20: (clone()+0x6d) [0x7f1dc214bcbd]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to
> interpret this.
> 
> --- end dump of recent events ---
> 
> === 8-< ===
> 
> A - not very scientific, but useful - aggregation of all OSD-outputs as
> follows. My hope is, that someone says:
> "Uhm, OK, tha's fixed in ..." ;)
> 
> ( count of occurences and corresponding string)
> 
> === 8-< ===
> 
>       4 (boost::statechart::simple_state<PG::RecoveryState::Stray,
>       4 (boost::statechart::state_machine<PG::RecoveryState::RecoveryMachine,
>      18 (ceph::__ceph_assert_fail(char
>      36 (clone()+0x6d)
>      18 (gsignal()+0x35)
>      16 (OSD::dequeue_op(PG*)+0x238)
>      16 (OSD::dequeue_op(PG*)+0x39a)
>       4 (OSD::_dispatch(Message*)+0x173)
>       4 (OSD::dispatch_op(std::tr1::shared_ptr<OpRequest>)+0x11b)
>       4 (OSD::handle_pg_log(std::tr1::shared_ptr<OpRequest>)+0x666)
>       4 (OSD::ms_dispatch(Message*)+0x184)
>      16 (PG::do_request(std::tr1::shared_ptr<OpRequest>)+0x9f)
>      16 (PG::do_request(std::tr1::shared_ptr<OpRequest>)+0xab)
>       4 (PG::merge_log(ObjectStore::Transaction&,
>       4 (PG::RecoveryState::handle_log(int,
>       4 (PG::RecoveryState::Stray::react(PG::RecoveryState::MLogRec
>      16 (ReplicatedPG::do_sub_op(std::tr1::shared_ptr<OpRequest>)+0x32e)
>      16 (ReplicatedPG::do_sub_op(std::tr1::shared_ptr<OpRequest>)+0x3f7)
>      12
> (ReplicatedPG::handle_pull_response(std::tr1::shared_ptr<OpRequest>)+0x4d4)
>      16
> (ReplicatedPG::handle_pull_response(std::tr1::shared_ptr<OpRequest>)+0xb24)
>       4 (ReplicatedPG::handle_push(std::tr1::shared_ptr<OpRequest>)+0x263)
>      32 (ReplicatedPG::recover_got(hobject_t,
>      32 (ReplicatedPG::submit_push_complete(ObjectRecoveryInfo&,
>      12 (ReplicatedPG::sub_op_push(std::tr1::shared_ptr<OpRequest>)+0x98)
>      16 (ReplicatedPG::sub_op_push(std::tr1::shared_ptr<OpRequest>)+0xa2)
>       4 (ReplicatedPG::sub_op_push(std::tr1::shared_ptr<OpRequest>)+0xf3)
>       4 (SimpleMessenger::dispatch_entry()+0x15)
>       4 (SimpleMessenger::DispatchQueue::entry()+0x5e9)
>       4 (SimpleMessenger::DispatchThread::entry()+0xd)
>      16 (ThreadPool::worker()+0x4d5)
>      16 (ThreadPool::worker()+0x76f)
>      32 (ThreadPool::WorkThread::entry()+0xd)
> 
> === 8-< ===
> 
> Everything has cleared up so far, so that's some good news ;)
> 
> Comments welcome,
> 
> Oliver.
> 
> -- 
> 
> Oliver Francke
> 
> filoo GmbH
> Moltkestra?e 25a
> 33330 G?tersloh
> HRB4355 AG G?tersloh
> 
> Gesch?ftsf?hrer: S.Grewing | J.Rehp?hler | C.Kunz
> 
> Folgen Sie uns auf Twitter: http://twitter.com/filoogmbh
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
