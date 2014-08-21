From: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>
Subject: A problem when restarting OSD
Date: Thu, 21 Aug 2014 07:19:47 +0000
Message-ID: <06E7D85B3BA36C4DB207FEDE871C5348936E6B@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:2607 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750951AbaHUHVu convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Aug 2014 03:21:50 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "'ceph-devel@vger.kernel.org'" <ceph-devel@vger.kernel.org>

Hi all,

I ran into a problem when restarting an OSD.

Here is my OSD tree before restarting the OSD:

# id    weight  type name       up/down reweight
-6      8       root ssd
-4      4               host zqw-s1-ssd
16      1                       osd.16  up      1
17      1                       osd.17  up      1
18      1                       osd.18  up      1
19      1                       osd.19  up      1
-5      4               host zqw-s2-ssd
20      1                       osd.20  up      1
21      1                       osd.21  up      1
22      1                       osd.22  up      1
23      1                       osd.23  up      1
-1      14.56   root default
-2      7.28            host zqw-s1
0       0.91                    osd.0   up      1
1       0.91                    osd.1   up      1
2       0.91                    osd.2   up      1
3       0.91                    osd.3   up      1
4       0.91                    osd.4   up      1
5       0.91                    osd.5   up      1
6       0.91                    osd.6   up      1
7       0.91                    osd.7   up      1
-3      7.28            host zqw-s2
8       0.91                    osd.8   up      1
9       0.91                    osd.9   up      1
10      0.91                    osd.10  up      1
11      0.91                    osd.11  up      1
12      0.91                    osd.12  up      1
13      0.91                    osd.13  up      1
14      0.91                    osd.14  up      1
15      0.91                    osd.15  up      1

After I restart one of the OSD with id from 16 to 23, say restarting osd.16, osd.16 goes to 'root default' and 'host zqw-s1', and ceph cluster begins to do rebalance. This surely is not what I want.

# id    weight  type name       up/down reweight
-6      7       root ssd
-4      3               host zqw-s1-ssd
17      1                       osd.17  up      1
18      1                       osd.18  up      1
19      1                       osd.19  up      1
-5      4               host zqw-s2-ssd
20      1                       osd.20  up      1
21      1                       osd.21  up      1
22      1                       osd.22  up      1
23      1                       osd.23  up      1
-1      15.56   root default
-2      8.28            host zqw-s1
0       0.91                    osd.0   up      1
1       0.91                    osd.1   up      1
2       0.91                    osd.2   up      1
3       0.91                    osd.3   up      1
4       0.91                    osd.4   up      1
5       0.91                    osd.5   up      1
6       0.91                    osd.6   up      1
7       0.91                    osd.7   up      1
16      1                       osd.16  up      1
-3      7.28            host zqw-s2
8       0.91                    osd.8   up      1
9       0.91                    osd.9   up      1
10      0.91                    osd.10  up      1
11      0.91                    osd.11  up      1
12      0.91                    osd.12  up      1
13      0.91                    osd.13  up      1
14      0.91                    osd.14  up      1
15      0.91                    osd.15  up      1

After digging into the problem, I find it's because in the ceph init script, we change the OSD's crush location in some way. It uses the script 'ceph-crush-location' to get the crush location from the ceph.conf file for the restarting OSD. If there isn't such an entry in ceph.conf, it uses the default one 'host=$(hostname -s) root=default'. Since I don't have the crush location configuration in my ceph.conf (I guess most of people don't have this in their ceph.conf), when I restarting osd.16, it goes to 'root default' and 'host zqw-s1'.

Here is a fix for this:
When the ceph init script uses 'ceph osd crush create-or-move' to change the OSD's crush location, do a check first, if this OSD is already existing in the crush map, return without making the location change. This change is at: https://github.com/wonzhq/ceph/commit/efdfa23664caa531390d141bd1539878761412fe

What do you think?
