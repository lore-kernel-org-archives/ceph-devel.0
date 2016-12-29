From: =?iso-8859-2?Q?=A3ukasz_Chrustek?= <skidoo@tlen.pl>
Subject: problem with removing osd
Date: Thu, 29 Dec 2016 16:07:18 +0100
Message-ID: <16310616780.20161229160718@tlen.pl>
Reply-To: =?iso-8859-2?Q?=A3ukasz_Chrustek?= <skidoo@tlen.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx-out.tlen.pl ([193.222.135.148]:19295 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752760AbcL2PeA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 29 Dec 2016 10:34:00 -0500
Received: from unknown (HELO [10.0.2.15]) (skidoo@o2.pl@[91.196.212.101])
          (envelope-sender <skidoo@tlen.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <ceph-devel@vger.kernel.org>; 29 Dec 2016 16:07:18 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I was trying to delete 3 osds from cluster, deletion procces took very
long  time and I interrupted it. mon process then crushed, and in ceph
osd tree (after restart ceph-mon) I saw:

 ~]# ceph osd tree
ID         WEIGHT    TYPE NAME            UP/DOWN REWEIGHT PRIMARY-AFFINITY
        -7  16.89590 root ssd-disks
       -11         0     host ssd1
-231707408         0
     22100         0         osd.22100        DNE        0
        71         0         osd.71           DNE        0


when I tried to delete osd.22100:

[root@cc1 ~]# ceph osd crush remove osd.22100
device 'osd.22100' does not appear in the crush map

then I tried to delete osd.71 and mon proccess crushed:

[root@cc1 ~]# ceph osd crush remove osd.71
2016-12-28 17:52:34.459668 7f426a862700  0 monclient: hunting for new mon

after restart of ceph-mon in ceph osd tree it shows:

# ceph osd tree
ID        WEIGHT    TYPE NAME             UP/DOWN REWEIGHT PRIMARY-AFFINITY
       -7  16.89590 root ssd-disks
      -11         0     host ssd1
598798032         0         osd.598798032     DNE        0
    21940         0         osd.21940         DNE        0
       71         0         osd.71            DNE        0

My question is how to delete this osds without direct editing crushmap
? It is production system, I can't affort any service interruption :(,
when I try to ceph osd crush remove then ceph-mon crushes....

I  dumped  crushmap,  but it took 19G (!!) after decompiling (compiled
file  is  very small). So, I cleaned this file with perl (it take very
long  time), and I have now small txt crushmap, which I edited. But is
there  any  chance  that ceph will still remember somewhere about this
huge  numbers  for osds ? Is it safe to apply this cleaned crushmap to
cluster ?

-- 
Regards
Luk

