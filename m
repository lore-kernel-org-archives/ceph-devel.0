From: Sage Weil <sage@inktank.com>
Subject: Re: Slow request in XFS
Date: Thu, 31 Jan 2013 04:43:14 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301310441590.11107@cobra.newdream.net>
References: <6F3FA899187F0043BA1827A69DA2F7CC5EA81F@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34308 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763Ab3AaMnP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Jan 2013 07:43:15 -0500
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC5EA81F@SHSMSX102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi-

Can you reproduce this with logs?  It looks like there are a few ops that 
are hanging for a very long time, but there isn't enough information here 
except to point to osds 610, 612, 615, and 68...

thanks!
s

On Thu, 31 Jan 2013, Chen, Xiaoxi wrote:

> Hi list,
> 	I just rebuild my ceph setup with 6 nodes, (20 sata+ 4 ssd as journal +10GbE ) per node,software stack is Ubuntu 12.10+ Kernel 3.6.3 + xfs+ceph 0.56.2. Before build up ceph cluster , I have checked all my disks can reach 90MB+/s for sequential write and 100MB+/s for sequential read, and the BWs are stable.
> 	Per nhm's suggestion, before I do any test on top of RBD, I run the rados bench gen got the following strange result, it has BW at first but then some of the requests hang there for a lot of time, and from osd you can see slow requests.The cluster is idle except for rados bench.
> 	Any inputs are highly appreciate.Thanks a lot ~
> 
> root@ceph-1:~# rados bench -p data 30 write
>  Maintaining 16 concurrent writes of 4194304 bytes for at least 30 seconds.
>  Object prefix: benchmark_data_ceph-1_39426
>    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
>      0       0         0         0         0         0         -         0
>      1      16        57        41   163.951       164  0.071567 0.0978894
>      2      16        57        41   81.9807         0         - 0.0978894
>      3      16        57        41   54.6555         0         - 0.0978894
>      4      16        57        41   40.9921         0         - 0.0978894
>      5      16        57        41    32.794         0         - 0.0978894
>      6      16        57        41   27.3285         0         - 0.0978894
>      7      16        57        41   23.4245         0         - 0.0978894
>      8      16        57        41   20.4965         0         - 0.0978894
>      9      16        57        41   18.2192         0         - 0.0978894
>     10      16        57        41   16.3973         0         - 0.0978894
>     11      16        57        41   14.9067         0         - 0.0978894
>     12      16        57        41   13.6645         0         - 0.0978894
>     13      16        57        41   12.6134         0         - 0.0978894
>     14      16        57        41   11.7124         0         - 0.0978894
>     15      16        57        41   10.9316         0         - 0.0978894
>     16      16        57        41   10.2484         0         - 0.0978894
>     17      16        57        41   9.64559         0         - 0.0978894
>     18      16        57        41   9.10974         0         - 0.0978894
>     19      16        57        41   8.63028         0         - 0.0978894
> 2013-01-31 19:25:55.282796min lat: 0.070066 max lat: 0.150938 avg lat: 0.0978894
>    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
>     20      16        57        41   8.19878         0         - 0.0978894
>     21      16        57        41   7.80834         0         - 0.0978894
>     22      16        57        41   7.45342         0         - 0.0978894
>     23      16        57        41   7.12936         0         - 0.0978894
>     24      16        57        41   6.83232         0         - 0.0978894
>     25      16        57        41   6.55903         0         - 0.0978894
>     26      16        57        41   6.30676         0         - 0.0978894
>     27      16        57        41   6.07318         0         - 0.0978894
>     28      16        57        41   5.85628         0         - 0.0978894
>     29      16        57        41   5.65435         0         - 0.0978894
>     30      16        57        41   5.46587         0         - 0.0978894
>     31      16        57        41   5.28955         0         - 0.0978894
>     32      16        57        41   5.12426         0         - 0.0978894
>     33      16        57        41   4.96898         0         - 0.0978894
>     34      16        57        41   4.82283         0         - 0.0978894
>     35      16        57        41   4.68504         0         - 0.0978894
>     36      16        57        41    4.5549         0         - 0.0978894
>     37      16        57        41    4.4318         0         - 0.0978894
>     38      16        57        41   4.31517         0         - 0.0978894
>     39      16        57        41   4.20452         0         - 0.0978894
> 2013-01-31 19:26:15.285538min lat: 0.070066 max lat: 0.150938 avg lat: 0.0978894
>    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
>     40      16        57        41   4.09941         0         - 0.0978894
>     41      16        57        41   3.99942         0         - 0.0978894
>     42      16        57        41    3.9042         0         - 0.0978894
>     43      16        57        41   3.81341         0         - 0.0978894
>     44      16        57        41   3.72674         0         - 0.0978894
>     45      16        57        41   3.64392         0         - 0.0978894
>     46      16        57        41   3.56471         0         - 0.0978894
>     47      16        57        41   3.48886         0         - 0.0978894
>     48      16        57        41   3.41618         0         - 0.0978894
>     49      16        57        41   3.34646         0         - 0.0978894
>     50      15        58        43   3.43951  0.163265   0.07674   1.22647
>     51      15        58        43   3.37207         0         -   1.22647
>     52      15        58        43   3.30722         0         -   1.22647
>     53      15        58        43   3.24482         0         -   1.22647
>     54      15        58        43   3.18473         0         -   1.22647
>     55      15        58        43   3.12683         0         -   1.22647
>     56      15        58        43     3.071         0         -   1.22647
>     57      15        58        43   3.01712         0         -   1.22647
>     58      15        58        43    2.9651         0         -   1.22647
>     59      15        58        43   2.91484         0         -   1.22647
> 2013-01-31 19:26:35.288266min lat: 0.070066 max lat: 48.648 avg lat: 1.22647
>    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
>     60      15        58        43   2.86626         0         -   1.22647
>     61      15        58        43   2.81927         0         -   1.22647
>     62      15        58        43    2.7738         0         -   1.22647
>     63      15        58        43   2.72977         0         -   1.22647
>     64      15        58        43   2.68712         0         -   1.22647
>     65      15        58        43   2.64578         0         -   1.22647
>     66      15        58        43   2.60569         0         -   1.22647
>     67      15        58        43    2.5668         0         -   1.22647
>     68      15        58        43   2.52905         0         -   1.22647
>     69      15        58        43    2.4924         0         -   1.22647
>     70      15        58        43   2.45679         0         -   1.22647
>     71      15        58        43   2.42219         0         -   1.22647
>     72      15        58        43   2.38855         0         -   1.22647
>     73      15        58        43   2.35583         0         -   1.22647
>     74      15        58        43   2.32399         0         -   1.22647
>     75      13        58        45   2.39966      0.32   73.9839   4.45992
>     76      13        58        45   2.36809         0         -   4.45992
>     77      13        58        45   2.33733         0         -   4.45992
>     78      13        58        45   2.30737         0         -   4.45992
>     79      13        58        45   2.27816         0         -   4.45992
> 2013-01-31 19:26:55.291112min lat: 0.070066 max lat: 73.9839 avg lat: 4.45992
>    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
>     80      13        58        45   2.24968         0         -   4.45992
>     81      13        58        45   2.22191         0         -   4.45992
>     82      13        58        45   2.19481         0         -   4.45992
>     83      13        58        45   2.16837         0         -   4.45992
>     84      13        58        45   2.14255         0         -   4.45992
>     85      13        58        45   2.11735         0         -   4.45992
>     86      13        58        45   2.09273         0         -   4.45992
>     87      13        58        45   2.06867         0         -   4.45992
>     88      13        58        45   2.04517         0         -   4.45992
>     89      13        58        45   2.02219         0         -   4.45992
>     90      13        58        45   1.99972         0         -   4.45992
>     91      13        58        45   1.97774         0         -   4.45992
>     92      13        58        45   1.95625         0         -   4.45992
>     93      13        58        45   1.93521         0         -   4.45992
>     94      13        58        45   1.91462         0         -   4.45992
>     95      13        58        45   1.89447         0         -   4.45992
>     96      13        58        45   1.87474         0         -   4.45992
>     97      13        58        45   1.85541         0         -   4.45992
>     98      13        58        45   1.83647         0         -   4.45992
>     99      13        58        45   1.81792         0         -   4.45992
> 2013-01-31 19:27:15.293969min lat: 0.070066 max lat: 73.9839 avg lat: 4.45992
>    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
>    100      13        58        45   1.79975         0         -   4.45992
>    101      13        58        45   1.78193         0         -   4.45992
>    102      13        58        45   1.76446         0         -   4.45992
>    103      13        58        45   1.74732         0         -   4.45992
>    104      13        58        45   1.73052         0         -   4.45992
>    105      13        58        45   1.71404         0         -   4.45992
>    106      13        58        45   1.69787         0         -   4.45992
>    107      13        58        45     1.682         0         -   4.45992
>    108      13        58        45   1.66643         0         -   4.45992
>    109      13        58        45   1.65114         0         -   4.45992
>    110      13        58        45   1.63613         0         -   4.45992
>    111      13        58        45   1.62139         0         -   4.45992
>    112      13        58        45   1.60691         0         -   4.45992
>    113      13        58        45   1.59269         0         -   4.45992
>    114      13        58        45   1.57872         0         -   4.45992
>    115      13        58        45     1.565         0         -   4.45992
>    116      13        58        45    1.5515         0         -   4.45992
>    117      13        58        45   1.53824         0         -   4.45992
>    118      13        58        45   1.52521         0         -   4.45992
>    119      13        58        45   1.51239         0         -   4.45992
> 2013-01-31 19:27:35.296900min lat: 0.070066 max lat: 73.9839 avg lat: 4.45992
>    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
>    120      13        58        45   1.49979         0         -   4.45992
>    121      13        58        45   1.48739         0         -   4.45992
>    122      13        58        45    1.4752         0         -   4.45992
>    123      13        58        45   1.46321         0         -   4.45992
>    124      13        58        45    1.4514         0         -   4.45992
>    125      13        58        45   1.43979         0         -   4.45992
>    126      13        58        45   1.42837         0         -   4.45992
>    127      13        58        45   1.41712         0         -   4.45992
>    128      13        58        45   1.40605         0         -   4.45992
>    129      13        58        45   1.39515         0         -   4.45992
>    130      13        58        45   1.38442         0         -   4.45992
>    131      13        58        45   1.37385         0         -   4.45992
>    132      13        58        45   1.36344         0         -   4.45992
>    133      13        58        45   1.35319         0         -   4.45992
>    134      13        58        45   1.34309         0         -   4.45992
>    135      13        58        45   1.33314         0         -   4.45992
>    136      13        58        45   1.32334         0         -   4.45992
>    137      13        58        45   1.31368         0         -   4.45992
>    138      13        58        45   1.30416         0         -   4.45992
>    139      13        58        45   1.29478         0         -   4.45992
> 2013-01-31 19:27:55.299876min lat: 0.070066 max lat: 73.9839 avg lat: 4.45992
>    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
>    140      13        58        45   1.28553         0         -   4.45992
>    141      13        58        45   1.27641         0         -   4.45992
>    142      13        58        45   1.26742         0         -   4.45992
>    143      13        58        45   1.25856         0         -   4.45992
>    144      13        58        45   1.24982         0         -   4.45992
>    145      13        58        45    1.2412         0         -   4.45992
>    146      13        58        45    1.2327         0         -   4.45992
>    147      13        58        45   1.22431         0         -   4.45992
>    148      13        58        45   1.21604         0         -   4.45992
>    149      13        58        45   1.20788         0         -   4.45992
>    150      13        58        45   1.19983         0         -   4.45992
>    151      13        58        45   1.19188         0         -   4.45992
>    152      13        58        45   1.18404         0         -   4.45992
>    153      13        58        45    1.1763         0         -   4.45992
>    154      13        58        45   1.16866         0         -   4.45992
>    155      13        58        45   1.16112         0         -   4.45992
>    156      13        58        45   1.15368         0         -   4.45992
>    157      13        58        45   1.14633         0         -   4.45992
>    158      13        58        45   1.13908         0         -   4.45992
>    159      13        58        45   1.13191         0         -   4.45992
> 2013-01-31 19:28:15.302677min lat: 0.070066 max lat: 73.9839 avg lat: 4.45992
>    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
>    160      13        58        45   1.12484         0         -   4.45992
>    161      13        58        45   1.11785         0         -   4.45992
>    162      13        58        45   1.11095         0         -   4.45992
>    163      13        58        45   1.10414         0         -   4.45992
>    164      13        58        45    1.0974         0         -   4.45992
>    165      13        58        45   1.09075         0         -   4.45992
>    166      13        58        45   1.08418         0         -   4.45992
>    167      13        58        45   1.07769         0         -   4.45992
>    168      13        58        45   1.07128         0         -   4.45992
>    169      13        58        45   1.06494         0         -   4.45992
>    170      13        58        45   1.05867         0         -   4.45992
>    171       3        58        55   1.28637  0.416667   170.042   34.5177
>    172       3        58        55   1.27889         0         -   34.5177
>    173       3        58        55   1.27149         0         -   34.5177
>    174       3        58        55   1.26419         0         -   34.5177
>    175       3        58        55   1.25696         0         -   34.5177
>    176       3        58        55   1.24982         0         -   34.5177
>    177       3        58        55   1.24276         0         -   34.5177
>    178       3        58        55   1.23578         0         -   34.5177
>    179       3        58        55   1.22887         0         -   34.5177
> 2013-01-31 19:28:35.305621min lat: 0.070066 max lat: 170.042 avg lat: 34.5177
>    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
>    180       3        58        55   1.22205         0         -   34.5177
>    181       3        58        55    1.2153         0         -   34.5177
>    182       3        58        55   1.20862         0         -   34.5177
>    183       3        58        55   1.20201         0         -   34.5177
>    184       3        58        55   1.19548         0         -   34.5177
>    185       3        58        55   1.18902         0         -   34.5177
>    186       3        58        55   1.18263         0         -   34.5177
>    187       3        58        55    1.1763         0         -   34.5177
>    188       3        58        55   1.17004         0         -   34.5177
>    189       3        58        55   1.16385         0         -   34.5177
>    190       3        58        55   1.15773         0         -   34.5177
>    191       3        58        55   1.15167         0         -   34.5177
>    192       3        58        55   1.14567         0         -   34.5177
>    193       3        58        55   1.13973         0         -   34.5177
>    194       3        58        55   1.13386         0         -   34.5177
>    195       3        58        55   1.12804         0         -   34.5177
>    196       3        58        55   1.12229         0         -   34.5177
>    197       3        58        55   1.11659         0         -   34.5177
>    198       3        58        55   1.11095         0         -   34.5177
>    199       3        58        55   1.10537         0         -   34.5177
> 2013-01-31 19:28:55.308524min lat: 0.070066 max lat: 170.042 avg lat: 34.5177
>    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
>    200       3        58        55   1.09984         0         -   34.5177
>    201       3        58        55   1.09437         0         -   34.5177
>    202       3        58        55   1.08895         0         -   34.5177
>    203       3        58        55   1.08359         0         -   34.5177
>    204       3        58        55   1.07828         0         -   34.5177
>    205       3        58        55   1.07302         0         -   34.5177
>    206       3        58        55   1.06781         0         -   34.5177
>    207       3        58        55   1.06265         0         -   34.5177
>    208       3        58        55   1.05754         0         -   34.5177
>    209       3        58        55   1.05248         0         -   34.5177
>    210       3        58        55   1.04747         0         -   34.5177
>    211       3        58        55    1.0425         0         -   34.5177
>    212       3        58        55   1.03759         0         -   34.5177
>    213       3        58        55   1.03272         0         -   34.5177
>    214       3        58        55   1.02789         0         -   34.5177
>    215       3        58        55   1.02311         0         -   34.5177
>    216       3        58        55   1.01837         0         -   34.5177
>    217       3        58        55   1.01368         0         -   34.5177
>    218       3        58        55   1.00903         0         -   34.5177
>    219       3        58        55   1.00442         0         -   34.5177
> 2013-01-31 19:29:15.311388min lat: 0.070066 max lat: 170.042 avg lat: 34.5177
>    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
>    220       3        58        55  0.999856         0         -   34.5177
>    221       3        58        55  0.995332         0         -   34.5177
>    222       3        58        55  0.990849         0         -   34.5177
>    223       3        58        55  0.986405         0         -   34.5177
>    224       3        58        55  0.982002         0         -   34.5177
>    225       3        58        55  0.977637         0         -   34.5177
>    226       3        58        55  0.973312         0         -   34.5177
>    227       3        58        55  0.969024         0         -   34.5177
>    228       3        58        55  0.964774         0         -   34.5177
>    229       3        58        55  0.960561         0         -   34.5177
>    230       3        58        55  0.956384         0         -   34.5177
>    231       3        58        55  0.952244         0         -   34.5177
>    232       3        58        55   0.94814         0         -   34.5177
>    233       3        58        55  0.944071         0         -   34.5177
>    234       3        58        55  0.940036         0         -   34.5177
>    235       3        58        55  0.936036         0         -   34.5177
>    236       3        58        55   0.93207         0         -   34.5177
>    237       3        58        55  0.928137         0         -   34.5177
>    238       3        58        55  0.924237         0         -   34.5177
>    239       3        58        55   0.92037         0         -   34.5177
> 2013-01-31 19:29:35.314257min lat: 0.070066 max lat: 170.042 avg lat: 34.5177
>    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
>    240       3        58        55  0.916535         0         -   34.5177
>    241       3        58        55  0.912732         0         -   34.5177
>    242       3        58        55   0.90896         0         -   34.5177
>    243       3        58        55   0.90522         0         -   34.5177
>    244       3        58        55   0.90151         0         -   34.5177
>    245       3        58        55   0.89783         0         -   34.5177
>    246       3        58        55   0.89418         0         -   34.5177
>    247       3        58        55   0.89056         0         -   34.5177
>    248       3        58        55  0.886969         0         -   34.5177
>    249       3        58        55  0.883407         0         -   34.5177
>    250       3        58        55  0.879874         0         -   34.5177
>    251       3        58        55  0.876368         0         -   34.5177
>    252       3        58        55   0.87289         0         -   34.5177
>    253       3        58        55   0.86944         0         -   34.5177
>    254       3        58        55  0.866017         0         -   34.5177
>    255       3        58        55  0.862621         0         -   34.5177
>    256       3        58        55  0.859252         0         -   34.5177
>    257       3        58        55  0.855908         0         -   34.5177
>    258       3        58        55  0.852591         0         -   34.5177
>    259       3        58        55  0.849299         0         -   34.5177
> 2013-01-31 19:29:55.317178min lat: 0.070066 max lat: 170.042 avg lat: 34.5177
>    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
>    260       3        58        55  0.846032         0         -   34.5177
>    261       3        58        55  0.842791         0         -   34.5177
>    262       3        58        55  0.839574         0         -   34.5177
>    263       3        58        55  0.836382         0         -   34.5177
>    264       3        58        55  0.833213         0         -   34.5177
>    265       3        58        55  0.830069         0         -   34.5177
>    266       3        58        55  0.826949         0         -   34.5177
>    267       3        58        55  0.823851         0         -   34.5177
>    268       3        58        55  0.820777         0         -   34.5177
>    269       3        58        55  0.817726         0         -   34.5177
>    270       3        58        55  0.814698         0         -   34.5177
>    271       3        58        55  0.811691         0         -   34.5177
>    272       3        58        55  0.808707         0         -   34.5177
>    273       3        58        55  0.805745         0         -   34.5177
>    274       3        58        55  0.802804         0         -   34.5177
>    275       3        58        55  0.799885         0         -   34.5177
>    276       3        58        55  0.796987         0         -   34.5177
>    277       3        58        55   0.79411         0         -   34.5177
>    278       3        58        55  0.791253         0         -   34.5177
>    279       3        58        55  0.788417         0         -   34.5177
> 2013-01-31 19:30:15.320112min lat: 0.070066 max lat: 170.042 avg lat: 34.5177
>    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
>    280       3        58        55  0.785601         0         -   34.5177
>    281       3        58        55  0.782805         0         -   34.5177
>    282       3        58        55  0.780029         0         -   34.5177
>    283       3        58        55  0.777273         0         -   34.5177
>    284       3        58        55  0.774536         0         -   34.5177
>    285       3        58        55  0.771819         0         -   34.5177
>    286       3        58        55   0.76912         0         -   34.5177
>    287       3        58        55   0.76644         0         -   34.5177
>    288       3        58        55  0.763779         0         -   34.5177
>    289       3        58        55  0.761136         0         -   34.5177
>    290       3        58        55  0.758511         0         -   34.5177
>    291       3        58        55  0.755905         0         -   34.5177
>    292       3        58        55  0.753316         0         -   34.5177
>    293       3        58        55  0.750745         0         -   34.5177
>    294       3        58        55  0.748191         0         -   34.5177
>    295       3        58        55  0.745655         0         -   34.5177
>    296       3        58        55  0.743136         0         -   34.5177
>    297       3        58        55  0.740634         0         -   34.5177
>    298       3        58        55  0.738149         0         -   34.5177
>  Total time run:         298.962451
> Total writes made:      58
> Write size:             4194304
> Bandwidth (MB/sec):     0.776 
> 
> Stddev Bandwidth:       9.48424
> Max bandwidth (MB/sec): 164
> Min bandwidth (MB/sec): 0
> Average Latency:        48.189
> Stddev Latency:         87.3356
> Max latency:            298.961
> Min latency:            0.070066
> 
> 
> 
> 
> 
> 
> Below is the output of ceph -w
> root@ceph-2:/data/osd.21/current# ceph -w
>    health HEALTH_OK
>    monmap e1: 1 mons at {ceph1=192.101.11.120:6789/0}, election epoch 2, quorum 0 ceph1
>    osdmap e92: 120 osds: 120 up, 120 in
>     pgmap v1375: 23232 pgs: 23232 active+clean; 0 bytes data, 8163 MB used, 83787 GB / 83795 GB avail
>    mdsmap e1: 0/0/1 up
> 
> 2013-01-31 19:25:07.898527 mon.0 [INF] pgmap v1375: 23232 pgs: 23232 active+clean; 0 bytes data, 8163 MB used, 83787 GB / 83795 GB avail
> 2013-01-31 19:25:35.931347 mon.0 [INF] pgmap v1376: 23232 pgs: 23232 active+clean; 8192 KB data, 8163 MB used, 83787 GB / 83795 GB avail
> 2013-01-31 19:25:36.999098 mon.0 [INF] pgmap v1377: 23232 pgs: 23232 active+clean; 57344 KB data, 8175 MB used, 83787 GB / 83795 GB avail
> 2013-01-31 19:25:38.074841 mon.0 [INF] pgmap v1378: 23232 pgs: 23232 active+clean; 69632 KB data, 8179 MB used, 83787 GB / 83795 GB avail
> 2013-01-31 19:25:39.201283 mon.0 [INF] pgmap v1379: 23232 pgs: 23232 active+clean; 90112 KB data, 8211 MB used, 83787 GB / 83795 GB avail
> 2013-01-31 19:25:40.243968 mon.0 [INF] pgmap v1380: 23232 pgs: 23232 active+clean; 132 MB data, 8284 MB used, 83787 GB / 83795 GB avail
> 2013-01-31 19:25:41.303049 mon.0 [INF] pgmap v1381: 23232 pgs: 23232 active+clean; 164 MB data, 8332 MB used, 83787 GB / 83795 GB avail
> 2013-01-31 19:25:45.630344 mon.0 [INF] pgmap v1382: 23232 pgs: 23232 active+clean; 164 MB data, 8336 MB used, 83787 GB / 83795 GB avail
> 2013-01-31 19:26:01.793346 mon.0 [INF] pgmap v1383: 23232 pgs: 23232 active+clean; 164 MB data, 8340 MB used, 83787 GB / 83795 GB avail
> 2013-01-31 19:26:05.293101 osd.25 [WRN] 1 slow requests, 1 included below; oldest blocked for > 30.005692 secs
> 2013-01-31 19:26:05.293110 osd.25 [WRN] slow request 30.005692 seconds old, received at 2013-01-31 19:25:35.287275: osd_op(client.4240.0:8 benchmark_data_ceph-1_39426_object7 [write 0~4194304] 0.69848840) v4 currently waiting for subops from [610]
> 2013-01-31 19:26:05.600533 osd.114 [WRN] 1 slow requests, 1 included below; oldest blocked for > 30.107983 secs
> 2013-01-31 19:26:05.600542 osd.114 [WRN] slow request 30.107983 seconds old, received at 2013-01-31 19:25:35.492449: osd_op(client.4240.0:35 benchmark_data_ceph-1_39426_object34 [write 0~4194304] 0.9abc7139) v4 currently waiting for subops from [68]
> 2013-01-31 19:26:08.949329 mon.0 [INF] pgmap v1384: 23232 pgs: 23232 active+clean; 164 MB data, 8344 MB used, 83787 GB / 83795 GB avail
> 2013-01-31 19:26:10.875142 mon.0 [INF] pgmap v1385: 23232 pgs: 23232 active+clean; 164 MB data, 8348 MB used, 83787 GB / 83795 GB avail
> 2013-01-31 19:26:06.358717 osd.516 [WRN] 1 slow requests, 1 included below; oldest blocked for > 30.857906 secs
> 2013-01-31 19:26:06.358727 osd.516 [WRN] slow request 30.857906 seconds old, received at 2013-01-31 19:25:35.500724: osd_op(client.4240.0:38 benchmark_data_ceph-1_39426_object37 [write 0~4194304] 0.666b9194) v4 currently waiting for subops from [612]
> 2013-01-31 19:26:05.415806 osd.518 [WRN] 1 slow requests, 1 included below; oldest blocked for > 30.129037 secs
> 2013-01-31 19:26:05.415824 osd.518 [WRN] slow request 30.129037 seconds old, received at 2013-01-31 19:25:35.286662: osd_op(client.4240.0:7 benchmark_data_ceph-1_39426_object6 [write 0~4194304] 0.baa4121c) v4 currently waiting for subops from [615]
> 2013-01-31 19:26:06.857152 osd.414 [WRN] 1 slow requests, 1 included below; oldest blocked for > 30.890407 secs
> 2013-01-31 19:26:06.857162 osd.414 [WRN] slow request 30.890407 seconds old, received at 2013-01-31 19:25:35.966641: osd_op(client.4240.0:57 benchmark_data_ceph-1_39426_object56 [write 0~4194304] 0.2b691f11) v4 currently waiting for subops from [620]
> 2013-01-31 19:26:27.376824 mon.0 [INF] pgmap v1386: 23232 pgs: 23232 active+clean; 168 MB data, 8356 MB used, 83787 GB / 83795 GB avail
> 2013-01-31 19:26:28.552513 mon.0 [INF] pgmap v1387: 23232 pgs: 23232 active+clean; 172 MB data, 8360 MB used, 83787 GB / 83795 GB avail
> 2013-01-31 19:26:29.578534 mon.0 [INF] pgmap v1388: 23232 pgs: 23232 active+clean; 176 MB data, 8364 MB used, 83787 GB / 83795 GB avail
> 2013-01-31 19:26:30.829351 mon.0 [INF] pgmap v1389: 23232 pgs: 23232 active+clean; 176 MB data, 8368 MB used, 83787 GB / 83795 GB avail
> 2013-01-31 19:26:33.155823 mon.0 [INF] pgmap v1390: 23232 pgs: 23232 active+clean; 180 MB data, 8368 MB used, 83787 GB / 83795 GB avail
> 2013-01-31 19:26:35.298090 osd.25 [WRN] 1 slow requests, 1 included below; oldest blocked for > 60.010747 secs
> 2013-01-31 19:26:35.298102 osd.25 [WRN] slow request 60.010747 seconds old, received at 2013-01-31 19:25:35.287275: osd_op(client.4240.0:8 benchmark_data_ceph-1_39426_object7 [write 0~4194304] 0.69848840) v4 currently waiting for subops from [610]
> 2013-01-31 19:26:35.605458 osd.114 [WRN] 1 slow requests, 1 included below; oldest blocked for > 60.112920 secs
> 2013-01-31 19:26:35.605469 osd.114 [WRN] slow request 60.112920 seconds old, received at 2013-01-31 19:25:35.492449: osd_op(client.4240.0:35 benchmark_data_ceph-1_39426_object34 [write 0~4194304] 0.9abc7139) v4 currently waiting for subops from [68]
> 2013-01-31 19:26:38.552453 mon.0 [INF] pgmap v1391: 23232 pgs: 23232 active+clean; 184 MB data, 8368 MB used, 83787 GB / 83795 GB avail
> 2013-01-31 19:26:40.524479 mon.0 [INF] pgmap v1392: 23232 pgs: 23232 active+clean; 188 MB data, 8372 MB used, 83787 GB / 83795 GB avail
> 2013-01-31 19:26:36.363526 osd.516 [WRN] 1 slow requests, 1 included below; oldest blocked for > 60.862743 secs
> 2013-01-31 19:26:36.363534 osd.516 [WRN] slow request 60.862743 seconds old, received at 2013-01-31 19:25:35.500724: osd_op(client.4240.0:38 benchmark_data_ceph-1_39426_object37 [write 0~4194304] 0.666b9194) v4 currently waiting for subops from [612]
> 2013-01-31 19:26:35.420666 osd.518 [WRN] 1 slow requests, 1 included below; oldest blocked for > 60.133929 secs
> 2013-01-31 19:26:35.420677 osd.518 [WRN] slow request 60.133929 seconds old, received at 2013-01-31 19:25:35.286662: osd_op(client.4240.0:7 benchmark_data_ceph-1_39426_object6 [write 0~4194304] 0.baa4121c) v4 currently waiting for subops from [615]
> 2013-01-31 19:26:44.813429 mon.0 [INF] pgmap v1393: 23232 pgs: 23232 active+clean; 192 MB data, 8372 MB used, 83787 GB / 83795 GB avail
> 2013-01-31 19:26:36.861749 osd.414 [WRN] 1 slow requests, 1 included below; oldest blocked for > 60.895043 secs
> 2013-01-31 19:26:36.861761 osd.414 [WRN] slow request 60.895043 seconds old, received at 2013-01-31 19:25:35.966641: osd_
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
