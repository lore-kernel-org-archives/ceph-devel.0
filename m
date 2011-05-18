From: AnnyRen <annyren6@gmail.com>
Subject: Re: IOZone Performance is very Strange
Date: Wed, 18 May 2011 14:24:46 +0800
Message-ID: <BANLkTi=N9LUp3sYHvU4qj87SP7SjPYYPZw@mail.gmail.com>
References: <BANLkTiktOCMyP4opCvST_130TotXvSvuyQ@mail.gmail.com>
	<1305638639.1606.4.camel@localhost>
	<BANLkTik7u+WAeztCGYG8yT3Vqv_TUCk+ZA@mail.gmail.com>
	<1305651942.1674.17.camel@localhost>
	<BANLkTikkohY1owj4WtP5YdLmmXJiFRAROg@mail.gmail.com>
	<1305727735.6672.24.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53678 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604Ab1ERGYr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 May 2011 02:24:47 -0400
Received: by eyx24 with SMTP id 24so344808eyx.19
        for <ceph-devel@vger.kernel.org>; Tue, 17 May 2011 23:24:46 -0700 (PDT)
In-Reply-To: <1305727735.6672.24.camel@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: cpwu@tnsoft.com.cn
Cc: "jerry1209@cht.com.tw" <jerry1209@cht.com.tw>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

root@MDS2:/mnt/ceph# rados bench 30 write -p data
Maintaining 16 concurrent writes of 4194304 bytes for at least 30 secon=
ds.
  sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg l=
at
    0       0         0         0         0         0         -        =
 0
    1      16        37        21   83.9856        84  0.993284  0.5671=
95
    2      16        64        48   95.9862       108  0.470228  0.5623=
06
    3      16        92        76   101.314       112  0.320282  0.5731=
53
    4      16       119       103   102.983       108  0.645115  0.5757=
08
    5      16       147       131   104.782       112  0.595362   0.572=
43
    6      16       176       160   106.649       116  0.320091  0.5665=
13
    7      16       204       188   107.412       112  0.764551  0.5684=
44
    8      16       230       214   106.983       104  0.519568  0.5706=
81
    9      16       261       245   108.872       124  0.572544  0.5702=
45
   10      16       287       271   108.383       104   1.06776  0.5698=
34
   11      16       317       301   109.437       120  0.450807  0.5699=
28
   12      16       342       326   108.649       100  0.336045  0.5651=
49
   13      16       371       355   109.213       116  0.846668  0.5704=
69
   14      16       400       384   109.696       116  0.758495  0.5700=
53
   15      16       429       413   110.115       116  0.325192  0.5695=
28
   16      16       455       439   109.732       104  0.454317  0.5689=
65
   17      16       485       469   110.335       120   1.36841  0.5701=
14
   18      16       513       497   110.427       112   1.26513   0.569=
56
   19      16       541       525   110.509       112  0.650765   0.570=
68
min lat: 0.237473 max lat: 1.6513 avg lat: 0.570027
  sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg l=
at
   20      16       565       549   109.782        96  0.561031  0.5700=
27
   21      16       593       577   109.886       112  0.619525  0.5701=
06
   22      16       624       608   110.527       124  0.505926  0.5721=
97
   23      16       650       634   110.243       104  0.609987  0.5707=
85
   24      16       679       663   110.482       116  0.475714  0.5699=
79
   25      16       708       692   110.702       116  0.444257  0.5681=
21
   26      16       737       721   110.905       116  0.288582  0.5693=
73
   27      16       766       750   111.093       116   1.15793  0.5677=
02
   28      16       793       777   110.982       108  0.287232   0.569=
45
   29      16       821       805   111.016       112  0.324029  0.5716=
77
   30      16       847       831   110.781       104  0.386532  0.5699=
97
Total time run:        30.413070
Total writes made:     848
Write size:            4194304
Bandwidth (MB/sec):    111.531

Average Latency:       0.573732
Max latency:           1.6513
Min latency:           0.237473



root@MDS2:/mnt/ceph# rados bench 30 seq -p data
  sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg l=
at
    0       0         0         0         0         0         -        =
 0
    1      16        39        23   91.9819        92  0.913858  0.4416=
42
    2      16        68        52   103.984       116  0.259619  0.4721=
26
    3      16        96        80   106.652       112   0.34457  0.5113=
64
    4      16       125       109   108.985       116  0.408573  0.5338=
46
    5      16       153       137   109.584       112   0.28345  0.5508=
11
    6      16       179       163    108.65       104  0.659187  0.5494=
