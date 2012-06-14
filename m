From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: ceph crash after creating a fresh ceph cluster
Date: Thu, 14 Jun 2012 11:51:26 +0200
Message-ID: <4FD9B41E.3050501@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:40641 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755115Ab2FNJvd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Jun 2012 05:51:33 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello list,

i've created a new ceph fs with:
mkcephfs -a -c /etc/ceph/ceph.conf -k /etc/ceph/client.admin.keyring

I've then connected to ceph with ceph -w and got pretty immediatly this=
=20
crash:

012-06-14 11:48:23.965577 7f548365c700  0 monclient: hunting for new mo=
n
ceph: mon/PGMap.cc:137: void PGMap::apply_incremental(const=20
PGMap::Incremental&): Assertion `inc.version =3D=3D version+1' failed.
*** Caught signal (Aborted) **
  in thread 7f548365c700
  ceph version 0.47.2-4-ge868b44=20
(commit:e868b44b3959a71c731f4ec9ff9773dead6dfcb5)
  1: ceph() [0x478939]
  2: (()+0xeff0) [0x7f5486cc3ff0]
  3: (gsignal()+0x35) [0x7f54854e6225]
  4: (abort()+0x180) [0x7f54854e9030]
  5: (__assert_fail()+0xf1) [0x7f54854df361]
  6: (PGMap::apply_incremental(PGMap::Incremental const&)+0x11f6) [0x47=
1c26]
  7: ceph() [0x45af75]
  8: (Admin::ms_dispatch(Message*)+0x669) [0x46a2a9]
  9: (SimpleMessenger::dispatch_entry()+0x979) [0x4961e9]
  10: (SimpleMessenger::DispatchThread::entry()+0xd) [0x45fa9d]
  11: (()+0x68ca) [0x7f5486cbb8ca]
  12: (clone()+0x6d) [0x7f5485583c0d]
2012-06-14 11:48:50.822072 7f548365c700 -1 *** Caught signal (Aborted) =
**
  in thread 7f548365c700

  ceph version 0.47.2-4-ge868b44=20
(commit:e868b44b3959a71c731f4ec9ff9773dead6dfcb5)
  1: ceph() [0x478939]
  2: (()+0xeff0) [0x7f5486cc3ff0]
  3: (gsignal()+0x35) [0x7f54854e6225]
  4: (abort()+0x180) [0x7f54854e9030]
  5: (__assert_fail()+0xf1) [0x7f54854df361]
  6: (PGMap::apply_incremental(PGMap::Incremental const&)+0x11f6) [0x47=
1c26]
  7: ceph() [0x45af75]
  8: (Admin::ms_dispatch(Message*)+0x669) [0x46a2a9]
  9: (SimpleMessenger::dispatch_entry()+0x979) [0x4961e9]
  10: (SimpleMessenger::DispatchThread::entry()+0xd) [0x45fa9d]
  11: (()+0x68ca) [0x7f5486cbb8ca]
  12: (clone()+0x6d) [0x7f5485583c0d]
  NOTE: a copy of the executable, or `objdump -rdS <executable>` is=20
needed to interpret this.

--- begin dump of recent events ---
     -2> 2012-06-14 11:47:42.886405 7f548365c700  0 monclient: hunting=20
for new mon
     -1> 2012-06-14 11:48:23.965577 7f548365c700  0 monclient: hunting=20
for new mon
      0> 2012-06-14 11:48:50.822072 7f548365c700 -1 *** Caught signal=20
(Aborted) **
  in thread 7f548365c700

  ceph version 0.47.2-4-ge868b44=20
(commit:e868b44b3959a71c731f4ec9ff9773dead6dfcb5)
  1: ceph() [0x478939]
  2: (()+0xeff0) [0x7f5486cc3ff0]
  3: (gsignal()+0x35) [0x7f54854e6225]
  4: (abort()+0x180) [0x7f54854e9030]
  5: (__assert_fail()+0xf1) [0x7f54854df361]
  6: (PGMap::apply_incremental(PGMap::Incremental const&)+0x11f6) [0x47=
1c26]
  7: ceph() [0x45af75]
  8: (Admin::ms_dispatch(Message*)+0x669) [0x46a2a9]
  9: (SimpleMessenger::dispatch_entry()+0x979) [0x4961e9]
  10: (SimpleMessenger::DispatchThread::entry()+0xd) [0x45fa9d]
  11: (()+0x68ca) [0x7f5486cbb8ca]
  12: (clone()+0x6d) [0x7f5485583c0d]
  NOTE: a copy of the executable, or `objdump -rdS <executable>` is=20
needed to interpret this.

--- end dump of recent events ---
Aborted

--=20
Mit freundlichen Gr=FC=DFen
   Stefan Priebe
Bachelor of Science in Computer Science (BSCS)
Vorstand (CTO)

-------------------------------
Profihost AG
Am Mittelfelde 29
30519 Hannover
Deutschland

Tel.: +49 (511) 5151 8181     | Fax.: +49 (511) 5151 8282
URL: http://www.profihost.com | E-Mail: info@profihost.com

Sitz der Gesellschaft: Hannover, USt-IdNr. DE813460827
Registergericht: Amtsgericht Hannover, Register-Nr.: HRB 202350
Vorstand: Cristoph Bluhm, Sebastian Bluhm, Stefan Priebe
Aufsichtsrat: Prof. Dr. iur. Winfried Huck (Vorsitzender)
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
