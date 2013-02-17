From: Chris Dunlop <chris@onthe.net.au>
Subject: Re: Mon losing touch with OSDs
Date: Mon, 18 Feb 2013 10:41:07 +1100
Message-ID: <20130217234107.GA19416@onthe.net.au>
References: <20130215032939.GA25578@onthe.net.au>
 <alpine.DEB.2.00.1302142051250.19927@cobra.newdream.net>
 <20130215220521.GA29999@onthe.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:33345 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754475Ab3BQXlM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 17 Feb 2013 18:41:12 -0500
Content-Disposition: inline
In-Reply-To: <20130215220521.GA29999@onthe.net.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

G'day Sage,

On Sat, Feb 16, 2013 at 09:05:21AM +1100, Chris Dunlop wrote:
> On Thu, Feb 14, 2013 at 08:57:11PM -0800, Sage Weil wrote:
>> On Fri, 15 Feb 2013, Chris Dunlop wrote:
>>> In an otherwise seemingly healthy cluster (ceph 0.56.2), what might cause the
>>> mons to lose touch with the osds?
>> 
>> Can you enable 'debug ms = 1' on the mons and leave them that way, in the 
>> hopes that this happens again?  It will give us more information to go on.
> 
> Debug turned on.

We haven't experienced the cluster losing touch with the osds completely
since upgrading from 0.56.2 to 0.56.3, but we did lose touch with osd.1
for a few seconds before it recovered. See below for logs (reminder: 3
boxes, b2 is mon-only, b4 is mon+osd.0, b5 is mon+osd.1).

The osd.1 drop was associated with a bit of an write iops spike on the osd
disks (logs below, "w/s" column), although the logs also show plenty of
other similar spikes that haven't led to a drop.  ...oh, a closer look at
the timestamps shows the spike actually came after the drop, so it wasn't
the spike that caused the drop.

Cheers,

Chris

----------------------------------------------------------------------
ceph-osd.0.log
----------------------------------------------------------------------
2013-02-17 05:50:58.841310 7f108cf1b700  0 log [INF] : 2.44 scrub ok
2013-02-17 06:03:54.406730 7f108cf1b700  0 log [INF] : 2.51 scrub ok
2013-02-17 06:04:51.560283 7f109af37700 -1 osd.0 784 heartbeat_check: no reply from osd.1 since 2013-02-17 06:04:30.768700 (cutoff 2013-02-17 06:04:31.560283)
2013-02-17 06:04:51.769792 7f108bf19700 -1 osd.0 784 heartbeat_check: no reply from osd.1 since 2013-02-17 06:04:30.768700 (cutoff 2013-02-17 06:04:31.769792)
2013-02-17 06:04:52.565376 7f109af37700 -1 osd.0 784 heartbeat_check: no reply from osd.1 since 2013-02-17 06:04:30.768700 (cutoff 2013-02-17 06:04:32.565376)
2013-02-17 06:04:53.565629 7f109af37700 -1 osd.0 784 heartbeat_check: no reply from osd.1 since 2013-02-17 06:04:30.768700 (cutoff 2013-02-17 06:04:33.565628)
2013-02-17 06:04:54.565813 7f109af37700 -1 osd.0 784 heartbeat_check: no reply from osd.1 since 2013-02-17 06:04:30.768700 (cutoff 2013-02-17 06:04:34.565812)
2013-02-17 06:04:55.565906 7f109af37700 -1 osd.0 784 heartbeat_check: no reply from osd.1 since 2013-02-17 06:04:30.768700 (cutoff 2013-02-17 06:04:35.565905)
2013-02-17 06:04:55.870011 7f108bf19700 -1 osd.0 784 heartbeat_check: no reply from osd.1 since 2013-02-17 06:04:30.768700 (cutoff 2013-02-17 06:04:35.870011)
2013-02-17 06:04:56.566030 7f109af37700 -1 osd.0 784 heartbeat_check: no reply from osd.1 since 2013-02-17 06:04:30.768700 (cutoff 2013-02-17 06:04:36.566029)
2013-02-17 06:04:57.566227 7f109af37700 -1 osd.0 784 heartbeat_check: no reply from osd.1 since 2013-02-17 06:04:30.768700 (cutoff 2013-02-17 06:04:37.566227)
2013-02-17 06:04:57.570184 7f108bf19700 -1 osd.0 784 heartbeat_check: no reply from osd.1 since 2013-02-17 06:04:30.768700 (cutoff 2013-02-17 06:04:37.570184)
2013-02-17 06:04:58.070400 7f108bf19700 -1 osd.0 784 heartbeat_check: no reply from osd.1 since 2013-02-17 06:04:30.768700 (cutoff 2013-02-17 06:04:38.070399)
2013-02-17 06:04:58.566489 7f109af37700 -1 osd.0 784 heartbeat_check: no reply from osd.1 since 2013-02-17 06:04:30.768700 (cutoff 2013-02-17 06:04:38.566489)
2013-02-17 06:04:59.566631 7f109af37700 -1 osd.0 784 heartbeat_check: no reply from osd.1 since 2013-02-17 06:04:30.768700 (cutoff 2013-02-17 06:04:39.566630)
2013-02-17 06:05:00.566728 7f109af37700 -1 osd.0 784 heartbeat_check: no reply from osd.1 since 2013-02-17 06:04:30.768700 (cutoff 2013-02-17 06:04:40.566728)
2013-02-17 06:05:01.566848 7f109af37700 -1 osd.0 784 heartbeat_check: no reply from osd.1 since 2013-02-17 06:04:30.768700 (cutoff 2013-02-17 06:04:41.566847)
2013-02-17 06:05:02.170643 7f108bf19700 -1 osd.0 784 heartbeat_check: no reply from osd.1 since 2013-02-17 06:04:30.768700 (cutoff 2013-02-17 06:04:42.170643)
2013-02-17 06:05:02.566961 7f109af37700 -1 osd.0 784 heartbeat_check: no reply from osd.1 since 2013-02-17 06:04:30.768700 (cutoff 2013-02-17 06:04:42.566960)
2013-02-17 06:05:04.880523 7f108a514700  0 -- 192.168.254.132:6802/18444 >> 192.168.254.133:6800/21178 pipe(0xac42a00 sd=31 :6802 s=2 pgs=19 cs=3 l=0).fault, initiating reconnect
2013-02-17 06:05:04.880977 7f108a615700  0 -- 192.168.254.132:6802/18444 >> 192.168.254.133:6800/21178 pipe(0xac42a00 sd=31 :6802 s=1 pgs=19 cs=4 l=0).fault
2013-02-17 06:18:52.354800 7f108cf1b700  0 log [INF] : 2.4e scrub ok
2013-02-17 06:22:12.410074 7f108cf1b700  0 log [INF] : 2.53 scrub ok

----------------------------------------------------------------------
ceph-osd.1.log
----------------------------------------------------------------------
2013-02-17 06:00:25.752991 7f5647f2c700  0 log [INF] : 2.a6 scrub ok
2013-02-17 06:01:59.282661 7f5647f2c700  0 log [INF] : 2.b0 scrub ok
2013-02-17 06:05:02.873412 7f5645525700  0 -- 192.168.254.133:6800/21178 >> 192.168.254.132:6802/18444 pipe(0x1e50c80 sd=38 :6800 s=2 pgs=1 cs=1 l=0).fault, initiating reconnect
2013-02-17 06:05:02.873463 7f5645323700  0 -- 192.168.254.133:6800/21178 >> 192.168.254.132:6802/18444 pipe(0x1e50c80 sd=38 :6800 s=1 pgs=1 cs=2 l=0).fault
2013-02-17 06:05:04.541062 7f5645525700  0 -- 192.168.254.133:6800/21178 >> 192.168.254.132:6802/18444 pipe(0x1e50c80 sd=31 :45391 s=2 pgs=2 cs=3 l=0).reader got old message 1 <= 2344847 0xa662c00 osd_map(785..786 src has 541..786) v3, discarding
2013-02-17 06:05:04.541113 7f5645525700  0 -- 192.168.254.133:6800/21178 >> 192.168.254.132:6802/18444 pipe(0x1e50c80 sd=31 :45391 s=2 pgs=2 cs=3 l=0).reader got old message 2 <= 2344847 0xa662c00 osd_map(785..786 src has 541..786) v3, discarding
2013-02-17 06:05:04.880116 7f564df38700  0 log [WRN] : map e786 wrongly marked me down
2013-02-17 06:19:13.397843 7f5647f2c700  0 log [INF] : 2.aa scrub ok
2013-02-17 06:21:05.506977 7f5647f2c700  0 log [INF] : 2.ba scrub ok