94
    7      16       208       192   109.698       116  0.981796  0.5531=
88
    8      16       234       218   108.984       104  0.539604   0.550=
86
    9      16       264       248   110.206       120  0.479113  0.5474=
96
   10      16       294       278   111.184       120   1.27273  0.5521=
85
   11      16       320       304   110.529       104   1.14992  0.5579=
91
   12      16       349       333   110.984       116  0.933907  0.5596=
65
   13      16       376       360   110.753       108   0.26945  0.5592=
05
   14      16       403       387   110.555       108   1.65993  0.5595=
34
   15      16       432       416   110.916       116  0.895407  0.5632=
38
   16      16       460       444   110.983       112  0.872572  0.5609=
72
   17      16       488       472   111.041       112  0.678441  0.5611=
67
   18      16       516       500   111.094       112  0.737577  0.5630=
33
   19      16       544       528    111.14       112  0.304587  0.5650=
15
min lat: 0.138238 max lat: 2.30221 avg lat: 0.564114
  sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg l=
at
   20      16       573       557   111.381       116  0.413558  0.5641=
14
   21      16       602       586   111.601       116    1.0044  0.5613=
93
   22      16       627       611   111.072       100   1.33495  0.5625=
11
   23      16       658       642   111.633       124   1.28495  0.5643=
87
   24      16       685       669   111.482       108  0.255379  0.5652=
83
   25      16       714       698   111.662       116  0.979657  0.5655=
71
   26      16       742       726   111.674       112  0.296857  0.5617=
89
   27      16       770       754   111.685       112  0.205119   0.558=
78
   28      16       796       780    111.41       104   0.44966  0.5592=
54
   29      16       826       810   111.706       120  0.432128  0.5592=
98
read got -2
error during benchmark: -5
error 5: Input/output error


Do you know What happened to the final output of read performance test~=
?

Thank you, Jeff!!  :-)


Anny






2011/5/18 Jeff Wu <cpwu@tnsoft.com.cn>:
> Hi ,
>
> Normally , read performance should be more than write performance ,ab=
out
> 20% ~ 30% .
>
> Could you run the following commands and attach all of the results ?
> =A0$rados bench 30 write -p data =A0 //write performance
> =A0$rados bench 30 seq =A0-p data =A0 =A0// read performance //
>
>
>
> On Wed, 2011-05-18 at 13:54 +0800, AnnyRen wrote:
>> Hi Jeff & Henry,
>>
>> I took your advice and used the following command to run iozone test
>>
>> /usr/bin/iozone -z -c -e -a -n 512M -g 2G -i 0 -i 1 -i 2 -f
>> /mnt/ceph/file0517.dbf -Rb /excel0517.xls
>>
>> Attachment is the output result.
>>
>> Writer Report
>> =A0 =A0 =A0 4 =A0 =A0 =A0 8 =A0 =A0 =A0 16 =A0 =A0 =A032 =A0 =A0 =A0=
64 =A0 =A0 =A0128 =A0 =A0 256 =A0 =A0 512 =A0 =A0 1024 =A0 =A02048 =A0 =
=A04096 =A0 =A08192 =A0 =A016384
>> 524288 =A0 =A0 =A0 =A097920 =A0 101778 =A097050 =A0 103121 =A0103445=
 =A0102137 =A0101082 =A0101993 =A098835 =A0 103674 =A0102043 =A099424 =A0=
 102679
