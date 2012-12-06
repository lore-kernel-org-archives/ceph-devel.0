From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Re: A couple of OSD-crashes after serious network trouble
Date: Thu, 06 Dec 2012 18:27:04 +0100
Message-ID: <50C0D568.1030209@filoo.de>
References: <50BF2CCB.3000302@filoo.de> <alpine.DEB.2.00.1212050650540.17270@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-7.de-punkt.de ([93.190.64.37]:57642 "EHLO
	mail-7.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424456Ab2LFR1H (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Dec 2012 12:27:07 -0500
In-Reply-To: <alpine.DEB.2.00.1212050650540.17270@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

On 12/05/2012 03:54 PM, Sage Weil wrote:
> On Wed, 5 Dec 2012, Oliver Francke wrote:
>> Hi *,
>>
>> around midnight yesterday we faced some layer-2 network problems. OS=
D's
>> started to lose heartbeats and so on. Slow requests... you name it.
>> So, after all OSD's doing their work, we had in sum around 6 of them=
 crashed,
>> 2 had to be restarted after first start. Should be 8 crashes in tota=
l.
> The recover_got() crash has definitely been resolved in the recent co=
de.
> The others are hard to read since they've been sorted/summed; the ful=
l
> backtrace is better for identifying the crash.  Do you have those
> available?

There is "the other" pattern:

/var/log/ceph/ceph-osd.40.log.1.gz: 1: /usr/bin/ceph-osd() [0x706c59]
/var/log/ceph/ceph-osd.40.log.1.gz: 2: (()+0xeff0) [0x7f7f306c0ff0]
/var/log/ceph/ceph-osd.40.log.1.gz: 3: (gsignal()+0x35) [0x7f7f2f35f1b5=
]
/var/log/ceph/ceph-osd.40.log.1.gz: 4: (abort()+0x180) [0x7f7f2f361fc0]
/var/log/ceph/ceph-osd.40.log.1.gz: 5:=20
(__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f7f2fbf3dc5]
/var/log/ceph/ceph-osd.40.log.1.gz: 6: (()+0xcb166) [0x7f7f2fbf2166]
/var/log/ceph/ceph-osd.40.log.1.gz: 7: (()+0xcb193) [0x7f7f2fbf2193]
/var/log/ceph/ceph-osd.40.log.1.gz: 8: (()+0xcb28e) [0x7f7f2fbf228e]
/var/log/ceph/ceph-osd.40.log.1.gz: 9: (ceph::__ceph_assert_fail(char=20
const*, char const*, int, char const*)+0x793) [0x77e903]
/var/log/ceph/ceph-osd.40.log.1.gz: 10:=20
(PG::merge_log(ObjectStore::Transaction&, pg_info_t&, pg_log_t&,=20
int)+0x1de3) [0x63db93]
/var/log/ceph/ceph-osd.40.log.1.gz: 11:=20
(PG::RecoveryState::Stray::react(PG::RecoveryState::MLogRec=20
const&)+0x2cc) [0x63e00c]
/var/log/ceph/ceph-osd.40.log.1.gz: 12:=20
(boost::statechart::simple_state<PG::RecoveryState::Stray,=20
PG::RecoveryState::Started, boost::mpl::list<mpl_::na, mpl_::na,=20
mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,=20
mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,=20
mpl_::na, mpl_::na, mpl_::na, mpl_::na>,=20
(boost::statechart::history_mode)0>::react_impl(boost::statechart::even=
t_base=20
const&, void const*)+0x203) [0x658a63]
/var/log/ceph/ceph-osd.40.log.1.gz: 13:=20
(boost::statechart::state_machine<PG::RecoveryState::RecoveryMachine,=20
PG::RecoveryState::Initial, std::allocator<void>,=20
boost::statechart::null_exception_translator>::process_event(boost::sta=
techart::event_base=20
const&)+0x6b) [0x650b4b]
/var/log/ceph/ceph-osd.40.log.1.gz: 14:=20
(PG::RecoveryState::handle_log(int, MOSDPGLog*, PG::RecoveryCtx*)+0x190=
)=20
[0x60a520]
/var/log/ceph/ceph-osd.40.log.1.gz: 15:=20
(OSD::handle_pg_log(std::tr1::shared_ptr<OpRequest>)+0x666) [0x5c62e6]
/var/log/ceph/ceph-osd.40.log.1.gz: 16:=20
(OSD::dispatch_op(std::tr1::shared_ptr<OpRequest>)+0x11b) [0x5c6f3b]
/var/log/ceph/ceph-osd.40.log.1.gz: 17: (OSD::_dispatch(Message*)+0x173=
)=20
[0x5d1983]
/var/log/ceph/ceph-osd.40.log.1.gz: 18:=20
(OSD::ms_dispatch(Message*)+0x184) [0x5d2254]
/var/log/ceph/ceph-osd.40.log.1.gz: 19:=20
(SimpleMessenger::DispatchQueue::entry()+0x5e9) [0x7d3c09]
/var/log/ceph/ceph-osd.40.log.1.gz: 20:=20
(SimpleMessenger::dispatch_entry()+0x15) [0x7d5195]
/var/log/ceph/ceph-osd.40.log.1.gz: 21:=20
(SimpleMessenger::DispatchThread::entry()+0xd) [0x726bad]
/var/log/ceph/ceph-osd.40.log.1.gz: 22: (()+0x68ca) [0x7f7f306b88ca]
/var/log/ceph/ceph-osd.40.log.1.gz: 23: (clone()+0x6d) [0x7f7f2f3fc92d]

State at the end of the day: active+clean;

Unfortunately... after some scrubbing today, we see again=20
inconsistencies... *sigh*

End of year syndrom?

Tried to get onto one OSD, which crashed yesterday and fired off some=20
ceph osd scrub 0.
And then ceph osd repair 0.

2012-12-06 16:46:29.818551 7f49f1923700  0 log [ERR] : 65.ad repair sta=
t=20
mismatch, got 4204/4205 objects, 0/0 clones, 16466529280/16470149632 by=
tes.
2012-12-06 16:46:29.818734 7f49f1923700  0 log [ERR] : 65.ad repair 1=20
errors, 1 fixed
2012-12-06 16:46:30.104722 7f49f2124700  0 log [ERR] : 65.23 repair sta=
t=20
mismatch, got 4258/4259 objects, 0/0 clones, 16686233712/16690428016 by=
tes.
2012-12-06 16:46:30.104890 7f49f2124700  0 log [ERR] : 65.23 repair 1=20
errors, 1 fixed
2012-12-06 16:51:26.973407 7f49f2124700  0 log [ERR] : 6.1 osd.31: soid=
=20
bafe2559/rb.0.1adf5.6733efe2.0000000007ce/head//6 size 4194304 !=3D kno=
wn=20
size 3046912
2012-12-06 16:51:26.973426 7f49f2124700  0 log [ERR] : 6.1 repair 0=20
missing, 1 inconsistent objects
2012-12-06 16:51:26.981234 7f49f2124700  0 log [ERR] : 6.1 repair stat=20
mismatch, got 2153/2154 objects, 0/0 clones, 7013002752/7017197056 byte=
s.
2012-12-06 16:51:26.981402 7f49f2124700  0 log [ERR] : 6.1 repair 1=20
errors, 1 fixed

um... is it repaired? Really? Everything cool now for OSD.0?=20
Additionally there are - again - half a dozen headers missing. If=20
corresponding VM's are stopped now, they will not restart, of course.

=46irst tickets are raised by customers having s/t like "filesystems=20
errors... mounted read-only..." on the console and kind of that crap...=
=20
again.

Well then, should one now do a ceph osd repair \* ? Fix the headers? Is=
=20
there a best practice?

Other hints? How can we now discover all of the potential errors=20
_before_ customers may see them, too?

Too many questions, but even more trouble...

Thnx for all attention.

Oliver.


> Thanks!
> sage
>
>
>   >
>> Typical output:
>>
>>
>> =3D=3D=3D 8-< =3D=3D=3D
>> --- begin dump of recent events ---
>>     -10> 2012-12-04 23:35:26.623091 7f1db7895700  5 filestore(/data/=
osd6-1)
>> _do_op 0x21035870 seq 111010292 osr(65.72 0x9e13570)/0x9e13570 start
>>      -9> 2012-12-04 23:35:26.623995 7f1db7895700  5 filestore(/data/=
osd6-1)
>> _do_op 0x21035500 seq 111010294 osr(10.3 0x5b5c170)/0x5b5c170 start
>>      -8> 2012-12-04 23:35:26.624013 7f1db6893700  5 --OSD::tracker--=
 reqid:
>> client.290626.0:798537, seq: 151093878, time: 2012-12-04 23:35:26.62=
4012,
>> event: sub_op_applied, request: osd_sub_op(client.290626.0:798537 65=
=2E72
>> c9612472/rb.0.2d5e5.39bd39.000000000652/head//65 [] v 8084'770407
>> snapset=3D0=3D[]:[] snapc=3D0=3D[]) v7
>>      -7> 2012-12-04 23:35:26.624047 7f1db8096700  5 filestore(/data/=
osd6-1)
>> _do_op 0x21035c80 seq 111010293 osr(65.72 0x9e13570)/0x9e13570 start
>>      -6> 2012-12-04 23:35:26.624119 7f1db6893700  5 --OSD::tracker--=
 reqid:
>> client.290626.0:798537, seq: 151093878, time: 2012-12-04 23:35:26.62=
4119,
>> event: done, request: osd_sub_op(client.290626.0:798537 65.72
>> c9612472/rb.0.2d5e5.39bd39.000000000652/head//65 [] v 8084'770407
>> snapset=3D0=3D[]:[] snapc=3D0=3D[]) v7
>>      -5> 2012-12-04 23:35:26.624953 7f1db6893700  5 --OSD::tracker--=
 reqid:
>> client.290626.0:798549, seq: 151093879, time: 2012-12-04 23:35:26.62=
4953,
>> event: sub_op_applied, request: osd_sub_op(client.290626.0:798549 65=
=2E72
>> c9612472/rb.0.2d5e5.39bd39.000000000652/head//65 [] v 8084'770408
>> snapset=3D0=3D[]:[] snapc=3D0=3D[]) v7
>>      -4> 2012-12-04 23:35:26.625017 7f1db6893700  5 --OSD::tracker--=
 reqid:
>> client.290626.0:798549, seq: 151093879, time: 2012-12-04 23:35:26.62=
5017,
>> event: done, request: osd_sub_op(client.290626.0:798549 65.72
>> c9612472/rb.0.2d5e5.39bd39.000000000652/head//65 [] v 8084'770408
>> snapset=3D0=3D[]:[] snapc=3D0=3D[]) v7
>>      -3> 2012-12-04 23:35:26.626220 7f1db7895700  5 filestore(/data/=
osd6-1)
>> _do_op 0x21035f00 seq 111010296 osr(6.7 0x5ca4570)/0x5ca4570 start
>>      -2> 2012-12-04 23:35:26.626218 7f1db8096700  5 filestore(/data/=
osd6-1)
>> _do_op 0x21035e10 seq 111010295 osr(10.3 0x5b5c170)/0x5b5c170 start
>>      -1> 2012-12-04 23:35:26.652283 7f1daed81700  5
>> throttle(msgr_dispatch_throttler-cluster 0x2791560) get 1049621 (0 -=
> 1049621)
>>       0> 2012-12-04 23:35:26.654669 7f1db1f89700 -1 *** Caught signa=
l (Aborted)
>> **
>>   in thread 7f1db1f89700
>>
>>   ceph version 0.48.2argonaut (commit:3e02b2fad88c2a95d9c0c86878f10d=
1beb780bfe)
>>   1: /usr/bin/ceph-osd() [0x6edaba]
>>   2: (()+0xfcb0) [0x7f1dc34c7cb0]
>>   3: (gsignal()+0x35) [0x7f1dc208e425]
>>   4: (abort()+0x17b) [0x7f1dc2091b8b]
>>   5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f1dc29e769=
d]
>>   6: (()+0xb5846) [0x7f1dc29e5846]
>>   7: (()+0xb5873) [0x7f1dc29e5873]
>>   8: (()+0xb596e) [0x7f1dc29e596e]
>>   9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>> const*)+0x1de) [0x7a82fe]
>>   10: (ReplicatedPG::recover_got(hobject_t, eversion_t)+0x4ae) [0x52=
b5ee]
>>   11: (ReplicatedPG::submit_push_complete(ObjectRecoveryInfo&,
>> ObjectStore::Transaction*)+0x470) [0x52ddd0]
>>   12:
>> (ReplicatedPG::handle_pull_response(std::tr1::shared_ptr<OpRequest>)=
+0x4d4)
>> [0x54b124]
>>   13: (ReplicatedPG::sub_op_push(std::tr1::shared_ptr<OpRequest>)+0x=
98)
>> [0x54bef8]
>>   14: (ReplicatedPG::do_sub_op(std::tr1::shared_ptr<OpRequest>)+0x3f=
7)
>> [0x54c3a7]
>>   15: (PG::do_request(std::tr1::shared_ptr<OpRequest>)+0x9f) [0x6007=
3f]
>>   16: (OSD::dequeue_op(PG*)+0x238) [0x5bfaf8]
>>   17: (ThreadPool::worker()+0x4d5) [0x79f835]
>>   18: (ThreadPool::WorkThread::entry()+0xd) [0x5d87cd]
>>   19: (()+0x7e9a) [0x7f1dc34bfe9a]
>>   20: (clone()+0x6d) [0x7f1dc214bcbd]
>>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is =
needed to
>> interpret this.
>>
>> --- end dump of recent events ---
>>
>> =3D=3D=3D 8-< =3D=3D=3D
>>
>> A - not very scientific, but useful - aggregation of all OSD-outputs=
 as