----------------------------------------------------------------------
ceph.log
----------------------------------------------------------------------
2013-02-17 06:04:45.031719 mon.0 10.200.63.130:6789/0 19956 : [INF] pgmap v2900128: 576 pgs: 575 active+clean, 1 active+clean+scrubbing; 407 GB data, 836 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:04:47.732814 mon.0 10.200.63.130:6789/0 19957 : [INF] pgmap v2900129: 576 pgs: 575 active+clean, 1 active+clean+scrubbing; 407 GB data, 836 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:04:50.046404 mon.0 10.200.63.130:6789/0 19958 : [INF] pgmap v2900130: 576 pgs: 575 active+clean, 1 active+clean+scrubbing; 407 GB data, 836 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:04:52.579862 mon.0 10.200.63.130:6789/0 19959 : [DBG] osd.1 10.200.63.133:6801/21178 reported failed by osd.0 10.200.63.132:6801/18444
2013-02-17 06:04:52.812732 mon.0 10.200.63.130:6789/0 19960 : [INF] pgmap v2900131: 576 pgs: 575 active+clean, 1 active+clean+scrubbing; 407 GB data, 836 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:04:55.026841 mon.0 10.200.63.130:6789/0 19961 : [INF] pgmap v2900132: 576 pgs: 575 active+clean, 1 active+clean+scrubbing; 407 GB data, 836 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:04:57.567496 mon.0 10.200.63.130:6789/0 19962 : [DBG] osd.1 10.200.63.133:6801/21178 reported failed by osd.0 10.200.63.132:6801/18444
2013-02-17 06:04:57.773216 mon.0 10.200.63.130:6789/0 19963 : [INF] pgmap v2900133: 576 pgs: 575 active+clean, 1 active+clean+scrubbing; 407 GB data, 836 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:05:00.043065 mon.0 10.200.63.130:6789/0 19964 : [INF] pgmap v2900134: 576 pgs: 575 active+clean, 1 active+clean+scrubbing; 407 GB data, 836 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:05:02.567938 mon.0 10.200.63.130:6789/0 19965 : [DBG] osd.1 10.200.63.133:6801/21178 reported failed by osd.0 10.200.63.132:6801/18444
2013-02-17 06:05:02.567989 mon.0 10.200.63.130:6789/0 19966 : [INF] osd.1 10.200.63.133:6801/21178 failed (3 reports from 1 peers after 2013-02-17 06:05:23.567928 >= grace 20.000021)
2013-02-17 06:05:02.787622 mon.0 10.200.63.130:6789/0 19967 : [INF] osdmap e785: 2 osds: 1 up, 2 in
2013-02-17 06:05:02.891325 mon.0 10.200.63.130:6789/0 19968 : [INF] pgmap v2900135: 576 pgs: 575 active+clean, 1 active+clean+scrubbing; 407 GB data, 836 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:05:03.355214 mon.0 10.200.63.130:6789/0 19969 : [INF] pgmap v2900136: 576 pgs: 271 active+clean, 304 stale+active+clean, 1 active+clean+scrubbing; 407 GB data, 836 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:05:03.884400 mon.0 10.200.63.130:6789/0 19970 : [INF] osdmap e786: 2 osds: 1 up, 2 in
2013-02-17 06:05:04.057756 mon.0 10.200.63.130:6789/0 19971 : [INF] pgmap v2900137: 576 pgs: 271 active+clean, 304 stale+active+clean, 1 active+clean+scrubbing; 407 GB data, 836 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:05:05.921247 mon.0 10.200.63.130:6789/0 19972 : [INF] osdmap e787: 2 osds: 2 up, 2 in
2013-02-17 06:05:05.921306 mon.0 10.200.63.130:6789/0 19973 : [INF] osd.1 10.200.63.133:6801/21178 boot
2013-02-17 06:05:06.022361 mon.0 10.200.63.130:6789/0 19974 : [INF] pgmap v2900138: 576 pgs: 271 active+clean, 304 stale+active+clean, 1 active+clean+scrubbing; 407 GB data, 836 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:05:06.983262 mon.0 10.200.63.130:6789/0 19975 : [INF] osdmap e788: 2 osds: 2 up, 2 in
2013-02-17 06:05:07.103855 mon.0 10.200.63.130:6789/0 19976 : [INF] pgmap v2900139: 576 pgs: 271 active+clean, 304 stale+active+clean, 1 active+clean+scrubbing; 407 GB data, 836 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:05:08.085143 mon.0 10.200.63.130:6789/0 19977 : [INF] osdmap e789: 2 osds: 2 up, 2 in
2013-02-17 06:05:08.201700 mon.0 10.200.63.130:6789/0 19978 : [INF] pgmap v2900140: 576 pgs: 271 active+clean, 304 stale+active+clean, 1 active+clean+scrubbing; 407 GB data, 836 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:05:12.100060 mon.0 10.200.63.130:6789/0 19979 : [INF] pgmap v2900141: 576 pgs: 259 active, 271 active+clean, 45 peering, 1 active+clean+scrubbing; 407 GB data, 836 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:05:13.196692 mon.0 10.200.63.130:6789/0 19980 : [INF] pgmap v2900142: 576 pgs: 467 active, 109 peering; 407 GB data, 835 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:05:04.880125 osd.1 10.200.63.133:6801/21178 292 : [WRN] map e786 wrongly marked me down
2013-02-17 06:05:17.088685 mon.0 10.200.63.130:6789/0 19981 : [INF] pgmap v2900143: 576 pgs: 479 active, 32 active+clean, 65 peering; 407 GB data, 835 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:05:18.229214 mon.0 10.200.63.130:6789/0 19982 : [INF] pgmap v2900144: 576 pgs: 469 active, 105 active+clean, 2 peering; 407 GB data, 835 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:05:22.702406 mon.0 10.200.63.130:6789/0 19983 : [INF] pgmap v2900145: 576 pgs: 198 active, 376 active+clean, 1 peering, 1 active+recovering; 407 GB data, 835 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:05:23.795151 mon.0 10.200.63.130:6789/0 19984 : [INF] pgmap v2900146: 576 pgs: 574 active+clean, 1 active+recovery_wait, 1 active+recovering; 407 GB data, 835 GB used, 2889 GB / 3724 GB avail; 1/211684 degraded (0.000%)
2013-02-17 06:05:27.689766 mon.0 10.200.63.130:6789/0 19985 : [INF] pgmap v2900147: 576 pgs: 575 active+clean, 1 active+recovery_wait; 407 GB data, 835 GB used, 2889 GB / 3724 GB avail; 1/211684 degraded (0.000%)
2013-02-17 06:05:28.798006 mon.0 10.200.63.130:6789/0 19986 : [INF] pgmap v2900148: 576 pgs: 576 active+clean; 407 GB data, 835 GB used, 2889 GB / 3724 GB avail
2013-02-17 06:05:32.688719 mon.0 10.200.63.130:6789/0 19987 : [INF] pgmap v2900149: 576 pgs: 576 active+clean; 407 GB data, 835 GB used, 2889 GB / 3724 GB avail
2013-02-17 06:05:33.764091 mon.0 10.200.63.130:6789/0 19988 : [INF] pgmap v2900150: 576 pgs: 576 active+clean; 407 GB data, 835 GB used, 2889 GB / 3724 GB avail

----------------------------------------------------------------------
ceph-mon.b2.log
----------------------------------------------------------------------
2013-02-17 06:04:40.032792 7fb315ca2700  0 log [INF] : pgmap v2900126: 576 pgs: 575 active+clean, 1 active+clean+scrubbing; 407 GB data, 836 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:04:42.733647 7fb315ca2700  0 log [INF] : pgmap v2900127: 576 pgs: 575 active+clean, 1 active+clean+scrubbing; 407 GB data, 836 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:04:45.031710 7fb315ca2700  0 log [INF] : pgmap v2900128: 576 pgs: 575 active+clean, 1 active+clean+scrubbing; 407 GB data, 836 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:04:47.732805 7fb315ca2700  0 log [INF] : pgmap v2900129: 576 pgs: 575 active+clean, 1 active+clean+scrubbing; 407 GB data, 836 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:04:50.046400 7fb315ca2700  0 log [INF] : pgmap v2900130: 576 pgs: 575 active+clean, 1 active+clean+scrubbing; 407 GB data, 836 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:04:52.577640 7fb315ca2700  1 mon.b2@0(leader).osd e784 prepare_failure osd.1 10.200.63.133:6801/21178 from osd.0 10.200.63.132:6801/18444 is reporting failure:1
2013-02-17 06:04:52.579842 7fb315ca2700  0 log [DBG] : osd.1 10.200.63.133:6801/21178 reported failed by osd.0 10.200.63.132:6801/18444
2013-02-17 06:04:52.812722 7fb315ca2700  0 log [INF] : pgmap v2900131: 576 pgs: 575 active+clean, 1 active+clean+scrubbing; 407 GB data, 836 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:04:55.026832 7fb315ca2700  0 log [INF] : pgmap v2900132: 576 pgs: 575 active+clean, 1 active+clean+scrubbing; 407 GB data, 836 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:04:57.567460 7fb315ca2700  1 mon.b2@0(leader).osd e784 prepare_failure osd.1 10.200.63.133:6801/21178 from osd.0 10.200.63.132:6801/18444 is reporting failure:1
2013-02-17 06:04:57.567493 7fb315ca2700  0 log [DBG] : osd.1 10.200.63.133:6801/21178 reported failed by osd.0 10.200.63.132:6801/18444
2013-02-17 06:04:57.773210 7fb315ca2700  0 log [INF] : pgmap v2900133: 576 pgs: 575 active+clean, 1 active+clean+scrubbing; 407 GB data, 836 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:05:00.043056 7fb315ca2700  0 log [INF] : pgmap v2900134: 576 pgs: 575 active+clean, 1 active+clean+scrubbing; 407 GB data, 836 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:05:02.567921 7fb315ca2700  1 mon.b2@0(leader).osd e784 prepare_failure osd.1 10.200.63.133:6801/21178 from osd.0 10.200.63.132:6801/18444 is reporting failure:1
2013-02-17 06:05:02.567937 7fb315ca2700  0 log [DBG] : osd.1 10.200.63.133:6801/21178 reported failed by osd.0 10.200.63.132:6801/18444
2013-02-17 06:05:02.567974 7fb315ca2700  1 mon.b2@0(leader).osd e784  we have enough reports/reporters to mark osd.1 down
2013-02-17 06:05:02.567987 7fb315ca2700  0 log [INF] : osd.1 10.200.63.133:6801/21178 failed (3 reports from 1 peers after 2013-02-17 06:05:23.567928 >= grace 20.000021)
2013-02-17 06:05:02.772787 7fb315ca2700  1 mon.b2@0(leader).osd e785 e785: 2 osds: 1 up, 2 in
2013-02-17 06:05:02.787619 7fb315ca2700  0 log [INF] : osdmap e785: 2 osds: 1 up, 2 in
2013-02-17 06:05:02.891321 7fb315ca2700  0 log [INF] : pgmap v2900135: 576 pgs: 575 active+clean, 1 active+clean+scrubbing; 407 GB data, 836 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:05:03.355205 7fb315ca2700  0 log [INF] : pgmap v2900136: 576 pgs: 271 active+clean, 304 stale+active+clean, 1 active+clean+scrubbing; 407 GB data, 836 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:05:03.847394 7fb315ca2700  1 mon.b2@0(leader).osd e786 e786: 2 osds: 1 up, 2 in
2013-02-17 06:05:03.884395 7fb315ca2700  0 log [INF] : osdmap e786: 2 osds: 1 up, 2 in
2013-02-17 06:05:04.057750 7fb315ca2700  0 log [INF] : pgmap v2900137: 576 pgs: 271 active+clean, 304 stale+active+clean, 1 active+clean+scrubbing; 407 GB data, 836 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:05:04.869787 7fb315ca2700  1 mon.b2@0(leader).pg v2900137  ignoring stats from non-active osd.
2013-02-17 06:05:05.884371 7fb315ca2700  1 mon.b2@0(leader).osd e787 e787: 2 osds: 2 up, 2 in
2013-02-17 06:05:05.921244 7fb315ca2700  0 log [INF] : osdmap e787: 2 osds: 2 up, 2 in
2013-02-17 06:05:05.921303 7fb315ca2700  0 log [INF] : osd.1 10.200.63.133:6801/21178 boot
2013-02-17 06:05:06.022350 7fb315ca2700  0 log [INF] : pgmap v2900138: 576 pgs: 271 active+clean, 304 stale+active+clean, 1 active+clean+scrubbing; 407 GB data, 836 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:05:06.946150 7fb315ca2700  1 mon.b2@0(leader).osd e788 e788: 2 osds: 2 up, 2 in
2013-02-17 06:05:06.983256 7fb315ca2700  0 log [INF] : osdmap e788: 2 osds: 2 up, 2 in
2013-02-17 06:05:07.103846 7fb315ca2700  0 log [INF] : pgmap v2900139: 576 pgs: 271 active+clean, 304 stale+active+clean, 1 active+clean+scrubbing; 407 GB data, 836 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:05:08.048069 7fb315ca2700  1 mon.b2@0(leader).osd e789 e789: 2 osds: 2 up, 2 in
2013-02-17 06:05:08.085140 7fb315ca2700  0 log [INF] : osdmap e789: 2 osds: 2 up, 2 in
2013-02-17 06:05:08.201692 7fb315ca2700  0 log [INF] : pgmap v2900140: 576 pgs: 271 active+clean, 304 stale+active+clean, 1 active+clean+scrubbing; 407 GB data, 836 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:05:12.100055 7fb315ca2700  0 log [INF] : pgmap v2900141: 576 pgs: 259 active, 271 active+clean, 45 peering, 1 active+clean+scrubbing; 407 GB data, 836 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:05:13.196685 7fb315ca2700  0 log [INF] : pgmap v2900142: 576 pgs: 467 active, 109 peering; 407 GB data, 835 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:05:17.088677 7fb315ca2700  0 log [INF] : pgmap v2900143: 576 pgs: 479 active, 32 active+clean, 65 peering; 407 GB data, 835 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:05:18.229204 7fb315ca2700  0 log [INF] : pgmap v2900144: 576 pgs: 469 active, 105 active+clean, 2 peering; 407 GB data, 835 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:05:22.702400 7fb315ca2700  0 log [INF] : pgmap v2900145: 576 pgs: 198 active, 376 active+clean, 1 peering, 1 active+recovering; 407 GB data, 835 GB used, 2888 GB / 3724 GB avail
2013-02-17 06:05:23.795142 7fb315ca2700  0 log [INF] : pgmap v2900146: 576 pgs: 574 active+clean, 1 active+recovery_wait, 1 active+recovering; 407 GB data, 835 GB used, 2889 GB / 3724 GB avail; 1/211684 degraded (0.000%)
2013-02-17 06:05:27.689761 7fb315ca2700  0 log [INF] : pgmap v2900147: 576 pgs: 575 active+clean, 1 active+recovery_wait; 407 GB data, 835 GB used, 2889 GB / 3724 GB avail; 1/211684 degraded (0.000%)
2013-02-17 06:05:28.797998 7fb315ca2700  0 log [INF] : pgmap v2900148: 576 pgs: 576 active+clean; 407 GB data, 835 GB used, 2889 GB / 3724 GB avail
2013-02-17 06:05:32.688713 7fb315ca2700  0 log [INF] : pgmap v2900149: 576 pgs: 576 active+clean; 407 GB data, 835 GB used, 2889 GB / 3724 GB avail
2013-02-17 06:05:33.764083 7fb315ca2700  0 log [INF] : pgmap v2900150: 576 pgs: 576 active+clean; 407 GB data, 835 GB used, 2889 GB / 3724 GB avail

