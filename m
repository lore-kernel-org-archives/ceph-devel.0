From: Karol Jurak <karol.jurak@gmail.com>
Subject: Re: Journal too small
Date: Mon, 21 May 2012 17:11:06 +0200
Message-ID: <201205211711.07072.karol.jurak@gmail.com>
References: <201205171259.55967.karol.jurak@gmail.com> <201205181256.50302.karol.jurak@gmail.com> <4FB6FC91.2060903@inktank.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:43521 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945Ab2EUPLM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 11:11:12 -0400
Received: by wgbdr13 with SMTP id dr13so5091138wgb.1
        for <ceph-devel@vger.kernel.org>; Mon, 21 May 2012 08:11:11 -0700 (PDT)
In-Reply-To: <4FB6FC91.2060903@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Saturday 19 of May 2012 03:51:13 Josh Durgin wrote:
> On 05/18/2012 03:56 AM, Karol Jurak wrote:
> > My question about journal is actually connected to a larger case I'm
> > currently trying to investigate.
> > 
> > The cluster initially run v0.45 but I upgraded it to v0.46 because of
> > the issue I described in this bug report (upgrade didn't resolve
> > it):
> > 
> > http://tracker.newdream.net/issues/2446
> 
> Could you attach an archive of all the osdmaps from to that bug?
> You can extract them with something like:
> 
> for epoch in $(seq 1 2000)
> do
>    ceph osd getmap $epoch -o osdmap_$epoch
> done

The monitors have deleted the osdmaps from that period, however I managed 
to reproduce this bug and I took a snapshot of osdmap and osdmap_full 
directories of one of the monitors. I attached it to the bug report.

> Large numbers of PGs per OSD are problematic due to memory usage linear
> in the number of PGs, and increased during peering and recovery.
> We recommend keeping the number of PGs per OSD on the order of 100s.
> In the future, it'll be possible to split PGs to increase their number
> when your cluster grows, or merge them when it shrinks. For now you
> should probably wait to create a pool with a large number of PGs until
> you have enough OSDs up and in to handle them.
> 
> PG splitting is http://tracker.newdream.net/issues/1515
> 
> Your crushmap with many devices with weight 0 might also have
> contributed to the problem due an issue with local retries.
> See:
> 
> http://tracker.newdream.net/issues/2047
> http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/6244
> 
> A workaround in the meantime is to remove devices in deep hierarchies
> from the crush map.
>
> > I see some items in your issue tracker that look like they may be
> > addressing this large memory consumption issue:
> > 
> > http://tracker.newdream.net/issues/2321
> > http://tracker.newdream.net/issues/2041
> 
> Those and the recent improvements in OSD map processing will help.

Thanks for info and advice.

> > ====
> > 2012-05-10 13:07:39.869811 7f878645a700 -1 common/HeartbeatMap.cc: In
> > function 'bool ceph::HeartbeatMap::_check(ceph::heartbeat_
> > handle_d*, const char*, time_t)' thread 7f878645a700 time 2012-05-10
> > 13:07:38.816680
> > common/HeartbeatMap.cc: 78: FAILED assert(0 == "hit suicide timeout")
> > 
> >   ceph version 0.46 (commit:cb7f1c9c7520848b0899b26440ac34a8acea58d1)
> >   1: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char
> >   const*,
> > 
> > long)+0x270) [0x7a32e0]
> > 
> >   2: (ceph::HeartbeatMap::is_healthy()+0x87) [0x7a34f7]
> >   3: (ceph::HeartbeatMap::check_touch_file()+0x28) [0x7a3748]
> >   4: (CephContextServiceThread::entry()+0x5c) [0x64c27c]
> >   5: (()+0x68ba) [0x7f87888be8ba]
> >   6: (clone()+0x6d) [0x7f8786f4302d]
> > 
> > ====
> 
> This is unresponsiveness again.

That makes sense. Most OSDs' filestores were on a storage shared with 
other VMs and also their (heavily utilized) swap partitions were on it.