>> 1048576 =A0 =A0 =A0 104306 =A0104841 =A0103616 =A0105884 =A0106044 =A0=
102221 =A0105666 =A0105890 =A0105811 =A0106409 =A0103957 =A0104062 =A01=
02115
>> 2097152 =A0 =A0 =A0 106896 =A0107989 =A0108428 =A0107500 =A0108453 =A0=
108444 =A0109584 =A0108618 =A0109413 =A0108102 =A0107529 =A0108357 =A01=
07545
>>
>> Reader Report
>> =A0 =A0 =A0 4 =A0 =A0 =A0 8 =A0 =A0 =A0 16 =A0 =A0 =A032 =A0 =A0 =A0=
64 =A0 =A0 =A0128 =A0 =A0 256 =A0 =A0 512 =A0 =A0 1024 =A0 =A02048 =A0 =
=A04096 =A0 =A08192 =A0 =A016384
>> 524288 =A0 =A0 =A0 =A03756286 5029629 5049864 5810960 5577953 555460=
6 5388867 5636832 5709141 5253596 3805560 3640738 3442332
>> 1048576 =A0 =A0 =A0 3709316 4733745 5400857 5655874 5788923 5565162 =
5865768 5546521 5886345 5167771 4485693 3531487 3473877
>> 2097152 =A0 =A0 =A0 4305329 5103282 5713626 6399318 6180508 6392487 =
5804140 4621404 5873338 5837715 4181626 3420274 3506328
>>
>>
>> the file size grows from 512 MB to 2 GB, write performance is about =
94
>> MB/s~ 106 MB/s
>> and read performance still exceed 3 GB~6 GB, is it too fast ?
>>
>> Or we used the cache or buffer but we don't know? if yes, how could =
we
>> avoid to use the cache to read ?
>> Thanks very much. :-)
>>
>> Best Regards,
>> Anny
>>
>>
>>
>>
>> 2011/5/18 Jeff Wu <cpwu@tnsoft.com.cn>:
>> >
>> > Hi AnnyRen,
>> >
>> > with the test results , =A0run a 1G data at your ceph cluster ,
>> > should be about 100M/sec.
>> > maybe,iozone test results didn't include iozone flush time.
>> >
>> > Could you list your hardware platform infos ?
>> > network:1G,4G,8G,FC ...?,cpu,memory:size ? ,disk:PATA,SATA,SAS,SSD=
 ??
>> > and
>> > could you try other iozone commands ,for instance :
>> >
>> > 1)
>> > add "-e" param to include flush(fsync,fflush) in the timing
>> > calculations.
>> >
>> > /usr/bin/iozone -azcR -e -f /mnt/ceph/test0516.dbf =A0\
>> > -g 1G -b /exceloutput0516.xls
>> >
>> > 2)run a large data which size is your host memory size*2:
>> >
>> > $./iozone -z -c -e -a -n 512M -g {memory_size}*2M -i 0 -i 1 -i 2 =A0=
\
>> > -f /mnt/ceph/fio -Rb ./iozone.xls
>> >
>> > or
>> > 2)
>> > !/bin/sh
>> >
>> > for i in 32 64 128 256
>> > do
>> > ./iozone -r ${i}k -t 10 -s 4096M -i 0 -i 1 -i 2 =A0 \
>> > -F /mnt/ceph/F1 /mnt/ceph/F2 /mnt/ceph/F3 /mnt/ceph/F4 /mnt/ceph/F=
5 /mnt/ceph/F6 /mnt/ceph/F7 /mnt/ceph/F8 /mnt/ceph/F9 /mnt/ceph/F10
>> > done
>> >
>> >
>> >
>> >
>> > Jeff
>> >
>> >
>> >
>> >
>> >
>> >
>> > On Tue, 2011-05-17 at 15:34 +0800, AnnyRen wrote:
>> >> Hi, Jeff:
>> >>
>> >> I run "ceph osd tell osd_num bench" with 1 times per osd
>> >>
>> >> and use ceph -w to observe every osd performance,
>> >>
>> >> osd0: =A0[INF] bench: wrote 1024 MB in blocks of 4096 KB in 10.87=
5844
>> >> sec at 96413 KB/sec
>> >> osd1: =A0[INF] bench: wrote 1024 MB in blocks of 4096 KB in 11.78=
4985
>> >> sec at 88975 KB/sec
>> >> osd2: =A0[INF] bench: wrote 1024 MB in blocks of 4096 KB in 11.16=
1067
>> >> sec at 93949 KB/sec
>> >> osd3: =A0[INF] bench: wrote 1024 MB in blocks of 4096 KB in 10.79=
8796
>> >> sec at 97101 KB/sec
>> >> osd4: =A0[INF] bench: wrote 1024 MB in blocks of 4096 KB in 14.43=
7141
>> >> sec at 72630 KB/sec
>> >> osd5: =A0[INF] bench: wrote 1024 MB in blocks of 4096 KB in 14.45=
1444
>> >> sec at 72558 KB/sec
>> >> osd6: =A0[INF] bench: wrote 1024 MB in blocks of 4096 KB in 11.08=
3872
>> >> sec at 94603 KB/sec
>> >> osd7: =A0[INF] bench: wrote 1024 MB in blocks of 4096 KB in 11.06=
2728
>> >> sec at 94784 KB/sec
>> >> osd8: =A0[INF] bench: wrote 1024 MB in blocks of 4096 KB in 14.13=
7312
>> >> sec at 74170 KB/sec
>> >> osd9: =A0[INF] bench: wrote 1024 MB in blocks of 4096 KB in 13.48=
9992
>> >> sec at 77729 KB/sec
>> >>
>> >>
>> >> and I run
>> >> root@MDS2:/mnt/ceph# rados bench 60 write -p data
>> >>
>> >> the result is
>> >>
>> >> Total time run: =A0 =A0 =A0 =A060.553247
>> >> Total writes made: =A0 =A0 1689
>> >> Write size: =A0 =A0 =A0 =A0 =A0 =A04194304
>> >> Bandwidth (MB/sec): =A0 =A0111.571
>> >>
>> >> Average Latency: =A0 =A0 =A0 0.573209
>> >> Max latency: =A0 =A0 =A0 =A0 =A0 2.25691
>> >> Min latency: =A0 =A0 =A0 =A0 =A0 0.218494
>> >>
>> >>
>> >>
>> >> 2011/5/17 Jeff Wu <cpwu@tnsoft.com.cn>:
>> >> > Hi AnnyRen
>> >> >
>> >> > Could you run the following commands and give us the test resul=
ts?
>> >> >
>> >> > $ceph osd tell OSD-N bench =A0 =A0// OSD-N : osd number : 0,1,2=
 ....
