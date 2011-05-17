From: AnnyRen <annyren6@gmail.com>
Subject: Re: IOZone Performance is very Strange
Date: Tue, 17 May 2011 17:44:35 +0800
Message-ID: <BANLkTinm_p-HYmZMoe9CwosjWFTi0L7bRw@mail.gmail.com>
References: <BANLkTiktOCMyP4opCvST_130TotXvSvuyQ@mail.gmail.com>
	<1305638639.1606.4.camel@localhost>
	<BANLkTik7u+WAeztCGYG8yT3Vqv_TUCk+ZA@mail.gmail.com>
	<1305651942.1674.17.camel@localhost>
	<BANLkTim0+VPeOPcuQMrR+2zECq9jwK1hSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:51264 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753663Ab1EQJoh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 May 2011 05:44:37 -0400
Received: by ewy4 with SMTP id 4so82959ewy.19
        for <ceph-devel@vger.kernel.org>; Tue, 17 May 2011 02:44:35 -0700 (PDT)
In-Reply-To: <BANLkTim0+VPeOPcuQMrR+2zECq9jwK1hSg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: cpwu@tnsoft.com.cn, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Henry,

Thanks for your suggestion! We'll try it.  :)
Hopefully come out with good result!  Thank you.

Best Regards,
Anny

2011/5/17 Henry C Chang <henry.cy.chang@gmail.com>:
> Hi Anny,
>
> As Jeff mentioned, you need to add the following option for iozone te=
sting:
> -e: include flush in the timing calculation to remedy the cache effec=
t
>
> and may add:
> -n: set the minimum size for auto mode (e.g., -n 256M) to skip testin=
g
> of small file sizes
>
> and drop -z if you want to omit testing small record sizes. (starting
> from 64K instead of 4K)
>
> --
> Henry
>
>
> 2011/5/18 Jeff Wu <cpwu@tnsoft.com.cn>:
>>
>> Hi AnnyRen,
>>
>> with the test results , =A0run a 1G data at your ceph cluster ,
>> should be about 100M/sec.
>> maybe,iozone test results didn't include iozone flush time.
>>
>> Could you list your hardware platform infos ?
>> network:1G,4G,8G,FC ...?,cpu,memory:size ? ,disk:PATA,SATA,SAS,SSD ?=
?
>> and
>> could you try other iozone commands ,for instance :
>>
>> 1)
>> add "-e" param to include flush(fsync,fflush) in the timing
>> calculations.
>>
>> /usr/bin/iozone -azcR -e -f /mnt/ceph/test0516.dbf =A0\
>> -g 1G -b /exceloutput0516.xls
>>
>> 2)run a large data which size is your host memory size*2:
>>
>> $./iozone -z -c -e -a -n 512M -g {memory_size}*2M -i 0 -i 1 -i 2 =A0=
\
>> -f /mnt/ceph/fio -Rb ./iozone.xls
>>
>> or
>> 2)
>> !/bin/sh
>>
>> for i in 32 64 128 256
>> do
>> ./iozone -r ${i}k -t 10 -s 4096M -i 0 -i 1 -i 2 =A0 \
>> -F /mnt/ceph/F1 /mnt/ceph/F2 /mnt/ceph/F3 /mnt/ceph/F4 /mnt/ceph/F5 =
/mnt/ceph/F6 /mnt/ceph/F7 /mnt/ceph/F8 /mnt/ceph/F9 /mnt/ceph/F10
>> done
>>
>>
>>
>>
>> Jeff
>>
>>
>>
>>
>>
>>
>> On Tue, 2011-05-17 at 15:34 +0800, AnnyRen wrote:
>>> Hi, Jeff:
>>>
>>> I run "ceph osd tell osd_num bench" with 1 times per osd
>>>
>>> and use ceph -w to observe every osd performance,
>>>
>>> osd0: =A0[INF] bench: wrote 1024 MB in blocks of 4096 KB in 10.8758=
44
>>> sec at 96413 KB/sec
>>> osd1: =A0[INF] bench: wrote 1024 MB in blocks of 4096 KB in 11.7849=
85
>>> sec at 88975 KB/sec
>>> osd2: =A0[INF] bench: wrote 1024 MB in blocks of 4096 KB in 11.1610=
67
>>> sec at 93949 KB/sec
>>> osd3: =A0[INF] bench: wrote 1024 MB in blocks of 4096 KB in 10.7987=
96
>>> sec at 97101 KB/sec
>>> osd4: =A0[INF] bench: wrote 1024 MB in blocks of 4096 KB in 14.4371=
41
>>> sec at 72630 KB/sec
>>> osd5: =A0[INF] bench: wrote 1024 MB in blocks of 4096 KB in 14.4514=
44
>>> sec at 72558 KB/sec
>>> osd6: =A0[INF] bench: wrote 1024 MB in blocks of 4096 KB in 11.0838=
72
>>> sec at 94603 KB/sec
>>> osd7: =A0[INF] bench: wrote 1024 MB in blocks of 4096 KB in 11.0627=
28
>>> sec at 94784 KB/sec
>>> osd8: =A0[INF] bench: wrote 1024 MB in blocks of 4096 KB in 14.1373=
12
>>> sec at 74170 KB/sec
>>> osd9: =A0[INF] bench: wrote 1024 MB in blocks of 4096 KB in 13.4899=
92
>>> sec at 77729 KB/sec
>>>
>>>
>>> and I run
>>> root@MDS2:/mnt/ceph# rados bench 60 write -p data
>>>
>>> the result is
>>>
>>> Total time run: =A0 =A0 =A0 =A060.553247
>>> Total writes made: =A0 =A0 1689
>>> Write size: =A0 =A0 =A0 =A0 =A0 =A04194304
>>> Bandwidth (MB/sec): =A0 =A0111.571
>>>
>>> Average Latency: =A0 =A0 =A0 0.573209
>>> Max latency: =A0 =A0 =A0 =A0 =A0 2.25691
>>> Min latency: =A0 =A0 =A0 =A0 =A0 0.218494
>>>
>>>
>>>
>>> 2011/5/17 Jeff Wu <cpwu@tnsoft.com.cn>:
>>> > Hi AnnyRen
>>> >
>>> > Could you run the following commands and give us the test results=
?
>>> >
>>> > $ceph osd tell OSD-N bench =A0 =A0// OSD-N : osd number : 0,1,2 .=
=2E..
>>> > $ceph -w
>>> >
>>> > $rados bench 60 write -p data =A0 =A0// refer to "rados -h "
>>> >
>>> > Jeff
>>> >
>>> >
>>> >
>>> > On Tue, 2011-05-17 at 11:53 +0800, AnnyRen wrote:
>>> >> I'm running iozone on EXT4 with Ceph v0.26.
>>> >> But I got the weird result, most write performance exceed 1GB/s,=
 even
