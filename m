From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: slow performance even when using SSDs
Date: Thu, 10 May 2012 15:09:55 +0200
Message-ID: <4FABBE23.4030608@profihost.ag>
References: <4FABAFE9.5060202@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:38226 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755368Ab2EJNJ6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 May 2012 09:09:58 -0400
In-Reply-To: <4FABAFE9.5060202@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

OK, here some retests. I had the SDDs conected to an old Raid controller
even i did used them as JBODs (oops).

Here are two new Tests (using kernel 3.4-rc6) it would be great if
someone could tell me if they're fine or bad.

New tests with all 3 SSDs connected to the mainboard.

#~ rados -p rbd bench 60 write
Total time run:        60.342419
Total writes made:     2021
Write size:            4194304
Bandwidth (MB/sec):    133.969

Average Latency:       0.477476
Max latency:           0.942029
Min latency:           0.109467

#~ rados -p rbd bench 60 write -b 4096
Total time run:        60.726326
Total writes made:     59026
Write size:            4096
Bandwidth (MB/sec):    3.797

Average Latency:       0.016459
Max latency:           0.874841
Min latency:           0.002392

Another test with only osd on the disk and the journal in memory / tmpfs:
#~ rados -p rbd bench 60 write
Total time run:        60.513240
Total writes made:     2555
Write size:            4194304
Bandwidth (MB/sec):    168.889

Average Latency:       0.378775
Max latency:           4.59233
Min latency:           0.055179

#~ rados -p rbd bench 60 write -b 4096
Total time run:        60.116260
Total writes made:     281903
Write size:            4096
Bandwidth (MB/sec):    18.318

Average Latency:       0.00341067
Max latency:           0.720486
Min latency:           0.000602

Another problem i have is i'm always getting:
"2012-05-10 15:05:22.140027 mon.0 192.168.0.100:6789/0 19 : [WRN]
message from mon.2 was stamped 0.109244s in the future, clocks not
synchronized"

even on all systems ntp is running fine.

Stefan

Am 10.05.2012 14:09, schrieb Stefan Priebe - Profihost AG:
> Dear List,
> 
> i'm doing a testsetup with ceph v0.46 and wanted to know how fast ceph is.
> 
> my testsetup:
> 3 servers with Intel Xeon X3440, 180GB SSD Intel 520 Series, 4GB RAM, 2x
> 1Gbit/s LAN each
> 
> All 3 are running as mon a-c and osd 0-2. Two of them are also running
> as mds.2 and mds.3 (has 8GB RAM instead of 4GB).
> 
> All machines run ceph v0.46 and vanilla Linux Kernel v3.0.30 and all of
> them use btrfs on the ssd which serves /srv/{osd,mon}.X. All of them use
> eth0+eth1 as bond0 (mode 6).
> 
> This gives me:
> rados -p rbd bench 60 write
> 
> ...
> Total time run:        61.465323
> Total writes made:     776
> Write size:            4194304
> Bandwidth (MB/sec):    50.500
> 
> Average Latency:       1.2654
> Max latency:           2.77124
> Min latency:           0.170936
> 
> Shouldn't it be at least 100MB/s? (1Gbit/s / 8)
> 
> And rados -p rbd bench 60 write -b 4096 gives pretty bad results:
> Total time run:        60.221130
> Total writes made:     6401
> Write size:            4096
> Bandwidth (MB/sec):    0.415
> 
> Average Latency:       0.150525
> Max latency:           1.12647
> Min latency:           0.026599
> 
> All btrfs ssds are also mounted with noatime.
> 
> Thanks for your help!
> 
> Greets Stefan
