From: =?ISO-8859-1?Q?Alexis_G=DCNST_HORN?=
	<alexis.gunsthorn@outscale.com>
Subject: Re: CephFS issue
Date: Wed, 16 Jan 2013 10:17:57 +0100
Message-ID: <CAEqYNSYadQ8PCYy5wXSYbz6TxYkYJmjyA6nbUTG+JD7-P5AQ=Q@mail.gmail.com>
References: <CAEqYNSYaMvprh580HNosaQe7ahMmT-iB9irMsgA87tE2fwtCTQ@mail.gmail.com>
	<13344378.XMpKyabt7g@hosanna>
	<CAKMAVE8w-HYuKiLXy3Nt+q3=CgiAzxjqwmJXpv4mUkHGp5bU-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:40753 "HELO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932141Ab3APJSB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 16 Jan 2013 04:18:01 -0500
Received: by mail-ia0-f200.google.com with SMTP id i38so364314iae.7
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jan 2013 01:17:57 -0800 (PST)
In-Reply-To: <CAKMAVE8w-HYuKiLXy3Nt+q3=CgiAzxjqwmJXpv4mUkHGp5bU-Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sam Lang <sam.lang@inktank.com>
Cc: "Joshua J. Kugler" <joshua@azariah.com>, ceph-devel@vger.kernel.org

Hello,

And thanks for your answers.

I've limited the client to 1Gb/s, in order to remove the network inbalance.
So now, everybody is 1 Gb/s.

But... but... I still have troubles. I can give you some more details
of my test procedure :

1. Start a fresh cluster, without cephx, 2GB journals on SSD.
2. Start my script (making a lot of empty files, and formatting them in ext3)
3. Issues. At the first issue, i stop my bench, to have readable logs.
Here are the logs


From ceph -w :
===========

2013-01-16 09:02:19.341051 mon.0 [INF] pgmap v1786: 4032 pgs: 4032
active+clean; 15936 MB data, 32214 MB used, 18589 GB / 18621 GB avail
2013-01-16 09:02:20.345751 mon.0 [INF] pgmap v1787: 4032 pgs: 4032
active+clean; 16398 MB data, 33154 MB used, 18588 GB / 18621 GB avail
2013-01-16 09:02:21.349814 mon.0 [INF] pgmap v1788: 4032 pgs: 4032
active+clean; 16593 MB data, 33637 MB used, 18588 GB / 18621 GB avail
2013-01-16 09:02:24.344724 mon.0 [INF] pgmap v1789: 4032 pgs: 4032
active+clean; 16667 MB data, 33805 MB used, 18588 GB / 18621 GB avail
2013-01-16 09:02:25.349057 mon.0 [INF] pgmap v1790: 4032 pgs: 4032
active+clean; 17084 MB data, 34631 MB used, 18587 GB / 18621 GB avail
2013-01-16 09:02:26.353304 mon.0 [INF] pgmap v1791: 4032 pgs: 4032
active+clean; 17275 MB data, 35080 MB used, 18586 GB / 18621 GB avail
2013-01-16 09:02:29.348205 mon.0 [INF] pgmap v1792: 4032 pgs: 4032
active+clean; 17341 MB data, 35189 MB used, 18586 GB / 18621 GB avail

** first problem **

2013-01-16 09:02:29.715958 mon.0 [INF] osd.14 172.17.243.140:6803/3634
failed (3 reports from 1 peers after 31.002178 >= grace 22.087502)
2013-01-16 09:02:29.801928 mon.0 [INF] pgmap v1793: 4032 pgs: 3831
active+clean, 201 stale+active+clean; 17442 MB data, 35393 MB used,
18586 GB / 18621 GB avail
2013-01-16 09:02:40.957558 osd.14 [WRN] map e19 wrongly marked me down

** mmm... an osd goes down **
2013-01-16 09:02:29.802394 mon.0 [INF] osdmap e19: 20 osds: 19 up, 20 in
2013-01-16 09:02:30.809717 mon.0 [INF] pgmap v1794: 4032 pgs: 3831
active+clean, 201 stale+active+clean; 17667 MB data, 35866 MB used,
18586 GB / 18621 GB avail