>>> >> up to 3GB/s
>>> >> I think it's not normal to get the performance outpupt.
>>> >>
>>> >> Command line I used is: /usr/bin/iozone -azcR -f
>>> >> /mnt/ceph/test0516.dbf -g 1G -b /exceloutput0516.xls
>>> >> Attachment is the output file...
>>> >>
>>> >> and my environment is composed of 15 physical machines with
>>> >>
>>> >> 3 MON, 2MDS (1 active, 1 standby), 10 OSD (1 osd daemon (3T) /ho=
st)
>>> >> EXT4 format
>>> >> data replication size: 3
>>> >>
>>> >>
>>> >>
>>> >> "Writer report"
>>> >> =A0 =A0 =A0 =A0 "4" =A0"8" =A0"16" =A0"32" =A0"64" =A0"128" =A0"=
256" =A0"512" =A0"1024"
>>> >> "2048" =A0"4096" =A0"8192" =A0"16384"
>>> >> "64" =A0 983980 =A01204796 =A01210227 =A01143223 =A01357066
>>> >> "128" =A0 1007629 =A01269781 =A01406136 =A01391557 =A01436229 =A0=
1521718
>>> >> "256" =A0 1112909 =A01430119 =A01523457 =A01652404 =A01514860 =A0=
1639786 =A01729594
>>> >> "512" =A0 1150351 =A01475116 =A01605228 =A01723770 =A01797349 =A0=
1712772 =A01783912 =A01854787
>>> >> "1024" =A0 1213334 =A01471481 =A01679160 =A01828574 =A01888889 =A0=
1899750 =A01885572
>>> >> =A01865912 =A01875690
>>> >> "2048" =A0 1229274 =A01540849 =A01708146 =A01843410 =A01903457 =A0=
1980705 =A01930406
>>> >> =A01913634 =A01906837 =A01815744
>>> >> "4096" =A0 1213284 =A01528348 =A01674646 =A01762434 =A01872096 =A0=
1882352 =A01881528
>>> >> =A01903416 =A01897949 =A01835102 =A01731177
>>> >> "8192" =A0 204560 =A0155186 =A0572387 =A0238548 =A0186597 =A0429=
036 =A0187327
>>> >> 157205 =A0553771 =A0416512 =A0299810 =A0405842
>>> >> "16384" =A0 699749 =A0559255 =A0687450 =A0541030 =A0828776 =A055=
5296 =A0742561
>>> >> 525483 =A0604910 =A0452423 =A0564557 =A0670539 =A0970616
>>> >> "32768" =A0 532414 =A0829610 =A0812215 =A0879441 =A0863159 =A086=
4794 =A0865938
>>> >> 804951 =A0916352 =A0879582 =A0608132 =A0860732 =A01239475
>>> >> "65536" =A0 994824 =A01096543 =A01095791 =A01317968 =A01280277 =A0=
1390267 =A01259868
>>> >> =A01205214 =A01339111 =A01346927 =A01267888 =A0863234 =A01190221
>>> >> "131072" =A0 1063429 =A01165115 =A01102650 =A01554828 =A01182128=
 =A01185731