----------------------------------------------------------------------
ceph-mon.b4.log
----------------------------------------------------------------------
2013-02-17 06:05:01.197587 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== mon.0 10.200.63.130:6789/0 197440 ==== paxos(auth lease lc 3461 fc 3441 pn 0 opn 0 gv {}) v2 ==== 88+0+0 (3474466732 0 0) 0x68998c0 con 0x2d189a0
2013-02-17 06:05:01.197626 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(auth lease_ack lc 3461 fc 3441 pn 0 opn 0 gv {}) v2 -- ?+0 0x1c636000
2013-02-17 06:05:01.560527 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== client.9965 10.200.63.132:0/2024602 550 ==== mon_subscribe({monmap=10+,osdmap=785}) v2 ==== 42+0+0 (601251667 0 0) 0x4fe9dc0 con 0x2ed8580
2013-02-17 06:05:01.560568 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> client.9965 10.200.63.132:0/2024602 -- mon_subscribe_ack(300s) v1 -- ?+0 0xccd71e0
2013-02-17 06:05:02.130295 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== mon.0 10.200.63.130:6789/0 197441 ==== paxos(osdmap lease lc 784 fc 541 pn 0 opn 0 gv {}) v2 ==== 88+0+0 (2329396769 0 0) 0x1c636000 con 0x2d189a0
2013-02-17 06:05:02.130339 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(osdmap lease_ack lc 784 fc 541 pn 0 opn 0 gv {}) v2 -- ?+0 0x68998c0
2013-02-17 06:05:02.130384 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== mon.0 10.200.63.130:6789/0 197442 ==== paxos(mdsmap lease lc 1 fc 1 pn 0 opn 0 gv {}) v2 ==== 88+0+0 (3718949626 0 0) 0x6899600 con 0x2d189a0
2013-02-17 06:05:02.130406 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(mdsmap lease_ack lc 1 fc 1 pn 0 opn 0 gv {}) v2 -- ?+0 0x1c636000
2013-02-17 06:05:02.130475 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== mon.0 10.200.63.130:6789/0 197443 ==== paxos(monmap lease lc 9 fc 1 pn 0 opn 0 gv {}) v2 ==== 88+0+0 (3086430848 0 0) 0x69698c0 con 0x2d189a0
2013-02-17 06:05:02.130488 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(monmap lease_ack lc 9 fc 1 pn 0 opn 0 gv {}) v2 -- ?+0 0x6899600
2013-02-17 06:05:02.684455 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== mon.0 10.200.63.130:6789/0 197444 ==== paxos(osdmap begin lc 784 fc 0 pn 40700 opn 0 gv {785=5833342}) v2 ==== 245+0+0 (1216715648 0 0) 0x6899600 con 0x2d189a0
2013-02-17 06:05:02.750106 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(osdmap accept lc 784 fc 0 pn 40700 opn 0 gv {}) v2 -- ?+0 0x69698c0
2013-02-17 06:05:02.750141 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== mon.0 10.200.63.130:6789/0 197445 ==== paxos(logm begin lc 2928952 fc 0 pn 40700 opn 0 gv {2928953=5833343}) v2 ==== 370+0+0 (2110251190 0 0) 0x1c636000 con 0x2d189a0
2013-02-17 06:05:02.778810 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(logm accept lc 2928952 fc 0 pn 40700 opn 0 gv {}) v2 -- ?+0 0x6899600
2013-02-17 06:05:02.778848 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== mon.0 10.200.63.130:6789/0 197446 ==== paxos(pgmap begin lc 2900134 fc 0 pn 40700 opn 0 gv {2900135=5833344}) v2 ==== 5451+0+0 (3356992033 0 0) 0x68998c0 con 0x2d189a0
2013-02-17 06:05:02.804185 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(pgmap accept lc 2900134 fc 0 pn 40700 opn 0 gv {}) v2 -- ?+0 0x1c636000
2013-02-17 06:05:02.804242 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== mon.0 10.200.63.130:6789/0 197447 ==== paxos(osdmap commit lc 785 fc 0 pn 40700 opn 0 gv {785=5833342}) v2 ==== 245+0+0 (2445046887 0 0) 0x699edc0 con 0x2d189a0
2013-02-17 06:05:02.853386 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== mon.0 10.200.63.130:6789/0 197448 ==== paxos(osdmap lease lc 785 fc 541 pn 0 opn 0 gv {}) v2 ==== 88+0+0 (3283911110 0 0) 0x69698c0 con 0x2d189a0
2013-02-17 06:05:02.853414 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(osdmap lease_ack lc 785 fc 541 pn 0 opn 0 gv {}) v2 -- ?+0 0x699edc0
2013-02-17 06:05:02.869698 7f2879ad7700  1 mon.b4@1(peon).osd e785 e785: 2 osds: 1 up, 2 in
2013-02-17 06:05:02.889915 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> client.9962 10.200.63.132:0/1024602 -- osd_map(785..785 src has 541..785) v3 -- ?+0 0x1c671e00
2013-02-17 06:05:02.889945 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> client.9793 10.200.63.133:0/1028590 -- osd_map(785..785 src has 541..785) v3 -- ?+0 0x6895200
2013-02-17 06:05:02.889966 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> client.9998 10.200.63.132:0/1026778 -- osd_map(785..785 src has 541..785) v3 -- ?+0 0x6895400
2013-02-17 06:05:02.889985 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> client.10007 10.200.63.132:0/1027293 -- osd_map(785..785 src has 541..785) v3 -- ?+0 0x6895600
2013-02-17 06:05:02.890011 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> client.10202 10.200.63.132:0/1011962 -- osd_map(785..785 src has 541..785) v3 -- ?+0 0x3017000
2013-02-17 06:05:02.890031 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> client.9980 10.200.63.132:0/1025294 -- osd_map(785..785 src has 541..785) v3 -- ?+0 0x6895a00
2013-02-17 06:05:02.890063 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> client.9983 10.200.63.132:0/1025964 -- osd_map(785..785 src has 541..785) v3 -- ?+0 0x6895c00
2013-02-17 06:05:02.890104 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> client.10001 10.200.63.132:0/2026778 -- osd_map(785..785 src has 541..785) v3 -- ?+0 0x2f00400
2013-02-17 06:05:02.890142 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> client.9814 10.200.63.132:0/2029392 -- osd_map(785..785 src has 541..785) v3 -- ?+0 0x2f0ca00
2013-02-17 06:05:02.890161 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> client.9811 10.200.63.132:0/1029392 -- osd_map(785..785 src has 541..785) v3 -- ?+0 0x2f02000
2013-02-17 06:05:02.890198 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> client.8936 10.200.63.132:0/1024890 -- osd_map(785..785 src has 541..785) v3 -- ?+0 0x3f9ea00
2013-02-17 06:05:02.890235 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> client.9965 10.200.63.132:0/2024602 -- osd_map(785..785 src has 541..785) v3 -- ?+0 0x6892400
2013-02-17 06:05:02.890262 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== mon.0 10.200.63.130:6789/0 197449 ==== paxos(logm commit lc 2928953 fc 0 pn 40700 opn 0 gv {2928953=5833343}) v2 ==== 370+0+0 (96512701 0 0) 0x6899600 con 0x2d189a0
2013-02-17 06:05:03.057217 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== mon.0 10.200.63.130:6789/0 197450 ==== paxos(logm lease lc 2928953 fc 2928452 pn 0 opn 0 gv {}) v2 ==== 88+0+0 (303443369 0 0) 0x1c591080 con 0x2d189a0
2013-02-17 06:05:03.057244 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(logm lease_ack lc 2928953 fc 2928451 pn 0 opn 0 gv {}) v2 -- ?+0 0x6899600
2013-02-17 06:05:03.109714 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== mon.0 10.200.63.130:6789/0 197451 ==== paxos(pgmap commit lc 2900135 fc 0 pn 40700 opn 0 gv {2900135=5833344}) v2 ==== 5451+0+0 (1375112371 0 0) 0x1c636000 con 0x2d189a0
2013-02-17 06:05:03.211911 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== mon.0 10.200.63.130:6789/0 197452 ==== paxos(pgmap lease lc 2900135 fc 2899634 pn 0 opn 0 gv {}) v2 ==== 88+0+0 (2609033812 0 0) 0x1c5bc000 con 0x2d189a0
2013-02-17 06:05:03.211933 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(pgmap lease_ack lc 2900135 fc 2899633 pn 0 opn 0 gv {}) v2 -- ?+0 0x1c636000
2013-02-17 06:05:03.267399 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== mon.0 10.200.63.130:6789/0 197453 ==== paxos(pgmap begin lc 2900135 fc 0 pn 40700 opn 0 gv {2900136=5833345}) v2 ==== 106258+0+0 (1573278324 0 0) 0x699edc0 con 0x2d189a0
2013-02-17 06:05:03.316969 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(pgmap accept lc 2900135 fc 0 pn 40700 opn 0 gv {}) v2 -- ?+0 0x1c5bc000
2013-02-17 06:05:03.317018 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== mon.0 10.200.63.130:6789/0 197454 ==== paxos(pgmap commit lc 2900136 fc 0 pn 40700 opn 0 gv {2900136=5833345}) v2 ==== 106258+0+0 (2619992220 0 0) 0x6899600 con 0x2d189a0
2013-02-17 06:05:03.421783 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== mon.0 10.200.63.130:6789/0 197455 ==== paxos(pgmap lease lc 2900136 fc 2899635 pn 0 opn 0 gv {}) v2 ==== 88+0+0 (556628681 0 0) 0x1c5bc000 con 0x2d189a0
2013-02-17 06:05:03.421821 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(pgmap lease_ack lc 2900136 fc 2899634 pn 0 opn 0 gv {}) v2 -- ?+0 0x6899600
2013-02-17 06:05:03.468894 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== client.9983 10.200.63.132:0/1025964 550 ==== mon_subscribe({monmap=10+,osdmap=786}) v2 ==== 42+0+0 (981029754 0 0) 0xdbb2700 con 0x2d19b80
2013-02-17 06:05:03.468930 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> client.9983 10.200.63.132:0/1025964 -- mon_subscribe_ack(300s) v1 -- ?+0 0xccd7380
2013-02-17 06:05:03.468945 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== client.9793 10.200.63.133:0/1028590 548 ==== mon_subscribe({monmap=10+,osdmap=786}) v2 ==== 42+0+0 (981029754 0 0) 0xdbb2540 con 0x2ed8420
2013-02-17 06:05:03.468956 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> client.9793 10.200.63.133:0/1028590 -- mon_subscribe_ack(300s) v1 -- ?+0 0x686c340
2013-02-17 06:05:03.715599 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== client.9998 10.200.63.132:0/1026778 549 ==== mon_subscribe({monmap=10+,osdmap=786}) v2 ==== 42+0+0 (981029754 0 0) 0x2fe7c00 con 0x2ed82c0
2013-02-17 06:05:03.715637 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> client.9998 10.200.63.132:0/1026778 -- mon_subscribe_ack(300s) v1 -- ?+0 0x686c4e0
2013-02-17 06:05:03.771214 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== mon.0 10.200.63.130:6789/0 197456 ==== paxos(osdmap begin lc 785 fc 0 pn 40700 opn 0 gv {786=5833346}) v2 ==== 248+0+0 (2752781820 0 0) 0x6899600 con 0x2d189a0
2013-02-17 06:05:03.833918 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(osdmap accept lc 785 fc 0 pn 40700 opn 0 gv {}) v2 -- ?+0 0x1c5bc000
2013-02-17 06:05:03.833969 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== mon.0 10.200.63.130:6789/0 197457 ==== paxos(logm begin lc 2928953 fc 0 pn 40700 opn 0 gv {2928954=5833347}) v2 ==== 899+0+0 (2467051332 0 0) 0x1c636000 con 0x2d189a0
2013-02-17 06:05:03.866255 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(logm accept lc 2928953 fc 0 pn 40700 opn 0 gv {}) v2 -- ?+0 0x6899600
2013-02-17 06:05:03.866293 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== mon.0 10.200.63.130:6789/0 197458 ==== paxos(osdmap commit lc 786 fc 0 pn 40700 opn 0 gv {786=5833346}) v2 ==== 248+0+0 (3711416935 0 0) 0x1c590000 con 0x2d189a0
2013-02-17 06:05:03.931450 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== mon.0 10.200.63.130:6789/0 197459 ==== paxos(osdmap lease lc 786 fc 541 pn 0 opn 0 gv {}) v2 ==== 88+0+0 (1686591545 0 0) 0x1c5bc000 con 0x2d189a0
2013-02-17 06:05:03.931493 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(osdmap lease_ack lc 786 fc 541 pn 0 opn 0 gv {}) v2 -- ?+0 0x1c590000
2013-02-17 06:05:03.959675 7f2879ad7700  1 mon.b4@1(peon).osd e786 e786: 2 osds: 1 up, 2 in
2013-02-17 06:05:03.990545 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> client.9983 10.200.63.132:0/1025964 -- osd_map(786..786 src has 541..786) v3 -- ?+0 0x6892600
2013-02-17 06:05:03.990586 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> client.9793 10.200.63.133:0/1028590 -- osd_map(786..786 src has 541..786) v3 -- ?+0 0x6892800
2013-02-17 06:05:03.990633 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> client.9998 10.200.63.132:0/1026778 -- osd_map(786..786 src has 541..786) v3 -- ?+0 0x6892a00
2013-02-17 06:05:03.990670 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== mon.0 10.200.63.130:6789/0 197460 ==== paxos(pgmap begin lc 2900136 fc 0 pn 40700 opn 0 gv {2900137=5833348}) v2 ==== 162+0+0 (2049167727 0 0) 0x6899600 con 0x2d189a0
2013-02-17 06:05:04.032168 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(pgmap accept lc 2900136 fc 0 pn 40700 opn 0 gv {}) v2 -- ?+0 0x1c5bc000
2013-02-17 06:05:04.032203 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== mon.0 10.200.63.130:6789/0 197461 ==== paxos(logm commit lc 2928954 fc 0 pn 40700 opn 0 gv {2928954=5833347}) v2 ==== 899+0+0 (4069256124 0 0) 0x1c590840 con 0x2d189a0
2013-02-17 06:05:04.088965 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== mon.0 10.200.63.130:6789/0 197462 ==== paxos(logm lease lc 2928954 fc 2928453 pn 0 opn 0 gv {}) v2 ==== 88+0+0 (2473265918 0 0) 0x1c590b00 con 0x2d189a0
2013-02-17 06:05:04.088996 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(logm lease_ack lc 2928954 fc 2928452 pn 0 opn 0 gv {}) v2 -- ?+0 0x1c590840
2013-02-17 06:05:04.129567 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== mon.0 10.200.63.130:6789/0 197463 ==== paxos(pgmap commit lc 2900137 fc 0 pn 40700 opn 0 gv {2900137=5833348}) v2 ==== 162+0+0 (2510848205 0 0) 0x1c590000 con 0x2d189a0
2013-02-17 06:05:04.210301 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== mon.0 10.200.63.130:6789/0 197464 ==== paxos(pgmap lease lc 2900137 fc 2899636 pn 0 opn 0 gv {}) v2 ==== 88+0+0 (3384776277 0 0) 0x1c5bc000 con 0x2d189a0
2013-02-17 06:05:04.210368 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(pgmap lease_ack lc 2900137 fc 2899635 pn 0 opn 0 gv {}) v2 -- ?+0 0x1c590000
2013-02-17 06:05:04.239384 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== mon.0 10.200.63.130:6789/0 197465 ==== paxos(auth lease lc 3461 fc 3441 pn 0 opn 0 gv {}) v2 ==== 88+0+0 (3037158960 0 0) 0x1c590840 con 0x2d189a0
2013-02-17 06:05:04.239405 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(auth lease_ack lc 3461 fc 3441 pn 0 opn 0 gv {}) v2 -- ?+0 0x1c5bc000
2013-02-17 06:05:04.239426 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== client.10007 10.200.63.132:0/1027293 549 ==== mon_subscribe({monmap=10+,osdmap=786}) v2 ==== 42+0+0 (981029754 0 0) 0x30256c0 con 0x2d198c0
2013-02-17 06:05:04.239472 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> client.10007 10.200.63.132:0/1027293 -- osd_map(786..786 src has 541..786) v3 -- ?+0 0x6892c00
2013-02-17 06:05:04.239484 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> client.10007 10.200.63.132:0/1027293 -- mon_subscribe_ack(300s) v1 -- ?+0 0x686c680
2013-02-17 06:05:04.239494 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== client.10202 10.200.63.132:0/1011962 549 ==== mon_subscribe({monmap=10+,osdmap=786}) v2 ==== 42+0+0 (981029754 0 0) 0x1b93afc0 con 0x2d19080
2013-02-17 06:05:04.239535 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> client.10202 10.200.63.132:0/1011962 -- osd_map(786..786 src has 541..786) v3 -- ?+0 0x3283000
2013-02-17 06:05:04.239546 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> client.10202 10.200.63.132:0/1011962 -- mon_subscribe_ack(300s) v1 -- ?+0 0x686c820
2013-02-17 06:05:04.239554 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== client.10001 10.200.63.132:0/2026778 551 ==== mon_subscribe({monmap=10+,osdmap=786}) v2 ==== 42+0+0 (981029754 0 0) 0x19a4c380 con 0x2d19a20
2013-02-17 06:05:04.239574 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> client.10001 10.200.63.132:0/2026778 -- osd_map(786..786 src has 541..786) v3 -- ?+0 0x6893000
2013-02-17 06:05:04.239584 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> client.10001 10.200.63.132:0/2026778 -- mon_subscribe_ack(300s) v1 -- ?+0 0x686c9c0
2013-02-17 06:05:04.840455 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== client.9814 10.200.63.132:0/2029392 550 ==== mon_subscribe({monmap=10+,osdmap=786}) v2 ==== 42+0+0 (981029754 0 0) 0xdbb08c0 con 0x2d18dc0
2013-02-17 06:05:04.840544 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> client.9814 10.200.63.132:0/2029392 -- osd_map(786..786 src has 541..786) v3 -- ?+0 0x6893200
2013-02-17 06:05:04.840564 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> client.9814 10.200.63.132:0/2029392 -- mon_subscribe_ack(300s) v1 -- ?+0 0x686cb60
2013-02-17 06:05:04.882186 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== client.9811 10.200.63.132:0/1029392 550 ==== mon_subscribe({monmap=10+,osdmap=786}) v2 ==== 42+0+0 (981029754 0 0) 0xc19e8c0 con 0x2d18f20
2013-02-17 06:05:04.882245 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> client.9811 10.200.63.132:0/1029392 -- osd_map(786..786 src has 541..786) v3 -- ?+0 0x6893400
2013-02-17 06:05:04.882265 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> client.9811 10.200.63.132:0/1029392 -- mon_subscribe_ack(300s) v1 -- ?+0 0x686cd00
2013-02-17 06:05:04.920980 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== mon.0 10.200.63.130:6789/0 197466 ==== paxos(logm begin lc 2928954 fc 0 pn 40700 opn 0 gv {2928955=5833349}) v2 ==== 636+0+0 (3516914051 0 0) 0x1c5bc000 con 0x2d189a0
2013-02-17 06:05:04.986213 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(logm accept lc 2928954 fc 0 pn 40700 opn 0 gv {}) v2 -- ?+0 0x1c590840
2013-02-17 06:05:04.986265 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== mon.0 10.200.63.130:6789/0 197467 ==== paxos(logm commit lc 2928955 fc 0 pn 40700 opn 0 gv {2928955=5833349}) v2 ==== 636+0+0 (2318971175 0 0) 0x1c590000 con 0x2d189a0
2013-02-17 06:05:05.059002 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== mon.0 10.200.63.130:6789/0 197468 ==== paxos(logm lease lc 2928955 fc 2928454 pn 0 opn 0 gv {}) v2 ==== 88+0+0 (90852951 0 0) 0x1c590840 con 0x2d189a0
2013-02-17 06:05:05.059028 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(logm lease_ack lc 2928955 fc 2928453 pn 0 opn 0 gv {}) v2 -- ?+0 0x1c590000
2013-02-17 06:05:05.130136 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== mon.0 10.200.63.130:6789/0 197469 ==== paxos(mdsmap lease lc 1 fc 1 pn 0 opn 0 gv {}) v2 ==== 88+0+0 (439731423 0 0) 0x1c590000 con 0x2d189a0
2013-02-17 06:05:05.130163 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(mdsmap lease_ack lc 1 fc 1 pn 0 opn 0 gv {}) v2 -- ?+0 0x1c590840
2013-02-17 06:05:05.130218 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== mon.0 10.200.63.130:6789/0 197470 ==== paxos(monmap lease lc 9 fc 1 pn 0 opn 0 gv {}) v2 ==== 88+0+0 (286498847 0 0) 0x1c591b80 con 0x2d189a0
2013-02-17 06:05:05.130234 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(monmap lease_ack lc 9 fc 1 pn 0 opn 0 gv {}) v2 -- ?+0 0x1c590000
2013-02-17 06:05:05.159964 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== client.8936 10.200.63.132:0/1024890 550 ==== mon_subscribe({monmap=10+}) v2 ==== 23+0+0 (897212988 0 0) 0x19cb9a40 con 0x2d18b00
2013-02-17 06:05:05.159994 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> client.8936 10.200.63.132:0/1024890 -- mon_subscribe_ack(300s) v1 -- ?+0 0x686cea0
2013-02-17 06:05:05.301727 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== client.8936 10.200.63.132:0/1024890 551 ==== mon_subscribe({monmap=10+,osdmap=787}) v2 ==== 42+0+0 (3460793650 0 0) 0x30d1340 con 0x2d18b00
2013-02-17 06:05:05.301785 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> client.8936 10.200.63.132:0/1024890 -- mon_subscribe_ack(300s) v1 -- ?+0 0x686d040
2013-02-17 06:05:05.534281 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== client.9965 10.200.63.132:0/2024602 551 ==== mon_subscribe({monmap=10+,osdmap=786}) v2 ==== 42+0+0 (981029754 0 0) 0x72d0e00 con 0x2ed8580
2013-02-17 06:05:05.534371 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> client.9965 10.200.63.132:0/2024602 -- osd_map(786..786 src has 541..786) v3 -- ?+0 0x6893600
2013-02-17 06:05:05.534392 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> client.9965 10.200.63.132:0/2024602 -- mon_subscribe_ack(300s) v1 -- ?+0 0x686d1e0
2013-02-17 06:05:05.812437 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== mon.0 10.200.63.130:6789/0 197471 ==== paxos(osdmap begin lc 786 fc 0 pn 40700 opn 0 gv {787=5833350}) v2 ==== 698+0+0 (1439899322 0 0) 0x1c590840 con 0x2d189a0
2013-02-17 06:05:05.870299 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(osdmap accept lc 786 fc 0 pn 40700 opn 0 gv {}) v2 -- ?+0 0x1c591b80
2013-02-17 06:05:05.870363 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== mon.0 10.200.63.130:6789/0 197472 ==== paxos(osdmap commit lc 787 fc 0 pn 40700 opn 0 gv {787=5833350}) v2 ==== 698+0+0 (1125289174 0 0) 0x1c5a98c0 con 0x2d189a0
2013-02-17 06:05:05.939275 7f2879ad7700  1 -- 10.200.63.132:6789/0 <== mon.0 10.200.63.130:6789/0 197473 ==== paxos(osdmap lease lc 787 fc 541 pn 0 opn 0 gv {}) v2 ==== 88+0+0 (885348033 0 0) 0x1c591b80 con 0x2d189a0
2013-02-17 06:05:05.939307 7f2879ad7700  1 -- 10.200.63.132:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(osdmap lease_ack lc 787 fc 541 pn 0 opn 0 gv {}) v2 -- ?+0 0x1c5a98c0
2013-02-17 06:05:05.951734 7f2879ad7700  1 mon.b4@1(peon).osd e787 e787: 2 osds: 2 up, 2 in

