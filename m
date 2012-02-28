From: =?ISO-8859-1?Q?Sz=E9kelyi?= Szabolcs <szekelyi@niif.hu>
Subject: Re: [WRN] map e### wrongly marked me down or wrong addr
Date: Tue, 28 Feb 2012 16:31:34 +0100
Message-ID: <2227262.Lg19pAvyvB@mranderson>
References: <2230716.Iq9SpLVmvc@mranderson> <Pine.LNX.4.64.1202270901350.12283@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart2448108.lJbEuqYKq2"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ki.iif.hu ([193.6.222.241]:55667 "EHLO mail.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752470Ab2B1Pb4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Feb 2012 10:31:56 -0500
In-Reply-To: <Pine.LNX.4.64.1202270901350.12283@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org, wido@widodh.nl


--nextPart2448108.lJbEuqYKq2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On 2012. February 27. 09:03:11 Sage Weil wrote:
> On Mon, 27 Feb 2012, Sz=E9kelyi Szabolcs wrote:
> > whenever I restart osd.0 I see a pair of messages like
> >=20
> > 2012-02-27 17:26:00.132666 mon.0 <osd_1_ip>:6789/0 106 : [INF] osd.=
0
> > <osd_0_ip>:6801/29931 failed (by osd.1 <osd_1_ip>:6806/20125)
> > 2012-02-27 17:26:21.074926 osd.0 <osd_0_ip>:6801/29931 1 : [WRN] ma=
p
> > e370
> > wrongly marked me down or wrong addr
> >=20
> > a couple of times. The situation stabilizes in a normal state after=

> > about two minutes.
> >=20
> > Should I worry about this? Maybe the first message is about the jus=
t
> > killed OSD, and the second comes from the new incarnation, and this=
 is
> > completely normal? This is Ceph 0.41.
>=20
> It's not normal.  Wido was seeing something similar, I think.  I susp=
ect
> the problem is that during startup ceph-osd just busy, but the heartb=
eat
> code is such that it's not supposed to miss them.
>=20
> Can you reproduce this with 'debug ms =3D 1'?

Yes, I managed to. Output of ceph -w attached (with IP addresses mangle=
d). My=20
setup is 3 nodes, node 1 and 2 running OSD, MDS and MON, node 3 running=
 MON=20
only. I also have the logs from all nodes in case you need it.

Thanks,
--=20
cc


--nextPart2448108.lJbEuqYKq2
Content-Disposition: attachment; filename="ceph.log"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-log; charset="UTF-8"; name="ceph.log"

