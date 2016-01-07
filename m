From: wangsongbo <songbo1227@gmail.com>
Subject: The osd process locked itself , when I tested cephfs through filebench
Date: Thu, 7 Jan 2016 16:22:53 +0800
Message-ID: <61C57C08-8FD0-4AA0-9AB8-8DAB1B9DF2D1@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34485 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbcDKKHh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Apr 2016 06:07:37 -0400
Received: by mail-pa0-f66.google.com with SMTP id hb4so13952195pac.1
        for <ceph-devel@vger.kernel.org>; Mon, 11 Apr 2016 03:07:36 -0700 (PDT)
Received: from [172.16.1.253] ([182.48.117.114])
        by smtp.gmail.com with ESMTPSA id w62sm34912976pfa.79.2016.04.11.03.07.33
        for <ceph-devel@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Apr 2016 03:07:35 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi all,
When I tested randomrw on my cluster  through filebench (running ceph 0.94.5) , one of the osds was marked down. but  I could still get the process with ps command.
So I checked the log fiile and found follow message:
---------------------------------------------------->
2016-01-07 02:41:02.104124 7fa9ae4cb700 -1 osd.11 1672 heartbeat_check: no reply from osd.5 since back 2016-01-07 02:40:49.365340 front 2016-01-07 02:40:49.365340 (cutoff 2016-01-07 02:40:55.104035)
2016-01-07 02:41:02.104156 7fa9ae4cb700 -1 osd.11 1672 heartbeat_check: no reply from osd.6 since back 2016-01-07 02:40:49.365340 front 2016-01-07 02:40:49.365340 (cutoff 2016-01-07 02:40:55.104035)
2016-01-07 02:41:02.104168 7fa9ae4cb700 -1 osd.11 1672 heartbeat_check: no reply from osd.7 since back 2016-01-07 02:40:49.365340 front 2016-01-07 02:40:49.365340 (cutoff 2016-01-07 02:40:55.104035)
2016-01-07 02:41:02.104182 7fa9ae4cb700 -1 osd.11 1672 heartbeat_check: no reply from osd.8 since back 2016-01-07 02:40:49.365340 front 2016-01-07 02:40:49.365340 (cutoff 2016-01-07 02:40:55.104035)
2016-01-07 02:41:02.104194 7fa9ae4cb700 -1 osd.11 1672 heartbeat_check: no reply from osd.12 since back 2016-01-07 02:40:49.365340 front 2016-01-07 02:40:49.365340 (cutoff 2016-01-07 02:40:55.104035)
2016-01-07 02:41:02.104208 7fa9ae4cb700 -1 osd.11 1672 heartbeat_check: no reply from osd.15 since back 2016-01-07 02:40:49.365340 front 2016-01-07 02:40:49.365340 (cutoff 2016-01-07 02:40:55.104035)
2016-01-07 02:41:02.104226 7fa9ae4cb700 -1 osd.11 1672 heartbeat_check: no reply from osd.16 since back 2016-01-07 02:40:49.365340 front 2016-01-07 02:40:49.365340 (cutoff 2016-01-07 02:40:55.104035)
2016-01-07 02:41:02.104253 7fa9ae4cb700 -1 osd.11 1672 heartbeat_check: no reply from osd.17 since back 2016-01-07 02:40:49.365340 front 2016-01-07 02:40:49.365340 (cutoff 2016-01-07 02:40:55.104035)
2016-01-07 02:41:03.104394 7fa9ae4cb700 -1 osd.11 1672 heartbeat_check: no reply from osd.3 since back 2016-01-07 02:40:49.365340 front 2016-01-07 02:40:49.365340 (cutoff 2016-01-07 02:40:56.104394)
2016-01-07 02:41:03.104441 7fa9ae4cb700 -1 osd.11 1672 heartbeat_check: no reply from osd.4 since back 2016-01-07 02:40:49.365340 front 2016-01-07 02:40:49.365340 (cutoff 2016-01-07 02:40:56.104394)
2016-01-07 02:41:03.104451 7fa9ae4cb700 -1 osd.11 1672 heartbeat_check: no reply from osd.5 since back 2016-01-07 02:40:49.365340 front 2016-01-07 02:40:49.365340 (cutoff 2016-01-07 02:40:56.104394)
2016-01-07 02:41:03.104459 7fa9ae4cb700 -1 osd.11 1672 heartbeat_check: no reply from osd.6 since back 2016-01-07 02:40:49.365340 front 2016-01-07 02:40:49.365340 (cutoff 2016-01-07 02:40:56.104394)
2016-01-07 02:41:03.104467 7fa9ae4cb700 -1 osd.11 1672 heartbeat_check: no reply from osd.7 since back 2016-01-07 02:40:49.365340 front 2016-01-07 02:40:49.365340 (cutoff 2016-01-07 02:40:56.104394)
2016-01-07 02:41:03.104495 7fa9ae4cb700 -1 osd.11 1672 heartbeat_check: no reply from osd.8 since back 2016-01-07 02:40:49.365340 front 2016-01-07 02:40:49.365340 (cutoff 2016-01-07 02:40:56.104394)
2016-01-07 02:41:03.104503 7fa9ae4cb700 -1 osd.11 1672 heartbeat_check: no reply from osd.12 since back 2016-01-07 02:40:49.365340 front 2016-01-07 02:40:49.365340 (cutoff 2016-01-07 02:40:56.104394)
2016-01-07 02:41:03.104512 7fa9ae4cb700 -1 osd.11 1672 heartbeat_check: no reply from osd.15 since back 2016-01-07 02:40:49.365340 front 2016-01-07 02:40:49.365340 (cutoff 2016-01-07 02:40:56.104394)
2016-01-07 02:41:03.104526 7fa9ae4cb700 -1 osd.11 1672 heartbeat_check: no reply from osd.16 since back 2016-01-07 02:40:49.365340 front 2016-01-07 02:40:49.365340 (cutoff 2016-01-07 02:40:56.104394)
2016-01-07 02:41:03.104541 7fa9ae4cb700 -1 osd.11 1672 heartbeat_check: no reply from osd.17 since back 2016-01-07 02:40:49.365340 front 2016-01-07 02:40:49.365340 (cutoff 2016-01-07 02:40:56.104394)
....
2016-01-07 02:56:17.340268 7fa98b99d700  0 -- 10.0.19.68:6816/10289 submit_message osd_op_reply(201270 1000005e069.0000046e [write 0~4194304] v1679'6462 uv6462 ondisk = 0) v6 remote, 10.0.3.68:0/49739, failed lossy con, dropping message 0x30f84fc0
2016-01-07 02:56:17.886032 7fa9ae4cb700  0 log_channel(cluster) log [WRN] : 1 slow requests, 1 included below; oldest blocked for > 9.802397 secs
2016-01-07 02:56:17.886195 7fa9ae4cb700  0 log_channel(cluster) log [WRN] : slow request 9.802397 seconds old, received at 2016-01-07 02:56:08.083416: osd_op(client.501311.0:201273 1000005e069.00000471 [write 0~4194304] 7.ea64f958 RETRY=1 snapc 1=[] ondisk+retry+write+known_if_redirected e1679) currently waiting for subops from 3,6
2016-01-07 02:56:18.886521 7fa9ae4cb700  0 log_channel(cluster) log [WRN] : 1 slow requests, 1 included below; oldest blocked for > 10.802942 secs
2016-01-07 02:56:18.886626 7fa9ae4cb700  0 log_channel(cluster) log [WRN] : slow request 10.802942 seconds old, received at 2016-01-07 02:56:08.083416: osd_op(client.501311.0:201273 1000005e069.00000471 [write 0~4194304] 7.ea64f958 RETRY=1 snapc 1=[] ondisk+retry+write+known_if_redirected e1679) currently waiting for subops from 3,6
2016-01-07 03:37:27.066275 7f5f537007e0  0 ceph version 0.94.5 (9764da52395923e0b32908d83a9f7304401fee43), process ceph-osd, pid 105993
2016-01-07 03:37:27.066295 7f5f537007e0  0 turning on heap profiler with prefix /var/log/ceph//osd.11.profile
2016-01-07 03:37:32.188191 7f5f537007e0  0 filestore(/var/lib/ceph/osd/ceph-11) lock_fsid failed to lock /var/lib/ceph/osd/ceph-11/fsid, is another ceph-osd still running? (11) Resource temporarily unavailable
2016-01-07 03:37:32.188225 7f5f537007e0 -1 osd.11 0 OSD::pre_init: object store '/var/lib/ceph/osd/ceph-11' is currently in use. (Is ceph-osd already running?)
2016-01-07 03:37:32.188233 7f5f537007e0 -1  ** ERROR: osd pre_init failed: (16) Device or resource busy
<----------------------------------------------------
As listed above, this osd may have restarted failed automatically. I manually restarted this process using 'service ceph restart osd.xx', the process was still alive.
Then ,I debug this process with gdb:
---------------------------------------------------->
(gdb) info threads
142 Thread 0x7fa9b4ba6700 (LWP 10293)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
141 Thread 0x7fa9b43a5700 (LWP 10320)  0x00007fa9b6f6da0e in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
140 Thread 0x7fa9b32fc700 (LWP 10321)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
139 Thread 0x7fa9b1cd2700 (LWP 10329)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
138 Thread 0x7fa9b14d1700 (LWP 10330)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
137 Thread 0x7fa9b0cd0700 (LWP 10331)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
136 Thread 0x7fa9b04cf700 (LWP 10332)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
135 Thread 0x7fa9afcce700 (LWP 10333)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
134 Thread 0x7fa9af4cd700 (LWP 10334)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
133 Thread 0x7fa9aeccc700 (LWP 10335)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
132 Thread 0x7fa9ae4cb700 (LWP 10336)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
131 Thread 0x7fa9adcca700 (LWP 10337)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
130 Thread 0x7fa9acd74700 (LWP 10917)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
129 Thread 0x7fa9ac573700 (LWP 10918)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
128 Thread 0x7fa9abd72700 (LWP 10921)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
127 Thread 0x7fa9ab571700 (LWP 10922)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
126 Thread 0x7fa9aad70700 (LWP 10923)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
125 Thread 0x7fa9aa56f700 (LWP 10924)  0x00007fa9b6f6da0e in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
124 Thread 0x7fa9a9d6e700 (LWP 10925)  0x00007fa9b6f6da0e in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
123 Thread 0x7fa9a956d700 (LWP 10926)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
122 Thread 0x7fa9a8d6c700 (LWP 10927)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
121 Thread 0x7fa9a856b700 (LWP 10928)  0x00007fa9b6f702e4 in __lll_lock_wait () from /lib64/libpthread.so.0
120 Thread 0x7fa9989b7700 (LWP 11808)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
119 Thread 0x7fa9981b6700 (LWP 11809)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
118 Thread 0x7fa9979b5700 (LWP 11810)  0x00007fa9b5ce8113 in poll () from /lib64/libc.so.6
117 Thread 0x7fa9971b4700 (LWP 11811)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
116 Thread 0x7fa9969b3700 (LWP 11812)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
115 Thread 0x7fa9959b1700 (LWP 11814)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
114 Thread 0x7fa9951b0700 (LWP 11815)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
113 Thread 0x7fa9949af700 (LWP 11816)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
112 Thread 0x7fa9941ae700 (LWP 11817)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
111 Thread 0x7fa9931ac700 (LWP 11819)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
110 Thread 0x7fa9929ab700 (LWP 11820)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
109 Thread 0x7fa9919a9700 (LWP 11822)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
108 Thread 0x7fa9911a8700 (LWP 11823)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
107 Thread 0x7fa9909a7700 (LWP 11824)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
106 Thread 0x7fa9901a6700 (LWP 11825)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
105 Thread 0x7fa98f9a5700 (LWP 11826)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
104 Thread 0x7fa98f1a4700 (LWP 11827)  0x00007fa9b6f702e4 in __lll_lock_wait () from /lib64/libpthread.so.0
103 Thread 0x7fa98e9a3700 (LWP 11828)  0x00007fa9b6f6da0e in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
102 Thread 0x7fa98e1a2700 (LWP 11829)  0x00007fa9b6f6da0e in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
101 Thread 0x7fa98d9a1700 (LWP 11830)  0x00007fa9b6f6da0e in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
100 Thread 0x7fa98d1a0700 (LWP 11831)  0x00007fa9b6f6da0e in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
99 Thread 0x7fa98c99f700 (LWP 11832)  0x00007fa9b6f6da0e in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
98 Thread 0x7fa98c19e700 (LWP 11833)  0x00007fa9b6f6da0e in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
97 Thread 0x7fa98b99d700 (LWP 11834)  0x00007fa9b6f6da0e in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
96 Thread 0x7fa98b19c700 (LWP 11835)  0x00007fa9b6f6da0e in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
95 Thread 0x7fa98a99b700 (LWP 11836)  0x00007fa9b6f6da0e in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
94 Thread 0x7fa98a19a700 (LWP 11837)  0x00007fa9b6f6da0e in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
93 Thread 0x7fa989999700 (LWP 11838)  0x00007fa9b6f6da0e in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
92 Thread 0x7fa989198700 (LWP 11839)  0x00007fa9b6f6da0e in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
91 Thread 0x7fa988997700 (LWP 11840)  0x00007fa9b6f6da0e in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
90 Thread 0x7fa988196700 (LWP 11841)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
89 Thread 0x7fa987995700 (LWP 11842)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
88 Thread 0x7fa987194700 (LWP 11843)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
87 Thread 0x7fa986892700 (LWP 11845)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
86 Thread 0x7fa986091700 (LWP 11846)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
85 Thread 0x7fa985890700 (LWP 11847)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
84 Thread 0x7fa984313700 (LWP 11893)  0x00007fa9b5ce8113 in poll () from /lib64/libc.so.6
83 Thread 0x7fa97d66b700 (LWP 14038)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
---Type <return> to continue, or q <return> to quit---
82 Thread 0x7fa9961b2700 (LWP 105678)  0x00007fa9b5ce8113 in poll () from /lib64/libc.so.6
81 Thread 0x7fa9921aa700 (LWP 105679)  0x00007fa9b5ce8113 in poll () from /lib64/libc.so.6
80 Thread 0x7fa9939ad700 (LWP 105680)  0x00007fa9b5ce8113 in poll () from /lib64/libc.so.6
79 Thread 0x7fa9828d7700 (LWP 105697)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
78 Thread 0x7fa981e56700 (LWP 105745)  0x00007fa9b6f702e4 in __lll_lock_wait () from /lib64/libpthread.so.0
77 Thread 0x7fa97f1e1700 (LWP 105749)  0x00007fa9b6f702e4 in __lll_lock_wait () from /lib64/libpthread.so.0
76 Thread 0x7fa982058700 (LWP 105758)  0x00007fa9b6f702e4 in __lll_lock_wait () from /lib64/libpthread.so.0
75 Thread 0x7fa9a41de700 (LWP 105768)  0x00007fa9b6f702e4 in __lll_lock_wait () from /lib64/libpthread.so.0
74 Thread 0x7fa9a57fb700 (LWP 105769)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
73 Thread 0x7fa98380f700 (LWP 105772)  0x00007fa9b6f702e4 in __lll_lock_wait () from /lib64/libpthread.so.0
72 Thread 0x7fa9830e8700 (LWP 105775)  0x00007fa9b6f702e4 in __lll_lock_wait () from /lib64/libpthread.so.0
71 Thread 0x7fa9a2730700 (LWP 105776)  0x00007fa9b6f702e4 in __lll_lock_wait () from /lib64/libpthread.so.0
70 Thread 0x7fa9a56fa700 (LWP 105778)  0x00007fa9b6f702e4 in __lll_lock_wait () from /lib64/libpthread.so.0
69 Thread 0x7fa980c44700 (LWP 106167)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
68 Thread 0x7fa97e707700 (LWP 106168)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
67 Thread 0x7fa984c6b700 (LWP 106169)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
66 Thread 0x7fa984726700 (LWP 106170)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
65 Thread 0x7fa984625700 (LWP 106171)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
64 Thread 0x7fa984524700 (LWP 106172)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
63 Thread 0x7fa983b12700 (LWP 106173)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
62 Thread 0x7fa983a11700 (LWP 106174)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
61 Thread 0x7fa98330a700 (LWP 106178)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
60 Thread 0x7fa982fe7700 (LWP 106179)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
59 Thread 0x7fa9827d6700 (LWP 106180)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
58 Thread 0x7fa98235b700 (LWP 106181)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
57 Thread 0x7fa982159700 (LWP 106182)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
56 Thread 0x7fa981c54700 (LWP 106183)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
55 Thread 0x7fa981b53700 (LWP 106184)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
54 Thread 0x7fa981a52700 (LWP 106185)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
53 Thread 0x7fa981951700 (LWP 106186)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
52 Thread 0x7fa981850700 (LWP 106187)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
51 Thread 0x7fa98174f700 (LWP 106188)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
50 Thread 0x7fa98164e700 (LWP 106189)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
49 Thread 0x7fa98154d700 (LWP 106190)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
48 Thread 0x7fa98144c700 (LWP 106191)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
47 Thread 0x7fa98134b700 (LWP 106192)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
46 Thread 0x7fa98124a700 (LWP 106193)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
45 Thread 0x7fa980d94700 (LWP 106207)  0x00007fa9b6f702e4 in __lll_lock_wait () from /lib64/libpthread.so.0
44 Thread 0x7fa98073f700 (LWP 106210)  0x00007fa9b6f702e4 in __lll_lock_wait () from /lib64/libpthread.so.0
43 Thread 0x7fa98053d700 (LWP 106211)  0x00007fa9b6f702e4 in __lll_lock_wait () from /lib64/libpthread.so.0
42 Thread 0x7fa980038700 (LWP 106214)  0x00007fa9b6f702e4 in __lll_lock_wait () from /lib64/libpthread.so.0
41 Thread 0x7fa97ff37700 (LWP 106215)  0x00007fa9b6f702e4 in __lll_lock_wait () from /lib64/libpthread.so.0
40 Thread 0x7fa97f7f1700 (LWP 106217)  0x00007fa9b6f702e4 in __lll_lock_wait () from /lib64/libpthread.so.0
39 Thread 0x7fa97f4ee700 (LWP 106219)  0x00007fa9b6f702e4 in __lll_lock_wait () from /lib64/libpthread.so.0
38 Thread 0x7fa97f2ec700 (LWP 106221)  0x00007fa9b6f702e4 in __lll_lock_wait () from /lib64/libpthread.so.0
37 Thread 0x7fa97e3e4700 (LWP 106223)  0x00007fa9b6f702e4 in __lll_lock_wait () from /lib64/libpthread.so.0
36 Thread 0x7fa97e2c3700 (LWP 106224)  0x00007fa9b6f702e4 in __lll_lock_wait () from /lib64/libpthread.so.0
35 Thread 0x7fa984f8e700 (LWP 106232)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
34 Thread 0x7fa980b43700 (LWP 106241)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
33 Thread 0x7fa9a317e700 (LWP 106259)  0x00007fa9b6f702e4 in __lll_lock_wait () from /lib64/libpthread.so.0
32 Thread 0x7fa9829d8700 (LWP 106260)  0x00007fa9b6f702e4 in __lll_lock_wait () from /lib64/libpthread.so.0
31 Thread 0x7fa9a4927700 (LWP 113181)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
30 Thread 0x7fa9a3fdc700 (LWP 113186)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
29 Thread 0x7fa984d6c700 (LWP 113193)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
28 Thread 0x7fa9a2f7c700 (LWP 113203)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
27 Thread 0x7fa98350c700 (LWP 79532)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
26 Thread 0x7fa97f6f0700 (LWP 87703)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
25 Thread 0x7fa981f57700 (LWP 87704)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
24 Thread 0x7fa97db2c700 (LWP 88370)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
23 Thread 0x7fa982cdb700 (LWP 88371)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
---Type <return> to continue, or q <return> to quit---
22 Thread 0x7fa98225a700 (LWP 88372)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
21 Thread 0x7fa980139700 (LWP 88373)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
20 Thread 0x7fa9a45f1700 (LWP 88378)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
19 Thread 0x7fa983910700 (LWP 88379)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
18 Thread 0x7fa97fe36700 (LWP 88387)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
17 Thread 0x7fa98370e700 (LWP 88397)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
16 Thread 0x7fa9a2e7b700 (LWP 88789)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
15 Thread 0x7fa982bda700 (LWP 88790)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
14 Thread 0x7fa98063e700 (LWP 88791)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
13 Thread 0x7fa97e4f5700 (LWP 88792)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
12 Thread 0x7fa9a504b700 (LWP 88793)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
11 Thread 0x7fa98508f700 (LWP 88795)  0x00007fa9b6f702e4 in __lll_lock_wait () from /lib64/libpthread.so.0
10 Thread 0x7fa97c8a3700 (LWP 88796)  0x00007fa9b6f702e4 in __lll_lock_wait () from /lib64/libpthread.so.0
9 Thread 0x7fa9a3dce700 (LWP 88797)  0x00007fa9b6f702e4 in __lll_lock_wait () from /lib64/libpthread.so.0
8 Thread 0x7fa97dc2d700 (LWP 88798)  0x00007fa9b6f702e4 in __lll_lock_wait () from /lib64/libpthread.so.0
7 Thread 0x7fa97caa5700 (LWP 88800)  0x00007fa9b6f702e4 in __lll_lock_wait () from /lib64/libpthread.so.0
6 Thread 0x7fa984e8d700 (LWP 88841)  0x00007fa9b6f702e4 in __lll_lock_wait () from /lib64/libpthread.so.0
5 Thread 0x7fa98043c700 (LWP 90830)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
4 Thread 0x7fa9a622f700 (LWP 90833)  0x00007fa9b6f702e4 in __lll_lock_wait () from /lib64/libpthread.so.0
3 Thread 0x7fa9a5b51700 (LWP 90845)  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
2 Thread 0x7fa97c9a4700 (LWP 90851)  0x00007fa9b6f6d63c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
* 1 Thread 0x7fa9b820e7e0 (LWP 10292)  0x00007fa9b6f6a2ad in pthread_join () from /lib64/libpthread.so.0
(gdb) thread 13
[Switching to thread 13 (Thread 0x7fa97e4f5700 (LWP 88792))]#0 0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
(gdb) bt
#0  0x00007fa9b77326ab in base::internal::SpinLockDelay(int volatile*, int, int) () from /usr/lib64/libtcmalloc.so.4
#1  0x00007fa9b772f9bc in SpinLock::SlowLock() () from /usr/lib64/libtcmalloc.so.4
#2  0x00007fa9b772c0f1 in ?? () from /usr/lib64/libtcmalloc.so.4
#3  0x00007fa9b7725626 in MallocHook::InvokeNewHookSlow(void const*, unsigned long) () from /usr/lib64/libtcmalloc.so.4
#4  0x00007fa9b7732d73 in tc_new () from /usr/lib64/libtcmalloc.so.4
#5  0x0000000000b2b982 in ceph::log::Log::create_entry (this=<value optimized out>, level=0, subsys=27) at log/Log.cc:175
#6  0x0000000000c03075 in Pipe::fault (this=0x3b53d800, onread=<value optimized out>) at msg/simple/Pipe.cc:1392
#7  0x0000000000c12114 in Pipe::reader (this=0x3b53d800) at msg/simple/Pipe.cc:1674
#8  0x0000000000c1606d in Pipe::Reader::entry (this=<value optimized out>) at msg/simple/Pipe.h:50
#9  0x00007fa9b6f69a51 in start_thread () from /lib64/libpthread.so.0
#10 0x00007fa9b5cf193d in clone () from /lib64/libc.so.6
(gdb)
<-------------
This is not the first time for me to find above problem.

Thanks,
wangsongbo
