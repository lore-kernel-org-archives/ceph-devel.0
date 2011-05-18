From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: Re: IOZone Performance is very Strange
Date: Wed, 18 May 2011 14:08:55 +0000
Message-ID: <1305727735.6672.24.camel@localhost>
References: <BANLkTiktOCMyP4opCvST_130TotXvSvuyQ@mail.gmail.com>
	 <1305638639.1606.4.camel@localhost>
	 <BANLkTik7u+WAeztCGYG8yT3Vqv_TUCk+ZA@mail.gmail.com>
	 <1305651942.1674.17.camel@localhost>
	 <BANLkTikkohY1owj4WtP5YdLmmXJiFRAROg@mail.gmail.com>
Reply-To: <cpwu@tnsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:32483 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752844Ab1ERGJB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 May 2011 02:09:01 -0400
In-Reply-To: <BANLkTikkohY1owj4WtP5YdLmmXJiFRAROg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: AnnyRen <annyren6@gmail.com>
Cc: "jerry1209@cht.com.tw" <jerry1209@cht.com.tw>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi , 

Normally , read performance should be more than write performance ,about
20% ~ 30% . 

Could you run the following commands and attach all of the results ? 
 $rados bench 30 write -p data   //write performance
 $rados bench 30 seq  -p data    // read performance //



