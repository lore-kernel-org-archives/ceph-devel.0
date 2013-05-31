From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: caller_ops.size error messages upstream/cuttlefish
Date: Fri, 31 May 2013 13:48:20 +0200
Message-ID: <51A88E04.5040405@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:53866 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152Ab3EaLs1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 May 2013 07:48:27 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

yesterday i updated to current upstream/cuttlefish while restarting an
OSD. The log gets spammed with these messages:

13-05-31 13:42:44.342142 osd.54 [ERR] 4.97d caller_ops.size 3002 > log
size 3001
2013-05-31 13:42:44.362058 osd.11 [ERR] 4.d15 caller_ops.size 3002 > log
size 3001
2013-05-31 13:42:44.365393 osd.11 [ERR] 4.af4 caller_ops.size 3002 > log
size 3001
2013-05-31 13:42:44.381021 osd.11 [ERR] 4.bc9 caller_ops.size 3002 > log
size 3001
2013-05-31 13:42:44.432011 osd.54 [ERR] 4.651 caller_ops.size 3002 > log
size 3001
2013-05-31 13:42:44.451333 osd.54 [ERR] 4.332 caller_ops.size 3002 > log
size 3001
2013-05-31 13:42:44.458137 osd.11 [ERR] 4.b87 caller_ops.size 3002 > log
size 3001
2013-05-31 13:42:44.552218 osd.54 [ERR] 4.9ea caller_ops.size 3002 > log
size 3001
2013-05-31 13:42:44.573992 osd.54 [ERR] 4.d56 caller_ops.size 3002 > log
size 3001
2013-05-31 13:42:44.576582 osd.11 [ERR] 4.8ce caller_ops.size 3002 > log
size 3001
2013-05-31 13:42:44.667815 osd.54 [ERR] 4.ba5 caller_ops.size 3002 > log
size 3001
2013-05-31 13:42:44.684187 osd.54 [ERR] 4.8b2 caller_ops.size 3002 > log
size 3001
2013-05-31 13:42:44.736891 osd.41 [ERR] 4.3e7 caller_ops.size 3002 > log
size 3001
2013-05-31 13:42:44.740904 osd.41 [ERR] 4.dd1 caller_ops.size 3002 > log
size 3001
2013-05-31 13:42:44.753944 osd.54 [ERR] 4.73c caller_ops.size 3002 > log
size 3001
2013-05-31 13:42:44.771081 osd.54 [ERR] 4.d6 caller_ops.size 3002 > log
size 3001
2013-05-31 13:42:44.839867 osd.41 [ERR] 4.6ff caller_ops.size 3002 > log
size 3001
2013-05-31 13:42:44.885132 osd.54 [ERR] 4.389 caller_ops.size 3002 > log
size 3001
2013-05-31 13:42:44.947816 osd.12 [ERR] 4.e12 caller_ops.size 3002 > log
size 3001
2013-05-31 13:42:44.956446 osd.54 [ERR] 4.a34 caller_ops.size 3002 > log
size 3001
2013-05-31 13:42:44.981324 osd.54 [ERR] 4.86 caller_ops.size 3002 > log
size 3001
2013-05-31 13:42:45.204110 osd.12 [ERR] 4.375 caller_ops.size 3002 > log
size 3001
2013-05-31 13:42:45.223636 osd.12 [ERR] 4.f75 caller_ops.size 3002 > log
size 3001
2013-05-31 13:42:45.300544 mon.0 [INF] osdmap e90849: 24 osds: 20 up, 24 in
2013-05-31 13:42:45.601838 osd.11 [ERR] 4.3e6 caller_ops.size 3002 > log
size 3001
2013-05-31 13:42:45.734445 osd.11 [ERR] 4.94d caller_ops.size 3002 > log
size 3001
2013-05-31 13:42:45.755154 osd.11 [ERR] 4.3dd caller_ops.size 3002 > log
size 3001
2013-05-31 13:42:45.779688 osd.11 [ERR] 4.815 caller_ops.size 3002 > log
size 3001
2013-05-31 13:42:45.931451 osd.54 [ERR] 4.47c caller_ops.size 3002 > log
size 3001

Then it also starts to have a lot of slow old requests (from the OSDs
which are down) and the I/O on my qemu guests gets stalled.

2013-05-31 13:43:40.732750 osd.3 [WRN] slow request 45.152737 seconds
old, received at 2013-05-31 13:42:55.579934:
osd_op(client.9439559.0:3387070 rbd_data.5039256b8b4567.000000000000290f
[write 2043904~8192] 4.f4a3cae1 RETRY=1 snapc 4da2=[] e90858) v4
currently reached pg
2013-05-31 13:43:40.732752 osd.3 [WRN] slow request 45.152716 seconds
old, received at 2013-05-31 13:42:55.579955:
osd_op(client.9439559.0:3387071 rbd_data.5039256b8b4567.000000000000290f
[write 2568192~12288] 4.f4a3cae1 RETRY=1 snapc 4da2=[] e90858) v4
currently reached pg

I've never seen this with bobtail. And i think this is not a wanted
"feature"... Can someone please comment on it?

Thanks!

Stefan
