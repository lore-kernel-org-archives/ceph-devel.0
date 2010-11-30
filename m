From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: Re: Performence test on ceph v0.23 + EXT4 and Btrfs
Date: Tue, 30 Nov 2010 10:55:41 +0800
Message-ID: <1291085741.1809.25.camel@cephhost>
References: <1291001135.1872.106.camel@cephhost>
	 <AANLkTi=E=pjvixkronpD-ij0CxjFBVauN5bBrsbT8nqW@mail.gmail.com>
Reply-To: <cpwu@tnsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:51742 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752393Ab0K3Cyr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Nov 2010 21:54:47 -0500
In-Reply-To: <AANLkTi=E=pjvixkronpD-ij0CxjFBVauN5bBrsbT8nqW@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: "sage@newdream.net" <sage@newdream.net>, "yehuda@hq.newdream.net" <yehuda@hq.newdream.net>, "colinm@hq.newdream.net" <colinm@hq.newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Andrew Lv <mllv@tnsoft.com.cn>



=E5=9C=A8 2010-11-30=E4=BA=8C=E7=9A=84 01:07 +0800=EF=BC=8CGregory Farn=
um=E5=86=99=E9=81=93=EF=BC=9A
> On Sun, Nov 28, 2010 at 7:25 PM, Jeff Wu <cpwu@tnsoft.com.cn> wrote:
> >
> > Hi ,
> >
> > I've recently been using FFSB and iozone to do performance test wit=
h Ceph
> > v0.23 on my platform.
> > the attachment file are FFSB configuration file and ceph.conf.
> So you're not using OSD journals in either test configuration? You're
> going to get pretty terrible write results without a journal.
> The reads are clearly slower than they should be and you could
> probably get better results by adjusting the caching behaviors. We
> haven't done too much work on optimizing read behavior.

Hi ,Greg , thank you for your suggestions.=20

