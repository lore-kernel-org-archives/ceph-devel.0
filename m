From: Samuel Just <sam.just@inktank.com>
Subject: Re: A couple of OSD-crashes after serious network trouble
Date: Fri, 7 Dec 2012 10:37:33 -0800
Message-ID: <CA+4uBUaEei_HLJxG44p_vtQTy+HKb3DR-rCjGdvTo+hP2UsFxQ@mail.gmail.com>
References: <50BF2CCB.3000302@filoo.de>
	<alpine.DEB.2.00.1212050650540.17270@cobra.newdream.net>
	<50C0D568.1030209@filoo.de>
	<50C1FFBF.6080802@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:57123 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755130Ab2LGShe convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Dec 2012 13:37:34 -0500
Received: by mail-vb0-f46.google.com with SMTP id b13so690965vby.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Dec 2012 10:37:33 -0800 (PST)
In-Reply-To: <50C1FFBF.6080802@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oliver Francke <Oliver.Francke@filoo.de>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

That is very likely to be one of the merge_log bugs fixed between 0.48
and 0.55.  I could confirm with a stacktrace from gdb with line
numbers or the remainder of the logging dumped when the daemon
crashed.

My understanding of your situation is that currently all pgs are
active+clean but you are missing some rbd image headers and some rbd
images appear to be corrupted.  Is that accurate?
-Sam

On Fri, Dec 7, 2012 at 6:39 AM, Oliver Francke <Oliver.Francke@filoo.de=
> wrote:
> Hi,
>
> is the following a "known one", too? Would be good to get it out of m=
y head:
>
>
>> /var/log/ceph/ceph-osd.40.log.1.gz: 1: /usr/bin/ceph-osd() [0x706c59=
]
>> /var/log/ceph/ceph-osd.40.log.1.gz: 2: (()+0xeff0) [0x7f7f306c0ff0]
>> /var/log/ceph/ceph-osd.40.log.1.gz: 3: (gsignal()+0x35) [0x7f7f2f35f=
1b5]
>> /var/log/ceph/ceph-osd.40.log.1.gz: 4: (abort()+0x180) [0x7f7f2f361f=
c0]
>> /var/log/ceph/ceph-osd.40.log.1.gz: 5:
>> (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f7f2fbf3dc5]
>> /var/log/ceph/ceph-osd.40.log.1.gz: 6: (()+0xcb166) [0x7f7f2fbf2166]
>> /var/log/ceph/ceph-osd.40.log.1.gz: 7: (()+0xcb193) [0x7f7f2fbf2193]
>> /var/log/ceph/ceph-osd.40.log.1.gz: 8: (()+0xcb28e) [0x7f7f2fbf228e]
>> /var/log/ceph/ceph-osd.40.log.1.gz: 9: (ceph::__ceph_assert_fail(cha=
r
>> const*, char const*, int, char const*)+0x793) [0x77e903]
>> /var/log/ceph/ceph-osd.40.log.1.gz: 10:
>> (PG::merge_log(ObjectStore::Transaction&, pg_info_t&, pg_log_t&,
>> int)+0x1de3) [0x63db93]
>> /var/log/ceph/ceph-osd.40.log.1.gz: 11:
>> (PG::RecoveryState::Stray::react(PG::RecoveryState::MLogRec const&)+=
0x2cc)
>> [0x63e00c]
>> /var/log/ceph/ceph-osd.40.log.1.gz: 12:
>> (boost::statechart::simple_state<PG::RecoveryState::Stray,
>> PG::RecoveryState::Started, boost::mpl::list<mpl_::na, mpl_::na, mpl=
_::na,
>> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na=
,
>> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na=
,
>> mpl_::na, mpl_::na, mpl_::na>,
>> (boost::statechart::history_mode)0>::react_impl(boost::statechart::e=
vent_base
>> const&, void const*)+0x203) [0x658a63]
>> /var/log/ceph/ceph-osd.40.log.1.gz: 13:
>> (boost::statechart::state_machine<PG::RecoveryState::RecoveryMachine=
,
>> PG::RecoveryState::Initial, std::allocator<void>,
>> boost::statechart::null_exception_translator>::process_event(boost::=
statechart::event_base
>> const&)+0x6b) [0x650b4b]
>> /var/log/ceph/ceph-osd.40.log.1.gz: 14:
>> (PG::RecoveryState::handle_log(int, MOSDPGLog*, PG::RecoveryCtx*)+0x=
190)
>> [0x60a520]
>> /var/log/ceph/ceph-osd.40.log.1.gz: 15:
>> (OSD::handle_pg_log(std::tr1::shared_ptr<OpRequest>)+0x666) [0x5c62e=
6]
>> /var/log/ceph/ceph-osd.40.log.1.gz: 16:
>> (OSD::dispatch_op(std::tr1::shared_ptr<OpRequest>)+0x11b) [0x5c6f3b]
>> /var/log/ceph/ceph-osd.40.log.1.gz: 17: (OSD::_dispatch(Message*)+0x=
173)
>> [0x5d1983]
>> /var/log/ceph/ceph-osd.40.log.1.gz: 18: (OSD::ms_dispatch(Message*)+=
0x184)
>> [0x5d2254]
>> /var/log/ceph/ceph-osd.40.log.1.gz: 19:
>> (SimpleMessenger::DispatchQueue::entry()+0x5e9) [0x7d3c09]
>> /var/log/ceph/ceph-osd.40.log.1.gz: 20:
>> (SimpleMessenger::dispatch_entry()+0x15) [0x7d5195]
>> /var/log/ceph/ceph-osd.40.log.1.gz: 21:
>> (SimpleMessenger::DispatchThread::entry()+0xd) [0x726bad]
>> /var/log/ceph/ceph-osd.40.log.1.gz: 22: (()+0x68ca) [0x7f7f306b88ca]
>> /var/log/ceph/ceph-osd.40.log.1.gz: 23: (clone()+0x6d) [0x7f7f2f3fc9=
2d]
>>
>
> Thnx for looking,
>
>
> Oliver.
>
> --
>
> Oliver Francke
>
> filoo GmbH
> Moltkestra=DFe 25a
> 33330 G=FCtersloh
> HRB4355 AG G=FCtersloh
>
> Gesch=E4ftsf=FChrer: S.Grewing | J.Rehp=F6hler | C.Kunz
>
> Folgen Sie uns auf Twitter: http://twitter.com/filoogmbh
>
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
