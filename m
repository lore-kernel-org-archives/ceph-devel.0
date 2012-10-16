From: Gregory Farnum <greg@inktank.com>
Subject: Re: Poor performance with rbd volumes
Date: Tue, 16 Oct 2012 11:24:27 -0700
Message-ID: <CAPYLRzh5HEiKBR_FZ2aX5cgP+2Rohpw1qWkKqNu-6WoOkEM4qA@mail.gmail.com>
References: <CAGqxmDPs2TWb0-XpXSWtT3HHCOGPu9NkcP264XK702FeYuiuaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:58230 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976Ab2JPSY2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Oct 2012 14:24:28 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so4781841iag.19
        for <ceph-devel@vger.kernel.org>; Tue, 16 Oct 2012 11:24:27 -0700 (PDT)
In-Reply-To: <CAGqxmDPs2TWb0-XpXSWtT3HHCOGPu9NkcP264XK702FeYuiuaw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?Maciej_Ga=B3kiewicz?= <maciejgalkiewicz@ragnarson.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Oct 16, 2012 at 7:27 AM, Maciej Ga=C5=82kiewicz
<maciejgalkiewicz@ragnarson.com> wrote:
> Hello
>
> I have two ceph clusters configured this way:
>
> production:
> # cat /etc/ceph/ceph.conf
> [global]
>   auth supported =3D cephx
>   keyring =3D /srv/ceph/keyring.admin
>
> [mon]
>   mon data =3D /srv/ceph/mon
>   mon clock drift allowed =3D 0.5
>
> [mon.n11c1]
>   host =3D n11c1
>   mon addr =3D 1.1.1.49:6789
> [mon.cc2]
>   host =3D cc2
>   mon addr =3D 1.1.1.48:6789
> [mon.n13c1]
>   host =3D n13c1
>   mon addr =3D 1.1.1.51:6789
>
> [mds]
>   debug mds =3D 1
>   keyring =3D /srv/ceph/ceph-stage2/keyring.$name
>
> [mds.n11c1]
>   host =3D n11c1
>
> [osd]
>   osd data =3D /srv/ceph/$name
>   osd journal =3D /srv/ceph/$name.journal
>   osd journal size =3D 1000
>   keyring =3D /srv/ceph/ceph-stage2/keyring.$name
>   debug osd =3D 1
>
> [osd.2]
>   host =3D n14c1
> [osd.0]
>   host =3D n11c1
> [osd.3]
>   host =3D n13c1
> [osd.1]
>   host =3D n12c1
>
> staging:
> # cat /etc/ceph/ceph.conf
> [global]
>   auth supported =3D cephx
>   keyring =3D /srv/ceph/keyring.admin
>
> [mon]
>   mon data =3D /srv/ceph/mon
>   mon clock drift allowed =3D 0.5
>
> [mon.cc]
>   host =3D cc
>   mon addr =3D 1.1.1.35:6789
> [mon.n3cc]
>   host =3D n3cc
>   mon addr =3D 1.1.1.34:6789
>
> [mds]
>   debug mds =3D 1
>   keyring =3D /srv/ceph/ceph-stage2/keyring.$name
>
> [mds.cc]
>   host =3D cc
> [mds.n3cc]
>   host =3D n3cc
>   mds standby replay =3D true
>   mds standby for name =3D cc
>
> [osd]
>   osd data =3D /srv/ceph/$name
>   osd journal =3D /srv/ceph/$name.journal
>   osd journal size =3D 1000
>   keyring =3D /srv/ceph/ceph-stage2/keyring.$name
>   debug osd =3D 1
>
> [osd.0]
>   host =3D cc
> [osd.1]
>   host =3D n3cc
>
> I am using RBD volumes mapped on virtual machines which run postgresq=
l
> and mongodb databases. Right now there are 15 clients with postgresql
> and 10 with mongodb. All clients generate at most 0.4 IOPS (both read
> and write). Here are the graphs (writes per second) for nodes with
> osds from last week:
> https://www.dropbox.com/s/djnpcxb6a9ktzv8/ceph_stats1.png
> https://www.dropbox.com/s/ak7npkhm776jarp/ceph_stats2.png
> https://www.dropbox.com/s/3lzfaku1nourmle/ceph_stats3.png
>
> Is it normal that ceph generates so much writes? In staging cluster
> there are no clients connected and still there are about 40 writes/s.
> I have also checked admin socket and dumped ops_in_flight. There were
> 0 ops.

What's this data showing us? Write requests to any disk on the node of =
any size?
That's more than I'd expect to see, but Ceph is going to engage in
some background chatter, and I notice you have at least a little bit
of logging enabled.

