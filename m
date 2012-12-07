From: Samuel Just <sam.just@inktank.com>
Subject: Re: A couple of OSD-crashes after serious network trouble
Date: Fri, 7 Dec 2012 13:18:07 -0800
Message-ID: <CA+4uBUYzOhxb1WHrULF=j5Vemdinz7gETdt0O1kuGa1mdETO1w@mail.gmail.com>
References: <50BF2CCB.3000302@filoo.de>
	<alpine.DEB.2.00.1212050650540.17270@cobra.newdream.net>
	<50C0D568.1030209@filoo.de>
	<50C1FFBF.6080802@filoo.de>
	<CA+4uBUaEei_HLJxG44p_vtQTy+HKb3DR-rCjGdvTo+hP2UsFxQ@mail.gmail.com>
	<C56EB768-EED4-41BC-A40F-FE46C7819560@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:46313 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030863Ab2LGVSI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Dec 2012 16:18:08 -0500
Received: by mail-vc0-f174.google.com with SMTP id d16so808991vcd.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Dec 2012 13:18:07 -0800 (PST)
In-Reply-To: <C56EB768-EED4-41BC-A40F-FE46C7819560@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oliver Francke <Oliver.Francke@filoo.de>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Ah... unfortunately doing a repair in these 6 cases would probably
result in the wrong object surviving.  It should work, but it might
corrupt the rbd image contents.  If the images are expendable, you
could repair and then delete the images.

The red flag here is that the "known size" is smaller than the other
size.  This indicates that it most likely chose the wrong file as the
"correct" one since rbd image blocks usually get bigger over time.  To
fix this, you will need to manually copy the file for the larger of
the two object replicas to replace the smaller of the two object
replicas.

=46or the first, soid 87c96f10/rb.0.47d9b.1014b7b4.0000000002df/head//6=
5
in pg 65.10:
1) Find the object on the primary and the replica (from above, primary
is 12 and replica is 40).  You can use find in the primary and replica
current/65.10_head directories to look for a file matching
*rb.0.47d9b.1014b7b4.0000000002df*).  The file name should be
'rb.0.47d9b.1014b7b4.0000000002df__head_87C96F10__65' I think.
2) Stop the primary and replica osds
3) Compare the file sizes for the two files -- you should find that
the file sizes do not match.
4) Replace the smaller file with the larger one (you'll probably want
to keep a copy of the smaller one around just in case).
5) Restart the osds and scrub pg 65.10 -- the pg should come up clean
(possibly with a relatively harmless stat mismatch)

If this worked our correctly, you can repeat for the other 5 cases.

Let me know if you have any questions.
-Sam

On Fri, Dec 7, 2012 at 11:09 AM, Oliver Francke <Oliver.Francke@filoo.d=
e> wrote:
> Hi Sam,
>
> Am 07.12.2012 um 19:37 schrieb Samuel Just <sam.just@inktank.com>:
>
>> That is very likely to be one of the merge_log bugs fixed between 0.=
48
>> and 0.55.  I could confirm with a stacktrace from gdb with line
>> numbers or the remainder of the logging dumped when the daemon
>> crashed.
>>
>> My understanding of your situation is that currently all pgs are
>> active+clean but you are missing some rbd image headers and some rbd
>> images appear to be corrupted.  Is that accurate?
>> -Sam
>>
>
> thnx for droppig in.
>
> Uhm almost correct, there are now 6 pg in state inconsistent:
>
> HEALTH_WARN 6 pgs inconsistent
> pg 65.da is active+clean+inconsistent, acting [1,33]
> pg 65.d7 is active+clean+inconsistent, acting [13,42]
> pg 65.10 is active+clean+inconsistent, acting [12,40]
> pg 65.f is active+clean+inconsistent, acting [13,31]
> pg 65.75 is active+clean+inconsistent, acting [1,33]
> pg 65.6a is active+clean+inconsistent, acting [13,31]
>
> I know which images are affected, but does a repair help?
>
> 0 log [ERR] : 65.10 osd.40: soid 87c96f10/rb.0.47d9b.1014b7b4.0000000=
002df/head//65 size 4194304 !=3D known size 699904
> 0 log [ERR] : 65.6a osd.31: soid 19a2526a/rb.0.2dcf2.1da2a31e.0000000=
00737/head//65 size 4191744 !=3D known size 2757632
> 0 log [ERR] : 65.75 osd.33: soid 20550575/rb.0.2d520.5c17a6e3.0000000=
00339/head//65 size 4194304 !=3D known size 1238016
> 0 log [ERR] : 65.d7 osd.42: soid fa3a5d7/rb.0.2c2a8.12ec359d.00000000=
205c/head//65 size 4194304 !=3D known size 1382912
> 0 log [ERR] : 65.da osd.33: soid c2a344da/rb.0.2be17.cb4bd69.00000000=
0081/head//65 size 4191744 !=3D known size 1815552
> 0 log [ERR] : 65.f osd.31: soid e8d2430f/rb.0.2d1e9.1339c5dd.00000000=
0c41/head//65 size 2424832 !=3D known size 2331648
>
> of make things worse?
>
> I could only check 14 out of 20 OSD's so far, cause from two older no=
des a scrub leads to slow-requests=85 > couple of minutes, so VM's got =
stalled=85 customers pressing the "reset-button", so losing caches=85
>
> Comments welcome,
>
> Oliver.
>
>> On Fri, Dec 7, 2012 at 6:39 AM, Oliver Francke <Oliver.Francke@filoo=
=2Ede> wrote:
>>> Hi,
>>>
>>> is the following a "known one", too? Would be good to get it out of=
 my head:
>>>
>>>
>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 1: /usr/bin/ceph-osd() [0x706c=
59]
>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 2: (()+0xeff0) [0x7f7f306c0ff0=
]
>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 3: (gsignal()+0x35) [0x7f7f2f3=
5f1b5]
>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 4: (abort()+0x180) [0x7f7f2f36=
1fc0]
>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 5:
>>>> (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f7f2fbf3dc5]
>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 6: (()+0xcb166) [0x7f7f2fbf216=
6]
>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 7: (()+0xcb193) [0x7f7f2fbf219=
3]
>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 8: (()+0xcb28e) [0x7f7f2fbf228=
e]
>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 9: (ceph::__ceph_assert_fail(c=
har
>>>> const*, char const*, int, char const*)+0x793) [0x77e903]
>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 10:
>>>> (PG::merge_log(ObjectStore::Transaction&, pg_info_t&, pg_log_t&,
>>>> int)+0x1de3) [0x63db93]
>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 11:
>>>> (PG::RecoveryState::Stray::react(PG::RecoveryState::MLogRec const&=
)+0x2cc)
>>>> [0x63e00c]
>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 12:
>>>> (boost::statechart::simple_state<PG::RecoveryState::Stray,
>>>> PG::RecoveryState::Started, boost::mpl::list<mpl_::na, mpl_::na, m=
pl_::na,
>>>> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::=
na,
>>>> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::=
na,
>>>> mpl_::na, mpl_::na, mpl_::na>,
>>>> (boost::statechart::history_mode)0>::react_impl(boost::statechart:=
:event_base
>>>> const&, void const*)+0x203) [0x658a63]
>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 13:
>>>> (boost::statechart::state_machine<PG::RecoveryState::RecoveryMachi=
ne,
>>>> PG::RecoveryState::Initial, std::allocator<void>,
>>>> boost::statechart::null_exception_translator>::process_event(boost=
::statechart::event_base
>>>> const&)+0x6b) [0x650b4b]
>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 14:
>>>> (PG::RecoveryState::handle_log(int, MOSDPGLog*, PG::RecoveryCtx*)+=
0x190)
>>>> [0x60a520]
>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 15:
>>>> (OSD::handle_pg_log(std::tr1::shared_ptr<OpRequest>)+0x666) [0x5c6=
2e6]
>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 16:
>>>> (OSD::dispatch_op(std::tr1::shared_ptr<OpRequest>)+0x11b) [0x5c6f3=
b]
>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 17: (OSD::_dispatch(Message*)+=
0x173)
>>>> [0x5d1983]
>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 18: (OSD::ms_dispatch(Message*=
)+0x184)
>>>> [0x5d2254]
>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 19:
>>>> (SimpleMessenger::DispatchQueue::entry()+0x5e9) [0x7d3c09]
>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 20:
>>>> (SimpleMessenger::dispatch_entry()+0x15) [0x7d5195]
>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 21:
>>>> (SimpleMessenger::DispatchThread::entry()+0xd) [0x726bad]
>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 22: (()+0x68ca) [0x7f7f306b88c=
a]
>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 23: (clone()+0x6d) [0x7f7f2f3f=
c92d]
>>>>
>>>
>>> Thnx for looking,
>>>
>>>
>>> Oliver.
>>>
>>> --
>>>
>>> Oliver Francke
>>>
>>> filoo GmbH
>>> Moltkestra=DFe 25a
>>> 33330 G=FCtersloh
>>> HRB4355 AG G=FCtersloh
>>>
>>> Gesch=E4ftsf=FChrer: S.Grewing | J.Rehp=F6hler | C.Kunz
>>>
>>> Folgen Sie uns auf Twitter: http://twitter.com/filoogmbh
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
