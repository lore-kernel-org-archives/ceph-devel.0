From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: A couple of OSD-crashes after serious network trouble
Date: Wed, 05 Dec 2012 12:15:23 +0100
Message-ID: <50BF2CCB.3000302@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-5.de-punkt.de ([93.190.64.35]:44373 "EHLO
	mail-5.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813Ab2LELP1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Dec 2012 06:15:27 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi *,

around midnight yesterday we faced some layer-2 network problems. OSD's=
=20
started to lose heartbeats and so on. Slow requests... you name it.
So, after all OSD's doing their work, we had in sum around 6 of them=20
crashed, 2 had to be restarted after first start. Should be 8 crashes i=
n=20
total.

Typical output:


=3D=3D=3D 8-< =3D=3D=3D
--- begin dump of recent events ---
    -10> 2012-12-04 23:35:26.623091 7f1db7895700  5=20
filestore(/data/osd6-1) _do_op 0x21035870 seq 111010292 osr(65.72=20
0x9e13570)/0x9e13570 start
     -9> 2012-12-04 23:35:26.623995 7f1db7895700  5=20
filestore(/data/osd6-1) _do_op 0x21035500 seq 111010294 osr(10.3=20
0x5b5c170)/0x5b5c170 start
     -8> 2012-12-04 23:35:26.624013 7f1db6893700  5 --OSD::tracker--=20
reqid: client.290626.0:798537, seq: 151093878, time: 2012-12-04=20
23:35:26.624012, event: sub_op_applied, request:=20
osd_sub_op(client.290626.0:798537 65.72=20
c9612472/rb.0.2d5e5.39bd39.000000000652/head//65 [] v 8084'770407=20
snapset=3D0=3D[]:[] snapc=3D0=3D[]) v7
     -7> 2012-12-04 23:35:26.624047 7f1db8096700  5=20
filestore(/data/osd6-1) _do_op 0x21035c80 seq 111010293 osr(65.72=20
0x9e13570)/0x9e13570 start
     -6> 2012-12-04 23:35:26.624119 7f1db6893700  5 --OSD::tracker--=20
reqid: client.290626.0:798537, seq: 151093878, time: 2012-12-04=20
23:35:26.624119, event: done, request: osd_sub_op(client.290626.0:79853=
7=20
65.72 c9612472/rb.0.2d5e5.39bd39.000000000652/head//65 [] v 8084'770407=
=20
snapset=3D0=3D[]:[] snapc=3D0=3D[]) v7
     -5> 2012-12-04 23:35:26.624953 7f1db6893700  5 --OSD::tracker--=20
reqid: client.290626.0:798549, seq: 151093879, time: 2012-12-04=20
23:35:26.624953, event: sub_op_applied, request:=20
osd_sub_op(client.290626.0:798549 65.72=20
c9612472/rb.0.2d5e5.39bd39.000000000652/head//65 [] v 8084'770408=20
snapset=3D0=3D[]:[] snapc=3D0=3D[]) v7
     -4> 2012-12-04 23:35:26.625017 7f1db6893700  5 --OSD::tracker--=20
reqid: client.290626.0:798549, seq: 151093879, time: 2012-12-04=20
23:35:26.625017, event: done, request: osd_sub_op(client.290626.0:79854=
9=20
65.72 c9612472/rb.0.2d5e5.39bd39.000000000652/head//65 [] v 8084'770408=
=20
snapset=3D0=3D[]:[] snapc=3D0=3D[]) v7
     -3> 2012-12-04 23:35:26.626220 7f1db7895700  5=20
filestore(/data/osd6-1) _do_op 0x21035f00 seq 111010296 osr(6.7=20
0x5ca4570)/0x5ca4570 start
     -2> 2012-12-04 23:35:26.626218 7f1db8096700  5=20
filestore(/data/osd6-1) _do_op 0x21035e10 seq 111010295 osr(10.3=20
0x5b5c170)/0x5b5c170 start
     -1> 2012-12-04 23:35:26.652283 7f1daed81700  5=20
throttle(msgr_dispatch_throttler-cluster 0x2791560) get 1049621 (0 ->=20
1049621)
      0> 2012-12-04 23:35:26.654669 7f1db1f89700 -1 *** Caught signal=20
(Aborted) **
  in thread 7f1db1f89700

  ceph version 0.48.2argonaut=20
(commit:3e02b2fad88c2a95d9c0c86878f10d1beb780bfe)
  1: /usr/bin/ceph-osd() [0x6edaba]
  2: (()+0xfcb0) [0x7f1dc34c7cb0]
  3: (gsignal()+0x35) [0x7f1dc208e425]
  4: (abort()+0x17b) [0x7f1dc2091b8b]
  5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f1dc29e769d]
  6: (()+0xb5846) [0x7f1dc29e5846]
  7: (()+0xb5873) [0x7f1dc29e5873]
  8: (()+0xb596e) [0x7f1dc29e596e]
  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char=20
