From: Samuel Just <sam.just@dreamhost.com>
Subject: Re: OSD died
Date: Fri, 4 May 2012 13:35:17 -0700
Message-ID: <CACLRD_25-gdmmGcyv7spq51Oa7U=6tWYMVky+DcTM0XFttxPmA@mail.gmail.com>
References: <CAMvP8PD-zKg6OhWEjM4QWSdtXmkdoca-6LghvgTgdHoiOyPPwg@mail.gmail.com>
	<CAMvP8PAs+4AW-PiVO=5p7Q2CLC3=uz-hSUKD7C9NW-dcDCJ=1w@mail.gmail.com>
	<CAMvP8PCj604hc9Y=wNkFs4_ZUBG3tvD3Dk+Dy84NpHvH7OVC_g@mail.gmail.com>
	<CAMvP8PCAbS2LVTwDNxKTwiLfogMDx-3isajw_VsGQ84duyi3sw@mail.gmail.com>
	<CAMvP8PDt+koqBAXAgNAcbv3i023-2mCxnYCUvhYvo8G6XJ4mkA@mail.gmail.com>
	<CACLRD_2r0cWt6Nq6FyKWmmCXmOfKq32VjXAxzcG+Xws8W=iXsA@mail.gmail.com>
	<CAMvP8PAnDwEjdn79pJRCnqi12cLsnZEzWuLwkLJwQ67+oZsxAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:59672 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754334Ab2EDUfU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 May 2012 16:35:20 -0400
Received: by lbbgm6 with SMTP id gm6so2312329lbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 04 May 2012 13:35:18 -0700 (PDT)
In-Reply-To: <CAMvP8PAnDwEjdn79pJRCnqi12cLsnZEzWuLwkLJwQ67+oZsxAA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tomasz Paszkowski <ss7pro@gmail.com>
Cc: ceph-devel@vger.kernel.org

I have pushed another patch to wip-snap-workaround to bypass that
crash.  Let me know about any further problems!
-Sam

On Thu, May 3, 2012 at 4:29 PM, Tomasz Paszkowski <ss7pro@gmail.com> wr=
ote:
> Hi,
>
> Now it dies with stack trace as below. If i understand correctly I
> need to implement the same trick with intersection before subtract as
> you have made ?
>
>
>
> 0x00007ffff5ebb445 in raise () from /lib/x86_64-linux-gnu/libc.so.6
> (gdb) bt
> #0 =C2=A00x00007ffff5ebb445 in raise () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #1 =C2=A00x00007ffff5ebebab in abort () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #2 =C2=A00x00007ffff680969d in __gnu_cxx::__verbose_terminate_handler=
() ()
> =C2=A0 from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
> #3 =C2=A00x00007ffff6807846 in ?? () from /usr/lib/x86_64-linux-gnu/l=
ibstdc++.so.6
> #4 =C2=A00x00007ffff6807873 in std::terminate() ()
> =C2=A0 from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
> #5 =C2=A00x00007ffff680796e in __cxa_throw ()
> =C2=A0 from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
> #6 =C2=A00x0000000000695eb0 in ceph::__ceph_assert_fail (
> =C2=A0 =C2=A0assertion=3D0x80b1cd "_size >=3D 0", file=3D0x80a202 "./=
include/interval_set.h",
> =C2=A0 =C2=A0line=3D382,
> =C2=A0 =C2=A0func=3D0x81c020 "void interval_set<T>::erase(T, T) [with=
 T =3D snapid_t]")
