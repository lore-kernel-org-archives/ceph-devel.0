From: Boris Lukashev <blukashev@sempervictus.com>
Subject: Re: 7915 is not resolved
Date: Mon, 11 Jan 2016 21:00:18 -0500
Message-ID: <CAFUG7CcudK5zu0eezuTmZrsakE4s-oHyPss3cubSRL5txQmA9Q@mail.gmail.com>
References: <CAFUG7Cd4KQRCCYamWQNnGUphY_OCXyeuqbK6DVcWT7AKko5=VA@mail.gmail.com>
	<alpine.DEB.2.11.1601111224120.27580@cpach.fuggernut.com>
	<CAFUG7CfS4uNp=Jxxc5bgf1s_X72Ezb8w5wg2zSdr=UnWCpYCQw@mail.gmail.com>
	<20160111190619.GA22809@localhost>
	<CAFUG7Cf+7wViua5YZCWt11_Q0253F3E4nzUPkfA9PoA8SHsNJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33537 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759558AbcALCAS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jan 2016 21:00:18 -0500
Received: by mail-pf0-f182.google.com with SMTP id e65so54132655pfe.0
        for <ceph-devel@vger.kernel.org>; Mon, 11 Jan 2016 18:00:18 -0800 (PST)
In-Reply-To: <CAFUG7Cf+7wViua5YZCWt11_Q0253F3E4nzUPkfA9PoA8SHsNJA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

In case anyone is following the mailing list later on, we spoke in IRC
and Sage provided a patch - http://fpaste.org/309609/52550203/ which
allows 8/10 OSDs to start (or at least not crash, ust hang sort of) -
one node still refuses to do so, and has two OSDs.
All OSDs which DO start, produce log output until 'done with init,
starting boot process' and seem to speak with the mon, but dont do
anything - all PGs are still marked down while OSD tree shows the
proper OSDs in and up (with two out and down on the "bad node").
RBD doesnt work, rados ls hangs, the mon log shows stale messages a la
"http://pastebin.com/BE98a2HP" which seem to indicate that its still
trying to commit the snapshot which caused all of this in the first
place (the same one preventing the "bad node" from running its OSDs
for more than a few seconds before they crash out in the same ASSERT).

If there is an outstanding message attempting to commit the bad
snapshot on the queue, and the receiving OSDs wont come up, is that
supposed to freeze all of the other ones? Is there no way to drop the
message and "safe boot" (ro or what not) the OSDs to extract data from
them?
Is there a "formal" procedure for saving data from this sort of
craziness? I'm happy to throw it all in a giant zpool and rebuild the
OSDs under Hammer in some clean way, it would just be rather nice to
get back the months of images and volumes in there...

Thank you,
-Boris Lukashev


