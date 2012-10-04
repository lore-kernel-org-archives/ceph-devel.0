From: Smart Weblications GmbH - Florian Wiessner
	<f.wiessner@smart-weblications.de>
Subject: ceph-mon not starting
Date: Thu, 04 Oct 2012 15:38:16 +0200
Message-ID: <506D9148.9040106@smart-weblications.de>
Reply-To: f.wiessner@smart-weblications.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx02.smart-weblications.de ([188.65.144.37]:36234 "EHLO
	mx02.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933044Ab2JDNhy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Oct 2012 09:37:54 -0400
Received: from office.smart-weblications.net (office.smart-weblications.net [91.204.168.193])
	by mx02.smart-weblications.de (Postfix) with ESMTPA id 19B7BC3615E
	for <ceph-devel@vger.kernel.org>; Thu,  4 Oct 2012 13:37:52 +0000 (UTC)
Received: from [192.168.200.13] (callosum.office.smart-weblications.net [192.168.200.13])
	by office.smart-weblications.net (Postfix) with ESMTP id 9B03D11404D3
	for <ceph-devel@vger.kernel.org>; Thu,  4 Oct 2012 15:37:51 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,


i have a ceph cluster with 2 osds, 3 mons.. one of the monitors does no=
t start
anymore:

2012-10-04 13:36:29.501178 7f7e123f9780 -1 asok(0x14ac000)
AdminSocketConfigObs::init: error: AdminSocket::create_shutdown_pipe er=
ror: (38)
=46unction not implemented
2012-10-04 13:36:29.535018 7f7e123f9780  1 mon.2@-1(probing) e1 init fs=
id
5b59811a-d235-488f-9b9b-953db7e5028b
2012-10-04 13:36:29.541171 7f7e123f9780 -1 mon/Paxos.cc: In function 'b=
ool
Paxos::is_consistent()' thread 7f7e123f9780 time 2012-10-04 13:36:29.53=
6744
mon/Paxos.cc: 1031: FAILED assert(consistent || (slurping =3D=3D 1))

 ceph version 0.48.1argonaut (commit:a7ad701b9bd479f20429f19e6fea7373ca=
6bba7c)
 1: /usr/bin/ceph-mon() [0x488a67]
 2: (Monitor::init()+0xc5a) [0x476f4a]
 3: (main()+0x2789) [0x45c3b9]
 4: (__libc_start_main()+0xfd) [0x7f7e10929c8d]
 5: /usr/bin/ceph-mon() [0x459a49]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is need=
ed to
interpret this.

--- begin dump of recent events ---
   -20> 2012-10-04 13:36:29.443083 7f7e123f9780  5 asok(0x14ac000)
register_command perfcounters_dump hook 0x14a0010
   -19> 2012-10-04 13:36:29.443578 7f7e123f9780  5 asok(0x14ac000)
register_command 1 hook 0x14a0010
   -18> 2012-10-04 13:36:29.443600 7f7e123f9780  5 asok(0x14ac000)
register_command perf dump hook 0x14a0010
   -17> 2012-10-04 13:36:29.443627 7f7e123f9780  5 asok(0x14ac000)
register_command perfcounters_schema hook 0x14a0010
   -16> 2012-10-04 13:36:29.443637 7f7e123f9780  5 asok(0x14ac000)
register_command 2 hook 0x14a0010
   -15> 2012-10-04 13:36:29.443644 7f7e123f9780  5 asok(0x14ac000)
register_command perf schema hook 0x14a0010
   -14> 2012-10-04 13:36:29.443651 7f7e123f9780  5 asok(0x14ac000)
register_command config show hook 0x14a0010
   -13> 2012-10-04 13:36:29.443658 7f7e123f9780  5 asok(0x14ac000)
register_command config set hook 0x14a0010
   -12> 2012-10-04 13:36:29.443665 7f7e123f9780  5 asok(0x14ac000)
register_command log flush hook 0x14a0010
   -11> 2012-10-04 13:36:29.443671 7f7e123f9780  5 asok(0x14ac000)
register_command log dump hook 0x14a0010
   -10> 2012-10-04 13:36:29.443678 7f7e123f9780  5 asok(0x14ac000)
register_command log reopen hook 0x14a0010
    -9> 2012-10-04 13:36:29.453381 7f7e123f9780  1 store(/data/ceph_bac=
kend/mon)
mount
    -8> 2012-10-04 13:36:29.454581 7f7e123f9780  0 ceph version 0.48.1a=
rgonaut
(commit:a7ad701b9bd479f20429f19e6fea7373ca6bba7c), process ceph-mon, pi=
d 3643
    -7> 2012-10-04 13:36:29.455363 7f7e123f9780  1 -- 10.0.0.11:6789/0
accepter.bind my_inst.addr is 10.0.0.11:6789/0 need_addr=3D0
    -6> 2012-10-04 13:36:29.469799 7f7e123f9780  1 finished global_init=
_daemonize
    -5> 2012-10-04 13:36:29.500601 7f7e123f9780  5 asok(0x14ac000) init
/var/run/ceph/ceph-mon.2.asok
    -4> 2012-10-04 13:36:29.501178 7f7e123f9780 -1 asok(0x14ac000)
AdminSocketConfigObs::init: error: AdminSocket::create_shutdown_pipe er=
ror: (38)
=46unction not implemented
    -3> 2012-10-04 13:36:29.502014 7f7e123f9780  1 -- 10.0.0.11:6789/0
messenger.start
    -2> 2012-10-04 13:36:29.502392 7f7e123f9780  1 -- 10.0.0.11:6789/0
accepter.start
    -1> 2012-10-04 13:36:29.535018 7f7e123f9780  1 mon.2@-1(probing) e1=
 init
fsid 5b59811a-d235-488f-9b9b-953db7e5028b
     0> 2012-10-04 13:36:29.541171 7f7e123f9780 -1 mon/Paxos.cc: In fun=
ction
'bool Paxos::is_consistent()' thread 7f7e123f9780 time 2012-10-04 13:36=
:29.536744
mon/Paxos.cc: 1031: FAILED assert(consistent || (slurping =3D=3D 1))

 ceph version 0.48.1argonaut (commit:a7ad701b9bd479f20429f19e6fea7373ca=
6bba7c)
 1: /usr/bin/ceph-mon() [0x488a67]
 2: (Monitor::init()+0xc5a) [0x476f4a]
 3: (main()+0x2789) [0x45c3b9]
 4: (__libc_start_main()+0xfd) [0x7f7e10929c8d]
 5: /usr/bin/ceph-mon() [0x459a49]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is need=
ed to
interpret this.

--- end dump of recent events ---
2012-10-04 13:36:29.568387 7f7e123f9780 -1 *** Caught signal (Aborted) =
**
 in thread 7f7e123f9780

 ceph version 0.48.1argonaut (commit:a7ad701b9bd479f20429f19e6fea7373ca=
6bba7c)
 1: /usr/bin/ceph-mon() [0x520c49]
 2: (()+0xeff0) [0x7f7e11a9aff0]
 3: (gsignal()+0x35) [0x7f7e1093d1b5]
 4: (abort()+0x180) [0x7f7e1093ffc0]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f7e111d1dc5]
 6: (()+0xcb166) [0x7f7e111d0166]
 7: (()+0xcb193) [0x7f7e111d0193]
 8: (()+0xcb28e) [0x7f7e111d028e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const=
*)+0x793)
[0x574023]
 10: /usr/bin/ceph-mon() [0x488a67]
 11: (Monitor::init()+0xc5a) [0x476f4a]
 12: (main()+0x2789) [0x45c3b9]
 13: (__libc_start_main()+0xfd) [0x7f7e10929c8d]
 14: /usr/bin/ceph-mon() [0x459a49]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is need=