> The situation on production is also weird for me. There are a lot of
> writes which do not reflect volume usage on clients. Looks like ceph
> have a big overhead or more likely something is wrong with the
> cluster.
>
> Benchmarks from both clusters:
>
> root@n12c1[production]:/srv/ceph# rados -p todo-list bench 60 write -=
b
> 4096 -t 16
>  Maintaining 16 concurrent writes of 4096 bytes for at least 60 secon=
ds.
>  Object prefix: benchmark_data_n12c1_2638
>    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   av=
g lat
>      0       0         0         0         0         0         -     =
    0
>      1      16        20         4 0.0156214  0.015625  0.798329  0.6=
96832
>      2      16        20         40.00781079         0         -  0.6=
96832
>      3      16        20         40.00520727         0         -  0.6=
96832
>      4      16        20         40.00390549         0         -  0.6=
96832
>      5      16        20         40.00312442         0         -  0.6=
96832
>      6      16        20         40.00260369         0         -  0.6=
96832
>      7      16        20         40.00223175         0         -  0.6=
96832
>      8      16        20         40.00195278         0         -  0.6=
96832
>      9      16        20         40.00173581         0         -  0.6=
96832
>     10      16        20         40.00156223         0         -  0.6=
96832
>     11      16        20         40.00142021         0         -  0.6=
96832
>     12      16        20         40.00130186         0         -  0.6=
96832
>     13      16        20         40.00120171         0         -  0.6=
96832
>     14      16        20         40.00111588         0         -  0.6=
96832
>     15      16        20         40.00104149         0         -  0.6=
96832
>     16      16        20         40.000976395         0         -  0.=
696832
>     17      16        20         40.000918959         0         -  0.=
696832
>     18      16        20         40.000867905         0         -  0.=
696832
>     19      16        24         80.001644450.000868056   18.9809   9=
=2E83857
> 2012-10-16 16:10:18.553915min lat: 0.391531 max lat: 18.9809 avg lat:=
 9.83857
>    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   av=
g lat
>     20      16        24         80.00156223         0         -   9.=
83857
>     21      16        25         90.001673810.00195312   20.6347   11=
=2E0381
>     22      16        36        200.00355051 0.0429688  0.259829   14=
=2E4342
>     23      16        36        200.00339614         0         -   14=
=2E4342
>     24      16        36        200.00325464         0         -   14=
=2E4342
>     25      16        37        210.003280680.00130208   23.8748   14=
=2E8838
>     26      16        37        21 0.0031545         0         -   14=
=2E8838
>     27      16        37        210.00303766         0         -   14=
=2E8838
>     28      16        37        210.00292918         0         -   14=
=2E8838
>     29      16        37        210.00282817         0         -   14=
=2E8838
>     30      16        37        21 0.0027339         0         -   14=
=2E8838
>     31      16        37        210.00264571         0         -   14=
=2E8838
>     32      16        37        210.00256303         0         -   14=
=2E8838
>     33      16        37        210.00248537         0         -   14=
=2E8838
>     34      16        37        210.00241227         0         -   14=
=2E8838
>     35      16        37        210.00234335         0         -   14=
=2E8838
>     36      16        37        210.00227825         0         -   14=
=2E8838
>     37      16        37        210.00221668         0         -   14=
=2E8838
>     38      16        37        210.00215834         0         -   14=
=2E8838
>     39      16        37        21  0.002103         0         -   14=
=2E8838
> 2012-10-16 16:10:38.557419min lat: 0.258984 max lat: 23.8748 avg lat:=
 14.8838
>    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   av=
g lat
>     40      16        37        210.00205043         0         -   14=
=2E8838
>     41      16        37        210.00200041         0         -   14=
=2E8838
>     42      16        37        210.00195279         0         -   14=
=2E8838
>     43      16        37        210.00190737         0         -   14=
=2E8838
>     44      16        37        210.00186402         0         -   14=
=2E8838
>     45      16        37        21 0.0018226         0         -   14=
=2E8838
>     46      16        37        210.00178298         0         -   14=
=2E8838
>     47      16        37        210.00174504         0         -   14=
=2E8838
>     48      16        37        210.00170869         0         -   14=
=2E8838
>     49      16        37        210.00167382         0         -   14=
=2E8838
>     50      16        37        210.00164034         0         -   14=
=2E8838
>     51      16        37        210.00160818         0         -   14=
=2E8838
>     52      16        37        210.00157725         0         -   14=
=2E8838
>     53      16        37        210.00154749         0         -   14=
=2E8838
>     54      16        37        210.00151884         0         -   14=
=2E8838
>     55      16        37        210.00149122         0         -   14=
=2E8838
>     56      16        37        210.00146459         0         -   14=
=2E8838
>     57      16        37        21 0.0014389         0         -   14=
=2E8838
>     58      16        37        210.00141409         0         -   14=
=2E8838
>     59      16        37        210.00139012         0         -   14=
=2E8838
> 2012-10-16 16:10:58.560825min lat: 0.258984 max lat: 23.8748 avg lat:=
 14.8838
