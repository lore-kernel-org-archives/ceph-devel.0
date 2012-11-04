From: Aleksey Samarin <nrg3tik@gmail.com>
Subject: poor performance
Date: Sun, 4 Nov 2012 13:58:31 +0400
Message-ID: <CAFjNkqRPC7MDm86LBYCD+reXePNjWzZBPz7yPn9pv553TYHPjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:50224 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056Ab2KDJ6b (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Nov 2012 04:58:31 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so6752316iea.19
        for <ceph-devel@vger.kernel.org>; Sun, 04 Nov 2012 01:58:31 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all

Im planning use ceph for cloud storage.
My test setup is 2 servers connected via infiniband 40Gb, 6x2Tb disks per node.
Centos 6.2
Ceph 0.52 from http://ceph.com/rpms/el6/x86_64
This is my config http://pastebin.com/Pzxafnsm
journal on tmpfs
well, im create bench pool and test it:
ceph osd pool create bench
rados -p bench bench 30 write

 Total time run:         43.258228
 Total writes made:      151
 Write size:             4194304
 Bandwidth (MB/sec):     13.963
 Stddev Bandwidth:       26.307
 Max bandwidth (MB/sec): 128
 Min bandwidth (MB/sec): 0
 Average Latency:        4.48605
 Stddev Latency:         8.17709
 Max latency:            29.7957
 Min latency:            0.039435

when i do rados -p bench bench 30 seq
 Total time run:        20.626935
 Total reads made:     275
 Read size:            4194304
 Bandwidth (MB/sec):    53.328
 Average Latency:       1.19754
 Max latency:           7.0215
 Min latency:           0.011647

I tested the single drive via dd if=/dev/zero of=/mnt/hdd2/testfile
bs=1024k count=20000
result:  158 MB/sec

Anyone can tell me why such a weak performance? Maybe I missed something?

All the best, Alex!
