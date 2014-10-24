From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: Write path analysis
Date: Fri, 24 Oct 2014 01:59:42 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F2822FEE2@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0075.outbound.protection.outlook.com ([157.56.111.75]:47520
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753593AbaJXB7u convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Oct 2014 21:59:50 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,
I have a 24 OSDs (all SSD) in a cluster node and I have created/mapped three 500GB images from 3 clients (1 each) with krbd. Replication factor is default (and changed to OSD since it is one node) .I ran the following fio script in parallel from 3 clients. As usual, I was seeing very dismal and bursty write performance (~1500K aggregated at peak).


[random-write]
ioengine=libaio
iodepth=64
filename=/dev/rbd1
rw=randwrite
bs=64k
direct=1
size=500G
numjobs=1


I was trying to analyze what is wrong with OSD and found out most of the OSDs with ~0 or max 1 thread running. So, it is clear that not enough data coming from upstream as in that case at least messenger threads would have been running !

Now, I tried to look 'ifstat' output and here it is for the cluster node.


       p2p1
KB/s in  KB/s out
113072.4   1298.51
100719.1   1185.05
114284.6   1324.86
178834.0   2099.69
211549.1   2376.65
29087.41    366.01
12456.08    174.72
1347.05     23.78
    1.01      3.68
    0.23      3.68
    1.08      4.43
    2.26      4.91
    0.76      3.88
69746.51    862.42
40927.77    491.73
60142.53    733.56
40593.33    500.36
50403.06    622.71
108577.1   1303.91
158618.9   1804.28
90437.46   1027.48
136244.7   1510.99
    0.54      3.95
    0.63      3.68
    0.24      3.75
    6.25      3.83
    0.74      3.68
    6.69      4.07
44616.63    547.42
63502.84    757.72
73507.45    852.72
230326.2   2528.38
157839.6   1802.30
189603.3   2122.25
82581.25    965.03
69347.60    799.37
118248.8   1368.59
70940.87    878.81
64014.78    773.66
97979.96   1134.85
150346.3   1631.18
84263.38    979.29
60342.13    730.17
156632.1   1791.12
176290.1   2062.07
120000.4   1347.99
30044.77    387.37
24333.55    324.90


So, you can see the bursty nature of the input to the cluster with periodic almost 0 KB input ! Highest from 3 clients you can see ~136244 KB ! Avg ~ 70MB and i.e ~1.5 iops !!

Now, here is the ifstat output for each client...

KB/s in  KB/s out
  439.23  37158.15
  699.95  59996.60
  898.57  80079.19
  397.90  31781.98
  324.35  27080.31
  127.05   9881.72
  244.84  20227.26
  233.70  19354.52
  338.95  27615.55
  212.83  17676.74
  458.11  39036.19
  694.03  59962.72
  479.04  41417.99
  379.50  31310.14
  403.29  34267.78
  511.71  44812.89
  370.45  32521.25
   94.49   7327.94
    1.11      0.51
    0.18      0.30
    0.63      0.30
    0.18      0.30
    1.33      1.48
    0.40      0.30
    0.40      0.30
    0.12      0.30
    5.76    336.43
  215.43  17002.90
  279.08  23719.46
   59.93   4638.77
  119.04   9073.26
    0.18      0.30
    1.99      0.30
    3.09      0.30
    0.47      0.37
    0.12      0.30
    1.39      0.30
   49.03   3831.99
  200.24  15390.87
  338.71  28017.09
  873.73  76383.56

Again, the similar pattern and avg ~say 25MB or so !!!
We can argue about increasing about num_jobs/iodepth etc. , that may improve the flow a bit but with the similar fio config read flow will be vastly different (I will post it when I will be testing RR). Lot more 'data in' to the cluster I would guess.

So, I think the major bottleneck for write could be in client (krbd client in this case) not in the OSD layer (?)..Let me know if I am missing anything.
Will fio push the data depending on how fast IO completion is happening ?

Thanks & Regards
Somnath

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

