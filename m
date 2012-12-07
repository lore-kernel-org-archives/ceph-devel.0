From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Re: A couple of OSD-crashes after serious network trouble
Date: Fri, 07 Dec 2012 15:39:59 +0100
Message-ID: <50C1FFBF.6080802@filoo.de>
References: <50BF2CCB.3000302@filoo.de> <alpine.DEB.2.00.1212050650540.17270@cobra.newdream.net> <50C0D568.1030209@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-3.de-punkt.de ([93.190.64.33]:52070 "EHLO
	mail-3.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965099Ab2LGOkC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Dec 2012 09:40:02 -0500
In-Reply-To: <50C0D568.1030209@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

is the following a "known one", too? Would be good to get it out of my =
head:

> /var/log/ceph/ceph-osd.40.log.1.gz: 1: /usr/bin/ceph-osd() [0x706c59]
> /var/log/ceph/ceph-osd.40.log.1.gz: 2: (()+0xeff0) [0x7f7f306c0ff0]
> /var/log/ceph/ceph-osd.40.log.1.gz: 3: (gsignal()+0x35) [0x7f7f2f35f1=
b5]
> /var/log/ceph/ceph-osd.40.log.1.gz: 4: (abort()+0x180) [0x7f7f2f361fc=
0]
> /var/log/ceph/ceph-osd.40.log.1.gz: 5:=20
> (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f7f2fbf3dc5]
> /var/log/ceph/ceph-osd.40.log.1.gz: 6: (()+0xcb166) [0x7f7f2fbf2166]
> /var/log/ceph/ceph-osd.40.log.1.gz: 7: (()+0xcb193) [0x7f7f2fbf2193]
> /var/log/ceph/ceph-osd.40.log.1.gz: 8: (()+0xcb28e) [0x7f7f2fbf228e]
> /var/log/ceph/ceph-osd.40.log.1.gz: 9: (ceph::__ceph_assert_fail(char=
=20
> const*, char const*, int, char const*)+0x793) [0x77e903]
> /var/log/ceph/ceph-osd.40.log.1.gz: 10:=20
> (PG::merge_log(ObjectStore::Transaction&, pg_info_t&, pg_log_t&,=20
> int)+0x1de3) [0x63db93]
> /var/log/ceph/ceph-osd.40.log.1.gz: 11:=20
> (PG::RecoveryState::Stray::react(PG::RecoveryState::MLogRec=20
> const&)+0x2cc) [0x63e00c]
> /var/log/ceph/ceph-osd.40.log.1.gz: 12:=20
> (boost::statechart::simple_state<PG::RecoveryState::Stray,=20
> PG::RecoveryState::Started, boost::mpl::list<mpl_::na, mpl_::na,=20
> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,=
=20
> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,=
=20
> mpl_::na, mpl_::na, mpl_::na, mpl_::na>,=20
> (boost::statechart::history_mode)0>::react_impl(boost::statechart::ev=
ent_base=20
> const&, void const*)+0x203) [0x658a63]
> /var/log/ceph/ceph-osd.40.log.1.gz: 13:=20
> (boost::statechart::state_machine<PG::RecoveryState::RecoveryMachine,=
=20
> PG::RecoveryState::Initial, std::allocator<void>,=20
> boost::statechart::null_exception_translator>::process_event(boost::s=
tatechart::event_base=20
> const&)+0x6b) [0x650b4b]
> /var/log/ceph/ceph-osd.40.log.1.gz: 14:=20
> (PG::RecoveryState::handle_log(int, MOSDPGLog*,=20
> PG::RecoveryCtx*)+0x190) [0x60a520]
> /var/log/ceph/ceph-osd.40.log.1.gz: 15:=20
> (OSD::handle_pg_log(std::tr1::shared_ptr<OpRequest>)+0x666) [0x5c62e6=
]
> /var/log/ceph/ceph-osd.40.log.1.gz: 16:=20
> (OSD::dispatch_op(std::tr1::shared_ptr<OpRequest>)+0x11b) [0x5c6f3b]
> /var/log/ceph/ceph-osd.40.log.1.gz: 17:=20
> (OSD::_dispatch(Message*)+0x173) [0x5d1983]
> /var/log/ceph/ceph-osd.40.log.1.gz: 18:=20
> (OSD::ms_dispatch(Message*)+0x184) [0x5d2254]
> /var/log/ceph/ceph-osd.40.log.1.gz: 19:=20
> (SimpleMessenger::DispatchQueue::entry()+0x5e9) [0x7d3c09]
> /var/log/ceph/ceph-osd.40.log.1.gz: 20:=20
> (SimpleMessenger::dispatch_entry()+0x15) [0x7d5195]
> /var/log/ceph/ceph-osd.40.log.1.gz: 21:=20
> (SimpleMessenger::DispatchThread::entry()+0xd) [0x726bad]
> /var/log/ceph/ceph-osd.40.log.1.gz: 22: (()+0x68ca) [0x7f7f306b88ca]
> /var/log/ceph/ceph-osd.40.log.1.gz: 23: (clone()+0x6d) [0x7f7f2f3fc92=
d]
>

Thnx for looking,

Oliver.

--=20

Oliver Francke

filoo GmbH
Moltkestra=DFe 25a
33330 G=FCtersloh
HRB4355 AG G=FCtersloh

Gesch=E4ftsf=FChrer: S.Grewing | J.Rehp=F6hler | C.Kunz

=46olgen Sie uns auf Twitter: http://twitter.com/filoogmbh

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
