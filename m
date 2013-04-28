From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: massive 4k random read drop with next branch
Date: Sun, 28 Apr 2013 14:21:32 +0200
Message-ID: <FAEC0EE3-ECC3-4F94-8731-E14A6576F01E@profihost.ag>
References: <517C316D.6030205@profihost.ag> <517C38D9.6060808@inktank.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:48334 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755625Ab3D1MVi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 28 Apr 2013 08:21:38 -0400
In-Reply-To: <517C38D9.6060808@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 27.04.2013 um 22:45 schrieb Mark Nelson <mark.nelson@inktank.com>:

> On 04/27/2013 03:13 PM, Stefan Priebe wrote:
>> Hello list,
>> 
>> today i was testing next branch against bobtail using a testcluster. I
>> upgraded this bobtail one to next branch.
>> 
>> I used QEMU 1.4.1 with librdb (for next branch i applied josh writeback
>> patch). My Testsystem had 5 Hosts with one OSD each and set replication
>> to 2.
>> 
>> All values where done with 8 jobs in parallel using fio in Qemu Guest.
>> 
>> bobtail:
>> rand 4k:  write: io=164316KB, bw=1783KB/s, iops=445, runt= 92136msec
>> rand 4k:  read : io=1117MB, bw=12710KB/s, iops=3177, runt= 90028msec
>> seq 4m:  write: io=8588MB, bw=97233KB/s, iops=23, runt= 90444msec
>> seq 4m:  read : io=83616MB, bw=951227KB/s, iops=232, runt= 90013msec
>> 
>> next branch:
>>   write: io=177236KB, bw=1963KB/s, iops=490, runt= 90284msec
>>   read : io=223628KB, bw=2408KB/s, iops=601, runt= 92875msec
>>   write: io=25936MB, bw=294443KB/s, iops=71, runt= 90199msec
>>   read : io=69856MB, bw=794585KB/s, iops=193, runt= 90025msec
> 
> Was everything else the same between the tests?  That does seem unusual.  If it's easy for you to switch between bobtail and next, could you try some 4k rados bench read tests to see if it's also happening there?

I think I got it. Under bobtail the whole stuff was in cache on the osd clients. While under next I tested while they were freshly rebooted ;-( sorry guys.

Will retest.

Stefan
> 
>> 
>> Greets,
>> Stefan
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
