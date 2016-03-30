From: Sage Weil <sage@newdream.net>
Subject: Re: reads while 100% write
Date: Wed, 30 Mar 2016 07:19:12 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1603300714580.22014@cpach.fuggernut.com>
References: <D320896C.C4F8%evgeniy.firsov@sandisk.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-131975210-1459336754=:22014"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47769 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbcC3LTW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Mar 2016 07:19:22 -0400
In-Reply-To: <D320896C.C4F8%evgeniy.firsov@sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Evgeniy Firsov <Evgeniy.Firsov@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-131975210-1459336754=:22014
Content-Type: TEXT/PLAIN; charset=Windows-1252
Content-Transfer-Encoding: 8BIT

On Wed, 30 Mar 2016, Evgeniy Firsov wrote:
> After pulling master branch on Friday I start seeing odd fio behavior, I
> see a lot of reads while writing and very low performance no matter
> whether it read or write workload.
> 
> Output from sequential 1M write:
> Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-sz
> avgqu-sz   await r_await w_await  svctm  %util
> 
> sdd               0.00   409.00    0.00  364.00     0.00  3092.00    16.99
>     0.28    0.78    0.00    0.78   0.76  27.60
> sde               0.00   242.00  365.00  363.00  2436.00  9680.00    33.29
>     0.18    0.24    0.42    0.07   0.23  16.80
> 
> 
> 
> block.db -> /dev/sdd
> block -> /dev/sde
> 
> health HEALTH_OK
> monmap e1: 1 mons at {a=127.0.0.1:6789/0}
>        election epoch 3, quorum 0 a
> osdmap e7: 1 osds: 1 up, 1 in
>        flags sortbitwise
> pgmap v24: 64 pgs, 1 pools, 577 MB data, 9152 objects
>        8210 MB used, 178 GB / 186 GB avail
>              64 active+clean
> client io 1550 kB/s rd, 9559 kB/s wr, 645 op/s rd, 387 op/s wr
> 
> 
> While on earlier revision(c1e41af) everything looks as expected:
> 
> Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-sz
> avgqu-sz   await r_await w_await  svctm  %util
> sdd               0.00  4910.00    0.00  680.00     0.00 22416.00    65.93
>     1.05    1.55    0.00    1.55   1.18  80.00
> sde               0.00     0.00    0.00 3418.00     0.00 217612.00
> 127.33    63.78   18.18    0.00   18.18   0.25  86.40
> 
> Other observation, may be related to the issue, is that CPU load is
> imbalanced. Single ³tp_osd_tp² thread is 100% busy, while the rest is idle.
> Looks like all load goes to single thread pool shard, earlier CPU was well
> balanced.

Hmm.  Can you capture a log with debug bluestore = 20 and debug bdev = 20?

Thanks!
sage


> 
> 
> ‹
> Evgeniy
> 
> 
> 
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--8323329-131975210-1459336754=:22014--
