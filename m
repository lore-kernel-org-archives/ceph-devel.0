From: Meng Zhao <mzhao@carbonite.cn>
Subject: Re: Replacing a failed disk/OSD: unfound object
Date: Wed, 13 Jul 2011 18:15:56 +0800
Message-ID: <4b7beb00f8799e7ddd8bdd7e9f94fa84@carbonite.cn>
References: <739109542484ec419c72b1a0f941a54d@carbonite.cn>
 <CAORUGqDHG9k-o_VwWTGo3UtimfyYnrisKnEAt7nf6+B1Q5q1uw@mail.gmail.com>
 <CAORUGqD=XxjRLL6j75yg8gQkKOuuNE=ybt2wVP37cKBZcX1y8Q@mail.gmail.com>
 <620ab7bc3254ca105a1b91930afce314@carbonite.cn>
 <Pine.LNX.4.64.1107120904210.30805@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [218.240.156.147] ([218.240.156.147]:53488 "EHLO
	mail.carbonite.cn" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S964996Ab1GMKQL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jul 2011 06:16:11 -0400
In-Reply-To: <Pine.LNX.4.64.1107120904210.30805@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Tommi Virtanen <tommi.virtanen@dreamhost.com>, Ceph devel <ceph-devel@vger.kernel.org>


The test setting is like this:
I build a ceph3.0 system with 3mon, 3mds, 3osd on 3 machines.
Then I copied some file around. on a ceph client and wait until ceph -w=
=20
shows regular healthy states.
Now I turn one machine off.

Here are the logs for this situation of unfound object:please look for=20
the "=3D>" mark for events of interest
ceph -w
=3D=3D=3D=3D=3D=3D=3D=3D=3D

2011-07-13 14:39:43.157935   mon e1: 3 mons at=20
{alpha=3D192.168.0.135:6789/0,beta=3D192.168.0.136:6789/0,gamma=3D192.1=
68.0.137:6789/0}
2011-07-13 14:59:11.519250   osd e179: 3 osds: 3 up, 3 in
2011-07-13 15:01:17.355846    pg v1099: 602 pgs: 602 active+clean; 349=20
MB data, 1778 MB used, 920 MB / 3069 MB avail
=3D>ceph0 shutdown  (with mon0, mdsalpa, osd0)
2011-07-13 16:17:22.232696 7f3ac1cd1700 monclient: hunting for new mon
2011-07-13 16:17:34.887551   log 2011-07-13 16:17:29.515704 mon1=20
192.168.0.136:6789/0 2 : [INF] mon.beta calling new monitor election
2011-07-13 16:17:34.887551   log 2011-07-13 16:17:29.633224 mon2=20
192.168.0.137:6789/0 9 : [INF] mon.gamma calling new monitor election
2011-07-13 16:17:34.887551   log 2011-07-13 16:17:34.530619 mon1=20
192.168.0.136:6789/0 3 : [INF] mon.beta@1 won leader election with=20
quorum 1,2
2011-07-13 16:17:47.744681   log 2011-07-13 16:17:47.521582 mon1=20
192.168.0.136:6789/0 4 : [INF] osd0 192.168.0.135:6801/6165 failed (by=20
osd2 192.168.0.137:6801/9292)
2011-07-13 16:17:48.754993   log 2011-07-13 16:17:47.589716 mon1=20
192.168.0.136:6789/0 5 : [INF] osd0 192.168.0.135:6801/6165 failed (by=20
osd1 192.168.0.136:6801/2984)
2011-07-13 16:17:52.742905   osd e180: 3 osds: 2 up, 3 in
2011-07-13 16:17:52.754959   log 2011-07-13 16:17:52.524626 mon1=20
192.168.0.136:6789/0 6 : [INF] osd0 192.168.0.135:6801/6165 failed (by=20
osd2 192.168.0.137:6801/9292)
2011-07-13 16:17:52.767674    pg v1100: 602 pgs: 602 active+clean; 349=20
MB data, 1778 MB used, 920 MB / 3069 MB avail
2011-07-13 16:17:53.751359   osd e181: 3 osds: 2 up, 3 in
2011-07-13 16:17:53.770067    pg v1101: 602 pgs: 602 active+clean; 349=20
MB data, 1778 MB used, 920 MB / 3069 MB avail
2011-07-13 16:17:54.049235   osd e182: 3 osds: 2 up, 3 in
2011-07-13 16:17:54.062753   mds e108: 1/1/1 up {0=3Dbeta=3Dup:replay},=
 1=20
up:standby
2011-07-13 16:17:54.073946    pg v1102: 602 pgs: 602 active+clean; 349=20
MB data, 1778 MB used, 920 MB / 3069 MB avail
2011-07-13 16:17:58.904299    pg v1103: 602 pgs: 233 active+clean, 369=20
active+clean+degraded; 349 MB data, 1790 MB used, 914 MB / 3069 MB=20
avail; 67/224 degraded (29.911%)
2011-07-13 16:17:59.083432   mds e109: 1/1/1 up {0=3Dbeta=3Dup:reconnec=
t},=20
1 up:standby
2011-07-13 16:17:59.105245   mds e110: 1/1/1 up {0=3Dbeta=3Dup:rejoin},=
 1=20
up:standby
2011-07-13 16:17:59.121004   mds e111: 1/1/1 up {0=3Dbeta=3Dup:active},=
 1=20
up:standby
2011-07-13 16:17:59.147149   log 2011-07-13 16:17:58.970253 mon1=20
192.168.0.136:6789/0 7 : [INF] mds0 192.168.0.136:6800/2862 up:reconnec=
t
2011-07-13 16:17:59.147149   log 2011-07-13 16:17:58.993575 mon1=20
192.168.0.136:6789/0 8 : [INF] mds0 192.168.0.136:6800/2862 up:rejoin
2011-07-13 16:17:59.147149   log 2011-07-13 16:17:59.008454 mon1=20
192.168.0.136:6789/0 9 : [INF] mds0 192.168.0.136:6800/2862 up:active
2011-07-13 16:18:01.522886   log 2011-07-13 16:17:58.980040 mds0=20
192.168.0.136:6800/2862 1 : [DBG] reconnect by client4101=20
192.168.0.138:0/384680305 after 0.009430
2011-07-13 16:18:03.746935    pg v1104: 602 pgs: 233 active+clean, 369=20
active+clean+degraded; 349 MB data, 1795 MB used, 910 MB / 3069 MB=20
avail; 67/224 degraded (29.911%)
2011-07-13 16:18:13.762497    pg v1105: 602 pgs: 233 active+clean, 369=20
active+clean+degraded; 349 MB data, 1796 MB used, 909 MB / 3069 MB=20
avail; 67/224 degraded (29.911%)
2011-07-13 16:20:03.752175    pg v1106: 602 pgs: 233 active+clean, 369=20
active+clean+degraded; 349 MB data, 1791 MB used, 909 MB / 3069 MB=20
avail; 67/224 degraded (29.911%)
2011-07-13 16:20:13.796924    pg v1107: 602 pgs: 233 active+clean, 369=20
active+clean+degraded; 349 MB data, 1786 MB used, 909 MB / 3069 MB=20
avail; 67/224 degraded (29.911%)
=3D>osd0 is considered out and replication start
2011-07-13 16:22:54.219786   osd e183: 3 osds: 2 up, 2 in
2011-07-13 16:22:54.234591    pg v1108: 602 pgs: 233 active+clean, 369=20
active+clean+degraded; 349 MB data, 1260 MB used, 537 MB / 2046 MB=20
avail; 67/224 degraded (29.911%)
2011-07-13 16:22:54.254039   log 2011-07-13 16:22:54.116461 mon1=20
192.168.0.136:6789/0 10 : [INF] osd0 out (down for 301.489741)
2011-07-13 16:23:02.684313   osd e184: 3 osds: 2 up, 2 in
2011-07-13 16:23:02.698807    pg v1109: 602 pgs: 233 active+clean, 369=20
active+clean+degraded; 349 MB data, 1260 MB used, 537 MB / 2046 MB=20
avail; 67/224 degraded (29.911%)
2011-07-13 16:23:07.995143   osd e185: 3 osds: 2 up, 2 in
2011-07-13 16:23:08.009328    pg v1110: 602 pgs: 9 active, 402=20
active+clean, 8 peering, 183 active+clean+degraded; 349 MB data, 1273 M=
B=20
used, 527 MB / 2046 MB avail; 54/224 degraded (24.107%)
2011-07-13 16:23:08.139752    pg v1111: 602 pgs: 41 active, 552=20
active+clean, 9 peering; 349 MB data, 1288 MB used, 514 MB / 2046 MB=20
avail; 53/224 degraded (23.661%)
2011-07-13 16:23:09.001543   osd e186: 3 osds: 2 up, 2 in
2011-07-13 16:23:09.027121    pg v1112: 602 pgs: 41 active, 552=20
active+clean, 9 peering; 349 MB data, 1288 MB used, 514 MB / 2046 MB=20
avail; 53/224 degraded (23.661%)
2011-07-13 16:23:09.311325   osd e187: 3 osds: 2 up, 2 in
2011-07-13 16:23:09.433629    pg v1113: 602 pgs: 41 active, 552=20
active+clean, 9 peering; 349 MB data, 1288 MB used, 514 MB / 2046 MB=20
avail; 53/224 degraded (23.661%)
2011-07-13 16:23:10.399307   osd e188: 3 osds: 2 up, 2 in
2011-07-13 16:23:10.414293    pg v1114: 602 pgs: 41 active, 552=20
active+clean, 9 peering; 349 MB data, 1288 MB used, 514 MB / 2046 MB=20
avail; 53/224 degraded (23.661%)
2011-07-13 16:23:11.408559   osd e189: 3 osds: 2 up, 2 in
2011-07-13 16:23:11.427273    pg v1115: 602 pgs: 41 active, 552=20
active+clean, 9 peering; 349 MB data, 1288 MB used, 514 MB / 2046 MB=20
avail; 53/224 degraded (23.661%)
2011-07-13 16:23:12.329049   osd e190: 3 osds: 2 up, 2 in
2011-07-13 16:23:12.365014    pg v1116: 602 pgs: 41 active, 552=20
active+clean, 9 peering; 349 MB data, 1288 MB used, 514 MB / 2046 MB=20
avail; 53/224 degraded (23.661%)
2011-07-13 16:23:14.973260    pg v1117: 602 pgs: 49 active, 552=20
active+clean, 1 peering; 349 MB data, 1301 MB used, 504 MB / 2046 MB=20
avail; 66/224 degraded (29.464%)
2011-07-13 16:23:17.129235    pg v1118: 602 pgs: 50 active, 552=20
active+clean; 349 MB data, 1317 MB used, 489 MB / 2046 MB avail; 67/224=
=20
degraded (29.911%)
2011-07-13 16:23:30.004135    pg v1119: 602 pgs: 46 active, 556=20
active+clean; 349 MB data, 1329 MB used, 474 MB / 2046 MB avail; 62/224=
=20
degraded (27.679%)
2011-07-13 16:23:35.271864    pg v1120: 602 pgs: 40 active, 562=20
active+clean; 349 MB data, 1373 MB used, 428 MB / 2046 MB avail; 53/224=
=20
degraded (23.661%)
2011-07-13 16:23:45.093097    pg v1121: 602 pgs: 38 active, 564=20
active+clean; 349 MB data, 1394 MB used, 408 MB / 2046 MB avail; 49/224=
=20
degraded (21.875%)
=3D>for some reason osd2 failed during object replication
2011-07-13 16:24:00.435405   log 2011-07-13 16:24:00.288017 mon1=20
192.168.0.136:6789/0 11 : [INF] osd2 192.168.0.137:6801/9292 failed (by=
=20
osd1 192.168.0.136:6801/2984)
2011-07-13 16:24:05.579361   log 2011-07-13 16:24:05.424065 mon1=20
192.168.0.136:6789/0 12 : [INF] osd2 192.168.0.137:6801/9292 failed (by=
=20
osd1 192.168.0.136:6801/2984)
2011-07-13 16:24:10.583691   osd e191: 3 osds: 1 up, 2 in
2011-07-13 16:24:10.594086   log 2011-07-13 16:24:10.455936 mon1=20
192.168.0.136:6789/0 13 : [INF] osd2 192.168.0.137:6801/9292 failed (by=
=20
osd1 192.168.0.136:6801/2984)
2011-07-13 16:24:10.614368    pg v1122: 602 pgs: 38 active, 564=20
active+clean; 349 MB data, 1394 MB used, 408 MB / 2046 MB avail; 49/224=
=20
degraded (21.875%)
2011-07-13 16:24:11.590134   osd e192: 3 osds: 1 up, 2 in
2011-07-13 16:24:11.607345    pg v1123: 602 pgs: 38 active, 564=20
active+clean; 349 MB data, 1394 MB used, 408 MB / 2046 MB avail; 49/224=
=20
degraded (21.875%)
2011-07-13 16:24:15.739147    pg v1124: 602 pgs: 25 active+degraded,=20
577 active+clean+degraded; 349 MB data, 1404 MB used, 402 MB / 2046 MB=20
avail; 143/224 degraded (63.839%); 31/112 unfound (27.679%)
2011-07-13 16:26:15.845867    pg v1125: 602 pgs: 25 active+degraded,=20
577 active+clean+degraded; 349 MB data, 1402 MB used, 402 MB / 2046 MB=20
avail; 143/224 degraded (63.839%); 31/112 unfound (27.679%)
=3D>osd2 considered out
2011-07-13 16:29:14.486774   osd e193: 3 osds: 1 up, 1 in
2011-07-13 16:29:14.504393    pg v1126: 602 pgs: 25 active+degraded,=20
577 active+clean+degraded; 349 MB data, 592 MB used, 308 MB / 1023 MB=20
avail; 143/224 degraded (63.839%); 31/112 unfound (27.679%)
2011-07-13 16:29:14.514343   log 2011-07-13 16:29:14.394234 mon1=20
192.168.0.136:6789/0 14 : [INF] osd2 out (down for 303.874867)
2011-07-13 16:29:16.077618    pg v1127: 602 pgs: 25 active+degraded,=20
577 active+clean+degraded; 349 MB data, 594 MB used, 308 MB / 1023 MB=20
avail; 143/224 degraded (63.839%); 31/112 unfound (27.679%)
2011-07-13 16:31:16.098224    pg v1128: 602 pgs: 25 active+degraded,=20
577 active+clean+degraded; 349 MB data, 592 MB used, 308 MB / 1023 MB=20
avail; 143/224 degraded (63.839%); 31/112 unfound (27.679%)

osd.2.log
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
2011-07-13 14:51:37.542028 7f3b6de13700 osd2 178 pg[0.53( v 178'1=20
(0'0,178'1] n=3D1 ec=3D2 les/c 166/178 163/163/155) [2,0] r=3D0 mlcod 0=
'0 !hml=20
active+clean]  sending commit on repgather(0x7f3b64075350 applied 178'1=
=20
rep_tid=3D266 wfack=3D wfdisk=3D op=3Dosd_op(client4101.1:375=20
10000000007.0000000a [write 0~4194304 [1@-1]] 0.43d3 snapc 1=3D[]))=20
0x7f3b6411f840
2011-07-13 14:51:40.448487 7f3b6de13700 osd2 178 pg[0.6e( v 178'2=20
(0'0,178'2] n=3D2 ec=3D2 les/c 172/178 170/170/155) [2,1] r=3D0 mlcod 0=
'0 !hml=20
active+clean]  sending commit on repgather(0x7f3b6415f090 applied 178'2=
=20
rep_tid=3D267 wfack=3D wfdisk=3D op=3Dosd_op(client4101.1:376=20
10000000007.0000000b [write 0~4194304 [1@-1]] 0.ad6e snapc 1=3D[]))=20
0x7f3b640d13e0
2011-07-13 14:51:42.524448 7f3b6e614700 osd2 178 pg[0.62( v 178'2=20
(0'0,178'2] n=3D2 ec=3D2 les/c 166/178 163/163/155) [2,0] r=3D0 mlcod 0=
'0 !hml=20
active+clean]  sending commit on repgather(0x7f3b640dd560 applied 178'2=
=20
rep_tid=3D268 wfack=3D wfdisk=3D op=3Dosd_op(client4101.1:377=20
10000000007.0000000c [write 0~4194304 [1@-1]] 0.7e62 snapc 1=3D[]))=20
0x7f3b6414fb80
2011-07-13 14:51:43.264678 7f3b6e614700 osd2 178 pg[0.8( v 178'2=20
(0'0,178'2] n=3D2 ec=3D2 les/c 166/178 163/163/155) [2,0] r=3D0 mlcod 0=
'0 !hml=20
active+clean]  sending commit on repgather(0x7f3b6011de10 applied 178'2=
=20
rep_tid=3D271 wfack=3D wfdisk=3D op=3Dosd_op(client4101.1:398=20
10000000007.00000021 [write 0~4194304 [1@-1]] 0.ef08 snapc 1=3D[]))=20
0x7f3b600e8010
2011-07-13 14:51:43.264801 7f3b6e614700 osd2 178 pg[0.2e( v 178'1=20
(0'0,178'1] n=3D1 ec=3D2 les/c 166/178 163/163/155) [2,0] r=3D0 mlcod 0=
'0 !hml=20
active+clean]  sending commit on repgather(0x2dc09f0 applied 178'1=20
rep_tid=3D273 wfack=3D wfdisk=3D op=3Dosd_op(client4101.1:404=20
10000000007.00000027 [write 0~269567 [1@-1]] 0.1a2e snapc 1=3D[]))=20
0x2e4b8602011-07-13 14:51:43.413590 7f3b6de13700 osd2 178 pg[0.6f( v=20
178'2 (0'0,178'2] n=3D2 ec=3D2 les/c 172/178 170/170/155) [2,1] r=3D0 m=
lcod=20
0'0 !hml active+clean]  sending commit on repgather(0x7f3b600b2310=20
applied 178'2 rep_tid=3D269 wfack=3D wfdisk=3D op=3Dosd_op(client4101.1=
:379=20
10000000007.0000000e [write 0~4194304 [1@-1]] 0.8def snapc 1=3D[]))=20
0x7f3b6005a340
2011-07-13 14:51:44.581422 7f3b6de13700 osd2 178 pg[0.52( v 178'2=20
(0'0,178'2] n=3D2 ec=3D2 les/c 172/178 170/170/155) [2,1] r=3D0 mlcod 0=
'0 !hml=20
active+clean]  sending commit on repgather(0x7f3b65d89090 applied 178'2=
=20
rep_tid=3D270 wfack=3D wfdisk=3D op=3Dosd_op(client4101.1:393=20
10000000007.0000001c [write 0~4194304 [1@-1]] 0.9a52 snapc 1=3D[]))=20
0x7f3b6406f190
2011-07-13 14:51:44.581630 7f3b6de13700 osd2 178 pg[0.4c( v 178'2=20
(0'0,178'2] n=3D2 ec=3D2 les/c 172/178 170/170/155) [2,1] r=3D0 mlcod 0=
'0 !hml=20
active+clean]  sending commit on repgather(0x7f3b6008eca0 applied 178'2=
=20
rep_tid=3D272 wfack=3D wfdisk=3D op=3Dosd_op(client4101.1:399=20
10000000007.00000022 [write 0~4194304 [1@-1]] 0.dacc snapc 1=3D[]))=20
0x7f3b60139550
=3D>something already wrong but ceph -w does not know
2011-07-13 14:52:59.465626 7f3b70719700 osd2 178 OSD::ms_handle_reset()
2011-07-13 14:52:59.465731 7f3b70719700 osd2 178 OSD::ms_handle_reset()=
=20
s=3D0x2dc0740
2011-07-13 15:06:15.518322 7f3b70719700 osd2 179 OSD::ms_handle_reset()
2011-07-13 15:06:15.518517 7f3b70719700 osd2 179 OSD::ms_handle_reset()=
=20
s=3D0x2de6ce0
2011-07-13 15:14:11.831878 7f3b6bb0c700 -- 192.168.0.137:6802/9292 >>=20
192.168.0.135:6802/6165 pipe(0x7f3b64099ab0 sd=3D13 pgs=3D1 cs=3D1 l=3D=
0).fault=20
with nothing to send, going to standby
2011-07-13 15:14:11.880194 7f3b6b304700 -- 192.168.0.137:6802/9292 >>=20
192.168.0.136:6802/2984 pipe(0x2ce1a20 sd=3D15 pgs=3D2 cs=3D1 l=3D0).fa=
ult with=20
nothing to send, going to standby
2011-07-13 15:21:15.511170 7f3b70719700 osd2 179 OSD::ms_handle_reset()
2011-07-13 15:21:15.511265 7f3b70719700 osd2 179 OSD::ms_handle_reset()=
=20
s=3D0x2bbfc10
2011-07-13 15:36:15.613503 7f3b70719700 osd2 179 OSD::ms_handle_reset()
2011-07-13 15:36:15.613602 7f3b70719700 osd2 179 OSD::ms_handle_reset()=
=20
s=3D0x2ac40b0
2011-07-13 15:51:15.707005 7f3b70719700 osd2 179 OSD::ms_handle_reset()
2011-07-13 15:51:15.707101 7f3b70719700 osd2 179 OSD::ms_handle_reset()=
=20
s=3D0x2827df0
2011-07-13 16:06:15.779902 7f3b70719700 osd2 179 OSD::ms_handle_reset()
2011-07-13 16:06:15.779992 7f3b70719700 osd2 179 OSD::ms_handle_reset()=
=20
s=3D0x2ba3650
2011-07-13 16:17:23.667067 7f3b70719700 osd2 179 OSD::ms_handle_reset()
2011-07-13 16:17:23.667128 7f3b70719700 osd2 179 OSD::ms_handle_reset()=
=20
s=3D0x2dc09f0
=3D>ceph0 shutdown
2011-07-13 16:17:25.043107 7f3b6b708700 -- 192.168.0.137:6803/9292 >>=20
192.168.0.135:6803/6165 pipe(0x7f3b640e77c0 sd=3D14 pgs=3D3 cs=3D1 l=3D=
0).fault=20
initiating reconnect
2011-07-13 16:17:25.044344 7f3b6bd0e700 -- 192.168.0.137:6803/9292 >>=20
192.168.0.135:6803/6165 pipe(0x7f3b640e77c0 sd=3D14 pgs=3D3 cs=3D2 l=3D=
0).fault=20
first fault
2011-07-13 16:17:44.634390 7f3b76f26700 osd2 179 heartbeat_check: no=20
heartbeat from osd0 since 2011-07-13 16:17:24.048586 (cutoff 2011-07-13=
=20
16:17:24.634291)
2011-07-13 16:17:45.143635 7f3b6c610700 osd2 179 heartbeat_check: no=20
heartbeat from osd0 since 2011-07-13 16:17:24.048586 (cutoff 2011-07-13=
=20
16:17:25.143606)
2011-07-13 16:17:45.635063 7f3b76f26700 osd2 179 heartbeat_check: no=20
heartbeat from osd0 since 2011-07-13 16:17:24.048586 (cutoff 2011-07-13=
=20
16:17:25.635027)
2011-07-13 16:17:46.446478 7f3b6c610700 osd2 179 heartbeat_check: no=20
heartbeat from osd0 since 2011-07-13 16:17:24.048586 (cutoff 2011-07-13=
=20
16:17:26.446446)
2011-07-13 16:17:46.635367 7f3b76f26700 osd2 179 heartbeat_check: no=20
heartbeat from osd0 since 2011-07-13 16:17:24.048586 (cutoff 2011-07-13=
=20
16:17:26.635334)
2011-07-13 16:17:46.946921 7f3b6c610700 osd2 179 heartbeat_check: no=20
heartbeat from osd0 since 2011-07-13 16:17:24.048586 (cutoff 2011-07-13=
=20
16:17:26.946890)
2011-07-13 16:17:47.635921 7f3b76f26700 osd2 179 heartbeat_check: no=20
heartbeat from osd0 since 2011-07-13 16:17:24.048586 (cutoff 2011-07-13=
=20
16:17:27.635884)
2011-07-13 16:17:48.347317 7f3b6c610700 osd2 179 heartbeat_check: no=20
heartbeat from osd0 since 2011-07-13 16:17:24.048586 (cutoff 2011-07-13=
=20
16:17:28.347285)
2011-07-13 16:17:48.636694 7f3b76f26700 osd2 179 heartbeat_check: no=20
heartbeat from osd0 since 2011-07-13 16:17:24.048586 (cutoff 2011-07-13=
=20
16:17:28.636657)
2011-07-13 16:17:49.637227 7f3b76f26700 osd2 179 heartbeat_check: no=20
heartbeat from osd0 since 2011-07-13 16:17:24.048586 (cutoff 2011-07-13=
=20
16:17:29.637193)
2011-07-13 16:17:49.647933 7f3b6c610700 osd2 179 heartbeat_check: no=20
heartbeat from osd0 since 2011-07-13 16:17:24.048586 (cutoff 2011-07-13=
=20
16:17:29.647916)
2011-07-13 16:17:50.425012 7f3b6c610700 osd2 179 heartbeat_check: no=20
heartbeat from osd0 since 2011-07-13 16:17:24.048586 (cutoff 2011-07-13=
=20
16:17:30.424981)
2011-07-13 16:17:50.637671 7f3b76f26700 osd2 179 heartbeat_check: no=20
heartbeat from osd0 since 2011-07-13 16:17:24.048586 (cutoff 2011-07-13=
=20
16:17:30.637638)
2011-07-13 16:17:51.025729 7f3b6c610700 osd2 179 heartbeat_check: no=20
heartbeat from osd0 since 2011-07-13 16:17:24.048586 (cutoff 2011-07-13=
=20
16:17:31.025698)
2011-07-13 16:17:51.638261 7f3b76f26700 osd2 179 heartbeat_check: no=20
heartbeat from osd0 since 2011-07-13 16:17:24.048586 (cutoff 2011-07-13=
=20
16:17:31.638165)
2011-07-13 16:17:51.926444 7f3b6c610700 osd2 179 heartbeat_check: no=20
heartbeat from osd0 since 2011-07-13 16:17:24.048586 (cutoff 2011-07-13=
=20
16:17:31.926413)
2011-07-13 16:17:52.526995 7f3b6c610700 osd2 179 heartbeat_check: no=20
heartbeat from osd0 since 2011-07-13 16:17:24.048586 (cutoff 2011-07-13=
=20
16:17:32.526963)
2011-07-13 16:17:52.638956 7f3b76f26700 osd2 179 heartbeat_check: no=20
heartbeat from osd0 since 2011-07-13 16:17:24.048586 (cutoff 2011-07-13=
=20
16:17:32.638936)
2011-07-13 16:17:52.763523 7f3b6b607700 -- 192.168.0.137:6802/9292 >>=20
192.168.0.136:6802/2984 pipe(0x2ce1a20 sd=3D13 pgs=3D2 cs=3D2 l=3D0).co=
nnect=20
claims to be 0.0.0.0:6802/2984 not 192.168.0.136:6802/2984 - presumably=
=20
this is the same node!
2011-07-13 16:17:59.235254 7f3b75723700 osd2 182 pg[1.94( v 182'23=20
(178'20,182'23] n=3D1 ec=3D2 les/c 181/182 180/180/155) [2] r=3D0 mlcod=
 0'0=20
!hml active+clean+degraded]  sending commit on repgather(0x7f3b602cfba0=
=20
applied 182'23 rep_tid=3D274 wfack=3D wfdisk=3D op=3Dosd_op(mds0.11:21=20
200.00000000 [writefull 0~84] 1.3494) v2) 0x7f3b601ebb90
*** Caught signal (Aborted) **
  in thread 0x7f3b74721700