ed to
interpret this.

--- begin dump of recent events ---
     0> 2012-10-04 13:36:29.568387 7f7e123f9780 -1 *** Caught signal (A=
borted) **
 in thread 7f7e123f9780

 ceph version 0.48.1argonaut (commit:a7ad701b9bd479f20429f19e6fea7373ca=
6bba7c)
 1: /usr/bin/ceph-mon() [0x520c49]
 2: (()+0xeff0) [0x7f7e11a9aff0]
 3: (gsignal()+0x35) [0x7f7e1093d1b5]
 4: (abort()+0x180) [0x7f7e1093ffc0]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f7e111d1dc5]
 6: (()+0xcb166) [0x7f7e111d0166]
 7: (()+0xcb193) [0x7f7e111d0193]
 8: (()+0xcb28e) [0x7f7e111d028e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const=
*)+0x793)
[0x574023]
 10: /usr/bin/ceph-mon() [0x488a67]
 11: (Monitor::init()+0xc5a) [0x476f4a]
 12: (main()+0x2789) [0x45c3b9]
 13: (__libc_start_main()+0xfd) [0x7f7e10929c8d]
 14: /usr/bin/ceph-mon() [0x459a49]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is need=
ed to
interpret this.

--- end dump of recent events ---

what can i do?

--=20

Mit freundlichen Gr=FC=DFen,

=46lorian Wiessner

Smart Weblications GmbH
Martinsberger Str. 1
D-95119 Naila

fon.: +49 9282 9638 200
fax.: +49 9282 9638 205
24/7: +49 900 144 000 00 - 0,99 EUR/Min*
http://www.smart-weblications.de

--
Sitz der Gesellschaft: Naila
Gesch=E4ftsf=FChrer: Florian Wiessner
HRB-Nr.: HRB 3840 Amtsgericht Hof
*aus dem dt. Festnetz, ggf. abweichende Preise aus dem Mobilfunknetz
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