----------------------------------------------------------------------
ceph-mon.b5.log
----------------------------------------------------------------------
2013-02-17 06:05:00.003187 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217824 ==== paxos(pgmap commit lc 2900134 fc 0 pn 40700 opn 0 gv {2900134=5833340}) v2 ==== 4055+0+0 (2464340035 0 0) 0x27a70b00 con 0x268a9a0
2013-02-17 06:05:00.051665 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217825 ==== paxos(pgmap lease lc 2900134 fc 2899633 pn 0 opn 0 gv {}) v2 ==== 88+0+0 (2739579357 0 0) 0x3950580 con 0x268a9a0
2013-02-17 06:05:00.051693 7faaec18d700  1 -- 10.200.63.133:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(pgmap lease_ack lc 2900134 fc 2899632 pn 0 opn 0 gv {}) v2 -- ?+0 0x27a70b00
2013-02-17 06:05:00.088234 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217826 ==== route(pg_stats_ack(11 pgs tid 15412) v1 tid 31190) v2 ==== 555+0+0 (4193262135 0 0) 0x27a62480 con 0x268a9a0
2013-02-17 06:05:00.088261 7faaec18d700  1 -- 10.200.63.133:6789/0 --> osd.1 10.200.63.133:6801/21178 -- pg_stats_ack(11 pgs tid 15412) v1 -- ?+0 0x27bf4540
2013-02-17 06:05:00.124146 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217827 ==== paxos(logm begin lc 2928951 fc 0 pn 40700 opn 0 gv {2928952=5833341}) v2 ==== 408+0+0 (2121299380 0 0) 0x27a70b00 con 0x268a9a0
2013-02-17 06:05:00.152577 7faaec18d700  1 -- 10.200.63.133:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(logm accept lc 2928951 fc 0 pn 40700 opn 0 gv {}) v2 -- ?+0 0x3950580
2013-02-17 06:05:00.164381 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217828 ==== paxos(logm commit lc 2928952 fc 0 pn 40700 opn 0 gv {2928952=5833341}) v2 ==== 408+0+0 (2048871512 0 0) 0x3950580 con 0x268a9a0
2013-02-17 06:05:00.221408 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217829 ==== paxos(logm lease lc 2928952 fc 2928451 pn 0 opn 0 gv {}) v2 ==== 88+0+0 (3800722919 0 0) 0x39b22c0 con 0x268a9a0
2013-02-17 06:05:00.221436 7faaec18d700  1 -- 10.200.63.133:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(logm lease_ack lc 2928952 fc 2928450 pn 0 opn 0 gv {}) v2 -- ?+0 0x3950580
2013-02-17 06:05:00.465887 7faaec18d700  1 -- 10.200.63.133:6789/0 <== client.9971 10.200.63.132:0/1024854 548 ==== mon_subscribe({monmap=10+,osdmap=785}) v2 ==== 42+0+0 (601251667 0 0) 0x27a556c0 con 0x268b1e0
2013-02-17 06:05:00.465937 7faaec18d700  1 -- 10.200.63.133:6789/0 --> client.9971 10.200.63.132:0/1024854 -- mon_subscribe_ack(300s) v1 -- ?+0 0x3ed91e0
2013-02-17 06:05:00.543992 7faaec18d700  1 -- 10.200.63.133:6789/0 <== client.9995 10.200.63.132:0/2026519 548 ==== mon_subscribe({monmap=10+,osdmap=785}) v2 ==== 42+0+0 (601251667 0 0) 0x99361c0 con 0x268b760
2013-02-17 06:05:00.544025 7faaec18d700  1 -- 10.200.63.133:6789/0 --> client.9995 10.200.63.132:0/2026519 -- mon_subscribe_ack(300s) v1 -- ?+0 0x3ed9380
2013-02-17 06:05:00.546004 7faaec18d700  1 -- 10.200.63.133:6789/0 <== client.9992 10.200.63.132:0/1026519 548 ==== mon_subscribe({monmap=10+,osdmap=785}) v2 ==== 42+0+0 (601251667 0 0) 0x2745f340 con 0x268ba20
2013-02-17 06:05:00.546038 7faaec18d700  1 -- 10.200.63.133:6789/0 --> client.9992 10.200.63.132:0/1026519 -- mon_subscribe_ack(300s) v1 -- ?+0 0x3ed9520
2013-02-17 06:05:01.197554 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217830 ==== paxos(auth lease lc 3461 fc 3441 pn 0 opn 0 gv {}) v2 ==== 88+0+0 (364209048 0 0) 0x3950580 con 0x268a9a0
2013-02-17 06:05:01.197590 7faaec18d700  1 -- 10.200.63.133:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(auth lease_ack lc 3461 fc 3441 pn 0 opn 0 gv {}) v2 -- ?+0 0x39b22c0
2013-02-17 06:05:01.348870 7faaec18d700  1 -- 10.200.63.133:6789/0 <== client.9953 10.200.63.133:0/1028024 549 ==== mon_subscribe({monmap=10+,osdmap=785}) v2 ==== 42+0+0 (601251667 0 0) 0x246a81c0 con 0x268ac60
2013-02-17 06:05:01.348913 7faaec18d700  1 -- 10.200.63.133:6789/0 --> client.9953 10.200.63.133:0/1028024 -- mon_subscribe_ack(300s) v1 -- ?+0 0x3ed96c0
2013-02-17 06:05:01.445022 7faaec18d700  1 -- 10.200.63.133:6789/0 <== client.9977 10.200.63.132:0/1025185 549 ==== mon_subscribe({monmap=10+,osdmap=785}) v2 ==== 42+0+0 (601251667 0 0) 0x279848c0 con 0x268b080
2013-02-17 06:05:01.445054 7faaec18d700  1 -- 10.200.63.133:6789/0 --> client.9977 10.200.63.132:0/1025185 -- mon_subscribe_ack(300s) v1 -- ?+0 0x3ed9860
2013-02-17 06:05:02.129960 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217831 ==== paxos(osdmap lease lc 784 fc 541 pn 0 opn 0 gv {}) v2 ==== 88+0+0 (2306880830 0 0) 0x39b22c0 con 0x268a9a0
2013-02-17 06:05:02.130015 7faaec18d700  1 -- 10.200.63.133:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(osdmap lease_ack lc 784 fc 541 pn 0 opn 0 gv {}) v2 -- ?+0 0x3950580
2013-02-17 06:05:02.130058 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217832 ==== paxos(mdsmap lease lc 1 fc 1 pn 0 opn 0 gv {}) v2 ==== 88+0+0 (1492732137 0 0) 0x3960dc0 con 0x268a9a0
2013-02-17 06:05:02.130071 7faaec18d700  1 -- 10.200.63.133:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(mdsmap lease_ack lc 1 fc 1 pn 0 opn 0 gv {}) v2 -- ?+0 0x39b22c0
2013-02-17 06:05:02.130177 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217833 ==== paxos(monmap lease lc 9 fc 1 pn 0 opn 0 gv {}) v2 ==== 88+0+0 (445342582 0 0) 0x39b2000 con 0x268a9a0
2013-02-17 06:05:02.130201 7faaec18d700  1 -- 10.200.63.133:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(monmap lease_ack lc 9 fc 1 pn 0 opn 0 gv {}) v2 -- ?+0 0x3960dc0
2013-02-17 06:05:02.567361 7faaec18d700  1 -- 10.200.63.133:6789/0 <== osd.0 10.200.63.132:6801/18444 16103 ==== osd_failure(failed osd.1 10.200.63.133:6801/21178 for 31sec e784 v784) v3 ==== 188+0+0 (2900250966 0 0) 0x2f69180 con 0x2ee6420
2013-02-17 06:05:02.567427 7faaec18d700  1 -- 10.200.63.133:6789/0 --> mon.0 10.200.63.130:6789/0 -- forward(osd_failure(failed osd.1 10.200.63.133:6801/21178 for 31sec e784 v784) v3) to leader v1 -- ?+0 0x39b2000
2013-02-17 06:05:02.568250 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217834 ==== route(no-reply tid 31188) v2 ==== 154+0+0 (247117294 0 0) 0x276ca000 con 0x268a9a0
2013-02-17 06:05:02.568572 7faaec18d700  1 -- 10.200.63.133:6789/0 <== osd.0 10.200.63.132:6801/18444 16104 ==== pg_stats(15 pgs tid 15379 v 784) v1 ==== 5695+0+0 (862073156 0 0) 0x27b2e480 con 0x2ee6420
2013-02-17 06:05:02.568630 7faaec18d700  1 -- 10.200.63.133:6789/0 --> mon.0 10.200.63.130:6789/0 -- forward(pg_stats(15 pgs tid 15379 v 784) v1) to leader v1 -- ?+0 0x27a70b00
2013-02-17 06:05:02.683997 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217835 ==== paxos(osdmap begin lc 784 fc 0 pn 40700 opn 0 gv {785=5833342}) v2 ==== 245+0+0 (3059524207 0 0) 0x27a70b00 con 0x268a9a0
2013-02-17 06:05:02.733666 7faaec18d700  1 -- 10.200.63.133:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(osdmap accept lc 784 fc 0 pn 40700 opn 0 gv {}) v2 -- ?+0 0x381f8c0
2013-02-17 06:05:02.733705 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217836 ==== paxos(logm begin lc 2928952 fc 0 pn 40700 opn 0 gv {2928953=5833343}) v2 ==== 370+0+0 (1453139115 0 0) 0x39b2000 con 0x268a9a0
2013-02-17 06:05:02.758039 7faaec18d700  1 -- 10.200.63.133:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(logm accept lc 2928952 fc 0 pn 40700 opn 0 gv {}) v2 -- ?+0 0x27a70b00
2013-02-17 06:05:02.758071 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217837 ==== paxos(pgmap begin lc 2900134 fc 0 pn 40700 opn 0 gv {2900135=5833344}) v2 ==== 5451+0+0 (2376171371 0 0) 0x3960dc0 con 0x268a9a0
2013-02-17 06:05:02.789264 7faaec18d700  1 -- 10.200.63.133:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(pgmap accept lc 2900134 fc 0 pn 40700 opn 0 gv {}) v2 -- ?+0 0x39b2000
2013-02-17 06:05:02.789297 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217838 ==== paxos(osdmap commit lc 785 fc 0 pn 40700 opn 0 gv {785=5833342}) v2 ==== 245+0+0 (2456140731 0 0) 0x381f8c0 con 0x268a9a0
2013-02-17 06:05:02.839358 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217839 ==== paxos(osdmap lease lc 785 fc 541 pn 0 opn 0 gv {}) v2 ==== 88+0+0 (655530447 0 0) 0x39b22c0 con 0x268a9a0
2013-02-17 06:05:02.839385 7faaec18d700  1 -- 10.200.63.133:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(osdmap lease_ack lc 785 fc 541 pn 0 opn 0 gv {}) v2 -- ?+0 0x381f8c0
2013-02-17 06:05:02.859571 7faaec18d700  1 mon.b5@2(peon).osd e785 e785: 2 osds: 1 up, 2 in
2013-02-17 06:05:02.871798 7faaec18d700  1 -- 10.200.63.133:6789/0 --> client.9995 10.200.63.132:0/2026519 -- osd_map(785..785 src has 541..785) v3 -- ?+0 0x2ad3000
2013-02-17 06:05:02.871864 7faaec18d700  1 -- 10.200.63.133:6789/0 --> client.9971 10.200.63.132:0/1024854 -- osd_map(785..785 src has 541..785) v3 -- ?+0 0x2afae00
2013-02-17 06:05:02.871939 7faaec18d700  1 -- 10.200.63.133:6789/0 --> client.9992 10.200.63.132:0/1026519 -- osd_map(785..785 src has 541..785) v3 -- ?+0 0x2ba7200
2013-02-17 06:05:02.871977 7faaec18d700  1 -- 10.200.63.133:6789/0 --> client.9977 10.200.63.132:0/1025185 -- osd_map(785..785 src has 541..785) v3 -- ?+0 0x2b63400
2013-02-17 06:05:02.871998 7faaec18d700  1 -- 10.200.63.133:6789/0 --> client.9953 10.200.63.133:0/1028024 -- osd_map(785..785 src has 541..785) v3 -- ?+0 0x2ba6600
2013-02-17 06:05:02.872016 7faaec18d700  1 -- 10.200.63.133:6789/0 --> client.9986 10.200.63.132:0/1026221 -- osd_map(785..785 src has 541..785) v3 -- ?+0 0x2a9ae00
2013-02-17 06:05:02.872113 7faaec18d700  1 -- 10.200.63.133:6789/0 --> client.9989 10.200.63.132:0/2026221 -- osd_map(785..785 src has 541..785) v3 -- ?+0 0x2bce200
2013-02-17 06:05:02.872135 7faaec18d700  1 -- 10.200.63.133:6789/0 --> client.9968 10.200.63.132:0/1024758 -- osd_map(785..785 src has 541..785) v3 -- ?+0 0x285e800
2013-02-17 06:05:02.872197 7faaec18d700  1 -- 10.200.63.133:6789/0 --> client.9974 10.200.63.132:0/1024950 -- osd_map(785..785 src has 541..785) v3 -- ?+0 0x2ba7c00
2013-02-17 06:05:02.872250 7faaec18d700  1 -- 10.200.63.133:6789/0 --> client.9956 10.200.63.132:0/1024424 -- osd_map(785..785 src has 541..785) v3 -- ?+0 0x2a4f000
2013-02-17 06:05:02.872272 7faaec18d700  1 -- 10.200.63.133:6789/0 --> client.9959 10.200.63.132:0/2024424 -- osd_map(785..785 src has 541..785) v3 -- ?+0 0x2b21a00
2013-02-17 06:05:02.872294 7faaec18d700  1 -- 10.200.63.133:6789/0 --> osd.0 10.200.63.132:6801/18444 -- osd_map(784..785 src has 541..785) v3 -- ?+0 0x2b64c00
2013-02-17 06:05:02.872311 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217840 ==== route(osd_map(784..785 src has 541..785) v3 tid 31191) v2 ==== 549+0+0 (1208657806 0 0) 0xd2c6fc0 con 0x268a9a0
2013-02-17 06:05:02.872323 7faaec18d700  1 -- 10.200.63.133:6789/0 --> osd.0 10.200.63.132:6801/18444 -- osd_map(784..785 src has 541..785) v3 -- ?+0 0x2c89c00
2013-02-17 06:05:02.872339 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217841 ==== paxos(logm commit lc 2928953 fc 0 pn 40700 opn 0 gv {2928953=5833343}) v2 ==== 370+0+0 (1947946272 0 0) 0x39b2000 con 0x268a9a0
2013-02-17 06:05:02.931840 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217842 ==== paxos(logm lease lc 2928953 fc 2928452 pn 0 opn 0 gv {}) v2 ==== 88+0+0 (2254758468 0 0) 0x27a70b00 con 0x268a9a0
2013-02-17 06:05:02.931867 7faaec18d700  1 -- 10.200.63.133:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(logm lease_ack lc 2928953 fc 2928451 pn 0 opn 0 gv {}) v2 -- ?+0 0x39b2000
2013-02-17 06:05:02.953651 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217843 ==== paxos(pgmap commit lc 2900135 fc 0 pn 40700 opn 0 gv {2900135=5833344}) v2 ==== 5451+0+0 (3278650520 0 0) 0x3950580 con 0x268a9a0
2013-02-17 06:05:03.013296 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217844 ==== paxos(pgmap lease lc 2900135 fc 2899634 pn 0 opn 0 gv {}) v2 ==== 88+0+0 (4264509609 0 0) 0x381fb80 con 0x268a9a0
2013-02-17 06:05:03.013323 7faaec18d700  1 -- 10.200.63.133:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(pgmap lease_ack lc 2900135 fc 2899633 pn 0 opn 0 gv {}) v2 -- ?+0 0x3950580
2013-02-17 06:05:03.043166 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217845 ==== paxos(pgmap begin lc 2900135 fc 0 pn 40700 opn 0 gv {2900136=5833345}) v2 ==== 106258+0+0 (3288368916 0 0) 0x381f8c0 con 0x268a9a0
2013-02-17 06:05:03.071470 7faaec18d700  1 -- 10.200.63.133:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(pgmap accept lc 2900135 fc 0 pn 40700 opn 0 gv {}) v2 -- ?+0 0x381fb80
2013-02-17 06:05:03.071503 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217846 ==== route(pg_stats_ack(15 pgs tid 15379) v1 tid 31192) v2 ==== 671+0+0 (3596506077 0 0) 0xcecf680 con 0x268a9a0
2013-02-17 06:05:03.071517 7faaec18d700  1 -- 10.200.63.133:6789/0 --> osd.0 10.200.63.132:6801/18444 -- pg_stats_ack(15 pgs tid 15379) v1 -- ?+0 0x26b41c0
2013-02-17 06:05:03.071536 7faaec18d700  1 -- 10.200.63.133:6789/0 <== osd.0 10.200.63.132:6801/18444 16105 ==== mon_subscribe({monmap=10+,osd_pg_creates=0,osdmap=785}) v2 ==== 69+0+0 (1495392616 0 0) 0x27a5c000 con 0x2ee6420
2013-02-17 06:05:03.071578 7faaec18d700  1 -- 10.200.63.133:6789/0 --> osd.0 10.200.63.132:6801/18444 -- osd_map(785..785 src has 541..785) v3 -- ?+0 0x2a9bc00
2013-02-17 06:05:03.071590 7faaec18d700  1 -- 10.200.63.133:6789/0 --> osd.0 10.200.63.132:6801/18444 -- mon_subscribe_ack(300s) v1 -- ?+0 0x3ed9a00
2013-02-17 06:05:03.071640 7faaec18d700  1 -- 10.200.63.133:6789/0 <== osd.0 10.200.63.132:6801/18444 16106 ==== osd_alive(want up_thru 785 have 785) v1 ==== 22+0+0 (1697281490 0 0) 0x26675180 con 0x2ee6420
2013-02-17 06:05:03.071678 7faaec18d700  1 -- 10.200.63.133:6789/0 --> mon.0 10.200.63.130:6789/0 -- forward(osd_alive(want up_thru 785 have 785) v1) to leader v1 -- ?+0 0x381edc0
2013-02-17 06:05:03.086178 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217847 ==== paxos(pgmap commit lc 2900136 fc 0 pn 40700 opn 0 gv {2900136=5833345}) v2 ==== 106258+0+0 (3946206785 0 0) 0x381edc0 con 0x268a9a0
2013-02-17 06:05:03.317782 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217848 ==== paxos(pgmap lease lc 2900136 fc 2899635 pn 0 opn 0 gv {}) v2 ==== 88+0+0 (3766713448 0 0) 0x381fb80 con 0x268a9a0
2013-02-17 06:05:03.317811 7faaec18d700  1 -- 10.200.63.133:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(pgmap lease_ack lc 2900136 fc 2899634 pn 0 opn 0 gv {}) v2 -- ?+0 0x381edc0
2013-02-17 06:05:03.583718 7faaec18d700  1 -- 10.200.63.133:6789/0 <== client.9977 10.200.63.132:0/1025185 550 ==== mon_subscribe({monmap=10+,osdmap=786}) v2 ==== 42+0+0 (981029754 0 0) 0xf313a40 con 0x268b080
2013-02-17 06:05:03.583753 7faaec18d700  1 -- 10.200.63.133:6789/0 --> client.9977 10.200.63.132:0/1025185 -- mon_subscribe_ack(300s) v1 -- ?+0 0x3ed9d40
2013-02-17 06:05:03.765409 7faaec18d700  1 -- 10.200.63.133:6789/0 <== client.9986 10.200.63.132:0/1026221 548 ==== mon_subscribe({monmap=10+,osdmap=786}) v2 ==== 42+0+0 (981029754 0 0) 0x254b4700 con 0x268b340
2013-02-17 06:05:03.765443 7faaec18d700  1 -- 10.200.63.133:6789/0 --> client.9986 10.200.63.132:0/1026221 -- mon_subscribe_ack(300s) v1 -- ?+0 0xc11e4e0
2013-02-17 06:05:03.771262 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217849 ==== paxos(osdmap begin lc 785 fc 0 pn 40700 opn 0 gv {786=5833346}) v2 ==== 248+0+0 (1123691466 0 0) 0x381edc0 con 0x268a9a0
2013-02-17 06:05:03.800417 7faaec18d700  1 -- 10.200.63.133:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(osdmap accept lc 785 fc 0 pn 40700 opn 0 gv {}) v2 -- ?+0 0x381fb80
2013-02-17 06:05:03.811504 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217850 ==== paxos(logm begin lc 2928953 fc 0 pn 40700 opn 0 gv {2928954=5833347}) v2 ==== 899+0+0 (976230293 0 0) 0x381fb80 con 0x268a9a0
2013-02-17 06:05:03.836730 7faaec18d700  1 -- 10.200.63.133:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(logm accept lc 2928953 fc 0 pn 40700 opn 0 gv {}) v2 -- ?+0 0x381edc0
2013-02-17 06:05:03.836762 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217851 ==== paxos(osdmap commit lc 786 fc 0 pn 40700 opn 0 gv {786=5833346}) v2 ==== 248+0+0 (1548565610 0 0) 0x3950580 con 0x268a9a0
2013-02-17 06:05:03.885558 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217852 ==== paxos(osdmap lease lc 786 fc 541 pn 0 opn 0 gv {}) v2 ==== 88+0+0 (4021780416 0 0) 0x39b2000 con 0x268a9a0
2013-02-17 06:05:03.885585 7faaec18d700  1 -- 10.200.63.133:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(osdmap lease_ack lc 786 fc 541 pn 0 opn 0 gv {}) v2 -- ?+0 0x3950580
2013-02-17 06:05:03.897747 7faaec18d700  1 mon.b5@2(peon).osd e786 e786: 2 osds: 1 up, 2 in
2013-02-17 06:05:03.910012 7faaec18d700  1 -- 10.200.63.133:6789/0 --> client.9977 10.200.63.132:0/1025185 -- osd_map(786..786 src has 541..786) v3 -- ?+0 0x2ba6a00
2013-02-17 06:05:03.910042 7faaec18d700  1 -- 10.200.63.133:6789/0 --> client.9986 10.200.63.132:0/1026221 -- osd_map(786..786 src has 541..786) v3 -- ?+0 0x2a9aa00
2013-02-17 06:05:03.910112 7faaec18d700  1 -- 10.200.63.133:6789/0 --> osd.0 10.200.63.132:6801/18444 -- osd_map(785..786 src has 541..786) v3 -- ?+0 0x2d00800
2013-02-17 06:05:03.910135 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217853 ==== paxos(pgmap begin lc 2900136 fc 0 pn 40700 opn 0 gv {2900137=5833348}) v2 ==== 162+0+0 (3432763774 0 0) 0x381edc0 con 0x268a9a0
2013-02-17 06:05:03.934366 7faaec18d700  1 -- 10.200.63.133:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(pgmap accept lc 2900136 fc 0 pn 40700 opn 0 gv {}) v2 -- ?+0 0x39b2000
2013-02-17 06:05:03.934397 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217854 ==== route(osd_map(785..786 src has 541..786) v3 tid 31193) v2 ==== 541+0+0 (2399459519 0 0) 0x27b72fc0 con 0x268a9a0
2013-02-17 06:05:03.934411 7faaec18d700  1 -- 10.200.63.133:6789/0 --> osd.0 10.200.63.132:6801/18444 -- osd_map(785..786 src has 541..786) v3 -- ?+0 0x285f600
2013-02-17 06:05:03.934428 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217855 ==== paxos(logm commit lc 2928954 fc 0 pn 40700 opn 0 gv {2928954=5833347}) v2 ==== 899+0+0 (2190316667 0 0) 0x3950580 con 0x268a9a0
2013-02-17 06:05:03.986328 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217856 ==== paxos(logm lease lc 2928954 fc 2928453 pn 0 opn 0 gv {}) v2 ==== 88+0+0 (1074855049 0 0) 0x387f8c0 con 0x268a9a0
2013-02-17 06:05:03.986355 7faaec18d700  1 -- 10.200.63.133:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(logm lease_ack lc 2928954 fc 2928452 pn 0 opn 0 gv {}) v2 -- ?+0 0x3950580
2013-02-17 06:05:04.008094 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217857 ==== paxos(pgmap commit lc 2900137 fc 0 pn 40700 opn 0 gv {2900137=5833348}) v2 ==== 162+0+0 (3385534158 0 0) 0x39b2000 con 0x268a9a0
2013-02-17 06:05:04.061016 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217858 ==== paxos(pgmap lease lc 2900137 fc 2899636 pn 0 opn 0 gv {}) v2 ==== 88+0+0 (1623274848 0 0) 0x3950580 con 0x268a9a0
2013-02-17 06:05:04.061043 7faaec18d700  1 -- 10.200.63.133:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(pgmap lease_ack lc 2900137 fc 2899635 pn 0 opn 0 gv {}) v2 -- ?+0 0x39b2000
2013-02-17 06:05:04.089621 7faaec18d700  1 -- 10.200.63.133:6789/0 <== client.9974 10.200.63.132:0/1024950 550 ==== mon_subscribe({monmap=10+}) v2 ==== 23+0+0 (897212988 0 0) 0x99376c0 con 0x268b8c0
2013-02-17 06:05:04.089641 7faaec18d700  1 -- 10.200.63.133:6789/0 --> client.9974 10.200.63.132:0/1024950 -- mon_subscribe_ack(300s) v1 -- ?+0 0xc11e9c0
2013-02-17 06:05:04.161576 7faaec18d700  1 -- 10.200.63.133:6789/0 <== client.9953 10.200.63.133:0/1028024 550 ==== mon_subscribe({monmap=10+,osdmap=786}) v2 ==== 42+0+0 (981029754 0 0) 0x270f3500 con 0x268ac60
2013-02-17 06:05:04.161635 7faaec18d700  1 -- 10.200.63.133:6789/0 --> client.9953 10.200.63.133:0/1028024 -- osd_map(786..786 src has 541..786) v3 -- ?+0 0x290e400
2013-02-17 06:05:04.161654 7faaec18d700  1 -- 10.200.63.133:6789/0 --> client.9953 10.200.63.133:0/1028024 -- mon_subscribe_ack(300s) v1 -- ?+0 0xc11e340
2013-02-17 06:05:04.197772 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217859 ==== paxos(auth lease lc 3461 fc 3441 pn 0 opn 0 gv {}) v2 ==== 88+0+0 (335508935 0 0) 0x39b2000 con 0x268a9a0
2013-02-17 06:05:04.197801 7faaec18d700  1 -- 10.200.63.133:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(auth lease_ack lc 3461 fc 3441 pn 0 opn 0 gv {}) v2 -- ?+0 0x3950580
2013-02-17 06:05:04.198129 7faaec18d700  1 -- 10.200.63.133:6789/0 <== client.9989 10.200.63.132:0/2026221 549 ==== mon_subscribe({monmap=10+,osdmap=786}) v2 ==== 42+0+0 (981029754 0 0) 0x9937340 con 0x2ee66e0
2013-02-17 06:05:04.198188 7faaec18d700  1 -- 10.200.63.133:6789/0 --> client.9989 10.200.63.132:0/2026221 -- osd_map(786..786 src has 541..786) v3 -- ?+0 0x2a4e000
2013-02-17 06:05:04.198208 7faaec18d700  1 -- 10.200.63.133:6789/0 --> client.9989 10.200.63.132:0/2026221 -- mon_subscribe_ack(300s) v1 -- ?+0 0xc11f1e0
2013-02-17 06:05:04.868960 7faaec18d700  1 -- 10.200.63.133:6789/0 <== osd.1 10.200.63.133:6801/21178 16167 ==== pg_stats(11 pgs tid 15413 v 784) v1 ==== 4203+0+0 (1978113006 0 0) 0xd460fc0 con 0x268b4a0
2013-02-17 06:05:04.869046 7faaec18d700  1 -- 10.200.63.133:6789/0 --> 10.200.63.133:6801/21178 -- osd_map(785..786 src has 541..786) v3 -- ?+0 0x2b20600 con 0x268b4a0
2013-02-17 06:05:04.869070 7faaec18d700  1 -- 10.200.63.133:6789/0 --> mon.0 10.200.63.130:6789/0 -- forward(pg_stats(11 pgs tid 15413 v 784) v1) to leader v1 -- ?+0 0x39b2000
2013-02-17 06:05:04.870167 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217860 ==== route(osd_map(785..786 src has 541..786) v3 tid 31194) v2 ==== 541+0+0 (4109387781 0 0) 0xd2946c0 con 0x268a9a0
2013-02-17 06:05:04.870195 7faaec18d700  1 -- 10.200.63.133:6789/0 --> osd.1 10.200.63.133:6801/21178 -- osd_map(785..786 src has 541..786) v3 -- ?+0 0x2ad2600
2013-02-17 06:05:04.920875 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217861 ==== paxos(logm begin lc 2928954 fc 0 pn 40700 opn 0 gv {2928955=5833349}) v2 ==== 636+0+0 (2711767532 0 0) 0x39b2000 con 0x268a9a0
2013-02-17 06:05:04.964213 7faaec18d700  1 -- 10.200.63.133:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(logm accept lc 2928954 fc 0 pn 40700 opn 0 gv {}) v2 -- ?+0 0x387f8c0
2013-02-17 06:05:04.977102 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217862 ==== paxos(logm commit lc 2928955 fc 0 pn 40700 opn 0 gv {2928955=5833349}) v2 ==== 636+0+0 (4237095061 0 0) 0x387f8c0 con 0x268a9a0
2013-02-17 06:05:05.039837 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217863 ==== paxos(logm lease lc 2928955 fc 2928454 pn 0 opn 0 gv {}) v2 ==== 88+0+0 (3942935192 0 0) 0x3950580 con 0x268a9a0
2013-02-17 06:05:05.039864 7faaec18d700  1 -- 10.200.63.133:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(logm lease_ack lc 2928955 fc 2928453 pn 0 opn 0 gv {}) v2 -- ?+0 0x387f8c0
2013-02-17 06:05:05.129923 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217864 ==== paxos(mdsmap lease lc 1 fc 1 pn 0 opn 0 gv {}) v2 ==== 88+0+0 (2330587895 0 0) 0x387f8c0 con 0x268a9a0
2013-02-17 06:05:05.129952 7faaec18d700  1 -- 10.200.63.133:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(mdsmap lease_ack lc 1 fc 1 pn 0 opn 0 gv {}) v2 -- ?+0 0x3950580
2013-02-17 06:05:05.130245 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217865 ==== paxos(monmap lease lc 9 fc 1 pn 0 opn 0 gv {}) v2 ==== 88+0+0 (1303228847 0 0) 0x3950840 con 0x268a9a0
2013-02-17 06:05:05.130263 7faaec18d700  1 -- 10.200.63.133:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(monmap lease_ack lc 9 fc 1 pn 0 opn 0 gv {}) v2 -- ?+0 0x387f8c0
2013-02-17 06:05:05.380504 7faaec18d700  1 -- 10.200.63.133:6789/0 <== client.9968 10.200.63.132:0/1024758 549 ==== mon_subscribe({monmap=10+,osdmap=786}) v2 ==== 42+0+0 (981029754 0 0) 0x27a0c380 con 0x268b600
2013-02-17 06:05:05.380583 7faaec18d700  1 -- 10.200.63.133:6789/0 --> client.9968 10.200.63.132:0/1024758 -- osd_map(786..786 src has 541..786) v3 -- ?+0 0x2c89a00
2013-02-17 06:05:05.380603 7faaec18d700  1 -- 10.200.63.133:6789/0 --> client.9968 10.200.63.132:0/1024758 -- mon_subscribe_ack(300s) v1 -- ?+0 0xc11fd40
2013-02-17 06:05:05.726864 7faaec18d700  1 -- 10.200.63.133:6789/0 <== osd.1 10.200.63.133:6801/21178 16168 ==== mon_get_version(what=osdmap handle=2) v1 ==== 18+0+0 (3896555503 0 0) 0xd3e5860 con 0x268b4a0
2013-02-17 06:05:05.726889 7faaec18d700  1 -- 10.200.63.133:6789/0 --> osd.1 10.200.63.133:6801/21178 -- mon_check_map_ack(handle=2 version=786) v2 -- ?+0 0x4aa4820
2013-02-17 06:05:05.727547 7faaec18d700  1 -- 10.200.63.133:6789/0 <== osd.1 10.200.63.133:6801/21178 16169 ==== osd_boot(osd.1 booted 780 v786) v3 ==== 581+0+0 (2497288980 0 0) 0x8340000 con 0x268b4a0
2013-02-17 06:05:05.727606 7faaec18d700  1 -- 10.200.63.133:6789/0 --> mon.0 10.200.63.130:6789/0 -- forward(osd_boot(osd.1 booted 780 v786) v3) to leader v1 -- ?+0 0x3950840
2013-02-17 06:05:05.812260 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217866 ==== paxos(osdmap begin lc 786 fc 0 pn 40700 opn 0 gv {787=5833350}) v2 ==== 698+0+0 (4074253838 0 0) 0x387f8c0 con 0x268a9a0
2013-02-17 06:05:05.841338 7faaec18d700  1 -- 10.200.63.133:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(osdmap accept lc 786 fc 0 pn 40700 opn 0 gv {}) v2 -- ?+0 0x39b2000
2013-02-17 06:05:05.856277 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217867 ==== paxos(osdmap commit lc 787 fc 0 pn 40700 opn 0 gv {787=5833350}) v2 ==== 698+0+0 (62741733 0 0) 0x3950580 con 0x268a9a0
2013-02-17 06:05:05.905956 7faaec18d700  1 -- 10.200.63.133:6789/0 <== mon.0 10.200.63.130:6789/0 217868 ==== paxos(osdmap lease lc 787 fc 541 pn 0 opn 0 gv {}) v2 ==== 88+0+0 (719158437 0 0) 0x27a74b00 con 0x268a9a0
2013-02-17 06:05:05.905976 7faaec18d700  1 -- 10.200.63.133:6789/0 --> mon.0 10.200.63.130:6789/0 -- paxos(osdmap lease_ack lc 787 fc 541 pn 0 opn 0 gv {}) v2 -- ?+0 0x3950580
2013-02-17 06:05:05.918189 7faaec18d700  1 mon.b5@2(peon).osd e787 e787: 2 osds: 2 up, 2 in