> =C2=A0 =C2=A0at common/assert.cc:75
> #7 =C2=A00x00000000005ebe03 in erase (len=3D..., start=3D..., this=3D=
0x1a14d30)
> =C2=A0 =C2=A0at ./include/interval_set.h:382
> #8 =C2=A0interval_set<snapid_t>::subtract (this=3D0x1a14d30, a=3D...)
> =C2=A0 =C2=A0at ./include/interval_set.h:404
> #9 =C2=A00x0000000000730530 in PG::activate (this=3D0x1a14800, t=3D..=
=2E, tfin=3D...,
> =C2=A0 =C2=A0query_map=3D..., activator_map=3D0x7fffea4527a0) at osd/=
PG.cc:1239
> #10 0x00000000007324a2 in PG::RecoveryState::Active::Active (this=3D0=
x3048280,
> =C2=A0 =C2=A0ctx=3D...) at osd/PG.cc:4016
> #11 0x000000000074799c in
> boost::statechart::state<PG::RecoveryState::Active, PG---Type <return=
>
> to continue, or q <return> to quit---
> ::RecoveryState::Primary, boost::mpl::list<mpl_::na, mpl_::na,
> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
> mpl_::na, mpl_::na, mpl_::na, mpl_::na>,
> (boost::statechart::history_mode)0>::shallow_construct (pContext=3D..=
=2E,
> =C2=A0 =C2=A0outermostContextBase=3D...) at /usr/include/boost/statec=
hart/state.hpp:89
> #12 0x0000000000747bd2 in deep_construct (outermostContextBase=3D...,
> =C2=A0 =C2=A0pContext=3D...) at /usr/include/boost/statechart/state.h=
pp:79
> #13 construct (outermostContextBase=3D..., pContext=3D...)
> =C2=A0 =C2=A0at /usr/include/boost/statechart/detail/constructor.hpp:=
93
> #14 boost::statechart::simple_state<PG::RecoveryState::Peering,
> PG::RecoveryState::Primary, PG::RecoveryState::GetInfo,
> (boost::statechart::history_mode)0>::transit_impl<PG::RecoveryState::=
Active,
> PG::RecoveryState::RecoveryMachine,
> boost::statechart::detail::no_transition_function> (this=3D0x3048280,
> =C2=A0 =C2=A0transitionAction=3D...) at /usr/include/boost/statechart=
/simple_state.hpp:798
> #15 0x0000000000747e52 in transit<PG::RecoveryState::Active> (this=3D=
0x3048280)
> =C2=A0 =C2=A0at /usr/include/boost/statechart/simple_state.hpp:314
> #16 react_without_action (stt=3D...)
> =C2=A0 =C2=A0at /usr/include/boost/statechart/transition.hpp:38
> #17 react (stt=3D...)
> =C2=A0 =C2=A0at /usr/include/boost/statechart/detail/reaction_dispatc=
her.hpp:47
> #18 react (stt=3D..., evt=3D..., eventType=3D<optimized out>)
> =C2=A0 =C2=A0at /usr/include/boost/statechart/detail/reaction_dispatc=
her.hpp:92
> #19 react (stt=3D..., evt=3D..., eventType=3D<optimized out>)
> ---Type <return> to continue, or q <return> to quit---
> =C2=A0 =C2=A0at /usr/include/boost/statechart/detail/reaction_dispatc=
her.hpp:109
> #20 react<PG::RecoveryState::Peering, boost::statechart::event_base,
> void const*> (stt=3D..., evt=3D..., eventType=3D<optimized out>)
> =C2=A0 =C2=A0at /usr/include/boost/statechart/transition.hpp:59
> #21 local_react_impl<boost::mpl::list2<boost::statechart::transition<=
PG::RecoveryState::Activate,
> PG::RecoveryState::Active>,
> boost::statechart::custom_reaction<PG::RecoveryState::AdvMap> >,
> boost::statechart::simple_state<PG::RecoveryState::Peering,
> PG::RecoveryState::Primary, PG::RecoveryState::GetInfo,
> (boost::statechart::history_mode)0> > (eventType=3D0xb17c20, evt=3D..=
=2E,
> stt=3D...)
> =C2=A0 =C2=A0at /usr/include/boost/statechart/simple_state.hpp:816
> #22 local_react<boost::mpl::list2<boost::statechart::transition<PG::R=
ecoveryState::Activate,
> PG::RecoveryState::Active>,
> boost::statechart::custom_reaction<PG::RecoveryState::AdvMap> > >
> (this=3D0x3048280, eventType=3D0xb17c20, evt=3D...)
> =C2=A0 =C2=A0at /usr/include/boost/statechart/simple_state.hpp:851
> #23 local_react_impl<boost::mpl::list<boost::statechart::custom_react=
ion<PG::RecoveryState::QueryState>,
> boost::statechart::transition<PG::RecoveryState::Activate,
> PG::RecoveryState::Active>,
> boost::statechart::custom_reaction<PG::RecoveryState::AdvMap> >,
> boost::statechart::simple_state<PG::RecoveryState::Peering,
> PG::RecoveryState::Primary, PG::RecoveryState::GetInfo,
> (boost::statechart::history_mode)0> > (eventType=3D0xb17c20, evt=3D..=
=2E,
> stt=3D...)
> =C2=A0 =C2=A0at /usr/include/boost/statechart/simple_state.hpp:820
> #24 local_react<boost::mpl::list<boost::statechart::custom_reaction<P=
G::RecoveryState::QueryState>,
> boost::statechart::transition<PG::RecoveryState::Activate, P---Type
> <return> to continue, or q <return> to quit---
> G::RecoveryState::Active>,
> boost::statechart::custom_reaction<PG::RecoveryState::AdvMap> > >
> (eventType=3D0xb17c20, evt=3D..., this=3D0x3048280)
> =C2=A0 =C2=A0at /usr/include/boost/statechart/simple_state.hpp:851
> #25 boost::statechart::simple_state<PG::RecoveryState::Peering,
> PG::RecoveryState::Primary, PG::RecoveryState::GetInfo,
> (boost::statechart::history_mode)0>::react_impl (this=3D0x3048280,
> evt=3D..., eventType=3D0xb17c20)
> =C2=A0 =C2=A0at /usr/include/boost/statechart/simple_state.hpp:489
>
> #26 0x0000000000745c9b in react_impl (eventType=3D0xb17c20, evt=3D...=
,
> =C2=A0 =C2=A0this=3D0x3578640) at /usr/include/boost/statechart/simpl=
e_state.hpp:498
> #27 boost::statechart::simple_state<PG::RecoveryState::WaitUpThru,
> PG::RecoveryState::Peering, boost::mpl::list<mpl_::na, mpl_::na,
> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
> mpl_::na, mpl_::na, mpl_::na, mpl_::na>,
> (boost::statechart::history_mode)0>::react_impl (this=3D0x3578640,
> evt=3D...,
> =C2=A0 =C2=A0eventType=3D0xb17c20) at /usr/include/boost/statechart/s=
imple_state.hpp:482
> #28 0x000000000057be6b in operator() (this=3D<synthetic pointer>)
> =C2=A0 =C2=A0at /usr/include/boost/statechart/state_machine.hpp:87
> #29 operator()<boost::statechart::detail::send_function<boost::statec=
hart::detail::state_base<std::allocator<void>,
> boost::statechart::detail::rtti_policy>,
> boost::statechart::event_base, const void*>,
> boost::statechart::state_machine<PG::RecoveryState::RecoveryMachine,
> PG::RecoveryState::Initial>::exception_event_handler> (action=3D...,
> this=3D<optimized out>)
> =C2=A0 =C2=A0at /usr/include/boost/statechart/null_exception_translat=
or.hpp:33
> ---Type <return> to continue, or q <return> to quit---
> #30 send_event (evt=3D..., this=3D0x1a15600)
> =C2=A0 =C2=A0at /usr/include/boost/statechart/state_machine.hpp:885
> #31 boost::statechart::state_machine<PG::RecoveryState::RecoveryMachi=
ne,
> PG::RecoveryState::Initial, std::allocator<void>,
> boost::statechart::null_exception_translator>::process_queued_events
> (this=3D0x1a15600)
> =C2=A0 =C2=A0at /usr/include/boost/statechart/state_machine.hpp:910
> #32 0x000000000073e57e in
> boost::statechart::state_machine<PG::RecoveryState::RecoveryMachine,
> PG::RecoveryState::Initial, std::allocator<void>,
> boost::statechart::null_exception_translator>::process_event
> (this=3D0x1a15600, evt=3D...)
> =C2=A0 =C2=A0at /usr/include/boost/statechart/state_machine.hpp:280
> #33 0x0000000000716fc5 in PG::RecoveryState::handle_activate_map (
> =C2=A0 =C2=A0this=3D0x1a15600, rctx=3D0x7fffea4527d0) at osd/PG.cc:49=
19
> #34 0x00000000005bb044 in handle_activate_map (rctx=3D0x7fffea4527d0,
> =C2=A0 =C2=A0this=3D0x1a14800) at ./osd/PG.h:1413
> #35 OSD::activate_map (this=3D0xbc3000, t=3D..., tfin=3D...) at osd/O=
SD.cc:3615
> #36 0x00000000005d3c9e in OSD::handle_osd_map (this=3D0xbc3000, m=3D0=
x3009e00)
> =C2=A0 =C2=A0at osd/OSD.cc:3286
> #37 0x00000000005d4c6b in OSD::_dispatch (this=3D0xbc3000, m=3D0x3009=
e00)
> =C2=A0 =C2=A0at osd/OSD.cc:2780
> #38 0x00000000005d5275 in OSD::ms_dispatch (this=3D0xbc3000, m=3D0x30=
09e00)
> =C2=A0 =C2=A0at osd/OSD.cc:2605
> #39 0x000000000067a90b in ms_deliver_dispatch (m=3D0x3009e00, this=3D=
0xba8680)
> =C2=A0 =C2=A0at msg/Messenger.h:178
> ---Type <return> to continue, or q <return> to quit---
> #40 SimpleMessenger::dispatch_entry (this=3D0xba8680)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:363
> #41 0x0000000000648f0d in SimpleMessenger::DispatchThread::entry (
> =C2=A0 =C2=A0this=3D<optimized out>) at msg/SimpleMessenger.h:560
> #42 0x00007ffff79c2e9a in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #43 0x00007ffff5f774bd in clone () from /lib/x86_64-linux-gnu/libc.so=
=2E6
> #44 0x0000000000000000 in ?? ()
>
>
> On Mon, Apr 30, 2012 at 6:53 PM, Samuel Just <sam.just@dreamhost.com>=
 wrote:
