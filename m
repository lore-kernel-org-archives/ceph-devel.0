From: Alphe Salas <asalas@kepler.cl>
Subject: Problem balancing disk space
Date: Tue, 19 Aug 2014 16:43:36 -0400
Message-ID: <53F3B6F8.40105@kepler.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:51520 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbaHSUno (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Aug 2014 16:43:44 -0400
Received: by mail-qc0-f173.google.com with SMTP id w7so6719921qcr.4
        for <ceph-devel@vger.kernel.org>; Tue, 19 Aug 2014 13:43:41 -0700 (PDT)
Received: from [192.168.0.44] ([200.111.172.141])
        by mx.google.com with ESMTPSA id n20sm36888556qar.38.2014.08.19.13.43.38
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Aug 2014 13:43:39 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello,
for some reasons the balancing of disk space use on OSD is not properly 
working. Can you please give me hint to solve that issue?

it is supposed that the proper difference betwin min and max osd disk 
space use, should be around 20%.

Actually I see that it is more that 40%

follow you will find the list of disk and real use

osd10: Filesystem      Size  Used Avail Use% Mounted on
osd10: /dev/sda1       1.8T  1.1T  646G  63% /var/lib/ceph/osd/ceph-18
osd10: Filesystem      Size  Used Avail Use% Mounted on
osd10: /dev/sdb1       1.8T  1.6T  109G  94% /var/lib/ceph/osd/ceph-19
osd09: Filesystem      Size  Used Avail Use% Mounted on
osd09: /dev/sda1       1.8T  1.5T  216G  88% /var/lib/ceph/osd/ceph-16
osd09: Filesystem      Size  Used Avail Use% Mounted on
osd09: /dev/sdb1       1.8T  895G  842G  52% /var/lib/ceph/osd/ceph-17
osd08: Filesystem      Size  Used Avail Use% Mounted on
osd08: /dev/sda1       1.8T  1.6T  153G  92% /var/lib/ceph/osd/ceph-10
osd08: Filesystem      Size  Used Avail Use% Mounted on
osd08: /dev/sdb1       1.8T  1.7T   84G  96% /var/lib/ceph/osd/ceph-11
osd07: Filesystem      Size  Used Avail Use% Mounted on
osd07: /dev/sda1       1.8T  1.5T  297G  83% /var/lib/ceph/osd/ceph-14
osd07: Filesystem      Size  Used Avail Use% Mounted on
osd07: /dev/sdb1       1.8T  1.5T  268G  85% /var/lib/ceph/osd/ceph-15
osd06: Filesystem      Size  Used Avail Use% Mounted on
osd06: /dev/sda1       1.8T  1.6T  193G  89% /var/lib/ceph/osd/ceph-12
osd06: Filesystem      Size  Used Avail Use% Mounted on
osd06: /dev/sdb1       1.8T  1.4T  305G  83% /var/lib/ceph/osd/ceph-13
osd05: Filesystem      Size  Used Avail Use% Mounted on
osd05: /dev/sda1       1.8T  1.3T  434G  76% /var/lib/ceph/osd/ceph-8
osd05: Filesystem      Size  Used Avail Use% Mounted on
osd05: /dev/sdb1       1.8T  1.2T  526G  70% /var/lib/ceph/osd/ceph-9
osd04: Filesystem      Size  Used Avail Use% Mounted on
osd04: /dev/sda1       1.8T  1.6T  169G  91% /var/lib/ceph/osd/ceph-6
osd04: Filesystem      Size  Used Avail Use% Mounted on
osd04: /dev/sdb1       1.8T  1.4T  313G  82% /var/lib/ceph/osd/ceph-7
osd03: Filesystem      Size  Used Avail Use% Mounted on
osd03: /dev/sda1       1.8T  1.6T  195G  89% /var/lib/ceph/osd/ceph-4
osd03: Filesystem      Size  Used Avail Use% Mounted on
osd03: /dev/sdb1       1.8T  1.3T  425G  76% /var/lib/ceph/osd/ceph-5
osd02: Filesystem      Size  Used Avail Use% Mounted on
osd02: /dev/sda1       1.8T  1.4T  362G  80% /var/lib/ceph/osd/ceph-2
osd02: Filesystem      Size  Used Avail Use% Mounted on
osd02: /dev/sdb1       1.8T  1.5T  211G  88% /var/lib/ceph/osd/ceph-3
osd01: Filesystem      Size  Used Avail Use% Mounted on
osd01: /dev/sda1       1.8T  1.4T  304G  83% /var/lib/ceph/osd/ceph-0
osd01: Filesystem      Size  Used Avail Use% Mounted on
osd01: /dev/sdb1       1.8T  1.3T  456G  74% /var/lib/ceph/osd/ceph-1

ceph health detail gives an inacurate estimation of the problem (the 
percentages are wrong..)

ceph health detail
HEALTH_WARN 4 near full osd(s)
osd.6 is near full at 85% (real 91%)
osd.10 is near full at 86% (real 92%)
osd.11 is near full at 90% (real 96%)
osd.19 is near full at 88% (real 94%)


Then as you can see on the above disk space use dump I get a usage span 
from 52% to 96%.

The question is how can I force the re balancing. I tryed with ceph osd 
reweight-by-use 108 and still there is this amazing gap.

actual osd tree is

# id    weight  type name       up/down reweight
-1      35.8    root default
-2      3.58            host osd01
0       1.79                    osd.0   up      1
1       1.79                    osd.1   up      0.808
-3      3.58            host osd02
2       1.79                    osd.2   up      0.9193
3       1.79                    osd.3   up      1
-4      3.58            host osd03
4       1.79                    osd.4   up      1
5       1.79                    osd.5   up      1
-5      3.58            host osd04
6       1.79                    osd.6   up      1
7       1.79                    osd.7   up      1
-6      3.58            host osd05
8       1.79                    osd.8   up      0.7892
9       1.79                    osd.9   up      0.7458
-7      3.58            host osd08
10      1.79                    osd.10  up      1
11      1.79                    osd.11  up      1
-8      3.58            host osd06
12      1.79                    osd.12  up      1
13      1.79                    osd.13  up      1
-9      3.58            host osd07
14      1.79                    osd.14  up      1
15      1.79                    osd.15  up      1
-10     3.58            host osd09
16      1.79                    osd.16  up      1
17      1.79                    osd.17  up      1
-11     3.58            host osd10
18      1.79                    osd.18  up      1
19      1.79                    osd.19  up      1

Regards,


-- 
Alphe Salas
I.T ingeneer
