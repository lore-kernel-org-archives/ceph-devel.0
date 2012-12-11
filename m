From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Re: A couple of OSD-crashes after serious network trouble
Date: Tue, 11 Dec 2012 20:38:28 +0100
Message-ID: <D0F1E938-CF21-4574-9A82-131D9016E190@filoo.de>
References: <50BF2CCB.3000302@filoo.de> <alpine.DEB.2.00.1212050650540.17270@cobra.newdream.net> <50C0D568.1030209@filoo.de> <50C1FFBF.6080802@filoo.de> <CA+4uBUaEei_HLJxG44p_vtQTy+HKb3DR-rCjGdvTo+hP2UsFxQ@mail.gmail.com> <C56EB768-EED4-41BC-A40F-FE46C7819560@filoo.de> <CA+4uBUYzOhxb1WHrULF=j5Vemdinz7gETdt0O1kuGa1mdETO1w@mail.gmail.com> <50C5BE15.5050209@filoo.de> <50C74EF1.6080000@filoo.de> <alpine.DEB.2.00.1212110855040.32154@cobra.newdream.net>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-3.de-punkt.de ([93.190.64.33]:54153 "EHLO
	mail-3.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949Ab2LKTia convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Dec 2012 14:38:30 -0500
In-Reply-To: <alpine.DEB.2.00.1212110855040.32154@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Samuel Just <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,

Am 11.12.2012 um 18:04 schrieb Sage Weil <sage@inktank.com>:

> On Tue, 11 Dec 2012, Oliver Francke wrote:
>> Hi Sam,
>>=20
>> perhaps you have overlooked my comments further down, beginning with
>> "been there" ? ;)
>=20
> We're pretty swamped with bobtail stuff at the moment, so ceph-devel=20
> inquiries are low on the priority list right now.
>=20

100% agree, this thing here is "best effort" right now, true.

> See below:
>=20
>>=20
>> If so, please have a look, cause I'm clueless 8-)
>>=20
>> On 12/10/2012 11:48 AM, Oliver Francke wrote:
>>> Hi Sam,
>>>=20
>>> helpful input.. and... not so...
>>>=20
>>> On 12/07/2012 10:18 PM, Samuel Just wrote:
>>>> Ah... unfortunately doing a repair in these 6 cases would probably
>>>> result in the wrong object surviving.  It should work, but it migh=
t
>>>> corrupt the rbd image contents.  If the images are expendable, you
>>>> could repair and then delete the images.
>>>>=20
>>>> The red flag here is that the "known size" is smaller than the oth=
er
>>>> size.  This indicates that it most likely chose the wrong file as =
the
>>>> "correct" one since rbd image blocks usually get bigger over time.=
  To