>> I apologise for the delay in getting back to you. =C2=A0I just pushe=
d a
>> branch called wip-snap-workaround based on v0.45. =C2=A0It should at=
 least
>> avoid the crash you saw. =C2=A0Let me know if you hit further troubl=
e.
>> -Sam
>>
>> On Thu, Apr 26, 2012 at 8:12 AM, Tomasz Paszkowski <ss7pro@gmail.com=
> wrote:
>>> Hi,
>>>
>>> Anyone have any idea how to fix this ? Can i just correct conflict
>>> data in osdmaps ?
>>>
>>>
>>> On Wed, Apr 25, 2012 at 3:42 PM, Tomasz Paszkowski <ss7pro@gmail.co=
m> wrote:
>>>> After removing pool snapshot I was trying to make self managed
>>>> snapshot and after reading source this was the root cause of this
>>>> problem.
>>>>
>>>>
>>>> On Wed, Apr 25, 2012 at 1:24 PM, Tomasz Paszkowski <ss7pro@gmail.c=
om> wrote:
>>>>> after upgrade to v0.45 stack trace is as follows:
>>>>>
>>>>> Program received signal SIGABRT, Aborted.
>>>>> [Switching to Thread 0x7fffeac55700 (LWP 11011)]
>>>>> 0x00007ffff5ebb445 in raise () from /lib/x86_64-linux-gnu/libc.so=
=2E6
>>>>> (gdb) bt
>>>>> #0 =C2=A00x00007ffff5ebb445 in raise () from /lib/x86_64-linux-gn=
u/libc.so.6
>>>>> #1 =C2=A00x00007ffff5ebebab in abort () from /lib/x86_64-linux-gn=
u/libc.so.6
>>>>> #2 =C2=A00x00007ffff680969d in __gnu_cxx::__verbose_terminate_han=
dler() ()
>>>>> =C2=A0 from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
>>>>> #3 =C2=A00x00007ffff6807846 in ?? () from /usr/lib/x86_64-linux-g=
nu/libstdc++.so.6
>>>>> #4 =C2=A00x00007ffff6807873 in std::terminate() ()
>>>>> =C2=A0 from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
>>>>> #5 =C2=A00x00007ffff680796e in __cxa_throw ()
>>>>> =C2=A0 from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
>>>>> #6 =C2=A00x0000000000695ec0 in ceph::__ceph_assert_fail (
>>>>> =C2=A0 =C2=A0assertion=3D0x80b1ed "_size >=3D 0", file=3D0x80a222=
 "./include/interval_set.h",
