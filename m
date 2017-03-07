From: kefu chai <tchaikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: osds crashing during hit_set_trim and
	hit_set_remove_all
Date: Tue, 7 Mar 2017 15:30:05 +0800
Message-ID: <CAJE9aON=pw-x34zGQCP-VtyhmgdgPaq=g4XEvqjsRYR2=88KKA@mail.gmail.com>
References: <CAK9wOaDWaX5QGwh07wNSaU9ormyin4WhFzmNqOi+7sN2_=V4JQ@mail.gmail.com>
	<alpine.DEB.2.11.1703031536480.651@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1703031536480.651-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, Mar 3, 2017 at 11:40 PM, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
> On Fri, 3 Mar 2017, Mike Lovell wrote:
>> i started an upgrade process to go from 0.94.7 to 10.2.5 on a production
>> cluster that is using cache tiering. this cluster has 3 monitors, 28 storage
>> nodes, around 370 osds. the upgrade of the monitors completed without issue.
>> i then upgraded 2 of the storage nodes, and after the restarts, the osds
>> started crashing during hit_set_trim. here is some of the output from the
>> log.
>> 2017-03-02 22:41:32.338290 7f8bfd6d7700 -1 osd/ReplicatedPG.cc: In function
>> 'void ReplicatedPG::hit_set_trim(ReplicatedPG::RepGather*, unsigned int)'
>> thread 7f8bfd6d7700 time 2017-03-02 22:41:32.335020
>> osd/ReplicatedPG.cc: 10514: FAILED assert(obc)
>>
>>  ceph version 0.94.7 (d56bdf93ced6b80b07397d57e3fa68fe68304432)
>>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>> const*)+0x85) [0xbddac5]
>>  2: (ReplicatedPG::hit_set_trim(ReplicatedPG::RepGather*, unsigned
>> int)+0x75f) [0x87e48f]
>>  3: (ReplicatedPG::hit_set_persist()+0xedb) [0x87f4ab]
>>  4: (ReplicatedPG::do_op(std::tr1::shared_ptr<OpRequest>&)+0xe3a) [0x8a0d1a]
>>  5: (ReplicatedPG::do_request(std::tr1::shared_ptr<OpRequest>&,
>> ThreadPool::TPHandle&)+0x68a) [0x83be4a]
>>  6: (OSD::dequeue_op(boost::intrusive_ptr<PG>,
>> std::tr1::shared_ptr<OpRequest>, ThreadPool::TPHandle&)+0x405) [0x69a5c5]
>>  7: (OSD::ShardedOpWQ::_process(unsigned int,
>> ceph::heartbeat_handle_d*)+0x333) [0x69ab33]
>>  8: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x86f)
>> [0xbcd1cf]
>>  9: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0xbcf300]
>>  10: (()+0x7dc5) [0x7f8c1c209dc5]
>>  11: (clone()+0x6d) [0x7f8c1aceaced]
>>
>> it started on just one osd and then spread to others until most of the osds
>> that are part of the cache tier were crashing. that was happening on both
>> the osds that were running jewel and on the ones running hammer. in the
>> process of trying to sort this out, the use_gmt_hitset option was set to
>> true and all of the osds were upgraded to hammer. we still have not been
>> able to determine a cause or a fix.
>>
>> it looks like when hit_set_trim and hit_set_remove_all are being called,
>> they are calling hit_set_archive_object() to generate a name based on a
>> timestamp and then calling get_object_context() which then returns nothing
>> and triggers an assert.
>>
>> i raised the debug_osd to 10/10 and then analyzed the logs after the crash.
>> i found the following in the ceph osd log afterwards.
>>
>> 2017-03-03 03:10:31.918470 7f218c842700 10 osd.146 pg_epoch: 266043
>> pg[19.5d4( v 264786'61233923 (262173'61230715,264786'61233923]
>> local-les=266043 n=393 ec=83762 les/c/f 266043/264767/0
>> 266042/266042/266042) [146,116,179] r=0 lpr=266042
>>  pi=264766-266041/431 crt=262323'61233250 lcod 0'0 mlcod 0'0 active+degraded
>> NIBBLEWISE] get_object_context: no obc for soid
>> 19:2ba00000:.ceph-internal::hit_set_19.5d4_archive_2017-03-03
>> 05%3a55%3a58.459084Z_2017-03-03 05%3a56%3a58.98101
>> 6Z:head and !can_create
>> 2017-03-03 03:10:31.921064 7f2194051700 10 osd.146 266043 do_waiters --
>> start
>> 2017-03-03 03:10:31.921072 7f2194051700 10 osd.146 266043 do_waiters --
>> finish
>> 2017-03-03 03:10:31.921076 7f2194051700  7 osd.146 266043 handle_pg_notify
>> from osd.255
>> 2017-03-03 03:10:31.921096 7f2194051700 10 osd.146 266043 do_waiters --
>> start
>> 2017-03-03 03:10:31.921099 7f2194051700 10 osd.146 266043 do_waiters --
>> finish
>> 2017-03-03 03:10:31.925858 7f218c041700 -1 osd/ReplicatedPG.cc: In function
>> 'void ReplicatedPG::hit_set_remove_all()' thread 7f218c041700 time
>> 2017-03-03 03:10:31.918201
>> osd/ReplicatedPG.cc: 11494: FAILED assert(obc)
>>
>>  ceph version 10.2.5 (c461ee19ecbc0c5c330aca20f7392c9a00730367)
>>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>> const*)+0x85) [0x7f21acee9425]
>>  2: (ReplicatedPG::hit_set_remove_all()+0x412) [0x7f21ac9cba92]
>>  3: (ReplicatedPG::on_activate()+0x6dd) [0x7f21ac9f73fd]
>>  4: (PG::RecoveryState::Active::react(PG::AllReplicasActivated const&)+0xac)
>> [0x7f21ac916adc]
>>  5: (boost::statechart::simple_state<PG::RecoveryState::Active,
>> PG::RecoveryState::Primary, PG::RecoveryState::Activating,(boost::statechart::history_mode)0>::react_impl(boost::statechart::event_ba
>> se const&, void const*)+0x179) [0x7f21a
>> c974909]
>>  6: (boost::statechart::simple_state<PG::RecoveryState::Activating,
>> PG::RecoveryState::Active, boost::mpl::list<mpl_::na, mpl_::na, mpl_::na,
>> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
>> mpl_::na, mpl_::na, mpl_:
>> :na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na>,(boost::statechart::history_mode)0>::react_impl(boost::statechart::event_ba
>> se const&, void const*)+0xcd) [0x7f21ac977ccd]
>>  7: (boost::statechart::state_machine<PG::RecoveryState::RecoveryMachine,
>> PG::RecoveryState::Initial, std::allocator<void>,boost::statechart::null_exception_translator>::send_event(boost::statechart
>> ::event_base const&)+0x6b) [0x7f21ac95
>> d9cb]
>>  8: (PG::handle_peering_event(std::shared_ptr<PG::CephPeeringEvt>,
>> PG::RecoveryCtx*)+0x1f4) [0x7f21ac924d24]
>>  9: (OSD::process_peering_events(std::list<PG*, std::allocator<PG*> >
>> const&, ThreadPool::TPHandle&)+0x259) [0x7f21ac87de99]
>>  10: (OSD::PeeringWQ::_process(std::list<PG*, std::allocator<PG*> > const&,
>> ThreadPool::TPHandle&)+0x12) [0x7f21ac8c8552]
>>  11: (ThreadPool::worker(ThreadPool::WorkThread*)+0xa7e) [0x7f21aceda46e]
>>  12: (ThreadPool::WorkThread::entry()+0x10) [0x7f21acedb350]
>>  13: (()+0x7dc5) [0x7f21aac04dc5]
>>  14: (clone()+0x6d) [0x7f21a928f73d]
>>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to
>> interpret this.
>>
>> it looks like it was looking for a hit_set with a timestamp
>> of 05:55:58.459084Z but the timestamp on the log lines is for
>> 3:10:31.921096. we have tried various options of the hit_set_count and
>> hit_set_period but the osds are still trying to find objects for timestamps
>> that don't exist. i've looked through the osd pg directories (i.e.
>> /var/lib/ceph/osd/ceph-##/current/<pg.id>_head) and found hit_set objects
>> but with wildly different timestamps.
>>
>> there are a few bugs on tracker that look like their related but we haven't
>> been able to find a fix from them yet. http://tracker.ceph.com/issues/13185
>> is the closest one but it hasn't given us a hint on a fix
>> yet. http://tracker.ceph.com/issues/14399
>> and http://tracker.ceph.com/issues/9732 also seem related but also haven't
>> helped. we have verified that all nodes are using the same timezone and have
>> consistent timestamps. we're currently looking at options to edit the
>> hit_set_setup() code to skip the hit_set_remove() call and the failing code.
>> this will give us empty hit sets and the thought is that we will then flush
>> the cache tier and remove it then add one back. still not sure if its going
>> to work.
>>
>> does anyone else have any other thoughts about how to handle this or why
>> this is happening? or what else we could do to get the osds back online?
>> this has crashed almost all of the cache tier osds and the cluster is
>> unusable at the moment.
>
> This looks like it's a variation on the earlier bug, but I'm not sure why
> you're hitting it an others haven't.  In the meantime, to get your cluster
> up, you just need to skip teh hitsets that won't load obc's.   This will
> leave the objects behind but it's not a big deal and can be cleaned up
> later.
>
> See github.com/liewegas/ceph/commit/wip-jewel-nocrash-gmt.  You can build
> that or you should see some (completely untested!) packages appear at
> shaman.ceph.com in an hour or so.
>
> Maybe Kefu knows why this might have triggered?

i pulled together a test at https://github.com/ceph/ceph/pull/13805,
to exercise the scenario where we upgrade from hammer to jewel with a
cache tier, but it failed to reproduce this issue.

maybe we should just skip removing the archive hitset object if it is
missing locally. see https://github.com/ceph/ceph/pull/13821.

>
> sage



-- 
Regards
Kefu Chai
