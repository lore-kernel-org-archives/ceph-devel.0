From: Alex Elder <elder@dreamhost.com>
Subject: Interesting Error
Date: Wed, 11 Apr 2012 11:07:30 -0500
Message-ID: <4F85AC42.5050601@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:39745 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759793Ab2DKQH0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Apr 2012 12:07:26 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 2E02324478
	for <ceph-devel@vger.kernel.org>; Wed, 11 Apr 2012 09:10:01 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net [71.195.31.37])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id D330D24476
	for <ceph-devel@vger.kernel.org>; Wed, 11 Apr 2012 09:10:00 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'm running suites/iozone.sh on a 3-node ceph cluster with
each running kernel ceph-client/wip-layout-helpers.

I've hit a consistent error twice now, but it seems to be
hitting it when running with particular arguments.

Here are the three commands in that workunit:
     iozone -c -e -s 1024M -r 16K -t 1 -F f1 -i 0 -i 1
     iozone -c -e -s 1024M -r 1M -t 1 -F f2 -i 0 -i 1
     iozone -c -e -s 10240M -r 1M -t 1 -F f3 -i 0 -i 1

The first two run to completion without a problem.  The third
one runs for a while and then reports something like what's
below, and then hangs the test (system is still operational).
I see this in the syslog, but I'm not sure its timing aligned
with the failure:
     [ 3925.501128] libceph: osd1 10.214.133.32:6800 socket closed

Since it shows up only with the 10MB file size and 1MB record
size I am wondering if this combination hits some sort of
boundary that would help me understand what's wrong.  Anyone
have any ideas?

Here is how my three nodes are configured in the teuthology file:
     - [mon.a, mon.c, osd.0]
     - [mon.b, mds.a, osd.1]
     - [client.0]

Thanks.

					-Alex


         Run began: Wed Apr 11 08:36:52 2012

         Include close in write timing
         Include fsync in write timing
         File size set to 10485760 KB
         Record Size 1024 KB
         Command line used: iozone -c -e -s 10240M -r 1M -t 1 -F f3 -i 0 
-i 1
         Output is in Kbytes/sec
         Time Resolution = 0.000001 seconds.
         Processor cache size set to 1024 Kbytes.
         Processor cache line size set to 32 bytes.
         File stride size set to 17 * record size.
         Throughput test with 1 process
         Each process writes a 10485760 Kbyte file in 1024 Kbyte records

Error writing block 9408, fd= 3

         Children see throughput for  1 initial writers  =       0.00 KB/sec
         Parent sees throughput for  1 initial writers   =       0.00 KB/sec
         Min throughput per process      =       0.00 KB/sec
         Max throughput per process      =       0.00 KB/sec
         Avg throughput per process      =       0.00 KB/sec
         Min xfer                        =       0.00 KB

Child 0
f3: No such file or directory
