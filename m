From: Soporte <soporte@astranetwork.net>
Subject: mds =?ISO-8859-1?Q?don=B4t_start_after_upgrade_0=2E55?=
Date: Mon, 10 Dec 2012 14:39:04 -0300
Message-ID: <50C61E38.4010606@astranetwork.net>
References: <CA+GnOzQ0ccjmqOEVXJet0mOZgB4dmpV7-zSYqDUab4it=On=_Q@mail.gmail.com> <2B458EA4-7BB6-4956-8C3B-F536876AD668@inktank.com> <CA+GnOzRYEPzb9SH202NCEBfQyPLyJRkUJOqrvkBpr3c4N6LGNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [201.216.232.116] ([201.216.232.116]:33496 "EHLO
	smtp.astranetwork.net" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1750818Ab2LJRpJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Dec 2012 12:45:09 -0500
Received: from [10.0.1.100] (201-212-191-61.net.prima.net.ar [201.212.191.61])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.astranetwork.net (Postfix) with ESMTPSA id 6BD0B4025F
	for <ceph-devel@vger.kernel.org>; Mon, 10 Dec 2012 14:39:11 -0300 (ART)
In-Reply-To: <CA+GnOzRYEPzb9SH202NCEBfQyPLyJRkUJOqrvkBpr3c4N6LGNQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi.

I can=B4t start mds server. The logs show:

--- begin dump of recent events ---
   -30> 2012-12-09 16:49:52.181838 7f547966a780  5 asok(0x1d8c000) regi=
ster_command perfcounters_dump hook 0x1d74010
   -29> 2012-12-09 16:49:52.181884 7f547966a780  5 asok(0x1d8c000) regi=
ster_command 1 hook 0x1d74010
   -28> 2012-12-09 16:49:52.181890 7f547966a780  5 asok(0x1d8c000) regi=
ster_command perf dump hook 0x1d74010
   -27> 2012-12-09 16:49:52.181901 7f547966a780  5 asok(0x1d8c000) regi=
ster_command perfcounters_schema hook 0x1d74010
   -26> 2012-12-09 16:49:52.181907 7f547966a780  5 asok(0x1d8c000) regi=
ster_command 2 hook 0x1d74010
   -25> 2012-12-09 16:49:52.181910 7f547966a780  5 asok(0x1d8c000) regi=
ster_command perf schema hook 0x1d74010
   -24> 2012-12-09 16:49:52.181915 7f547966a780  5 asok(0x1d8c000) regi=
ster_command config show hook 0x1d74010
   -23> 2012-12-09 16:49:52.181919 7f547966a780  5 asok(0x1d8c000) regi=
ster_command config set hook 0x1d74010
   -22> 2012-12-09 16:49:52.181926 7f547966a780  5 asok(0x1d8c000) regi=
ster_command log flush hook 0x1d74010
   -21> 2012-12-09 16:49:52.181932 7f547966a780  5 asok(0x1d8c000) regi=
ster_command log dump hook 0x1d74010
   -20> 2012-12-09 16:49:52.181936 7f547966a780  5 asok(0x1d8c000) regi=
ster_command log reopen hook 0x1d74010
   -19> 2012-12-09 16:49:52.183484 7f547966a780  0 ceph version 0.55 (6=
90f8175606edf37a3177c27a3949c78fd37099f), process ceph-mds, pid 2400
   -18> 2012-12-09 16:49:52.184629 7f547966a780  1 finished global_init=
_daemonize
   -17> 2012-12-09 16:49:52.187153 7f547966a780  5 asok(0x1d8c000) init=
 /var/run/ceph/ceph-mds.a.asok
   -16> 2012-12-09 16:49:52.187209 7f547966a780  5 asok(0x1d8c000) bind=
_and_listen /var/run/ceph/ceph-mds.a.asok
   -15> 2012-12-09 16:49:52.187274 7f547966a780  5 asok(0x1d8c000) regi=
ster_command 0 hook 0x1d720b8
   -14> 2012-12-09 16:49:52.187291 7f547966a780  5 asok(0x1d8c000) regi=
ster_command version hook 0x1d720b8
   -13> 2012-12-09 16:49:52.187306 7f547966a780  5 asok(0x1d8c000) regi=
ster_command git_version hook 0x1d720b8
   -12> 2012-12-09 16:49:52.187316 7f547966a780  5 asok(0x1d8c000) regi=
ster_command help hook 0x1d740c0
   -11> 2012-12-09 16:49:52.187369 7f547966a780 10 monclient(hunting): =
build_initial_monmap
   -10> 2012-12-09 16:49:52.187697 7f547966a780 10 monclient(hunting): =
init
    -9> 2012-12-09 16:49:52.188025 7f547966a780 10 monclient(hunting): =
auth_supported 2
    -8> 2012-12-09 16:49:52.188049 7f547966a780 10 monclient(hunting): =
_reopen_session
    -7> 2012-12-09 16:49:52.188099 7f547966a780 10 monclient(hunting): =
_pick_new_mon picked mon.d con 0x1d9cf20 addr 10.0.1.244:6789/0
    -6> 2012-12-09 16:49:52.188129 7f547966a780 10 monclient(hunting): =
_send_mon_message to mon.d at 10.0.1.244:6789/0
    -5> 2012-12-09 16:49:52.188142 7f547966a780 10 monclient(hunting): =
renew_subs
    -4> 2012-12-09 16:49:52.188224 7f5475915700  5 asok(0x1d8c000) entr=
y start
    -3> 2012-12-09 16:49:52.189164 7f5474112700  0 mds.-1.0 ms_handle_c=
onnect on 10.0.1.244:6789/0
    -2> 2012-12-09 16:49:52.189942 7f5474112700 10 monclient(hunting): =
no handler for protocol 0
    -1> 2012-12-09 16:49:52.189965 7f5474112700 10 monclient(hunting): =
none of our auth protocols are supported by the server
     0> 2012-12-09 16:49:52.190925 7f547966a780 -1 *** Caught signal (S=
egmentation fault) **

Maybe and issue with cephx? How I can check this?

Cristian.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
