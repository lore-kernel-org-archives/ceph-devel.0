From: Dong Yuan <yuandong1222@gmail.com>
Subject: Re: Problem balancing disk space
Date: Wed, 20 Aug 2014 10:19:28 +0800
Message-ID: <CAMm-wcKA8uP0pcyUh+tMFH=Gt2zze1j=WVRqk2m2AHfmi4j85w@mail.gmail.com>
References: <53F3B6F8.40105@kepler.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f180.google.com ([209.85.220.180]:47125 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbaHTCTa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Aug 2014 22:19:30 -0400
Received: by mail-vc0-f180.google.com with SMTP id ij19so8511555vcb.11
        for <ceph-devel@vger.kernel.org>; Tue, 19 Aug 2014 19:19:29 -0700 (PDT)
In-Reply-To: <53F3B6F8.40105@kepler.cl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alphe Salas <asalas@kepler.cl>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Data balancing is depended on the following items:

1. osd counts, more is better, while 20 may be not enough.
2. PG counts, more is better. you can try to create a new pool with
more PGs than default.
3. Object size, little is better. More objects with little size is
better than less objects with big size.
4. Bucket type in the CrushMap. different bucket type means different
balance algorithm.
5. Maybe other issues.

You can use pg dump command to get details about object counts for
each PG, this may be helpful to locate your problem.

On 20 August 2014 04:43, Alphe Salas <asalas@kepler.cl> wrote:
> Hello,
> for some reasons the balancing of disk space use on OSD is not properly
> working. Can you please give me hint to solve that issue?
>
> it is supposed that the proper difference betwin min and max osd disk space
> use, should be around 20%.
>
> Actually I see that it is more that 40%
>
> follow you will find the list of disk and real use
>
> osd10: Filesystem      Size  Used Avail Use% Mounted on
> osd10: /dev/sda1       1.8T  1.1T  646G  63% /var/lib/ceph/osd/ceph-18
> osd10: Filesystem      Size  Used Avail Use% Mounted on
> osd10: /dev/sdb1       1.8T  1.6T  109G  94% /var/lib/ceph/osd/ceph-19
> osd09: Filesystem      Size  Used Avail Use% Mounted on
> osd09: /dev/sda1       1.8T  1.5T  216G  88% /var/lib/ceph/osd/ceph-16
> osd09: Filesystem      Size  Used Avail Use% Mounted on
> osd09: /dev/sdb1       1.8T  895G  842G  52% /var/lib/ceph/osd/ceph-17
> osd08: Filesystem      Size  Used Avail Use% Mounted on
> osd08: /dev/sda1       1.8T  1.6T  153G  92% /var/lib/ceph/osd/ceph-10
> osd08: Filesystem      Size  Used Avail Use% Mounted on
> osd08: /dev/sdb1       1.8T  1.7T   84G  96% /var/lib/ceph/osd/ceph-11
> osd07: Filesystem      Size  Used Avail Use% Mounted on
> osd07: /dev/sda1       1.8T  1.5T  297G  83% /var/lib/ceph/osd/ceph-14
> osd07: Filesystem      Size  Used Avail Use% Mounted on
> osd07: /dev/sdb1       1.8T  1.5T  268G  85% /var/lib/ceph/osd/ceph-15
> osd06: Filesystem      Size  Used Avail Use% Mounted on
> osd06: /dev/sda1       1.8T  1.6T  193G  89% /var/lib/ceph/osd/ceph-12
> osd06: Filesystem      Size  Used Avail Use% Mounted on
> osd06: /dev/sdb1       1.8T  1.4T  305G  83% /var/lib/ceph/osd/ceph-13
> osd05: Filesystem      Size  Used Avail Use% Mounted on
> osd05: /dev/sda1       1.8T  1.3T  434G  76% /var/lib/ceph/osd/ceph-8
> osd05: Filesystem      Size  Used Avail Use% Mounted on
> osd05: /dev/sdb1       1.8T  1.2T  526G  70% /var/lib/ceph/osd/ceph-9
> osd04: Filesystem      Size  Used Avail Use% Mounted on
> osd04: /dev/sda1       1.8T  1.6T  169G  91% /var/lib/ceph/osd/ceph-6
> osd04: Filesystem      Size  Used Avail Use% Mounted on
> osd04: /dev/sdb1       1.8T  1.4T  313G  82% /var/lib/ceph/osd/ceph-7
> osd03: Filesystem      Size  Used Avail Use% Mounted on
> osd03: /dev/sda1       1.8T  1.6T  195G  89% /var/lib/ceph/osd/ceph-4
> osd03: Filesystem      Size  Used Avail Use% Mounted on
> osd03: /dev/sdb1       1.8T  1.3T  425G  76% /var/lib/ceph/osd/ceph-5
> osd02: Filesystem      Size  Used Avail Use% Mounted on
> osd02: /dev/sda1       1.8T  1.4T  362G  80% /var/lib/ceph/osd/ceph-2
> osd02: Filesystem      Size  Used Avail Use% Mounted on
> osd02: /dev/sdb1       1.8T  1.5T  211G  88% /var/lib/ceph/osd/ceph-3
> osd01: Filesystem      Size  Used Avail Use% Mounted on
> osd01: /dev/sda1       1.8T  1.4T  304G  83% /var/lib/ceph/osd/ceph-0
> osd01: Filesystem      Size  Used Avail Use% Mounted on
> osd01: /dev/sdb1       1.8T  1.3T  456G  74% /var/lib/ceph/osd/ceph-1
>
> ceph health detail gives an inacurate estimation of the problem (the
> percentages are wrong..)
>
> ceph health detail
> HEALTH_WARN 4 near full osd(s)
> osd.6 is near full at 85% (real 91%)
> osd.10 is near full at 86% (real 92%)
> osd.11 is near full at 90% (real 96%)
> osd.19 is near full at 88% (real 94%)
>
>
> Then as you can see on the above disk space use dump I get a usage span from
> 52% to 96%.
>
> The question is how can I force the re balancing. I tryed with ceph osd
> reweight-by-use 108 and still there is this amazing gap.
>
> actual osd tree is
>
> # id    weight  type name       up/down reweight
> -1      35.8    root default
> -2      3.58            host osd01
> 0       1.79                    osd.0   up      1
> 1       1.79                    osd.1   up      0.808
> -3      3.58            host osd02
> 2       1.79                    osd.2   up      0.9193
> 3       1.79                    osd.3   up      1
> -4      3.58            host osd03
> 4       1.79                    osd.4   up      1
> 5       1.79                    osd.5   up      1
> -5      3.58            host osd04
> 6       1.79                    osd.6   up      1
> 7       1.79                    osd.7   up      1
> -6      3.58            host osd05
> 8       1.79                    osd.8   up      0.7892
> 9       1.79                    osd.9   up      0.7458
> -7      3.58            host osd08
> 10      1.79                    osd.10  up      1
> 11      1.79                    osd.11  up      1
> -8      3.58            host osd06
> 12      1.79                    osd.12  up      1
> 13      1.79                    osd.13  up      1
> -9      3.58            host osd07
> 14      1.79                    osd.14  up      1
> 15      1.79                    osd.15  up      1
> -10     3.58            host osd09
> 16      1.79                    osd.16  up      1
> 17      1.79                    osd.17  up      1
> -11     3.58            host osd10
> 18      1.79                    osd.18  up      1
> 19      1.79                    osd.19  up      1
>
> Regards,
>
>
> --
> Alphe Salas
> I.T ingeneer
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Dong Yuan
Email:yuandong1222@gmail.com
