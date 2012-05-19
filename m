From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Journal too small
Date: Fri, 18 May 2012 18:51:13 -0700
Message-ID: <4FB6FC91.2060903@inktank.com>
References: <201205171259.55967.karol.jurak@gmail.com> <4FB54AA8.7080906@inktank.com> <201205181256.50302.karol.jurak@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33827 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759473Ab2ESBvR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 May 2012 21:51:17 -0400
Received: by pbbrp8 with SMTP id rp8so4637845pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 18 May 2012 18:51:16 -0700 (PDT)
In-Reply-To: <201205181256.50302.karol.jurak@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Karol Jurak <karol.jurak@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 05/18/2012 03:56 AM, Karol Jurak wrote:
> On Thursday 17 of May 2012 20:59:52 Josh Durgin wrote:
>> On 05/17/2012 03:59 AM, Karol Jurak wrote:
>>> How serious is such situation? Do the OSDs know how to handle it
>>> correctly? Or could this result in some data loss or corruption?
>>> After the recovery finished (ceph -w showed that all PGs are in
>>> active+clean state) I noticed that a few rbd images were corrupted.
>>
>> As Sage mentioned, the OSDs know how to handle full journals correctly.
>>
>> I'd like to figure out how your rbd images got corrupted, if possible.
>>
>> How did you notice the corruption?
>>
>> Has your cluster always run 0.46, or did you upgrade from earlier
>> versions?
>>
>> What happened to the cluster between your last check for corruption and
>> now? Did your use of it or any ceph client or server configuration
>> change?
>
> My question about journal is actually connected to a larger case I'm
> currently trying to investigate.
>
> The cluster initially run v0.45 but I upgraded it to v0.46 because of the
> issue I described in this bug report (upgrade didn't resolve it):
>
> http://tracker.newdream.net/issues/2446

Could you attach an archive of all the osdmaps from to that bug?
You can extract them with something like:

for epoch in $(seq 1 2000)
do
   ceph osd getmap $epoch -o osdmap_$epoch
done

> The cluster consisted of 26 OSDs and used the crushmap which had a
> structure identical to that of a default crushmap constructed during the
> cluster creation. It had the unknownrack which contained 26 hosts and
> every host contained one OSD.
>
> Problems started when one of my collegues created and installed into the
> cluster the new crush map which introduced a couple of new racks, changed
> the placement rule to 'step chooseleaf firstn 0 type rack' and changed the
> weights of most of the OSDs to 0 (they were meant to be removed from the
> cluster). I don't have the exact copy of that crushmap but my collegue
> reconstructed it from memory the best he could. It's attached as new-
> crushmap.txt.
>
> The OSDs reacted to the new crushmap by allocating large amounts of
> memory. Most of them had only 1 or 2 GB of RAM. That proved to be not
> enough and the Xen VMs hosting the OSDs crashed. It turned out later, that
> most of the OSDs required as much as 6 to 10 GB of memory to complete the
> peering phase (ceph -w showed large number of PGs in that state while the
> OSDs were allocating memory).
>
> One factor which I think might have played significant role in this
> situation was the large number of PGs - 20000. Our idea was to
> incrementally build the cluster consisting of approximately 200 OSDs,
> hence the 20000 PGs.

Large numbers of PGs per OSD are problematic due to memory usage linear
in the number of PGs, and increased during peering and recovery.
We recommend keeping the number of PGs per OSD on the order of 100s.
In the future, it'll be possible to split PGs to increase their number
when your cluster grows, or merge them when it shrinks. For now you
should probably wait to create a pool with a large number of PGs until
you have enough OSDs up and in to handle them.

PG splitting is http://tracker.newdream.net/issues/1515

Your crushmap with many devices with weight 0 might also have
contributed to the problem due an issue with local retries.
See:

http://tracker.newdream.net/issues/2047
http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/6244

A workaround in the meantime is to remove devices in deep hierarchies
from the crush map.

> I see some items in your issue tracker that look like they may be
> addressing this large memory consumption issue:
>
> http://tracker.newdream.net/issues/2321
> http://tracker.newdream.net/issues/2041

Those and the recent improvements in OSD map processing will help.

> I reverted to the default crushmap, changed replication level to 1 and
> marked all OSDs but 2 out. That allowed me to finally recover the cluster
> and bring it online but in the process all the OSDs crashed numerous
> times. They were either killed by the OOM Killer or the whole VMs were
> destroyed by me because they were unresponsive or the OSDs crashed due to
> failed asserts such as:
>
> ====
> 2012-05-10 13:07:39.869811 7f878645a700 -1 common/HeartbeatMap.cc: In
> function 'bool ceph::HeartbeatMap::_check(ceph::heartbeat_
> handle_d*, const char*, time_t)' thread 7f878645a700 time 2012-05-10
> 13:07:38.816680
> common/HeartbeatMap.cc: 78: FAILED assert(0 == "hit suicide timeout")
>
>   ceph version 0.46 (commit:cb7f1c9c7520848b0899b26440ac34a8acea58d1)
>   1: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char const*,
> long)+0x270) [0x7a32e0]
>   2: (ceph::HeartbeatMap::is_healthy()+0x87) [0x7a34f7]
>   3: (ceph::HeartbeatMap::check_touch_file()+0x28) [0x7a3748]
>   4: (CephContextServiceThread::entry()+0x5c) [0x64c27c]
>   5: (()+0x68ba) [0x7f87888be8ba]
>   6: (clone()+0x6d) [0x7f8786f4302d]
> ====