>>> >> 1190752 =A01195792 =A01277441 =A01211063 =A01237567 =A01226999 =A0=
1336961
>>> >> "262144" =A0 1280619 =A01368554 =A01497837 =A01633397 =A01598255=
 =A01609212
>>> >> 1607504 =A01665019 =A01590515 =A01548307 =A01591258 =A01505267 =A0=
1625679
>>> >> "524288" =A0 1519583 =A01767928 =A01738523 =A01883151 =A02011216=
 =A01993877
>>> >> 2023543 =A01867440 =A02106124 =A02055064 =A01906668 =A01778645 =A0=
1838988
>>> >> "1048576" =A0 1580851 =A01887530 =A02044131 =A02166133 =A0223637=
9 =A02283578
>>> >> 2257454 =A02296612 =A02271066 =A02101274 =A01905829 =A01605923 =A0=
2158238
>>> >>
>>> >>
>>> >>
>>> >> "Reader report"
>>> >> =A0 =A0 =A0 =A0 "4" =A0"8" =A0"16" =A0"32" =A0"64" =A0"128" =A0"=
256" =A0"512" =A0"1024"
>>> >> "2048" =A0"4096" =A0"8192" =A0"16384"
>>> >> "64" =A0 1933893 =A02801873 =A03057153 =A03363612 =A03958892
>>> >> "128" =A0 2286447 =A03053774 =A02727923 =A03468030 =A04104338 =A0=
4557257
>>> >> "256" =A0 2903529 =A03236056 =A03245838 =A03705040 =A03654598 =A0=
4496299 =A05117791
>>> >> "512" =A0 2906696 =A03437042 =A03628697 =A03431550 =A04871723 =A0=
4296637 =A06246213 =A06395018
>>> >> "1024" =A0 3229770 =A03483896 =A04609294 =A03791442 =A04614246 =A0=
5536137 =A04550690
>>> >> =A05048117 =A04966395
>>> >> "2048" =A0 3554251 =A04310472 =A03885431 =A04096676 =A06401772 =A0=
4842658 =A05080379
>>> >> =A05184636 =A05596757 =A05735012
>>> >> "4096" =A0 3416292 =A04691638 =A04321103 =A05728903 =A05475122 =A0=
5171846 =A04819300
>>> >> =A05258919 =A06408472 =A05044289 =A04079948
>>> >> "8192" =A0 3233004 =A04615263 =A04536055 =A05618186 =A05414558 =A0=
5025700 =A05553712
>>> >> =A04926264 =A05634770 =A05281396 =A04659702 =A03652258
>>> >> "16384" =A0 3141058 =A03704193 =A04567654 =A04395850 =A04568869 =
=A05387732
>>> >> 4436432 =A05808029 =A05578420 =A04675810 =A03913007 =A03911225 =A0=
3961277
>>> >> "32768" =A0 3704273 =A04598957 =A04088278 =A05133719 =A05896692 =
=A05537024
>>> >> 5234412 =A05398271 =A04942992 =A04118662 =A03729099 =A03511757 =A0=
3481511
>>> >> "65536" =A0 4131091 =A04210184 =A05341188 =A04647619 =A06077765 =
=A05852474
>>> >> 5379762 =A05259330 =A05488249 =A05246682 =A04342682 =A03549202 =A0=
3286487
>>> >> "131072" =A0 3582876 =A05251082 =A05332216 =A05269908 =A05303512=
 =A05574440
>>> >> 5635064 =A05796372 =A05406363 =A04958839 =A04435918 =A03673443 =A0=
3647874
>>> >> "262144" =A0 3659283 =A04551414 =A05746231 =A05433824 =A05876196=
 =A06011650
>>> >> 5552000 =A05629260 =A05298830 =A04982226 =A04628902 =A04065823 =A0=
3421924
>>> >> "524288" =A0 3905973 =A05488778 =A05219963 =A06047356 =A05916811=
 =A06180455
>>> >> 5495733 =A05925628 =A05637512 =A05537123 =A03517132 =A03550861 =A0=
3047013
>>> >> "1048576" =A0 3855595 =A05634571 =A05410298 =A06001809 =A0646471=
3 =A06299610
>>> >> 5894249 =A05516031 =A05800161 =A05209203 =A04295840 =A03724983 =A0=
3641623
>>> >
>>> >
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