>> >> > $ceph -w
>> >> >
>> >> > $rados bench 60 write -p data =A0 =A0// refer to "rados -h "
>> >> >
>> >> > Jeff
>> >> >
>> >> >
>> >> >
>> >> > On Tue, 2011-05-17 at 11:53 +0800, AnnyRen wrote:
>> >> >> I'm running iozone on EXT4 with Ceph v0.26.
>> >> >> But I got the weird result, most write performance exceed 1GB/=
s, even
>> >> >> up to 3GB/s
>> >> >> I think it's not normal to get the performance outpupt.
>> >> >>
>> >> >> Command line I used is: /usr/bin/iozone -azcR -f
>> >> >> /mnt/ceph/test0516.dbf -g 1G -b /exceloutput0516.xls
>> >> >> Attachment is the output file...
>> >> >>
>> >> >> and my environment is composed of 15 physical machines with
>> >> >>
>> >> >> 3 MON, 2MDS (1 active, 1 standby), 10 OSD (1 osd daemon (3T) /=
host)
>> >> >> EXT4 format
>> >> >> data replication size: 3
>> >> >>
>> >> >>
>> >> >>
>> >> >> "Writer report"
>> >> >> =A0 =A0 =A0 =A0 "4" =A0"8" =A0"16" =A0"32" =A0"64" =A0"128" =A0=
"256" =A0"512" =A0"1024"
>> >> >> "2048" =A0"4096" =A0"8192" =A0"16384"
>> >> >> "64" =A0 983980 =A01204796 =A01210227 =A01143223 =A01357066
>> >> >> "128" =A0 1007629 =A01269781 =A01406136 =A01391557 =A01436229 =
=A01521718
>> >> >> "256" =A0 1112909 =A01430119 =A01523457 =A01652404 =A01514860 =
=A01639786 =A01729594
>> >> >> "512" =A0 1150351 =A01475116 =A01605228 =A01723770 =A01797349 =
=A01712772 =A01783912 =A01854787
>> >> >> "1024" =A0 1213334 =A01471481 =A01679160 =A01828574 =A01888889=
 =A01899750 =A01885572
>> >> >> =A01865912 =A01875690
>> >> >> "2048" =A0 1229274 =A01540849 =A01708146 =A01843410 =A01903457=
 =A01980705 =A01930406
>> >> >> =A01913634 =A01906837 =A01815744
>> >> >> "4096" =A0 1213284 =A01528348 =A01674646 =A01762434 =A01872096=
 =A01882352 =A01881528
>> >> >> =A01903416 =A01897949 =A01835102 =A01731177
>> >> >> "8192" =A0 204560 =A0155186 =A0572387 =A0238548 =A0186597 =A04=
29036 =A0187327
>> >> >> 157205 =A0553771 =A0416512 =A0299810 =A0405842
>> >> >> "16384" =A0 699749 =A0559255 =A0687450 =A0541030 =A0828776 =A0=
555296 =A0742561
>> >> >> 525483 =A0604910 =A0452423 =A0564557 =A0670539 =A0970616
>> >> >> "32768" =A0 532414 =A0829610 =A0812215 =A0879441 =A0863159 =A0=
864794 =A0865938
>> >> >> 804951 =A0916352 =A0879582 =A0608132 =A0860732 =A01239475
>> >> >> "65536" =A0 994824 =A01096543 =A01095791 =A01317968 =A01280277=
 =A01390267 =A01259868
