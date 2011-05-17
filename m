From: Simon Tian <aixt2006@gmail.com>
Subject: Re: IOZone Performance is very Strange
Date: Tue, 17 May 2011 16:19:33 +0800
Message-ID: <BANLkTikL+Tb6hkD+DRHh-6rr=2fQnVapaw@mail.gmail.com>
References: <BANLkTiktOCMyP4opCvST_130TotXvSvuyQ@mail.gmail.com>
	<1305638639.1606.4.camel@localhost>
	<BANLkTik7u+WAeztCGYG8yT3Vqv_TUCk+ZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46630 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab1EQITf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 May 2011 04:19:35 -0400
Received: by wya21 with SMTP id 21so178942wya.19
        for <ceph-devel@vger.kernel.org>; Tue, 17 May 2011 01:19:33 -0700 (PDT)
In-Reply-To: <BANLkTik7u+WAeztCGYG8yT3Vqv_TUCk+ZA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: AnnyRen <annyren6@gmail.com>
Cc: cpwu@tnsoft.com.cn, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,
        The throughput of EXT4 is nice.... How about btrfs?

Thx!
Simon

2011/5/17 AnnyRen <annyren6@gmail.com>:
> Hi, Jeff:
>
> I run "ceph osd tell osd_num bench" with 1 times per osd
>
> and use ceph -w to observe every osd performance,
>
> osd0: =C2=A0[INF] bench: wrote 1024 MB in blocks of 4096 KB in 10.875=
844
> sec at 96413 KB/sec
> osd1: =C2=A0[INF] bench: wrote 1024 MB in blocks of 4096 KB in 11.784=
985
> sec at 88975 KB/sec
> osd2: =C2=A0[INF] bench: wrote 1024 MB in blocks of 4096 KB in 11.161=
067
> sec at 93949 KB/sec
> osd3: =C2=A0[INF] bench: wrote 1024 MB in blocks of 4096 KB in 10.798=
796
> sec at 97101 KB/sec
> osd4: =C2=A0[INF] bench: wrote 1024 MB in blocks of 4096 KB in 14.437=
141
> sec at 72630 KB/sec
> osd5: =C2=A0[INF] bench: wrote 1024 MB in blocks of 4096 KB in 14.451=
444
> sec at 72558 KB/sec
> osd6: =C2=A0[INF] bench: wrote 1024 MB in blocks of 4096 KB in 11.083=
872
> sec at 94603 KB/sec
> osd7: =C2=A0[INF] bench: wrote 1024 MB in blocks of 4096 KB in 11.062=
728
> sec at 94784 KB/sec
> osd8: =C2=A0[INF] bench: wrote 1024 MB in blocks of 4096 KB in 14.137=
312
> sec at 74170 KB/sec
> osd9: =C2=A0[INF] bench: wrote 1024 MB in blocks of 4096 KB in 13.489=
992
> sec at 77729 KB/sec
>
>
> and I run
> root@MDS2:/mnt/ceph# rados bench 60 write -p data
>
> the result is
>
> Total time run: =C2=A0 =C2=A0 =C2=A0 =C2=A060.553247
> Total writes made: =C2=A0 =C2=A0 1689
> Write size: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04194304
> Bandwidth (MB/sec): =C2=A0 =C2=A0111.571
>
> Average Latency: =C2=A0 =C2=A0 =C2=A0 0.573209
> Max latency: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2.25691
> Min latency: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.218494
>
>
>
> 2011/5/17 Jeff Wu <cpwu@tnsoft.com.cn>:
>> Hi AnnyRen
>>
>> Could you run the following commands and give us the test results?
>>
>> $ceph osd tell OSD-N bench =C2=A0 =C2=A0// OSD-N : osd number : 0,1,=
2 ....
>> $ceph -w
>>
>> $rados bench 60 write -p data =C2=A0 =C2=A0// refer to "rados -h "
>>
>> Jeff
>>
>>
>>
>> On Tue, 2011-05-17 at 11:53 +0800, AnnyRen wrote:
>>> I'm running iozone on EXT4 with Ceph v0.26.
>>> But I got the weird result, most write performance exceed 1GB/s, ev=
en
>>> up to 3GB/s
>>> I think it's not normal to get the performance outpupt.
>>>
>>> Command line I used is: /usr/bin/iozone -azcR -f
>>> /mnt/ceph/test0516.dbf -g 1G -b /exceloutput0516.xls
>>> Attachment is the output file...
>>>
>>> and my environment is composed of 15 physical machines with
>>>
>>> 3 MON, 2MDS (1 active, 1 standby), 10 OSD (1 osd daemon (3T) /host)
>>> EXT4 format
>>> data replication size: 3
>>>
>>>
>>>
>>> "Writer report"
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 "4" =C2=A0"8" =C2=A0"16" =C2=A0"32" =C2=
=A0"64" =C2=A0"128" =C2=A0"256" =C2=A0"512" =C2=A0"1024"
>>> "2048" =C2=A0"4096" =C2=A0"8192" =C2=A0"16384"
>>> "64" =C2=A0 983980 =C2=A01204796 =C2=A01210227 =C2=A01143223 =C2=A0=
1357066
>>> "128" =C2=A0 1007629 =C2=A01269781 =C2=A01406136 =C2=A01391557 =C2=A0=
1436229 =C2=A01521718
>>> "256" =C2=A0 1112909 =C2=A01430119 =C2=A01523457 =C2=A01652404 =C2=A0=
1514860 =C2=A01639786 =C2=A01729594
>>> "512" =C2=A0 1150351 =C2=A01475116 =C2=A01605228 =C2=A01723770 =C2=A0=
1797349 =C2=A01712772 =C2=A01783912 =C2=A01854787
>>> "1024" =C2=A0 1213334 =C2=A01471481 =C2=A01679160 =C2=A01828574 =C2=
=A01888889 =C2=A01899750 =C2=A01885572
>>> =C2=A01865912 =C2=A01875690
>>> "2048" =C2=A0 1229274 =C2=A01540849 =C2=A01708146 =C2=A01843410 =C2=
=A01903457 =C2=A01980705 =C2=A01930406
>>> =C2=A01913634 =C2=A01906837 =C2=A01815744
>>> "4096" =C2=A0 1213284 =C2=A01528348 =C2=A01674646 =C2=A01762434 =C2=
=A01872096 =C2=A01882352 =C2=A01881528
>>> =C2=A01903416 =C2=A01897949 =C2=A01835102 =C2=A01731177
>>> "8192" =C2=A0 204560 =C2=A0155186 =C2=A0572387 =C2=A0238548 =C2=A01=
86597 =C2=A0429036 =C2=A0187327
>>> 157205 =C2=A0553771 =C2=A0416512 =C2=A0299810 =C2=A0405842
>>> "16384" =C2=A0 699749 =C2=A0559255 =C2=A0687450 =C2=A0541030 =C2=A0=
828776 =C2=A0555296 =C2=A0742561
>>> 525483 =C2=A0604910 =C2=A0452423 =C2=A0564557 =C2=A0670539 =C2=A097=
0616
>>> "32768" =C2=A0 532414 =C2=A0829610 =C2=A0812215 =C2=A0879441 =C2=A0=
863159 =C2=A0864794 =C2=A0865938
>>> 804951 =C2=A0916352 =C2=A0879582 =C2=A0608132 =C2=A0860732 =C2=A012=
39475
>>> "65536" =C2=A0 994824 =C2=A01096543 =C2=A01095791 =C2=A01317968 =C2=
=A01280277 =C2=A01390267 =C2=A01259868
>>> =C2=A01205214 =C2=A01339111 =C2=A01346927 =C2=A01267888 =C2=A086323=
4 =C2=A01190221
>>> "131072" =C2=A0 1063429 =C2=A01165115 =C2=A01102650 =C2=A01554828 =C2=
=A01182128 =C2=A01185731
>>> 1190752 =C2=A01195792 =C2=A01277441 =C2=A01211063 =C2=A01237567 =C2=
=A01226999 =C2=A01336961
>>> "262144" =C2=A0 1280619 =C2=A01368554 =C2=A01497837 =C2=A01633397 =C2=
=A01598255 =C2=A01609212
>>> 1607504 =C2=A01665019 =C2=A01590515 =C2=A01548307 =C2=A01591258 =C2=
=A01505267 =C2=A01625679
>>> "524288" =C2=A0 1519583 =C2=A01767928 =C2=A01738523 =C2=A01883151 =C2=
=A02011216 =C2=A01993877
>>> 2023543 =C2=A01867440 =C2=A02106124 =C2=A02055064 =C2=A01906668 =C2=
=A01778645 =C2=A01838988
>>> "1048576" =C2=A0 1580851 =C2=A01887530 =C2=A02044131 =C2=A02166133 =
=C2=A02236379 =C2=A02283578
>>> 2257454 =C2=A02296612 =C2=A02271066 =C2=A02101274 =C2=A01905829 =C2=
=A01605923 =C2=A02158238
>>>
>>>
>>>
>>> "Reader report"
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 "4" =C2=A0"8" =C2=A0"16" =C2=A0"32" =C2=
=A0"64" =C2=A0"128" =C2=A0"256" =C2=A0"512" =C2=A0"1024"
>>> "2048" =C2=A0"4096" =C2=A0"8192" =C2=A0"16384"
>>> "64" =C2=A0 1933893 =C2=A02801873 =C2=A03057153 =C2=A03363612 =C2=A0=
3958892
>>> "128" =C2=A0 2286447 =C2=A03053774 =C2=A02727923 =C2=A03468030 =C2=A0=
4104338 =C2=A04557257
>>> "256" =C2=A0 2903529 =C2=A03236056 =C2=A03245838 =C2=A03705040 =C2=A0=
3654598 =C2=A04496299 =C2=A05117791
>>> "512" =C2=A0 2906696 =C2=A03437042 =C2=A03628697 =C2=A03431550 =C2=A0=
4871723 =C2=A04296637 =C2=A06246213 =C2=A06395018
>>> "1024" =C2=A0 3229770 =C2=A03483896 =C2=A04609294 =C2=A03791442 =C2=
=A04614246 =C2=A05536137 =C2=A04550690
>>> =C2=A05048117 =C2=A04966395
>>> "2048" =C2=A0 3554251 =C2=A04310472 =C2=A03885431 =C2=A04096676 =C2=
=A06401772 =C2=A04842658 =C2=A05080379
>>> =C2=A05184636 =C2=A05596757 =C2=A05735012
>>> "4096" =C2=A0 3416292 =C2=A04691638 =C2=A04321103 =C2=A05728903 =C2=
=A05475122 =C2=A05171846 =C2=A04819300
>>> =C2=A05258919 =C2=A06408472 =C2=A05044289 =C2=A04079948
>>> "8192" =C2=A0 3233004 =C2=A04615263 =C2=A04536055 =C2=A05618186 =C2=
=A05414558 =C2=A05025700 =C2=A05553712
>>> =C2=A04926264 =C2=A05634770 =C2=A05281396 =C2=A04659702 =C2=A036522=
58
>>> "16384" =C2=A0 3141058 =C2=A03704193 =C2=A04567654 =C2=A04395850 =C2=
=A04568869 =C2=A05387732
>>> 4436432 =C2=A05808029 =C2=A05578420 =C2=A04675810 =C2=A03913007 =C2=
=A03911225 =C2=A03961277
>>> "32768" =C2=A0 3704273 =C2=A04598957 =C2=A04088278 =C2=A05133719 =C2=
=A05896692 =C2=A05537024
>>> 5234412 =C2=A05398271 =C2=A04942992 =C2=A04118662 =C2=A03729099 =C2=
=A03511757 =C2=A03481511
>>> "65536" =C2=A0 4131091 =C2=A04210184 =C2=A05341188 =C2=A04647619 =C2=
=A06077765 =C2=A05852474
>>> 5379762 =C2=A05259330 =C2=A05488249 =C2=A05246682 =C2=A04342682 =C2=
=A03549202 =C2=A03286487
>>> "131072" =C2=A0 3582876 =C2=A05251082 =C2=A05332216 =C2=A05269908 =C2=
=A05303512 =C2=A05574440
>>> 5635064 =C2=A05796372 =C2=A05406363 =C2=A04958839 =C2=A04435918 =C2=
=A03673443 =C2=A03647874
>>> "262144" =C2=A0 3659283 =C2=A04551414 =C2=A05746231 =C2=A05433824 =C2=
=A05876196 =C2=A06011650
>>> 5552000 =C2=A05629260 =C2=A05298830 =C2=A04982226 =C2=A04628902 =C2=
=A04065823 =C2=A03421924
>>> "524288" =C2=A0 3905973 =C2=A05488778 =C2=A05219963 =C2=A06047356 =C2=
=A05916811 =C2=A06180455
>>> 5495733 =C2=A05925628 =C2=A05637512 =C2=A05537123 =C2=A03517132 =C2=
=A03550861 =C2=A03047013
>>> "1048576" =C2=A0 3855595 =C2=A05634571 =C2=A05410298 =C2=A06001809 =
=C2=A06464713 =C2=A06299610
>>> 5894249 =C2=A05516031 =C2=A05800161 =C2=A05209203 =C2=A04295840 =C2=
=A03724983 =C2=A03641623
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