This is unresponsiveness again.

> ====
> 2012-05-10 16:33:30.437730 7f062e9c1700 -1 osd/PG.cc: In function 'void
> PG::merge_log(ObjectStore::Transaction&, pg_info_t&, pg_
> log_t&, int)' thread 7f062e9c1700 time 2012-05-10 16:33:30.369211
> osd/PG.cc: 369: FAILED assert(log.head>= olog.tail&&  olog.head>=
> log.tail)
>
>   ceph version 0.46 (commit:cb7f1c9c7520848b0899b26440ac34a8acea58d1)
>   1: (PG::merge_log(ObjectStore::Transaction&, pg_info_t&, pg_log_t&,
> int)+0x1f14) [0x77d894]
>   2: (PG::RecoveryState::Stray::react(PG::RecoveryState::MLogRec
> const&)+0x2c5) [0x77dba5]
>   3: (boost::statechart::simple_state<PG::RecoveryState::Stray,
> PG::RecoveryState::Started, boost::mpl::list<mpl_::na, mpl_::na, mpl_::na,
> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
> mpl_::na, mpl_::na, mpl_::na>,
> (boost::statechart::history_mode)0>::react_impl(boost::statechart::event_base
> const&, void const*)+0x213) [0x794d93]
>   4: (boost::statechart::state_machine<PG::RecoveryState::RecoveryMachine,
> PG::RecoveryState::Initial, std::allocator<void>,
> boost::statechart::null_exception_translator>::process_event(boost::statechart::event_base
> const&)+0x6b) [0x78c3cb]
>   5: (PG::RecoveryState::handle_log(int, MOSDPGLog*,
> PG::RecoveryCtx*)+0x1a6) [0x745b76]
>   6: (OSD::handle_pg_log(std::tr1::shared_ptr<OpRequest>)+0x56f) [0x5e1b8f]
>   7: (OSD::dispatch_op(std::tr1::shared_ptr<OpRequest>)+0x13b) [0x5e291b]
>   8: (OSD::_dispatch(Message*)+0x17d) [0x5e7afd]
>   9: (OSD::ms_dispatch(Message*)+0x1df) [0x5e83cf]
>   10: (SimpleMessenger::dispatch_entry()+0x979) [0x6dadf9]
>   11: (SimpleMessenger::DispatchThread::entry()+0xd) [0x613e8d]
>   12: (()+0x68ba) [0x7f063c63c8ba]
>   13: (clone()+0x6d) [0x7f063acc102d]
> ====

This is a bug. If it's reproducible, could you generate logs of it
happening with 'debug osd = 20'?

> Although 'ceph -w' showed that all PGs are in active+clean state, during
> the attempt to start the VMs which had their disk images on rbd devices,
> fsck revealed multiple filesystem errors.

Were any of the osds restarted when they were running 0.45? There were
a couple issues with journal replay on non-btrfs that were fixed in 0.46.

If any of the nodes were powered off, it would be good to know whether
Xen was flushing disk caches for the VMs running your OSDs as well.

Josh
