From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: Re: Minimum Recommended Hardware
Date: Thu, 19 May 2011 14:14:35 +0000
Message-ID: <1305814475.15013.15.camel@localhost>
References: <b792daeb0cd450e18e6c275abb595dcd@pl1.haspere.com>
Reply-To: <cpwu@tnsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:20645 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932363Ab1ESGOf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 May 2011 02:14:35 -0400
In-Reply-To: <b792daeb0cd450e18e6c275abb595dcd@pl1.haspere.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "YS3fpFE2ykfB@dyweni.com" <YS3fpFE2ykfB@dyweni.com>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

Hi ,

My osd hosts configuration :

cpu : 4 processor, Intel(R) Core(TM)2 Quad CPU  Q8400  @ 2.66GHz
mem : 4GB
NIC : 1GB

disk:  
SATA disk WDC WD3200AAJS-0  320GB ---> save osd data
SATA SSD  OCZ-VERTEX2  60GB  ----->  save osd journal 

filesystem : btrfs 

rados writing performance  is about 50~60M/sec
I also tried to use ramdisk to save osd journal ,
rados writing performance reach to 75~85M/sec

Regards,

Jeff.

test logs:

1. " rados bench 60 write -p data" 

Total time run:        61.034223
Total writes made:     901
Write size:            4194304
Bandwidth (MB/sec):    59.049 

Average Latency:       1.0838
Max latency:           7.27347
Min latency:           0.177559


Total time run:        61.275064
Total writes made:     880
Write size:            4194304
Bandwidth (MB/sec):    57.446 

Average Latency:       1.11073
Max latency:           10.9278
Min latency:           0.170368


Total time run:        60.733064
Total writes made:     915
Write size:            4194304
Bandwidth (MB/sec):    60.264 

Average Latency:       1.0616
Max latency:           6.86648
Min latency:           0.186103


2." ceph osd tell osd-N bench" 

2011-05-18 10:11:18.979422   log 2011-05-18 19:06:23.149264 osd0
172.16.35.75:6800/3408 143 : [INF] bench: wrote 1024 MB in blocks of
4096 KB in 21.099019 sec at 49697 KB/sec
2011-05-18 10:12:18.468762   log 2011-05-18 19:07:23.482783 osd1
172.16.35.75:6803/3791 150 : [INF] bench: wrote 1024 MB in blocks of
4096 KB in 15.492175 sec at 67684 KB/sec
2011-05-18 10:11:21.629888   log 2011-05-18 19:06:59.173391 osd2
172.16.35.76:6800/3345 165 : [INF] bench: wrote 1024 MB in blocks of
4096 KB in 19.412487 sec at 54015 KB/sec
2011-05-18 10:11:23.696908   log 2011-05-18 19:09:52.778198 osd4
172.16.35.77:6800/1727 141 : [INF] bench: wrote 1024 MB in blocks of
4096 KB in 15.393317 sec at 68118 KB/sec
2011-05-18 10:11:24.797029   log 2011-05-18 19:07:02.344256 osd3
172.16.35.76:6803/3732 158 : [INF] bench: wrote 1024 MB in blocks of
4096 KB in 19.813493 sec at 52922 KB/sec
2011-05-18 10:11:32.572687   log 2011-05-18 19:10:02.520102 osd5
172.16.35.77:6803/1819 126 : [INF] bench: wrote 1024 MB in blocks of
4096 KB in 23.028046 sec at 45534 KB/sec






On Thu, 2011-05-19 at 13:27 +0800, Dyweni - Ceph-Devel wrote:
> Hi!
> 
>  I've been doing some casual testing of Ceph (GIT Master) and am seeing 
>  some really slow speeds:
>   - rados bench:  5-6MB/s
>   - QEMU-KVM:  1-2MB/s
> 
>  As part of my performance troubleshooting plan, I'd like to find out 
>  what the list considers the "minimum recommended" hardware configuration 
>  to be in order to run Ceph and achieve a reasonably good transfer rate 
>  (I'm thinking 50MB/s+?).
> 
>  My current setup is this:
> 
>  All machines PXE boot and run their OS from a customized initramfs 
>  image.  Hard drives are used solely for data storage.  All machines run 
>  the 2.6.39-rc7-git13 Linux Kernel.  OSD Journal lives in the OSD Data 
>  partition and is 1000 MB.  I use the default (2) number of replicas for 
>  all pools.  No iptables or Ceph authentication being used.  All machines 
>  are connected by an 8 port Linksys Gigabit switch.
> 
>  I use a set of custom shell scripts to build and start the Ceph cluster 
>  from bare metal (once the machines are booted from PXE).
> 
>  I've tried both EXT4 and BTRFS file systems on the OSDs, but both give 
>  the same speeds.
> 
>  1 x MON
>    Dual P3 930Mhz, 256K Cache
>    512MB RAM
>    No HD
>    100Mb NIC
> 
>  1 x MDS
>    Dual Athlon 64 X2 3800+, 512K Cache
>    4GB RAM
>    No HD
>    100Mb NIC
> 
>  4 x OSD
>    OSD1 =
>      P3 1Ghz, 256K Cache
>      2GB RAM
>      80GB IDE (dd_rescue can read about 45MB/s sustained)
>      1Gb NIC (e1000 driver)
>    OSD2 =
>      P3 550Mhz, 512K Cache
>      768MB RAM
>      40GB IDE (dd_rescue can read about 30MB/s sustained)
>      1Gb NIC (e1000 driver)
>    OSD3 =
>      Celeron 1Ghz, 128K Cache
>      512MB RAM
>      18GB IDE (dd_rescue can read about 15MB/s sustained)
>      1Gb NIC (e1000 driver)
>    OSD4 =
>      P3 1Ghz, 256K Cache
>      512MB RAM
>      20GB IDE (dd_rescue can read about 40MB/s sustained)
>      1Gb NIC (e1000 driver)
> 
> 
>  Thanks,
>  Dyweni
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

