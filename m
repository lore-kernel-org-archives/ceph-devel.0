From: Stefan Priebe <s.priebe@profihost.ag>
Subject: massive 4k random read drop with next branch
Date: Sat, 27 Apr 2013 22:13:33 +0200
Message-ID: <517C316D.6030205@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:48117 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753925Ab3D0UNc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 27 Apr 2013 16:13:32 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello list,

today i was testing next branch against bobtail using a testcluster. I 
upgraded this bobtail one to next branch.

I used QEMU 1.4.1 with librdb (for next branch i applied josh writeback 
patch). My Testsystem had 5 Hosts with one OSD each and set replication 
to 2.

All values where done with 8 jobs in parallel using fio in Qemu Guest.

bobtail:
rand 4k:  write: io=164316KB, bw=1783KB/s, iops=445, runt= 92136msec
rand 4k:  read : io=1117MB, bw=12710KB/s, iops=3177, runt= 90028msec
seq 4m:  write: io=8588MB, bw=97233KB/s, iops=23, runt= 90444msec
seq 4m:  read : io=83616MB, bw=951227KB/s, iops=232, runt= 90013msec

next branch:
   write: io=177236KB, bw=1963KB/s, iops=490, runt= 90284msec
   read : io=223628KB, bw=2408KB/s, iops=601, runt= 92875msec
   write: io=25936MB, bw=294443KB/s, iops=71, runt= 90199msec
   read : io=69856MB, bw=794585KB/s, iops=193, runt= 90025msec

Greets,
Stefan