>=20
> Could you run "ceph osd tell * bench", then run "ceph -w", and report
> the results? (That'll just run local benchmarking on the OSD to repor=
t
> the approximate write speed it's capable of.)

I run six times for the command: "$ sudo ceph osd tell 0/1 bench "=20
use "$ sudo ceph -w" to get the following results:=20

osd0 : [INF] bench: wrote 1024 MB in blocks of 4096 KB in 12.906598 sec
at 49775 KB/sec
osd1 : [INF] bench: wrote 1024 MB in blocks of 4096 KB in 21.023294 sec
at 49384 KB/sec
osd0 : [INF] bench: wrote 1024 MB in blocks of 4096 KB in 12.834682 sec
at 51535 KB/sec
osd1 : [INF] bench: wrote 1024 MB in blocks of 4096 KB in 20.792697 sec
at 37547 KB/sec
osd0  : [INF] bench: wrote 1024 MB in blocks of 4096 KB in 13.058412 se=
c
at 77191 KB/sec
osd1  : [INF] bench: wrote 1024 MB in blocks of 4096 KB in 21.113612 se=
c
at 47369 KB/sec

The detail test logs attached below.


> You can also run "rados -p data bench 60 write", and then "rados -p
> data bench 0 seq" to get a simpler (better understood) performance
> test.

I run twice for the command: "rados -p data bench 60 write" ,
Get the results:
$ sudo rados -p data bench 60 write
=2E.........................
=2E.........................

Total time run:        76.182225
Total writes made:     121
Write size:            4194304
Bandwidth (MB/sec):    6.219=20

Average Latency:       13.3068
Max latency:           23.9986
Min latency:           7.01847

$ sudo rados -p data bench 60 write
=2E.........................
=2E.........................
Total time run:        74.830651
Total writes made:     97
Write size:            4194304
Bandwidth (MB/sec):    4.714=20

Average Latency:       15.5064
Max latency:           24.5641
Min latency:           3.50005

but run  "$ sudo rados -p data bench 0 seq"=20
fail to get the results, Maybe it's a bug,ceph version 0.23.
logs:
  sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg
lat
    0      16        16         0         0         0         -
0
read got -2
error during benchmark: -2
=2E/common/Mutex.h: In function 'Mutex::~Mutex()':
=2E/common/Mutex.h:97: FAILED assert(nlock =3D=3D 0)
 ceph version 0.23 (commit:5d1d8d0c4602be9819cc9f7aea562fccbb005a56)

=2E..............................
=2E..............................

The detail logs addached below.



> With this data as a baseline we can start looking at what might be
> causing trouble.
> -Greg


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. Process

transoft@ubuntu-mon0:/usr/local/etc/ceph$ ps -ef
root     12919     1  2 Nov26 ?        02:23:45 /usr/local/bin/cmon -i =
0
-c ceph.conf
root     12952     1  1 Nov26 ?        01:30:03 /usr/local/bin/cmon -i =
1
-c ceph.conf
root     12987     1  1 Nov26 ?        01:51:42 /usr/local/bin/cmon -i =
2
-c ceph.conf
root     13036     1  1 Nov26 ?        01:00:08 /usr/local/bin/cmds -i =
0
-c ceph.conf
root     13075     1  0 Nov26 ?        00:47:47 /usr/local/bin/cmds -i =
1
-c ceph.conf

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
2. ceph -w=20

transoft@ubuntu-mon0:/usr/local/etc/ceph$ sudo ceph osd tell 0 bench
2010-11-30 08:47:09.080125 mon <- [osd,tell,0,bench]
2010-11-30 08:47:09.080378 mon1 -> 'ok' (0)
transoft@ubuntu-mon0:/usr/local/etc/ceph$ sudo ceph osd tell 1 bench
2010-11-30 08:47:54.520159 mon <- [osd,tell,1,bench]
2010-11-30 08:47:54.520433 mon2 -> 'ok' (0)
transoft@ubuntu-mon0:/usr/local/etc/ceph$ sudo ceph osd tell 0 bench
2010-11-30 08:48:29.590115 mon <- [osd,tell,0,bench]
2010-11-30 08:48:29.590365 mon2 -> 'ok' (0)
transoft@ubuntu-mon0:/usr/local/etc/ceph$ sudo ceph osd tell 1 bench
2010-11-30 08:48:47.450092 mon <- [osd,tell,1,bench]
2010-11-30 08:48:47.450341 mon1 -> 'ok' (0)
transoft@ubuntu-mon0:/usr/local/etc/ceph$ sudo ceph osd tell 0 bench
2010-11-30 08:49:27.240742 mon <- [osd,tell,0,bench]
2010-11-30 08:49:27.241076 mon1 -> 'ok' (0)
transoft@ubuntu-mon0:/usr/local/etc/ceph$ sudo ceph osd tell 1 bench
2010-11-30 08:49:43.500749 mon <- [osd,tell,1,bench]
2010-11-30 08:49:43.501043 mon2 -> 'ok' (0)
transoft@ubuntu-mon0:/usr/local/etc/ceph$=20

transoft@ubuntu-mon0:/usr/local/etc/ceph$ sudo ceph -w
2010-11-30 08:47:04.150457    pg v8701: 528 pgs: 528 active+clean; 1067=
4
KB data, 442 MB used, 219 GB / 219 GB avail
2010-11-30 08:47:04.151228   mds e5: 1/1/1 up {0=3Dup:active}, 1
up:standby
2010-11-30 08:47:04.151253   osd e6: 2 osds: 2 up, 2 in
2010-11-30 08:47:04.151319   log 2010-11-30 08:45:17.795260 osd0
172.16.10.42:6800/16864 3 : [INF] bench: wrote 1024 MB in blocks of 409=
6
KB in 12.828886 sec at 51682 KB/sec
2010-11-30 08:47:04.151375   mon e1: 3 mons at
{0=3D172.16.10.171:6789/0,1=3D172.16.10.171:6790/0,2=3D172.16.10.171:67=
91/0}
2010-11-30 08:47:22.487639   log 2010-11-30 08:47:00.704960 osd0
172.16.10.42:6800/16864 4 : [INF] bench: wrote 1024 MB in blocks of 409=
6
KB in 12.906598 sec at 49775 KB/sec
2010-11-30 08:48:17.047842   log 2010-11-30 09:52:29.975820 osd1
172.16.10.65:6800/6678 3 : [INF] bench: wrote 1024 MB in blocks of 4096
KB in 21.023294 sec at 49384 KB/sec
2010-11-30 08:48:42.915344   log 2010-11-30 08:48:21.135651 osd0
172.16.10.42:6800/16864 5 : [INF] bench: wrote 1024 MB in blocks of 409=
6
KB in 12.834682 sec at 51535 KB/sec
2010-11-30 08:49:10.000303   log 2010-11-30 09:53:22.645957 osd1
172.16.10.65:6800/6678 4 : [INF] bench: wrote 1024 MB in blocks of 4096
KB in 20.792697 sec at 37547 KB/sec
2010-11-30 08:49:40.809023   log 2010-11-30 08:49:19.005413 osd0
172.16.10.42:6800/16864 6 : [INF] bench: wrote 1024 MB in blocks of 409=
6
KB in 13.058412 sec at 77191 KB/sec
2010-11-30 08:50:06.184830   log 2010-11-30 09:54:19.064900 osd1
172.16.10.65:6800/6678 5 : [INF] bench: wrote 1024 MB in blocks of 4096
KB in 21.113612 sec at 47369 KB/sec



=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
3. rados -p data bench 60 write

transoft@ubuntu-mon0:/usr/local/etc/ceph$ sudo rados -p data bench 60
write
Maintaining 16 concurrent writes of 4194304 bytes for at least 60
seconds.
  sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg
lat
    0      16        16         0         0         0         -
0
    1      16        16         0         0         0         -
0
    2      16        16         0         0         0         -
0
    3      16        16         0         0         0         -
0
    4      16        16         0         0         0         -
0
    5      16        17         1  0.793474       0.8    7.9252
7.9252
    6      16        17         1  0.662028         0         -
7.9252
    7      16        17         1  0.567947         0         -
7.9252
    8      16        24         8   3.97823   9.33333   10.5391
10.1201
    9      16        24         8   3.53801         0         -
10.1201
   10      16        38        22   8.76019        28   7.13522
9.96534
   11      16        38        22   7.96645         0         -
9.96534
   12      16        38        22   7.30461         0         -
9.96534
   13      16        38        22   6.74431         0         -
9.96534
   14      16        38        22   6.26388         0         -
9.96534
   15      16        38        22   5.84735         0         -
9.96534
   16      16        41        25   6.23039         2    8.7632
10.3001
   17      16        41        25   5.86468         0         -
10.3001
   18      16        41        25   5.53953         0         -
10.3001
   19      16        52        36   7.55792   14.6667   10.3215
11.3923
min lat: 7.01847 max lat: 15.8599 avg lat: 11.3923
  sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg
lat
   20      16        52        36   7.18061         0         -
11.3923
   21      16        56        40   7.59925         8   13.7597
11.8294
   22      16        56        40   7.25439         0         -
11.8294
   23      16        56        40   6.93949         0         -
11.8294
   24      16        56        40   6.65079         0         -
11.8294
   25      16        63        47   7.50258         7   7.33881
11.2982
   26      16        63        47   7.21441         0         -
11.2982
   27      16        68        52   7.68667        10   9.28991
11.1051
   28      16        68        52   7.41251         0         -
11.1051
   29      16        68        52   7.15725         0         -
11.1051
   30      16        68        52   6.91898         0         -
11.1051
   31      16        68        52   6.69606         0         -
11.1051
   32      16        79        63   7.85927       8.8   15.0751
11.933
   33      16        79        63   7.62121         0         -
11.933
   34      16        79        63    7.3973         0         -
11.933
   35      16        79        63   7.18618         0         -
11.933
   36      16        79        63   6.98678         0         -
11.933
   37      16        84        68   7.33767         4   17.4944
12.3426
   38      16        84        68   7.14464         0         -
12.3426
   39      16        85        69   7.06399         2   8.24284
12.2832
min lat: 7.01847 max lat: 19.7384 avg lat: 12.2832
  sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg
lat
   40      16        85        69   6.88751         0         -
12.2832
   41      16        85        69   6.71971         0         -
12.2832
   42      16        85        69   6.55985         0         -
12.2832
   43      16        87        71   6.59315         2   15.8845
12.3846
   44      16        87        71   6.44343         0         -
12.3846
   45      16        87        71   6.30037         0         -
12.3846
   46      16        87        71   6.16352         0         -
12.3846
   47      16        91        75   6.37235         4   21.8578
12.8896
   48      16        91        75   6.23967         0         -
12.8896
   49      16       101        85   6.92742        20   18.2741
13.1211
   50      16       101        85   6.78897         0         -
13.1211
   51      16       101        85   6.65595         0         -
13.1211
   52      16       101        85   6.52804         0         -
13.1211
   53      16       101        85   6.40496         0         -
13.1211
   54      16       111        95   7.02602         8   13.1645
12.939
   55      16       111        95   6.89835         0         -
12.939
   56      16       111        95   6.77524         0         -
12.939
   57      16       111        95   6.65646         0         -
12.939
   58      16       111        95   6.54176         0         -
12.939
   59      16       115        99   6.70174       3.2   13.1073
12.9458
min lat: 7.01847 max lat: 21.8578 avg lat: 12.9364
  sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg
lat
   60      16       120       104   6.92291        20   11.3313
12.9364
   61      15       121       106   6.94046         8   13.3389
12.9444
   62      15       121       106   6.82859         0         -
12.9444
   63      15       121       106   6.72026         0         -
12.9444
   64      15       121       106   6.61533         0         -
12.9444
   65      15       121       106   6.51362         0         -
12.9444
   66      11       121       110   6.65706       3.2   14.3524
12.9974
   67      11       121       110   6.55777         0         -
12.9974
   68      11       121       110   6.46139         0         -
12.9974
   69      11       121       110    6.3678         0         -
12.9974
   70      11       121       110   6.27689         0         -
12.9974
   71       2       121       119   6.69486       7.2   13.2646
13.1676
   72       2       121       119   6.60193         0         -
13.1676
   73       2       121       119   6.51154         0         -
13.1676
   74       2       121       119    6.4236         0         -
13.1676
   75       2       121       119     6.338         0         -
13.1676
   76       2       121       119   6.25465         0         -
13.1676
Total time run:        76.182225
Total writes made:     121
Write size:            4194304
Bandwidth (MB/sec):    6.219=20

Average Latency:       13.3068
Max latency:           23.9986
Min latency:           7.01847
transoft@ubuntu-mon0:/usr/local/etc/ceph$=20

transoft@ubuntu-mon0:/usr/local/etc/ceph$ sudo rados -p data bench 60
write
Maintaining 16 concurrent writes of 4194304 bytes for at least 60
seconds.
  sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg
lat
    0      16        16         0         0         0         -
0
    1      16        16         0         0         0         -
0
    2      16        16         0         0         0         -
0
    3      16        17         1   1.31537   1.33333   3.50005
3.50005
    4      16        17         1  0.989638         0         -
3.50005
    5      16        17         1  0.793226         0         -
3.50005
    6      16        17         1  0.661871         0         -
3.50005
    7      16        17         1  0.567841         0         -
3.50005
    8      16        17         1  0.497201         0         -
3.50005
    9      16        17         1  0.442194         0         -
3.50005
   10      16        17         1  0.398146         0         -
3.50005
   11      16        17         1  0.362079         0         -
3.50005
   12      16        25         9   2.98799   3.55556   12.0273
17.9704
   13      16        27        11   3.37183         8   12.0974
16.8994
   14      16        33        17   4.83996        24   12.8105
16.4478
   15      16        33        17    4.5181         0         -
16.4478
   16      16        33        17    4.2364         0         -
16.4478
   17      16        33        17   3.98777         0         -
16.4478
   18      16        33        17   3.76669         0         -
16.4478
   19      16        38        22    4.6185         4   14.6053
16.0123
min lat: 3.50005 max lat: 20.9926 avg lat: 16.0123
  sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg
lat
   20      16        38        22   4.38793         0         -
16.0123
   21      16        38        22   4.17939         0         -
16.0123
   22      16        38        22   3.98976         0         -
16.0123
   23      16        38        22   3.81659         0         -
16.0123
   24      16        38        22   3.65782         0         -
16.0123
   25      16        47        31   4.94834         6   13.0266
15.7939
   26      16        47        31   4.75829         0         -
15.7939
   27      16        47        31   4.58231         0         -
15.7939
   28      16        47        31   4.41888         0         -
15.7939
   29      16        47        31   4.26672         0         -
15.7939
   30      16        47        31   4.12467         0         -
15.7939
   31      16        54        38   4.89315   4.66667   14.5712
16.1038
   32      16        54        38   4.74042         0         -
16.1038
   33      16        54        38   4.59694         0         -
16.1038
   34      16        54        38   4.46188         0         -
16.1038
   35      16        54        38   4.33454         0         -
16.1038
   36      16        63        47   5.21238       7.2   12.2193
15.3573
   37      16        66        50   5.39536        12   9.59416
15.0125
   38      16        66        50   5.25352         0         -
15.0125
   39      16        66        50   5.11895         0         -
15.0125
min lat: 3.50005 max lat: 24.5641 avg lat: 15.0125
  sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg
lat
   40      16        66        50   4.99107         0         -
15.0125
   41      16        66        50   4.86947         0         -
15.0125
   42      16        73        57   5.41915       5.6   11.6831
14.5749
   43      16        73        57   5.29323         0         -
14.5749
   44      16        73        57   5.17304         0         -
14.5749
   45      16        73        57   5.05817         0         -
14.5749
   46      16        73        57   4.94831         0         -
14.5749
   47      16        82        66   5.60781       7.2   14.1181
14.6534
   48      16        82        66   5.49105         0         -
14.6534
   49      16        82        66   5.37907         0         -
14.6534
   50      16        82        66   5.27157         0         -
14.6534
   51      16        82        66   5.16829         0         -
14.6534
   52      16        82        66   5.06898         0         -
14.6534
   53      16        88        72   5.42554         4   14.2779
14.6222
   54      16        88        72   5.32512         0         -
14.6222
   55      16        88        72   5.22837         0         -
14.6222
   56      16        88        72   5.13507         0         -
14.6222
   57      16        88        72   5.04505         0         -
14.6222
   58      16        88        72   4.95812         0         -
14.6222
   59      16        90        74   5.00954   1.33333   18.7183
14.808
min lat: 3.50005 max lat: 24.5641 avg lat: 14.8389
  sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg
lat
   60      16        96        80   5.32549        24   16.2963
14.8389
   61      16        96        80   5.23826         0         -
14.8389
   62      16        96        80   5.15383         0         -
14.8389
   63      16        96        80   5.07208         0         -
14.8389
   64      13        97        84   5.24252         4   13.2043
15.0243
   65      13        97        84   5.16191         0         -
15.0243
   66      13        97        84   5.08375         0         -
15.0243
   67      13        97        84   5.00792         0         -
15.0243
   68      13        97        84   4.93432         0         -
15.0243
   69      13        97        84   4.86285         0         -
15.0243
   70       5        97        92   5.24994   5.33333   18.0332
15.3781
   71       5        97        92   5.17604         0         -
15.3781
   72       5        97        92   5.10419         0         -
15.3781
   73       5        97        92    5.0343         0         -
15.3781
   74       5        97        92   4.96631         0         -
15.3781
Total time run:        74.830651
Total writes made:     97
Write size:            4194304
Bandwidth (MB/sec):    4.714=20

Average Latency:       15.5064
Max latency:           24.5641
Min latency:           3.50005
transoft@ubuntu-mon0:/usr/local/etc/ceph$=20

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
4. rados -p data bench 0 seq

transoft@ubuntu-mon0:/usr/local/etc/ceph$ sudo rados -p data bench 0 se=
q
  sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg
lat
    0      16        16         0         0         0         -
0
read got -2
error during benchmark: -2
=2E/common/Mutex.h: In function 'Mutex::~Mutex()':
=2E/common/Mutex.h:97: FAILED assert(nlock =3D=3D 0)
 ceph version 0.23 (commit:5d1d8d0c4602be9819cc9f7aea562fccbb005a56)
 1: rados() [0x40c941]
 2: (exit()+0xe2) [0x7f518ea744f2]
 3: (__libc_start_main()+0x105) [0x7f518ea59d95]
 4: rados() [0x405b19]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.
=2E/common/Mutex.h: In function 'Mutex::~Mutex()':
=2E/common/Mutex.h:97: FAILED assert(nlock =3D=3D 0)
 ceph version 0.23 (commit:5d1d8d0c4602be9819cc9f7aea562fccbb005a56)
 1: rados() [0x40c941]
 2: (exit()+0xe2) [0x7f518ea744f2]
 3: (__libc_start_main()+0x105) [0x7f518ea59d95]
 4: rados() [0x405b19]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.
terminate called after throwing an instance of 'ceph::FailedAssertion'
*** Caught signal (ABRT) ***
 ceph version 0.23 (commit:5d1d8d0c4602be9819cc9f7aea562fccbb005a56)
 1: (sigabrt_handler(int)+0x91) [0x7f518fe7dec1]
 2: (()+0x33c20) [0x7f518ea6ec20]
 3: (gsignal()+0x35) [0x7f518ea6eba5]
 4: (abort()+0x180) [0x7f518ea726b0]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f518f3126bd]
 6: (()+0xb9906) [0x7f518f310906]
 7: (()+0xb9933) [0x7f518f310933]
 8: (()+0xb9a3e) [0x7f518f310a3e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x456) [0x7f518fe5ab96]
 10: rados() [0x40c941]
 11: (exit()+0xe2) [0x7f518ea744f2]
 12: (__libc_start_main()+0x105) [0x7f518ea59d95]
 13: rados() [0x405b19]
