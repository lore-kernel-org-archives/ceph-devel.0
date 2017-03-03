From: Mike Lovell <mike.lovell-Kvon/JIRTjNl57MIdRCFDg@public.gmane.org>
Subject: osds crashing during hit_set_trim and
	hit_set_remove_all
Date: Fri, 3 Mar 2017 03:35:25 -0700
Message-ID: <CAK9wOaDWaX5QGwh07wNSaU9ormyin4WhFzmNqOi+7sN2_=V4JQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1047960617=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============1047960617==
Content-Type: multipart/alternative; boundary=001a113db09a84ca2c0549d11a01

--001a113db09a84ca2c0549d11a01
Content-Type: text/plain; charset=UTF-8

i started an upgrade process to go from 0.94.7 to 10.2.5 on a production
cluster that is using cache tiering. this cluster has 3 monitors, 28
storage nodes, around 370 osds. the upgrade of the monitors completed
without issue. i then upgraded 2 of the storage nodes, and after the
restarts, the osds started crashing during hit_set_trim. here is some of
the output from the log.

2017-03-02 22:41:32.338290 7f8bfd6d7700 -1 osd/ReplicatedPG.cc: In function
'void ReplicatedPG::hit_set_trim(ReplicatedPG::RepGather*, unsigned int)'
thread 7f8bfd6d7700 time 2017-03-02 22:41:32.335020
osd/ReplicatedPG.cc: 10514: FAILED assert(obc)

 ceph version 0.94.7 (d56bdf93ced6b80b07397d57e3fa68fe68304432)
 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x85) [0xbddac5]
 2: (ReplicatedPG::hit_set_trim(ReplicatedPG::RepGather*, unsigned
int)+0x75f) [0x87e48f]
 3: (ReplicatedPG::hit_set_persist()+0xedb) [0x87f4ab]
 4: (ReplicatedPG::do_op(std::tr1::shared_ptr<OpRequest>&)+0xe3a) [0x8a0d1a]
 5: (ReplicatedPG::do_request(std::tr1::shared_ptr<OpRequest>&,
ThreadPool::TPHandle&)+0x68a) [0x83be4a]
 6: (OSD::dequeue_op(boost::intrusive_ptr<PG>,
std::tr1::shared_ptr<OpRequest>, ThreadPool::TPHandle&)+0x405) [0x69a5c5]
 7: (OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*)+0x333) [0x69ab33]
 8: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x86f)
[0xbcd1cf]
 9: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0xbcf300]
 10: (()+0x7dc5) [0x7f8c1c209dc5]
 11: (clone()+0x6d) [0x7f8c1aceaced]

it started on just one osd and then spread to others until most of the osds
that are part of the cache tier were crashing. that was happening on both
the osds that were running jewel and on the ones running hammer. in the
process of trying to sort this out, the use_gmt_hitset option was set to
true and all of the osds were upgraded to hammer. we still have not been
able to determine a cause or a fix.

it looks like when hit_set_trim and hit_set_remove_all are being called,
they are calling hit_set_archive_object() to generate a name based on a
timestamp and then calling get_object_context() which then returns nothing
and triggers an assert.

i raised the debug_osd to 10/10 and then analyzed the logs after the crash.
i found the following in the ceph osd log afterwards.

