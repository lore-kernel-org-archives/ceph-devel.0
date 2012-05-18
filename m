From: Karol Jurak <karol.jurak@gmail.com>
Subject: Re: Journal too small
Date: Fri, 18 May 2012 12:56:50 +0200
Message-ID: <201205181256.50302.karol.jurak@gmail.com>
References: <201205171259.55967.karol.jurak@gmail.com> <4FB54AA8.7080906@inktank.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_yritP9unBly6oGZ"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:50064 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab2ERK5A (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 May 2012 06:57:00 -0400
Received: by wgbdr13 with SMTP id dr13so2665146wgb.1
        for <ceph-devel@vger.kernel.org>; Fri, 18 May 2012 03:56:58 -0700 (PDT)
In-Reply-To: <4FB54AA8.7080906@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

--Boundary-00=_yritP9unBly6oGZ
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Thursday 17 of May 2012 20:59:52 Josh Durgin wrote:
> On 05/17/2012 03:59 AM, Karol Jurak wrote:
> > How serious is such situation? Do the OSDs know how to handle it
> > correctly? Or could this result in some data loss or corruption?
> > After the recovery finished (ceph -w showed that all PGs are in
> > active+clean state) I noticed that a few rbd images were corrupted.
> 
> As Sage mentioned, the OSDs know how to handle full journals correctly.
> 
> I'd like to figure out how your rbd images got corrupted, if possible.
> 
> How did you notice the corruption?
> 
> Has your cluster always run 0.46, or did you upgrade from earlier
> versions?
> 
> What happened to the cluster between your last check for corruption and
> now? Did your use of it or any ceph client or server configuration
> change?

My question about journal is actually connected to a larger case I'm 
currently trying to investigate.

The cluster initially run v0.45 but I upgraded it to v0.46 because of the 
issue I described in this bug report (upgrade didn't resolve it):

http://tracker.newdream.net/issues/2446

The cluster consisted of 26 OSDs and used the crushmap which had a 
structure identical to that of a default crushmap constructed during the 
cluster creation. It had the unknownrack which contained 26 hosts and 
every host contained one OSD.

Problems started when one of my collegues created and installed into the 
cluster the new crush map which introduced a couple of new racks, changed 
the placement rule to 'step chooseleaf firstn 0 type rack' and changed the 
weights of most of the OSDs to 0 (they were meant to be removed from the 
cluster). I don't have the exact copy of that crushmap but my collegue 
reconstructed it from memory the best he could. It's attached as new-
crushmap.txt.

The OSDs reacted to the new crushmap by allocating large amounts of 
memory. Most of them had only 1 or 2 GB of RAM. That proved to be not 
enough and the Xen VMs hosting the OSDs crashed. It turned out later, that 
most of the OSDs required as much as 6 to 10 GB of memory to complete the 
peering phase (ceph -w showed large number of PGs in that state while the 
OSDs were allocating memory).

One factor which I think might have played significant role in this 
situation was the large number of PGs - 20000. Our idea was to 
incrementally build the cluster consisting of approximately 200 OSDs, 
hence the 20000 PGs.

I see some items in your issue tracker that look like they may be 
addressing this large memory consumption issue:

http://tracker.newdream.net/issues/2321
http://tracker.newdream.net/issues/2041

I reverted to the default crushmap, changed replication level to 1 and 
marked all OSDs but 2 out. That allowed me to finally recover the cluster 
and bring it online but in the process all the OSDs crashed numerous 
times. They were either killed by the OOM Killer or the whole VMs were 
destroyed by me because they were unresponsive or the OSDs crashed due to 
failed asserts such as:

====
2012-05-10 13:07:39.869811 7f878645a700 -1 common/HeartbeatMap.cc: In 
function 'bool ceph::HeartbeatMap::_check(ceph::heartbeat_
handle_d*, const char*, time_t)' thread 7f878645a700 time 2012-05-10 
13:07:38.816680
common/HeartbeatMap.cc: 78: FAILED assert(0 == "hit suicide timeout")

 ceph version 0.46 (commit:cb7f1c9c7520848b0899b26440ac34a8acea58d1)
 1: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char const*, 
