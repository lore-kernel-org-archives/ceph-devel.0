From: Dyweni - Ceph-Devel <YS3fpFE2ykfB@dyweni.com>
Subject: Minimum Recommended Hardware
Date: Thu, 19 May 2011 00:27:51 -0500
Message-ID: <b792daeb0cd450e18e6c275abb595dcd@pl1.haspere.com>
Reply-To: <YS3fpFE2ykfB@dyweni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from pl1.haspere.com ([208.111.35.220]:39748 "EHLO pl1.haspere.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754088Ab1ESF1w (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 19 May 2011 01:27:52 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Devel <ceph-devel@vger.kernel.org>

 Hi!

 I've been doing some casual testing of Ceph (GIT Master) and am seeing 
 some really slow speeds:
  - rados bench:  5-6MB/s
  - QEMU-KVM:  1-2MB/s

 As part of my performance troubleshooting plan, I'd like to find out 
 what the list considers the "minimum recommended" hardware configuration 
 to be in order to run Ceph and achieve a reasonably good transfer rate 
 (I'm thinking 50MB/s+?).

 My current setup is this:

 All machines PXE boot and run their OS from a customized initramfs 
 image.  Hard drives are used solely for data storage.  All machines run 
 the 2.6.39-rc7-git13 Linux Kernel.  OSD Journal lives in the OSD Data 
 partition and is 1000 MB.  I use the default (2) number of replicas for 
 all pools.  No iptables or Ceph authentication being used.  All machines 
 are connected by an 8 port Linksys Gigabit switch.

 I use a set of custom shell scripts to build and start the Ceph cluster 
 from bare metal (once the machines are booted from PXE).

 I've tried both EXT4 and BTRFS file systems on the OSDs, but both give 
 the same speeds.

 1 x MON
   Dual P3 930Mhz, 256K Cache
   512MB RAM
   No HD
   100Mb NIC

 1 x MDS
   Dual Athlon 64 X2 3800+, 512K Cache
   4GB RAM
   No HD
   100Mb NIC

 4 x OSD
   OSD1 =
     P3 1Ghz, 256K Cache
     2GB RAM
     80GB IDE (dd_rescue can read about 45MB/s sustained)
     1Gb NIC (e1000 driver)
   OSD2 =
     P3 550Mhz, 512K Cache
     768MB RAM
     40GB IDE (dd_rescue can read about 30MB/s sustained)
     1Gb NIC (e1000 driver)
   OSD3 =
     Celeron 1Ghz, 128K Cache
     512MB RAM
     18GB IDE (dd_rescue can read about 15MB/s sustained)
     1Gb NIC (e1000 driver)
   OSD4 =
     P3 1Ghz, 256K Cache
     512MB RAM
     20GB IDE (dd_rescue can read about 40MB/s sustained)
     1Gb NIC (e1000 driver)


 Thanks,
 Dyweni

