From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Luminous RC feedback - device classes and osd df weirdness
Date: Thu, 29 Jun 2017 17:04:26 +1200
Message-ID: <71ce32a8-6232-0f5b-35a5-d86f30a045db@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cat-porwal-prod-mail1.catalyst.net.nz ([202.78.240.226]:46752
        "EHLO cat-porwal-prod-mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751611AbdF2FEb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 29 Jun 2017 01:04:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by cat-porwal-prod-mail1.catalyst.net.nz (Postfix) with ESMTP id 96C89805A3
        for <ceph-devel@vger.kernel.org>; Thu, 29 Jun 2017 17:04:29 +1200 (NZST)
Received: from cat-porwal-prod-mail1.catalyst.net.nz ([127.0.0.1])
        by localhost (cat-porwal-prod-mail1.servers.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jUplqzGUPVwq for <ceph-devel@vger.kernel.org>;
        Thu, 29 Jun 2017 17:04:28 +1200 (NZST)
Received: from [192.168.1.64] (122-61-5-223.jetstream.xtra.co.nz [122.61.5.223])
        (Authenticated sender: mark.kirkwood@catalyst.net.nz)
        by cat-porwal-prod-mail1.catalyst.net.nz (Postfix) with ESMTPSA id 44A55805A1
        for <ceph-devel@vger.kernel.org>; Thu, 29 Jun 2017 17:04:28 +1200 (NZST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I'm running a 4 node test 'cluster' (VMs on my workstation) that I've 
upgraded to Luminous RC. Specifically I wanted to test having each node 
with 1 spinning device and one solid state state so I could try out 
device classes to create fast and slow(er) pools.

I started with 4 filestore osds (comimg from the Jewel pre-upgrade), and 
added 4 more, all of which were Bluestore on the ssds.

I used crushtool to set the device classes (see crush test diff below).

That all went very smoothly, with only a couple of things that seemed 
weird. Firstly the crush/osd tree output is a bit strange (but I could 
get to the point where it make sense):

$ sudo ceph osd tree
ID  WEIGHT  TYPE NAME          UP/DOWN REWEIGHT PRIMARY-AFFINITY
-15 0.23196 root default~ssd
-11 0.05699     host ceph1~ssd
   4 0.05699         osd.4           up  1.00000 1.00000
-12 0.05899     host ceph2~ssd
   5 0.05899         osd.5           up  1.00000 1.00000
-13 0.05699     host ceph3~ssd
   6 0.05699         osd.6           up  1.00000 1.00000
-14 0.05899     host ceph4~ssd
   7 0.05899         osd.7           up  1.00000 1.00000
-10 0.07996 root default~hdd
  -6 0.01999     host ceph1~hdd
   0 0.01999         osd.0           up  1.00000 1.00000
  -7 0.01999     host ceph2~hdd
   1 0.01999         osd.1           up  1.00000 1.00000
  -8 0.01999     host ceph3~hdd
   2 0.01999         osd.2           up  1.00000 1.00000
  -9 0.01999     host ceph4~hdd
   3 0.01999         osd.3           up  1.00000 1.00000
  -1 0.31198 root default
  -2 0.07700     host ceph1
   0 0.01999         osd.0           up  1.00000 1.00000
   4 0.05699         osd.4           up  1.00000 1.00000
  -3 0.07899     host ceph2
   1 0.01999         osd.1           up  1.00000 1.00000
   5 0.05899         osd.5           up  1.00000 1.00000
  -4 0.07700     host ceph3
   2 0.01999         osd.2           up  1.00000 1.00000
   6 0.05699         osd.6           up  1.00000 1.00000
  -5 0.07899     host ceph4
   3 0.01999         osd.3           up  1.00000 1.00000
   7 0.05899         osd.7           up  1.00000 1.00000


But the osd df output is baffling, I've got two identical lines for each 
osd (hard to see immediately - sorting by osd id would make it easier). 
This is not ideal, particularly as for the bluestore guys there is no 
other way to work out utilization. Any ideas - have I done something 
obviously wrong here that is triggering the 2 lines?

$ sudo ceph osd df
ID WEIGHT  REWEIGHT SIZE   USE    AVAIL  %USE VAR  PGS
  4 0.05699  1.00000 60314M  1093M 59221M 1.81 1.27   0
  5 0.05899  1.00000 61586M  1234M 60351M 2.00 1.40   0
  6 0.05699  1.00000 60314M  1248M 59066M 2.07 1.45   0
  7 0.05899  1.00000 61586M  1209M 60376M 1.96 1.37   0
  0 0.01999  1.00000 25586M 43812k 25543M 0.17 0.12  45
  1 0.01999  1.00000 25586M 42636k 25544M 0.16 0.11  37
  2 0.01999  1.00000 25586M 44336k 25543M 0.17 0.12  53
  3 0.01999  1.00000 25586M 42716k 25544M 0.16 0.11  57
  0 0.01999  1.00000 25586M 43812k 25543M 0.17 0.12  45
  4 0.05699  1.00000 60314M  1093M 59221M 1.81 1.27   0
  1 0.01999  1.00000 25586M 42636k 25544M 0.16 0.11  37
  5 0.05899  1.00000 61586M  1234M 60351M 2.00 1.40   0
  2 0.01999  1.00000 25586M 44336k 25543M 0.17 0.12  53
  6 0.05699  1.00000 60314M  1248M 59066M 2.07 1.45   0
  3 0.01999  1.00000 25586M 42716k 25544M 0.16 0.11  57
  7 0.05899  1.00000 61586M  1209M 60376M 1.96 1.37   0
               TOTAL   338G  4955M   333G 1.43
MIN/MAX VAR: 0.11/1.45  STDDEV: 0.97


The modifications to crush map
--- crush.txt.orig    2017-06-28 14:38:38.067669000 +1200
+++ crush.txt    2017-06-28 14:41:22.071669000 +1200
@@ -8,14 +8,14 @@
  tunable allowed_bucket_algs 54

  # devices
-device 0 osd.0
-device 1 osd.1
-device 2 osd.2
-device 3 osd.3
-device 4 osd.4
-device 5 osd.5
-device 6 osd.6
-device 7 osd.7
+device 0 osd.0 class hdd
+device 1 osd.1 class hdd
+device 2 osd.2 class hdd
+device 3 osd.3 class hdd
+device 4 osd.4 class ssd
+device 5 osd.5 class ssd
+device 6 osd.6 class ssd
+device 7 osd.7 class ssd

  # types
  type 0 osd
@@ -80,7 +80,7 @@
      type replicated
      min_size 1
      max_size 10
-    step take default
+    step take default class hdd
      step chooseleaf firstn 0 type host
      step emit
  }

