From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: mds sync wrlock
Date: Wed, 29 Jun 2011 13:01:38 -0700
Message-ID: <D948AD56-6ADE-4D6C-BC2D-627D73C79663@dreamhost.com>
References: <BANLkTin9SkuYVnatyXoKCjHiJevCizKwVA@mail.gmail.com> <B0DF7127-A5BF-4DAE-A22C-1FD9C284172B@dreamhost.com> <BANLkTim_k-8Wqqx6e6W+R0LdaNvCGPUNng@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:41235 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab1F2UB7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jun 2011 16:01:59 -0400
In-Reply-To: <BANLkTim_k-8Wqqx6e6W+R0LdaNvCGPUNng@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


On Jun 29, 2011, at 3:16 AM, huang jun wrote:

> hi,Gregory
> now, we test the ceph 0.30, and get the same result.
> steps are:
> we mount ceph on /mnt/test/
> then create dir "/mnt/test/a/b/"
> 1) in dir "b" , use "seq 3000|xargs -i mkdir {}" to create 3000 dirs
> 2) and at some time,make a directory "c" in "a"
> from the mds debug log:
> 
> 2011-06-29 05:44:19.368961 7f7a0b421700 mds0.locker wrlock_start
> waiting on (inest lock->sync w=1 dirty flushing) on [inode 10000000000
> [...2,head] /a/ auth v18 pv20 ap=312 f(v0 m2011-06-29 05:44:15.550665
> 2=0+2) n(v0 rc2011-06-29 05:44:15.550665 1934=0+1934) (iauth sync r=1)
> (isnap sync r=1) (inest lock->sync w=1 dirty flushing) (ifile excl
> w=1) (ixattr excl) (iversion lock) caps={4099=pAsLsXsxFsx/-@10},l=4099
> | dirtyscattered lock dirfrag caps dirty authpin 0x14c97e0]
> 
> we find:
> the dir "a" was locked when we create dirs below dir "b"
> in function predirty_journal_parents (in MDCache.cc ), the flag "stop"
> was marked true,so we got the message "predirty_journal_parents stop.
> marking nestlock on".
> step 1) got a lock of dir "a", it type is  CEPH_LOCK_INEST , it name
> is " sync "
> and the value of  this lock is "inest lock->sync w=1 dirty flushing".
> 
> i want to know:
> why  it got the wrlock of dir "a" when creates dirs below dir "b" ?

Ah. Each directory has a lot of different locks protecting different pieces of state. Here, the only write lock that is being held for the creates in dir b is the nestlock, which protects the rstats (recursive stats). Generally that lock shouldn't block creates though. How long does your test take to run?
Since the lock says it's flushing I wonder if there's something else going on that's hurting your OSD performance and stalling it out.

I'll see if I can reproduce it locally.