2012-02-28 16:01:13.264183 7ff7a5070760 -- :/0 messenger.start
2012-02-28 16:01:13.264667 7ff7a5070760 -- :/30181 --> <node2_ip>:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0xfd49e0 con 0xfd4680
2012-02-28 16:01:13.273459 7ff7a506f700 -- <node3_ip>:0/30181 learned my addr <node3_ip>:0/30181
2012-02-28 16:01:13.282361 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 1 ==== mon_map v1 ==== 484+0+0 (2076239083 0 0) 0xfd57c0 con 0xfd4680
2012-02-28 16:01:13.282416 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 2 ==== auth_reply(proto 2 0 Success) v1 ==== 33+0+0 (3148579503 0 0) 0xfd59c0 con 0xfd4680
2012-02-28 16:01:13.282585 7ff7a1def700 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- auth(proto 2 32 bytes epoch 0) v1 -- ?+0 0x7ff798001860 con 0xfd4680
2012-02-28 16:01:13.287192 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 3 ==== auth_reply(proto 2 0 Success) v1 ==== 206+0+0 (3356126306 0 0) 0xfd50a0 con 0xfd4680
2012-02-28 16:01:13.287284 7ff7a1def700 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- auth(proto 2 165 bytes epoch 0) v1 -- ?+0 0x7ff798001b20 con 0xfd4680
2012-02-28 16:01:13.292062 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 4 ==== auth_reply(proto 2 0 Success) v1 ==== 409+0+0 (1449299407 0 0) 0xfd2120 con 0xfd4680
2012-02-28 16:01:13.292122 7ff7a1def700 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- mon_subscribe({monmap=0+}) v1 -- ?+0 0xfd5560 con 0xfd4680
2012-02-28 16:01:13.292137 7ff7a1def700 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- observe(0 v0) v1 -- ?+0 0xfd4e90 con 0xfd4680
2012-02-28 16:01:13.292146 7ff7a1def700 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- observe(1 v0) v1 -- ?+0 0x7ff7980008d0 con 0xfd4680
2012-02-28 16:01:13.292153 7ff7a1def700 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- observe(2 v0) v1 -- ?+0 0x7ff798000aa0 con 0xfd4680
2012-02-28 16:01:13.292161 7ff7a1def700 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- observe(3 v0) v1 -- ?+0 0x7ff798000c70 con 0xfd4680
2012-02-28 16:01:13.292169 7ff7a1def700 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- observe(4 v0) v1 -- ?+0 0x7ff798000e40 con 0xfd4680
2012-02-28 16:01:13.292176 7ff7a1def700 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- observe(5 v0) v1 -- ?+0 0x7ff798001010 con 0xfd4680
2012-02-28 16:01:13.292208 7ff7a5070760 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- observe(0 v0) v1 -- ?+0 0xfd2120 con 0xfd4680
2012-02-28 16:01:13.292218 7ff7a5070760 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- observe(1 v0) v1 -- ?+0 0xfd49e0 con 0xfd4680
2012-02-28 16:01:13.292226 7ff7a5070760 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- observe(2 v0) v1 -- ?+0 0xfd4b90 con 0xfd4680
2012-02-28 16:01:13.292234 7ff7a5070760 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- observe(3 v0) v1 -- ?+0 0xfd7050 con 0xfd4680
2012-02-28 16:01:13.292241 7ff7a5070760 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- observe(4 v0) v1 -- ?+0 0x7ff798001e20 con 0xfd4680
2012-02-28 16:01:13.292249 7ff7a5070760 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- observe(5 v0) v1 -- ?+0 0x7ff798001fd0 con 0xfd4680
2012-02-28 16:01:13.296591 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 5 ==== mon_map v1 ==== 484+0+0 (2076239083 0 0) 0xfd4e90 con 0xfd4680
2012-02-28 16:01:13.296625 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 6 ==== mon_subscribe_ack(300s) v1 ==== 20+0+0 (550605086 0 0) 0xfd2120 con 0xfd4680
2012-02-28 16:01:13.321810 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 7 ==== mon_observe_notify(v144307 103495 bytes latest v144307) v1 ==== 103546+0+0 (4223560445 0 0) 0xfd4e90 con 0xfd4680
2012-02-28 16:01:13.321821    pg v144307: 396 pgs: 396 active+clean; 5462 MB data, 11050 MB used, 70829 MB / 81880 MB avail
2012-02-28 16:01:13.322938 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 8 ==== mon_observe_notify(v228 723 bytes latest v228) v1 ==== 774+0+0 (1278325872 0 0) 0xfd2120 con 0xfd4680
2012-02-28 16:01:13.322952   mds e228: 1/1/1 up {0=nyme-eik=up:active}, 1 up:standby
2012-02-28 16:01:13.322999 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 9 ==== mon_observe_notify(v417 1808 bytes latest v417) v1 ==== 1859+0+0 (2344824191 0 0) 0xfd5f10 con 0xfd4680
2012-02-28 16:01:13.323004   osd e417: 2 osds: 2 up, 2 in
2012-02-28 16:01:13.323079 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 10 ==== mon_observe_notify(v21749 9063 bytes latest v21749) v1 ==== 9114+0+0 (1289442126 0 0) 0xfd6160 con 0xfd4680
2012-02-28 16:01:13.323083   log 2012-02-28 00:36:13.972330 osd.0 <node1_ip>:6801/4107 174 : [INF] 2.11 scrub ok
2012-02-28 16:01:13.323142 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 11 ==== mon_observe_notify(v1 480 bytes latest v1) v1 ==== 531+0+0 (2957729643 0 0) 0xfd0520 con 0xfd4680
2012-02-28 16:01:13.323146   mon e1: 3 mons at {cc=<node3_ip>:6789/0,duf-iszk=<node1_ip>:6789/0,nyme-eik=<node2_ip>:6789/0}
2012-02-28 16:01:13.323174 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 12 ==== mon_observe_notify(v3002 1247 bytes latest v3002) v1 ==== 1298+0+0 (2708200378 0 0) 0xfd6880 con 0xfd4680
2012-02-28 16:01:13.323185 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 13 ==== observe(0 v0) v1 ==== 46+0+0 (801180020 0 0) 0xfd6b70 con 0xfd4680
2012-02-28 16:01:13.323196 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 14 ==== observe(1 v0) v1 ==== 46+0+0 (514907460 0 0) 0xfd5560 con 0xfd4680
2012-02-28 16:01:13.323206 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 15 ==== observe(2 v0) v1 ==== 46+0+0 (1294115092 0 0) 0xfd9400 con 0xfd4680
2012-02-28 16:01:13.323215 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 16 ==== observe(3 v0) v1 ==== 46+0+0 (2085844260 0 0) 0xfd9650 con 0xfd4680
2012-02-28 16:01:13.323225 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 17 ==== observe(4 v0) v1 ==== 46+0+0 (3926284724 0 0) 0xfd98c0 con 0xfd4680
2012-02-28 16:01:13.323235 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 18 ==== observe(5 v0) v1 ==== 46+0+0 (3682045316 0 0) 0xfd9b30 con 0xfd4680
2012-02-28 16:01:13.323244 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 19 ==== observe(0 v0) v1 ==== 46+0+0 (307195066 0 0) 0xfd9da0 con 0xfd4680
2012-02-28 16:01:13.323254 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 20 ==== observe(1 v0) v1 ==== 46+0+0 (591313034 0 0) 0xfda010 con 0xfd4680
2012-02-28 16:01:13.323264 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 21 ==== observe(2 v0) v1 ==== 46+0+0 (1890370778 0 0) 0xfda280 con 0xfd4680
2012-02-28 16:01:13.323273 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 22 ==== observe(3 v0) v1 ==== 46+0+0 (1105006826 0 0) 0xfda4f0 con 0xfd4680
2012-02-28 16:01:13.323282 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 23 ==== observe(4 v0) v1 ==== 46+0+0 (3616029818 0 0) 0xfda760 con 0xfd4680
2012-02-28 16:01:13.323292 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 24 ==== observe(5 v0) v1 ==== 46+0+0 (3875137610 0 0) 0xfda9d0 con 0xfd4680
2012-02-28 16:01:20.877850 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 25 ==== mon_observe_notify(v144308 355 bytes v144308) v1 ==== 406+0+0 (2395304311 0 0) 0xfd2120 con 0xfd4680
2012-02-28 16:01:20.877869    pg v144308: 396 pgs: 396 active+clean; 5462 MB data, 11050 MB used, 70829 MB / 81880 MB avail
2012-02-28 16:01:24.311141 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 26 ==== mon_observe_notify(v144309 355 bytes v144309) v1 ==== 406+0+0 (3968204164 0 0) 0xfd0520 con 0xfd4680
2012-02-28 16:01:24.311156    pg v144309: 396 pgs: 396 active+clean; 5462 MB data, 11050 MB used, 70829 MB / 81880 MB avail
2012-02-28 16:01:58.861459 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 27 ==== mon_observe_notify(v418 121 bytes v418) v1 ==== 172+0+0 (1629466791 0 0) 0xfd2120 con 0xfd4680
2012-02-28 16:01:58.861480   osd e418: 2 osds: 1 up, 2 in
2012-02-28 16:02:00.168388 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 28 ==== mon_observe_notify(v144310 41 bytes v144310) v1 ==== 92+0+0 (1653431204 0 0) 0xfd0520 con 0xfd4680
2012-02-28 16:02:00.168407    pg v144310: 396 pgs: 396 active+clean; 5462 MB data, 11050 MB used, 70829 MB / 81880 MB avail
2012-02-28 16:02:01.614940 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 29 ==== mon_observe_notify(v419 548 bytes v419) v1 ==== 599+0+0 (3611041000 0 0) 0xfd2120 con 0xfd4680
2012-02-28 16:02:01.614955   osd e419: 2 osds: 2 up, 2 in
2012-02-28 16:02:04.321772 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 30 ==== mon_observe_notify(v144311 41 bytes v144311) v1 ==== 92+0+0 (2508967073 0 0) 0xfd0520 con 0xfd4680
2012-02-28 16:02:04.321787    pg v144311: 396 pgs: 396 active+clean; 5462 MB data, 11050 MB used, 70829 MB / 81880 MB avail
2012-02-28 16:02:19.966675 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 31 ==== mon_observe_notify(v420 124 bytes v420) v1 ==== 175+0+0 (4125450570 0 0) 0xfd2120 con 0xfd4680
2012-02-28 16:02:19.966693   osd e420: 2 osds: 2 up, 2 in
2012-02-28 16:02:19.966732 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 32 ==== mon_observe_notify(v21750 206 bytes v21750) v1 ==== 257+0+0 (1082969218 0 0) 0xfd0520 con 0xfd4680
2012-02-28 16:02:19.966736   log 2012-02-28 16:02:01.611321 mon.0 <node2_ip>:6789/0 14 : [INF] osd.0 <node1_ip>:6804/23742 boot
2012-02-28 16:02:26.705321 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 33 ==== mon_observe_notify(v144312 139 bytes v144312) v1 ==== 190+0+0 (986727106 0 0) 0xfd2120 con 0xfd4680
2012-02-28 16:02:26.705337    pg v144312: 396 pgs: 396 active+clean; 5462 MB data, 11068 MB used, 70811 MB / 81880 MB avail
2012-02-28 16:02:28.348630 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 34 ==== mon_observe_notify(v21751 631 bytes v21751) v1 ==== 682+0+0 (1833216267 0 0) 0xfd0520 con 0xfd4680
2012-02-28 16:02:28.348642   log 2012-02-28 16:02:13.290671 mon.2 <node3_ip>:6789/0 19 : [INF] mon.cc calling new monitor election
2012-02-28 16:02:28.348642   log 2012-02-28 16:02:13.308784 mon.1 <node1_ip>:6789/0 20 : [INF] mon.duf-iszk calling new monitor election
2012-02-28 16:02:28.348642   log 2012-02-28 16:02:18.654781 mon.1 <node1_ip>:6789/0 21 : [INF] mon.duf-iszk@1 won leader election with quorum 1,2
2012-02-28 16:02:29.144306 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 35 ==== mon_observe_notify(v421 132 bytes v421) v1 ==== 183+0+0 (923968138 0 0) 0xfd2120 con 0xfd4680
2012-02-28 16:02:29.144317   osd e421: 2 osds: 2 up, 2 in
2012-02-28 16:02:30.964743 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 36 ==== mon_observe_notify(v144313 41 bytes v144313) v1 ==== 92+0+0 (2863575645 0 0) 0xfd0520 con 0xfd4680
2012-02-28 16:02:30.964758    pg v144313: 396 pgs: 396 active+clean; 5462 MB data, 11068 MB used, 70811 MB / 81880 MB avail
2012-02-28 16:02:32.195112 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 37 ==== mon_observe_notify(v21752 842 bytes v21752) v1 ==== 893+0+0 (39343928 0 0) 0xfd2120 con 0xfd4680
2012-02-28 16:02:32.195131   log 2012-02-28 16:02:19.968787 mon.0 <node2_ip>:6789/0 15 : [INF] mon.nyme-eik calling new monitor election
2012-02-28 16:02:32.195131   log 2012-02-28 16:02:20.320948 mon.2 <node3_ip>:6789/0 20 : [INF] mon.cc calling new monitor election
2012-02-28 16:02:32.195131   log 2012-02-28 16:02:20.922430 mon.0 <node2_ip>:6789/0 16 : [INF] mon.nyme-eik calling new monitor election
2012-02-28 16:02:32.195131   log 2012-02-28 16:02:22.659472 mon.0 <node2_ip>:6789/0 17 : [INF] mon.nyme-eik@0 won leader election with quorum 0,1,2
2012-02-28 16:02:34.453449 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 38 ==== mon_observe_notify(v21753 454 bytes v21753) v1 ==== 505+0+0 (1664099018 0 0) 0xfd0520 con 0xfd4680
2012-02-28 16:02:34.453463   log 2012-02-28 16:02:22.105130 mon.1 <node1_ip>:6789/0 22 : [INF] mon.duf-iszk calling new monitor election
2012-02-28 16:02:34.453463   log 2012-02-28 16:02:32.191719 mon.0 <node2_ip>:6789/0 18 : [INF] osd.0 <node1_ip>:6804/23742 failed (by osd.1 <node2_ip>:6804/30245)
2012-02-28 16:02:35.214841 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 39 ==== mon_observe_notify(v144314 103499 bytes v144314) v1 ==== 103550+0+0 (2646928202 0 0) 0xfd4e90 con 0xfd4680
2012-02-28 16:02:35.214854    pg v144314: 396 pgs: 396 peering; 5462 MB data, 11071 MB used, 70808 MB / 81880 MB avail
2012-02-28 16:02:42.598690 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 40 ==== mon_observe_notify(v144315 44982 bytes v144315) v1 ==== 45033+0+0 (3226339542 0 0) 0xfd4e90 con 0xfd4680
2012-02-28 16:02:42.598708    pg v144315: 396 pgs: 172 active+clean, 224 peering; 5462 MB data, 11073 MB used, 70806 MB / 81880 MB avail
2012-02-28 16:02:47.406071 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 41 ==== mon_observe_notify(v144316 44982 bytes v144316) v1 ==== 45033+0+0 (547737123 0 0) 0xfd4e90 con 0xfd4680
2012-02-28 16:02:47.406089    pg v144316: 396 pgs: 172 active+clean, 224 peering; 5462 MB data, 11069 MB used, 70810 MB / 81880 MB avail
2012-02-28 16:02:51.526856 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 42 ==== mon_observe_notify(v144317 58868 bytes v144317) v1 ==== 58919+0+0 (829960563 0 0) 0xfd4e90 con 0xfd4680
2012-02-28 16:02:51.526871    pg v144317: 396 pgs: 396 active+clean; 5462 MB data, 11066 MB used, 70813 MB / 81880 MB avail
2012-02-28 16:02:54.123603 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 43 ==== mon_observe_notify(v21754 245 bytes v21754) v1 ==== 296+0+0 (1847835573 0 0) 0xfd4e90 con 0xfd4680
2012-02-28 16:02:54.123627   log 2012-02-28 16:02:47.381310 mon.0 <node2_ip>:6789/0 19 : [INF] osd.0 <node1_ip>:6804/23742 failed (by osd.1 <node2_ip>:6804/30245)
2012-02-28 16:02:56.134109 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 44 ==== mon_observe_notify(v144318 58868 bytes v144318) v1 ==== 58919+0+0 (2723822933 0 0) 0xfd4e90 con 0xfd4680
2012-02-28 16:02:56.134127    pg v144318: 396 pgs: 396 active+clean; 5462 MB data, 11081 MB used, 70798 MB / 81880 MB avail
2012-02-28 16:02:57.647285 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 45 ==== mon_observe_notify(v422 121 bytes v422) v1 ==== 172+0+0 (2253776352 0 0) 0xfd4e90 con 0xfd4680
2012-02-28 16:02:57.647301   osd e422: 2 osds: 1 up, 2 in
2012-02-28 16:02:58.861179 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 46 ==== mon_observe_notify(v21755 245 bytes v21755) v1 ==== 296+0+0 (36946188 0 0) 0xfd4e90 con 0xfd4680
2012-02-28 16:02:58.861196   log 2012-02-28 16:02:56.105655 mon.0 <node2_ip>:6789/0 20 : [INF] osd.0 <node1_ip>:6804/23742 failed (by osd.1 <node2_ip>:6804/30245)
2012-02-28 16:02:59.877287 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 47 ==== mon_observe_notify(v144319 355 bytes v144319) v1 ==== 406+0+0 (3217771738 0 0) 0xfd4e90 con 0xfd4680
2012-02-28 16:02:59.877299    pg v144319: 396 pgs: 396 active+clean; 5462 MB data, 11092 MB used, 70787 MB / 81880 MB avail
2012-02-28 16:03:01.759577 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 48 ==== mon_observe_notify(v144320 41 bytes v144320) v1 ==== 92+0+0 (2419092195 0 0) 0xfd4e90 con 0xfd4680
2012-02-28 16:03:01.759591    pg v144320: 396 pgs: 396 active+clean; 5462 MB data, 11092 MB used, 70787 MB / 81880 MB avail
2012-02-28 16:03:04.800993 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 49 ==== mon_observe_notify(v21756 214 bytes v21756) v1 ==== 265+0+0 (3667335124 0 0) 0xfd4e90 con 0xfd4680
2012-02-28 16:03:04.801014   log 2012-02-28 16:02:57.076950 osd.0 <node1_ip>:6804/23742 1 : [WRN] map e422 wrongly marked me down or wrong addr
2012-02-28 16:03:06.327975 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 50 ==== mon_observe_notify(v144321 355 bytes v144321) v1 ==== 406+0+0 (515198204 0 0) 0xfd4e90 con 0xfd4680
2012-02-28 16:03:06.327990    pg v144321: 396 pgs: 396 active+clean; 5462 MB data, 11083 MB used, 70796 MB / 81880 MB avail
2012-02-28 16:03:07.848555 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 51 ==== mon_observe_notify(v423 556 bytes v423) v1 ==== 607+0+0 (171857389 0 0) 0xfd4e90 con 0xfd4680
2012-02-28 16:03:07.848567   osd e423: 2 osds: 2 up, 2 in
2012-02-28 16:03:13.958511 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 52 ==== mon_observe_notify(v144322 41 bytes v144322) v1 ==== 92+0+0 (1716590982 0 0) 0xfd4e90 con 0xfd4680
2012-02-28 16:03:13.958530    pg v144322: 396 pgs: 396 active+clean; 5462 MB data, 11083 MB used, 70796 MB / 81880 MB avail
2012-02-28 16:03:15.148995 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 53 ==== mon_observe_notify(v21757 206 bytes v21757) v1 ==== 257+0+0 (2088400352 0 0) 0xfd4e90 con 0xfd4680
2012-02-28 16:03:15.149007   log 2012-02-28 16:03:07.844740 mon.0 <node2_ip>:6789/0 21 : [INF] osd.0 <node1_ip>:6804/23742 boot
2012-02-28 16:03:16.089873 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 54 ==== mon_observe_notify(v424 124 bytes v424) v1 ==== 175+0+0 (3988733786 0 0) 0xfd4e90 con 0xfd4680
2012-02-28 16:03:16.089893   osd e424: 2 osds: 2 up, 2 in
2012-02-28 16:03:20.015196 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 55 ==== mon_observe_notify(v144323 41 bytes v144323) v1 ==== 92+0+0 (218939456 0 0) 0xfd4e90 con 0xfd4680
2012-02-28 16:03:20.015213    pg v144323: 396 pgs: 396 active+clean; 5462 MB data, 11083 MB used, 70796 MB / 81880 MB avail
2012-02-28 16:03:23.735483 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 56 ==== mon_observe_notify(v425 124 bytes v425) v1 ==== 175+0+0 (3929752999 0 0) 0xfd4e90 con 0xfd4680
2012-02-28 16:03:23.735498   osd e425: 2 osds: 2 up, 2 in
2012-02-28 16:03:27.835810 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 57 ==== mon_observe_notify(v144324 58558 bytes v144324) v1 ==== 58609+0+0 (1302549044 0 0) 0xfd4e90 con 0xfd4680
2012-02-28 16:03:27.835826    pg v144324: 396 pgs: 172 active+clean, 224 peering; 5462 MB data, 11092 MB used, 70787 MB / 81880 MB avail
2012-02-28 16:03:29.839119 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 58 ==== mon_observe_notify(v144325 41 bytes v144325) v1 ==== 92+0+0 (4162372517 0 0) 0xfd4e90 con 0xfd4680
2012-02-28 16:03:29.839135    pg v144325: 396 pgs: 172 active+clean, 224 peering; 5462 MB data, 11092 MB used, 70787 MB / 81880 MB avail
2012-02-28 16:03:31.483193 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 59 ==== mon_observe_notify(v144326 58558 bytes v144326) v1 ==== 58609+0+0 (3881269352 0 0) 0xfd4e90 con 0xfd4680
2012-02-28 16:03:31.483207    pg v144326: 396 pgs: 172 active+clean, 224 peering; 5462 MB data, 11093 MB used, 70786 MB / 81880 MB avail
2012-02-28 16:03:34.516819 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 60 ==== mon_observe_notify(v144327 44982 bytes v144327) v1 ==== 45033+0+0 (1169982256 0 0) 0xfd4e90 con 0xfd4680
2012-02-28 16:03:34.516837    pg v144327: 396 pgs: 172 active+clean, 224 peering; 5462 MB data, 11086 MB used, 70793 MB / 81880 MB avail
2012-02-28 16:03:37.298876 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 61 ==== mon_observe_notify(v144328 58558 bytes v144328) v1 ==== 58609+0+0 (3918549894 0 0) 0xfd4e90 con 0xfd4680
2012-02-28 16:03:37.298895    pg v144328: 396 pgs: 172 active+clean, 224 peering; 5462 MB data, 11065 MB used, 70814 MB / 81880 MB avail
2012-02-28 16:03:38.928847 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 62 ==== mon_observe_notify(v21758 245 bytes v21758) v1 ==== 296+0+0 (1456146670 0 0) 0xfd4e90 con 0xfd4680
2012-02-28 16:03:38.928867   log 2012-02-28 16:03:34.492517 mon.0 <node2_ip>:6789/0 22 : [INF] osd.0 <node1_ip>:6804/23742 failed (by osd.1 <node2_ip>:6804/30245)
2012-02-28 16:03:42.950954 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 63 ==== mon_observe_notify(v144329 351 bytes v144329) v1 ==== 402+0+0 (3782619541 0 0) 0xfd4e90 con 0xfd4680
2012-02-28 16:03:42.950968    pg v144329: 396 pgs: 172 active+clean, 224 peering; 5462 MB data, 11066 MB used, 70813 MB / 81880 MB avail
2012-02-28 16:03:43.277976 7ff7a05ec700 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- observe(0 v144329) v1 -- ?+0 0xfd5560 con 0xfd4680
2012-02-28 16:03:43.278004 7ff7a05ec700 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- observe(1 v228) v1 -- ?+0 0xfd4e90 con 0xfd4680
2012-02-28 16:03:43.278016 7ff7a05ec700 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- observe(2 v425) v1 -- ?+0 0xfd6dd0 con 0xfd4680
2012-02-28 16:03:43.278026 7ff7a05ec700 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- observe(3 v21758) v1 -- ?+0 0xfd2120 con 0xfd4680
2012-02-28 16:03:43.278035 7ff7a05ec700 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- observe(4 v1) v1 -- ?+0 0xfd49e0 con 0xfd4680
2012-02-28 16:03:43.278045 7ff7a05ec700 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- observe(5 v3002) v1 -- ?+0 0xfd02d0 con 0xfd4680
2012-02-28 16:03:43.282820 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 64 ==== observe(0 v144329) v1 ==== 46+0+0 (950636123 0 0) 0xfd5560 con 0xfd4680
2012-02-28 16:03:43.282840 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 65 ==== observe(1 v228) v1 ==== 46+0+0 (3867231385 0 0) 0xfd02d0 con 0xfd4680
2012-02-28 16:03:43.282851 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 66 ==== observe(2 v425) v1 ==== 46+0+0 (2544068279 0 0) 0xfd4e90 con 0xfd4680
2012-02-28 16:03:43.286732 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 67 ==== observe(3 v21758) v1 ==== 46+0+0 (2680762742 0 0) 0xfd5560 con 0xfd4680
2012-02-28 16:03:43.286784 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 68 ==== observe(4 v1) v1 ==== 46+0+0 (3735298227 0 0) 0xfd5560 con 0xfd4680
2012-02-28 16:03:43.286803 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 69 ==== observe(5 v3002) v1 ==== 46+0+0 (2986209494 0 0) 0xfd02d0 con 0xfd4680
2012-02-28 16:03:43.292392 7ff7a05ec700 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- observe(0 v144329) v1 -- ?+0 0xfd5560 con 0xfd4680
2012-02-28 16:03:43.292415 7ff7a05ec700 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- observe(1 v228) v1 -- ?+0 0xfd02d0 con 0xfd4680
2012-02-28 16:03:43.292428 7ff7a05ec700 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- observe(2 v425) v1 -- ?+0 0xfd4e90 con 0xfd4680
2012-02-28 16:03:43.292437 7ff7a05ec700 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- observe(3 v21758) v1 -- ?+0 0xfd6dd0 con 0xfd4680
2012-02-28 16:03:43.292446 7ff7a05ec700 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- observe(4 v1) v1 -- ?+0 0xfd2120 con 0xfd4680
2012-02-28 16:03:43.292455 7ff7a05ec700 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- observe(5 v3002) v1 -- ?+0 0xfd49e0 con 0xfd4680
2012-02-28 16:03:43.448583 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 70 ==== observe(0 v144329) v1 ==== 46+0+0 (950636123 0 0) 0xfd5560 con 0xfd4680
2012-02-28 16:03:43.448609 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 71 ==== observe(1 v228) v1 ==== 46+0+0 (3867231385 0 0) 0xfd02d0 con 0xfd4680
2012-02-28 16:03:43.448620 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 72 ==== observe(2 v425) v1 ==== 46+0+0 (2544068279 0 0) 0xfd4e90 con 0xfd4680
2012-02-28 16:03:43.448630 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 73 ==== observe(3 v21758) v1 ==== 46+0+0 (2680762742 0 0) 0xfd6dd0 con 0xfd4680
2012-02-28 16:03:43.448648 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 74 ==== observe(4 v1) v1 ==== 46+0+0 (3735298227 0 0) 0xfd2120 con 0xfd4680
2012-02-28 16:03:43.448659 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 75 ==== observe(5 v3002) v1 ==== 46+0+0 (2986209494 0 0) 0xfd49e0 con 0xfd4680
2012-02-28 16:03:46.266999 7ff7a15ee700 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- mon_subscribe({monmap=2+}) v1 -- ?+0 0xfd4bb0 con 0xfd4680
2012-02-28 16:03:48.616529 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 76 ==== mon_observe_notify(v144330 351 bytes v144330) v1 ==== 402+0+0 (1458204978 0 0) 0xfd6dd0 con 0xfd4680
2012-02-28 16:03:48.616549    pg v144330: 396 pgs: 172 active+clean, 224 peering; 5462 MB data, 11062 MB used, 70817 MB / 81880 MB avail
2012-02-28 16:03:48.616614 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 77 ==== mon_subscribe_ack(300s) v1 ==== 20+0+0 (550605086 0 0) 0xfd5560 con 0xfd4680
2012-02-28 16:03:53.178202 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 78 ==== mon_observe_notify(v21759 245 bytes v21759) v1 ==== 296+0+0 (1927834069 0 0) 0xfd6dd0 con 0xfd4680
2012-02-28 16:03:53.178218   log 2012-02-28 16:03:48.611694 mon.0 <node2_ip>:6789/0 23 : [INF] osd.0 <node1_ip>:6804/23742 failed (by osd.1 <node2_ip>:6804/30245)
2012-02-28 16:03:53.998690 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 79 ==== mon_observe_notify(v144331 58558 bytes v144331) v1 ==== 58609+0+0 (548481564 0 0) 0xfd6dd0 con 0xfd4680
2012-02-28 16:03:53.998709    pg v144331: 396 pgs: 396 active+clean; 5462 MB data, 11067 MB used, 70812 MB / 81880 MB avail
2012-02-28 16:03:54.709752 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 80 ==== mon_observe_notify(v144332 58558 bytes v144332) v1 ==== 58609+0+0 (3967922103 0 0) 0xfd6dd0 con 0xfd4680
2012-02-28 16:03:54.709766    pg v144332: 396 pgs: 396 active+clean; 5462 MB data, 11064 MB used, 70815 MB / 81880 MB avail
2012-02-28 16:03:55.519420 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 81 ==== mon_observe_notify(v426 121 bytes v426) v1 ==== 172+0+0 (2154679647 0 0) 0xfd6dd0 con 0xfd4680
2012-02-28 16:03:55.519431   osd e426: 2 osds: 1 up, 2 in
2012-02-28 16:03:58.096844 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 82 ==== mon_observe_notify(v21760 245 bytes v21760) v1 ==== 296+0+0 (4256530275 0 0) 0xfd6dd0 con 0xfd4680
2012-02-28 16:03:58.096857   log 2012-02-28 16:03:54.684957 mon.0 <node2_ip>:6789/0 24 : [INF] osd.0 <node1_ip>:6804/23742 failed (by osd.1 <node2_ip>:6804/30245)
2012-02-28 16:03:58.745138 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 83 ==== mon_observe_notify(v144333 355 bytes v144333) v1 ==== 406+0+0 (3219301286 0 0) 0xfd6dd0 con 0xfd4680
2012-02-28 16:03:58.745152    pg v144333: 396 pgs: 396 active+clean; 5462 MB data, 11063 MB used, 70816 MB / 81880 MB avail
2012-02-28 16:04:00.436538 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 84 ==== mon_observe_notify(v427 124 bytes v427) v1 ==== 175+0+0 (2389483845 0 0) 0xfd6dd0 con 0xfd4680
2012-02-28 16:04:00.436550   osd e427: 2 osds: 1 up, 2 in
2012-02-28 16:04:00.925585 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 85 ==== mon_observe_notify(v144334 41 bytes v144334) v1 ==== 92+0+0 (365831806 0 0) 0xfd6dd0 con 0xfd4680
2012-02-28 16:04:00.925597    pg v144334: 396 pgs: 396 active+clean; 5462 MB data, 11063 MB used, 70816 MB / 81880 MB avail
2012-02-28 16:04:05.860257 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 86 ==== mon_observe_notify(v428 548 bytes v428) v1 ==== 599+0+0 (3906418914 0 0) 0xfd6dd0 con 0xfd4680
2012-02-28 16:04:05.860273   osd e428: 2 osds: 2 up, 2 in
2012-02-28 16:04:07.012555 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 87 ==== mon_observe_notify(v21761 214 bytes v21761) v1 ==== 265+0+0 (4240544896 0 0) 0xfd6dd0 con 0xfd4680
2012-02-28 16:04:07.012572   log 2012-02-28 16:03:55.036189 osd.0 <node1_ip>:6804/23742 2 : [WRN] map e426 wrongly marked me down or wrong addr
2012-02-28 16:04:10.029658 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 88 ==== mon_observe_notify(v144335 41 bytes v144335) v1 ==== 92+0+0 (3653822023 0 0) 0xfd6dd0 con 0xfd4680
2012-02-28 16:04:10.029674    pg v144335: 396 pgs: 396 active+clean; 5462 MB data, 11063 MB used, 70816 MB / 81880 MB avail
2012-02-28 16:04:10.932193 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 89 ==== mon_observe_notify(v429 124 bytes v429) v1 ==== 175+0+0 (465460390 0 0) 0xfd6dd0 con 0xfd4680
2012-02-28 16:04:10.932204   osd e429: 2 osds: 2 up, 2 in
2012-02-28 16:04:12.326153 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 90 ==== mon_observe_notify(v21762 206 bytes v21762) v1 ==== 257+0+0 (1922524831 0 0) 0xfd6dd0 con 0xfd4680
2012-02-28 16:04:12.326166   log 2012-02-28 16:04:05.856109 mon.0 <node2_ip>:6789/0 25 : [INF] osd.0 <node1_ip>:6804/23742 boot
2012-02-28 16:04:12.937694 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 91 ==== mon_observe_notify(v144336 41 bytes v144336) v1 ==== 92+0+0 (658414210 0 0) 0xfd6dd0 con 0xfd4680
2012-02-28 16:04:12.937709    pg v144336: 396 pgs: 396 active+clean; 5462 MB data, 11063 MB used, 70816 MB / 81880 MB avail
2012-02-28 16:04:14.797257 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 92 ==== mon_observe_notify(v144337 44982 bytes v144337) v1 ==== 45033+0+0 (1828392876 0 0) 0xfd6dd0 con 0xfd4680
2012-02-28 16:04:14.797276    pg v144337: 396 pgs: 224 active+clean, 172 peering; 5462 MB data, 11077 MB used, 70802 MB / 81880 MB avail
2012-02-28 16:04:29.641568 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 93 ==== mon_observe_notify(v144338 56762 bytes v144338) v1 ==== 56813+0+0 (3662554996 0 0) 0xfd6dd0 con 0xfd4680
2012-02-28 16:04:29.641584    pg v144338: 396 pgs: 224 active+clean, 172 peering; 5462 MB data, 11081 MB used, 70798 MB / 81880 MB avail
2012-02-28 16:04:35.251625 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 94 ==== mon_observe_notify(v144339 56762 bytes v144339) v1 ==== 56813+0+0 (1704333868 0 0) 0xfd6dd0 con 0xfd4680
2012-02-28 16:04:35.251639    pg v144339: 396 pgs: 224 active+clean, 172 peering; 5462 MB data, 11086 MB used, 70793 MB / 81880 MB avail
2012-02-28 16:04:38.994117 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 95 ==== mon_observe_notify(v430 124 bytes v430) v1 ==== 175+0+0 (2163938809 0 0) 0xfd6dd0 con 0xfd4680
2012-02-28 16:04:38.994134   osd e430: 2 osds: 2 up, 2 in
2012-02-28 16:04:40.994550 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 96 ==== mon_observe_notify(v144340 41 bytes v144340) v1 ==== 92+0+0 (969654684 0 0) 0xfd6dd0 con 0xfd4680
2012-02-28 16:04:40.994567    pg v144340: 396 pgs: 224 active+clean, 172 peering; 5462 MB data, 11086 MB used, 70793 MB / 81880 MB avail
2012-02-28 16:04:42.444825 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 97 ==== mon_observe_notify(v144341 44986 bytes v144341) v1 ==== 45037+0+0 (1337086493 0 0) 0xfd6dd0 con 0xfd4680
2012-02-28 16:04:42.444840    pg v144341: 396 pgs: 396 active+clean; 5462 MB data, 11075 MB used, 70804 MB / 81880 MB avail
2012-02-28 16:04:50.287316 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 98 ==== mon_observe_notify(v144342 44986 bytes v144342) v1 ==== 45037+0+0 (1938909290 0 0) 0xfd6dd0 con 0xfd4680
2012-02-28 16:04:50.287329    pg v144342: 396 pgs: 396 active+clean; 5462 MB data, 11075 MB used, 70804 MB / 81880 MB avail
2012-02-28 16:04:53.559968 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 99 ==== mon_observe_notify(v144343 58558 bytes v144343) v1 ==== 58609+0+0 (3439726711 0 0) 0xfd6dd0 con 0xfd4680
2012-02-28 16:04:53.559981    pg v144343: 396 pgs: 172 active+clean, 224 peering; 5462 MB data, 11081 MB used, 70798 MB / 81880 MB avail
2012-02-28 16:05:07.418657 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 100 ==== mon_observe_notify(v144344 58558 bytes v144344) v1 ==== 58609+0+0 (2290017593 0 0) 0xfd6dd0 con 0xfd4680
2012-02-28 16:05:07.418672    pg v144344: 396 pgs: 396 active+clean; 5462 MB data, 11072 MB used, 70807 MB / 81880 MB avail
2012-02-28 16:05:16.583020 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 101 ==== mon_observe_notify(v144345 355 bytes v144345) v1 ==== 406+0+0 (246120157 0 0) 0xfd6dd0 con 0xfd4680
2012-02-28 16:05:16.583036    pg v144345: 396 pgs: 396 active+clean; 5462 MB data, 11063 MB used, 70816 MB / 81880 MB avail
2012-02-28 16:05:24.069058 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 102 ==== mon_observe_notify(v144346 355 bytes v144346) v1 ==== 406+0+0 (1129884504 0 0) 0xfd6dd0 con 0xfd4680
2012-02-28 16:05:24.069071    pg v144346: 396 pgs: 396 active+clean; 5462 MB data, 11055 MB used, 70824 MB / 81880 MB avail
2012-02-28 16:05:25.513859 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 103 ==== mon_observe_notify(v144347 355 bytes v144347) v1 ==== 406+0+0 (12007247 0 0) 0xfd6dd0 con 0xfd4680
2012-02-28 16:05:25.513873    pg v144347: 396 pgs: 396 active+clean; 5462 MB data, 11071 MB used, 70808 MB / 81880 MB avail
2012-02-28 16:06:13.278232 7ff7a05ec700 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- observe(0 v144347) v1 -- ?+0 0xfd5560 con 0xfd4680
2012-02-28 16:06:13.278264 7ff7a05ec700 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- observe(1 v228) v1 -- ?+0 0xfd2120 con 0xfd4680
2012-02-28 16:06:13.278277 7ff7a05ec700 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- observe(2 v430) v1 -- ?+0 0xfd02d0 con 0xfd4680
2012-02-28 16:06:13.278286 7ff7a05ec700 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- observe(3 v21762) v1 -- ?+0 0xfd6dd0 con 0xfd4680
2012-02-28 16:06:13.278295 7ff7a05ec700 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- observe(4 v1) v1 -- ?+0 0xfd4e90 con 0xfd4680
2012-02-28 16:06:13.278304 7ff7a05ec700 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- observe(5 v3002) v1 -- ?+0 0xfd49e0 con 0xfd4680
2012-02-28 16:06:13.282787 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 104 ==== observe(0 v144347) v1 ==== 46+0+0 (3090185049 0 0) 0xfd2120 con 0xfd4680
2012-02-28 16:06:13.282815 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 105 ==== observe(1 v228) v1 ==== 46+0+0 (3867231385 0 0) 0xfd49e0 con 0xfd4680
2012-02-28 16:06:13.282834 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 106 ==== observe(2 v430) v1 ==== 46+0+0 (2825334984 0 0) 0xfd02d0 con 0xfd4680
2012-02-28 16:06:13.287204 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 107 ==== observe(3 v21762) v1 ==== 46+0+0 (2269441988 0 0) 0xfd2120 con 0xfd4680
2012-02-28 16:06:13.287236 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 108 ==== observe(4 v1) v1 ==== 46+0+0 (3735298227 0 0) 0xfd49e0 con 0xfd4680
2012-02-28 16:06:13.287257 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 109 ==== observe(5 v3002) v1 ==== 46+0+0 (2986209494 0 0) 0xfd5560 con 0xfd4680
2012-02-28 16:06:13.292634 7ff7a05ec700 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- observe(0 v144347) v1 -- ?+0 0xfd2120 con 0xfd4680
2012-02-28 16:06:13.292659 7ff7a05ec700 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- observe(1 v228) v1 -- ?+0 0xfd49e0 con 0xfd4680
2012-02-28 16:06:13.292671 7ff7a05ec700 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- observe(2 v430) v1 -- ?+0 0xfd02d0 con 0xfd4680
2012-02-28 16:06:13.292681 7ff7a05ec700 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- observe(3 v21762) v1 -- ?+0 0xfd5560 con 0xfd4680
2012-02-28 16:06:13.292690 7ff7a05ec700 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- observe(4 v1) v1 -- ?+0 0xfd6dd0 con 0xfd4680
2012-02-28 16:06:13.292699 7ff7a05ec700 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- observe(5 v3002) v1 -- ?+0 0xfd4e90 con 0xfd4680
2012-02-28 16:06:13.297127 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 110 ==== observe(0 v144347) v1 ==== 46+0+0 (3090185049 0 0) 0xfd02d0 con 0xfd4680
2012-02-28 16:06:13.297158 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 111 ==== observe(1 v228) v1 ==== 46+0+0 (3867231385 0 0) 0xfd2120 con 0xfd4680
2012-02-28 16:06:13.297178 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 112 ==== observe(2 v430) v1 ==== 46+0+0 (2825334984 0 0) 0xfd49e0 con 0xfd4680
2012-02-28 16:06:13.297188 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 113 ==== observe(3 v21762) v1 ==== 46+0+0 (2269441988 0 0) 0xfd5560 con 0xfd4680
2012-02-28 16:06:13.297199 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 114 ==== observe(4 v1) v1 ==== 46+0+0 (3735298227 0 0) 0xfd6dd0 con 0xfd4680
2012-02-28 16:06:13.301331 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 115 ==== observe(5 v3002) v1 ==== 46+0+0 (2986209494 0 0) 0xfd02d0 con 0xfd4680
2012-02-28 16:06:16.269548 7ff7a15ee700 -- <node3_ip>:0/30181 --> <node2_ip>:6789/0 -- mon_subscribe({monmap=2+}) v1 -- ?+0 0xfd2120 con 0xfd4680
2012-02-28 16:06:16.274161 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 116 ==== mon_subscribe_ack(300s) v1 ==== 20+0+0 (550605086 0 0) 0xfd5560 con 0xfd4680
2012-02-28 16:06:23.056702 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 117 ==== mon_observe_notify(v144348 355 bytes v144348) v1 ==== 406+0+0 (3006755776 0 0) 0xfd4e90 con 0xfd4680
2012-02-28 16:06:23.056722    pg v144348: 396 pgs: 396 active+clean; 5462 MB data, 11071 MB used, 70808 MB / 81880 MB avail
2012-02-28 16:06:24.472054 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 118 ==== mon_observe_notify(v144349 355 bytes v144349) v1 ==== 406+0+0 (1863086531 0 0) 0xfd4e90 con 0xfd4680
2012-02-28 16:06:24.472070    pg v144349: 396 pgs: 396 active+clean; 5462 MB data, 11052 MB used, 70827 MB / 81880 MB avail
2012-02-28 16:07:23.105217 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 119 ==== mon_observe_notify(v144350 355 bytes v144350) v1 ==== 406+0+0 (917110385 0 0) 0xfd4e90 con 0xfd4680
2012-02-28 16:07:23.105238    pg v144350: 396 pgs: 396 active+clean; 5462 MB data, 11052 MB used, 70827 MB / 81880 MB avail
2012-02-28 16:07:24.455836 7ff7a1def700 -- <node3_ip>:0/30181 <== mon.0 <node2_ip>:6789/0 120 ==== mon_observe_notify(v144351 355 bytes v144351) v1 ==== 406+0+0 (3697664532 0 0) 0xfd4e90 con 0xfd4680
2012-02-28 16:07:24.455852    pg v144351: 396 pgs: 396 active+clean; 5462 MB data, 11052 MB used, 70827 MB / 81880 MB avail

--nextPart2448108.lJbEuqYKq2--