2017-03-03 03:10:31.918470 7f218c842700 10 osd.146 pg_epoch: 266043
pg[19.5d4( v 264786'61233923 (262173'61230715,264786'61233923]
local-les=266043 n=393 ec=83762 les/c/f 266043/264767/0
266042/266042/266042) [146,116,179] r=0 lpr=266042
 pi=264766-266041/431 crt=262323'61233250 lcod 0'0 mlcod 0'0
active+degraded NIBBLEWISE] get_object_context: no obc for soid
19:2ba00000:.ceph-internal::hit_set_19.5d4_archive_2017-03-03
05%3a55%3a58.459084Z_2017-03-03 05%3a56%3a58.98101
6Z:head and !can_create
2017-03-03 03:10:31.921064 7f2194051700 10 osd.146 266043 do_waiters --
start
2017-03-03 03:10:31.921072 7f2194051700 10 osd.146 266043 do_waiters --
finish
2017-03-03 03:10:31.921076 7f2194051700  7 osd.146 266043 handle_pg_notify
from osd.255
2017-03-03 03:10:31.921096 7f2194051700 10 osd.146 266043 do_waiters --
start
2017-03-03 03:10:31.921099 7f2194051700 10 osd.146 266043 do_waiters --
finish
2017-03-03 03:10:31.925858 7f218c041700 -1 osd/ReplicatedPG.cc: In function
'void ReplicatedPG::hit_set_remove_all()' thread 7f218c041700 time
2017-03-03 03:10:31.918201
osd/ReplicatedPG.cc: 11494: FAILED assert(obc)

 ceph version 10.2.5 (c461ee19ecbc0c5c330aca20f7392c9a00730367)
 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x85) [0x7f21acee9425]
 2: (ReplicatedPG::hit_set_remove_all()+0x412) [0x7f21ac9cba92]
 3: (ReplicatedPG::on_activate()+0x6dd) [0x7f21ac9f73fd]
 4: (PG::RecoveryState::Active::react(PG::AllReplicasActivated
const&)+0xac) [0x7f21ac916adc]
 5: (boost::statechart::simple_state<PG::RecoveryState::Active,
PG::RecoveryState::Primary, PG::RecoveryState::Activating,
(boost::statechart::history_mode)0>::react_impl(boost::statechart::event_base
const&, void const*)+0x179) [0x7f21a
c974909]
 6: (boost::statechart::simple_state<PG::RecoveryState::Activating,
PG::RecoveryState::Active, boost::mpl::list<mpl_::na, mpl_::na, mpl_::na,
mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
mpl_::na, mpl_::na, mpl_:
:na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na>,
(boost::statechart::history_mode)0>::react_impl(boost::statechart::event_base
const&, void const*)+0xcd) [0x7f21ac977ccd]
 7: (boost::statechart::state_machine<PG::RecoveryState::RecoveryMachine,
PG::RecoveryState::Initial, std::allocator<void>,
boost::statechart::null_exception_translator>::send_event(boost::statechart::event_base
const&)+0x6b) [0x7f21ac95
d9cb]
 8: (PG::handle_peering_event(std::shared_ptr<PG::CephPeeringEvt>,
PG::RecoveryCtx*)+0x1f4) [0x7f21ac924d24]
 9: (OSD::process_peering_events(std::list<PG*, std::allocator<PG*> >
const&, ThreadPool::TPHandle&)+0x259) [0x7f21ac87de99]
 10: (OSD::PeeringWQ::_process(std::list<PG*, std::allocator<PG*> > const&,
ThreadPool::TPHandle&)+0x12) [0x7f21ac8c8552]
 11: (ThreadPool::worker(ThreadPool::WorkThread*)+0xa7e) [0x7f21aceda46e]
 12: (ThreadPool::WorkThread::entry()+0x10) [0x7f21acedb350]
 13: (()+0x7dc5) [0x7f21aac04dc5]
 14: (clone()+0x6d) [0x7f21a928f73d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed
to interpret this.

it looks like it was looking for a hit_set with a timestamp
of 05:55:58.459084Z but the timestamp on the log lines is for
3:10:31.921096. we have tried various options of the hit_set_count and
hit_set_period but the osds are still trying to find objects for timestamps
that don't exist. i've looked through the osd pg directories (i.e.
/var/lib/ceph/osd/ceph-##/current/<pg.id>_head) and found hit_set objects
but with wildly different timestamps.

there are a few bugs on tracker that look like their related but we haven't
been able to find a fix from them yet. http://tracker.ceph.com/issues/13185
is the closest one but it hasn't given us a hint on a fix yet.
http://tracker.ceph.com/issues/14399 and http://tracker.ceph.com/issues/9732
also seem related but also haven't helped. we have verified that all nodes
are using the same timezone and have consistent timestamps. we're currently
looking at options to edit the hit_set_setup() code to skip the
hit_set_remove() call and the failing code. this will give us empty hit
sets and the thought is that we will then flush the cache tier and remove
it then add one back. still not sure if its going to work.

does anyone else have any other thoughts about how to handle this or why
this is happening? or what else we could do to get the osds back online?
this has crashed almost all of the cache tier osds and the cluster is
unusable at the moment.

thanks in advance.
mike

--001a113db09a84ca2c0549d11a01
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">i started an upgrade process to go from 0.94.7 to 10.2.5 o=
n a production cluster that is using cache tiering. this cluster has 3 moni=
tors, 28 storage nodes, around 370 osds. the upgrade of the monitors comple=
ted without issue. i then upgraded 2 of the storage nodes, and after the re=
starts, the osds started crashing during hit_set_trim. here is some of the =
output from the log.<div><br></div><div><div>2017-03-02 22:41:32.338290 7f8=
bfd6d7700 -1 osd/ReplicatedPG.cc: In function &#39;void ReplicatedPG::hit_s=
et_trim(ReplicatedPG::RepGather*, unsigned int)&#39; thread 7f8bfd6d7700 ti=
me 2017-03-02 22:41:32.335020</div><div>osd/ReplicatedPG.cc: 10514: FAILED =
assert(obc)</div><div><br></div><div>=C2=A0ceph version 0.94.7 (d56bdf93ced=
6b80b07397d57e3fa68fe68304432)</div><div>=C2=A01: (ceph::__ceph_assert_fail=
(char const*, char const*, int, char const*)+0x85) [0xbddac5]</div><div>=C2=
=A02: (ReplicatedPG::hit_set_trim(ReplicatedPG::RepGather*, unsigned int)+0=
x75f) [0x87e48f]</div><div>=C2=A03: (ReplicatedPG::hit_set_persist()+0xedb)=
 [0x87f4ab]</div><div>=C2=A04: (ReplicatedPG::do_op(std::tr1::shared_ptr&lt=
;OpRequest&gt;&amp;)+0xe3a) [0x8a0d1a]</div><div>=C2=A05: (ReplicatedPG::do=
_request(std::tr1::shared_ptr&lt;OpRequest&gt;&amp;, ThreadPool::TPHandle&a=
mp;)+0x68a) [0x83be4a]</div><div>=C2=A06: (OSD::dequeue_op(boost::intrusive=
_ptr&lt;PG&gt;, std::tr1::shared_ptr&lt;OpRequest&gt;, ThreadPool::TPHandle=
&amp;)+0x405) [0x69a5c5]</div><div>=C2=A07: (OSD::ShardedOpWQ::_process(uns=
igned int, ceph::heartbeat_handle_d*)+0x333) [0x69ab33]</div><div>=C2=A08: =
(ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x86f) [0xbcd1cf=
]</div><div>=C2=A09: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [=
0xbcf300]</div><div>=C2=A010: (()+0x7dc5) [0x7f8c1c209dc5]</div><div>=C2=A0=
11: (clone()+0x6d) [0x7f8c1aceaced]</div></div><div><br></div><div>it start=
ed on just one osd and then spread to others until most of the osds that ar=
e part of the cache tier were crashing. that was happening on both the osds=
 that were running jewel and on the ones running hammer. in the process of =
trying to sort this out, the=C2=A0use_gmt_hitset option was set to true and=
 all of the osds were upgraded to hammer. we still have not been able to de=
termine a cause or a fix.</div><div><br></div><div>it looks like when hit_s=
et_trim and hit_set_remove_all are being called, they are calling hit_set_a=
rchive_object() to generate a name based on a timestamp and then calling ge=
t_object_context() which then returns nothing and triggers an assert.</div>=
<div><br></div><div>i raised the debug_osd to 10/10 and then analyzed the l=
ogs after the crash. i found the following in the ceph osd log afterwards.<=
/div><div><br></div><div><div><div>2017-03-03 03:10:31.918470 7f218c842700 =
10 osd.146 pg_epoch: 266043 pg[19.5d4( v 264786&#39;61233923 (262173&#39;61=
230715,264786&#39;61233923] local-les=3D266043 n=3D393 ec=3D83762 les/c/f 2=
66043/264767/0 266042/266042/266042) [146,116,179] r=3D0 lpr=3D266042</div>=
<div>=C2=A0pi=3D264766-266041/431 crt=3D262323&#39;61233250 lcod 0&#39;0 ml=
cod 0&#39;0 active+degraded NIBBLEWISE] get_object_context: no obc for soid=
 19:2ba00000:.ceph-internal::hit_set_19.5d4_archive_2017-03-03 05%3a55%3a58=
.459084Z_2017-03-03 05%3a56%3a58.98101</div><div>6Z:head and !can_create</d=
iv><div>2017-03-03 03:10:31.921064 7f2194051700 10 osd.146 266043 do_waiter=
s -- start</div><div>2017-03-03 03:10:31.921072 7f2194051700 10 osd.146 266=
043 do_waiters -- finish</div><div>2017-03-03 03:10:31.921076 7f2194051700 =
=C2=A07 osd.146 266043 handle_pg_notify from osd.255</div><div>2017-03-03 0=
3:10:31.921096 7f2194051700 10 osd.146 266043 do_waiters -- start</div><div=
>2017-03-03 03:10:31.921099 7f2194051700 10 osd.146 266043 do_waiters -- fi=
nish</div><div>2017-03-03 03:10:31.925858 7f218c041700 -1 osd/ReplicatedPG.=
cc: In function &#39;void ReplicatedPG::hit_set_remove_all()&#39; thread 7f=
218c041700 time 2017-03-03 03:10:31.918201</div><div>osd/ReplicatedPG.cc: 1=
1494: FAILED assert(obc)</div><div><br></div><div>=C2=A0ceph version 10.2.5=
 (c461ee19ecbc0c5c330aca20f7392c9a00730367)</div><div>=C2=A01: (ceph::__cep=
h_assert_fail(char const*, char const*, int, char const*)+0x85) [0x7f21acee=
9425]</div><div>=C2=A02: (ReplicatedPG::hit_set_remove_all()+0x412) [0x7f21=
ac9cba92]</div><div>=C2=A03: (ReplicatedPG::on_activate()+0x6dd) [0x7f21ac9=
f73fd]</div><div>=C2=A04: (PG::RecoveryState::Active::react(PG::AllReplicas=
Activated const&amp;)+0xac) [0x7f21ac916adc]</div><div>=C2=A05: (boost::sta=
techart::simple_state&lt;PG::RecoveryState::Active, PG::RecoveryState::Prim=
ary, PG::RecoveryState::Activating, (boost::statechart::history_mode)0&gt;:=
:react_impl(boost::statechart::event_base const&amp;, void const*)+0x179) [=
0x7f21a</div><div>c974909]</div><div>=C2=A06: (boost::statechart::simple_st=
ate&lt;PG::RecoveryState::Activating, PG::RecoveryState::Active, boost::mpl=
::list&lt;mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_:=
:na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_:</div><div>:na,=
 mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na&gt;, =
(boost::statechart::history_mode)0&gt;::react_impl(boost::statechart::event=
_base const&amp;, void const*)+0xcd) [0x7f21ac977ccd]</div><div>=C2=A07: (b=
oost::statechart::state_machine&lt;PG::RecoveryState::RecoveryMachine, PG::=
RecoveryState::Initial, std::allocator&lt;void&gt;, boost::statechart::null=
_exception_translator&gt;::send_event(boost::statechart::event_base const&a=
mp;)+0x6b) [0x7f21ac95</div><div>d9cb]</div><div>=C2=A08: (PG::handle_peeri=
ng_event(std::shared_ptr&lt;PG::CephPeeringEvt&gt;, PG::RecoveryCtx*)+0x1f4=
) [0x7f21ac924d24]</div><div>=C2=A09: (OSD::process_peering_events(std::lis=
t&lt;PG*, std::allocator&lt;PG*&gt; &gt; const&amp;, ThreadPool::TPHandle&a=
mp;)+0x259) [0x7f21ac87de99]</div><div>=C2=A010: (OSD::PeeringWQ::_process(=
std::list&lt;PG*, std::allocator&lt;PG*&gt; &gt; const&amp;, ThreadPool::TP=
Handle&amp;)+0x12) [0x7f21ac8c8552]</div><div>=C2=A011: (ThreadPool::worker=
(ThreadPool::WorkThread*)+0xa7e) [0x7f21aceda46e]</div><div>=C2=A012: (Thre=
adPool::WorkThread::entry()+0x10) [0x7f21acedb350]</div><div>=C2=A013: (()+=
0x7dc5) [0x7f21aac04dc5]</div><div>=C2=A014: (clone()+0x6d) [0x7f21a928f73d=
]</div><div>=C2=A0NOTE: a copy of the executable, or `objdump -rdS &lt;exec=
utable&gt;` is needed to interpret this.</div></div></div><div><br></div><d=
iv>it looks like it was looking for a hit_set with a timestamp of=C2=A005:5=
5:58.459084Z but the timestamp on the log lines is for 3:10:31.921096. we h=
ave tried various options of the hit_set_count and hit_set_period but the o=
sds are still trying to find objects for timestamps that don&#39;t exist. i=
&#39;ve looked through the osd pg directories (i.e. /var/lib/ceph/osd/ceph-=
##/current/&lt;<a href=3D"http://pg.id">pg.id</a>&gt;_head) and found hit_s=
et objects but with wildly different timestamps.</div><div><br></div><div>t=
here are a few bugs on tracker that look like their related but we haven&#3=
9;t been able to find a fix from them yet.=C2=A0<a href=3D"http://tracker.c=
eph.com/issues/13185">http://tracker.ceph.com/issues/13185</a> is the close=
st one but it hasn&#39;t given us a hint on a fix yet.=C2=A0<a href=3D"http=
://tracker.ceph.com/issues/14399">http://tracker.ceph.com/issues/14399</a> =
and=C2=A0<a href=3D"http://tracker.ceph.com/issues/9732">http://tracker.cep=
h.com/issues/9732</a> also seem related but also haven&#39;t helped. we hav=
e verified that all nodes are using the same timezone and have consistent t=
imestamps. we&#39;re currently looking at options to edit the hit_set_setup=
() code to skip the hit_set_remove() call and the failing code. this will g=
ive us empty hit sets and the thought is that we will then flush the cache =
tier and remove it then add one back. still not sure if its going to work.<=
/div><div><br></div><div>does anyone else have any other thoughts about how=
 to handle this or why this is happening? or what else we could do to get t=
he osds back online? this has crashed almost all of the cache tier osds and=
 the cluster is unusable at the moment.</div><div><br></div><div>thanks in =
advance.</div><div>mike</div></div>

--001a113db09a84ca2c0549d11a01--

--===============1047960617==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1047960617==--