>>>> fix this, you will need to manually copy the file for the larger o=
f
>>>> the two object replicas to replace the smaller of the two object
>>>> replicas.
>>>>=20
>>>> For the first, soid 87c96f10/rb.0.47d9b.1014b7b4.0000000002df/head=
//65
>>>> in pg 65.10:
>>>> 1) Find the object on the primary and the replica (from above, pri=
mary
>>>> is 12 and replica is 40).  You can use find in the primary and rep=
lica
>>>> current/65.10_head directories to look for a file matching
>>>> *rb.0.47d9b.1014b7b4.0000000002df*).  The file name should be
>>>> 'rb.0.47d9b.1014b7b4.0000000002df__head_87C96F10__65' I think.
>>>> 2) Stop the primary and replica osds
>>>> 3) Compare the file sizes for the two files -- you should find tha=
t
>>>> the file sizes do not match.
>>>> 4) Replace the smaller file with the larger one (you'll probably w=
ant
>>>> to keep a copy of the smaller one around just in case).
>>>> 5) Restart the osds and scrub pg 65.10 -- the pg should come up cl=
ean
>>>> (possibly with a relatively harmless stat mismatch)
>>>=20
>>> been there. on OSD.12 it's
>>> -rw-r--r-- 1 root root 699904 Dec  9 06:25
>>> rb.0.47d9b.1014b7b4.0000000002df__head_87C96F10__41
>>>=20
>>> on OSD.40:
>>> -rw-r--r-- 1 root root 4194304 Dec  9 06:25
>>> rb.0.47d9b.1014b7b4.0000000002df__head_87C96F10__41
>>>=20
>>> going by a short glance into the file, there are some readable
>>> syslog-entries, in both files.
>>> For the bad luck in this example, the shorter file contains the mor=
e current
>>> entries?!
>=20
> It sounds like the larger one was at one point correct, but since the=
y got=20
> out of sync an update was applied to the other.  What fs is this (ins=
ide=20
> the VM)?  If we're lucky the whole block is file data, in which case =
I=20
> would extend the small one with more recent out to the full size by t=
aking=20
> the last chunk of the second one.  (Or, if the bytes look like an=20
> unimportant file, just use truncate(1) to extend it, and get zeros fo=
r=20
> that region.)  Make backups of the object first, and fsck inside the =
VM=20
> afterwards.
>=20
> --
>=20
> We've seen this issue bite twice now, both times on argonaut.  So far=
=20
> nobody using anything more recent..but that is a smaller pool of peop=
le,=20
> so no real comform there.  Working on setting up a higher-stress long=
-term=20
> testing cluster to trigger this.
>=20
> Can you remind me what kernel version you are using?

one of the affected nodes are driven by 3.5.4, the newer ones are nowad=
ays Ubtuntu 12.04.1 LTS with self-compiled 3.6.6.
Inside the VM's you can imagine all flavors, less forgiving CentOS 5.8,=
 some debian5.0 ( ext3)=85 mostly ext3, I think. Not optimum, at least.

Couple of problems caused by slow requests, I can see in some log-files=
 customers pressing the "RESET" button, implemented via qemu-monitor.
Destructive as can be, with having some megs of cache with the rbd-devi=
ce.

Thnx n regards,

Oliver.

>=20
> sage
>=20
>=20
>>>=20
>>> What exactly happens, if I try to copy or export the file? Which bl=
ock will
>>> be chosen?
>>> VM is running as I'm writing, so flexibility reduced.
>>>=20
>>> Regards,
>>>=20
>>> Oliver.
>>>=20
>>>> If this worked our correctly, you can repeat for the other 5 cases=
=2E
>>>>=20
>>>> Let me know if you have any questions.
>>>> -Sam
>>>>=20
>>>> On Fri, Dec 7, 2012 at 11:09 AM, Oliver Francke <Oliver.Francke@fi=
loo.de>
>>>> wrote:
>>>>> Hi Sam,
>>>>>=20
>>>>> Am 07.12.2012 um 19:37 schrieb Samuel Just <sam.just@inktank.com>=
:
>>>>>=20
>>>>>> That is very likely to be one of the merge_log bugs fixed betwee=
n 0.48
>>>>>> and 0.55.  I could confirm with a stacktrace from gdb with line
>>>>>> numbers or the remainder of the logging dumped when the daemon
>>>>>> crashed.
>>>>>>=20
>>>>>> My understanding of your situation is that currently all pgs are
>>>>>> active+clean but you are missing some rbd image headers and some=
 rbd