** and up again **
2013-01-16 09:02:30.810339 mon.0 [INF] osdmap e20: 20 osds: 20 up, 20 in
2013-01-16 09:02:30.810515 mon.0 [INF] osd.14 172.17.243.140:6803/3634 boot
2013-01-16 09:02:31.806311 mon.0 [INF] pgmap v1795: 4032 pgs: 3831
active+clean, 201 stale+active+clean; 17667 MB data, 35866 MB used,
18586 GB / 18621 GB avail
2013-01-16 09:02:31.806435 mon.0 [INF] osdmap e21: 20 osds: 20 up, 20 in
2013-01-16 09:02:34.356824 mon.0 [INF] pgmap v1796: 4032 pgs: 3831
active+clean, 201 stale+active+clean; 17729 MB data, 35976 MB used,
18586 GB / 18621 GB avail
2013-01-16 09:02:35.370869 mon.0 [INF] pgmap v1797: 4032 pgs: 3831
active+clean, 201 stale+active+clean; 17974 MB data, 36399 MB used,
18585 GB / 18621 GB avail
2013-01-16 09:02:36.376036 mon.0 [INF] pgmap v1798: 4032 pgs: 3831
active+clean, 201 stale+active+clean; 18223 MB data, 36742 MB used,
18585 GB / 18621 GB avail
2013-01-16 09:02:37.385946 mon.0 [INF] pgmap v1799: 4032 pgs: 4032
active+clean; 18633 MB data, 37456 MB used, 18584 GB / 18621 GB avail
2013-01-16 09:02:39.352359 mon.0 [INF] pgmap v1800: 4032 pgs: 4032
active+clean; 18721 MB data, 37585 MB used, 18584 GB / 18621 GB avail
2013-01-16 09:02:40.356163 mon.0 [INF] pgmap v1801: 4032 pgs: 4032
active+clean; 18940 MB data, 38053 MB used, 18584 GB / 18621 GB avail
2013-01-16 09:02:41.359535 mon.0 [INF] pgmap v1802: 4032 pgs: 4032
active+clean; 19073 MB data, 38377 MB used, 18583 GB / 18621 GB avail

** what is this line stand for ? **
2013-01-16 09:02:41.719045 mon.0 [INF] osd.11 172.17.243.140:6800/3425
failed (3 reports from 2 peers after 22.000156 >= grace 20.000000)


