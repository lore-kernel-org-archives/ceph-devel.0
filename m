From: Butkeev Stas <staerist@ya.ru>
Subject: Number of PG per OSD in cluster
Date: Mon, 06 Jul 2015 10:36:13 +0300
Message-ID: <1054521436168173@web15h.yandex.ru>
References: <4009181431524961@web9g.yandex.ru> <5553DD77.9060300@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from forward20h.cmail.yandex.net ([87.250.230.162]:38594 "EHLO
	forward20h.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754455AbbGFHrq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Jul 2015 03:47:46 -0400
In-Reply-To: <5553DD77.9060300@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-qa@ceph.com" <ceph-qa@ceph.com>, "ceph-maintainers@ceph.com" <ceph-maintainers@ceph.com>

Hello everbody

Could you help me with one question about number of pg in cluster.
I have next cluster

[10:26]:[root@se087  ~]# ceph osd tree
ID  WEIGHT    TYPE NAME                        UP/DOWN REWEIGHT PRIMARY=
-AFFINITY=20
 -1 183.00101 root default                                             =
         =20
 -2 183.00101     region RU                                            =
         =20
 -3  91.50099         datacenter ru-msk-comp1p                         =
         =20
 -9  22.87500             host sf016                                   =
         =20
 48   1.90599                 osd.48                up  1.00000        =
  1.00000=20
 49   1.90599                 osd.49                up  1.00000        =
  1.00000=20
 50   1.90599                 osd.50                up  1.00000        =
  1.00000=20
 51   1.90599                 osd.51                up  1.00000        =
  1.00000=20
 52   1.90599                 osd.52                up  1.00000        =
  1.00000=20
 53   1.90599                 osd.53                up  1.00000        =
  1.00000=20
 54   1.90599                 osd.54                up  1.00000        =
  1.00000=20
 55   1.90599                 osd.55                up  1.00000        =
  1.00000=20
 56   1.90599                 osd.56                up  1.00000        =
  1.00000=20
 57   1.90599                 osd.57                up  1.00000        =
  1.00000=20
 58   1.90599                 osd.58                up  1.00000        =
  1.00000=20
 59   1.90599                 osd.59                up  1.00000        =
  1.00000=20
-10  22.87500             host sf049                                   =
         =20
 60   1.90599                 osd.60                up  1.00000        =
  1.00000=20
 61   1.90599                 osd.61                up  1.00000        =
  1.00000=20
 62   1.90599                 osd.62                up  1.00000        =
  1.00000=20
 63   1.90599                 osd.63                up  1.00000        =
  1.00000=20
 64   1.90599                 osd.64                up  1.00000        =
  1.00000=20
 65   1.90599                 osd.65                up  1.00000        =
  1.00000=20
 66   1.90599                 osd.66                up  1.00000        =
  1.00000=20
 67   1.90599                 osd.67                up  1.00000        =
  1.00000=20
 68   1.90599                 osd.68                up  1.00000        =
  1.00000=20
 69   1.90599                 osd.69                up  1.00000        =
  1.00000=20
 70   1.90599                 osd.70                up  1.00000        =
  1.00000=20
 71   1.90599                 osd.71                up  1.00000        =
  1.00000=20
-11  22.87500             host sf056                                   =
         =20
 72   1.90599                 osd.72                up  1.00000        =
  1.00000=20
 73   1.90599                 osd.73                up  1.00000        =
  1.00000=20
 74   1.90599                 osd.74                up  1.00000        =
  1.00000=20
 75   1.90599                 osd.75                up  1.00000        =
  1.00000=20
 76   1.90599                 osd.76                up  1.00000        =
  1.00000=20
 77   1.90599                 osd.77                up  1.00000        =
  1.00000=20
 78   1.90599                 osd.78                up  1.00000        =
  1.00000=20
 79   1.90599                 osd.79                up  1.00000        =
  1.00000=20
 80   1.90599                 osd.80                up  1.00000        =
  1.00000=20
 81   1.90599                 osd.81                up  1.00000        =
  1.00000=20
 82   1.90599                 osd.82                up  1.00000        =
  1.00000=20
 83   1.90599                 osd.83                up  1.00000        =
  1.00000=20
-12  22.87500             host sf068                                   =
         =20
 84   1.90599                 osd.84                up  1.00000        =
  1.00000=20
 85   1.90599                 osd.85                up  1.00000        =
  1.00000=20
 86   1.90599                 osd.86                up  1.00000        =
  1.00000=20
 87   1.90599                 osd.87                up  1.00000        =
  1.00000=20
 88   1.90599                 osd.88                up  1.00000        =
  1.00000=20
 89   1.90599                 osd.89                up  1.00000        =
  1.00000=20
 90   1.90599                 osd.90                up  1.00000        =
  1.00000=20
 91   1.90599                 osd.91                up  1.00000        =
  1.00000=20
 92   1.90599                 osd.92                up  1.00000        =
  1.00000=20
 93   1.90599                 osd.93                up  1.00000        =
  1.00000=20
 94   1.90599                 osd.94                up  1.00000        =
  1.00000=20
 95   1.90599                 osd.95                up  1.00000        =
  1.00000=20
 -4  91.50099         datacenter ru-msk-vol51                          =
         =20
 -5  22.87500             host se087                                   =
         =20
  0   1.90599                 osd.0                 up  1.00000        =
  1.00000=20
  1   1.90599                 osd.1                 up  1.00000        =
  1.00000=20
  2   1.90599                 osd.2                 up  1.00000        =
  1.00000=20
  3   1.90599                 osd.3                 up  1.00000        =
  1.00000=20
  4   1.90599                 osd.4                 up  1.00000        =
  1.00000=20
  5   1.90599                 osd.5                 up  1.00000        =
  1.00000=20
  6   1.90599                 osd.6                 up  1.00000        =
  1.00000=20
  7   1.90599                 osd.7                 up  1.00000        =
  1.00000=20
  8   1.90599                 osd.8                 up  1.00000        =
  1.00000=20
  9   1.90599                 osd.9                 up  1.00000        =
  1.00000=20
 10   1.90599                 osd.10                up  1.00000        =
  1.00000=20
 11   1.90599                 osd.11                up  1.00000        =
  1.00000=20
 -6  22.87500             host se088                                   =
         =20
 12   1.90599                 osd.12                up  1.00000        =
  1.00000=20
 13   1.90599                 osd.13                up  1.00000        =
  1.00000=20
 14   1.90599                 osd.14                up  1.00000        =
  1.00000=20
 15   1.90599                 osd.15                up  1.00000        =
  1.00000=20
 16   1.90599                 osd.16                up  1.00000        =
  1.00000=20
 17   1.90599                 osd.17                up  1.00000        =
  1.00000=20
 18   1.90599                 osd.18                up  1.00000        =
  1.00000=20
 19   1.90599                 osd.19                up  1.00000        =
  1.00000=20
 20   1.90599                 osd.20                up  1.00000        =
  1.00000=20
 21   1.90599                 osd.21                up  1.00000        =
  1.00000=20
 22   1.90599                 osd.22                up  1.00000        =
  1.00000=20
 23   1.90599                 osd.23                up  1.00000        =
  1.00000=20
 -7  22.87500             host se089                                   =
         =20
 24   1.90599                 osd.24                up  1.00000        =
  1.00000=20
 25   1.90599                 osd.25                up  1.00000        =
  1.00000=20
 26   1.90599                 osd.26                up  1.00000        =
  1.00000=20
 27   1.90599                 osd.27                up  1.00000        =
  1.00000=20
 28   1.90599                 osd.28                up  1.00000        =
  1.00000=20
 29   1.90599                 osd.29                up  1.00000        =
  1.00000=20
 30   1.90599                 osd.30                up  1.00000        =
  1.00000=20
 31   1.90599                 osd.31                up  1.00000        =
  1.00000=20
 32   1.90599                 osd.32                up  1.00000        =
  1.00000=20
 33   1.90599                 osd.33                up  1.00000        =
  1.00000=20
 34   1.90599                 osd.34                up  1.00000        =
  1.00000=20
 35   1.90599                 osd.35                up  1.00000        =
  1.00000=20
 -8  22.87500             host se090                                   =
         =20
 36   1.90599                 osd.36                up  1.00000        =
  1.00000=20
 37   1.90599                 osd.37                up  1.00000        =
  1.00000=20
 38   1.90599                 osd.38                up  1.00000        =
  1.00000=20
 39   1.90599                 osd.39                up  1.00000        =
  1.00000=20
 40   1.90599                 osd.40                up  1.00000        =
  1.00000=20
 41   1.90599                 osd.41                up  1.00000        =
  1.00000=20
 42   1.90599                 osd.42                up  1.00000        =
  1.00000=20
 43   1.90599                 osd.43                up  1.00000        =
  1.00000=20
 44   1.90599                 osd.44                up  1.00000        =
  1.00000=20
 45   1.90599                 osd.45                up  1.00000        =
  1.00000=20
 46   1.90599                 osd.46                up  1.00000        =
  1.00000=20
 47   1.90599                 osd.47                up  1.00000        =
  1.00000

total OSD 96.
I want use ceph + rgw and now I have 10 pools.
How I can calculate number of pg per OSD with 10 pools?

Thanks in advance for the help.

--=9A
Best Regards,
Stanislav Butkeev
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
