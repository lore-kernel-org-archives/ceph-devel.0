From: Sage Weil <sage@newdream.net>
Subject: Re: unstable branch: ls -l hang after write by 64 clients
Date: Tue, 26 Oct 2010 12:25:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1010261224450.20055@cobra.newdream.net>
References: <1288117260.10847.93.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37769 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755976Ab0JZTWf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Oct 2010 15:22:35 -0400
In-Reply-To: <1288117260.10847.93.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 26 Oct 2010, Jim Schutt wrote:
> Hi,
> 
> I'm testing a file system with 10 osd daemons, 
> 1 mds daemon, 1 mon daemon.
> 
> Client code is 2.6.36 + current for-linus branch
> Server code is unstable branch, 2a3e73bb325f.
> 
> After mounting 64 clients, I had each write its own 512 MiB
> file with dd, with all files being created in the same directory.
> 
> A few seconds after they completed, from another client (not one
> of the 64 writers) I did "ls -l" on the directory holding the 
> new files.
> 
> After several minutes, it still hasn't returned;
> all the daemons are still running.

This looks just like a client bug I'm tracking down with Henry Chang.  
I'll try again to reproduce it in my environment (as that should speed up 
the debugging process anyway!).

sage



> 
> My mds log (with debug mds = 20) has lots of the following.
> What else can I do to help debug this?  I've reproduced
> twice....
> 
> Thanks -- Jim
> 
> 2010-10-26 12:09:05.500371 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 34) from client4171
> 2010-10-26 12:09:05.500382 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.100:0/3015812162 -- client_session(renewcaps seq 34) v1 -- ?+0 0x7fbb40004ba0
> 2010-10-26 12:09:05.834753 418c3940 -- 172.17.40.26:6800/9546 <== client4169 172.17.40.101:0/344740799 49 ==== client_session(request_renewcaps seq 34) ==== 28+0+0 (918153143 0 0) 0x1e6fe90
> 2010-10-26 12:09:05.834790 418c3940 mds0.server get_session have 0x1e677b0 client4169 172.17.40.101:0/344740799 state open
> 2010-10-26 12:09:05.834802 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 34) from client4169
> 2010-10-26 12:09:05.834812 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.101:0/344740799 -- client_session(renewcaps seq 34) v1 -- ?+0 0x7fbb40004ba0
> 2010-10-26 12:09:05.851199 418c3940 -- 172.17.40.26:6800/9546 <== client4168 172.17.40.98:0/3464587309 49 ==== client_session(request_renewcaps seq 34) ==== 28+0+0 (918153143 0 0) 0x1e6fe90
> 2010-10-26 12:09:05.851217 418c3940 mds0.server get_session have 0x1e67000 client4168 172.17.40.98:0/3464587309 state open
> 2010-10-26 12:09:05.851228 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 34) from client4168
> 2010-10-26 12:09:05.851238 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.98:0/3464587309 -- client_session(renewcaps seq 34) v1 -- ?+0 0x7fbb4002acd0
> 2010-10-26 12:09:06.447536 42cd2940 mds0.cache trim max=100000  cur=67
> 2010-10-26 12:09:06.447557 42cd2940 mds0.cache trim_client_leases
> 2010-10-26 12:09:06.481255 42cd2940 mds0.cache check_memory_usage total 365752, rss 10284, heap 214184, malloc 527 mmap 0, baseline 74276, buffers 8, max 1048576, 65 / 69 inodes have caps, 193 caps, 2.7971 caps per inode
> 2010-10-26 12:09:06.481273 42cd2940 mds0.log trim 2 / 30 segments, 789 / -1 events, 0 (0) expiring, 0 (0) expired
> 2010-10-26 12:09:06.481308 42cd2940 mds0.bal get_load mdsload<[0,0 0]/[0,0 0], req 0, hr 0, qlen 0, cpu 0.09>
> 2010-10-26 12:09:06.481330 42cd2940 mds0.locker scatter_tick
> 2010-10-26 12:09:06.481337 42cd2940 mds0.server find_idle_sessions.  laggy until 0.000000
> 2010-10-26 12:09:06.481344 42cd2940 mds0.server laggiest active session is client4112 172.17.40.43:0/770818898
> 2010-10-26 12:09:06.481352 42cd2940 mds0.server laggiest active session is client4112 172.17.40.43:0/770818898 and sufficiently new (2010-10-26 12:08:46.792942)
> 2010-10-26 12:09:06.481361 42cd2940 mds0.bal tick last_sample now 2010-10-26 12:09:06.481361
> 2010-10-26 12:09:06.481381 42cd2940 mds0.bal get_load mdsload<[0,0 0]/[0,0 0], req 0, hr 0, qlen 0, cpu 0.09>
> 2010-10-26 12:09:06.481403 42cd2940 mds0.bal mds0 epoch 77 load mdsload<[0,0 0]/[0,0 0], req 0, hr 0, qlen 0, cpu 0.09>
> 2010-10-26 12:09:06.481418 42cd2940 mds0.snap check_osd_map - version unchanged
> 2010-10-26 12:09:06.790136 418c3940 -- 172.17.40.26:6800/9546 <== client4112 172.17.40.43:0/770818898 49 ==== client_session(request_renewcaps seq 34) ==== 28+0+0 (918153143 0 0) 0x7fbb40004ba0
> 2010-10-26 12:09:06.790159 418c3940 mds0.server get_session have 0x1e70050 client4112 172.17.40.43:0/770818898 state open
> 2010-10-26 12:09:06.790171 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 34) from client4112
> 2010-10-26 12:09:06.790182 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.43:0/770818898 -- client_session(renewcaps seq 34) v1 -- ?+0 0x7fbb4002acd0
> 2010-10-26 12:09:06.849353 418c3940 -- 172.17.40.26:6800/9546 <== client4111 172.17.40.42:0/3837811501 48 ==== client_session(request_renewcaps seq 34) ==== 28+0+0 (918153143 0 0) 0x1e6fe90
> 2010-10-26 12:09:06.849372 418c3940 mds0.server get_session have 0x1e60740 client4111 172.17.40.42:0/3837811501 state open
> 2010-10-26 12:09:06.849384 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 34) from client4111
> 2010-10-26 12:09:06.849393 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.42:0/3837811501 -- client_session(renewcaps seq 34) v1 -- ?+0 0x7fbb40004ba0
> 2010-10-26 12:09:07.076875 418c3940 -- 172.17.40.26:6800/9546 <== client4115 172.17.40.51:0/1833635374 49 ==== client_session(request_renewcaps seq 34) ==== 28+0+0 (918153143 0 0) 0x7fbb40004ba0
> 2010-10-26 12:09:07.076897 418c3940 mds0.server get_session have 0x1e76840 client4115 172.17.40.51:0/1833635374 state open
> 2010-10-26 12:09:07.076909 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 34) from client4115
> 2010-10-26 12:09:07.076939 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.51:0/1833635374 -- client_session(renewcaps seq 34) v1 -- ?+0 0x7fbb4002acd0
> 2010-10-26 12:09:07.634877 42cd2940 mds0.1 beacon_send up:active seq 196 (currently up:active)
> 2010-10-26 12:09:07.634899 42cd2940 -- 172.17.40.26:6800/9546 --> mon0 172.17.40.21:6800/0 -- mdsbeacon(4097/0 up:active seq 196 v4) v1 -- ?+0 0x7fbb38133880
> 2010-10-26 12:09:07.635177 418c3940 -- 172.17.40.26:6800/9546 <== mon0 172.17.40.21:6800/0 213 ==== mdsbeacon(4097/0 up:active seq 196 v4) v2 ==== 103+0+0 (1623315592 0 0) 0x7fbb40004560
> 2010-10-26 12:09:07.635192 418c3940 mds0.1 handle_mds_beacon up:active seq 196 rtt 0.000299
> 2010-10-26 12:09:08.436287 418c3940 -- 172.17.40.26:6800/9546 <== client4135 172.17.40.57:0/2730913365 49 ==== client_session(request_renewcaps seq 34) ==== 28+0+0 (4232531160 0 0) 0x1e6fe90
> 2010-10-26 12:09:08.436312 418c3940 mds0.server get_session have 0x1e43cc0 client4135 172.17.40.57:0/2730913365 state open
> 2010-10-26 12:09:08.436325 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 34) from client4135
> 2010-10-26 12:09:08.436335 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.57:0/2730913365 -- client_session(renewcaps seq 34) v1 -- ?+0 0x7fbb40004ba0
> 2010-10-26 12:09:08.446318 418c3940 -- 172.17.40.26:6800/9546 <== client4140 172.17.40.49:0/3161186877 49 ==== client_session(request_renewcaps seq 34) ==== 28+0+0 (918153143 0 0) 0x7fbb380953b0
> 2010-10-26 12:09:08.446339 418c3940 mds0.server get_session have 0x1e507b0 client4140 172.17.40.49:0/3161186877 state open
> 2010-10-26 12:09:08.446352 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 34) from client4140
> 2010-10-26 12:09:08.446362 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.49:0/3161186877 -- client_session(renewcaps seq 34) v1 -- ?+0 0x7fbb4002acd0
> 2010-10-26 12:09:10.024734 418c3940 -- 172.17.40.26:6800/9546 <== client4167 172.17.40.99:0/4030460000 49 ==== client_session(request_renewcaps seq 34) ==== 28+0+0 (918153143 0 0) 0x1e6fe90
> 2010-10-26 12:09:10.024759 418c3940 mds0.server get_session have 0x1e6a590 client4167 172.17.40.99:0/4030460000 state open
> 2010-10-26 12:09:10.024771 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 34) from client4167
> 2010-10-26 12:09:10.024782 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.99:0/4030460000 -- client_session(renewcaps seq 34) v1 -- ?+0 0x7fbb40004ba0
> 2010-10-26 12:09:10.031532 418c3940 -- 172.17.40.26:6800/9546 <== client4170 172.17.40.102:0/1587931204 50 ==== client_session(request_renewcaps seq 34) ==== 28+0+0 (918153143 0 0) 0x7fbb38083a10
> 2010-10-26 12:09:10.031550 418c3940 mds0.server get_session have 0x1e6b200 client4170 172.17.40.102:0/1587931204 state open
> 2010-10-26 12:09:10.031562 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 34) from client4170
> 2010-10-26 12:09:10.031572 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.102:0/1587931204 -- client_session(renewcaps seq 34) v1 -- ?+0 0x7fbb4002acd0
> 2010-10-26 12:09:11.447653 42cd2940 mds0.cache trim max=100000  cur=67
> 2010-10-26 12:09:11.447672 42cd2940 mds0.cache trim_client_leases
> 2010-10-26 12:09:11.490363 42cd2940 mds0.cache check_memory_usage total 365752, rss 10284, heap 214184, malloc 527 mmap 0, baseline 74276, buffers 8, max 1048576, 65 / 69 inodes have caps, 193 caps, 2.7971 caps per inode
> 2010-10-26 12:09:11.490380 42cd2940 mds0.log trim 2 / 30 segments, 789 / -1 events, 0 (0) expiring, 0 (0) expired
> 2010-10-26 12:09:11.490411 42cd2940 mds0.bal get_load mdsload<[0,0 0]/[0,0 0], req 0, hr 0, qlen 0, cpu 0.09>
> 2010-10-26 12:09:11.490432 42cd2940 mds0.locker scatter_tick
> 2010-10-26 12:09:11.490439 42cd2940 mds0.server find_idle_sessions.  laggy until 0.000000
> 2010-10-26 12:09:11.490445 42cd2940 mds0.server laggiest active session is client4109 172.17.40.31:0/952375814
> 2010-10-26 12:09:11.490453 42cd2940 mds0.server laggiest active session is client4109 172.17.40.31:0/952375814 and sufficiently new (2010-10-26 12:08:52.214192)
> 2010-10-26 12:09:11.490475 42cd2940 mds0.bal tick last_sample now 2010-10-26 12:09:11.490475
> 2010-10-26 12:09:11.490483 42cd2940 mds0.snap check_osd_map - version unchanged
> 2010-10-26 12:09:11.635018 42cd2940 mds0.1 beacon_send up:active seq 197 (currently up:active)
> 2010-10-26 12:09:11.635039 42cd2940 -- 172.17.40.26:6800/9546 --> mon0 172.17.40.21:6800/0 -- mdsbeacon(4097/0 up:active seq 197 v4) v1 -- ?+0 0x7fbb38133880
> 2010-10-26 12:09:11.635323 418c3940 -- 172.17.40.26:6800/9546 <== mon0 172.17.40.21:6800/0 214 ==== mdsbeacon(4097/0 up:active seq 197 v4) v2 ==== 103+0+0 (434678255 0 0) 0x7fbb40004560
> 2010-10-26 12:09:11.635337 418c3940 mds0.1 handle_mds_beacon up:active seq 197 rtt 0.000304
> 2010-10-26 12:09:12.213035 418c3940 -- 172.17.40.26:6800/9546 <== client4109 172.17.40.31:0/952375814 47 ==== client_session(request_renewcaps seq 36) ==== 28+0+0 (829375604 0 0) 0x7fbb3801b340
> 2010-10-26 12:09:12.213058 418c3940 mds0.server get_session have 0x1e14400 client4109 172.17.40.31:0/952375814 state open
> 2010-10-26 12:09:12.213070 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 36) from client4109
> 2010-10-26 12:09:12.213081 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.31:0/952375814 -- client_session(renewcaps seq 36) v1 -- ?+0 0x7fbb40004ba0
> 2010-10-26 12:09:15.635249 42cd2940 mds0.1 beacon_send up:active seq 198 (currently up:active)
> 2010-10-26 12:09:15.635273 42cd2940 -- 172.17.40.26:6800/9546 --> mon0 172.17.40.21:6800/0 -- mdsbeacon(4097/0 up:active seq 198 v4) v1 -- ?+0 0x7fbb38133880
> 2010-10-26 12:09:15.635569 418c3940 -- 172.17.40.26:6800/9546 <== mon0 172.17.40.21:6800/0 215 ==== mdsbeacon(4097/0 up:active seq 198 v4) v2 ==== 103+0+0 (2459119174 0 0) 0x7fbb40004560
> 2010-10-26 12:09:15.635605 418c3940 mds0.1 handle_mds_beacon up:active seq 198 rtt 0.000339
> 2010-10-26 12:09:16.447763 42cd2940 mds0.cache trim max=100000  cur=67
> 2010-10-26 12:09:16.447784 42cd2940 mds0.cache trim_client_leases
> 2010-10-26 12:09:16.480993 42cd2940 mds0.cache check_memory_usage total 365752, rss 10284, heap 214184, malloc 527 mmap 0, baseline 74276, buffers 8, max 1048576, 65 / 69 inodes have caps, 193 caps, 2.7971 caps per inode
> 2010-10-26 12:09:16.481020 42cd2940 mds0.log trim 2 / 30 segments, 789 / -1 events, 0 (0) expiring, 0 (0) expired
> 2010-10-26 12:09:16.481064 42cd2940 mds0.bal get_load mdsload<[0,0 0]/[0,0 0], req 0, hr 0, qlen 0, cpu 0.08>
> 2010-10-26 12:09:16.481096 42cd2940 mds0.locker scatter_tick
> 2010-10-26 12:09:16.481106 42cd2940 mds0.server find_idle_sessions.  laggy until 0.000000
> 2010-10-26 12:09:16.481116 42cd2940 mds0.server laggiest active session is client4110 172.17.40.41:0/3421999211
> 2010-10-26 12:09:16.481129 42cd2940 mds0.server laggiest active session is client4110 172.17.40.41:0/3421999211 and sufficiently new (2010-10-26 12:08:57.495228)
> 2010-10-26 12:09:16.481143 42cd2940 mds0.bal tick last_sample now 2010-10-26 12:09:16.481142
> 2010-10-26 12:09:16.481174 42cd2940 mds0.bal get_load mdsload<[0,0 0]/[0,0 0], req 0, hr 0, qlen 0, cpu 0.08>
> 2010-10-26 12:09:16.481197 42cd2940 mds0.bal mds0 epoch 78 load mdsload<[0,0 0]/[0,0 0], req 0, hr 0, qlen 0, cpu 0.08>
> 2010-10-26 12:09:16.481213 42cd2940 mds0.snap check_osd_map - version unchanged
> 2010-10-26 12:09:17.494368 418c3940 -- 172.17.40.26:6800/9546 <== client4110 172.17.40.41:0/3421999211 50 ==== client_session(request_renewcaps seq 35) ==== 28+0+0 (2364941625 0 0) 0x1e6fe90
> 2010-10-26 12:09:17.494398 418c3940 mds0.server get_session have 0x1e149e0 client4110 172.17.40.41:0/3421999211 state open
> 2010-10-26 12:09:17.494410 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 35) from client4110
> 2010-10-26 12:09:17.494421 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.41:0/3421999211 -- client_session(renewcaps seq 35) v1 -- ?+0 0x7fbb40004ba0
> 2010-10-26 12:09:17.708190 418c3940 -- 172.17.40.26:6800/9546 <== client4122 172.17.40.56:0/786471154 51 ==== client_session(request_renewcaps seq 35) ==== 28+0+0 (2364941625 0 0) 0x1e6fe90
> 2010-10-26 12:09:17.708211 418c3940 mds0.server get_session have 0x1e467a0 client4122 172.17.40.56:0/786471154 state open
> 2010-10-26 12:09:17.708244 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 35) from client4122
> 2010-10-26 12:09:17.708255 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.56:0/786471154 -- client_session(renewcaps seq 35) v1 -- ?+0 0x7fbb40004ba0
> 2010-10-26 12:09:17.798147 418c3940 -- 172.17.40.26:6800/9546 <== client4114 172.17.40.45:0/3971644125 50 ==== client_session(request_renewcaps seq 35) ==== 28+0+0 (2364941625 0 0) 0x7fbb38083a10
> 2010-10-26 12:09:17.798167 418c3940 mds0.server get_session have 0x1e4c010 client4114 172.17.40.45:0/3971644125 state open
> 2010-10-26 12:09:17.798179 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 35) from client4114
> 2010-10-26 12:09:17.798190 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.45:0/3971644125 -- client_session(renewcaps seq 35) v1 -- ?+0 0x7fbb4002acd0
> 2010-10-26 12:09:17.932371 418c3940 -- 172.17.40.26:6800/9546 <== client4120 172.17.40.58:0/2178399590 50 ==== client_session(request_renewcaps seq 35) ==== 28+0+0 (2364941625 0 0) 0x1e6fe90
> 2010-10-26 12:09:17.932391 418c3940 mds0.server get_session have 0x1e443d0 client4120 172.17.40.58:0/2178399590 state open
> 2010-10-26 12:09:17.932403 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 35) from client4120
> 2010-10-26 12:09:17.932413 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.58:0/2178399590 -- client_session(renewcaps seq 35) v1 -- ?+0 0x7fbb40004ba0
> 2010-10-26 12:09:18.232255 418c3940 -- 172.17.40.26:6800/9546 <== client4127 172.17.40.63:0/1159565059 51 ==== client_session(request_renewcaps seq 35) ==== 28+0+0 (2364941625 0 0) 0x7fbb3801b340
> 2010-10-26 12:09:18.232276 418c3940 mds0.server get_session have 0x1e476e0 client4127 172.17.40.63:0/1159565059 state open
> 2010-10-26 12:09:18.232288 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 35) from client4127
> 2010-10-26 12:09:18.232298 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.63:0/1159565059 -- client_session(renewcaps seq 35) v1 -- ?+0 0x7fbb40004ba0
> 2010-10-26 12:09:18.303486 418c3940 -- 172.17.40.26:6800/9546 <== client4124 172.17.40.66:0/1211720657 50 ==== client_session(request_renewcaps seq 35) ==== 28+0+0 (2364941625 0 0) 0x7fbb3800d150
> 2010-10-26 12:09:18.303504 418c3940 mds0.server get_session have 0x1e48930 client4124 172.17.40.66:0/1211720657 state open
> 2010-10-26 12:09:18.303516 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 35) from client4124
> 2010-10-26 12:09:18.303526 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.66:0/1211720657 -- client_session(renewcaps seq 35) v1 -- ?+0 0x7fbb4002acd0
> 2010-10-26 12:09:18.385917 418c3940 -- 172.17.40.26:6800/9546 <== client4128 172.17.40.54:0/2534385440 50 ==== client_session(request_renewcaps seq 35) ==== 28+0+0 (2364941625 0 0) 0x1e6fe90
> 2010-10-26 12:09:18.385940 418c3940 mds0.server get_session have 0x1e77130 client4128 172.17.40.54:0/2534385440 state open
> 2010-10-26 12:09:18.385952 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 35) from client4128
> 2010-10-26 12:09:18.385962 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.54:0/2534385440 -- client_session(renewcaps seq 35) v1 -- ?+0 0x7fbb400021a0
> 2010-10-26 12:09:18.485634 418c3940 -- 172.17.40.26:6800/9546 <== client4125 172.17.40.61:0/2354518851 50 ==== client_session(request_renewcaps seq 35) ==== 28+0+0 (2364941625 0 0) 0x7fbb38083a10
> 2010-10-26 12:09:18.485655 418c3940 mds0.server get_session have 0x1e723b0 client4125 172.17.40.61:0/2354518851 state open
> 2010-10-26 12:09:18.485667 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 35) from client4125
> 2010-10-26 12:09:18.485677 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.61:0/2354518851 -- client_session(renewcaps seq 35) v1 -- ?+0 0x7fbb40004ba0
> 2010-10-26 12:09:18.503360 418c3940 -- 172.17.40.26:6800/9546 <== client4130 172.17.40.70:0/2166486472 50 ==== client_session(request_renewcaps seq 35) ==== 28+0+0 (2364941625 0 0) 0x1e6fe90
> 2010-10-26 12:09:18.503396 418c3940 mds0.server get_session have 0x1e453a0 client4130 172.17.40.70:0/2166486472 state open
> 2010-10-26 12:09:18.503408 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 35) from client4130
> 2010-10-26 12:09:18.503419 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.70:0/2166486472 -- client_session(renewcaps seq 35) v1 -- ?+0 0x7fbb400f72a0
> 2010-10-26 12:09:18.564844 418c3940 -- 172.17.40.26:6800/9546 <== client4138 172.17.40.67:0/3732516210 50 ==== client_session(request_renewcaps seq 35) ==== 28+0+0 (2364941625 0 0) 0x1e6fe90
> 2010-10-26 12:09:18.564865 418c3940 mds0.server get_session have 0x1e5ea60 client4138 172.17.40.67:0/3732516210 state open
> 2010-10-26 12:09:18.564876 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 35) from client4138
> 2010-10-26 12:09:18.564887 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.67:0/3732516210 -- client_session(renewcaps seq 35) v1 -- ?+0 0x7fbb4002acd0
> 2010-10-26 12:09:18.569173 418c3940 -- 172.17.40.26:6800/9546 <== client4136 172.17.40.62:0/2725831425 50 ==== client_session(request_renewcaps seq 35) ==== 28+0+0 (2364941625 0 0) 0x1e9b010
> 2010-10-26 12:09:18.569191 418c3940 mds0.server get_session have 0x1e1f5f0 client4136 172.17.40.62:0/2725831425 state open
> 2010-10-26 12:09:18.569203 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 35) from client4136
> 2010-10-26 12:09:18.569213 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.62:0/2725831425 -- client_session(renewcaps seq 35) v1 -- ?+0 0x7fbb4001cd80
> 2010-10-26 12:09:18.705377 418c3940 -- 172.17.40.26:6800/9546 <== client4132 172.17.40.71:0/3469719040 50 ==== client_session(request_renewcaps seq 35) ==== 28+0+0 (2364941625 0 0) 0x7fbb40004ba0
> 2010-10-26 12:09:18.705397 418c3940 mds0.server get_session have 0x1e71620 client4132 172.17.40.71:0/3469719040 state open
> 2010-10-26 12:09:18.705408 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 35) from client4132
> 2010-10-26 12:09:18.705418 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.71:0/3469719040 -- client_session(renewcaps seq 35) v1 -- ?+0 0x7fbb400021a0
> 2010-10-26 12:09:18.908581 418c3940 -- 172.17.40.26:6800/9546 <== client4133 172.17.40.65:0/1740774756 51 ==== client_session(request_renewcaps seq 35) ==== 28+0+0 (2364941625 0 0) 0x1e6fe90
> 2010-10-26 12:09:18.908602 418c3940 mds0.server get_session have 0x1e500a0 client4133 172.17.40.65:0/1740774756 state open
> 2010-10-26 12:09:18.908614 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 35) from client4133
> 2010-10-26 12:09:18.908624 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.65:0/1740774756 -- client_session(renewcaps seq 35) v1 -- ?+0 0x7fbb40004ba0
> 2010-10-26 12:09:19.005299 418c3940 -- 172.17.40.26:6800/9546 <== client4145 172.17.40.75:0/3244159623 50 ==== client_session(request_renewcaps seq 35) ==== 28+0+0 (2364941625 0 0) 0x7fbb3801b340
> 2010-10-26 12:09:19.005321 418c3940 mds0.server get_session have 0x1e4d000 client4145 172.17.40.75:0/3244159623 state open
> 2010-10-26 12:09:19.005333 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 35) from client4145
> 2010-10-26 12:09:19.005344 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.75:0/3244159623 -- client_session(renewcaps seq 35) v1 -- ?+0 0x7fbb4002acd0
> 2010-10-26 12:09:19.322065 418c3940 -- 172.17.40.26:6800/9546 <== client4150 172.17.40.82:0/2922368505 50 ==== client_session(request_renewcaps seq 35) ==== 28+0+0 (2364941625 0 0) 0x7fbb40004ba0
> 2010-10-26 12:09:19.322085 418c3940 mds0.server get_session have 0x1e543b0 client4150 172.17.40.82:0/2922368505 state open
> 2010-10-26 12:09:19.322097 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 35) from client4150
> 2010-10-26 12:09:19.322107 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.82:0/2922368505 -- client_session(renewcaps seq 35) v1 -- ?+0 0x7fbb4002acd0
> 2010-10-26 12:09:19.440698 418c3940 -- 172.17.40.26:6800/9546 <== client4151 172.17.40.80:0/2522805322 50 ==== client_session(request_renewcaps seq 35) ==== 28+0+0 (2364941625 0 0) 0x1e6fe90
> 2010-10-26 12:09:19.440736 418c3940 mds0.server get_session have 0x1e533a0 client4151 172.17.40.80:0/2522805322 state open
> 2010-10-26 12:09:19.440748 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 35) from client4151
> 2010-10-26 12:09:19.440758 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.80:0/2522805322 -- client_session(renewcaps seq 35) v1 -- ?+0 0x7fbb40004ba0
> 2010-10-26 12:09:19.635391 42cd2940 mds0.1 beacon_send up:active seq 199 (currently up:active)
> 2010-10-26 12:09:19.635420 42cd2940 -- 172.17.40.26:6800/9546 --> mon0 172.17.40.21:6800/0 -- mdsbeacon(4097/0 up:active seq 199 v4) v1 -- ?+0 0x7fbb38133880
> 2010-10-26 12:09:19.635722 418c3940 -- 172.17.40.26:6800/9546 <== mon0 172.17.40.21:6800/0 216 ==== mdsbeacon(4097/0 up:active seq 199 v4) v2 ==== 103+0+0 (3954856737 0 0) 0x7fbb40004560
> 2010-10-26 12:09:19.635749 418c3940 mds0.1 handle_mds_beacon up:active seq 199 rtt 0.000337
> 2010-10-26 12:09:19.701901 418c3940 -- 172.17.40.26:6800/9546 <== client4153 172.17.40.84:0/3914691807 50 ==== client_session(request_renewcaps seq 35) ==== 28+0+0 (2364941625 0 0) 0x7fbb40004ba0
> 2010-10-26 12:09:19.701924 418c3940 mds0.server get_session have 0x1e54fc0 client4153 172.17.40.84:0/3914691807 state open
> 2010-10-26 12:09:19.701936 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 35) from client4153
> 2010-10-26 12:09:19.701946 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.84:0/3914691807 -- client_session(renewcaps seq 35) v1 -- ?+0 0x7fbb4002acd0
> 2010-10-26 12:09:19.712320 418c3940 -- 172.17.40.26:6800/9546 <== client4152 172.17.40.83:0/4286302040 50 ==== client_session(request_renewcaps seq 35) ==== 28+0+0 (2364941625 0 0) 0x1e6fe90
> 2010-10-26 12:09:19.712338 418c3940 mds0.server get_session have 0x1e53bf0 client4152 172.17.40.83:0/4286302040 state open
> 2010-10-26 12:09:19.712350 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 35) from client4152
> 2010-10-26 12:09:19.712359 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.83:0/4286302040 -- client_session(renewcaps seq 35) v1 -- ?+0 0x7fbb40004ba0
> 2010-10-26 12:09:19.783516 418c3940 -- 172.17.40.26:6800/9546 <== client4157 172.17.40.88:0/2360311861 51 ==== client_session(request_renewcaps seq 35) ==== 28+0+0 (2364941625 0 0) 0x7fbb400021a0
> 2010-10-26 12:09:19.783537 418c3940 mds0.server get_session have 0x1e5a010 client4157 172.17.40.88:0/2360311861 state open
> 2010-10-26 12:09:19.783549 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 35) from client4157
> 2010-10-26 12:09:19.783559 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.88:0/2360311861 -- client_session(renewcaps seq 35) v1 -- ?+0 0x7fbb4007c940
> 2010-10-26 12:09:19.810248 418c3940 -- 172.17.40.26:6800/9546 <== client4163 172.17.40.92:0/1073095077 50 ==== client_session(request_renewcaps seq 35) ==== 28+0+0 (2364941625 0 0) 0x7fbb3800d150
> 2010-10-26 12:09:19.810266 418c3940 mds0.server get_session have 0x1e49c80 client4163 172.17.40.92:0/1073095077 state open
> 2010-10-26 12:09:19.810278 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 35) from client4163
> 2010-10-26 12:09:19.810288 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.92:0/1073095077 -- client_session(renewcaps seq 35) v1 -- ?+0 0x7fbb400021a0
> 2010-10-26 12:09:19.903428 418c3940 -- 172.17.40.26:6800/9546 <== client4154 172.17.40.85:0/579532454 50 ==== client_session(request_renewcaps seq 35) ==== 28+0+0 (2364941625 0 0) 0x7fbb400f72a0
> 2010-10-26 12:09:19.903449 418c3940 mds0.server get_session have 0x1e558a0 client4154 172.17.40.85:0/579532454 state open
> 2010-10-26 12:09:19.903461 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 35) from client4154
> 2010-10-26 12:09:19.903471 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.85:0/579532454 -- client_session(renewcaps seq 35) v1 -- ?+0 0x7fbb4001cd80
> 2010-10-26 12:09:19.972754 418c3940 -- 172.17.40.26:6800/9546 <== client4156 172.17.40.87:0/3594419550 50 ==== client_session(request_renewcaps seq 35) ==== 28+0+0 (2364941625 0 0) 0x1e6fe90
> 2010-10-26 12:09:19.972790 418c3940 mds0.server get_session have 0x1e56ad0 client4156 172.17.40.87:0/3594419550 state open
> 2010-10-26 12:09:19.972803 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 35) from client4156
> 2010-10-26 12:09:19.972813 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.87:0/3594419550 -- client_session(renewcaps seq 35) v1 -- ?+0 0x7fbb40004ba0
> 2010-10-26 12:09:20.109823 418c3940 -- 172.17.40.26:6800/9546 <== client4164 172.17.40.96:0/2666741681 51 ==== client_session(request_renewcaps seq 35) ==== 28+0+0 (2364941625 0 0) 0x7fbb4002acd0
> 2010-10-26 12:09:20.109845 418c3940 mds0.server get_session have 0x1e4b3c0 client4164 172.17.40.96:0/2666741681 state open
> 2010-10-26 12:09:20.109857 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 35) from client4164
> 2010-10-26 12:09:20.109867 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.96:0/2666741681 -- client_session(renewcaps seq 35) v1 -- ?+0 0x7fbb400021a0
> 2010-10-26 12:09:20.198753 418c3940 -- 172.17.40.26:6800/9546 <== client4166 172.17.40.97:0/1735752130 51 ==== client_session(request_renewcaps seq 35) ==== 28+0+0 (2364941625 0 0) 0x7fbb38083a10
> 2010-10-26 12:09:20.198773 418c3940 mds0.server get_session have 0x1e68b30 client4166 172.17.40.97:0/1735752130 state open
> 2010-10-26 12:09:20.198785 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 35) from client4166
> 2010-10-26 12:09:20.198794 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.97:0/1735752130 -- client_session(renewcaps seq 35) v1 -- ?+0 0x7fbb40004ba0
> 2010-10-26 12:09:20.359461 418c3940 -- 172.17.40.26:6800/9546 <== client4161 172.17.40.95:0/1499721505 50 ==== client_session(request_renewcaps seq 35) ==== 28+0+0 (2364941625 0 0) 0x7fbb4002acd0
> 2010-10-26 12:09:20.359482 418c3940 mds0.server get_session have 0x1e646c0 client4161 172.17.40.95:0/1499721505 state open
> 2010-10-26 12:09:20.359494 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 35) from client4161
> 2010-10-26 12:09:20.359504 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.95:0/1499721505 -- client_session(renewcaps seq 35) v1 -- ?+0 0x7fbb400021a0
> 2010-10-26 12:09:21.447857 42cd2940 mds0.cache trim max=100000  cur=67
> 2010-10-26 12:09:21.447878 42cd2940 mds0.cache trim_client_leases
> 2010-10-26 12:09:21.477794 42cd2940 mds0.cache check_memory_usage total 365752, rss 10284, heap 214184, malloc 527 mmap 0, baseline 74276, buffers 8, max 1048576, 65 / 69 inodes have caps, 193 caps, 2.7971 caps per inode
> 2010-10-26 12:09:21.477809 42cd2940 mds0.log trim 2 / 30 segments, 789 / -1 events, 0 (0) expiring, 0 (0) expired
> 2010-10-26 12:09:21.477834 42cd2940 mds0.bal get_load mdsload<[0,0 0]/[0,0 0], req 0, hr 0, qlen 0, cpu 0.15>
> 2010-10-26 12:09:21.477854 42cd2940 mds0.locker scatter_tick
> 2010-10-26 12:09:21.477860 42cd2940 mds0.server find_idle_sessions.  laggy until 0.000000
> 2010-10-26 12:09:21.477867 42cd2940 mds0.server laggiest active session is client4113 172.17.40.44:0/3912274056
> 2010-10-26 12:09:21.477875 42cd2940 mds0.server laggiest active session is client4113 172.17.40.44:0/3912274056 and sufficiently new (2010-10-26 12:09:02.505093)
> 2010-10-26 12:09:21.477883 42cd2940 mds0.bal tick last_sample now 2010-10-26 12:09:21.477883
> 2010-10-26 12:09:21.477890 42cd2940 mds0.snap check_osd_map - version unchanged
> .
> .
> .
> 2010-10-26 12:17:21.458720 42cd2940 mds0.cache trim max=100000  cur=67
> 2010-10-26 12:17:21.458751 42cd2940 mds0.cache trim_client_leases
> 2010-10-26 12:17:21.470279 42cd2940 mds0.cache check_memory_usage total 365752, rss 10736, heap 214184, malloc 520 mmap 0, baseline 74276, buffers 8, max 1048576, 65 / 69 inodes have caps, 193 caps, 2.7971 caps per inode
> 2010-10-26 12:17:21.470295 42cd2940 mds0.log trim 2 / 30 segments, 789 / -1 events, 0 (0) expiring, 0 (0) expired
> 2010-10-26 12:17:21.470327 42cd2940 mds0.bal get_load mdsload<[0,0 0]/[0,0 0], req 0, hr 0, qlen 0, cpu 0.23>
> 2010-10-26 12:17:21.470348 42cd2940 mds0.locker scatter_tick
> 2010-10-26 12:17:21.470355 42cd2940 mds0.server find_idle_sessions.  laggy until 0.000000
> 2010-10-26 12:17:21.470362 42cd2940 mds0.server laggiest active session is client4113 172.17.40.44:0/3912274056
> 2010-10-26 12:17:21.470371 42cd2940 mds0.server laggiest active session is client4113 172.17.40.44:0/3912274056 and sufficiently new (2010-10-26 12:17:02.489485)
> 2010-10-26 12:17:21.470380 42cd2940 mds0.bal tick last_sample now 2010-10-26 12:17:21.470380
> 2010-10-26 12:17:21.470386 42cd2940 mds0.snap check_osd_map - version unchanged
> 2010-10-26 12:17:22.489313 418c3940 -- 172.17.40.26:6800/9546 <== client4113 172.17.40.44:0/3912274056 75 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x7fbb38083a10
> 2010-10-26 12:17:22.489340 418c3940 mds0.server get_session have 0x1e1d530 client4113 172.17.40.44:0/3912274056 state open
> 2010-10-26 12:17:22.489352 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4113
> 2010-10-26 12:17:22.489364 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.44:0/3912274056 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb40004ba0
> 2010-10-26 12:17:22.524870 418c3940 -- 172.17.40.26:6800/9546 <== client4119 172.17.40.52:0/3237405470 74 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x1e6fe90
> 2010-10-26 12:17:22.524887 418c3940 mds0.server get_session have 0x1e78500 client4119 172.17.40.52:0/3237405470 state open
> 2010-10-26 12:17:22.524919 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4119
> 2010-10-26 12:17:22.524930 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.52:0/3237405470 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb4002acd0
> 2010-10-26 12:17:22.574620 418c3940 -- 172.17.40.26:6800/9546 <== client4117 172.17.40.48:0/418084210 74 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x7fbb3801b340
> 2010-10-26 12:17:22.574648 418c3940 mds0.server get_session have 0x1e1b3d0 client4117 172.17.40.48:0/418084210 state open
> 2010-10-26 12:17:22.574659 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4117
> 2010-10-26 12:17:22.574670 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.48:0/418084210 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb400021a0
> 2010-10-26 12:17:22.614200 418c3940 -- 172.17.40.26:6800/9546 <== client4121 172.17.40.50:0/2703171753 75 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x1e6fe90
> 2010-10-26 12:17:22.614216 418c3940 mds0.server get_session have 0x1e44dc0 client4121 172.17.40.50:0/2703171753 state open
> 2010-10-26 12:17:22.614227 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4121
> 2010-10-26 12:17:22.614238 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.50:0/2703171753 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb400f72a0
> 2010-10-26 12:17:22.742963 418c3940 -- 172.17.40.26:6800/9546 <== client4116 172.17.40.46:0/3087721285 75 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x7fbb40004ba0
> 2010-10-26 12:17:22.742980 418c3940 mds0.server get_session have 0x1e4c820 client4116 172.17.40.46:0/3087721285 state open
> 2010-10-26 12:17:22.742991 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4116
> 2010-10-26 12:17:22.743002 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.46:0/3087721285 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb4002acd0
> 2010-10-26 12:17:22.910011 418c3940 -- 172.17.40.26:6800/9546 <== client4118 172.17.40.47:0/3568736089 75 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x1e6fe90
> 2010-10-26 12:17:22.910028 418c3940 mds0.server get_session have 0x1e1bc20 client4118 172.17.40.47:0/3568736089 state open
> 2010-10-26 12:17:22.910039 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4118
> 2010-10-26 12:17:22.910049 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.47:0/3568736089 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb40004ba0
> 2010-10-26 12:17:23.062417 418c3940 -- 172.17.40.26:6800/9546 <== client4123 172.17.40.59:0/2595441351 74 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x1e6fe90
> 2010-10-26 12:17:23.062439 418c3940 mds0.server get_session have 0x1e46dc0 client4123 172.17.40.59:0/2595441351 state open
> 2010-10-26 12:17:23.062451 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4123
> 2010-10-26 12:17:23.062462 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.59:0/2595441351 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb4002acd0
> 2010-10-26 12:17:23.280798 418c3940 -- 172.17.40.26:6800/9546 <== client4126 172.17.40.53:0/4248267740 74 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x7fbb40004ba0
> 2010-10-26 12:17:23.280818 418c3940 mds0.server get_session have 0x1e72c90 client4126 172.17.40.53:0/4248267740 state open
> 2010-10-26 12:17:23.280829 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4126
> 2010-10-26 12:17:23.280840 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.53:0/4248267740 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb4002acd0
> 2010-10-26 12:17:23.284786 418c3940 -- 172.17.40.26:6800/9546 <== client4137 172.17.40.55:0/1216351479 74 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x7fbb40004ba0
> 2010-10-26 12:17:23.284807 418c3940 mds0.server get_session have 0x1e5e050 client4137 172.17.40.55:0/1216351479 state open
> 2010-10-26 12:17:23.284833 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4137
> 2010-10-26 12:17:23.284845 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.55:0/1216351479 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb400021a0
> 2010-10-26 12:17:23.419926 418c3940 -- 172.17.40.26:6800/9546 <== client4134 172.17.40.68:0/3909472740 74 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x1e6fe90
> 2010-10-26 12:17:23.419943 418c3940 mds0.server get_session have 0x1e433a0 client4134 172.17.40.68:0/3909472740 state open
> 2010-10-26 12:17:23.419954 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4134
> 2010-10-26 12:17:23.419964 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.68:0/3909472740 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb40004ba0
> 2010-10-26 12:17:23.474650 418c3940 -- 172.17.40.26:6800/9546 <== client4139 172.17.40.64:0/249826782 74 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x1e6fe90
> 2010-10-26 12:17:23.474670 418c3940 mds0.server get_session have 0x1e5f410 client4139 172.17.40.64:0/249826782 state open
> 2010-10-26 12:17:23.474681 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4139
> 2010-10-26 12:17:23.474692 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.64:0/249826782 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb4007c940
> 2010-10-26 12:17:23.546856 418c3940 -- 172.17.40.26:6800/9546 <== client4129 172.17.40.72:0/3739067243 74 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x1e6fe90
> 2010-10-26 12:17:23.546874 418c3940 mds0.server get_session have 0x1e77a10 client4129 172.17.40.72:0/3739067243 state open
> 2010-10-26 12:17:23.546885 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4129
> 2010-10-26 12:17:23.546896 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.72:0/3739067243 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb4002acd0
> 2010-10-26 12:17:23.586157 418c3940 -- 172.17.40.26:6800/9546 <== client4143 172.17.40.74:0/2234897981 74 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x7fbb380953b0
> 2010-10-26 12:17:23.586173 418c3940 mds0.server get_session have 0x1e52920 client4143 172.17.40.74:0/2234897981 state open
> 2010-10-26 12:17:23.586184 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4143
> 2010-10-26 12:17:23.586195 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.74:0/2234897981 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb400021a0
> 2010-10-26 12:17:23.654834 42cd2940 mds0.1 beacon_send up:active seq 320 (currently up:active)
> 2010-10-26 12:17:23.654868 42cd2940 -- 172.17.40.26:6800/9546 --> mon0 172.17.40.21:6800/0 -- mdsbeacon(4097/0 up:active seq 320 v4) v1 -- ?+0 0x7fbb38133880
> 2010-10-26 12:17:23.655164 418c3940 -- 172.17.40.26:6800/9546 <== mon0 172.17.40.21:6800/0 340 ==== mdsbeacon(4097/0 up:active seq 320 v4) v2 ==== 103+0+0 (1357374689 0 0) 0x7fbb40004560
> 2010-10-26 12:17:23.655193 418c3940 mds0.1 handle_mds_beacon up:active seq 320 rtt 0.000333
> 2010-10-26 12:17:23.752800 418c3940 -- 172.17.40.26:6800/9546 <== client4131 172.17.40.69:0/3601957077 74 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x7fbb38083a10
> 2010-10-26 12:17:23.752818 418c3940 mds0.server get_session have 0x1e45cc0 client4131 172.17.40.69:0/3601957077 state open
> 2010-10-26 12:17:23.752830 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4131
> 2010-10-26 12:17:23.752840 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.69:0/3601957077 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb40004ba0
> 2010-10-26 12:17:23.807227 418c3940 -- 172.17.40.26:6800/9546 <== client4142 172.17.40.73:0/1133588140 74 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x7fbb3801b340
> 2010-10-26 12:17:23.807244 418c3940 mds0.server get_session have 0x1e523e0 client4142 172.17.40.73:0/1133588140 state open
> 2010-10-26 12:17:23.807270 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4142
> 2010-10-26 12:17:23.807282 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.73:0/1133588140 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb4002acd0
> 2010-10-26 12:17:23.876607 418c3940 -- 172.17.40.26:6800/9546 <== client4146 172.17.40.77:0/4275215241 74 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x7fbb400021a0
> 2010-10-26 12:17:23.876624 418c3940 mds0.server get_session have 0x1e4d940 client4146 172.17.40.77:0/4275215241 state open
> 2010-10-26 12:17:23.876644 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4146
> 2010-10-26 12:17:23.876654 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.77:0/4275215241 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb4001cd80
> 2010-10-26 12:17:23.923015 418c3940 -- 172.17.40.26:6800/9546 <== client4147 172.17.40.78:0/3860540022 74 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x7fbb380953b0
> 2010-10-26 12:17:23.923032 418c3940 mds0.server get_session have 0x1e4e9d0 client4147 172.17.40.78:0/3860540022 state open
> 2010-10-26 12:17:23.923043 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4147
> 2010-10-26 12:17:23.923053 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.78:0/3860540022 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb400021a0
> 2010-10-26 12:17:23.926084 418c3940 -- 172.17.40.26:6800/9546 <== client4149 172.17.40.81:0/4218295137 75 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x1e6fe90
> 2010-10-26 12:17:23.926100 418c3940 mds0.server get_session have 0x1e56010 client4149 172.17.40.81:0/4218295137 state open
> 2010-10-26 12:17:23.926111 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4149
> 2010-10-26 12:17:23.926121 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.81:0/4218295137 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb400f72a0
> 2010-10-26 12:17:24.066881 418c3940 -- 172.17.40.26:6800/9546 <== client4144 172.17.40.76:0/2526660462 74 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x7fbb40004ba0
> 2010-10-26 12:17:24.066902 418c3940 mds0.server get_session have 0x1e514e0 client4144 172.17.40.76:0/2526660462 state open
> 2010-10-26 12:17:24.066914 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4144
> 2010-10-26 12:17:24.066925 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.76:0/2526660462 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb4002acd0
> 2010-10-26 12:17:24.099054 418c3940 -- 172.17.40.26:6800/9546 <== client4141 172.17.40.60:0/1568596364 75 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x1e6fe90
> 2010-10-26 12:17:24.099071 418c3940 mds0.server get_session have 0x1e4e140 client4141 172.17.40.60:0/1568596364 state open
> 2010-10-26 12:17:24.099082 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4141
> 2010-10-26 12:17:24.099092 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.60:0/1568596364 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb40004ba0
> 2010-10-26 12:17:24.386487 418c3940 -- 172.17.40.26:6800/9546 <== client4148 172.17.40.79:0/785727615 74 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x7fbb40004ba0
> 2010-10-26 12:17:24.386506 418c3940 mds0.server get_session have 0x1e4f450 client4148 172.17.40.79:0/785727615 state open
> 2010-10-26 12:17:24.386518 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4148
> 2010-10-26 12:17:24.386528 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.79:0/785727615 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb4002acd0
> 2010-10-26 12:17:24.439068 418c3940 -- 172.17.40.26:6800/9546 <== client4155 172.17.40.86:0/2363738145 74 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x7fbb38083a10
> 2010-10-26 12:17:24.439099 418c3940 mds0.server get_session have 0x1e4a280 client4155 172.17.40.86:0/2363738145 state open
> 2010-10-26 12:17:24.439111 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4155
> 2010-10-26 12:17:24.439121 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.86:0/2363738145 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb40004ba0
> 2010-10-26 12:17:24.517250 418c3940 -- 172.17.40.26:6800/9546 <== client4158 172.17.40.89:0/1188428012 74 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x1e6fe90
> 2010-10-26 12:17:24.517271 418c3940 mds0.server get_session have 0x1e5a940 client4158 172.17.40.89:0/1188428012 state open
> 2010-10-26 12:17:24.517282 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4158
> 2010-10-26 12:17:24.517293 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.89:0/1188428012 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb400021a0
> 2010-10-26 12:17:24.782419 418c3940 -- 172.17.40.26:6800/9546 <== client4160 172.17.40.91:0/1685590087 74 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x7fbb3801b340
> 2010-10-26 12:17:24.782439 418c3940 mds0.server get_session have 0x1e66d00 client4160 172.17.40.91:0/1685590087 state open
> 2010-10-26 12:17:24.782451 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4160
> 2010-10-26 12:17:24.782462 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.91:0/1685590087 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb40004ba0
> 2010-10-26 12:17:24.860204 418c3940 -- 172.17.40.26:6800/9546 <== client4165 172.17.40.93:0/282234168 75 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x7fbb380953b0
> 2010-10-26 12:17:24.860220 418c3940 mds0.server get_session have 0x1e68010 client4165 172.17.40.93:0/282234168 state open
> 2010-10-26 12:17:24.860231 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4165
> 2010-10-26 12:17:24.860242 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.93:0/282234168 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb4002acd0
> 2010-10-26 12:17:25.031720 418c3940 -- 172.17.40.26:6800/9546 <== client4173 172.17.40.104:0/2503246206 75 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x1e6fe90
> 2010-10-26 12:17:25.031741 418c3940 mds0.server get_session have 0x1e6c970 client4173 172.17.40.104:0/2503246206 state open
> 2010-10-26 12:17:25.031753 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4173
> 2010-10-26 12:17:25.031764 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.104:0/2503246206 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb40004ba0
> 2010-10-26 12:17:25.149683 418c3940 -- 172.17.40.26:6800/9546 <== client4162 172.17.40.94:0/375102617 74 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x1e6fe90
> 2010-10-26 12:17:25.149702 418c3940 mds0.server get_session have 0x1e49250 client4162 172.17.40.94:0/375102617 state open
> 2010-10-26 12:17:25.149713 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4162
> 2010-10-26 12:17:25.149724 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.94:0/375102617 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb4002acd0
> 2010-10-26 12:17:25.198015 418c3940 -- 172.17.40.26:6800/9546 <== client4172 172.17.40.103:0/3101858211 75 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x1e6fe90
> 2010-10-26 12:17:25.198031 418c3940 mds0.server get_session have 0x1e6c050 client4172 172.17.40.103:0/3101858211 state open
> 2010-10-26 12:17:25.198042 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4172
> 2010-10-26 12:17:25.198053 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.103:0/3101858211 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb400021a0
> 2010-10-26 12:17:25.198514 418c3940 -- 172.17.40.26:6800/9546 <== client4159 172.17.40.90:0/4250847908 74 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x7fbb38083a10
> 2010-10-26 12:17:25.198548 418c3940 mds0.server get_session have 0x1e66420 client4159 172.17.40.90:0/4250847908 state open
> 2010-10-26 12:17:25.198561 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4159
> 2010-10-26 12:17:25.198572 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.90:0/4250847908 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb4007c940
> 2010-10-26 12:17:25.478184 418c3940 -- 172.17.40.26:6800/9546 <== client4171 172.17.40.100:0/3015812162 74 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x7fbb3801b340
> 2010-10-26 12:17:25.478205 418c3940 mds0.server get_session have 0x1e6ba50 client4171 172.17.40.100:0/3015812162 state open
> 2010-10-26 12:17:25.478216 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4171
> 2010-10-26 12:17:25.478227 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.100:0/3015812162 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb40004ba0
> 2010-10-26 12:17:25.817831 418c3940 -- 172.17.40.26:6800/9546 <== client4169 172.17.40.101:0/344740799 74 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x1e6fe90
> 2010-10-26 12:17:25.817850 418c3940 mds0.server get_session have 0x1e677b0 client4169 172.17.40.101:0/344740799 state open
> 2010-10-26 12:17:25.817862 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4169
> 2010-10-26 12:17:25.817873 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.101:0/344740799 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb40004ba0
> 2010-10-26 12:17:25.834461 418c3940 -- 172.17.40.26:6800/9546 <== client4168 172.17.40.98:0/3464587309 74 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x1e6fe90
> 2010-10-26 12:17:25.834480 418c3940 mds0.server get_session have 0x1e67000 client4168 172.17.40.98:0/3464587309 state open
> 2010-10-26 12:17:25.834491 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4168
> 2010-10-26 12:17:25.834502 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.98:0/3464587309 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb4002acd0
> 2010-10-26 12:17:26.458903 42cd2940 mds0.cache trim max=100000  cur=67
> 2010-10-26 12:17:26.458938 42cd2940 mds0.cache trim_client_leases
> 2010-10-26 12:17:26.471540 42cd2940 mds0.cache check_memory_usage total 365752, rss 10736, heap 214184, malloc 520 mmap 0, baseline 74276, buffers 8, max 1048576, 65 / 69 inodes have caps, 193 caps, 2.7971 caps per inode
> 2010-10-26 12:17:26.471557 42cd2940 mds0.log trim 2 / 30 segments, 789 / -1 events, 0 (0) expiring, 0 (0) expired
> 2010-10-26 12:17:26.471589 42cd2940 mds0.bal get_load mdsload<[0,0 0]/[0,0 0], req 0, hr 0, qlen 0, cpu 0.21>
> 2010-10-26 12:17:26.471610 42cd2940 mds0.locker scatter_tick
> 2010-10-26 12:17:26.471617 42cd2940 mds0.server find_idle_sessions.  laggy until 0.000000
> 2010-10-26 12:17:26.471624 42cd2940 mds0.server laggiest active session is client4112 172.17.40.43:0/770818898
> 2010-10-26 12:17:26.471633 42cd2940 mds0.server laggiest active session is client4112 172.17.40.43:0/770818898 and sufficiently new (2010-10-26 12:17:06.757674)
> 2010-10-26 12:17:26.471648 42cd2940 mds0.bal tick last_sample now 2010-10-26 12:17:26.471648
> 2010-10-26 12:17:26.471668 42cd2940 mds0.bal get_load mdsload<[0,0 0]/[0,0 0], req 0, hr 0, qlen 0, cpu 0.21>
> 2010-10-26 12:17:26.471690 42cd2940 mds0.bal mds0 epoch 127 load mdsload<[0,0 0]/[0,0 0], req 0, hr 0, qlen 0, cpu 0.21>
> 2010-10-26 12:17:26.471704 42cd2940 mds0.snap check_osd_map - version unchanged
> 2010-10-26 12:17:26.757659 418c3940 -- 172.17.40.26:6800/9546 <== client4112 172.17.40.43:0/770818898 74 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x7fbb40004ba0
> 2010-10-26 12:17:26.757682 418c3940 mds0.server get_session have 0x1e70050 client4112 172.17.40.43:0/770818898 state open
> 2010-10-26 12:17:26.757694 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4112
> 2010-10-26 12:17:26.757722 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.43:0/770818898 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb4002acd0
> 2010-10-26 12:17:26.835108 418c3940 -- 172.17.40.26:6800/9546 <== client4111 172.17.40.42:0/3837811501 73 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x1e6fe90
> 2010-10-26 12:17:26.835125 418c3940 mds0.server get_session have 0x1e60740 client4111 172.17.40.42:0/3837811501 state open
> 2010-10-26 12:17:26.835136 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4111
> 2010-10-26 12:17:26.835146 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.42:0/3837811501 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb40004ba0
> 2010-10-26 12:17:27.057220 418c3940 -- 172.17.40.26:6800/9546 <== client4115 172.17.40.51:0/1833635374 74 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x7fbb40004ba0
> 2010-10-26 12:17:27.057241 418c3940 mds0.server get_session have 0x1e76840 client4115 172.17.40.51:0/1833635374 state open
> 2010-10-26 12:17:27.057252 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4115
> 2010-10-26 12:17:27.057263 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.51:0/1833635374 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb4002acd0
> 2010-10-26 12:17:27.654978 42cd2940 mds0.1 beacon_send up:active seq 321 (currently up:active)
> 2010-10-26 12:17:27.655017 42cd2940 -- 172.17.40.26:6800/9546 --> mon0 172.17.40.21:6800/0 -- mdsbeacon(4097/0 up:active seq 321 v4) v1 -- ?+0 0x7fbb38133880
> 2010-10-26 12:17:27.655321 418c3940 -- 172.17.40.26:6800/9546 <== mon0 172.17.40.21:6800/0 341 ==== mdsbeacon(4097/0 up:active seq 321 v4) v2 ==== 103+0+0 (701405574 0 0) 0x7fbb40004560
> 2010-10-26 12:17:27.655348 418c3940 mds0.1 handle_mds_beacon up:active seq 321 rtt 0.000336
> 2010-10-26 12:17:28.423974 418c3940 -- 172.17.40.26:6800/9546 <== client4135 172.17.40.57:0/2730913365 74 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (58733416 0 0) 0x1e6fe90
> 2010-10-26 12:17:28.423996 418c3940 mds0.server get_session have 0x1e43cc0 client4135 172.17.40.57:0/2730913365 state open
> 2010-10-26 12:17:28.424008 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4135
> 2010-10-26 12:17:28.424019 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.57:0/2730913365 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb40004ba0
> 2010-10-26 12:17:28.437924 418c3940 -- 172.17.40.26:6800/9546 <== client4140 172.17.40.49:0/3161186877 74 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x7fbb38083a10
> 2010-10-26 12:17:28.437942 418c3940 mds0.server get_session have 0x1e507b0 client4140 172.17.40.49:0/3161186877 state open
> 2010-10-26 12:17:28.437954 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4140
> 2010-10-26 12:17:28.437965 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.49:0/3161186877 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb4002acd0
> 2010-10-26 12:17:30.006929 418c3940 -- 172.17.40.26:6800/9546 <== client4170 172.17.40.102:0/1587931204 75 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x7fbb3801b340
> 2010-10-26 12:17:30.006953 418c3940 mds0.server get_session have 0x1e6b200 client4170 172.17.40.102:0/1587931204 state open
> 2010-10-26 12:17:30.006965 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4170
> 2010-10-26 12:17:30.006976 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.102:0/1587931204 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb40004ba0
> 2010-10-26 12:17:30.008538 418c3940 -- 172.17.40.26:6800/9546 <== client4167 172.17.40.99:0/4030460000 74 ==== client_session(request_renewcaps seq 59) ==== 28+0+0 (3380516871 0 0) 0x1e6fe90
> 2010-10-26 12:17:30.008555 418c3940 mds0.server get_session have 0x1e6a590 client4167 172.17.40.99:0/4030460000 state open
> 2010-10-26 12:17:30.008567 418c3940 mds0.server handle_client_session client_session(request_renewcaps seq 59) from client4167
> 2010-10-26 12:17:30.008593 418c3940 -- 172.17.40.26:6800/9546 --> 172.17.40.99:0/4030460000 -- client_session(renewcaps seq 59) v1 -- ?+0 0x7fbb4002acd0
> 2010-10-26 12:17:31.458990 42cd2940 mds0.cache trim max=100000  cur=67
> 2010-10-26 12:17:31.459025 42cd2940 mds0.cache trim_client_leases
> 2010-10-26 12:17:31.468682 42cd2940 mds0.cache check_memory_usage total 365752, rss 10736, heap 214184, malloc 520 mmap 0, baseline 74276, buffers 8, max 1048576, 65 / 69 inodes have caps, 193 caps, 2.7971 caps per inode
> 2010-10-26 12:17:31.468699 42cd2940 mds0.log trim 2 / 30 segments, 789 / -1 events, 0 (0) expiring, 0 (0) expired
> 2010-10-26 12:17:31.468729 42cd2940 mds0.bal get_load mdsload<[0,0 0]/[0,0 0], req 0, hr 0, qlen 0, cpu 0.2>
> 2010-10-26 12:17:31.468750 42cd2940 mds0.locker scatter_tick
> 2010-10-26 12:17:31.468756 42cd2940 mds0.server find_idle_sessions.  laggy until 0.000000
> 2010-10-26 12:17:31.468763 42cd2940 mds0.server laggiest active session is client4109 172.17.40.31:0/952375814
> 2010-10-26 12:17:31.468772 42cd2940 mds0.server laggiest active session is client4109 172.17.40.31:0/952375814 and sufficiently new (2010-10-26 12:17:12.201667)
> 2010-10-26 12:17:31.468781 42cd2940 mds0.bal tick last_sample now 2010-10-26 12:17:31.468780
> 2010-10-26 12:17:31.468787 42cd2940 mds0.snap check_osd_map - version unchanged
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
