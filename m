From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: cluster io rate is not matching with rbd client IO rate
Date: Mon, 20 Apr 2015 06:26:09 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD7BE36@SACMBXIP01.sdcorp.global.sandisk.com>
References: <59E25171A319194CB0889178D3F1E09A0B88C3A6@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0081.outbound.protection.outlook.com ([157.56.110.81]:11502
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750829AbbDTG0N convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Apr 2015 02:26:13 -0400
In-Reply-To: <59E25171A319194CB0889178D3F1E09A0B88C3A6@SACMBXIP01.sdcorp.global.sandisk.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Srinivasula Maram <Srinivasula.Maram@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,
Could you try with rbd_cache = false in ceph.conf (global section)  and see what is the behavior ?

Thanks & Regards
Somnath

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Srinivasula Maram
Sent: Friday, April 17, 2015 8:15 AM
To: ceph-devel
Subject: cluster io rate is not matching with rbd client IO rate

Hi

Seeing cluster IO rate is not matching with RBD clients IO rate, not able to figure how user data is increasing this much high rate.

As per the ceph health stats: IO on cluster is happening at the rate of 150 MB/s on an average. But user data is increasing at the rate around 3GB/s. Here IO is happening on librbds which are mapped on KVM vms.

Is there any explanation why it is happening like this so?

Thanks,
Srinivas

015-04-17 20:29:46.943142 mon.0 [INF] pgmap v1776398: 8264 pgs: 8264 active+clean; 1614 GB data, 10203 GB used, 147 TB / 157 TB avail; 0 B/s rd, 98510 kB/s wr, 1554 op/s
2015-04-17 20:29:47.963117 mon.0 [INF] pgmap v1776399: 8264 pgs: 8264 active+clean; 1615 GB data, 10203 GB used, 147 TB / 157 TB avail; 0 B/s rd, 97955 kB/s wr, 1549 op/s
2015-04-17 20:29:48.978292 mon.0 [INF] pgmap v1776400: 8264 pgs: 8264 active+clean; 1617 GB data, 10203 GB used, 147 TB / 157 TB avail; 0 B/s rd, 115 MB/s wr, 1874 op/s
2015-04-17 20:29:50.010742 mon.0 [INF] pgmap v1776401: 8264 pgs: 8264 active+clean; 1621 GB data, 10204 GB used, 147 TB / 157 TB avail; 0 B/s rd, 178 MB/s wr, 2878 op/s
2015-04-17 20:29:51.015480 mon.0 [INF] pgmap v1776402: 8264 pgs: 8264 active+clean; 1622 GB data, 10204 GB used, 147 TB / 157 TB avail; 0 B/s rd, 157 MB/s wr, 2563 op/s
2015-04-17 20:29:52.037910 mon.0 [INF] pgmap v1776403: 8264 pgs: 8264 active+clean; 1624 GB data, 10205 GB used, 147 TB / 157 TB avail; 0 B/s rd, 80105 kB/s wr, 1266 op/s
2015-04-17 20:29:53.054741 mon.0 [INF] pgmap v1776404: 8264 pgs: 8264 active+clean; 1625 GB data, 10205 GB used, 147 TB / 157 TB avail; 0 B/s rd, 99071 kB/s wr, 1550 op/s
2015-04-17 20:29:54.066974 mon.0 [INF] pgmap v1776405: 8264 pgs: 8264 active+clean; 1627 GB data, 10205 GB used, 147 TB / 157 TB avail; 0 B/s rd, 108 MB/s wr, 1760 op/s
2015-04-17 20:29:55.112756 mon.0 [INF] pgmap v1776406: 8264 pgs: 8264 active+clean; 1631 GB data, 10206 GB used, 147 TB / 157 TB avail; 0 B/s rd, 173 MB/s wr, 2848 op/s
2015-04-17 20:29:56.139603 mon.0 [INF] pgmap v1776407: 8264 pgs: 8264 active+clean; 1632 GB data, 10206 GB used, 147 TB / 157 TB avail; 0 B/s rd, 151 MB/s wr, 2473 op/s
2015-04-17 20:29:57.169299 mon.0 [INF] pgmap v1776408: 8264 pgs: 8264 active+clean; 1634 GB data, 10207 GB used, 147 TB / 157 TB avail; 0 B/s rd, 92967 kB/s wr, 1481 op/s
2015-04-17 20:29:58.184703 mon.0 [INF] pgmap v1776409: 8264 pgs: 8264 active+clean; 1635 GB data, 10207 GB used, 147 TB / 157 TB avail; 0 B/s rd, 112 MB/s wr, 1835 op/s
2015-04-17 20:29:59.198354 mon.0 [INF] pgmap v1776410: 8264 pgs: 8264 active+clean; 1637 GB data, 10207 GB used, 147 TB / 157 TB avail; 0 B/s rd, 93262 kB/s wr, 1502 op/s
2015-04-17 20:30:00.234921 mon.0 [INF] pgmap v1776411: 8264 pgs: 8264 active+clean; 1641 GB data, 10208 GB used, 147 TB / 157 TB avail; 0 B/s rd, 174 MB/s wr, 2851 op/s
2015-04-17 20:30:01.263929 mon.0 [INF] pgmap v1776412: 8264 pgs: 8264 active+clean; 1642 GB data, 10208 GB used, 147 TB / 157 TB avail; 0 B/s rd, 171 MB/s wr, 2769 op/s
2015-04-17 20:30:02.281171 mon.0 [INF] pgmap v1776413: 8264 pgs: 8264 active+clean; 1644 GB data, 10209 GB used, 147 TB / 157 TB avail; 0 B/s rd, 88814 kB/s wr, 1393 op/s
2015-04-17 20:30:03.301199 mon.0 [INF] pgmap v1776414: 8264 pgs: 8264 active+clean; 1646 GB data, 10209 GB used, 147 TB / 157 TB avail; 0 B/s rd, 118 MB/s wr, 1903 op/s
2015-04-17 20:30:04.312039 mon.0 [INF] pgmap v1776415: 8264 pgs: 8264 active+clean; 1647 GB data, 10209 GB used, 147 TB / 157 TB avail; 0 B/s rd, 102 MB/s wr, 1663 op/s
2015-04-17 20:30:05.342232 mon.0 [INF] pgmap v1776416: 8264 pgs: 8264 active+clean; 1650 GB data, 10210 GB used, 147 TB / 157 TB avail; 0 B/s rd, 125 MB/s wr, 2056 op/s
2015-04-17 20:30:06.348746 mon.0 [INF] pgmap v1776417: 8264 pgs: 8264 active+clean; 1651 GB data, 10210 GB used, 147 TB / 157 TB avail; 0 B/s rd, 127 MB/s wr, 2078 op/s
2015-04-17 20:30:07.366716 mon.0 [INF] pgmap v1776418: 8264 pgs: 8264 active+clean; 1653 GB data, 10210 GB used, 147 TB / 157 TB avail; 0 B/s rd, 96942 kB/s wr, 1566 op/s
2015-04-17 20:30:08.388218 mon.0 [INF] pgmap v1776419: 8264 pgs: 8264 active+clean; 1655 GB data, 10211 GB used, 147 TB / 157 TB avail; 0 B/s rd, 127 MB/s wr, 2089 op/s
2015-04-17 20:30:09.399524 mon.0 [INF] pgmap v1776420: 8264 pgs: 8264 active+clean; 1656 GB data, 10211 GB used, 147 TB / 157 TB avail; 0 B/s rd, 101631 kB/s wr, 1596 op/s
2015-04-17 20:30:10.431556 mon.0 [INF] pgmap v1776421: 8264 pgs: 8264 active+clean; 1659 GB data, 10212 GB used, 147 TB / 157 TB avail; 0 B/s rd, 142 MB/s wr, 2303 op/s
2015-04-17 20:30:11.457734 mon.0 [INF] pgmap v1776422: 8264 pgs: 8264 active+clean; 1660 GB data, 10212 GB used, 147 TB / 157 TB avail; 0 B/s rd, 147 MB/s wr, 2377 op/s
2015-04-17 20:30:12.490209 mon.0 [INF] pgmap v1776423: 8264 pgs: 8264 active+clean; 1662 GB data, 10212 GB used, 147 TB / 157 TB avail; 0 B/s rd, 98258 kB/s wr, 1549 op/s
2015-04-17 20:30:13.509144 mon.0 [INF] pgmap v1776424: 8264 pgs: 8264 active+clean; 1664 GB data, 10213 GB used, 147 TB / 157 TB avail; 0 B/s rd, 127 MB/s wr, 2050 op/s
2015-04-17 20:30:14.527577 mon.0 [INF] pgmap v1776425: 8264 pgs: 8264 active+clean; 1666 GB data, 10213 GB used, 147 TB / 157 TB avail; 0 B/s rd, 127 MB/s wr, 2060 op/s
2015-04-17 20:30:15.549649 mon.0 [INF] pgmap v1776426: 8264 pgs: 8264 active+clean; 1669 GB data, 10214 GB used, 147 TB / 157 TB avail; 0 B/s rd, 141 MB/s wr, 2291 op/s
2015-04-17 20:30:16.576971 mon.0 [INF] pgmap v1776427: 8264 pgs: 8264 active+clean; 1670 GB data, 10214 GB used, 147 TB / 157 TB avail; 0 B/s rd, 123 MB/s wr, 1989 op/s
2015-04-17 20:30:17.607637 mon.0 [INF] pgmap v1776428: 8264 pgs: 8264 active+clean; 1672 GB data, 10214 GB used, 147 TB / 157 TB avail; 0 B/s rd, 106 MB/s wr, 1722 op/s
2015-04-17 20:30:18.639557 mon.0 [INF] pgmap v1776429: 8264 pgs: 8264 active+clean; 1674 GB data, 10214 GB used, 147 TB / 157 TB avail; 0 B/s rd, 117 MB/s wr, 1913 op/s
2015-04-17 20:30:19.659292 mon.0 [INF] pgmap v1776430: 8264 pgs: 8264 active+clean; 1676 GB data, 10215 GB used, 147 TB / 157 TB avail; 0 B/s rd, 120 MB/s wr, 1933 op/s
2015-04-17 20:30:20.679373 mon.0 [INF] pgmap v1776431: 8264 pgs: 8264 active+clean; 1678 GB data, 10215 GB used, 147 TB / 157 TB avail; 0 B/s rd, 144 MB/s wr, 2359 op/s
2015-04-17 20:30:21.692215 mon.0 [INF] pgmap v1776432: 8264 pgs: 8264 active+clean; 1680 GB data, 10216 GB used, 147 TB / 157 TB avail; 0 B/s rd, 126 MB/s wr, 2060 op/s
2015-04-17 20:30:22.712546 mon.0 [INF] pgmap v1776433: 8264 pgs: 8264 active+clean; 1682 GB data, 10216 GB used, 147 TB / 157 TB avail; 0 B/s rd, 119 MB/s wr, 1920 op/s
2015-04-17 20:30:23.730023 mon.0 [INF] pgmap v1776434: 8264 pgs: 8264 active+clean; 1684 GB data, 10217 GB used, 147 TB / 157 TB avail; 0 B/s rd, 126 MB/s wr, 2060 op/s
2015-04-17 20:30:24.758508 mon.0 [INF] pgmap v1776435: 8264 pgs: 8264 active+clean; 1687 GB data, 10217 GB used, 147 TB / 157 TB avail; 0 B/s rd, 161 MB/s wr, 2643 op/s
2015-04-17 20:30:25.772624 mon.0 [INF] pgmap v1776436: 8264 pgs: 8264 active+clean; 1689 GB data, 10218 GB used, 147 TB / 157 TB avail; 0 B/s rd, 161 MB/s wr, 2634 op/s
2015-04-17 20:30:26.785168 mon.0 [INF] pgmap v1776437: 8264 pgs: 8264 active+clean; 1690 GB data, 10218 GB used, 147 TB / 157 TB avail; 0 B/s rd, 103 MB/s wr, 1682 op/s
2015-04-17 20:30:27.804292 mon.0 [INF] pgmap v1776438: 8264 pgs: 8264 active+clean; 1692 GB data, 10218 GB used, 147 TB / 157 TB avail; 0 B/s rd, 102 MB/s wr, 1658 op/s
2015-04-17 20:30:28.821582 mon.0 [INF] pgmap v1776439: 8264 pgs: 8264 active+clean; 1694 GB data, 10219 GB used, 147 TB / 157 TB avail; 0 B/s rd, 120 MB/s wr, 1946 op/s
2015-04-17 20:30:29.860519 mon.0 [INF] pgmap v1776440: 8264 pgs: 8264 active+clean; 1697 GB data, 10219 GB used, 147 TB / 157 TB avail; 0 B/s rd, 162 MB/s wr, 2648 op/s
2015-04-17 20:30:30.869959 mon.0 [INF] pgmap v1776441: 8264 pgs: 8264 active+clean; 1699 GB data, 10219 GB used, 147 TB / 157 TB avail; 0 B/s rd, 158 MB/s wr, 2569 op/s
2015-04-17 20:30:31.980411 mon.0 [INF] pgmap v1776442: 8264 pgs: 8264 active+clean; 1700 GB data, 10220 GB used, 147 TB / 157 TB avail; 0 B/s rd, 96417 kB/s wr, 1519 op/s
2015-04-17 20:30:32.996692 mon.0 [INF] pgmap v1776443: 8264 pgs: 8264 active+clean; 1702 GB data, 10220 GB used, 147 TB / 157 TB avail; 0 B/s rd, 95029 kB/s wr, 1491 op/s
2015-04-17 20:30:34.028737 mon.0 [INF] pgmap v1776444: 8264 pgs: 8264 active+clean; 1704 GB data, 10221 GB used, 147 TB / 157 TB avail; 0 B/s rd, 114 MB/s wr, 1840 op/s
2015-04-17 20:30:35.060611 mon.0 [INF] pgmap v1776445: 8264 pgs: 8264 active+clean; 1708 GB data, 10221 GB used, 147 TB / 157 TB avail; 0 B/s rd, 173 MB/s wr, 2837 op/s
2015-04-17 20:30:36.066565 mon.0 [INF] pgmap v1776446: 8264 pgs: 8264 active+clean; 1709 GB data, 10222 GB used, 147 TB / 157 TB avail; 0 B/s rd, 155 MB/s wr, 2551 op/s
2015-04-17 20:30:37.093112 mon.0 [INF] pgmap v1776447: 8264 pgs: 8264 active+clean; 1710 GB data, 10222 GB used, 147 TB / 157 TB avail; 0 B/s rd, 86432 kB/s wr, 1378 op/s
2015-04-17 20:30:38.108672 mon.0 [INF] pgmap v1776448: 8264 pgs: 8264 active+clean; 1712 GB data, 10222 GB used, 147 TB / 157 TB avail; 0 B/s rd, 97804 kB/s wr, 1577 op/s
2015-04-17 20:30:39.123775 mon.0 [INF] pgmap v1776449: 8264 pgs: 8264 active+clean; 1714 GB data, 10222 GB used, 147 TB / 157 TB avail; 0 B/s rd, 102066 kB/s wr, 1626 op/s
2015-04-17 20:30:40.161998 mon.0 [INF] pgmap v1776450: 8264 pgs: 8264 active+clean; 1718 GB data, 10223 GB used, 147 TB / 157 TB avail; 0 B/s rd, 177 MB/s wr, 2855 op/s

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