>> >> >> =A01205214 =A01339111 =A01346927 =A01267888 =A0863234 =A011902=
21
>> >> >> "131072" =A0 1063429 =A01165115 =A01102650 =A01554828 =A011821=
28 =A01185731
>> >> >> 1190752 =A01195792 =A01277441 =A01211063 =A01237567 =A01226999=
 =A01336961
>> >> >> "262144" =A0 1280619 =A01368554 =A01497837 =A01633397 =A015982=
55 =A01609212
>> >> >> 1607504 =A01665019 =A01590515 =A01548307 =A01591258 =A01505267=
 =A01625679
>> >> >> "524288" =A0 1519583 =A01767928 =A01738523 =A01883151 =A020112=
16 =A01993877
>> >> >> 2023543 =A01867440 =A02106124 =A02055064 =A01906668 =A01778645=
 =A01838988
>> >> >> "1048576" =A0 1580851 =A01887530 =A02044131 =A02166133 =A02236=
379 =A02283578
>> >> >> 2257454 =A02296612 =A02271066 =A02101274 =A01905829 =A01605923=
 =A02158238
>> >> >>
>> >> >>
>> >> >>
>> >> >> "Reader report"
>> >> >> =A0 =A0 =A0 =A0 "4" =A0"8" =A0"16" =A0"32" =A0"64" =A0"128" =A0=
"256" =A0"512" =A0"1024"
>> >> >> "2048" =A0"4096" =A0"8192" =A0"16384"
>> >> >> "64" =A0 1933893 =A02801873 =A03057153 =A03363612 =A03958892
>> >> >> "128" =A0 2286447 =A03053774 =A02727923 =A03468030 =A04104338 =
=A04557257
>> >> >> "256" =A0 2903529 =A03236056 =A03245838 =A03705040 =A03654598 =
=A04496299 =A05117791
>> >> >> "512" =A0 2906696 =A03437042 =A03628697 =A03431550 =A04871723 =
=A04296637 =A06246213 =A06395018
>> >> >> "1024" =A0 3229770 =A03483896 =A04609294 =A03791442 =A04614246=
 =A05536137 =A04550690
>> >> >> =A05048117 =A04966395
>> >> >> "2048" =A0 3554251 =A04310472 =A03885431 =A04096676 =A06401772=
 =A04842658 =A05080379
>> >> >> =A05184636 =A05596757 =A05735012
>> >> >> "4096" =A0 3416292 =A04691638 =A04321103 =A05728903 =A05475122=
 =A05171846 =A04819300
>> >> >> =A05258919 =A06408472 =A05044289 =A04079948
>> >> >> "8192" =A0 3233004 =A04615263 =A04536055 =A05618186 =A05414558=
 =A05025700 =A05553712
>> >> >> =A04926264 =A05634770 =A05281396 =A04659702 =A03652258
>> >> >> "16384" =A0 3141058 =A03704193 =A04567654 =A04395850 =A0456886=
9 =A05387732
>> >> >> 4436432 =A05808029 =A05578420 =A04675810 =A03913007 =A03911225=
 =A03961277
>> >> >> "32768" =A0 3704273 =A04598957 =A04088278 =A05133719 =A0589669=
2 =A05537024
>> >> >> 5234412 =A05398271 =A04942992 =A04118662 =A03729099 =A03511757=
 =A03481511
>> >> >> "65536" =A0 4131091 =A04210184 =A05341188 =A04647619 =A0607776=
5 =A05852474
>> >> >> 5379762 =A05259330 =A05488249 =A05246682 =A04342682 =A03549202=
 =A03286487
>> >> >> "131072" =A0 3582876 =A05251082 =A05332216 =A05269908 =A053035=
12 =A05574440
>> >> >> 5635064 =A05796372 =A05406363 =A04958839 =A04435918 =A03673443=
 =A03647874
>> >> >> "262144" =A0 3659283 =A04551414 =A05746231 =A05433824 =A058761=
96 =A06011650
>> >> >> 5552000 =A05629260 =A05298830 =A04982226 =A04628902 =A04065823=
 =A03421924
>> >> >> "524288" =A0 3905973 =A05488778 =A05219963 =A06047356 =A059168=
11 =A06180455
>> >> >> 5495733 =A05925628 =A05637512 =A05537123 =A03517132 =A03550861=
 =A03047013
>> >> >> "1048576" =A0 3855595 =A05634571 =A05410298 =A06001809 =A06464=
713 =A06299610
>> >> >> 5894249 =A05516031 =A05800161 =A05209203 =A04295840 =A03724983=
 =A03641623
>> >> >
>> >> >
>> >
>> >
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