>> follows. My hope is, that someone says:
>> "Uhm, OK, tha's fixed in ..." ;)
>>
>> ( count of occurences and corresponding string)
>>
>> =3D=3D=3D 8-< =3D=3D=3D
>>
>>        4 (boost::statechart::simple_state<PG::RecoveryState::Stray,
>>        4 (boost::statechart::state_machine<PG::RecoveryState::Recove=
ryMachine,
>>       18 (ceph::__ceph_assert_fail(char
>>       36 (clone()+0x6d)
>>       18 (gsignal()+0x35)
>>       16 (OSD::dequeue_op(PG*)+0x238)
>>       16 (OSD::dequeue_op(PG*)+0x39a)
>>        4 (OSD::_dispatch(Message*)+0x173)
>>        4 (OSD::dispatch_op(std::tr1::shared_ptr<OpRequest>)+0x11b)
>>        4 (OSD::handle_pg_log(std::tr1::shared_ptr<OpRequest>)+0x666)
>>        4 (OSD::ms_dispatch(Message*)+0x184)
>>       16 (PG::do_request(std::tr1::shared_ptr<OpRequest>)+0x9f)
>>       16 (PG::do_request(std::tr1::shared_ptr<OpRequest>)+0xab)
>>        4 (PG::merge_log(ObjectStore::Transaction&,
>>        4 (PG::RecoveryState::handle_log(int,
>>        4 (PG::RecoveryState::Stray::react(PG::RecoveryState::MLogRec
>>       16 (ReplicatedPG::do_sub_op(std::tr1::shared_ptr<OpRequest>)+0=
x32e)
>>       16 (ReplicatedPG::do_sub_op(std::tr1::shared_ptr<OpRequest>)+0=
x3f7)
>>       12
>> (ReplicatedPG::handle_pull_response(std::tr1::shared_ptr<OpRequest>)=
+0x4d4)
>>       16
>> (ReplicatedPG::handle_pull_response(std::tr1::shared_ptr<OpRequest>)=
+0xb24)
>>        4 (ReplicatedPG::handle_push(std::tr1::shared_ptr<OpRequest>)=
+0x263)
>>       32 (ReplicatedPG::recover_got(hobject_t,
>>       32 (ReplicatedPG::submit_push_complete(ObjectRecoveryInfo&,
>>       12 (ReplicatedPG::sub_op_push(std::tr1::shared_ptr<OpRequest>)=
+0x98)
>>       16 (ReplicatedPG::sub_op_push(std::tr1::shared_ptr<OpRequest>)=
+0xa2)
>>        4 (ReplicatedPG::sub_op_push(std::tr1::shared_ptr<OpRequest>)=
+0xf3)
>>        4 (SimpleMessenger::dispatch_entry()+0x15)
>>        4 (SimpleMessenger::DispatchQueue::entry()+0x5e9)
>>        4 (SimpleMessenger::DispatchThread::entry()+0xd)
>>       16 (ThreadPool::worker()+0x4d5)
>>       16 (ThreadPool::worker()+0x76f)
>>       32 (ThreadPool::WorkThread::entry()+0xd)
>>
>> =3D=3D=3D 8-< =3D=3D=3D
>>
>> Everything has cleared up so far, so that's some good news ;)
>>
>> Comments welcome,
>>
>> Oliver.
>>
>> --=20
>>
>> Oliver Francke
>>
>> filoo GmbH
>> Moltkestra?e 25a
>> 33330 G?tersloh
>> HRB4355 AG G?tersloh
>>
>> Gesch?ftsf?hrer: S.Grewing | J.Rehp?hler | C.Kunz
>>
>> Folgen Sie uns auf Twitter: http://twitter.com/filoogmbh
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


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
