From: AnnyRen <annyren6@gmail.com>
Subject: Re: IOZone Performance is very Strange
Date: Tue, 17 May 2011 15:34:21 +0800
Message-ID: <BANLkTik7u+WAeztCGYG8yT3Vqv_TUCk+ZA@mail.gmail.com>
References: <BANLkTiktOCMyP4opCvST_130TotXvSvuyQ@mail.gmail.com>
	<1305638639.1606.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:57918 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687Ab1EQHeX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 May 2011 03:34:23 -0400
Received: by ewy4 with SMTP id 4so56842ewy.19
        for <ceph-devel@vger.kernel.org>; Tue, 17 May 2011 00:34:22 -0700 (PDT)
In-Reply-To: <1305638639.1606.4.camel@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: cpwu@tnsoft.com.cn
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi, Jeff:

I run "ceph osd tell osd_num bench" with 1 times per osd

and use ceph -w to observe every osd performance,

osd0:  [INF] bench: wrote 1024 MB in blocks of 4096 KB in 10.875844
sec at 96413 KB/sec
osd1:  [INF] bench: wrote 1024 MB in blocks of 4096 KB in 11.784985
sec at 88975 KB/sec
osd2:  [INF] bench: wrote 1024 MB in blocks of 4096 KB in 11.161067
sec at 93949 KB/sec
osd3:  [INF] bench: wrote 1024 MB in blocks of 4096 KB in 10.798796
sec at 97101 KB/sec
osd4:  [INF] bench: wrote 1024 MB in blocks of 4096 KB in 14.437141
sec at 72630 KB/sec
osd5:  [INF] bench: wrote 1024 MB in blocks of 4096 KB in 14.451444
sec at 72558 KB/sec
osd6:  [INF] bench: wrote 1024 MB in blocks of 4096 KB in 11.083872
sec at 94603 KB/sec
osd7:  [INF] bench: wrote 1024 MB in blocks of 4096 KB in 11.062728
sec at 94784 KB/sec
osd8:  [INF] bench: wrote 1024 MB in blocks of 4096 KB in 14.137312
sec at 74170 KB/sec
osd9:  [INF] bench: wrote 1024 MB in blocks of 4096 KB in 13.489992
sec at 77729 KB/sec


and I run
root@MDS2:/mnt/ceph# rados bench 60 write -p data

the result is

Total time run:        60.553247
Total writes made:     1689
Write size:            4194304
Bandwidth (MB/sec):    111.571

Average Latency:       0.573209
Max latency:           2.25691
Min latency:           0.218494



2011/5/17 Jeff Wu <cpwu@tnsoft.com.cn>:
> Hi AnnyRen
>
> Could you run the following commands and give us the test results?
>
> $ceph osd tell OSD-N bench =A0 =A0// OSD-N : osd number : 0,1,2 ....
> $ceph -w
>
> $rados bench 60 write -p data =A0 =A0// refer to "rados -h "
>
> Jeff
>
>
>
> On Tue, 2011-05-17 at 11:53 +0800, AnnyRen wrote:
>> I'm running iozone on EXT4 with Ceph v0.26.
>> But I got the weird result, most write performance exceed 1GB/s, eve=
n
>> up to 3GB/s
>> I think it's not normal to get the performance outpupt.
>>
>> Command line I used is: /usr/bin/iozone -azcR -f
>> /mnt/ceph/test0516.dbf -g 1G -b /exceloutput0516.xls
>> Attachment is the output file...
>>
>> and my environment is composed of 15 physical machines with
>>
>> 3 MON, 2MDS (1 active, 1 standby), 10 OSD (1 osd daemon (3T) /host)
>> EXT4 format
>> data replication size: 3
>>
>>
>>
>> "Writer report"
>> =A0 =A0 =A0 =A0 "4" =A0"8" =A0"16" =A0"32" =A0"64" =A0"128" =A0"256"=
 =A0"512" =A0"1024"
>> "2048" =A0"4096" =A0"8192" =A0"16384"
>> "64" =A0 983980 =A01204796 =A01210227 =A01143223 =A01357066
>> "128" =A0 1007629 =A01269781 =A01406136 =A01391557 =A01436229 =A0152=
1718
>> "256" =A0 1112909 =A01430119 =A01523457 =A01652404 =A01514860 =A0163=
9786 =A01729594
>> "512" =A0 1150351 =A01475116 =A01605228 =A01723770 =A01797349 =A0171=
2772 =A01783912 =A01854787
>> "1024" =A0 1213334 =A01471481 =A01679160 =A01828574 =A01888889 =A018=
99750 =A01885572
>> =A01865912 =A01875690
>> "2048" =A0 1229274 =A01540849 =A01708146 =A01843410 =A01903457 =A019=
80705 =A01930406
>> =A01913634 =A01906837 =A01815744
>> "4096" =A0 1213284 =A01528348 =A01674646 =A01762434 =A01872096 =A018=
82352 =A01881528
>> =A01903416 =A01897949 =A01835102 =A01731177
>> "8192" =A0 204560 =A0155186 =A0572387 =A0238548 =A0186597 =A0429036 =
=A0187327
>> 157205 =A0553771 =A0416512 =A0299810 =A0405842
>> "16384" =A0 699749 =A0559255 =A0687450 =A0541030 =A0828776 =A0555296=
 =A0742561