const*)+0x1de) [0x7a82fe]
  10: (ReplicatedPG::recover_got(hobject_t, eversion_t)+0x4ae) [0x52b5e=
e]
  11: (ReplicatedPG::submit_push_complete(ObjectRecoveryInfo&,=20
ObjectStore::Transaction*)+0x470) [0x52ddd0]
  12:=20
(ReplicatedPG::handle_pull_response(std::tr1::shared_ptr<OpRequest>)+0x=
4d4)=20
[0x54b124]
  13: (ReplicatedPG::sub_op_push(std::tr1::shared_ptr<OpRequest>)+0x98)=
=20
[0x54bef8]
  14: (ReplicatedPG::do_sub_op(std::tr1::shared_ptr<OpRequest>)+0x3f7)=20
[0x54c3a7]
  15: (PG::do_request(std::tr1::shared_ptr<OpRequest>)+0x9f) [0x60073f]
  16: (OSD::dequeue_op(PG*)+0x238) [0x5bfaf8]
  17: (ThreadPool::worker()+0x4d5) [0x79f835]
  18: (ThreadPool::WorkThread::entry()+0xd) [0x5d87cd]
  19: (()+0x7e9a) [0x7f1dc34bfe9a]
  20: (clone()+0x6d) [0x7f1dc214bcbd]
  NOTE: a copy of the executable, or `objdump -rdS <executable>` is=20
needed to interpret this.

--- end dump of recent events ---

=3D=3D=3D 8-< =3D=3D=3D

A - not very scientific, but useful - aggregation of all OSD-outputs as=
=20
follows. My hope is, that someone says:
"Uhm, OK, tha's fixed in ..." ;)

( count of occurences and corresponding string)

=3D=3D=3D 8-< =3D=3D=3D

       4 (boost::statechart::simple_state<PG::RecoveryState::Stray,
       4=20
(boost::statechart::state_machine<PG::RecoveryState::RecoveryMachine,
      18 (ceph::__ceph_assert_fail(char
      36 (clone()+0x6d)
      18 (gsignal()+0x35)
      16 (OSD::dequeue_op(PG*)+0x238)
      16 (OSD::dequeue_op(PG*)+0x39a)
       4 (OSD::_dispatch(Message*)+0x173)
       4 (OSD::dispatch_op(std::tr1::shared_ptr<OpRequest>)+0x11b)
       4 (OSD::handle_pg_log(std::tr1::shared_ptr<OpRequest>)+0x666)
       4 (OSD::ms_dispatch(Message*)+0x184)
      16 (PG::do_request(std::tr1::shared_ptr<OpRequest>)+0x9f)
      16 (PG::do_request(std::tr1::shared_ptr<OpRequest>)+0xab)
       4 (PG::merge_log(ObjectStore::Transaction&,
       4 (PG::RecoveryState::handle_log(int,
       4 (PG::RecoveryState::Stray::react(PG::RecoveryState::MLogRec
      16 (ReplicatedPG::do_sub_op(std::tr1::shared_ptr<OpRequest>)+0x32=
e)
      16 (ReplicatedPG::do_sub_op(std::tr1::shared_ptr<OpRequest>)+0x3f=
7)
      12=20
(ReplicatedPG::handle_pull_response(std::tr1::shared_ptr<OpRequest>)+0x=
4d4)
      16=20
(ReplicatedPG::handle_pull_response(std::tr1::shared_ptr<OpRequest>)+0x=
b24)
       4 (ReplicatedPG::handle_push(std::tr1::shared_ptr<OpRequest>)+0x=
263)
      32 (ReplicatedPG::recover_got(hobject_t,
      32 (ReplicatedPG::submit_push_complete(ObjectRecoveryInfo&,
      12 (ReplicatedPG::sub_op_push(std::tr1::shared_ptr<OpRequest>)+0x=
98)
      16 (ReplicatedPG::sub_op_push(std::tr1::shared_ptr<OpRequest>)+0x=
a2)
       4 (ReplicatedPG::sub_op_push(std::tr1::shared_ptr<OpRequest>)+0x=
f3)
       4 (SimpleMessenger::dispatch_entry()+0x15)
       4 (SimpleMessenger::DispatchQueue::entry()+0x5e9)
       4 (SimpleMessenger::DispatchThread::entry()+0xd)
      16 (ThreadPool::worker()+0x4d5)
      16 (ThreadPool::worker()+0x76f)
      32 (ThreadPool::WorkThread::entry()+0xd)

=3D=3D=3D 8-< =3D=3D=3D

Everything has cleared up so far, so that's some good news ;)

Comments welcome,

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
