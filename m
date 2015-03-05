From: Mark Nelson <mnelson@redhat.com>
Subject: pool distribution quality report script
Date: Wed, 04 Mar 2015 22:11:57 -0600
Message-ID: <54F7D78D.2090200@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46910 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751066AbbCEEMB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 4 Mar 2015 23:12:01 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Hi All,

Recently some folks showed interest in gathering pool distribution 
statistics and I remembered I wrote a script to do that a while back. 
It was broken due to a change in the ceph pg dump output format that was 
committed a while back, so I cleaned the script up, added detection of 
header fields, automatic json support, and also added in calculation of 
expected max and min PGs per OSD and std deviation.

The script is available here:

https://github.com/ceph/ceph-tools/blob/master/cbt/tools/readpgdump.py

Some general comments:

1) Expected numbers are derived by treating PGs and OSDs as a 
balls-in-buckets problem ala Raab & Steger:

http://www14.in.tum.de/personen/raab/publ/balls.pdf

2) You can invoke it either by passing it a file or stdout, ie:

ceph pg dump -f json | ./readpgdump.py

or

./readpgdump.py ~/pgdump.out


3) Here's a snippet of some of some sample output from a 210 OSD 
cluster.  Does this output make sense to people?  Is it useful?

> [nhm@burnupiX tools]$ ./readpgdump.py ~/pgdump.out
> +----------------------------------------------------------------------------+
> | Detected input as plain                                                    |
> +----------------------------------------------------------------------------+
>
> +----------------------------------------------------------------------------+
> | Pool ID: 681                                                               |
> +----------------------------------------------------------------------------+
> | Participating OSDs: 210                                                    |
> | Participating PGs: 4096                                                    |
> +----------------------------------------------------------------------------+
> | OSDs in Primary Role (Acting)                                              |
> | Expected PGs Per OSD: Min: 4, Max: 33, Mean: 19.5, Std Dev: 7.2            |
> | Actual PGs Per OSD: Min: 7, Max: 43, Mean: 19.5, Std Dev: 6.5              |
> | 5 Most Subscribed OSDs: 199(43), 175(36), 149(34), 167(32), 20(31)         |
> | 5 Least Subscribed OSDs: 121(7), 46(7), 70(8), 94(9), 122(9)               |
> | Avg Deviation from Most Subscribed OSD: 54.6%                              |
> +----------------------------------------------------------------------------+
> | OSDs in Secondary Role (Acting)                                            |
> | Expected PGs Per OSD: Min: 18, Max: 59, Mean: 39.0, Std Dev: 10.2          |
> | Actual PGs Per OSD: Min: 17, Max: 61, Mean: 39.0, Std Dev: 9.7             |
> | 5 Most Subscribed OSDs: 44(61), 14(60), 2(59), 167(59), 164(57)            |
> | 5 Least Subscribed OSDs: 35(17), 31(20), 37(20), 145(20), 16(20)           |
> | Avg Deviation from Most Subscribed OSD: 36.0%                              |
> +----------------------------------------------------------------------------+
> | OSDs in All Roles (Acting)                                                 |
> | Expected PGs Per OSD: Min: 32, Max: 83, Mean: 58.5, Std Dev: 12.5          |
> | Actual PGs Per OSD: Min: 29, Max: 93, Mean: 58.5, Std Dev: 14.6            |
> | 5 Most Subscribed OSDs: 199(93), 175(92), 44(92), 167(91), 14(91)          |
> | 5 Least Subscribed OSDs: 121(29), 35(30), 47(30), 131(32), 145(32)         |
> | Avg Deviation from Most Subscribed OSD: 37.1%                              |
> +----------------------------------------------------------------------------+
> | OSDs in Primary Role (Up)                                                  |
> | Expected PGs Per OSD: Min: 4, Max: 33, Mean: 19.5, Std Dev: 7.2            |
> | Actual PGs Per OSD: Min: 7, Max: 43, Mean: 19.5, Std Dev: 6.5              |
> | 5 Most Subscribed OSDs: 199(43), 175(36), 149(34), 167(32), 20(31)         |
> | 5 Least Subscribed OSDs: 121(7), 46(7), 70(8), 94(9), 122(9)               |
> | Avg Deviation from Most Subscribed OSD: 54.6%                              |
> +----------------------------------------------------------------------------+
> | OSDs in Secondary Role (Up)                                                |
> | Expected PGs Per OSD: Min: 18, Max: 59, Mean: 39.0, Std Dev: 10.2          |
> | Actual PGs Per OSD: Min: 17, Max: 61, Mean: 39.0, Std Dev: 9.7             |
> | 5 Most Subscribed OSDs: 44(61), 14(60), 2(59), 167(59), 164(57)            |
> | 5 Least Subscribed OSDs: 35(17), 31(20), 37(20), 145(20), 16(20)           |
> | Avg Deviation from Most Subscribed OSD: 36.0%                              |
> +----------------------------------------------------------------------------+
> | OSDs in All Roles (Up)                                                     |
> | Expected PGs Per OSD: Min: 32, Max: 83, Mean: 58.5, Std Dev: 12.5          |
> | Actual PGs Per OSD: Min: 29, Max: 93, Mean: 58.5, Std Dev: 14.6            |
> | 5 Most Subscribed OSDs: 199(93), 175(92), 44(92), 167(91), 14(91)          |
> | 5 Least Subscribed OSDs: 121(29), 35(30), 47(30), 131(32), 145(32)         |
> | Avg Deviation from Most Subscribed OSD: 37.1%                              |
> +----------------------------------------------------------------------------+

