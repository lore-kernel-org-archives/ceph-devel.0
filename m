From: Soporte <soporte@astranetwork.net>
Subject: mds =?ISO-8859-1?Q?don=B4t_start_after_upgrade_to_0=2E?=
 =?ISO-8859-1?Q?55?=
Date: Thu, 13 Dec 2012 09:20:47 -0300
Message-ID: <50C9C81F.5010807@astranetwork.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [201.216.232.116] ([201.216.232.116]:36041 "EHLO
	smtp.astranetwork.net" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753854Ab2LMMU4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Dec 2012 07:20:56 -0500
Received: from [10.0.1.100] (unknown [186.153.248.218])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.astranetwork.net (Postfix) with ESMTPSA id 3C67E4036A
	for <ceph-devel@vger.kernel.org>; Thu, 13 Dec 2012 09:20:52 -0300 (ART)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi.

I can=B4t start mds after upgrade to 0.55. The logs show:

   -40> 2012-12-13 09:03:54.264433 7f0949da0780  5 asok(0x2754000) regi=
ster_command 2 hook 0x273c010
   -39> 2012-12-13 09:03:54.264440 7f0949da0780  5 asok(0x2754000) regi=
ster_command perf schema hook 0x273c010
   -38> 2012-12-13 09:03:54.264445 7f0949da0780  5 asok(0x2754000) regi=
ster_command config show hook 0x273c010
   -37> 2012-12-13 09:03:54.264452 7f0949da0780  5 asok(0x2754000) regi=
ster_command config set hook 0x273c010
   -36> 2012-12-13 09:03:54.264458 7f0949da0780  5 asok(0x2754000) regi=
ster_command log flush hook 0x273c010
   -35> 2012-12-13 09:03:54.264462 7f0949da0780  5 asok(0x2754000) regi=
ster_command log dump hook 0x273c010
   -34> 2012-12-13 09:03:54.264468 7f0949da0780  5 asok(0x2754000) regi=
ster_command log reopen hook 0x273c010
   -33> 2012-12-13 09:03:54.266019 7f0949da0780  0 ceph version 0.55.1 =
(8e25c8d984f9258644389a18997ec6bdef8e056b), process ceph-mds, pid 4067
   -32> 2012-12-13 09:03:54.266917 7f0949da0780  1 finished global_init=
_daemonize
   -31> 2012-12-13 09:03:54.269579 7f0949da0780  5 asok(0x2754000) init=
 /var/run/ceph/ceph-mds.a.asok
   -30> 2012-12-13 09:03:54.269633 7f0949da0780  5 asok(0x2754000) bind=
_and_listen /var/run/ceph/ceph-mds.a.asok
   -29> 2012-12-13 09:03:54.269698 7f0949da0780  5 asok(0x2754000) regi=
ster_command 0 hook 0x273a0b8
   -28> 2012-12-13 09:03:54.269706 7f0949da0780  5 asok(0x2754000) regi=
ster_command version hook 0x273a0b8
   -27> 2012-12-13 09:03:54.269714 7f0949da0780  5 asok(0x2754000) regi=
ster_command git_version hook 0x273a0b8
   -26> 2012-12-13 09:03:54.269718 7f0949da0780  5 asok(0x2754000) regi=
ster_command help hook 0x273c0c0
   -25> 2012-12-13 09:03:54.269773 7f0949da0780 10 monclient(hunting): =
build_initial_monmap
   -24> 2012-12-13 09:03:54.270108 7f0949da0780 10 monclient(hunting): =
init
   -23> 2012-12-13 09:03:54.270447 7f0949da0780 10 monclient(hunting): =
auth_supported 2 method cephx
   -22> 2012-12-13 09:03:54.270463 7f0949da0780 10 monclient(hunting): =
_reopen_session
   -21> 2012-12-13 09:03:54.270513 7f0949da0780 10 monclient(hunting): =
_pick_new_mon picked mon.b con 0x2764f20 addr 10.0.1.242:6789/0
   -20> 2012-12-13 09:03:54.270537 7f0949da0780 10 monclient(hunting): =
_send_mon_message to mon.b at 10.0.1.242:6789/0
   -19> 2012-12-13 09:03:54.270546 7f0949da0780 10 monclient(hunting): =
renew_subs
   -18> 2012-12-13 09:03:54.271351 7f0944848700  0 mds.-1.0 ms_handle_c=
onnect on 10.0.1.242:6789/0
   -17> 2012-12-13 09:03:54.270769 7f094604b700  5 asok(0x2754000) entr=
y start
   -16> 2012-12-13 09:03:57.270503 7f0943846700 10 monclient(hunting): =
tick
   -15> 2012-12-13 09:03:57.270534 7f0943846700  1 monclient(hunting): =
continuing hunt
   -14> 2012-12-13 09:03:57.270538 7f0943846700 10 monclient(hunting): =
_reopen_session
   -13> 2012-12-13 09:03:57.270645 7f0943846700 10 monclient(hunting): =
_pick_new_mon picked mon.d con 0x2765600 addr 10.0.1.244:6789/0
   -12> 2012-12-13 09:03:57.270680 7f0943846700 10 monclient(hunting): =
_send_mon_message to mon.d at 10.0.1.244:6789/0
   -11> 2012-12-13 09:03:57.270688 7f0943846700 10 monclient(hunting): =
renew_subs
   -10> 2012-12-13 09:03:57.271507 7f0944848700  0 mds.-1.0 ms_handle_c=
onnect on 10.0.1.244:6789/0
    -9> 2012-12-13 09:04:00.270761 7f0943846700 10 monclient(hunting): =
tick
    -8> 2012-12-13 09:04:00.270778 7f0943846700  1 monclient(hunting): =
continuing hunt
    -7> 2012-12-13 09:04:00.270782 7f0943846700 10 monclient(hunting): =
_reopen_session
    -6> 2012-12-13 09:04:00.270849 7f0943846700 10 monclient(hunting): =
_pick_new_mon picked mon.c con 0x2765760 addr 10.0.1.243:6789/0
    -5> 2012-12-13 09:04:00.270879 7f0943846700 10 monclient(hunting): =
_send_mon_message to mon.c at 10.0.1.243:6789/0
    -4> 2012-12-13 09:04:00.270946 7f0943846700 10 monclient(hunting): =
renew_subs
    -3> 2012-12-13 09:04:00.271553 7f0944848700  0 mds.-1.0 ms_handle_c=
onnect on 10.0.1.243:6789/0
    -2> 2012-12-13 09:04:00.745467 7f0944848700 10 monclient(hunting): =
no handler for protocol 0
    -1> 2012-12-13 09:04:00.745484 7f0944848700 10 monclient(hunting): =
none of our auth protocols are supported by the server
     0> 2012-12-13 09:04:00.746437 7f0949da0780 -1 *** Caught signal (S=
egmentation fault) **
 in thread 7f0949da0780

 ceph version 0.55.1 (8e25c8d984f9258644389a18997ec6bdef8e056b)
 1: /usr/bin/ceph-mds() [0x819e70]
 2: (()+0xfcb0) [0x7f094943ccb0]
 3: (MonClient::wait_auth_rotating(double)+0xac) [0x748d2c]
 4: (MDS::init(int)+0x787) [0x4e7527]
 5: (main()+0xed7) [0x4cbf87]
 6: (__libc_start_main()+0xed) [0x7f09481ff76d]
 7: /usr/bin/ceph-mds() [0x4cdde9]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is need=
ed to interpret this.

Any idea what happen?

Cristian.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