=3D>restart osd2
2011-07-13 17:06:00.120011 7fe0f5c57720 ceph version 0.30.commit:=20
64b1b2c70f0cde39c72d5d724c65ea8afaaa00b9. process: cosd. pid: 10241
2011-07-13 17:06:00.132026 7fe0f5c57720 filestore(/data/osd.2) mount=20
=46IEMAP ioctl is NOT supported
2011-07-13 17:06:00.132100 7fe0f5c57720 filestore(/data/osd.2) mount=20
detected btrfs
2011-07-13 17:06:00.132120 7fe0f5c57720 filestore(/data/osd.2) mount=20
btrfs CLONE_RANGE ioctl is supported
2011-07-13 17:06:00.149449 7fe0f5c57720 filestore(/data/osd.2) mount=20
btrfs SNAP_CREATE is supported
2011-07-13 17:06:00.297455 7fe0f5c57720 filestore(/data/osd.2) mount=20
btrfs SNAP_DESTROY is supported
2011-07-13 17:06:00.297786 7fe0f5c57720 filestore(/data/osd.2) mount=20
btrfs START_SYNC got 0 Success
2011-07-13 17:06:00.297847 7fe0f5c57720 filestore(/data/osd.2) mount=20
btrfs START_SYNC is supported (transid 363)
2011-07-13 17:06:00.300147 7fe0f5c57720 filestore(/data/osd.2) mount=20
btrfs WAIT_SYNC is supported
2011-07-13 17:06:00.301704 7fe0f5c57720 filestore(/data/osd.2) mount=20
btrfs SNAP_CREATE_V2 got 0 Success
2011-07-13 17:06:00.301727 7fe0f5c57720 filestore(/data/osd.2) mount=20
btrfs SNAP_CREATE_V2 is supported
2011-07-13 17:06:00.325592 7fe0f5c57720 filestore(/data/osd.2) mount=20
found snaps <24050,24085>
2011-07-13 17:06:00.376720 7fe0f5c57720 filestore(/data/osd.2) mount:=20
enabling PARALLEL journal mode: btrfs, SNAP_CREATE_V2 detected and=20
'filestore btrfs snap' mode is enabled
2011-07-13 17:06:00.376809 7fe0f5c57720 journal _open=20
/data/osd.2/journal fd 11: 1048576000 bytes, block size 4096 bytes,=20
directio =3D 1
2011-07-13 17:06:00.470792 7fe0f5c57720 journal read_entry 593817600 :=20
seq 24086 1049540 bytes
2011-07-13 17:06:00.472089 7fe0f5c57720 journal read_entry 593817600 :=20
seq 24086 1049540 bytes
*** Caught signal (Aborted) **
  in thread 0x7fe0f5c57720
  ceph version 0.30 (commit:64b1b2c70f0cde39c72d5d724c65ea8afaaa00b9)
  1: /usr/bin/cosd() [0x637e6e]
  2: (()+0xf430) [0x7fe0f563a430]
  3: (gsignal()+0x35) [0x7fe0f442c355]
  4: (abort()+0x17f) [0x7fe0f442d5ef]
  5: (__assert_fail()+0xf1) [0x7fe0f44254c1]
  6: (FileStore::_do_transaction(ObjectStore::Transaction&)+0x3d42)=20
