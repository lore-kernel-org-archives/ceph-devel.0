From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: RadosGW performance and disk space usage
Date: Mon, 28 Jan 2013 09:35:48 -0800
Message-ID: <CAC-hyiHQuS9X6acBg0fZ-g-OMu_1mrys3gf-537hE5sZ9NeKWQ@mail.gmail.com>
References: <CAJVE5RXTM4iARw=wpaUX_ofZgP6tHLjiG6JoakpbhEXf7ZgVLQ@mail.gmail.com>
	<CAKMAVE-JJVsinn4ys2o-p=b-7-_u9KGvd1fxwfMX0=44fS4T8w@mail.gmail.com>
	<CALFpzo4u2PspjkvSig3LL821YY_XA2iHBjAh30JxgwWTFGsgcA@mail.gmail.com>
	<CAJVE5RXpqJ3ZcbxAOCSD0f5OwN6Nre_TuhjY1BUveJTb=cga9A@mail.gmail.com>
	<CAJVE5RVE5_QzvNEYnm86NaKs4GVaAfXDUVUsrdJneXX5GbWgBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f175.google.com ([209.85.210.175]:34289 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756937Ab3A1Rft (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Jan 2013 12:35:49 -0500
Received: by mail-ia0-f175.google.com with SMTP id r4so4495591iaj.6
        for <ceph-devel@vger.kernel.org>; Mon, 28 Jan 2013 09:35:49 -0800 (PST)
In-Reply-To: <CAJVE5RVE5_QzvNEYnm86NaKs4GVaAfXDUVUsrdJneXX5GbWgBw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Cesar Mello <cmello@gmail.com>
Cc: Marcus Sorensen <shadowsor@gmail.com>, Sam Lang <sam.lang@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, Jan 27, 2013 at 3:10 PM, Cesar Mello <cmello@gmail.com> wrote:
> Hi,
>
> Just tried rest-bench. This little tool is wonderful, thanks!
>
> I still have to learn lots of things. So please don't spend much time
> explaining me, but instead please give me any pointers to
> documentation or source code that can be useful. As a curiosity, I'm
> pasting the results from my laptop. I'll repeat the same tests using
> my desktop as the server.
>
> Notice there is an assert being triggered, so I guess I'm running a
> build with debugging code ?!. I compiled using ./configure
> --with-radosgw --with-rest-bench followed by make.
>
> Thanks a lot for the attention.
>
> Best regards!
> Mello
>
> root@l3:/etc/init.d# rest-bench --api-host=localhost --bucket=test
> --access-key=JJABVJ3AWBS1ZOCML7NS
> --secret=A+ecBz2+Sdxj4Y8Mo+u3akIewGvJPkwOhwRgPKkX --protocol=http
> --uri_style=path write
> host=localhost
>  Maintaining 16 concurrent writes of 4194304 bytes for at least 60 seconds.
>  Object prefix: benchmark_data_l3_4032
>    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
>      0       3         3         0         0         0         -         0
>      1      16        16         0         0         0         -         0
>      2      16        16         0         0         0         -         0
>      3      16        16         0         0         0         -         0
>      4      16        16         0         0         0         -         0
>      5      16        16         0         0         0         -         0
>      6      16        16         0         0         0         -         0
>      7      16        16         0         0         0         -         0
>      8      16        16         0         0         0         -         0
>      9      16        16         0         0         0         -         0
>     10      16        16         0         0         0         -         0
>     11      16        16         0         0         0         -         0
>     12      16        17         1  0.333265  0.333333   11.2761   11.2761
>     13      16        18         2  0.615257         4   12.5964   11.9363
>     14      16        20         4   1.14262         8   13.1392   12.5365
>     15      16        23         7   1.86628        12   14.2273   13.2594
>     16      16        27        11   2.74944        16   15.0222   13.8968
>     17      16        32        16   3.76394        20   16.2604   14.6301
>     18      16        32        16   3.55483         0         -   14.6301
>     19      16        34        18    3.7887         4    6.2274   13.7695
> 2013-01-27 20:49:29.703509min lat: 6.2274 max lat: 16.2604 avg lat: 13.7695
>    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
>     20      16        34        18   3.59927         0         -   13.7695
>     21      16        34        18   3.42787         0         -   13.7695
>     22      16        34        18   3.27205         0         -   13.7695
>     23      16        35        19   3.30367         1   9.09053   13.5233
>     24      16        36        20   3.33264         4   9.09667    13.302
>     25      16        36        20   3.19933         0         -    13.302
>     26      16        36        20   3.07628         0         -    13.302
>     27      16        37        21   3.11047   1.33333   11.2459    13.204
>     28      16        37        21   2.99938         0         -    13.204
>     29      16        37        21   2.89595         0         -    13.204
>     30      16        37        21   2.79942         0         -    13.204
>     31      16        37        21   2.70912         0         -    13.204
>     32      16        39        23   2.87441       1.6   14.9981   13.3602
>     33      16        39        23    2.7873         0         -   13.3602
>     34      16        39        23   2.70533         0         -   13.3602
>     35      16        40        24   2.74229   1.33333   21.5365   13.7009
>     36      16        40        24   2.66612         0         -   13.7009
>     37      16        42        26   2.81023         4   22.6059   14.3855
>     38      16        42        26   2.73628         0         -   14.3855
>     39      16        45        29   2.97374         6   23.2615   15.3025
> 2013-01-27 20:49:49.707740min lat: 6.2274 max lat: 23.4496 avg lat: 16.1307
>    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
>     40      16        51        35   3.49927        24   21.0123   16.1307
>     41      16        51        35   3.41392         0         -   16.1307
>     42      16        52        36   3.42786         2   19.0243    16.211
>     43      16        52        36   3.34814         0         -    16.211
>     44      16        52        36   3.27204         0         -    16.211
>     45      16        52        36   3.19933         0         -    16.211
>     46      16        53        37   3.21672         1   11.0793   16.0723
>     47      16        53        37   3.14828         0         -   16.0723
>     48      16        53        37   3.08269         0         -   16.0723
>     49      16        53        37   3.01978         0         -   16.0723
>     50      16        55        39   3.11935         2   23.4253   16.5245
>     51      16        55        39   3.05819         0         -   16.5245
>     52      16        58        42    3.2301         6   13.3052   16.2945
>     53      16        58        42   3.16915         0         -   16.2945
>     54      16        60        44   3.25858         4   14.2116   16.1999
>     55      16        60        44   3.19933         0         -   16.1999
>     56      16        63        47   3.35644         6   15.6276   16.3393
>     57      16        63        47   3.29756         0         -   16.3393
>     58      16        66        50   3.44755         6   18.0547   16.5454
>     59      16        66        50   3.38912         0         -   16.5454
> 2013-01-27 20:50:09.712027min lat: 6.2274 max lat: 26.3519 avg lat: 16.5454
>    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
>     60      16        66        50   3.33263         0         -   16.5454
>     61      16        66        50     3.278         0         -   16.5454
>     62      16        66        50   3.22513         0         -   16.5454
>     63      16        67        51   3.23741       0.8   10.9553   16.4358
>     64      16        67        51   3.18683         0         -   16.4358
>     65      16        67        51    3.1378         0         -   16.4358
>     66      16        67        51   3.09025         0         -   16.4358
>     67      16        67        51   3.04413         0         -   16.4358
>     68      16        67        51   2.99937         0         -   16.4358
>     69      16        67        51    2.9559         0         -   16.4358
>     70      16        67        51   2.91367         0         -   16.4358
>     71      14        67        53   2.98528         1   15.1841   16.2524
>     72       9        67        58   3.22154        20   26.2114   16.6243
>  Total time run:         72.403588
> Total writes made:      67
> Write size:             4194304
> Bandwidth (MB/sec):     3.701
>
> Stddev Bandwidth:       4.92554
> Max bandwidth (MB/sec): 24
> Min bandwidth (MB/sec): 0
> Average Latency:        17.1886
> Stddev Latency:         5.48181
> Max latency:            32.7038
> Min latency:            6.2274

Can you run 'rados bench' on the same setup (with the same params)?
The numbers are really horrible.

Yehuda
