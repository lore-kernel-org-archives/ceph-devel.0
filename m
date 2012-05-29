From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: Re: poor OSD performance using kernel 3.4
Date: Tue, 29 May 2012 23:31:12 +0200
Message-ID: <4FC54020.8040603@univ-nantes.fr>
References: <5970d59f-9531-4f60-8600-3e1268824c83@mailpro> <4FC49B12.8020004@profihost.ag> <4FC4D1A8.1080001@univ-nantes.fr> <4FC4E0A9.8010008@profihost.ag> <4FC50C4A.4090101@inktank.com> <4FC53AC4.5020600@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls1-cha.cpub.univ-nantes.fr ([193.52.103.113]:50657 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755921Ab2E2VbS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 May 2012 17:31:18 -0400
In-Reply-To: <4FC53AC4.5020600@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Mark Nelson <mark.nelson@inktank.com>, ceph-devel@vger.kernel.org

Le 29/05/2012 23:08, Stefan Priebe a =C3=A9crit :
> Am 29.05.2012 19:50, schrieb Mark Nelson:
>> I did some quick tests on a couple of nodes I had laying around this
>> morning.
>
> I just noticed that i get a constant rate of 40MB/s while using 1=20
> thread. When i use two thread or more i get drop to 0MB/s and crazy=20
> jumping values.
>
> ~# rados -p rbd bench 90 write -t 1
> Maintaining 1 concurrent writes of 4194304 bytes for at least 90 seco=
nds.
>   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg=
 lat
>     0       0         0         0         0         0         -      =
   0
>     1       1        10         9    35.994        36  0.100147  0.10=
1133
>     2       1        20        19   37.9931        40  0.096893  0.10=
0719
>     3       1        31        30   39.9921        44   0.09784 0.099=
9607
>     4       1        41        40   39.9929        40  0.099156 0.099=
9003
>     5       1        51        50   39.9932        40  0.098239 0.099=
6518
>     6       1        61        60   39.9932        40  0.098682 0.099=
4851
>     7       1        71        70   39.9933        40  0.094397  0.09=
9184
>     8       1        81        80   39.9931        40  0.099823 0.099=
3327
>     9       1        91        90   39.9931        40  0.101013 0.099=
2236
>    10       1       101       100    39.993        40  0.098277  0.09=
9237
>
>

not here :

on data :
root@label5:~# rados -p data bench 20 write -t 1
Maintaining 1 concurrent writes of 4194304 bytes for at least 20 second=
s.
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg =
lat
     0       0         0         0         0         0         -       =
  0
     1       1        15        14   55.9837        56  0.096813 0.0677=
311
     2       1        33        32   63.9852        72  0.088802 0.0612=
602
     3       1        51        50   66.6529        72  0.056883 0.0594=
909
     4       1        60        59    58.989        36  0.046377 0.0577=
145
     5       1        60        59   47.1916         0         - 0.0577=
145
     6       1        79        78   51.9911        38  0.041831 0.0768=
918
     7       1        98        97    55.419        76  0.050436 0.0718=
439
     8       1       101       100   49.9919        12  0.043673 0.0712=
079
     9       1       101       100   44.4375         0         - 0.0712=
079
    10       1       115       114   45.5929        28  0.043768 0.0876=
947
    11       1       134       133    48.356        76  0.052382 0.0826=
428
    12       1       154       153   50.9919        80  0.042077 0.0783=
619
    13       1       175       174   53.5299        84  0.053474 0.0745=
956
    14       1       194       193   55.1339        76  0.049631 0.0724=
711
    15       1       211       210    55.991        68  0.052683 0.0712=
887
    16       1       232       231   57.7407        84  0.044341 0.0692=
121
    17       1       249       248   58.3436        68  0.053707 0.0684=
414
    18       1       258       257    57.102        36  0.086088 0.0680=
656
    19       1       267       266   55.9911        36  0.050902 0.0713=
341
min lat: 0.033395 max lat: 2.14757 avg lat: 0.0703545
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg =
lat
    20       1       285       284   56.7909        72  0.047755 0.0703=
545
Total time run:        20.066134
Total writes made:     286
Write size:            4194304
Bandwidth (MB/sec):    57.011

on rbd :


Maintaining 1 concurrent writes of 4194304 bytes for at least 20 second=
s.
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg =
lat
     0       1         1         0         0         0         -       =
  0
     1       1        18        17   67.9801        68  0.065869 0.0587=
313
     2       1        35        34   67.9842        68  0.056982 0.0580=
468
     3       1        55        54   71.9848        80  0.050305 0.0554=
721
     4       1        72        71   70.9858        68  0.039387 0.0561=
269
     5       1        91        90    71.986        76  0.055236 0.0554=
057
     6       1       109       108   71.9864        72  0.069547 0.0554=
112
     7       1       126       125   71.4154        68  0.049234 0.0556=
564
     8       1       146       145   72.4868        80  0.052302 0.0551=
064
     9       1       165       164   72.8758        76    0.0533 0.0548=
858
    10       1       184       183    73.187        76  0.041342 0.0543=
598
    11       1       202       201    73.078        72  0.048963 0.0544=
978
    12       1       218       217   72.3207        64  0.071926 0.0549=
402
    13       1       236       235   72.2951        72  0.055804 0.0551=
936
    14       1       254       253   72.2731        72  0.058315 0.0552=
612
    15       1       272       271   72.2541        72  0.047687 0.0552=
036
    16       1       290       289   72.2375        72  0.059162  0.055=
275
    17       1       308       307   72.2229        72  0.051991 0.0553=
467
    18       1       327       326    72.432        76  0.053271 0.0552=
114
    19       1       346       345   72.6192        76  0.058125 0.0550=
658
min lat: 0.036202 max lat: 0.113077 avg lat: 0.0547502
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg =
lat
    20       1       366       365   72.9874        80  0.036246 0.0547=
502
Total time run:        20.086555
Total writes made:     367
Write size:            4194304
Bandwidth (MB/sec):    73.084

>
> # rados -p rbd bench 90 write -t 2
> Maintaining 2 concurrent writes of 4194304 bytes for at least 90 seco=
nds.
>   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg=
 lat
>     0       0         0         0         0         0         -      =
   0
>     1       2        15        13   51.9888        52    0.0956  0.11=
5315
>     2       2        22        20   39.9928        28  0.120065  0.19=
3125
>     3       2        41        39   51.9917        76   0.09557   0.1=
5246
>     4       2        58        56   55.9912        68   0.09875  0.13=
7688
>     5       2        67        65    51.992        36  0.111211  0.13=
9465
>     6       2        85        83   55.3251        72  0.136967  0.14=
3079
>     7       2       101        99   56.5625        64  0.098664  0.13=
6263
>     8       2       101        99   49.4919         0         -  0.13=
6263
>     9       2       112       110   48.8808        22  0.099479  0.16=
0563
>
> Stefan

pool rbd stays consistent here, no matter how much thread involved. The=
=20
max speed with my setup is around 16~24 threads, and it's quite effecti=
ve.

on the contrary, pool data is jumping up & down, no matter how much=20
thread involved :)

Maybe this is because journal is too tight ? Or because 2 of the 8 node=
s=20
have slower disks ?

I may be able to retest thursday, my two last osd should have faster &=20
larger disks.

Cheers,

--=20
Yann Dupont - Service IRTS, DSI Universit=C3=A9 de Nantes
Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