2013-01-16 09:02:41.818483 mon.0 [INF] pgmap v1803: 4032 pgs: 2236
active+clean, 1796 stale+active+clean; 19275 MB data, 38859 MB used,
18583 GB / 18621 GB avail
2013-01-16 09:02:41.819489 mon.0 [INF] osdmap e22: 20 osds: 11 up, 20 in
2013-01-16 09:02:42.805527 mon.0 [INF] pgmap v1804: 4032 pgs: 2236
active+clean, 1796 stale+active+clean; 19275 MB data, 38859 MB used,
18583 GB / 18621 GB avail
2013-01-16 09:02:42.805698 mon.0 [INF] osdmap e23: 20 osds: 16 up, 20 in
2013-01-16 09:02:42.805955 mon.0 [INF] osd.7 172.17.243.139:6808/7341 boot
2013-01-16 09:02:42.806036 mon.0 [INF] osd.3 172.17.243.139:6804/6961 boot
2013-01-16 09:02:42.806126 mon.0 [INF] osd.18 172.17.243.140:6807/3889 boot
2013-01-16 09:02:42.806189 mon.0 [INF] osd.11 172.17.243.140:6800/3425 boot
2013-01-16 09:02:52.974678 osd.18 [WRN] map e22 wrongly marked me down
2013-01-16 09:02:42.806245 mon.0 [INF] osd.13 172.17.243.140:6802/3566 boot
2013-01-16 09:02:43.808634 mon.0 [INF] pgmap v1805: 4032 pgs: 2236
active+clean, 1796 stale+active+clean; 19275 MB data, 38859 MB used,
18583 GB / 18621 GB avail
2013-01-16 09:02:43.808756 mon.0 [INF] osdmap e24: 20 osds: 16 up, 20 in
2013-01-16 09:02:44.811869 mon.0 [INF] pgmap v1806: 4032 pgs: 2236
active+clean, 1796 stale+active+clean; 19275 MB data, 38859 MB used,
18583 GB / 18621 GB avail
2013-01-16 09:02:44.811985 mon.0 [INF] osdmap e25: 20 osds: 17 up, 20 in
2013-01-16 09:02:44.812009 mon.0 [INF] osd.12 172.17.243.140:6801/3498 boot
2013-01-16 09:02:45.815437 mon.0 [INF] pgmap v1807: 4032 pgs: 2236
active+clean, 1796 stale+active+clean; 19275 MB data, 38859 MB used,
18583 GB / 18621 GB avail
2013-01-16 09:02:45.815606 mon.0 [INF] osdmap e26: 20 osds: 17 up, 20 in
2013-01-16 09:02:46.818327 mon.0 [INF] pgmap v1808: 4032 pgs: 2236
active+clean, 1796 stale+active+clean; 19275 MB data, 38859 MB used,
18583 GB / 18621 GB avail
2013-01-16 09:02:41.820220 osd.3 [WRN] map e22 wrongly marked me down
2013-01-16 09:02:46.818505 mon.0 [INF] osdmap e27: 20 osds: 17 up, 20 in
2013-01-16 09:02:47.932055 mon.0 [INF] pgmap v1809: 4032 pgs: 2533
active+clean, 1358 stale+active+clean, 134 active+degraded, 7
active+recovering; 19376 MB data, 39095 MB used, 18582 GB / 18621 GB
avail; 397/19058 degraded (2.083%)
2013-01-16 09:02:46.821031 osd.5 [WRN] map e27 wrongly marked me down
2013-01-16 09:02:49.041444 mon.0 [INF] pgmap v1810: 4032 pgs: 2475
active+clean, 884 stale+active+clean, 659 active+degraded, 14
active+recovering; 19789 MB data, 39786 MB used, 18582 GB / 18621 GB
avail; 1669/19466 degraded (8.574%)
2013-01-16 09:02:49.074691 mon.0 [INF] pgmap v1811: 4032 pgs: 2475
active+clean, 884 stale+active+clean, 659 active+degraded, 14
active+recovering; 19789 MB data, 39786 MB used, 18582 GB / 18621 GB
avail; 1669/19466 degraded (8.574%)
2013-01-16 09:02:49.074826 mon.0 [INF] osdmap e28: 20 osds: 18 up, 20 in
2013-01-16 09:02:52.974664 osd.13 [WRN] map e22 wrongly marked me down
2013-01-16 09:02:41.820299 osd.7 [WRN] map e22 wrongly marked me down
2013-01-16 09:02:49.074886 mon.0 [INF] osd.5 172.17.243.139:6806/7101 boot
2013-01-16 09:02:50.079667 mon.0 [INF] pgmap v1812: 4032 pgs: 2462
active+clean, 863 stale+active+clean, 692 active+degraded, 15
active+recovering; 19846 MB data, 39866 MB used, 18582 GB / 18621 GB
avail; 1732/19520 degraded (8.873%)
2013-01-16 09:02:54.966850 osd.12 [WRN] map e24 wrongly marked me down
2013-01-16 09:02:50.080001 mon.0 [INF] osdmap e29: 20 osds: 18 up, 20 in
2013-01-16 09:02:51.093554 mon.0 [INF] pgmap v1813: 4032 pgs: 2544
active+clean, 551 stale+active+clean, 917 active+degraded, 20
active+recovering; 20155 MB data, 40541 MB used, 18581 GB / 18621 GB
avail; 2274/19814 degraded (11.477%)
2013-01-16 09:02:52.974918 osd.11 [WRN] map e22 wrongly marked me down
2013-01-16 09:02:52.094470 mon.0 [INF] pgmap v1814: 4032 pgs: 2722
active+clean, 324 stale+active+clean, 962 active+degraded, 24
active+recovering; 20225 MB data, 40701 MB used, 18581 GB / 18621 GB
avail; 2382/19882 degraded (11.981%)
2013-01-16 09:02:54.308171 mon.0 [INF] pgmap v1815: 4032 pgs: 2873
active+clean, 21 active+recovery_wait, 273 stale+active+clean, 837
active+degraded, 28 active+recovering; 20243 MB data, 40793 MB used,
18581 GB / 18621 GB avail; 2099/19902 degraded (10.547%)
2013-01-16 09:02:55.329441 mon.0 [INF] pgmap v1816: 4032 pgs: 3227
active+clean, 47 active+recovery_wait, 30 stale+active+clean, 687
active+degraded, 41 active+recovering; 20356 MB data, 41239 MB used,
18580 GB / 18621 GB avail; 1783/20000 degraded (8.915%)
2013-01-16 09:02:55.973588 mon.0 [INF] pgmap v1817: 4032 pgs: 3227
active+clean, 47 active+recovery_wait, 30 stale+active+clean, 687
active+degraded, 41 active+recovering; 20356 MB data, 41293 MB used,
18580 GB / 18621 GB avail; 1783/20000 degraded (8.915%)
2013-01-16 09:02:55.973792 mon.0 [INF] osdmap e30: 20 osds: 19 up, 20 in
2013-01-16 09:02:55.973814 mon.0 [INF] osd.10 172.17.243.139:6802/6739 boot
2013-01-16 09:02:56.974683 mon.0 [INF] pgmap v1818: 4032 pgs: 3227
active+clean, 47 active+recovery_wait, 30 stale+active+clean, 687
active+degraded, 41 active+recovering; 20356 MB data, 41293 MB used,
18580 GB / 18621 GB avail; 1783/20000 degraded (8.915%)
2013-01-16 09:02:56.974787 mon.0 [INF] osdmap e31: 20 osds: 19 up, 20 in
2013-01-16 09:02:57.979976 mon.0 [INF] pgmap v1819: 4032 pgs: 3227
active+clean, 47 active+recovery_wait, 30 stale+active+clean, 687
active+degraded, 41 active+recovering; 20356 MB data, 41289 MB used,
18580 GB / 18621 GB avail; 1783/20000 degraded (8.915%)
2013-01-16 09:02:59.309723 mon.0 [INF] pgmap v1820: 4032 pgs: 3227
active+clean, 41 active+recovery_wait, 30 stale+active+clean, 687
active+degraded, 47 active+recovering; 20356 MB data, 41349 MB used,
18580 GB / 18621 GB avail; 1783/20000 degraded (8.915%)
2013-01-16 09:02:59.726707 mon.0 [INF] pgmap v1821: 4032 pgs: 3227
active+clean, 41 active+recovery_wait, 30 stale+active+clean, 687
active+degraded, 47 active+recovering; 20356 MB data, 41349 MB used,
18580 GB / 18621 GB avail; 1783/20000 degraded (8.915%)
2013-01-16 09:02:59.726929 mon.0 [INF] osdmap e32: 20 osds: 20 up, 20 in
2013-01-16 09:02:59.726954 mon.0 [INF] osd.16 172.17.243.140:6805/3741 boot
2013-01-16 09:03:00.729711 mon.0 [INF] pgmap v1822: 4032 pgs: 3227
active+clean, 41 active+recovery_wait, 30 stale+active+clean, 687
active+degraded, 47 active+recovering; 20356 MB data, 41349 MB used,
18580 GB / 18621 GB avail; 1783/20000 degraded (8.915%)
2013-01-16 09:03:10.769474 osd.16 [WRN] map e31 wrongly marked me down
2013-01-16 09:03:00.729831 mon.0 [INF] osdmap e33: 20 osds: 20 up, 20 in
2013-01-16 09:03:01.744266 mon.0 [INF] pgmap v1823: 4032 pgs: 3332
active+clean, 62 active+recovery_wait, 30 stale+active+clean, 555
active+degraded, 53 active+recovering; 20356 MB data, 41349 MB used,
18580 GB / 18621 GB avail; 1509/20000 degraded (7.545%)
2013-01-16 09:03:02.747374 mon.0 [INF] pgmap v1824: 4032 pgs: 3390
active+clean, 72 active+recovery_wait, 30 stale+active+clean, 483
active+degraded, 57 active+recovering; 20356 MB data, 41347 MB used,
18580 GB / 18621 GB avail; 1333/20000 degraded (6.665%)
2013-01-16 09:02:55.863357 osd.10 [WRN] map e29 wrongly marked me down
2013-01-16 09:03:04.942985 mon.0 [INF] pgmap v1825: 4032 pgs: 3544
active+clean, 94 active+recovery_wait, 18 stale+active+clean, 309
active+degraded, 67 active+recovering; 20364 MB data, 41390 MB used,
18580 GB / 18621 GB avail; 967/20004 degraded (4.834%)
2013-01-16 09:03:05.958228 mon.0 [INF] pgmap v1826: 4032 pgs: 3808
active+clean, 144 active+recovery_wait, 80 active+recovering; 20370 MB
data, 41471 MB used, 18580 GB / 18621 GB avail; 358/20010 degraded
(1.789%)
2013-01-16 09:03:06.958733 mon.0 [INF] pgmap v1827: 4032 pgs: 3808
active+clean, 144 active+recovery_wait, 80 active+recovering; 20370 MB
data, 41470 MB used, 18580 GB / 18621 GB avail; 358/20010 degraded
(1.789%)
2013-01-16 09:03:15.693682 mon.0 [INF] pgmap v1828: 4032 pgs: 3808
active+clean, 144 active+recovery_wait, 80 active+recovering; 20370 MB
data, 41469 MB used, 18580 GB / 18621 GB avail; 357/20010 degraded
(1.784%)
2013-01-16 09:03:16.696846 mon.0 [INF] pgmap v1829: 4032 pgs: 3830
active+clean, 141 active+recovery_wait, 61 active+recovering; 20370 MB
data, 41468 MB used, 18580 GB / 18621 GB avail; 328/20010 degraded
(1.639%)
2013-01-16 09:03:17.699405 mon.0 [INF] pgmap v1830: 4032 pgs: 3845
active+clean, 140 active+recovery_wait, 47 active+recovering; 20370 MB
data, 41467 MB used, 18580 GB / 18621 GB avail; 299/20010 degraded
(1.494%)
2013-01-16 09:03:19.942892 mon.0 [INF] pgmap v1831: 4032 pgs: 3864
active+clean, 127 active+recovery_wait, 41 active+recovering; 20370 MB
data, 41475 MB used, 18580 GB / 18621 GB avail; 272/20010 degraded
(1.359%)
2013-01-16 09:03:20.946409 mon.0 [INF] pgmap v1832: 4032 pgs: 3907
active+clean, 108 active+recovery_wait, 17 active+recovering; 20370 MB
data, 41502 MB used, 18580 GB / 18621 GB avail; 188/20010 degraded
(0.940%)
2013-01-16 09:03:31.129874 mon.0 [INF] pgmap v1833: 4032 pgs: 3911
active+clean, 104 active+recovery_wait, 17 active+recovering; 20370 MB
data, 41502 MB used, 18580 GB / 18621 GB avail; 182/20010 degraded
(0.910%)
2013-01-16 09:03:32.131913 mon.0 [INF] pgmap v1834: 4032 pgs: 3923
active+clean, 93 active+recovery_wait, 16 active+recovering; 20370 MB
data, 41502 MB used, 18580 GB / 18621 GB avail; 162/20010 degraded
(0.810%)
2013-01-16 09:03:34.946845 mon.0 [INF] pgmap v1835: 4032 pgs: 3935
active+clean, 86 active+recovery_wait, 11 active+recovering; 20370 MB
data, 41523 MB used, 18580 GB / 18621 GB avail; 154/20010 degraded
(0.770%)
2013-01-16 09:03:35.949757 mon.0 [INF] pgmap v1836: 4032 pgs: 3942
active+clean, 81 active+recovery_wait, 9 active+recovering; 20370 MB
data, 41523 MB used, 18580 GB / 18621 GB avail; 144/20010 degraded
(0.720%)
2013-01-16 09:03:45.701697 mon.0 [INF] pgmap v1837: 4032 pgs: 3945
active+clean, 79 active+recovery_wait, 8 active+recovering; 20370 MB
data, 41527 MB used, 18580 GB / 18621 GB avail; 139/20010 degraded
(0.695%)
2013-01-16 09:03:46.704631 mon.0 [INF] pgmap v1838: 4032 pgs: 3953
active+clean, 74 active+recovery_wait, 5 active+recovering; 20370 MB
data, 41527 MB used, 18580 GB / 18621 GB avail; 130/20010 degraded
(0.650%)
2013-01-16 09:03:49.977023 mon.0 [INF] pgmap v1839: 4032 pgs: 3954
active+clean, 73 active+recovery_wait, 5 active+recovering; 20370 MB
data, 41527 MB used, 18580 GB / 18621 GB avail; 127/20010 degraded
(0.635%)
2013-01-16 09:03:50.979121 mon.0 [INF] pgmap v1840: 4032 pgs: 3962
active+clean, 67 active+recovery_wait, 3 active+recovering; 20370 MB
data, 41527 MB used, 18580 GB / 18621 GB avail; 114/20010 degraded
(0.570%)
2013-01-16 09:04:00.705699 mon.0 [INF] pgmap v1841: 4032 pgs: 3965
active+clean, 62 active+recovery_wait, 5 active+recovering; 20370 MB
data, 41535 MB used, 18580 GB / 18621 GB avail; 109/20010 degraded
(0.545%)
2013-01-16 09:04:01.709011 mon.0 [INF] pgmap v1842: 4032 pgs: 3974
active+clean, 53 active+recovery_wait, 5 active+recovering; 20370 MB
data, 41535 MB used, 18580 GB / 18621 GB avail; 91/20010 degraded
(0.455%)
2013-01-16 09:04:02.712028 mon.0 [INF] pgmap v1843: 4032 pgs: 3982
active+clean, 45 active+recovery_wait, 5 active+recovering; 20370 MB
data, 41535 MB used, 18580 GB / 18621 GB avail; 78/20010 degraded
(0.390%)
2013-01-16 09:04:05.420501 mon.0 [INF] pgmap v1844: 4032 pgs: 3988
active+clean, 39 active+recovery_wait, 5 active+recovering; 20370 MB
data, 41535 MB used, 18580 GB / 18621 GB avail; 59/20010 degraded
(0.295%)
2013-01-16 09:04:16.363577 mon.0 [INF] pgmap v1845: 4032 pgs: 3990
active+clean, 37 active+recovery_wait, 5 active+recovering; 20370 MB
data, 41535 MB used, 18580 GB / 18621 GB avail; 57/20010 degraded
(0.285%)
2013-01-16 09:04:19.956659 mon.0 [INF] pgmap v1846: 4032 pgs: 3991
active+clean, 36 active+recovery_wait, 5 active+recovering; 20370 MB
data, 41535 MB used, 18580 GB / 18621 GB avail; 55/20010 degraded
(0.275%)
2013-01-16 09:04:20.959748 mon.0 [INF] pgmap v1847: 4032 pgs: 4001
active+clean, 27 active+recovery_wait, 4 active+recovering; 20370 MB
data, 41574 MB used, 18580 GB / 18621 GB avail; 44/20010 degraded
(0.220%)
2013-01-16 09:04:32.004246 mon.0 [INF] pgmap v1848: 4032 pgs: 4009
active+clean, 19 active+recovery_wait, 4 active+recovering; 20370 MB
data, 41574 MB used, 18580 GB / 18621 GB avail; 29/20010 degraded
(0.145%)
2013-01-16 09:04:50.719753 mon.0 [INF] pgmap v1849: 4032 pgs: 4013
active+clean, 14 active+recovery_wait, 5 active+recovering; 20370 MB
data, 41576 MB used, 18580 GB / 18621 GB avail; 24/20010 degraded
(0.120%)
2013-01-16 09:04:51.722190 mon.0 [INF] pgmap v1850: 4032 pgs: 4019
active+clean, 8 active+recovery_wait, 5 active+recovering; 20370 MB
data, 41576 MB used, 18580 GB / 18621 GB avail; 11/20010 degraded
(0.055%)
2013-01-16 09:05:05.721981 mon.0 [INF] pgmap v1851: 4032 pgs: 4024
active+clean, 5 active+recovery_wait, 3 active+recovering; 20370 MB
data, 41578 MB used, 18580 GB / 18621 GB avail; 6/20010 degraded
(0.030%)

