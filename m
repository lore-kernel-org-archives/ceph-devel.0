From: Fyodor Ustinov <ufm@ufm.su>
Subject: read and write speed.
Date: Tue, 31 May 2011 01:50:28 +0300
Message-ID: <4DE41F34.8020504@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:58565 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753781Ab1E3Wuh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 30 May 2011 18:50:37 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.ufm.su (Postfix) with ESMTP id 364DD60048A
	for <ceph-devel@vger.kernel.org>; Tue, 31 May 2011 01:50:35 +0300 (EEST)
Received: from mail.ufm.su ([127.0.0.1])
	by localhost (mail.ufm.su [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rebby2w0aEkY for <ceph-devel@vger.kernel.org>;
	Tue, 31 May 2011 01:50:34 +0300 (EEST)
Received: from [192.168.2.22] (unknown [94.232.181.14])
	by mail.ufm.su (Postfix) with ESMTPSA id ABD8D600484
	for <ceph-devel@vger.kernel.org>; Tue, 31 May 2011 01:50:30 +0300 (EEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi!

Fresh 0.28.2 cluster.

Why reading two times slower than the writing by dd, but rados show 
different.
(Second question - why rados bench crash on read test?)


root@gate0:/mnt# dd if=/dev/zero of=aaa bs=1024000 count=10000
10000+0 records in
10000+0 records out
10240000000 bytes (10 GB) copied, 64.5598 s, 159 MB/s

root@gate0:/mnt# dd if=aaa of=/dev/null bs=1024000
10000+0 records in
10000+0 records out
10240000000 bytes (10 GB) copied, 122.513 s, 83.6 MB/s
root@gate0:/mnt#

root@gate0:/etc/ceph# rados -p test bench 20 write
Maintaining 16 concurrent writes of 4194304 bytes for at least 20 seconds.
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
     0       0         0         0         0         0         -         0
     1      16        47        31   123.966       124  0.445371  0.360663
     2      16        82        66   131.967       140  0.160564   0.32065
     3      16       111        95   126.637       116  0.116967  0.349943
     4      16       142       126    125.97       124  0.176179  0.369969
     5      15       169       154    123.17       112   0.12449  0.411138
     6      16       202       186   123.971       128  0.175033  0.442003
     7      16       241       225   128.541       156  0.163481  0.421575
     8      16       271       255    127.47       120  0.162152  0.444525
     9      16       305       289   128.415       136  0.100893  0.456108
    10      16       337       321   128.371       128  0.107163  0.467081
    11      16       370       354   128.698       132  0.147602  0.455438
    12      16       400       384   127.971       120  0.163287  0.454927
    13      16       433       417   128.279       132  0.176282  0.451909
    14      16       459       443   126.544       104   3.02971  0.465092
    15      16       492       476   126.906       132  0.183307  0.473582
    16      16       523       507   126.722       124  0.170459  0.465038
    17      16       544       528   124.208        84  0.160463  0.462053
    18      16       574       558   123.973       120   0.10411  0.478344
    19      16       607       591   124.395       132  0.126514   0.48624
min lat: 0.095185 max lat: 3.9695 avg lat: 0.488688
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
    20      16       638       622   124.372       124   2.85047  0.488688
Total time run:        20.547165
Total writes made:     639
Write size:            4194304
Bandwidth (MB/sec):    124.397

Average Latency:       0.513493
Max latency:           3.9695
Min latency:           0.095185
root@gate0:/etc/ceph#

root@gate0:/etc/ceph# rados -p test bench 20 seq
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
     0       0         0         0         0         0         -         0
     1      16        58        42   167.966       168  0.085676  0.279929
     2      16       101        85    169.97       172  0.785072  0.323728
     3      16       145       129   171.969       176  0.141833  0.331852
     4      16       193       177   176.969       192   0.75847  0.335484
     5      15       240       225    179.97       192  0.114137  0.332022
     6      16       288       272   181.303       188   0.54563  0.339292
     7      16       335       319   182.256       188  0.531714  0.341969
     8      16       380       364    181.97       180  0.101676  0.339337
     9      16       427       411   182.634       188  0.216583  0.339264
    10      16       471       455   181.968       176  0.803917  0.341281
    11      16       515       499   181.422       176  0.112194  0.343552
    12      16       559       543   180.968       176  0.241835  0.345668
    13      16       600       584    179.66       164  0.088883  0.347034
read got -2
error during benchmark: -5
error 5: Input/output error
root@gate0:/etc/ceph#


WBR,
     Fyodor.
