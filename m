From: M Ranga Swami Reddy <swamireddy@gmail.com>
Subject: OSD Crash with scan_min and scan_max values reduced
Date: Mon, 22 Feb 2016 19:06:10 +0530
Message-ID: <CANA9Uk7zsBQbGZRFu3voqTvnOVAsMnSM+DAx5rGVoADBCj3e8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:35032 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754936AbcBVNgL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Feb 2016 08:36:11 -0500
Received: by mail-vk0-f47.google.com with SMTP id e6so128959660vkh.2
        for <ceph-devel@vger.kernel.org>; Mon, 22 Feb 2016 05:36:11 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

Hello,
I have reduced the scan_min and scan_max as below. After the below
change, during the scrubbing, got the op_tp_thread time out after 15.
After some time, OSDs crashed also... Any suggestions will be
helpful... Thanking you.
=3D=3D
-osd_backfill_scan_min =3D 64
-osd_backfill_scan_max =3D 512
+osd_backfill_scan_min =3D 16
+osd_backfill_scan_max =3D 32
osd_op_thread_timeout =3D 15
osd_recovery_thread_timeout =3D 30
=3D=3D

emerg:  2016-02-22 02:48:24.301522 7f8ee3096700  1 heartbeat_map
is_healthy 'OSD::op_tp thread 0x7f8edf08e700' had timed out after 15

2016-02-22T02:54:20.325657+00:00 emerg:  --- begin dump of recent event=
s ---

=E2=80=A6

2016-02-22T02:54:20.435546+00:00 emerg:  2016-02-22 02:54:20.315656
7f31a2166700  1 heartbeat_map reset_timeout 'OSD::op_tp thread
0x7f31a2166700' had suicide timed out after 150



2016-02-22T02:54:20.456737+00:00 emerg:  2016-02-22 02:54:20.237829
7fa09e05f700 -1 common/HeartbeatMap.cc: In function 'bool
ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, const char*,
time_t)' thread 7fa09e05f700 time 2016-02-22 02:54:20.187089

common/HeartbeatMap.cc: 79: FAILED assert(0 =3D=3D "hit suicide timeout=
")



ceph version 0.80.7 (6c0127fcb58008793d3c8b62d925bc91963672a3)

1: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char const*,
long)+0x107) [0x9c5757]

2: (ceph::HeartbeatMap::is_healthy()+0xa7) [0x9c6107]

3: (OSD::handle_osd_ping(MOSDPing*)+0x81b) [0x647a5b]

4: (OSD::heartbeat_dispatch(Message*)+0x51b) [0x648d0b]

5: (DispatchQueue::entry()+0x549) [0xb27269]

6: (DispatchQueue::DispatchThread::entry()+0xd) [0xa618ad]

7: (()+0x7e9a) [0x7fa0b4e77e9a]

8: (clone()+0x6d) [0x7fa0b3d708bd]

NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