>> 525483 =A0604910 =A0452423 =A0564557 =A0670539 =A0970616
>> "32768" =A0 532414 =A0829610 =A0812215 =A0879441 =A0863159 =A0864794=
 =A0865938
>> 804951 =A0916352 =A0879582 =A0608132 =A0860732 =A01239475
>> "65536" =A0 994824 =A01096543 =A01095791 =A01317968 =A01280277 =A013=
90267 =A01259868
>> =A01205214 =A01339111 =A01346927 =A01267888 =A0863234 =A01190221
>> "131072" =A0 1063429 =A01165115 =A01102650 =A01554828 =A01182128 =A0=
1185731
>> 1190752 =A01195792 =A01277441 =A01211063 =A01237567 =A01226999 =A013=
36961
>> "262144" =A0 1280619 =A01368554 =A01497837 =A01633397 =A01598255 =A0=
1609212
>> 1607504 =A01665019 =A01590515 =A01548307 =A01591258 =A01505267 =A016=
25679
>> "524288" =A0 1519583 =A01767928 =A01738523 =A01883151 =A02011216 =A0=
1993877
>> 2023543 =A01867440 =A02106124 =A02055064 =A01906668 =A01778645 =A018=
38988
>> "1048576" =A0 1580851 =A01887530 =A02044131 =A02166133 =A02236379 =A0=
2283578
>> 2257454 =A02296612 =A02271066 =A02101274 =A01905829 =A01605923 =A021=
58238
>>
>>
>>
>> "Reader report"
>> =A0 =A0 =A0 =A0 "4" =A0"8" =A0"16" =A0"32" =A0"64" =A0"128" =A0"256"=
 =A0"512" =A0"1024"
>> "2048" =A0"4096" =A0"8192" =A0"16384"
>> "64" =A0 1933893 =A02801873 =A03057153 =A03363612 =A03958892
>> "128" =A0 2286447 =A03053774 =A02727923 =A03468030 =A04104338 =A0455=
7257
>> "256" =A0 2903529 =A03236056 =A03245838 =A03705040 =A03654598 =A0449=
6299 =A05117791
>> "512" =A0 2906696 =A03437042 =A03628697 =A03431550 =A04871723 =A0429=
6637 =A06246213 =A06395018
>> "1024" =A0 3229770 =A03483896 =A04609294 =A03791442 =A04614246 =A055=
36137 =A04550690
>> =A05048117 =A04966395
>> "2048" =A0 3554251 =A04310472 =A03885431 =A04096676 =A06401772 =A048=
42658 =A05080379
>> =A05184636 =A05596757 =A05735012
>> "4096" =A0 3416292 =A04691638 =A04321103 =A05728903 =A05475122 =A051=
71846 =A04819300
>> =A05258919 =A06408472 =A05044289 =A04079948
>> "8192" =A0 3233004 =A04615263 =A04536055 =A05618186 =A05414558 =A050=
25700 =A05553712
>> =A04926264 =A05634770 =A05281396 =A04659702 =A03652258
>> "16384" =A0 3141058 =A03704193 =A04567654 =A04395850 =A04568869 =A05=
387732
>> 4436432 =A05808029 =A05578420 =A04675810 =A03913007 =A03911225 =A039=
61277
>> "32768" =A0 3704273 =A04598957 =A04088278 =A05133719 =A05896692 =A05=
537024
>> 5234412 =A05398271 =A04942992 =A04118662 =A03729099 =A03511757 =A034=
81511
>> "65536" =A0 4131091 =A04210184 =A05341188 =A04647619 =A06077765 =A05=
852474
>> 5379762 =A05259330 =A05488249 =A05246682 =A04342682 =A03549202 =A032=
86487
>> "131072" =A0 3582876 =A05251082 =A05332216 =A05269908 =A05303512 =A0=
5574440
>> 5635064 =A05796372 =A05406363 =A04958839 =A04435918 =A03673443 =A036=
47874
>> "262144" =A0 3659283 =A04551414 =A05746231 =A05433824 =A05876196 =A0=
6011650
>> 5552000 =A05629260 =A05298830 =A04982226 =A04628902 =A04065823 =A034=
21924
>> "524288" =A0 3905973 =A05488778 =A05219963 =A06047356 =A05916811 =A0=
6180455
>> 5495733 =A05925628 =A05637512 =A05537123 =A03517132 =A03550861 =A030=
47013
>> "1048576" =A0 3855595 =A05634571 =A05410298 =A06001809 =A06464713 =A0=
6299610
>> 5894249 =A05516031 =A05800161 =A05209203 =A04295840 =A03724983 =A036=
41623
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