Aborted
transoft@ubuntu-mon0:/usr/local/etc/ceph$=20

transoft@ubuntu-mon0:/usr/local/etc/ceph$ sudo rados -p data bench 60
seq
  sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg
lat
    0      16        16         0         0         0         -
0
read got -2
error during benchmark: -2
=2E/common/Mutex.h: In function 'Mutex::~Mutex()':
=2E/common/Mutex.h:97: FAILED assert(nlock =3D=3D 0)
 ceph version 0.23 (commit:5d1d8d0c4602be9819cc9f7aea562fccbb005a56)
 1: rados() [0x40c941]
 2: (exit()+0xe2) [0x7f795c31c4f2]
 3: (__libc_start_main()+0x105) [0x7f795c301d95]
 4: rados() [0x405b19]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.
=2E/common/Mutex.h: In function 'Mutex::~Mutex()':
=2E/common/Mutex.h:97: FAILED assert(nlock =3D=3D 0)
 ceph version 0.23 (commit:5d1d8d0c4602be9819cc9f7aea562fccbb005a56)
 1: rados() [0x40c941]
 2: (exit()+0xe2) [0x7f795c31c4f2]
 3: (__libc_start_main()+0x105) [0x7f795c301d95]
 4: rados() [0x405b19]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.
terminate called after throwing an instance of 'ceph::FailedAssertion'
*** Caught signal (ABRT) ***
 ceph version 0.23 (commit:5d1d8d0c4602be9819cc9f7aea562fccbb005a56)
 1: (sigabrt_handler(int)+0x91) [0x7f795d725ec1]
 2: (()+0x33c20) [0x7f795c316c20]
 3: (gsignal()+0x35) [0x7f795c316ba5]
 4: (abort()+0x180) [0x7f795c31a6b0]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f795cbba6bd]
 6: (()+0xb9906) [0x7f795cbb8906]
 7: (()+0xb9933) [0x7f795cbb8933]
 8: (()+0xb9a3e) [0x7f795cbb8a3e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x456) [0x7f795d702b96]
 10: rados() [0x40c941]
 11: (exit()+0xe2) [0x7f795c31c4f2]
 12: (__libc_start_main()+0x105) [0x7f795c301d95]
 13: rados() [0x405b19]
Aborted

transoft@ubuntu-mon0:/usr/local/etc/ceph$ sudo rados -p data bench 60
rand
Random test not implemented yet!
error during benchmark: -1
transoft@ubuntu-mon0:/usr/local/etc/ceph$=20




Best Regards
Jeff.Wu









--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
