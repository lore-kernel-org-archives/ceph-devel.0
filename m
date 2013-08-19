From: Mostowiec Dominik <Dominik.Mostowiec@grupaonet.pl>
Subject: RE: [ceph-users] large memory leak on scrubbing
Date: Tue, 20 Aug 2013 00:01:20 +0200
Message-ID: <ADBDB4FFB0814748AF32D0A1EE6E10AF228322C9EF@MXMBON06.grupa.onet>
References: <ADBDB4FFB0814748AF32D0A1EE6E10AF228322C75B@MXMBON06.grupa.onet>
 <alpine.DEB.2.00.1308170808070.1479@cobra.newdream.net>
 <ADBDB4FFB0814748AF32D0A1EE6E10AF228322C852@MXMBON06.grupa.onet>
 <alpine.DEB.2.00.1308190853590.11018@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from onsmg02.portal.onet.pl ([213.180.131.212]:47408 "EHLO
	onsmg02.portal.onet.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183Ab3HSWBZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Aug 2013 18:01:25 -0400
In-Reply-To: <alpine.DEB.2.00.1308190853590.11018@cobra.newdream.net>
Content-Language: pl-PL
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, =?iso-8859-2?Q?Studzi=F1ski_Krzysztof?= <krzysztof.studzinski@grupaonet.pl>, Sydor Bohdan <Bohdan.Sydor@grupaonet.pl>

Hi,
> Is that the only slow request message you see?
No.
Full log: https://www.dropbox.com/s/i3ep5dcimndwvj1/slow_requests.txt.tar.gz 
It start from:
2013-08-16 09:43:39.662878 mon.0 10.174.81.132:6788/0 4276384 : [DBG] osd.4 10.174.81.131:6805/31460 reported failed by osd.50 10.174.81.135:6842/26019
2013-08-16 09:43:40.711911 mon.0 10.174.81.132:6788/0 4276386 : [DBG] osd.4 10.174.81.131:6805/31460 reported failed by osd.14 10.174.81.132:6836/2958
2013-08-16 09:43:41.043016 mon.0 10.174.81.132:6788/0 4276388 : [DBG] osd.4 10.174.81.131:6805/31460 reported failed by osd.13 10.174.81.132:6830/2482
2013-08-16 09:43:41.043047 mon.0 10.174.81.132:6788/0 4276389 : [INF] osd.4 10.174.81.131:6805/31460 failed (3 reports from 3 peers after 2013-08-16 09:43:56.042983 >= grace 20.000000)
2013-08-16 09:43:41.122326 mon.0 10.174.81.132:6788/0 4276390 : [INF] osdmap e10294: 144 osds: 143 up, 143 in
2013-08-16 09:43:38.798833 osd.4 10.174.81.131:6805/31460 913 : [WRN] 6 slow requests, 6 included below; oldest blocked for > 30.190146 secs
2013-08-16 09:43:38.798843 osd.4 10.174.81.131:6805/31460 914 : [WRN] slow request 30.190146 seconds old, received at 2013-08-16 09:43:08.585504: osd_op(client.22301645.0:48987 .dir.1585245.1 [call rgw.bucket_complete_op] 16.33d5ea80) v4 currently waiting for subops from [25,133]
2013-08-16 09:43:38.798854 osd.4 10.174.81.131:6805/31460 915 : [WRN] slow request 30.189643 seconds old, received at 2013-08-16 09:43:08.586007: osd_op(client.22301855.0:49374 .dir.1585245.1 [call rgw.bucket_complete_op] 16.33d5ea80) v4 currently waiting for subops from [25,133]
2013-08-16 09:43:38.798859 osd.4 10.174.81.131:6805/31460 916 : [WRN] slow request 30.188236 seconds old, received at 2013-08-16 09:43:08.587414: osd_op(client.22307596.0:47674 .dir.1585245.1 [call rgw.bucket_complete_op] 16.33d5ea80) v4 currently waiting for subops from [25,133]
2013-08-16 09:43:38.798862 osd.4 10.174.81.131:6805/31460 917 : [WRN] slow request 30.187853 seconds old, received at 2013-08-16 09:43:08.587797: osd_op(client.22303894.0:51846 .dir.1585245.1 [call rgw.bucket_complete_op] 16.33d5ea80) v4 currently waiting for subops from [25,133]
...
2013-08-16 09:44:18.126318 mon.0 10.174.81.132:6788/0 4276427 : [INF] osd.4 10.174.81.131:6805/31460 boot
...
2013-08-16 09:44:23.215918 mon.0 10.174.81.132:6788/0 4276437 : [DBG] osd.25 10.174.81.133:6810/2961 reported failed by osd.83 10.174.81.137:6837/27963
2013-08-16 09:44:23.704769 mon.0 10.174.81.132:6788/0 4276438 : [INF] pgmap v17035051: 32424 pgs: 1 stale+active+clean+scrubbing+deep, 2 active, 31965 active+clean, 7 stale+active+clean, 29 peering, 415 active+degraded, 5 active+clean+scrubbing; 6630 GB data, 21420 GB used, 371 TB / 392 TB avail; 246065/61089697 degraded (0.403%)
2013-08-16 09:44:23.711244 mon.0 10.174.81.132:6788/0 4276439 : [DBG] osd.133 10.174.81.142:6803/21366 reported failed by osd.26 10.174.81.133:6814/3674
2013-08-16 09:44:23.713597 mon.0 10.174.81.132:6788/0 4276440 : [DBG] osd.133 10.174.81.142:6803/21366 reported failed by osd.17 10.174.81.132:6806/9188
2013-08-16 09:44:23.753952 mon.0 10.174.81.132:6788/0 4276441 : [DBG] osd.133 10.174.81.142:6803/21366 reported failed by osd.27 10.174.81.133:6822/5389
2013-08-16 09:44:23.753982 mon.0 10.174.81.132:6788/0 4276442 : [INF] osd.133 10.174.81.142:6803/21366 failed (3 reports from 3 peers after 2013-08-16 09:44:38.753913 >= grace 20.000000)
....

2013-08-16 09:47:10.229099 mon.0 10.174.81.132:6788/0 4276646 : [INF] pgmap v17035216: 32424 pgs: 32424 active+clean; 6630 GB data, 21420 GB used, 371 TB / 392 TB avail; 0B/s rd, 622KB/s wr, 85op/s

Why osd's are 'reported failed' on scrubbing?

--
Regards 
Dominik 
