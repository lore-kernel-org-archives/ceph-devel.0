From: Blair Bethwaite <blair.bethwaite@gmail.com>
Subject: Re: Number of PG per OSD in cluster
Date: Mon, 6 Jul 2015 18:41:40 +1000
Message-ID: <CA+z5DswQxwYDjg5EQ+6meOaTLmUE4h8bg-+SYsWUJ36MFKChFg@mail.gmail.com>
References: <4009181431524961@web9g.yandex.ru> <5553DD77.9060300@redhat.com> <1054521436168173@web15h.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:34129 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbbGFImA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Jul 2015 04:42:00 -0400
Received: by igcsj18 with SMTP id sj18so228564204igc.1
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2015 01:42:00 -0700 (PDT)
In-Reply-To: <1054521436168173@web15h.yandex.ru>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Butkeev Stas <staerist@ya.ru>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-qa@ceph.com" <ceph-qa@ceph.com>, "ceph-maintainers@ceph.com" <ceph-maintainers@ceph.com>

Hi,

Firstly, please show some mailing list decorum and use the appropriate
mailing list (this is a usage related question, so should go to
ceph-users@ceph.com), and please don't spam every single ceph related
list you can find.

Regarding your question, see http://ceph.com/pgcalc/.

Cheers,

On 6 July 2015 at 17:36, Butkeev Stas <staerist@ya.ru> wrote:
> Hello everbody
>
> Could you help me with one question about number of pg in cluster.
> I have next cluster
>
> [10:26]:[root@se087  ~]# ceph osd tree
> ID  WEIGHT    TYPE NAME                        UP/DOWN REWEIGHT PRIMARY-AFFINITY
>  -1 183.00101 root default
>  -2 183.00101     region RU
>  -3  91.50099         datacenter ru-msk-comp1p
>  -9  22.87500             host sf016
>  48   1.90599                 osd.48                up  1.00000          1.00000
>  49   1.90599                 osd.49                up  1.00000          1.00000
>  50   1.90599                 osd.50                up  1.00000          1.00000
>  51   1.90599                 osd.51                up  1.00000          1.00000
>  52   1.90599                 osd.52                up  1.00000          1.00000
>  53   1.90599                 osd.53                up  1.00000          1.00000
>  54   1.90599                 osd.54                up  1.00000          1.00000
>  55   1.90599                 osd.55                up  1.00000          1.00000
>  56   1.90599                 osd.56                up  1.00000          1.00000
>  57   1.90599                 osd.57                up  1.00000          1.00000
>  58   1.90599                 osd.58                up  1.00000          1.00000
>  59   1.90599                 osd.59                up  1.00000          1.00000
> -10  22.87500             host sf049
>  60   1.90599                 osd.60                up  1.00000          1.00000
>  61   1.90599                 osd.61                up  1.00000          1.00000
>  62   1.90599                 osd.62                up  1.00000          1.00000
>  63   1.90599                 osd.63                up  1.00000          1.00000
>  64   1.90599                 osd.64                up  1.00000          1.00000
>  65   1.90599                 osd.65                up  1.00000          1.00000
>  66   1.90599                 osd.66                up  1.00000          1.00000
>  67   1.90599                 osd.67                up  1.00000          1.00000
>  68   1.90599                 osd.68                up  1.00000          1.00000
>  69   1.90599                 osd.69                up  1.00000          1.00000
>  70   1.90599                 osd.70                up  1.00000          1.00000
>  71   1.90599                 osd.71                up  1.00000          1.00000
> -11  22.87500             host sf056
>  72   1.90599                 osd.72                up  1.00000          1.00000
>  73   1.90599                 osd.73                up  1.00000          1.00000
>  74   1.90599                 osd.74                up  1.00000          1.00000
>  75   1.90599                 osd.75                up  1.00000          1.00000
>  76   1.90599                 osd.76                up  1.00000          1.00000
>  77   1.90599                 osd.77                up  1.00000          1.00000
>  78   1.90599                 osd.78                up  1.00000          1.00000
>  79   1.90599                 osd.79                up  1.00000          1.00000
>  80   1.90599                 osd.80                up  1.00000          1.00000
>  81   1.90599                 osd.81                up  1.00000          1.00000
>  82   1.90599                 osd.82                up  1.00000          1.00000
>  83   1.90599                 osd.83                up  1.00000          1.00000
> -12  22.87500             host sf068
>  84   1.90599                 osd.84                up  1.00000          1.00000
>  85   1.90599                 osd.85                up  1.00000          1.00000
>  86   1.90599                 osd.86                up  1.00000          1.00000
>  87   1.90599                 osd.87                up  1.00000          1.00000
>  88   1.90599                 osd.88                up  1.00000          1.00000
>  89   1.90599                 osd.89                up  1.00000          1.00000
>  90   1.90599                 osd.90                up  1.00000          1.00000
>  91   1.90599                 osd.91                up  1.00000          1.00000
>  92   1.90599                 osd.92                up  1.00000          1.00000
>  93   1.90599                 osd.93                up  1.00000          1.00000
>  94   1.90599                 osd.94                up  1.00000          1.00000
>  95   1.90599                 osd.95                up  1.00000          1.00000
>  -4  91.50099         datacenter ru-msk-vol51
>  -5  22.87500             host se087
>   0   1.90599                 osd.0                 up  1.00000          1.00000
>   1   1.90599                 osd.1                 up  1.00000          1.00000
>   2   1.90599                 osd.2                 up  1.00000          1.00000
>   3   1.90599                 osd.3                 up  1.00000          1.00000
>   4   1.90599                 osd.4                 up  1.00000          1.00000
>   5   1.90599                 osd.5                 up  1.00000          1.00000
>   6   1.90599                 osd.6                 up  1.00000          1.00000
>   7   1.90599                 osd.7                 up  1.00000          1.00000
>   8   1.90599                 osd.8                 up  1.00000          1.00000
>   9   1.90599                 osd.9                 up  1.00000          1.00000
>  10   1.90599                 osd.10                up  1.00000          1.00000
>  11   1.90599                 osd.11                up  1.00000          1.00000
>  -6  22.87500             host se088
>  12   1.90599                 osd.12                up  1.00000          1.00000
>  13   1.90599                 osd.13                up  1.00000          1.00000
>  14   1.90599                 osd.14                up  1.00000          1.00000
>  15   1.90599                 osd.15                up  1.00000          1.00000
>  16   1.90599                 osd.16                up  1.00000          1.00000
>  17   1.90599                 osd.17                up  1.00000          1.00000
>  18   1.90599                 osd.18                up  1.00000          1.00000
>  19   1.90599                 osd.19                up  1.00000          1.00000
>  20   1.90599                 osd.20                up  1.00000          1.00000
>  21   1.90599                 osd.21                up  1.00000          1.00000
>  22   1.90599                 osd.22                up  1.00000          1.00000
>  23   1.90599                 osd.23                up  1.00000          1.00000
>  -7  22.87500             host se089
>  24   1.90599                 osd.24                up  1.00000          1.00000
>  25   1.90599                 osd.25                up  1.00000          1.00000
>  26   1.90599                 osd.26                up  1.00000          1.00000
>  27   1.90599                 osd.27                up  1.00000          1.00000
>  28   1.90599                 osd.28                up  1.00000          1.00000
>  29   1.90599                 osd.29                up  1.00000          1.00000
>  30   1.90599                 osd.30                up  1.00000          1.00000
>  31   1.90599                 osd.31                up  1.00000          1.00000
>  32   1.90599                 osd.32                up  1.00000          1.00000
>  33   1.90599                 osd.33                up  1.00000          1.00000
>  34   1.90599                 osd.34                up  1.00000          1.00000
>  35   1.90599                 osd.35                up  1.00000          1.00000
>  -8  22.87500             host se090
>  36   1.90599                 osd.36                up  1.00000          1.00000
>  37   1.90599                 osd.37                up  1.00000          1.00000
>  38   1.90599                 osd.38                up  1.00000          1.00000
>  39   1.90599                 osd.39                up  1.00000          1.00000
>  40   1.90599                 osd.40                up  1.00000          1.00000
>  41   1.90599                 osd.41                up  1.00000          1.00000
>  42   1.90599                 osd.42                up  1.00000          1.00000
>  43   1.90599                 osd.43                up  1.00000          1.00000
>  44   1.90599                 osd.44                up  1.00000          1.00000
>  45   1.90599                 osd.45                up  1.00000          1.00000
>  46   1.90599                 osd.46                up  1.00000          1.00000
>  47   1.90599                 osd.47                up  1.00000          1.00000
>
> total OSD 96.
> I want use ceph + rgw and now I have 10 pools.
> How I can calculate number of pg per OSD with 10 pools?
>
> Thanks in advance for the help.
>
> --
> Best Regards,
> Stanislav Butkeev
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,
~Blairo