>>>>>> images appear to be corrupted.  Is that accurate?
>>>>>> -Sam
>>>>>>=20
>>>>> thnx for droppig in.
>>>>>=20
>>>>> Uhm almost correct, there are now 6 pg in state inconsistent:
>>>>>=20
>>>>> HEALTH_WARN 6 pgs inconsistent
>>>>> pg 65.da is active+clean+inconsistent, acting [1,33]
>>>>> pg 65.d7 is active+clean+inconsistent, acting [13,42]
>>>>> pg 65.10 is active+clean+inconsistent, acting [12,40]
>>>>> pg 65.f is active+clean+inconsistent, acting [13,31]
>>>>> pg 65.75 is active+clean+inconsistent, acting [1,33]
>>>>> pg 65.6a is active+clean+inconsistent, acting [13,31]
>>>>>=20
>>>>> I know which images are affected, but does a repair help?
>>>>>=20
>>>>> 0 log [ERR] : 65.10 osd.40: soid
>>>>> 87c96f10/rb.0.47d9b.1014b7b4.0000000002df/head//65 size 4194304 !=
=3D known
>>>>> size 699904
>>>>> 0 log [ERR] : 65.6a osd.31: soid
>>>>> 19a2526a/rb.0.2dcf2.1da2a31e.000000000737/head//65 size 4191744 !=
=3D known
>>>>> size 2757632
>>>>> 0 log [ERR] : 65.75 osd.33: soid
>>>>> 20550575/rb.0.2d520.5c17a6e3.000000000339/head//65 size 4194304 !=
=3D known
>>>>> size 1238016
>>>>> 0 log [ERR] : 65.d7 osd.42: soid
>>>>> fa3a5d7/rb.0.2c2a8.12ec359d.00000000205c/head//65 size 4194304 !=3D=
 known
>>>>> size 1382912
>>>>> 0 log [ERR] : 65.da osd.33: soid
>>>>> c2a344da/rb.0.2be17.cb4bd69.000000000081/head//65 size 4191744 !=3D=
 known