>    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   av=
g lat
>     60      16        37        210.00136695         0         -   14=
=2E8838
>     61      16        37        210.00134454         0         -   14=
=2E8838
>     62      16        37        210.00132286         0         -   14=
=2E8838
>     63      16        37        210.00130186         0         -   14=
=2E8838
>     64      16        37        210.00128152         0         -   14=
=2E8838
>     65      16        37        21 0.0012618         0         -   14=
=2E8838
>     66       6        38        320.001893610.00104802    44.154   25=
=2E6537
>     67       6        38        320.00186535         0         -   25=
=2E6537
>  Total time run:         67.779471
> Total writes made:      38
> Write size:             4096
> Bandwidth (MB/sec):     0.002
>
> Stddev Bandwidth:       0.00555568
> Max bandwidth (MB/sec): 0.0429688
> Min bandwidth (MB/sec): 0
> Average Latency:        27.8774
> Stddev Latency:         17.9306
> Max latency:            64.4662
> Min latency:            0.258984

That's pretty hilariously slow =E2=80=94 patterns like this usually mea=
n that
you have one OSD in particular which is very slow at serving writes.
Have you run any benchmarks on the backing filesystems without Ceph in
the way?
These results combined with the fact that you're using old btrfs
nodes, which have been supporting database access patterns, makes me
think that you've just got a workload that fragments btrfs horribly
and so your backing filesystems are themselves not supporting any real
throughput.
-Greg

>
> root@cc[staging]:/var/images# rados -p todo-list-test bench 60 write
> -b 4096 -t 16
>  Maintaining 16 concurrent writes of 4096 bytes for at least 60 secon=
ds.
>  Object prefix: benchmark_data_cc_20637
>    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   av=
g lat
>      0       0         0         0         0         0         -     =
    0
>      1      16       129       113  0.441308  0.441406  0.089088  0.1=
30034
>      2      16       228       212  0.413976  0.386719  0.170227  0.1=
44586
>      3      16       324       308  0.400965     0.375   0.17551  0.1=
49879
>      4      16       481       465  0.454019  0.613281  0.081618  0.1=
36798
>      5      16       628       612  0.478042  0.574219  0.080181  0.1=
24768
>      6      16       641       625  0.406831 0.0507812  0.707781  0.1=
36926
>      7      16       641       625  0.348713         0         -  0.1=
36926
>      8      16       659       643  0.313911 0.0351562  0.281386  0.1=
93741
>      9      16       739       723  0.313749    0.3125  0.177852  0.1=
96558
>     10      16       865       849  0.331585  0.492188  0.142906   0.=
18791
>     11      16      1009       993  0.352569    0.5625  0.089554  0.1=
76182
>     12      16      1059      1043  0.339462  0.195312  0.132217  0.1=
74339
>     13      16      1075      1059  0.318157    0.0625   1.57543  0.1=
95923
>     14      16      1075      1059  0.295431         0         -  0.1=
95923
>     15      16      1076      1060  0.2759960.00195312   2.07952    0=
=2E1977
>     16      16      1156      1140  0.278275    0.3125  0.158087   0.=
22184
>     17      16      1204      1188  0.272933    0.1875   0.08167  0.2=
23639
>     18      16      1221      1205  0.261459 0.0664062  0.714995  0.2=
36254
>     19      16      1222      1206  0.2479040.00390625  0.293113  0.2=
36301
> 2012-10-16 16:14:21.879463min lat: 0.066844 max lat: 2.96921 avg lat:=
 0.247091