>>>>> =C2=A0 =C2=A0line=3D382,
>>>>> =C2=A0 =C2=A0func=3D0x81bf60 "void interval_set<T>::erase(T, T) [=
with T =3D snapid_t]")
>>>>> =C2=A0 =C2=A0at common/assert.cc:75
>>>>> #7 =C2=A00x00000000005d1359 in erase (len=3D..., start=3D..., thi=
s=3D0xbe5738)
>>>>> =C2=A0 =C2=A0at ./include/interval_set.h:382
>>>>> #8 =C2=A0subtract (a=3D..., this=3D0xbe5738) at ./include/interva=
l_set.h:404
>>>>> #9 =C2=A0OSD::advance_map (this=3D0xbca000, t=3D..., tfin=3D<opti=
mized out>)
>>>>> =C2=A0 =C2=A0at osd/OSD.cc:3475
>>>>> #10 0x00000000005d33bf in OSD::handle_osd_map (this=3D0xbca000, m=
=3D0x2a4c800)
>>>>> =C2=A0 =C2=A0at osd/OSD.cc:3272
>>>>> #11 0x00000000005d4c9b in OSD::_dispatch (this=3D0xbca000, m=3D0x=
2a4c800)
>>>>> =C2=A0 =C2=A0at osd/OSD.cc:2780
>>>>> ---Type <return> to continue, or q <return> to quit---
>>>>> #12 0x00000000005d52a5 in OSD::ms_dispatch (this=3D0xbca000, m=3D=
0x2a4c800)
>>>>> =C2=A0 =C2=A0at osd/OSD.cc:2605
>>>>> #13 0x000000000067a91b in ms_deliver_dispatch (m=3D0x2a4c800, thi=
s=3D0xba8680)
>>>>> =C2=A0 =C2=A0at msg/Messenger.h:178
>>>>> #14 SimpleMessenger::dispatch_entry (this=3D0xba8680)
>>>>> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:363
>>>>> #15 0x0000000000648f1d in SimpleMessenger::DispatchThread::entry =
(
>>>>> =C2=A0 =C2=A0this=3D<optimized out>) at msg/SimpleMessenger.h:560
>>>>> #16 0x00007ffff79c2e9a in start_thread ()
>>>>> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
>>>>> #17 0x00007ffff5f774bd in clone () from /lib/x86_64-linux-gnu/lib=
c.so.6
>>>>> #18 0x0000000000000000 in ?? ()
>>>>>
>>>>>
>>>>> On Wed, Apr 25, 2012 at 12:11 PM, Tomasz Paszkowski <ss7pro@gmail=
=2Ecom> wrote:
>>>>>> osd dump is like this:
>>>>>>
>>>>>> pool 0 'data' rep size 2 crush_ruleset 0 object_hash rjenkins pg=
_num
>>>>>> 768 pgp_num 768 lpg_num 2 lpgp_num 2 last_change 1 owner 0
>>>>>> crash_replay_interval 45
>>>>>> pool 1 'metadata' rep size 2 crush_ruleset 1 object_hash rjenkin=
s
>>>>>> pg_num 768 pgp_num 768 lpg_num 2 lpgp_num 2 last_change 1 owner =
0
>>>>>> pool 2 'rbd' rep size 2 crush_ruleset 2 object_hash rjenkins pg_=
num
>>>>>> 768 pgp_num 768 lpg_num 2 lpgp_num 2 last_change 1 owner 0
>>>>>> pool 9 'nova' rep size 2 crush_ruleset 0 object_hash rjenkins pg=
_num
>>>>>> 2568 pgp_num 2568 lpg_num 0 lpgp_num 0 last_change 1435 owner
>>>>>> 18446744073709551615
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0removed_snaps [1~1]
>>>>>> pool 10 'glance' rep size 2 crush_ruleset 0 object_hash rjenkins
>>>>>> pg_num 2568 pgp_num 2568 lpg_num 0 lpgp_num 0 last_change 132 ow=
ner
>>>>>> 18446744073709551615
>>>>>>
>>>>>>
>>>>>> On Wed, Apr 25, 2012 at 11:04 AM, Tomasz Paszkowski <ss7pro@gmai=
l.com> wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> After making and removing snapshot from one of the pools, all o=
f the
>>>>>>> osd in cluster are dying with log like below:
>>>>>>>
>>>>>>>
>>>>>>> 2012-04-25 11:01:00.938313 7f66694b9700 osd.1 1434 =C2=A0removi=
ng old
>>>>>>> osdmap epoch 966
>>>>>>> 2012-04-25 11:01:00.938330 7f66694b9700 osd.1 1434 =C2=A0removi=
ng old
>>>>>>> osdmap epoch 967
>>>>>>> 2012-04-25 11:01:00.938348 7f66694b9700 osd.1 1434 =C2=A0advanc=
e to epoch
>>>>>>> 1435 (<=3D newest 1470)
>>>>>>> 2012-04-25 11:01:00.939437 7f66694b9700 osd.1 1435 advance_map =
epoch
>>>>>>> 1435 =C2=A01325 pgs
>>>>>>> 2012-04-25 11:01:00.939455 7f66694b9700 osd.1 1435 =C2=A0pool 0=
 removed
