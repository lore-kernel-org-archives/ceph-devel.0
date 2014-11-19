From: Qiang <wangqiang.hunan@gmail.com>
Subject: Re: Issue: Ceph osd rm one osd cause 30% objects degraded
Date: Wed, 19 Nov 2014 23:30:33 +0800
Message-ID: <546CB799.60505@gmail.com>
References: <546C7F2E.8020207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:34860 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755996AbaKSPan (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Nov 2014 10:30:43 -0500
Received: by mail-pd0-f177.google.com with SMTP id ft15so1047907pdb.36
        for <ceph-devel@vger.kernel.org>; Wed, 19 Nov 2014 07:30:43 -0800 (PST)
Received: from [192.168.1.103] ([111.161.77.227])
        by mx.google.com with ESMTPSA id fv4sm2198142pbd.47.2014.11.19.07.30.42
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Nov 2014 07:30:42 -0800 (PST)
In-Reply-To: <546C7F2E.8020207@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Add more information:

After step4, there are many "restarting backfill on osd.x" in ceph.log

2014-11-19 16:03:37.766787 mon.0 10.16.40.40:6789/0 2460367 : [INF]=20
pgmap v9995708: 8192 pgs: 10 inactive, 15 peering, 8167 active+clean;=20
21280 GB data, 63334 GB used, 209 TB / 270 TB avail; 174 kB/s wr, 26 op=
/s
2014-11-19 16:03:38.446557 osd.39 10.16.40.53:6802/38684 1310 : [INF]=20
3.42a restarting backfill on osd.34 from (0'0,0'0] MAX to 1528'608742
2014-11-19 16:03:38.451568 osd.39 10.16.40.53:6802/38684 1311 : [INF]=20
3.b0a restarting backfill on osd.72 from (0'0,0'0] MAX to 1528'837511
2014-11-19 16:03:38.481297 osd.39 10.16.40.53:6802/38684 1312 : [INF]=20
3.375 restarting backfill on osd.22 from (0'0,0'0] MAX to 1529'103924
2014-11-19 16:03:38.484977 osd.39 10.16.40.53:6802/38684 1313 : [INF]=20
3.b0a restarting backfill on osd.87 from (0'0,0'0] MAX to 1528'837511
2014-11-19 16:03:38.541612 osd.39 10.16.40.53:6802/38684 1314 : [INF]=20
3.b54 restarting backfill on osd.80 from (0'0,0'0] MAX to 1529'598339

Then (28.190%) objects degraded
2014-11-19 16:07:40.324423 mon.1 10.16.40.41:6789/0 12 : [INF] mon.xx=20
calling new monitor election
2014-11-19 16:07:51.003344 mon.0 10.16.40.40:6789/0 2460469 : [INF]=20
pgmap v9995757: 8192 pgs: 4939 active+remapped+wait_backfill, 2=20
active+remapped, 21 active+remapped+backfilling, 765=20
active+recovery_wait, 2122 active+clean, 343 active+recovering; 21281 G=
B=20
data, 64164 GB used, 208 TB / 270 TB avail; 4888 kB/s rd, 2120 kB/s wr,=
=20
398 op/s; 6032032/21397704 objects degraded (28.190%); 2917 MB/s, 18=20
objects/s recovering

Thanks very much.

On 2014=E5=B9=B411=E6=9C=8819=E6=97=A5 19:29, Qiang wrote:
> Hi, Dear ceph-devel
>
> I met a issue:  Ceph osd rm one osd cause 30% objects degraded.
>
> Step 1:
> #created a ssd root
> ceph osd crush add-bucket ssd root
>
> Step 2: Installed a osd.100 failed:
>
> 94    1            osd.94    up    1
> 95    1            osd.95    up    1
> 96    1            osd.96    up    1
> 97    1            osd.97    up    1
> 98    1            osd.98    up    1
> 99    1            osd.99    up    1
> 100    0    osd.100    down    0
>
> Step 3: Installed a osd.101 again successfully.  Move a host into roo=
t=3Dssd.
> -12    1    root ssd
> -13    1        host ssd-cephnode1
> 101    1            osd.101    up    1
> -1    100    root default
> -2    10        host cephnode1
> 0    1            osd.0    up    1
> 1    1            osd.1    up    1
> 2    1            osd.2    up    1
>
> Step 4: Then I ceph osd rm 100, but the the ceph health turned into 3=
0%
> objects degraded. Then the io performance downgrade to very slow (1MB=
/s
> each clients).
>
> Anybody know what is the root cause? Or some suggestions to finger it=
 out?
>
> Thank you very much.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