>>>>> size 1815552
>>>>> 0 log [ERR] : 65.f osd.31: soid
>>>>> e8d2430f/rb.0.2d1e9.1339c5dd.000000000c41/head//65 size 2424832 !=
=3D known
>>>>> size 2331648
>>>>>=20
>>>>> of make things worse?
>>>>>=20
>>>>> I could only check 14 out of 20 OSD's so far, cause from two olde=
r nodes
>>>>> a scrub leads to slow-requests? > couple of minutes, so VM's got
>>>>> stalled? customers pressing the "reset-button", so losing caches?
>>>>>=20
>>>>> Comments welcome,
>>>>>=20
>>>>> Oliver.
>>>>>=20
>>>>>> On Fri, Dec 7, 2012 at 6:39 AM, Oliver Francke
>>>>>> <Oliver.Francke@filoo.de> wrote:
>>>>>>> Hi,
>>>>>>>=20
>>>>>>> is the following a "known one", too? Would be good to get it ou=
t of
>>>>>>> my head:
>>>>>>>=20
>>>>>>>=20
>>>>>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 1: /usr/bin/ceph-osd()
>>>>>>>> [0x706c59]
>>>>>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 2: (()+0xeff0)
>>>>>>>> [0x7f7f306c0ff0]
>>>>>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 3: (gsignal()+0x35)
>>>>>>>> [0x7f7f2f35f1b5]
>>>>>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 4: (abort()+0x180)
>>>>>>>> [0x7f7f2f361fc0]
>>>>>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 5:
>>>>>>>> (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f7f2fbf3d=
c5]
>>>>>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 6: (()+0xcb166)
>>>>>>>> [0x7f7f2fbf2166]
>>>>>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 7: (()+0xcb193)
>>>>>>>> [0x7f7f2fbf2193]
>>>>>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 8: (()+0xcb28e)
>>>>>>>> [0x7f7f2fbf228e]
>>>>>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 9:
>>>>>>>> (ceph::__ceph_assert_fail(char
>>>>>>>> const*, char const*, int, char const*)+0x793) [0x77e903]
>>>>>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 10:
>>>>>>>> (PG::merge_log(ObjectStore::Transaction&, pg_info_t&, pg_log_t=
&,
>>>>>>>> int)+0x1de3) [0x63db93]
>>>>>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 11:
>>>>>>>> (PG::RecoveryState::Stray::react(PG::RecoveryState::MLogRec
>>>>>>>> const&)+0x2cc)
>>>>>>>> [0x63e00c]
>>>>>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 12:
>>>>>>>> (boost::statechart::simple_state<PG::RecoveryState::Stray,
>>>>>>>> PG::RecoveryState::Started, boost::mpl::list<mpl_::na, mpl_::n=
a,
>>>>>>>> mpl_::na,
>>>>>>>> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
>>>>>>>> mpl_::na,
>>>>>>>> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
>>>>>>>> mpl_::na,
>>>>>>>> mpl_::na, mpl_::na, mpl_::na>,
>>>>>>>> (boost::statechart::history_mode)0>::react_impl(boost::statech=
art::event_base=20
>>>>>>>> const&, void const*)+0x203) [0x658a63]
>>>>>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 13:
>>>>>>>> (boost::statechart::state_machine<PG::RecoveryState::RecoveryM=
achine,=20
>>>>>>>> PG::RecoveryState::Initial, std::allocator<void>,
>>>>>>>> boost::statechart::null_exception_translator>::process_event(b=
oost::statechart::event_base=20
>>>>>>>> const&)+0x6b) [0x650b4b]
>>>>>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 14:
>>>>>>>> (PG::RecoveryState::handle_log(int, MOSDPGLog*,
>>>>>>>> PG::RecoveryCtx*)+0x190)
>>>>>>>> [0x60a520]
>>>>>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 15:
>>>>>>>> (OSD::handle_pg_log(std::tr1::shared_ptr<OpRequest>)+0x666)
>>>>>>>> [0x5c62e6]
>>>>>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 16:
>>>>>>>> (OSD::dispatch_op(std::tr1::shared_ptr<OpRequest>)+0x11b)
>>>>>>>> [0x5c6f3b]
>>>>>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 17:
>>>>>>>> (OSD::_dispatch(Message*)+0x173)
>>>>>>>> [0x5d1983]
>>>>>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 18:
>>>>>>>> (OSD::ms_dispatch(Message*)+0x184)
>>>>>>>> [0x5d2254]
>>>>>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 19:
>>>>>>>> (SimpleMessenger::DispatchQueue::entry()+0x5e9) [0x7d3c09]
>>>>>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 20:
>>>>>>>> (SimpleMessenger::dispatch_entry()+0x15) [0x7d5195]
>>>>>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 21:
>>>>>>>> (SimpleMessenger::DispatchThread::entry()+0xd) [0x726bad]
>>>>>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 22: (()+0x68ca)
>>>>>>>> [0x7f7f306b88ca]
>>>>>>>> /var/log/ceph/ceph-osd.40.log.1.gz: 23: (clone()+0x6d)
>>>>>>>> [0x7f7f2f3fc92d]
>>>>>>>>=20
>>>>>>> Thnx for looking,
>>>>>>>=20
>>>>>>>=20
>>>>>>> Oliver.
>>>>>>>=20
>>>>>>> --=20
>>>>>>>=20
>>>>>>> Oliver Francke
>>>>>>>=20
>>>>>>> filoo GmbH
>>>>>>> Moltkestra?e 25a
>>>>>>> 33330 G?tersloh
>>>>>>> HRB4355 AG G?tersloh
>>>>>>>=20
>>>>>>> Gesch?ftsf?hrer: S.Grewing | J.Rehp?hler | C.Kunz
>>>>>>>=20
>>>>>>> Folgen Sie uns auf Twitter: http://twitter.com/filoogmbh
>>>>>>>=20
>>>>>>> --=20
>>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>>> ceph-devel" in
>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>> More majordomo info at http://vger.kernel.org/majordomo-info.ht=
ml
>>>>>> --=20
>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel"
>>>>>> in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at http://vger.kernel.org/majordomo-info.htm=
l
>>>=20
>>>=20
>>=20
>>=20
>> --=20
>>=20
>> Oliver Francke
>>=20
>> filoo GmbH
>> Moltkestra?e 25a
>> 33330 G?tersloh
>> HRB4355 AG G?tersloh
>>=20
>> Gesch?ftsf?hrer: S.Grewing | J.Rehp?hler | C.Kunz
>>=20
>> Folgen Sie uns auf Twitter: http://twitter.com/filoogmbh
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>=20
>>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