>>>>>>> snaps [], unchanged (snap_epoch =3D 0)
>>>>>>> 2012-04-25 11:01:00.939469 7f66694b9700 osd.1 1435 =C2=A0pool 1=
 removed
>>>>>>> snaps [], unchanged (snap_epoch =3D 0)
>>>>>>> 2012-04-25 11:01:00.939482 7f66694b9700 osd.1 1435 =C2=A0pool 2=
 removed
>>>>>>> snaps [], unchanged (snap_epoch =3D 0)
>>>>>>> ./include/interval_set.h: In function 'void interval_set<T>::er=
ase(T,
>>>>>>> T) [with T =3D snapid_t]' thread 7f66694b9700 time 2012-04-25
>>>>>>> 11:01:00.939509
>>>>>>> ./include/interval_set.h: 382: FAILED assert(_size >=3D 0)
>>>>>>> =C2=A0ceph version 0.44.1 (commit:c89b7f22c8599eb974e75a2f7a5f8=
55358199dee)
>>>>>>> =C2=A01: (OSD::advance_map(ObjectStore::Transaction&, C_Context=
s*)+0x2971) [0x5cfb51]
>>>>>>> =C2=A02: (OSD::handle_osd_map(MOSDMap*)+0x193c) [0x5d162c]
>>>>>>> =C2=A03: (OSD::_dispatch(Message*)+0x2eb) [0x5d34fb]
>>>>>>> =C2=A04: (OSD::ms_dispatch(Message*)+0x129) [0x5d3a59]
>>>>>>> =C2=A05: (SimpleMessenger::dispatch_entry()+0x78b) [0x67513b]
>>>>>>> =C2=A06: (SimpleMessenger::DispatchThread::entry()+0xd) [0x5212=
4d]
>>>>>>> =C2=A07: (()+0x7e9a) [0x7f6676226e9a]
>>>>>>> =C2=A08: (clone()+0x6d) [0x7f66747db4bd]
>>>>>>> =C2=A0ceph version 0.44.1 (commit:c89b7f22c8599eb974e75a2f7a5f8=
55358199dee)
>>>>>>> =C2=A01: (OSD::advance_map(ObjectStore::Transaction&, C_Context=
s*)+0x2971) [0x5cfb51]
>>>>>>> =C2=A02: (OSD::handle_osd_map(MOSDMap*)+0x193c) [0x5d162c]
>>>>>>> =C2=A03: (OSD::_dispatch(Message*)+0x2eb) [0x5d34fb]
>>>>>>> =C2=A04: (OSD::ms_dispatch(Message*)+0x129) [0x5d3a59]
>>>>>>> =C2=A05: (SimpleMessenger::dispatch_entry()+0x78b) [0x67513b]
>>>>>>> =C2=A06: (SimpleMessenger::DispatchThread::entry()+0xd) [0x5212=
4d]
>>>>>>> =C2=A07: (()+0x7e9a) [0x7f6676226e9a]
>>>>>>> =C2=A08: (clone()+0x6d) [0x7f66747db4bd]
>>>>>>> *** Caught signal (Aborted) **
>>>>>>> =C2=A0in thread 7f66694b9700
>>>>>>> =C2=A0ceph version 0.44.1 (commit:c89b7f22c8599eb974e75a2f7a5f8=
55358199dee)
>>>>>>> =C2=A01: /usr/bin/ceph-osd() [0x6fa0c6]
>>>>>>> =C2=A02: (()+0xfcb0) [0x7f667622ecb0]
>>>>>>> =C2=A03: (gsignal()+0x35) [0x7f667471f445]
>>>>>>> =C2=A04: (abort()+0x17b) [0x7f6674722bab]
>>>>>>> =C2=A05: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f=
667506d69d]
>>>>>>> =C2=A06: (()+0xb5846) [0x7f667506b846]
>>>>>>> =C2=A07: (()+0xb5873) [0x7f667506b873]
>>>>>>> =C2=A08: (()+0xb596e) [0x7f667506b96e]
>>>>>>> =C2=A09: (ceph::__ceph_assert_fail(char const*, char const*, in=
t, char
>>>>>>> const*)+0x200) [0x68f420]
>>>>>>> =C2=A010: (OSD::advance_map(ObjectStore::Transaction&, C_Contex=
ts*)+0x2971)
>>>>>>> [0x5cfb51]
>>>>>>> =C2=A011: (OSD::handle_osd_map(MOSDMap*)+0x193c) [0x5d162c]
>>>>>>> =C2=A012: (OSD::_dispatch(Message*)+0x2eb) [0x5d34fb]
>>>>>>> =C2=A013: (OSD::ms_dispatch(Message*)+0x129) [0x5d3a59]
>>>>>>> =C2=A014: (SimpleMessenger::dispatch_entry()+0x78b) [0x67513b]
>>>>>>> =C2=A015: (SimpleMessenger::DispatchThread::entry()+0xd) [0x521=
24d]
>>>>>>> =C2=A016: (()+0x7e9a) [0x7f6676226e9a]
>>>>>>> =C2=A017: (clone()+0x6d) [0x7f66747db4bd]
>>>>>>>
>>>>>>>
>>>>>>> --
>>>>>>> Tomasz Paszkowski
>>>>>>> SS7, Asterisk, SAN, Datacenter, Cloud Computing
>>>>>>> +48500166299
>>>>>>
>>>>>>
>>>>>>
>>>>>> --
>>>>>> Tomasz Paszkowski
>>>>>> SS7, Asterisk, SAN, Datacenter, Cloud Computing
>>>>>> +48500166299
>>>>>
>>>>>
>>>>>
>>>>> --
>>>>> Tomasz Paszkowski
>>>>> SS7, Asterisk, SAN, Datacenter, Cloud Computing
>>>>> +48500166299
>>>>
>>>>
>>>>
>>>> --
>>>> Tomasz Paszkowski
>>>> SS7, Asterisk, SAN, Datacenter, Cloud Computing
>>>> +48500166299
>>>
>>>
>>>
>>> --
>>> Tomasz Paszkowski
>>> SS7, Asterisk, SAN, Datacenter, Cloud Computing
>>> +48500166299
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.=
html
>
>
>
> --
> Tomasz Paszkowski
> SS7, Asterisk, SAN, Datacenter, Cloud Computing
> +48500166299
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