On Mon, Jan 11, 2016 at 3:13 PM, Boris Lukashev
<blukashev@sempervictus.com> wrote:
> Thank you much - i'll get Hammer built out that way in a bit.
>
> In the meantime, looks like its getting a bit better, but two OSDs are
> still giving me trouble.
> Sage - your patches appear to have saved 4/5 nodes (8/10OSD). Ceph is
> currently resolving state, but osd tree shows the 4 nodes up with
> their respective pairs of OSDs. Thank you ever so much.
> Dmitry/Mirantis - you might want to merge 0.80.11 + these patches into
> your MOS repo for Fuel 7 systems as it may save someone from
> catastrophe down the line (plus you're a bit out of date anyway).
>
> On to the last node, the error logs from the OSDs still show a very
> similar, but slightly different stack trace:
>    -22> 2016-01-11 20:02:37.929902 7f26dadff700  5 osd.6 pg_epoch:
> 84290 pg[11.2d( v 84268'523421 (84261'520420,84268'523421]
> local-les=84266 n=508 ec=38 les/c 84266/84268 84289/84289/84289) [6]
> r=0 lpr=84289 pi=84265-84288/6 crt=84268'523415 lcod 0'0 mlcod 0'0
> inactive] enter Started/Primary/Active
>    -21> 2016-01-11 20:02:37.930111 7f26da5fe700  5 osd.6 pg_epoch:
> 84290 pg[11.25( v 84268'783451 (84261'780450,84268'783451]
> local-les=84268 n=500 ec=38 les/c 84268/84268 84288/84288/84288) [4]
> r=-1 lpr=84289 pi=84197-84287/7 crt=84268'783449 lcod 0'0 inactive
> NOTIFY] exit Reset 0.193889 2 0.000031
>    -20> 2016-01-11 20:02:37.930134 7f26da5fe700  5 osd.6 pg_epoch:
> 84290 pg[11.25( v 84268'783451 (84261'780450,84268'783451]
> local-les=84268 n=500 ec=38 les/c 84268/84268 84288/84288/84288) [4]
> r=-1 lpr=84289 pi=84197-84287/7 crt=84268'783449 lcod 0'0 inactive
> NOTIFY] enter Started
>    -19> 2016-01-11 20:02:37.930146 7f26da5fe700  5 osd.6 pg_epoch:
> 84290 pg[11.25( v 84268'783451 (84261'780450,84268'783451]
> local-les=84268 n=500 ec=38 les/c 84268/84268 84288/84288/84288) [4]
> r=-1 lpr=84289 pi=84197-84287/7 crt=84268'783449 lcod 0'0 inactive
> NOTIFY] enter Start
>    -18> 2016-01-11 20:02:37.930155 7f26da5fe700  1 osd.6 pg_epoch:
> 84290 pg[11.25( v 84268'783451 (84261'780450,84268'783451]
> local-les=84268 n=500 ec=38 les/c 84268/84268 84288/84288/84288) [4]
> r=-1 lpr=84289 pi=84197-84287/7 crt=84268'783449 lcod 0'0 inactive
> NOTIFY] state<Start>: transitioning to Stray
>    -17> 2016-01-11 20:02:37.930168 7f26da5fe700  5 osd.6 pg_epoch:
> 84290 pg[11.25( v 84268'783451 (84261'780450,84268'783451]
> local-les=84268 n=500 ec=38 les/c 84268/84268 84288/84288/84288) [4]
> r=-1 lpr=84289 pi=84197-84287/7 crt=84268'783449 lcod 0'0 inactive
> NOTIFY] exit Start 0.000022 0 0.000000
>    -16> 2016-01-11 20:02:37.930181 7f26da5fe700  5 osd.6 pg_epoch:
> 84290 pg[11.25( v 84268'783451 (84261'780450,84268'783451]
> local-les=84268 n=500 ec=38 les/c 84268/84268 84288/84288/84288) [4]
> r=-1 lpr=84289 pi=84197-84287/7 crt=84268'783449 lcod 0'0 inactive
> NOTIFY] enter Started/Stray
>    -15> 2016-01-11 20:02:37.930428 7f26da5fe700  5 osd.6 pg_epoch:
> 84290 pg[11.3b( v 84268'1233293 (84261'1230292,84268'1233293]
> local-les=84268 n=511 ec=38 les/c 84268/84268 84289/84289/84289) [6]
> r=0 lpr=84289 pi=84267-84288/5 crt=84268'1233291 lcod 0'0 mlcod 0'0
> inactive] exit Reset 0.047014 2 0.000041
>    -14> 2016-01-11 20:02:37.930449 7f26da5fe700  5 osd.6 pg_epoch:
> 84290 pg[11.3b( v 84268'1233293 (84261'1230292,84268'1233293]
> local-les=84268 n=511 ec=38 les/c 84268/84268 84289/84289/84289) [6]
> r=0 lpr=84289 pi=84267-84288/5 crt=84268'1233291 lcod 0'0 mlcod 0'0
> inactive] enter Started
>    -13> 2016-01-11 20:02:37.930460 7f26da5fe700  5 osd.6 pg_epoch:
> 84290 pg[11.3b( v 84268'1233293 (84261'1230292,84268'1233293]
> local-les=84268 n=511 ec=38 les/c 84268/84268 84289/84289/84289) [6]
> r=0 lpr=84289 pi=84267-84288/5 crt=84268'1233291 lcod 0'0 mlcod 0'0
> inactive] enter Start
>    -12> 2016-01-11 20:02:37.930471 7f26da5fe700  1 osd.6 pg_epoch:
> 84290 pg[11.3b( v 84268'1233293 (84261'1230292,84268'1233293]
> local-les=84268 n=511 ec=38 les/c 84268/84268 84289/84289/84289) [6]
> r=0 lpr=84289 pi=84267-84288/5 crt=84268'1233291 lcod 0'0 mlcod 0'0
> inactive] state<Start>: transitioning to Primary
>    -11> 2016-01-11 20:02:37.930484 7f26da5fe700  5 osd.6 pg_epoch:
> 84290 pg[11.3b( v 84268'1233293 (84261'1230292,84268'1233293]
> local-les=84268 n=511 ec=38 les/c 84268/84268 84289/84289/84289) [6]
> r=0 lpr=84289 pi=84267-84288/5 crt=84268'1233291 lcod 0'0 mlcod 0'0
> inactive] exit Start 0.000024 0 0.000000
>    -10> 2016-01-11 20:02:37.930497 7f26da5fe700  5 osd.6 pg_epoch:
> 84290 pg[11.3b( v 84268'1233293 (84261'1230292,84268'1233293]
> local-les=84268 n=511 ec=38 les/c 84268/84268 84289/84289/84289) [6]
> r=0 lpr=84289 pi=84267-84288/5 crt=84268'1233291 lcod 0'0 mlcod 0'0
> inactive] enter Started/Primary
>     -9> 2016-01-11 20:02:37.930510 7f26da5fe700  5 osd.6 pg_epoch:
> 84290 pg[11.3b( v 84268'1233293 (84261'1230292,84268'1233293]
> local-les=84268 n=511 ec=38 les/c 84268/84268 84289/84289/84289) [6]
> r=0 lpr=84289 pi=84267-84288/5 crt=84268'1233291 lcod 0'0 mlcod 0'0
> inactive] enter Started/Primary/Peering
>     -8> 2016-01-11 20:02:37.930521 7f26da5fe700  5 osd.6 pg_epoch:
> 84290 pg[11.3b( v 84268'1233293 (84261'1230292,84268'1233293]
> local-les=84268 n=511 ec=38 les/c 84268/84268 84289/84289/84289) [6]
> r=0 lpr=84289 pi=84267-84288/5 crt=84268'1233291 lcod 0'0 mlcod 0'0
> peering] enter Started/Primary/Peering/GetInfo
>     -7> 2016-01-11 20:02:37.930543 7f26da5fe700  5 osd.6 pg_epoch:
> 84290 pg[11.3b( v 84268'1233293 (84261'1230292,84268'1233293]
> local-les=84268 n=511 ec=38 les/c 84268/84268 84289/84289/84289) [6]
> r=0 lpr=84289 pi=84267-84288/5 crt=84268'1233291 lcod 0'0 mlcod 0'0
> peering] exit Started/Primary/Peering/GetInfo 0.000022 0 0.000000
>     -6> 2016-01-11 20:02:37.930558 7f26da5fe700  5 osd.6 pg_epoch:
> 84290 pg[11.3b( v 84268'1233293 (84261'1230292,84268'1233293]
> local-les=84268 n=511 ec=38 les/c 84268/84268 84289/84289/84289) [6]
> r=0 lpr=84289 pi=84267-84288/5 crt=84268'1233291 lcod 0'0 mlcod 0'0
> peering] enter Started/Primary/Peering/GetLog
>     -5> 2016-01-11 20:02:37.930592 7f26da5fe700  5 osd.6 pg_epoch:
> 84290 pg[11.3b( v 84268'1233293 (84261'1230292,84268'1233293]
> local-les=84268 n=511 ec=38 les/c 84268/84268 84289/84289/84289) [6]
> r=0 lpr=84289 pi=84267-84288/5 crt=84268'1233291 lcod 0'0 mlcod 0'0
> peering] exit Started/Primary/Peering/GetLog 0.000035 0 0.000000
>     -4> 2016-01-11 20:02:37.930607 7f26da5fe700  5 osd.6 pg_epoch:
> 84290 pg[11.3b( v 84268'1233293 (84261'1230292,84268'1233293]
> local-les=84268 n=511 ec=38 les/c 84268/84268 84289/84289/84289) [6]
> r=0 lpr=84289 pi=84267-84288/5 crt=84268'1233291 lcod 0'0 mlcod 0'0
> peering] enter Started/Primary/Peering/GetMissing
>     -3> 2016-01-11 20:02:37.930620 7f26da5fe700  5 osd.6 pg_epoch:
> 84290 pg[11.3b( v 84268'1233293 (84261'1230292,84268'1233293]
> local-les=84268 n=511 ec=38 les/c 84268/84268 84289/84289/84289) [6]
> r=0 lpr=84289 pi=84267-84288/5 crt=84268'1233291 lcod 0'0 mlcod 0'0
> peering] exit Started/Primary/Peering/GetMissing 0.000013 0 0.000000
>     -2> 2016-01-11 20:02:37.930633 7f26da5fe700  5 osd.6 pg_epoch:
> 84290 pg[11.3b( v 84268'1233293 (84261'1230292,84268'1233293]
> local-les=84268 n=511 ec=38 les/c 84268/84268 84289/84289/84289) [6]
> r=0 lpr=84289 pi=84267-84288/5 crt=84268'1233291 lcod 0'0 mlcod 0'0
> peering] exit Started/Primary/Peering 0.000124 0 0.000000
>     -1> 2016-01-11 20:02:37.930646 7f26da5fe700  5 osd.6 pg_epoch:
> 84290 pg[11.3b( v 84268'1233293 (84261'1230292,84268'1233293]
> local-les=84268 n=511 ec=38 les/c 84268/84268 84289/84289/84289) [6]
> r=0 lpr=84289 pi=84267-84288/5 crt=84268'1233291 lcod 0'0 mlcod 0'0
> inactive] enter Started/Primary/Active
>      0> 2016-01-11 20:02:37.934944 7f26da5fe700 -1
> ./include/interval_set.h: In function 'void interval_set<T>::erase(T,
> T) [with T = snapid_t]' thread 7f26da5fe700 time 2016-01-11
> 20:02:37.930666
> ./include/interval_set.h: 389: FAILED assert(_size >= 0)
>
>  ceph version 0.80.11-21-gf526309 (f526309b51b1760df193fca5fc39b4913e890bab)
>  1: (interval_set<snapid_t>::subtract(interval_set<snapid_t>
> const&)+0xb0) [0x79d4e0]
>  2: (PG::activate(ObjectStore::Transaction&, unsigned int,
> std::list<Context*, std::allocator<Context*> >&, std::map<int,
> std::map<spg_t, pg_query_t, std::less<spg_t>,
> std::allocator<std::pair<spg_t const, pg_query_t> > >, std::less<int>,
> std::allocator<std::pair<int const, std::map<spg_t, pg_query_t,
> std::less<spg_t>, std::allocator<std::pair<spg_t const, pg_query_t> >
>> > > >&, std::map<int, std::vector<std::pair<pg_notify_t,
> std::map<unsigned int, pg_interval_t, std::less<unsigned int>,
> std::allocator<std::pair<unsigned int const, pg_interval_t> > > >,
> std::allocator<std::pair<pg_notify_t, std::map<unsigned int,
> pg_interval_t, std::less<unsigned int>,
> std::allocator<std::pair<unsigned int const, pg_interval_t> > > > > >,
> std::less<int>, std::allocator<std::pair<int const,
> std::vector<std::pair<pg_notify_t, std::map<unsigned int,
> pg_interval_t, std::less<unsigned int>,
> std::allocator<std::pair<unsigned int const, pg_interval_t> > > >,
> std::allocator<std::pair<pg_notify_t, std::map<unsigned int,
> pg_interval_t, std::less<unsigned int>,
> std::allocator<std::pair<unsigned int const, pg_interval_t> > > > > >
>> > >*, PG::RecoveryCtx*)+0x846) [0x7742e6]
>  3: (PG::RecoveryState::Active::Active(boost::statechart::state<PG::RecoveryState::Active,
> PG::RecoveryState::Primary, PG::RecoveryState::Activating,
> (boost::statechart::history_mode)0>::my_context)+0x3fc) [0x77671c]
>  4: (boost::statechart::detail::safe_reaction_result
> boost::statechart::simple_state<PG::RecoveryState::Peering,
> PG::RecoveryState::Primary, PG::RecoveryState::GetInfo,
> (boost::statechart::history_mode)0>::transit_impl<PG::RecoveryState::Active,
> PG::RecoveryState::RecoveryMachine,
> boost::statechart::detail::no_transition_function>(boost::statechart::detail::no_transition_function
> const&)+0xa8) [0x7a7928]
>  5: (boost::statechart::simple_state<PG::RecoveryState::Peering,
> PG::RecoveryState::Primary, PG::RecoveryState::GetInfo,
> (boost::statechart::history_mode)0>::react_impl(boost::statechart::event_base
> const&, void const*)+0x13a) [0x7a7d9a]
>  6: (boost::statechart::simple_state<PG::RecoveryState::GetMissing,
> PG::RecoveryState::Peering, boost::mpl::list<mpl_::na, mpl_::na,
> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
> mpl_::na, mpl_::na, mpl_::na, mpl_::na>,
> (boost::statechart::history_mode)0>::react_impl(boost::statechart::event_base
> const&, void const*)+0xc0) [0x7a8a20]
>  7: (boost::statechart::state_machine<PG::RecoveryState::RecoveryMachine,
> PG::RecoveryState::Initial, std::allocator<void>,
> boost::statechart::null_exception_translator>::send_event(boost::statechart::event_base
> const&)+0x5b) [0x79185b]
>  8: (boost::statechart::state_machine<PG::RecoveryState::RecoveryMachine,
> PG::RecoveryState::Initial, std::allocator<void>,
> boost::statechart::null_exception_translator>::process_queued_events()+0xd4)
> [0x7919d4]
>  9: (PG::handle_activate_map(PG::RecoveryCtx*)+0x11b) [0x74092b]
>  10: (OSD::advance_pg(unsigned int, PG*, ThreadPool::TPHandle&,
> PG::RecoveryCtx*, std::set<boost::intrusive_ptr<PG>,
> std::less<boost::intrusive_ptr<PG> >,
> std::allocator<boost::intrusive_ptr<PG> > >*)+0x6c2) [0x654ca2]
>  11: (OSD::process_peering_events(std::list<PG*, std::allocator<PG*> >
> const&, ThreadPool::TPHandle&)+0x20c) [0x65535c]
>  12: (OSD::PeeringWQ::_process(std::list<PG*, std::allocator<PG*> >
> const&, ThreadPool::TPHandle&)+0x18) [0x69c8c8]
>  13: (ThreadPool::worker(ThreadPool::WorkThread*)+0xb01) [0xa5af11]
>  14: (ThreadPool::WorkThread::entry()+0x10) [0xa5be00]
>  15: (()+0x8182) [0x7f26f08ab182]
>  16: (clone()+0x6d) [0x7f26eeeca47d]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
>
>
> This is running the same pacakges as all the others, and is not the
> actual node which originally crashed on us during the snapshot.
> Some of our pools are only 2X replication due to the small cluster
> size. Is there any way to ensure that killing both OSDs won't affect
> both replicas of some bits? I'm still trying to get the hang of all
> the Ceph CLIs.
>
> So far rbd and rados dont seem to work (assuming the pool is figuring
> itself out), but at least the OSDs are coming up... Is this expected
> behavior or do i need to hit it with the proverbial wrench a few more
> times?
>
> Thank you much,
> -Boris Lukashev
>
> On Mon, Jan 11, 2016 at 2:06 PM, Dmitry Borodaenko
> <dborodaenko@mirantis.com> wrote:
>> Fuel 8.0 will support Hammer, you can grab the packages from:
>> http://mirror.fuel-infra.org/mos-repos/ubuntu/8.0/pool/main/c/ceph/
>>
>> or, if you build your own packages with the extra patches, grab the
>> Debian build scripts from:
>> https://review.fuel-infra.org/#/c/13879/
>>
>> That would make sure that your packages would work with Fuel.
>>
>> --
>> Dmitry Borodaenko
>>
>> On Mon, Jan 11, 2016 at 01:15:50PM -0500, Boris Lukashev wrote:
>>> Thank you, pulling those into my branch currently and kicking off a build.
>>> In terms of upgrading to Hammer - the documentation looks straight
>>> forward enough, but given that this is a Fuel based OpenStack
>>> deployment, i'm wondering if you've heard of any potential
>>> compatibility issues from doing so.
>>>
>>> -Boris
>>>
>>> On Mon, Jan 11, 2016 at 12:25 PM, Sage Weil <sage@newdream.net> wrote:
>>> > On Mon, 11 Jan 2016, Boris Lukashev wrote:
>>> >> I ran into an incredibly unpleasant loss of a 5 node, 10 OSD ceph
>>> >> cluster backing our openstack glance and cinder services by just
>>> >> asking RBD to snapshot one of the volumes.
>>> >> The conditions under which this occured are as follows - bash script
>>> >> asking cinder to snapshot RBD volumes in rapid succession (2 of them),
>>> >> which either caused a nova host (and ceph OSD holder) to crash, or
>>> >> simply suffered the crash simultaneously. On reboot of the host, RBD
>>> >> started throwing errors, once all OSDs were restarted, they all fail,
>>> >> crashing with the following:
>>> >>
>>> >>     -1> 2016-01-11 16:37:35.401002 7f16f8449700  5 osd.6 pg_epoch:
>>> >> 84269 pg[2.2c( empty local-les=84219 n=0 ec=1 les/c 84219/84219
>>> >> 84218/84218/84193) [6,8] r=0 lpr=84261 crt=0'0 mlcod 0'0 peering]
>>> >> enter Started/Primary/Peering/GetInfo
>>> >>      0> 2016-01-11 16:37:35.401057 7f16f7c48700 -1
>>> >> ./include/interval_set.h: In function 'void interval_set<T>::erase(T,
>>> >> T) [with T = snapid_t]' thread 7f16f7c48700 time 2016-01-11
>>> >> 16:37:35.398335
>>> >> ./include/interval_set.h: 386: FAILED assert(_size >= 0)
>>> >>
>>> >>  ceph version 0.80.11-19-g130b0f7 (130b0f748332851eb2e3789e2b2fa4d3d08f3006)
>>> >>  1: (interval_set<snapid_t>::subtract(interval_set<snapid_t>
>>> >> const&)+0xb0) [0x79d140]
>>> >>  2: (PGPool::update(std::tr1::shared_ptr<OSDMap const>)+0x656) [0x772856]
>>> >>  3: (PG::handle_advance_map(std::tr1::shared_ptr<OSDMap const>,
>>> >> std::tr1::shared_ptr<OSDMap const>, std::vector<int,
>>> >> std::allocator<int> >&, int, std::vector<int, std::allocator<int> >&,
>>> >> int, PG::RecoveryCtx*)+0x282) [0x772c22]
>>> >>  4: (OSD::advance_pg(unsigned int, PG*, ThreadPool::TPHandle&,
>>> >> PG::RecoveryCtx*, std::set<boost::intrusive_ptr<PG>,
>>> >> std::less<boost::intrusive_ptr<PG> >,
>>> >> std::allocator<boost::intrusive_ptr<PG> > >*)+0x292) [0x6548e2]
>>> >>  5: (OSD::process_peering_events(std::list<PG*, std::allocator<PG*> >
>>> >> const&, ThreadPool::TPHandle&)+0x20c) [0x6553cc]
>>> >>  6: (OSD::PeeringWQ::_process(std::list<PG*, std::allocator<PG*> >
>>> >> const&, ThreadPool::TPHandle&)+0x18) [0x69c858]
>>> >>  7: (ThreadPool::worker(ThreadPool::WorkThread*)+0xb01) [0xa5ac71]
>>> >>  8: (ThreadPool::WorkThread::entry()+0x10) [0xa5bb60]
>>> >>  9: (()+0x8182) [0x7f170def5182]
>>> >>  10: (clone()+0x6d) [0x7f170c51447d]
>>> >>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>>> >> needed to interpret this.
>>> >>
>>> >> To me, this looks like the snapshot which was being created when the
>>> >> nova host died is causing the assert to fail since the snap was never
>>> >> completed and is broken.
>>> >>
>>> >> http://tracker.ceph.com/issues/11493 which appears very similar is
>>> >> marked as resolved, but with firefly current (deployed via Fuel and
>>> >> updated in place with 0.80.11 debs) this issue hit us on Saturday.
>>> >
>>> > You can try cherry-picking the two commits in wip-11493-b which make the
>>> > OSD semi-gracefully tolerate this situation.  This is a bug that's been
>>> > fixed in hammer, but since the inconsistency has already been introduced
>>> > simply upgrading probably won't resolve it.  Nevertheless, after working
>>> > around this, I'd encourage you to move to hammer and firefly is at end of
>>> > life.
>>> >
>>> > sage
>>> >
>>> >>
>>> >> Whats the way around this? I imagine commenting out that assert may
>>> >> cause more damage, but we need to get our OSDs and the RBD data in
>>> >> them back online. Is there a permanent fix in any branch we can
>>> >> backport? We built this cluster using Fuel so this affects every
>>> >> Mirantis user if not every ceph user out there, and the vector into
>>> >> this catastrophic bug is normal daily operations (snapshot
>>> >> apparently)....
>>> >>
>>> >> Thank you all for looking over this, advice would be greatly appreciated.
>>> >> --
>>> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> >> the body of a message to majordomo@vger.kernel.org
>>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> >>
>>> >>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