> > ====
> > 2012-05-10 16:33:30.437730 7f062e9c1700 -1 osd/PG.cc: In function
> > 'void PG::merge_log(ObjectStore::Transaction&, pg_info_t&, pg_
> > log_t&, int)' thread 7f062e9c1700 time 2012-05-10 16:33:30.369211
> > osd/PG.cc: 369: FAILED assert(log.head>= olog.tail&&  olog.head>=
> > log.tail)
> > 
> >   ceph version 0.46 (commit:cb7f1c9c7520848b0899b26440ac34a8acea58d1)
> >   1: (PG::merge_log(ObjectStore::Transaction&, pg_info_t&, pg_log_t&,
> > 
> > int)+0x1f14) [0x77d894]
> > 
> >   2: (PG::RecoveryState::Stray::react(PG::RecoveryState::MLogRec
> > 
> > const&)+0x2c5) [0x77dba5]
> > 
> >   3: (boost::statechart::simple_state<PG::RecoveryState::Stray,
> > 
> > PG::RecoveryState::Started, boost::mpl::list<mpl_::na, mpl_::na,
> > mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
> > mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
> > mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na>,
> > (boost::statechart::history_mode)0>::react_impl(boost::statechart::ev
> > ent_base const&, void const*)+0x213) [0x794d93]
> > 
> >   4:
> >   (boost::statechart::state_machine<PG::RecoveryState::RecoveryMachi
> >   ne,
> > 
> > PG::RecoveryState::Initial, std::allocator<void>,
> > boost::statechart::null_exception_translator>::process_event(boost::s
> > tatechart::event_base const&)+0x6b) [0x78c3cb]
> > 
> >   5: (PG::RecoveryState::handle_log(int, MOSDPGLog*,
> > 
> > PG::RecoveryCtx*)+0x1a6) [0x745b76]
> > 
> >   6: (OSD::handle_pg_log(std::tr1::shared_ptr<OpRequest>)+0x56f)
> >   [0x5e1b8f] 7:
> >   (OSD::dispatch_op(std::tr1::shared_ptr<OpRequest>)+0x13b)
> >   [0x5e291b] 8: (OSD::_dispatch(Message*)+0x17d) [0x5e7afd]
> >   9: (OSD::ms_dispatch(Message*)+0x1df) [0x5e83cf]
> >   10: (SimpleMessenger::dispatch_entry()+0x979) [0x6dadf9]
> >   11: (SimpleMessenger::DispatchThread::entry()+0xd) [0x613e8d]
> >   12: (()+0x68ba) [0x7f063c63c8ba]
> >   13: (clone()+0x6d) [0x7f063acc102d]
> > 
> > ====
> 
> This is a bug. If it's reproducible, could you generate logs of it
> happening with 'debug osd = 20'?

Unfortunately I don't know how to reproduce this bug. I've only seen it a 
couple of times on one specific OSD and that OSD was running with logging 
verbosity at default level. However I still have that logs, if they are of 
any help.

> > Although 'ceph -w' showed that all PGs are in active+clean state,
> > during the attempt to start the VMs which had their disk images on
> > rbd devices, fsck revealed multiple filesystem errors.
> 
> Were any of the osds restarted when they were running 0.45? There were
> a couple issues with journal replay on non-btrfs that were fixed in
> 0.46.

I can't recall for sure but I think it's quite possible that some of the 
OSDs were restarted when they were running 0.45. I don't think that any of 
them crashed at that time, though.

> If any of the nodes were powered off, it would be good to know whether
> Xen was flushing disk caches for the VMs running your OSDs as well.

Based on my limited research I think that it's possible that Xen (at least 
older versions of it which we use) does not flush disk caches for the VMs. 
On the other hand I'm almost certain that none of the xen hosts on which 
OSD VMs were running were powered down or crashed at that time. So all I/O 
of OSD VMs should eventually be persisted on disks.

Karol