----------------------------------------------------------------------
iostat
----------------------------------------------------------------------

b4:osd.0            load %user %nice  %sys  %iow  %stl %idle  dev rrqm/s wrqm/s    r/s    w/s    rkB/s    wkB/s arq-sz aqu-sz  await  rwait wwait %util
2013-02-17-06:04:04  0.4   1.2   0.0   1.4   0.6   0.0  94.1  sdn    0.0    0.0    9.7   13.7    49.33   126.70  15.00   0.37  15.88   3.77  24.5  10.5
2013-02-17-06:04:19  0.4   1.4   0.0   1.3   0.6   0.0  93.8  sdn    0.0    0.1    2.9   18.2    12.53   171.73  17.49   0.44  20.92   6.98  23.1  11.3
2013-02-17-06:04:34  0.6   1.8   0.0   1.6   0.5   0.0  93.7  sdn    0.0    0.0    2.7   20.3    11.47   169.67  15.80   0.56  14.74   4.00  16.2  11.5
2013-02-17-06:04:49  0.5   1.4   0.0   1.3   0.5   0.0  93.9  sdn    0.0    0.1    2.9   15.0    12.27   157.50  18.93   0.25  26.17   5.45  30.2   7.9
2013-02-17-06:05:04  0.7   2.0   0.0   1.1   1.2   0.0  92.5  sdn    0.0    0.1    7.7   62.7    32.53   498.20  15.09   1.44  20.36  22.43  20.1  22.6
2013-02-17-06:05:19  1.4   1.0   0.0   0.5   8.8   0.0  88.8  sdn    0.0    0.1    2.7  209.8    20.53  3959.80  37.47  89.88 414.63 159.00 417.9  99.9
2013-02-17-06:05:34  1.4   2.0   0.0   1.0   1.3   0.0  93.2  sdn    0.0    1.7    4.8   54.5   544.53   462.63  33.99   4.40 104.45  15.00 112.3  33.8
2013-02-17-06:05:49  1.2   2.2   0.0   1.3   0.6   0.0  93.3  sdn    0.0    0.6    0.0   18.5     0.00   175.90  18.98   0.49  26.44   0.00  26.4  10.1
2013-02-17-06:06:04  1.0   1.2   0.0   1.0   1.1   0.0  93.7  sdn    0.0    1.3    0.6   31.4     2.40   225.17  14.22   1.49  46.48  48.89  46.4  21.9
2013-02-17-06:06:19  0.8   4.0   0.0   1.3   0.7   0.0  90.7  sdn    0.0    0.7    2.1   21.5    16.80   202.60  18.65   0.45  18.95  16.45  19.2  13.1
2013-02-17-06:06:34  1.2   4.4   0.0   1.3   0.9   0.0  90.1  sdn    0.0    0.3    1.5   18.7    45.33   161.67  20.56   0.45  22.45  48.18  20.4  11.1
2013-02-17-06:06:49  1.2   3.4   0.0   1.5   1.0   0.0  90.5  sdn    0.0    0.5    0.7   26.7     3.47   246.93  18.32   1.38  50.61  74.00  50.0  21.0
2013-02-17-06:07:04  1.3   4.1   0.0   1.4   0.7   0.0  90.3  sdn    0.0    0.2    0.9   13.2     4.27   128.00  18.81   0.42  30.19  18.46  31.0  10.9