** ok, cluster is now OK again **
2013-01-16 09:05:20.725478 mon.0 [INF] pgmap v1852: 4032 pgs: 4032
active+clean; 20370 MB data, 41578 MB used, 18580 GB / 18621 GB avail
2013-01-16 09:06:19.980664 mon.0 [INF] pgmap v1853: 4032 pgs: 4032
active+clean; 20370 MB data, 41592 MB used, 18580 GB / 18621 GB avail



Now, logs on an OSD who crashed :
===========================

** OSD accept client connection **
2013-01-16 08:56:23.435601 7f22c7dfd700  0 -- 172.17.243.139:6809/7411
>> 172.17.243.180:0/325477521 pipe(0x7f21e00008c0 sd=67 :6809 pgs=0
cs=0 l=0).accept peer addr is really 172.17.243.180:0/325477521
(socket is 172.17.243.180:53990/0)

2013-01-16 08:56:23.766078 7f22c54d4700  0 -- 172.17.243.39:6817/7411
>> 172.17.243.40:6812/3838 pipe(0x7f21b00033b0 sd=68 :6817 pgs=0 cs=0
l=0).accept connect_seq 4 vs existing 3 state standby
2013-01-16 08:56:24.380420 7f22cd1f4700  0 -- 172.17.243.39:6817/7411
>> 172.17.243.40:6804/3566 pipe(0x7f21b0002f10 sd=45 :6817 pgs=0 cs=0
l=0).accept connect_seq 4 vs existing 3 state standby
2013-01-16 08:56:24.467310 7f22ccdf0700  0 -- 172.17.243.39:6817/7411
>> 172.17.243.40:6816/3947 pipe(0x7f21b0001060 sd=31 :6817 pgs=0 cs=0
l=0).accept connect_seq 4 vs existing 3 state standby
2013-01-16 08:56:26.162884 7f22cc5e8700  0 -- 172.17.243.39:6817/7411
>> 172.17.243.40:6800/3425 pipe(0x7f21b0002820 sd=34 :6817 pgs=0 cs=0
l=0).accept connect_seq 4 vs existing 3 state standby
2013-01-16 08:57:38.137387 7f22c54d4700  0 -- 172.17.243.39:6817/7411
>> 172.17.243.40:6812/3838 pipe(0x7f21b00033b0 sd=68 :6817 pgs=23 cs=5
l=0).fault with nothing to send, going to standby
2013-01-16 08:57:38.137415 7f22c7bfb700  0 -- 172.17.243.39:6817/7411
>> 172.17.243.40:6820/3498 pipe(0x7f21b0003160 sd=30 :6817 pgs=38 cs=1
l=0).fault with nothing to send, going to standby