[0x5c4b62]
  7: (FileStore::do_transactions(std::list<ObjectStore::Transaction*,=20
std::allocator<ObjectStore::Transaction*> >&, unsigned long)+0x75)=20
[0x5c5135]
  8: (JournalingObjectStore::journal_replay(unsigned long)+0xf60)=20
[0x5d54c0]
  9: (FileStore::mount()+0x17e9) [0x5ae489]
  10: (OSD::init()+0x165) [0x50cfd5]
  11: (main()+0x2424) [0x48ba64]
  12: (__libc_start_main()+0xfd) [0x7fe0f4418d2d]
  13: /usr/bin/cosd() [0x4881e9]



It seems cosd  does not escalate error situations


On Tue, 12 Jul 2011 09:06:14 -0700 (PDT), Sage Weil wrote:
> On Tue, 12 Jul 2011, Meng Zhao wrote:
>> Thanks Tommi.  I rebuilt the ceph cluster a few times just to=20
>> reproduce the
>> situation. The result seems mixed, more likely btrfs failed (after=20
>> power
>> reset). But it does happen anyway.
>>
>> The big question is: However rare, unfound object situation makes=20
>> the *entire*
>> ceph file system not mountable, leads to a total lost of all data.=20
>> That is
>> quite a risk to take for production system.  Is there a way to=20
>> recover from
>> such situation ?(e.g. remove the file associated with the missing=20
>> object)
>
> There isn't an easy way to do this currently, but it is very easy to=20
> add.
> I've added an issue to the tracker.
>
> The real question is whether the lost object is file data or=20
> namespace
> metadata.  If it's namespace metadata, you may lose part of the=20
> directory
> hierarchy (until the fsck/namespace rebuild work is done).  For file=20
> data,
> it's easy enough to just mark the unfound object as deleted.
>
> sage
>
>
>>
>>
>> On Fri, 8 Jul 2011 10:08:46 -0700, Tommi Virtanen wrote:
>> > [It seems I dropped the Cc: to ceph-devel, added it back.. Please
>> > reply to this message instead, and sorry about that. I'm starting=20
>> to
>> > dislike Google Apps for mailing list traffic :( ]
>> >
>> > On Fri, Jul 8, 2011 at 10:07, Tommi Virtanen
>> > <tommi.virtanen@dreamhost.com> wrote:
>> > > On Fri, Jul 8, 2011 at 01:23, Meng Zhao <mzhao@carbonite.cn>=20
>> wrote:
>> > > > I was trying to replace a disk for an osd by following=20
>> instruction at:
>> > > > http://ceph.newdream.net/wiki/Replacing_a_failed_disk/OSD
>> > > >
>> > > > Now, ceph -w getting
>> > > > 2011-07-08 15:52:39.702881 =C2=A0 =C2=A0pg v1602: 602 pgs: 49=20
>> active+degraded, 553
>> > > > active+clean+degraded; 349 MB data, 333 MB used, 566 MB / 1023=
=20
>> MB avail;
>> > > > 167/224 degraded (74.554%); 55/112 unfound (49.107%)
>> > > >
>> > > > and a copy operation hang on the ceph client forever. I cannot=
=20
>> kill (-9)
>> > > > the
>> > > > cp process. Is there any hope to recover my ceph filesystem?
>> > >
>> > > I'm pretty sure that the cp is hanging because Ceph chooses to=20
>> wait in
>> > > case the unfound objects do come back (e.g. an OSD comes back=20
>> online).
>> > >
>> > > Now, in the default configuration, losing a single OSD should=20
>> not have
>> > > caused unfound objects in the first place. Can you provide any=20
>> more
>> > > information on how you got to that point?
>> > >
>> > > > My general question is: How are objects distributed among=20
>> OSDs? Does
>> > > > duplication (2x) guarantee that a failure of a single OSD=20
>> would not lose
>> > > > data? =C2=A0It appears to me that the objects are statisticall=
y=20
>> redistributed
>> > > > and
>> > > > does not guarantee physical separation of replication data=20
>> location.
>> > >
>> > > The CRUSH logic has a special case for that: when picking=20
>> replicas, if
>> > > it would pick an already used bucket, it tries again.
>> > >
>> > > My understanding is that with the default crushmap, replicas=20
>> will go
>> > > to different OSDs, and this is what I see in practice. If you=20
>> did
>> > > construct your crushmap, it's possible that you made one that=20
>> allows
>> > > multiple replicas on the same drive. Or even configured Ceph to
>> > > maintain no replicas.
>> > >
>> > > It is also possible you got hit by a bug, most likely one not in=
=20
>> the
>> > > placement rules but in the OSDs code.
>> > >
>> > > Can you provide more information on your setup and the steps you=
=20
>> took?
>> > >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe=20
>> ceph-devel" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe=20
>> ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
