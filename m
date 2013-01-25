From: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Subject: Assert failed in PG.cc:5235 ("we got a bad state machine event")
Date: Fri, 25 Jan 2013 07:50:10 +0000
Message-ID: <6F3FA899187F0043BA1827A69DA2F7CC5E7299@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:64849 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751135Ab3AYHvp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Jan 2013 02:51:45 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi list,
=A0=A0 I have got the following log when I running test on top of Ceph.=
 Seems this part of codes are quite fresh(not yet appear in 0.56.1), an=
y idea about what happen?


pgs=3D714 cs=3D11 l=3D0).reader got old message 1 <=3D 6 0x4552800 osd_=
map(363..375 src has 1..375) v3, discarding
2013-01-25 14:12:53.979018 7f192cd96700=A0 0 -- 192.101.11.124:6804/107=
83 >> 192.101.11.121:6849/17270 pipe(0xe7ad400 sd=3D245 :6804 s=3D2
pgs=3D486 cs=3D11 l=3D0).fault with nothing to send, going to standby
2013-01-25 14:12:54.987534 7f192bf88700=A0 0 -- 192.101.11.124:6804/107=
83 >> 192.101.11.125:6804/80050 pipe(0x3a12000 sd=3D48 :41394 s=3D2
pgs=3D4275 cs=3D3 l=3D0).fault, initiating reconnect
2013-01-25 14:12:54.989279 7f1947859700 -1 osd.510 369 heartbeat_check:=
 no reply from osd.37 since 2013-01-25 14:12:17.748513 (cutof
f 2013-01-25 14:12:34.989276)
2013-01-25 14:12:54.989428 7f192bf88700=A0 0 -- 192.101.11.124:6804/107=
83 >> 192.101.11.125:6804/80050 pipe(0x3a12000 sd=3D47 :41473 s=3D2
pgs=3D4281 cs=3D5 l=3D0).reader got old message 1 <=3D 2 0x740e800 osd_=
map(363..377 src has 1..377) v3, discarding
2013-01-25 14:12:54.997166 7f192945d700=A0 0 -- 192.101.11.124:6804/107=
83 >> 192.101.11.121:6872/16641 pipe(0x1b01180 sd=3D27 :38664 s=3D2
pgs=3D714 cs=3D11 l=3D0).fault, initiating reconnect
2013-01-25 14:12:54.997212 7f192bf88700=A0 0 -- 192.101.11.124:6804/107=
83 >> 192.101.11.125:6804/80050 pipe(0x3a12000 sd=3D47 :41473 s=3D2
pgs=3D4281 cs=3D5 l=3D0).fault, initiating reconnect
2013-01-25 14:12:54.998554 7f192945d700=A0 0 -- 192.101.11.124:6804/107=
83 >> 192.101.11.121:6872/16641 pipe(0x1b01180 sd=3D27 :38743 s=3D2
pgs=3D715 cs=3D13 l=3D0).reader got old message 1 <=3D 6 0x4850c00 osd_=
map(370..377 src has 1..377) v3, discarding
2013-01-25 14:12:54.998565 7f192bf88700=A0 0 -- 192.101.11.124:6804/107=
83 >> 192.101.11.125:6804/80050 pipe(0x3a12000 sd=3D47 :41477 s=3D2
pgs=3D4282 cs=3D7 l=3D0).reader got old message 1 <=3D 2 0x8d4da00 osd_=
map(370..377 src has 1..377) v3, discarding
2013-01-25 14:12:55.202858 7f193f849700=A0 0 log [WRN] : map e377 wrong=
ly marked me down
2013-01-25 14:12:58.985680 7f1929d66700=A0 0 -- 192.101.11.124:6874/107=
83 >> 192.101.11.120:6831/1580 pipe(0x390cc80 sd=3D38 :60934 s=3D2
pgs=3D535 cs=3D1 l=3D0).fault with nothing to send, going to standby
2013-01-25 14:12:59.030720 7f1935b23700=A0 0 -- 192.101.11.124:6874/107=
83 >> 192.101.11.121:6872/16641 pipe(0x7a7b680 sd=3D58 :38862 s=3D2
pgs=3D725 cs=3D1 l=3D0).fault, initiating reconnect
2013-01-25 14:12:59.031210 7f1935a22700=A0 0 -- 192.101.11.124:6874/107=
83 >> 192.101.11.125:6804/80050 pipe(0x1b95180 sd=3D59 :41596 s=3D2
pgs=3D4285 cs=3D1 l=3D0).fault, initiating reconnect
2013-01-25 14:12:59.032473 7f1935b23700=A0 0 -- 192.101.11.124:6874/107=
83 >> 192.101.11.121:6872/16641 pipe(0x7a7b680 sd=3D58 :38864 s=3D2
pgs=3D726 cs=3D3 l=3D0).fault with nothing to send, going to standby
2013-01-25 14:12:59.032721 7f1935a22700=A0 0 -- 192.101.11.124:6874/107=
83 >> 192.101.11.125:6804/80050 pipe(0x1b95180 sd=3D59 :41598 s=3D2
pgs=3D4286 cs=3D3 l=3D0).fault with nothing to send, going to standby
2013-01-25 14:12:59.131044 7f193b040700 -1 osd/PG.cc: In function 'PG::=
RecoveryState::Crashed::Crashed(boost::statechart::state<PG::
RecoveryState::Crashed, PG::RecoveryState::RecoveryMachine>::my_context=
)' thread 7f193b040700 time 2013-01-25 14:12:59.030259
osd/PG.cc: 5235: FAILED assert(0 =3D=3D "we got a bad state machine eve=
nt")

ceph version 0.56-417-g67c7757 (67c77577bdfe4985aa50e91986677c742b7cc85=
f)
1: (PG::RecoveryState::Crashed::Crashed(boost::statechart::state<PG::Re=
coveryState::Crashed, PG::RecoveryState::RecoveryMachine, bo
ost::mpl::list<mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::=
na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::n
a, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na=
, mpl_::na>, (boost::statechart::history_mode)0>::my_context)
+0xc4) [0x740c84]
2: /usr/bin/ceph-osd() [0x77f189]
3: (boost::statechart::detail::reaction_result boost::statechart::simpl=
e_state<PG::RecoveryState::Reset, PG::RecoveryState::Recover
yMachine, boost::mpl::list<mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_=
::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_:
:na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::=
na, mpl_::na, mpl_::na>, (boost::statechart::history_mode)0>:
:local_react_impl_non_empty::local_react_impl<boost::mpl::list2<boost::=
statechart::custom_reaction<PG::FlushedEvt>, boost::statechar
t::transition<boost::statechart::event_base, PG::RecoveryState::Crashed=
, boost::statechart::detail::no_context<boost::statechart::ev
ent_base>, &boost::statechart::detail::no_context<boost::statechart::ev=
ent_base>::no_function> >, boost::statechart::simple_state<PG
::RecoveryState::Reset, PG::RecoveryState::RecoveryMachine, boost::mpl:=
:list<mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_:
:na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::=
na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::n
a, mpl_::na>, (boost::statechart::history_mode)0> >(boost::statechart::=
simple_state<PG::RecoveryState::Reset, PG::RecoveryState::Rec
overyMachine, boost::mpl::list<mpl_::na, mpl_::na, mpl_::na, mpl_::na, =
mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, m
pl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mp=
l_::na, mpl_::na, mpl_::na>, (boost::statechart::history_mode
)0>&, boost::statechart::event_base const&, void const*)+0xb5) [0x7a1e6=
5]
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