long)+0x270) [0x7a32e0]
 2: (ceph::HeartbeatMap::is_healthy()+0x87) [0x7a34f7]
 3: (ceph::HeartbeatMap::check_touch_file()+0x28) [0x7a3748]
 4: (CephContextServiceThread::entry()+0x5c) [0x64c27c]
 5: (()+0x68ba) [0x7f87888be8ba]
 6: (clone()+0x6d) [0x7f8786f4302d]
====

or

====
2012-05-10 16:33:30.437730 7f062e9c1700 -1 osd/PG.cc: In function 'void 
PG::merge_log(ObjectStore::Transaction&, pg_info_t&, pg_
log_t&, int)' thread 7f062e9c1700 time 2012-05-10 16:33:30.369211
osd/PG.cc: 369: FAILED assert(log.head >= olog.tail && olog.head >= 
log.tail)

 ceph version 0.46 (commit:cb7f1c9c7520848b0899b26440ac34a8acea58d1)
 1: (PG::merge_log(ObjectStore::Transaction&, pg_info_t&, pg_log_t&, 
int)+0x1f14) [0x77d894]
 2: (PG::RecoveryState::Stray::react(PG::RecoveryState::MLogRec 
const&)+0x2c5) [0x77dba5]
 3: (boost::statechart::simple_state<PG::RecoveryState::Stray, 
PG::RecoveryState::Started, boost::mpl::list<mpl_::na, mpl_::na, mpl_::na, 
mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, 
mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, 
mpl_::na, mpl_::na, mpl_::na>, 
(boost::statechart::history_mode)0>::react_impl(boost::statechart::event_base 
const&, void const*)+0x213) [0x794d93]
 4: (boost::statechart::state_machine<PG::RecoveryState::RecoveryMachine, 
PG::RecoveryState::Initial, std::allocator<void>, 
boost::statechart::null_exception_translator>::process_event(boost::statechart::event_base 
const&)+0x6b) [0x78c3cb]
 5: (PG::RecoveryState::handle_log(int, MOSDPGLog*, 
PG::RecoveryCtx*)+0x1a6) [0x745b76]
 6: (OSD::handle_pg_log(std::tr1::shared_ptr<OpRequest>)+0x56f) [0x5e1b8f]
 7: (OSD::dispatch_op(std::tr1::shared_ptr<OpRequest>)+0x13b) [0x5e291b]
 8: (OSD::_dispatch(Message*)+0x17d) [0x5e7afd]
 9: (OSD::ms_dispatch(Message*)+0x1df) [0x5e83cf]
 10: (SimpleMessenger::dispatch_entry()+0x979) [0x6dadf9]
 11: (SimpleMessenger::DispatchThread::entry()+0xd) [0x613e8d]
 12: (()+0x68ba) [0x7f063c63c8ba]
 13: (clone()+0x6d) [0x7f063acc102d]
====

Although 'ceph -w' showed that all PGs are in active+clean state, during 
the attempt to start the VMs which had their disk images on rbd devices, 
fsck revealed multiple filesystem errors.

Karol

--Boundary-00=_yritP9unBly6oGZ
Content-Type: text/plain;
  charset="ISO-8859-1";
  name="new-crushmap.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="new-crushmap.txt"

# begin crush map

# devices
device 0 osd.0
device 1 osd.1
device 2 osd.2
device 3 osd.3
device 4 osd.4
device 5 osd.5
device 6 osd.6
device 7 osd.7
device 8 osd.8
device 9 osd.9
device 10 osd.10
device 11 osd.11
device 12 osd.12
device 13 osd.13
device 14 osd.14
device 15 osd.15
device 16 osd.16
device 17 osd.17
device 18 osd.18
device 19 osd.19
device 20 osd.20
device 21 osd.21
device 22 osd.22
device 23 osd.23
device 24 osd.24
device 25 osd.25