** mm.. problem **
2013-01-16 08:57:38.137519 7f22da7fc700  0 log [WRN] : map e14 wrongly
marked me down

2013-01-16 09:00:40.785736 7f22c7dfd700  0 -- 172.17.243.139:6809/7411
>> 172.17.243.180:0/325477521 pipe(0x7f21e00008c0 sd=57 :6809 pgs=0
cs=0 l=0).accept peer addr is really 172.17.243.180:0/325477521
(socket is 172.17.243.180:54061/0)
2013-01-16 09:02:29.803361 7f22d45ee700  0 -- 172.17.243.39:6821/7411
>> 172.17.243.40:6818/3634 pipe(0x7f21b8001dd0 sd=55 :6821 pgs=40 cs=1
l=0).fault with nothing to send, going to standby
2013-01-16 09:02:29.805155 7f22cd7fa700  0 -- 172.17.243.39:0/7411 >>
172.17.243.40:6819/3634 pipe(0x7f21482bba40 sd=56 :0 pgs=0 cs=0
l=1).fault

** big problem ? **
2013-01-16 09:02:30.849557 7f22c7dfd700  0 -- 172.17.243.139:6809/7411
>> 172.17.243.180:0/325477521 pipe(0x7f21e00008c0 sd=57 :6809 pgs=41
cs=1 l=1).reader got 128 + 0 + 2097152 byte message.. ABORTED