>    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   av=
g lat
>     20      16      1302      1286  0.251131    0.3125   0.19978  0.2=
47091
>     21      16      1317      1301  0.241961 0.0585938  0.203456  0.2=
46584
>     22      16      1399      1383   0.24552  0.320312  0.158703  0.2=
53264
>     23      16      1511      1495  0.253864    0.4375  0.164127  0.2=
45372
>     24      16      1654      1638  0.266557  0.558594  0.086673  0.2=
34202
>     25      16      1718      1702  0.265894      0.25   0.27639  0.2=
30337
>     26      16      1720      1704  0.255967 0.0078125   1.58549  0.2=
31933
>     27      16      1785      1769  0.255889  0.253906  0.140973  0.2=
38474
>     28      16      1816      1800  0.251075  0.121094  0.179986  0.2=
47877
>     29      16      1913      1897   0.25548  0.378906  0.103972  0.2=
43542
>     30      16      2057      2041  0.265712    0.5625  0.071993  0.2=
34536
>     31      16      2233      2217  0.279314    0.6875  0.090504  0.2=
23128
>     32      16      2264      2248  0.274369  0.121094   0.11962  0.2=
21455
>     33      16      2281      2265  0.268067 0.0664062   0.22729  0.2=
32648
>     34      16      2281      2265  0.260183         0         -  0.2=
32648
>     35      16      2298      2282  0.254646 0.0332031  0.227998  0.2=
44199
>     36      16      2425      2409  0.261351  0.496094  0.116612  0.2=
38956
>     37      16      2553      2537  0.267798       0.5  0.126228  0.2=
32921
>     38      16      2652      2636  0.270926  0.386719   0.12253  0.2=
29696
>     39      16      2665      2649  0.265281 0.0507812  0.205365  0.2=
29567
> 2012-10-16 16:14:41.882716min lat: 0.066844 max lat: 2.96921 avg lat:=
 0.234852
>    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   av=
g lat
>     40      16      2730      2714  0.264996  0.253906  0.116825  0.2=
34852
>     41      16      2730      2714  0.258532         0         -  0.2=
34852
>     42      16      2747      2731  0.253958 0.0332031  0.155447  0.2=
45442
>     43      16      2844      2828  0.256862  0.378906  0.159537  0.2=
42571
>     44      16      2892      2876  0.255285    0.1875  0.548109  0.2=
42033
>     45      16      2955      2939   0.25508  0.246094  0.245377  0.2=
43047
>     46      16      2957      2941  0.249705 0.0078125   1.33743  0.2=
43768
>     47      16      3021      3005   0.24971      0.25  0.226326  0.2=
49331
>     48      16      3021      3005  0.244508         0         -  0.2=
49331
>     49      16      3067      3051  0.243184 0.0898438  0.218276  0.2=
55766
>     50      16      3068      3052  0.2383990.00390625   1.28465  0.2=
56103
>     51      16      3068      3052  0.233724         0         -  0.2=
56103
>     52      16      3085      3069  0.230506 0.0332031   0.78895   0.=
26712
>     53      16      3181      3165  0.233232     0.375  0.128619  0.2=
67592
>     54      16      3244      3228  0.233469  0.246094  0.162226  0.2=
65363
>     55      16      3245      3229  0.2292950.00390625   1.23061  0.2=
65662
>     56      16      3326      3310   0.23085  0.316406  0.130218  0.2=
70394
>     57      16      3421      3405  0.233309  0.371094  0.271192   0.=
26772
>     58      16      3422      3406  0.2293540.00390625  0.243273  0.2=
67713
>     59      16      3472      3456  0.228777  0.195312  0.172423  0.2=
72543
> 2012-10-16 16:15:01.885897min lat: 0.066844 max lat: 2.96921 avg lat:=
 0.271267
>    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   av=
g lat
>     60      16      3536      3520   0.22913      0.25  0.245948  0.2=
71267
>     61      16      3536      3520  0.225373         0         -  0.2=
71267
>  Total time run:         61.778350
> Total writes made:      3537
> Write size:             4096
> Bandwidth (MB/sec):     0.224
>
> Stddev Bandwidth:       0.199931
> Max bandwidth (MB/sec): 0.6875
> Min bandwidth (MB/sec): 0
> Average Latency:        0.278853
> Stddev Latency:         0.441319
> Max latency:            2.96921
> Min latency:            0.066844
>
> The biggest problem in my clusters is poor performance. Simple insert
> to the database on the client often takes seconds. It is unacceptable
> and I am trying to find the bottleneck. Could you please help me with
> it?
>
> Replica count is set to 2. Kernel 3.2.23, ceph 0.52, osd data are
> stored on the same partition (two 7200rpm disks in raid0) as journal
> files, filesystem btrfs. Filesystem on n11c1 is 4 months old, n12c1
> and n14c1 are around 1.5 month old, cc and n3cc is around 3 months
> old. Both clusters are healthy. Production have around 544 pgs and 46
> pools, staging 232 and 8 pools.
Also this is interesting =E2=80=94=C2=A0what are the pools used for? Wi=
th an
average size of 11 PGs/pool on production, and 4 OSDs, then you're
likely to have some pretty distributions of writes on a per-pool
basis, which would exacerbate any slow OSD problems on the pools which
map heavily to that OSD.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