b4:osd.0-journal    load %user %nice  %sys  %iow  %stl %idle  dev rrqm/s wrqm/s    r/s    w/s    rkB/s    wkB/s arq-sz aqu-sz  await  rwait wwait %util
2013-02-17-06:04:04  0.4   1.2   0.0   1.4   0.6   0.0  94.1  md2    0.0    0.0    0.0    9.3     0.00    96.53  20.69   0.00   0.00   0.00   0.0   0.0
2013-02-17-06:04:19  0.4   1.3   0.0   1.3   0.6   0.0  93.8  md2    0.0    0.0    0.0    7.3     0.00   113.87  31.05   0.00   0.00   0.00   0.0   0.0
2013-02-17-06:04:34  0.6   1.8   0.0   1.6   0.5   0.0  93.7  md2    0.0    0.0    0.0    9.7     0.00   126.67  26.03   0.00   0.00   0.00   0.0   0.0
2013-02-17-06:04:49  0.5   1.4   0.0   1.2   0.5   0.0  93.9  md2    0.0    0.0    0.0    8.7     0.00   125.33  28.92   0.00   0.00   0.00   0.0   0.0
2013-02-17-06:05:04  0.7   2.0   0.0   1.1   1.2   0.0  92.4  md2    0.0    0.0    0.0   19.1     0.00   573.07  59.90   0.00   0.00   0.00   0.0   0.0
2013-02-17-06:05:19  1.4   1.0   0.0   0.5   8.7   0.0  88.8  md2    0.0    0.0    0.0   34.7     0.00  3702.13 213.58   0.00   0.00   0.00   0.0   0.0
2013-02-17-06:05:34  1.4   2.0   0.0   1.0   1.4   0.0  93.1  md2    0.0    0.0    0.0   18.5     0.00   297.07  32.06   0.00   0.00   0.00   0.0   0.0
2013-02-17-06:05:49  1.2   2.1   0.0   1.4   0.6   0.0  93.3  md2    0.0    0.0    0.0   10.5     0.00   124.27  23.59   0.00   0.00   0.00   0.0   0.0
2013-02-17-06:06:04  1.0   1.2   0.0   0.9   1.1   0.0  93.8  md2    0.0    0.0    0.0   15.3     0.00   187.47  24.45   0.00   0.00   0.00   0.0   0.0
2013-02-17-06:06:19  0.8   4.0   0.0   1.3   0.7   0.0  90.8  md2    0.0    0.0    0.0    9.2     0.00   108.80  23.65   0.00   0.00   0.00   0.0   0.0
2013-02-17-06:06:34  1.2   4.4   0.0   1.3   0.9   0.0  90.1  md2    0.0    0.0    0.0   16.0     0.00   170.40  21.30   0.00   0.00   0.00   0.0   0.0
2013-02-17-06:06:49  1.2   3.4   0.0   1.5   1.0   0.0  90.4  md2    0.0    0.0    0.0   11.9     0.00   141.87  23.91   0.00   0.00   0.00   0.0   0.0
2013-02-17-06:07:04  1.3   4.1   0.0   1.4   0.7   0.0  90.4  md2    0.0    0.0    0.0    9.3     0.00   108.53  23.26   0.00   0.00   0.00   0.0   0.0