# types
type 0 osd
type 1 host
type 2 rack
type 3 row
type 4 room
type 5 datacenter
type 6 pool

# buckets
host ceph-backup-osd-1 {
	id -2		# do not change unnecessarily
	# weight 0.000
	alg straw
	hash 0	# rjenkins1
	item osd.0 weight 0.000
}
host ceph-backup-osd-2 {
	id -8		# do not change unnecessarily
	# weight 0.000
	alg straw
	hash 0	# rjenkins1
	item osd.1 weight 0.000
}
host ceph-backup-osd-3 {
	id -4		# do not change unnecessarily
	# weight 0.000
	alg straw
	hash 0	# rjenkins1
	item osd.2 weight 0.000
}
host ceph-backup-osd-4 {
	id -11		# do not change unnecessarily
	# weight 0.000
	alg straw
	hash 0	# rjenkins1
	item osd.3 weight 0.000
}
host ceph-backup-osd-5 {
	id -12		# do not change unnecessarily
	# weight 0.000
	alg straw
	hash 0	# rjenkins1
	item osd.4 weight 0.000
}
host ceph-backup-osd-6 {
	id -5		# do not change unnecessarily
	# weight 0.000
	alg straw
	hash 0	# rjenkins1
	item osd.5 weight 0.000
}
host ceph-backup-osd-7 {
	id -6		# do not change unnecessarily
	# weight 0.000
	alg straw
	hash 0	# rjenkins1
	item osd.6 weight 0.000
}
host ceph-backup-osd-8 {
	id -10		# do not change unnecessarily
	# weight 0.000
	alg straw
	hash 0	# rjenkins1
	item osd.7 weight 0.000
}
host ceph-backup-osd-9 {
	id -9		# do not change unnecessarily
	# weight 0.000
	alg straw
	hash 0	# rjenkins1
	item osd.8 weight 0.000
}
host ceph-backup-osd-10 {
	id -7		# do not change unnecessarily
	# weight 0.000
	alg straw
	hash 0	# rjenkins1
	item osd.9 weight 0.000
}
host ceph-backup-osd-11 {
	id -13		# do not change unnecessarily
	# weight 0.000
	alg straw
	hash 0	# rjenkins1
	item osd.10 weight 0.000
}
host ceph-backup-osd-12 {
	id -22		# do not change unnecessarily
	# weight 0.000
	alg straw
	hash 0	# rjenkins1
	item osd.11 weight 0.000
}
host ceph-backup-osd-13 {
	id -14		# do not change unnecessarily
	# weight 0.000
	alg straw
	hash 0	# rjenkins1
	item osd.12 weight 0.000
}
host ceph-backup-osd-14 {
	id -15		# do not change unnecessarily
	# weight 0.000
	alg straw
	hash 0	# rjenkins1
	item osd.13 weight 0.000
}
host ceph-backup-osd-15 {
	id -16		# do not change unnecessarily
	# weight 0.000
	alg straw
	hash 0	# rjenkins1
	item osd.14 weight 0.000
}
host ceph-backup-osd-16 {
	id -17		# do not change unnecessarily
	# weight 0.000
	alg straw
	hash 0	# rjenkins1
	item osd.15 weight 0.000
}
host ceph-backup-osd-17 {
	id -18		# do not change unnecessarily
	# weight 0.000
	alg straw
	hash 0	# rjenkins1
	item osd.16 weight 0.000
}
host ceph-backup-osd-18 {
	id -19		# do not change unnecessarily
	# weight 0.000
	alg straw
	hash 0	# rjenkins1
	item osd.17 weight 0.000
}
host ceph-backup-osd-19 {
	id -20		# do not change unnecessarily
	# weight 0.000
	alg straw
	hash 0	# rjenkins1
	item osd.18 weight 0.000
}
host ceph-backup-osd-20 {
	id -21		# do not change unnecessarily
	# weight 0.000
	alg straw
	hash 0	# rjenkins1
	item osd.19 weight 0.000
}
host ceph-backup-osd-21 {
	id -23		# do not change unnecessarily
	# weight 2.700
	alg straw
	hash 0	# rjenkins1
	item osd.20 weight 2.700
}
host ceph-backup-osd-22 {
	id -24		# do not change unnecessarily
	# weight 0.000
	alg straw
	hash 0	# rjenkins1
	item osd.21 weight 0.000
}
host ceph-backup-osd-23 {
	id -25		# do not change unnecessarily
	# weight 1.000
	alg straw
	hash 0	# rjenkins1
	item osd.22 weight 1.000
}
host ceph-backup-osd-24 {
	id -26		# do not change unnecessarily
	# weight 2.700
	alg straw
	hash 0	# rjenkins1
	item osd.23 weight 2.700
}
host ceph-backup-osd-25 {
	id -27		# do not change unnecessarily
	# weight 0.000
	alg straw
	hash 0	# rjenkins1
	item osd.24 weight 0.000
}
host ceph-backup-osd-26 {
	id -28		# do not change unnecessarily
	# weight 0.000
	alg straw
	hash 0	# rjenkins1
	item osd.25 weight 0.000
}
rack unknownrack {
	id -3		# do not change unnecessarily
	# weight 0.000
	alg straw
	hash 0	# rjenkins1
	item ceph-backup-osd-1 weight 0.000
	item ceph-backup-osd-2 weight 0.000
	item ceph-backup-osd-3 weight 0.000
	item ceph-backup-osd-4 weight 0.000
	item ceph-backup-osd-5 weight 0.000
	item ceph-backup-osd-6 weight 0.000
	item ceph-backup-osd-7 weight 0.000
	item ceph-backup-osd-8 weight 0.000
	item ceph-backup-osd-9 weight 0.000
	item ceph-backup-osd-10 weight 0.000
	item ceph-backup-osd-11 weight 0.000
	item ceph-backup-osd-12 weight 0.000
	item ceph-backup-osd-13 weight 0.000
	item ceph-backup-osd-14 weight 0.000
	item ceph-backup-osd-15 weight 0.000
	item ceph-backup-osd-16 weight 0.000
	item ceph-backup-osd-17 weight 0.000
	item ceph-backup-osd-18 weight 0.000
	item ceph-backup-osd-19 weight 0.000
	item ceph-backup-osd-20 weight 0.000
}
rack a8 {
	id -29		# do not change unnecessarily
	# weight 5.400
	alg straw
	hash 0	# rjenkins1
	item ceph-backup-osd-21 weight 2.700
	item ceph-backup-osd-24 weight 2.700
}
rack c11 {
	id -30		# do not change unnecessarily
	# weight 4.000
	alg straw
	hash 0	# rjenkins1
	item ceph-backup-osd-23 weight 2.000
	item ceph-backup-osd-22 weight 2.000
}
rack d12 {
	id -31		# do not change unnecessarily
	# weight 2.000
	alg straw
	hash 0	# rjenkins1
	item ceph-backup-osd-26 weight 1.000
	item ceph-backup-osd-25 weight 1.000
}

pool backup {
	id -1		# do not change unnecessarily
	# weight 11.400
	alg straw
	hash 0	# rjenkins1
	item a8 weight 5.400
	item c11 weight 4.000
	item d12 weight 2.000
	item unknownrack weight 0.000
}

# rules
rule data {
	ruleset 0
	type replicated
	min_size 1
	max_size 10
	step take backup
	step chooseleaf firstn 0 type rack
	step emit
}
rule metadata {
	ruleset 1
	type replicated
	min_size 1
	max_size 10
	step take backup
	step chooseleaf firstn 0 type rack
	step emit
}
rule rbd {
	ruleset 2
	type replicated
	min_size 1
	max_size 10
	step take backup
	step chooseleaf firstn 0 type rack
	step emit
}

# end crush map

--Boundary-00=_yritP9unBly6oGZ--