This is shown for all the pools, followed by the totals:

> +----------------------------------------------------------------------------+
> | Pool ID: Totals (All Pools)                                                |
> +----------------------------------------------------------------------------+
> | Participating OSDs: 210                                                    |
> | Participating PGs: 131072                                                  |
> +----------------------------------------------------------------------------+
> | OSDs in Primary Role (Acting)                                              |
> | Expected PGs Per OSD: Min: 542, Max: 705, Mean: 624.0, Std Dev: 40.8       |
> | Actual PGs Per OSD: Min: 356, Max: 917, Mean: 624.0, Std Dev: 176.2        |
> | 5 Most Subscribed OSDs: 167(917), 123(876), 23(873), 194(869), 60(868)     |
> | 5 Least Subscribed OSDs: 117(356), 155(358), 46(361), 78(361), 70(362)     |
> | Avg Deviation from Most Subscribed OSD: 32.0%                              |
> +----------------------------------------------------------------------------+
> | OSDs in Secondary Role (Acting)                                            |
> | Expected PGs Per OSD: Min: 1132, Max: 1363, Mean: 1248.0, Std Dev: 57.8    |
> | Actual PGs Per OSD: Min: 864, Max: 1554, Mean: 1248.0, Std Dev: 229.9      |
> | 5 Most Subscribed OSDs: 182(1554), 142(1552), 4(1548), 123(1544), 100(1540)|
> | 5 Least Subscribed OSDs: 16(864), 55(885), 18(885), 42(885), 85(891)       |
> | Avg Deviation from Most Subscribed OSD: 19.7%                              |
> +----------------------------------------------------------------------------+
> | OSDs in All Roles (Acting)                                                 |
> | Expected PGs Per OSD: Min: 1730, Max: 2013, Mean: 1872.0, Std Dev: 70.7    |
> | Actual PGs Per OSD: Min: 1252, Max: 2420, Mean: 1872.0, Std Dev: 402.0     |
> | 5 Most Subscribed OSDs: 123(2420), 142(2403), 195(2390), 100(2389), 182(2380)|
> | 5 Least Subscribed OSDs: 55(1252), 42(1268), 16(1271), 85(1271), 155(1275) |
> | Avg Deviation from Most Subscribed OSD: 22.6%                              |
> +----------------------------------------------------------------------------+
> | OSDs in Primary Role (Up)                                                  |
> | Expected PGs Per OSD: Min: 542, Max: 705, Mean: 624.0, Std Dev: 40.8       |
> | Actual PGs Per OSD: Min: 356, Max: 917, Mean: 624.0, Std Dev: 176.2        |
> | 5 Most Subscribed OSDs: 167(917), 123(876), 23(873), 194(869), 60(868)     |
> | 5 Least Subscribed OSDs: 117(356), 155(358), 46(361), 78(361), 70(362)     |
> | Avg Deviation from Most Subscribed OSD: 32.0%                              |
> +----------------------------------------------------------------------------+
> | OSDs in Secondary Role (Up)                                                |
> | Expected PGs Per OSD: Min: 1132, Max: 1363, Mean: 1248.0, Std Dev: 57.8    |
> | Actual PGs Per OSD: Min: 864, Max: 1554, Mean: 1248.0, Std Dev: 229.9      |
> | 5 Most Subscribed OSDs: 182(1554), 142(1552), 4(1548), 123(1544), 100(1540)|
> | 5 Least Subscribed OSDs: 16(864), 55(885), 18(885), 42(885), 85(891)       |
> | Avg Deviation from Most Subscribed OSD: 19.7%                              |
> +----------------------------------------------------------------------------+
> | OSDs in All Roles (Up)                                                     |
> | Expected PGs Per OSD: Min: 1730, Max: 2013, Mean: 1872.0, Std Dev: 70.7    |
> | Actual PGs Per OSD: Min: 1252, Max: 2420, Mean: 1872.0, Std Dev: 402.0     |
> | 5 Most Subscribed OSDs: 123(2420), 142(2403), 195(2390), 100(2389), 182(2380)|
> | 5 Least Subscribed OSDs: 55(1252), 42(1268), 16(1271), 85(1271), 155(1275) |
> | Avg Deviation from Most Subscribed OSD: 22.6%                              |
> +----------------------------------------------------------------------------+

