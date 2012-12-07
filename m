From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Re: A couple of OSD-crashes after serious network trouble
Date: Fri, 7 Dec 2012 20:09:45 +0100
Message-ID: <C56EB768-EED4-41BC-A40F-FE46C7819560@filoo.de>
References: <50BF2CCB.3000302@filoo.de> <alpine.DEB.2.00.1212050650540.17270@cobra.newdream.net> <50C0D568.1030209@filoo.de> <50C1FFBF.6080802@filoo.de> <CA+4uBUaEei_HLJxG44p_vtQTy+HKb3DR-rCjGdvTo+hP2UsFxQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-3.de-punkt.de ([93.190.64.33]:35936 "EHLO
	mail-3.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239Ab2LGTJo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Dec 2012 14:09:44 -0500
In-Reply-To: <CA+4uBUaEei_HLJxG44p_vtQTy+HKb3DR-rCjGdvTo+hP2UsFxQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sam,

Am 07.12.2012 um 19:37 schrieb Samuel Just <sam.just@inktank.com>:

> That is very likely to be one of the merge_log bugs fixed between 0.4=
8
> and 0.55.  I could confirm with a stacktrace from gdb with line
> numbers or the remainder of the logging dumped when the daemon
> crashed.
>=20
> My understanding of your situation is that currently all pgs are
> active+clean but you are missing some rbd image headers and some rbd
> images appear to be corrupted.  Is that accurate?
> -Sam
>=20

thnx for droppig in.

Uhm almost correct, there are now 6 pg in state inconsistent:

HEALTH_WARN 6 pgs inconsistent
pg 65.da is active+clean+inconsistent, acting [1,33]
pg 65.d7 is active+clean+inconsistent, acting [13,42]
pg 65.10 is active+clean+inconsistent, acting [12,40]
pg 65.f is active+clean+inconsistent, acting [13,31]
pg 65.75 is active+clean+inconsistent, acting [1,33]
pg 65.6a is active+clean+inconsistent, acting [13,31]

I know which images are affected, but does a repair help?

0 log [ERR] : 65.10 osd.40: soid 87c96f10/rb.0.47d9b.1014b7b4.000000000=
2df/head//65 size 4194304 !=3D known size 699904
0 log [ERR] : 65.6a osd.31: soid 19a2526a/rb.0.2dcf2.1da2a31e.000000000=
737/head//65 size 4191744 !=3D known size 2757632
0 log [ERR] : 65.75 osd.33: soid 20550575/rb.0.2d520.5c17a6e3.000000000=
339/head//65 size 4194304 !=3D known size 1238016
0 log [ERR] : 65.d7 osd.42: soid fa3a5d7/rb.0.2c2a8.12ec359d.0000000020=
5c/head//65 size 4194304 !=3D known size 1382912
0 log [ERR] : 65.da osd.33: soid c2a344da/rb.0.2be17.cb4bd69.0000000000=
81/head//65 size 4191744 !=3D known size 1815552
0 log [ERR] : 65.f osd.31: soid e8d2430f/rb.0.2d1e9.1339c5dd.000000000c=
41/head//65 size 2424832 !=3D known size 2331648

of make things worse?

I could only check 14 out of 20 OSD's so far, cause from two older node=
s a scrub leads to slow-requests=85 > couple of minutes, so VM's got st=
alled=85 customers pressing the "reset-button", so losing caches=85

Comments welcome,

Oliver.

> On Fri, Dec 7, 2012 at 6:39 AM, Oliver Francke <Oliver.Francke@filoo.=
de> wrote:
>> Hi,
>>=20
>> is the following a "known one", too? Would be good to get it out of =
my head:
>>=20
>>=20
>>> /var/log/ceph/ceph-osd.40.log.1.gz: 1: /usr/bin/ceph-osd() [0x706c5=
9]
>>> /var/log/ceph/ceph-osd.40.log.1.gz: 2: (()+0xeff0) [0x7f7f306c0ff0]
>>> /var/log/ceph/ceph-osd.40.log.1.gz: 3: (gsignal()+0x35) [0x7f7f2f35=
f1b5]
>>> /var/log/ceph/ceph-osd.40.log.1.gz: 4: (abort()+0x180) [0x7f7f2f361=
fc0]
>>> /var/log/ceph/ceph-osd.40.log.1.gz: 5:
>>> (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f7f2fbf3dc5]
>>> /var/log/ceph/ceph-osd.40.log.1.gz: 6: (()+0xcb166) [0x7f7f2fbf2166=
]
>>> /var/log/ceph/ceph-osd.40.log.1.gz: 7: (()+0xcb193) [0x7f7f2fbf2193=
]
>>> /var/log/ceph/ceph-osd.40.log.1.gz: 8: (()+0xcb28e) [0x7f7f2fbf228e=
]
>>> /var/log/ceph/ceph-osd.40.log.1.gz: 9: (ceph::__ceph_assert_fail(ch=
ar
>>> const*, char const*, int, char const*)+0x793) [0x77e903]
>>> /var/log/ceph/ceph-osd.40.log.1.gz: 10:
>>> (PG::merge_log(ObjectStore::Transaction&, pg_info_t&, pg_log_t&,
>>> int)+0x1de3) [0x63db93]
>>> /var/log/ceph/ceph-osd.40.log.1.gz: 11:
>>> (PG::RecoveryState::Stray::react(PG::RecoveryState::MLogRec const&)=
+0x2cc)
>>> [0x63e00c]
>>> /var/log/ceph/ceph-osd.40.log.1.gz: 12:
>>> (boost::statechart::simple_state<PG::RecoveryState::Stray,
>>> PG::RecoveryState::Started, boost::mpl::list<mpl_::na, mpl_::na, mp=
l_::na,
>>> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::n=
a,
>>> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::n=
a,
>>> mpl_::na, mpl_::na, mpl_::na>,
>>> (boost::statechart::history_mode)0>::react_impl(boost::statechart::=
event_base
>>> const&, void const*)+0x203) [0x658a63]
>>> /var/log/ceph/ceph-osd.40.log.1.gz: 13:
>>> (boost::statechart::state_machine<PG::RecoveryState::RecoveryMachin=
e,
>>> PG::RecoveryState::Initial, std::allocator<void>,
>>> boost::statechart::null_exception_translator>::process_event(boost:=
:statechart::event_base
>>> const&)+0x6b) [0x650b4b]
>>> /var/log/ceph/ceph-osd.40.log.1.gz: 14:
>>> (PG::RecoveryState::handle_log(int, MOSDPGLog*, PG::RecoveryCtx*)+0=
x190)
>>> [0x60a520]
>>> /var/log/ceph/ceph-osd.40.log.1.gz: 15:
>>> (OSD::handle_pg_log(std::tr1::shared_ptr<OpRequest>)+0x666) [0x5c62=
e6]
>>> /var/log/ceph/ceph-osd.40.log.1.gz: 16:
>>> (OSD::dispatch_op(std::tr1::shared_ptr<OpRequest>)+0x11b) [0x5c6f3b=
]
>>> /var/log/ceph/ceph-osd.40.log.1.gz: 17: (OSD::_dispatch(Message*)+0=
x173)
>>> [0x5d1983]
>>> /var/log/ceph/ceph-osd.40.log.1.gz: 18: (OSD::ms_dispatch(Message*)=
+0x184)
>>> [0x5d2254]
>>> /var/log/ceph/ceph-osd.40.log.1.gz: 19:
>>> (SimpleMessenger::DispatchQueue::entry()+0x5e9) [0x7d3c09]
>>> /var/log/ceph/ceph-osd.40.log.1.gz: 20:
>>> (SimpleMessenger::dispatch_entry()+0x15) [0x7d5195]
>>> /var/log/ceph/ceph-osd.40.log.1.gz: 21:
>>> (SimpleMessenger::DispatchThread::entry()+0xd) [0x726bad]
>>> /var/log/ceph/ceph-osd.40.log.1.gz: 22: (()+0x68ca) [0x7f7f306b88ca=
]
>>> /var/log/ceph/ceph-osd.40.log.1.gz: 23: (clone()+0x6d) [0x7f7f2f3fc=
92d]
>>>=20
>>=20
>> Thnx for looking,
>>=20
>>=20
>> Oliver.
>>=20
>> --
>>=20
>> Oliver Francke
>>=20
>> filoo GmbH
>> Moltkestra=DFe 25a
>> 33330 G=FCtersloh
>> HRB4355 AG G=FCtersloh
>>=20
>> Gesch=E4ftsf=FChrer: S.Grewing | J.Rehp=F6hler | C.Kunz
>>=20
>> Folgen Sie uns auf Twitter: http://twitter.com/filoogmbh
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
