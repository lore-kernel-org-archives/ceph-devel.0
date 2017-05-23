From: =?iso-8859-2?Q?=A3ukasz_Chrustek?= <skidoo@tlen.pl>
Subject: Problem with query and any operation on PGs
Date: Tue, 23 May 2017 14:48:18 +0200
Message-ID: <483467685.20170523144818@tlen.pl>
References: <175484591.20170523135449@tlen.pl>
Reply-To: =?iso-8859-2?Q?=A3ukasz_Chrustek?= <skidoo@tlen.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx-out.tlen.pl ([193.222.135.142]:58679 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965158AbdEWMsZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 23 May 2017 08:48:25 -0400
Received: from unknown (HELO [10.0.2.15]) (skidoo@o2.pl@[89.72.161.229])
          (envelope-sender <skidoo@tlen.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <ceph-devel@vger.kernel.org>; 23 May 2017 14:48:18 +0200
In-Reply-To: <175484591.20170523135449@tlen.pl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Cze¶æ,

Hello,

After terrible outage coused by failure of 10Gbit switch, ceph cluster
went  to HEALTH_ERR (three whole storage servers go offline in the same time
and didn't back in short time). After cluster recovery two PGs goto to
incomplite state, I can't them query, and can't do with them anything,
what   would   allow   back  working cluster back. here is strace of
this command: https://pastebin.com/HpNFvR8Z. But... this cluster isn't enteriely off:

[root@cc1 ~]# rbd ls management-vms
os-mongodb1
os-mongodb1-database
os-gitlab-root
os-mongodb1-database2
os-wiki-root
[root@cc1 ~]# rbd ls volumes
^C
[root@cc1 ~]#

and for all mon hosts (don't put all three here)

[root@cc1 ~]# rbd -m 192.168.128.1 list management-vms
os-mongodb1
os-mongodb1-database
os-gitlab-root
os-mongodb1-database2
os-wiki-root
[root@cc1 ~]# rbd -m 192.168.128.1 list volumes
^C
[root@cc1 ~]#

and  all other POOLs from list, except (most important) volumes, I can
list images.

Fanny thing, I can list rbd info for particular image:

[root@cc1 ~]# rbd info
volumes/volume-197602d7-40f9-40ad-b286-cdec688b1497
rbd image 'volume-197602d7-40f9-40ad-b286-cdec688b1497':
        size 20480 MB in 1280 objects
        order 24 (16384 kB objects)
        block_name_prefix: rbd_data.64a21a0a9acf52
        format: 2
        features: layering
        flags:
        parent: images/37bdf0ca-f1f3-46ce-95b9-c04bb9ac8a53@snap
        overlap: 3072 MB

but can't list the whole content of pool volumes.

[root@cc1 ~]# ceph osd pool ls
volumes
images
backups
volumes-ssd-intel-s3700
management-vms
.rgw.root
.rgw.control
.rgw
.rgw.gc
.log
.users.uid
.rgw.buckets.index
.users
.rgw.buckets.extra
.rgw.buckets
volumes-cached
cache-ssd

here is ceph osd tree:

ID  WEIGHT    TYPE NAME            UP/DOWN REWEIGHT PRIMARY-AFFINITY
 -7  20.88388 root ssd-intel-s3700
-11   3.19995     host ssd-stor1
 56   0.79999         osd.56            up  1.00000          1.00000
 57   0.79999         osd.57            up  1.00000          1.00000
 58   0.79999         osd.58            up  1.00000          1.00000
 59   0.79999         osd.59            up  1.00000          1.00000
 -9   2.12999     host ssd-stor2
 60   0.70999         osd.60            up  1.00000          1.00000
 61   0.70999         osd.61            up  1.00000          1.00000
 62   0.70999         osd.62            up  1.00000          1.00000
 -8   2.12999     host ssd-stor3
 63   0.70999         osd.63            up  1.00000          1.00000
 64   0.70999         osd.64            up  1.00000          1.00000
 65   0.70999         osd.65            up  1.00000          1.00000
-10   4.19998     host ssd-stor4
 25   0.70000         osd.25            up  1.00000          1.00000
 26   0.70000         osd.26            up  1.00000          1.00000
 27   0.70000         osd.27            up  1.00000          1.00000
 28   0.70000         osd.28            up  1.00000          1.00000
 29   0.70000         osd.29            up  1.00000          1.00000
 24   0.70000         osd.24            up  1.00000          1.00000
-12   3.41199     host ssd-stor5
 73   0.85300         osd.73            up  1.00000          1.00000
 74   0.85300         osd.74            up  1.00000          1.00000
 75   0.85300         osd.75            up  1.00000          1.00000
 76   0.85300         osd.76            up  1.00000          1.00000
-13   3.41199     host ssd-stor6
 77   0.85300         osd.77            up  1.00000          1.00000
 78   0.85300         osd.78            up  1.00000          1.00000
 79   0.85300         osd.79            up  1.00000          1.00000
 80   0.85300         osd.80            up  1.00000          1.00000
-15   2.39999     host ssd-stor7
 90   0.79999         osd.90            up  1.00000          1.00000
 91   0.79999         osd.91            up  1.00000          1.00000
 92   0.79999         osd.92            up  1.00000          1.00000
 -1 167.69969 root default
 -2  33.99994     host stor1
  6   3.39999         osd.6           down        0          1.00000
  7   3.39999         osd.7             up  1.00000          1.00000
  8   3.39999         osd.8             up  1.00000          1.00000
  9   3.39999         osd.9             up  1.00000          1.00000
 10   3.39999         osd.10          down        0          1.00000
 11   3.39999         osd.11          down        0          1.00000
 69   3.39999         osd.69            up  1.00000          1.00000
 70   3.39999         osd.70            up  1.00000          1.00000
 71   3.39999         osd.71          down        0          1.00000
 81   3.39999         osd.81            up  1.00000          1.00000
 -3  20.99991     host stor2
 13   2.09999         osd.13            up  1.00000          1.00000
 12   2.09999         osd.12            up  1.00000          1.00000
 14   2.09999         osd.14            up  1.00000          1.00000
 15   2.09999         osd.15            up  1.00000          1.00000
 16   2.09999         osd.16            up  1.00000          1.00000
 17   2.09999         osd.17            up  1.00000          1.00000
 18   2.09999         osd.18          down        0          1.00000
 19   2.09999         osd.19            up  1.00000          1.00000
 20   2.09999         osd.20            up  1.00000          1.00000
 21   2.09999         osd.21            up  1.00000          1.00000
 -4  25.00000     host stor3
 30   2.50000         osd.30            up  1.00000          1.00000
 31   2.50000         osd.31            up  1.00000          1.00000
 32   2.50000         osd.32            up  1.00000          1.00000
 33   2.50000         osd.33          down        0          1.00000
 34   2.50000         osd.34            up  1.00000          1.00000
 35   2.50000         osd.35            up  1.00000          1.00000
 66   2.50000         osd.66            up  1.00000          1.00000
 67   2.50000         osd.67            up  1.00000          1.00000
 68   2.50000         osd.68            up  1.00000          1.00000
 72   2.50000         osd.72          down        0          1.00000
 -5  25.00000     host stor4
 44   2.50000         osd.44            up  1.00000          1.00000
 45   2.50000         osd.45            up  1.00000          1.00000
 46   2.50000         osd.46          down        0          1.00000
 47   2.50000         osd.47            up  1.00000          1.00000
  0   2.50000         osd.0             up  1.00000          1.00000
  1   2.50000         osd.1             up  1.00000          1.00000
  2   2.50000         osd.2             up  1.00000          1.00000
  3   2.50000         osd.3             up  1.00000          1.00000
  4   2.50000         osd.4             up  1.00000          1.00000
  5   2.50000         osd.5             up  1.00000          1.00000
 -6  14.19991     host stor5
 48   1.79999         osd.48            up  1.00000          1.00000
 49   1.59999         osd.49            up  1.00000          1.00000
 50   1.79999         osd.50            up  1.00000          1.00000
 51   1.79999         osd.51          down        0          1.00000
 52   1.79999         osd.52            up  1.00000          1.00000
 53   1.79999         osd.53            up  1.00000          1.00000
 54   1.79999         osd.54            up  1.00000          1.00000
 55   1.79999         osd.55            up  1.00000          1.00000
-14  14.39999     host stor6
 82   1.79999         osd.82            up  1.00000          1.00000
 83   1.79999         osd.83            up  1.00000          1.00000
 84   1.79999         osd.84            up  1.00000          1.00000
 85   1.79999         osd.85            up  1.00000          1.00000
 86   1.79999         osd.86            up  1.00000          1.00000
 87   1.79999         osd.87            up  1.00000          1.00000
 88   1.79999         osd.88            up  1.00000          1.00000
 89   1.79999         osd.89            up  1.00000          1.00000
-16  12.59999     host stor7
 93   1.79999         osd.93            up  1.00000          1.00000
 94   1.79999         osd.94            up  1.00000          1.00000
 95   1.79999         osd.95            up  1.00000          1.00000
 96   1.79999         osd.96            up  1.00000          1.00000
 97   1.79999         osd.97            up  1.00000          1.00000
 98   1.79999         osd.98            up  1.00000          1.00000
 99   1.79999         osd.99            up  1.00000          1.00000
-17  21.49995     host stor8
 22   1.59999         osd.22            up  1.00000          1.00000
 23   1.59999         osd.23            up  1.00000          1.00000
 36   2.09999         osd.36            up  1.00000          1.00000
 37   2.09999         osd.37            up  1.00000          1.00000
 38   2.50000         osd.38            up  1.00000          1.00000
 39   2.50000         osd.39            up  1.00000          1.00000
 40   2.50000         osd.40            up  1.00000          1.00000
 41   2.50000         osd.41          down        0          1.00000
 42   2.50000         osd.42            up  1.00000          1.00000
 43   1.59999         osd.43            up  1.00000          1.00000
[root@cc1 ~]#

and ceph health detail:

ceph health detail | grep down
HEALTH_WARN 23 pgs backfilling; 23 pgs degraded; 2 pgs down; 2 pgs
peering; 2 pgs stuck inactive; 25 pgs stuck unclean; 23 pgs
undersized; recovery 176211/14148564 objects degraded (1.245%);
recovery 238972/14148564 objects misplaced (1.689%); noout flag(s) set
pg 1.60 is stuck inactive since forever, current state
down+remapped+peering, last acting [66,69,40]
pg 1.165 is stuck inactive since forever, current state
down+remapped+peering, last acting [37]
pg 1.60 is stuck unclean since forever, current state
down+remapped+peering, last acting [66,69,40]
pg 1.165 is stuck unclean since forever, current state
down+remapped+peering, last acting [37]
pg 1.165 is down+remapped+peering, acting [37]
pg 1.60 is down+remapped+peering, acting [66,69,40]


problematic pgs are 1.165 and 1.60.

Please  advice  how  to  unblock pool volumes and/or make this two pgs
working  -  in a last night and day, when we tried to solve this issue
these pgs are for 100% empty from data.




-- 
Pozdrowienia,
 £ukasz Chrustek