2013-01-16 09:02:30.849585 7f22c7dfd700  0 -- 172.17.243.139:6809/7411
>> 172.17.243.180:0/325477521 pipe(0x7f21e00008c0 sd=57 :6809 pgs=41
cs=1 l=1).reader bad tag 0
2013-01-16 09:02:30.851438 7f22c7dfd700  0 -- 172.17.243.139:6809/7411
>> 172.17.243.180:0/325477521 pipe(0x7f21e00008c0 sd=56 :6809 pgs=0
cs=0 l=0).accept peer addr is really 172.17.243.180:0/325477521
(socket is 172.17.243.180:54083/0)
2013-01-16 09:02:31.214491 7f22d5ff3700  0 -- 172.17.243.139:6809/7411
submit_message osd_op_reply(17382 10000000009.000005a0 [write
8192~2097152] ondisk = 0) v4 remote, 172.17.243.180:0/325477521,
failed lossy con, dropping message 0x7f22b85b59b0
2013-01-16 09:02:41.821988 7f22c78f8700  0 -- 172.17.243.39:6821/7411
>> 172.17.243.40:6800/3425 pipe(0x7f22b8073ac0 sd=28 :60758 pgs=32
cs=1 l=0).fault with nothing to send, going to standby
2013-01-16 09:02:41.825431 7f22c7fff700  0 -- 172.17.243.39:6821/7411
>> 172.17.243.40:6814/3889 pipe(0x7f22b801df10 sd=29 :53568 pgs=32
cs=1 l=0).fault, initiating reconnect
2013-01-16 09:02:41.826937 7f2143fff700  0 -- 172.17.243.39:6821/7411
>> 172.17.243.40:6814/3889 pipe(0x7f22b801df10 sd=29 :53568 pgs=32
cs=2 l=0).fault
2013-01-16 09:02:41.830376 7f22c5ede700  0 -- 172.17.243.39:0/7411 >>
172.17.243.40:6805/3566 pipe(0x7f2148329e30 sd=41 :0 pgs=0 cs=0
l=1).fault
2013-01-16 09:02:42.826058 7f22ccaed700  0 -- 172.17.243.39:6821/7411
>> 172.17.243.40:6823/3425 pipe(0x7f21b80024c0 sd=47 :6821 pgs=0 cs=0
l=0).accept connect_seq 0 vs existing 0 state wait



On the MDS log, nothing strange, only "normal" operations.



With all this information, do you have new ideas ?

Furthermore, do you have any ETA for CephFS become stable ?
I love the concept, but... well, note stable enough yet to be
production ready :(

Thanks a lot