b5:osd.1            load %user %nice  %sys  %iow  %stl %idle  dev rrqm/s wrqm/s    r/s    w/s    rkB/s    wkB/s arq-sz aqu-sz  await  rwait wwait %util
2013-02-17-06:04:05  0.7   0.1   0.0   0.1   0.7   0.0  98.2  sdg    0.0    0.0    9.4   19.1    48.00   166.17  15.01   1.17  40.89  20.92  50.7  27.2
2013-02-17-06:04:20  0.6   0.1   0.0   0.1   0.6   0.0  98.2  sdg    0.0    0.0    2.7   15.8    10.67   147.00  17.08   0.68  36.64   9.50  41.2  13.5
2013-02-17-06:04:35  0.5   0.2   0.0   0.1   0.7   0.0  98.0  sdg    0.0    0.0    3.2   22.5    13.07   204.63  16.92   1.10  42.77  30.62  44.5  23.1
2013-02-17-06:04:50  0.4   0.1   0.0   0.1   0.4   0.0  98.3  sdg    0.0    0.0    2.7   13.6    10.67   142.43  18.82   0.59  36.39  22.50  39.1  13.1
2013-02-17-06:05:05  0.3   0.1   0.0   0.1   1.1   0.0  97.7  sdg    0.0    0.0    3.0   20.7    11.80   190.57  17.05   0.96  40.48  23.56  42.9  20.1
2013-02-17-06:05:20  1.4   0.7   0.0   0.6   6.2   0.0  91.9  sdg    0.0    0.0    7.1  233.9    30.17  2871.43  24.08  91.60 342.67 132.99 349.1  99.5
2013-02-17-06:05:35  1.1   0.2   0.0   0.1   2.3   0.0  96.8  sdg    0.0    1.5    1.7   73.5    18.93  1111.63  30.09   9.59 247.66  76.00 251.6  49.6
2013-02-17-06:05:50  1.0   0.1   0.0   0.1   0.6   0.0  98.8  sdg    0.0    0.1    0.0   14.6     0.00   144.87  19.84   0.52  35.62   0.00  35.6   9.9
2013-02-17-06:06:05  0.8   0.2   0.0   0.1   1.5   0.0  97.7  sdg    0.0    1.1    2.1   37.9     8.27   297.93  15.31   1.97  49.17  64.84  48.3  30.1
2013-02-17-06:06:20  0.8   0.4   0.0   0.2   0.7   0.0  97.9  sdg    0.0    0.1   11.1   15.1   123.73   137.47  19.89   0.65  24.62  17.07  30.2  22.3
2013-02-17-06:06:35  0.7   0.4   0.0   0.2   1.5   0.0  97.1  sdg    0.0    0.1    9.4   23.7   150.13   223.33  22.54   1.27  38.31  19.79  45.6  26.4
2013-02-17-06:06:50  0.8   0.4   0.0   0.2   1.2   0.0  97.4  sdg    0.0    0.2    8.5   22.5   138.40   188.87  21.11   1.71  55.01  28.35  65.0  30.4
2013-02-17-06:07:05  0.8   0.5   0.0   0.3   1.2   0.0  97.2  sdg    0.0    0.0    7.2   18.4    93.07   185.93  21.80   1.13  44.30  26.02  51.4  30.0

[b5:osd.1-journal not recorded]

----------------------------------------------------------------------
