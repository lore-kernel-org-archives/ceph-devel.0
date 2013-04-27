From: Wido den Hollander <wido@42on.com>
Subject: Re: massive 4k random read drop with next branch
Date: Sat, 27 Apr 2013 23:14:44 +0200
Message-ID: <517C3FC4.5030507@42on.com>
References: <517C316D.6030205@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:39403 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753369Ab3D0VOr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 27 Apr 2013 17:14:47 -0400
In-Reply-To: <517C316D.6030205@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 04/27/2013 10:13 PM, Stefan Priebe wrote:
> Hello list,
>
> today i was testing next branch against bobtail using a testcluster. I
> upgraded this bobtail one to next branch.
>
> I used QEMU 1.4.1 with librdb (for next branch i applied josh writeback
> patch). My Testsystem had 5 Hosts with one OSD each and set replication
> to 2.
>
> All values where done with 8 jobs in parallel using fio in Qemu Guest.
>

I'm not seeing the same. Although my tests were with Bonnie++ I actually 
noticed a very big increase.

The biggest increase was write performance which went up a lot going 
from Bobtail to next, but with next VMs (Qemu 1.2.2) are a lot more 
snappier.

The benchmarks don't give me a huge difference in read performance, but 
my VMs feel a lot faster however.

Wido

> bobtail:
> rand 4k:  write: io=164316KB, bw=1783KB/s, iops=445, runt= 92136msec
> rand 4k:  read : io=1117MB, bw=12710KB/s, iops=3177, runt= 90028msec
> seq 4m:  write: io=8588MB, bw=97233KB/s, iops=23, runt= 90444msec
> seq 4m:  read : io=83616MB, bw=951227KB/s, iops=232, runt= 90013msec
>
> next branch:
>    write: io=177236KB, bw=1963KB/s, iops=490, runt= 90284msec
>    read : io=223628KB, bw=2408KB/s, iops=601, runt= 92875msec
>    write: io=25936MB, bw=294443KB/s, iops=71, runt= 90199msec
>    read : io=69856MB, bw=794585KB/s, iops=193, runt= 90025msec
>
> Greets,
> Stefan
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