On Wed, 2011-05-18 at 13:54 +0800, AnnyRen wrote:
> Hi Jeff & Henry,
> 
> I took your advice and used the following command to run iozone test
> 
> /usr/bin/iozone -z -c -e -a -n 512M -g 2G -i 0 -i 1 -i 2 -f
> /mnt/ceph/file0517.dbf -Rb /excel0517.xls
> 
> Attachment is the output result.
> 
> Writer Report													
> 	4	8	16	32	64	128	256	512	1024	2048	4096	8192	16384
> 524288	97920	101778	97050	103121	103445	102137	101082	101993	98835	103674	102043	99424	102679
> 1048576	104306	104841	103616	105884	106044	102221	105666	105890	105811	106409	103957	104062	102115
> 2097152	106896	107989	108428	107500	108453	108444	109584	108618	109413	108102	107529	108357	107545
> 
> Reader Report													
> 	4	8	16	32	64	128	256	512	1024	2048	4096	8192	16384
> 524288	3756286	5029629	5049864	5810960	5577953	5554606	5388867	5636832	5709141	5253596	3805560	3640738	3442332
> 1048576	3709316	4733745	5400857	5655874	5788923	5565162	5865768	5546521	5886345	5167771	4485693	3531487	3473877
> 2097152	4305329	5103282	5713626	6399318	6180508	6392487	5804140	4621404	5873338	5837715	4181626	3420274	3506328
> 
> 
> the file size grows from 512 MB to 2 GB, write performance is about 94
> MB/s~ 106 MB/s
> and read performance still exceed 3 GB~6 GB, is it too fast ?
> 
> Or we used the cache or buffer but we don't know? if yes, how could we
> avoid to use the cache to read ?
> Thanks very much. :-)
> 
> Best Regards,
> Anny
> 
> 
> 
> 
> 2011/5/18 Jeff Wu <cpwu@tnsoft.com.cn>:
> >
> > Hi AnnyRen,
> >
> > with the test results ,  run a 1G data at your ceph cluster ,
> > should be about 100M/sec.
> > maybe,iozone test results didn't include iozone flush time.
> >
> > Could you list your hardware platform infos ?
> > network:1G,4G,8G,FC ...?,cpu,memory:size ? ,disk:PATA,SATA,SAS,SSD ??
> > and
> > could you try other iozone commands ,for instance :
> >
> > 1)
> > add "-e" param to include flush(fsync,fflush) in the timing
> > calculations.
> >
> > /usr/bin/iozone -azcR -e -f /mnt/ceph/test0516.dbf  \
> > -g 1G -b /exceloutput0516.xls
> >
> > 2)run a large data which size is your host memory size*2:
> >
> > $./iozone -z -c -e -a -n 512M -g {memory_size}*2M -i 0 -i 1 -i 2  \
> > -f /mnt/ceph/fio -Rb ./iozone.xls
> >
> > or
> > 2)
> > !/bin/sh
> >
> > for i in 32 64 128 256
> > do
> > ./iozone -r ${i}k -t 10 -s 4096M -i 0 -i 1 -i 2   \
> > -F /mnt/ceph/F1 /mnt/ceph/F2 /mnt/ceph/F3 /mnt/ceph/F4 /mnt/ceph/F5 /mnt/ceph/F6 /mnt/ceph/F7 /mnt/ceph/F8 /mnt/ceph/F9 /mnt/ceph/F10
> > done
> >
> >
> >
> >
> > Jeff
> >
> >
> >
> >
> >
> >
> > On Tue, 2011-05-17 at 15:34 +0800, AnnyRen wrote:
> >> Hi, Jeff:
> >>
> >> I run "ceph osd tell osd_num bench" with 1 times per osd
> >>
> >> and use ceph -w to observe every osd performance,
> >>
> >> osd0:  [INF] bench: wrote 1024 MB in blocks of 4096 KB in 10.875844
> >> sec at 96413 KB/sec
> >> osd1:  [INF] bench: wrote 1024 MB in blocks of 4096 KB in 11.784985
> >> sec at 88975 KB/sec
> >> osd2:  [INF] bench: wrote 1024 MB in blocks of 4096 KB in 11.161067
> >> sec at 93949 KB/sec
> >> osd3:  [INF] bench: wrote 1024 MB in blocks of 4096 KB in 10.798796
> >> sec at 97101 KB/sec
> >> osd4:  [INF] bench: wrote 1024 MB in blocks of 4096 KB in 14.437141
> >> sec at 72630 KB/sec
> >> osd5:  [INF] bench: wrote 1024 MB in blocks of 4096 KB in 14.451444
> >> sec at 72558 KB/sec
> >> osd6:  [INF] bench: wrote 1024 MB in blocks of 4096 KB in 11.083872
> >> sec at 94603 KB/sec
> >> osd7:  [INF] bench: wrote 1024 MB in blocks of 4096 KB in 11.062728
> >> sec at 94784 KB/sec
> >> osd8:  [INF] bench: wrote 1024 MB in blocks of 4096 KB in 14.137312
> >> sec at 74170 KB/sec
> >> osd9:  [INF] bench: wrote 1024 MB in blocks of 4096 KB in 13.489992
> >> sec at 77729 KB/sec
> >>
> >>
> >> and I run
> >> root@MDS2:/mnt/ceph# rados bench 60 write -p data
> >>
> >> the result is
> >>
> >> Total time run:        60.553247
> >> Total writes made:     1689
> >> Write size:            4194304
> >> Bandwidth (MB/sec):    111.571
> >>
> >> Average Latency:       0.573209
> >> Max latency:           2.25691
> >> Min latency:           0.218494
> >>
> >>
> >>
> >> 2011/5/17 Jeff Wu <cpwu@tnsoft.com.cn>:
> >> > Hi AnnyRen
> >> >
> >> > Could you run the following commands and give us the test results?
> >> >
> >> > $ceph osd tell OSD-N bench    // OSD-N : osd number : 0,1,2 ....
> >> > $ceph -w
> >> >
> >> > $rados bench 60 write -p data    // refer to "rados -h "
> >> >
> >> > Jeff
> >> >
> >> >
> >> >
> >> > On Tue, 2011-05-17 at 11:53 +0800, AnnyRen wrote:
> >> >> I'm running iozone on EXT4 with Ceph v0.26.
> >> >> But I got the weird result, most write performance exceed 1GB/s, even
> >> >> up to 3GB/s
> >> >> I think it's not normal to get the performance outpupt.
> >> >>
> >> >> Command line I used is: /usr/bin/iozone -azcR -f
> >> >> /mnt/ceph/test0516.dbf -g 1G -b /exceloutput0516.xls
> >> >> Attachment is the output file...
> >> >>
> >> >> and my environment is composed of 15 physical machines with
> >> >>
> >> >> 3 MON, 2MDS (1 active, 1 standby), 10 OSD (1 osd daemon (3T) /host)
> >> >> EXT4 format
> >> >> data replication size: 3
> >> >>
> >> >>
> >> >>
> >> >> "Writer report"
> >> >>         "4"  "8"  "16"  "32"  "64"  "128"  "256"  "512"  "1024"
> >> >> "2048"  "4096"  "8192"  "16384"
> >> >> "64"   983980  1204796  1210227  1143223  1357066
> >> >> "128"   1007629  1269781  1406136  1391557  1436229  1521718
> >> >> "256"   1112909  1430119  1523457  1652404  1514860  1639786  1729594
> >> >> "512"   1150351  1475116  1605228  1723770  1797349  1712772  1783912  1854787
> >> >> "1024"   1213334  1471481  1679160  1828574  1888889  1899750  1885572
> >> >>  1865912  1875690
> >> >> "2048"   1229274  1540849  1708146  1843410  1903457  1980705  1930406
> >> >>  1913634  1906837  1815744
> >> >> "4096"   1213284  1528348  1674646  1762434  1872096  1882352  1881528
> >> >>  1903416  1897949  1835102  1731177
> >> >> "8192"   204560  155186  572387  238548  186597  429036  187327
> >> >> 157205  553771  416512  299810  405842
> >> >> "16384"   699749  559255  687450  541030  828776  555296  742561
> >> >> 525483  604910  452423  564557  670539  970616
> >> >> "32768"   532414  829610  812215  879441  863159  864794  865938
> >> >> 804951  916352  879582  608132  860732  1239475
> >> >> "65536"   994824  1096543  1095791  1317968  1280277  1390267  1259868
> >> >>  1205214  1339111  1346927  1267888  863234  1190221
> >> >> "131072"   1063429  1165115  1102650  1554828  1182128  1185731
> >> >> 1190752  1195792  1277441  1211063  1237567  1226999  1336961
> >> >> "262144"   1280619  1368554  1497837  1633397  1598255  1609212
> >> >> 1607504  1665019  1590515  1548307  1591258  1505267  1625679
> >> >> "524288"   1519583  1767928  1738523  1883151  2011216  1993877
> >> >> 2023543  1867440  2106124  2055064  1906668  1778645  1838988
> >> >> "1048576"   1580851  1887530  2044131  2166133  2236379  2283578
> >> >> 2257454  2296612  2271066  2101274  1905829  1605923  2158238
> >> >>
> >> >>
> >> >>
> >> >> "Reader report"
> >> >>         "4"  "8"  "16"  "32"  "64"  "128"  "256"  "512"  "1024"
> >> >> "2048"  "4096"  "8192"  "16384"
> >> >> "64"   1933893  2801873  3057153  3363612  3958892
> >> >> "128"   2286447  3053774  2727923  3468030  4104338  4557257
> >> >> "256"   2903529  3236056  3245838  3705040  3654598  4496299  5117791
> >> >> "512"   2906696  3437042  3628697  3431550  4871723  4296637  6246213  6395018
> >> >> "1024"   3229770  3483896  4609294  3791442  4614246  5536137  4550690
> >> >>  5048117  4966395
> >> >> "2048"   3554251  4310472  3885431  4096676  6401772  4842658  5080379
> >> >>  5184636  5596757  5735012
> >> >> "4096"   3416292  4691638  4321103  5728903  5475122  5171846  4819300
> >> >>  5258919  6408472  5044289  4079948
> >> >> "8192"   3233004  4615263  4536055  5618186  5414558  5025700  5553712
> >> >>  4926264  5634770  5281396  4659702  3652258
> >> >> "16384"   3141058  3704193  4567654  4395850  4568869  5387732
> >> >> 4436432  5808029  5578420  4675810  3913007  3911225  3961277
> >> >> "32768"   3704273  4598957  4088278  5133719  5896692  5537024
> >> >> 5234412  5398271  4942992  4118662  3729099  3511757  3481511
> >> >> "65536"   4131091  4210184  5341188  4647619  6077765  5852474
> >> >> 5379762  5259330  5488249  5246682  4342682  3549202  3286487
> >> >> "131072"   3582876  5251082  5332216  5269908  5303512  5574440
> >> >> 5635064  5796372  5406363  4958839  4435918  3673443  3647874
> >> >> "262144"   3659283  4551414  5746231  5433824  5876196  6011650
> >> >> 5552000  5629260  5298830  4982226  4628902  4065823  3421924
> >> >> "524288"   3905973  5488778  5219963  6047356  5916811  6180455
> >> >> 5495733  5925628  5637512  5537123  3517132  3550861  3047013
> >> >> "1048576"   3855595  5634571  5410298  6001809  6464713  6299610
> >> >> 5894249  5516031  5800161  5209203  4295840  3724983  3641623
> >> >
> >> >
> >
> >

