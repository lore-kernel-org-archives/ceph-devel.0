From: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Subject: Re: Poor read performance in KVM
Date: Sat, 21 Jul 2012 01:47:48 +0930
Message-ID: <500984AC.9030104@bashkirtsev.com>
References: <5002C215.108@bashkirtsev.com> <5003B1CC.4060909@inktank.com> <50064DCD.8040904@bashkirtsev.com> <5006D5FB.8030700@inktank.com> <50080D9D.8010306@bashkirtsev.com> <50085518.80507@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.logics.net.au ([150.101.56.178]:41042 "EHLO
	mail.logics.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367Ab2GTQSC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jul 2012 12:18:02 -0400
In-Reply-To: <50085518.80507@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


> Yes, they can hold up reads to the same object. Depending on where 
> they're stuck, they may be blocking other requests as well if they're
> e.g. taking up all the filestore threads. Waiting for subops means
> they're waiting for replicas to acknowledge the write and commit it to
> disk. The real cause for slowness of those ops is the replicas. If you
> enable 'debug osd = 25', 'filestore = 25', and 'debug journal = 20' you
> can trace through the logs to see exactly what's happening with the
> subops for those requests.
Despite my promise to crank up logging and investigate what's going on I 
was unable to. Ceph ceased to work before I was able to do something 
reasonable (I've got about one hour of logging which I will look through 
shortly). But then I started to get slow request warnings delayed by 
thousands of seconds. VMs came to a standstill. I have restarted all 
ceph subsystems few times - no banana. ceph health reported that 
everything was OK when clearly it was not running. So I ended up 
rebooting hosts and that's where fun begin: btrfs has failed to umount , 
on boot up it spit out "btrfs: free space inode generation (0) did not 
match free space cache generation (177431)". I have not started ceph and 
made an attempt to umount and umount just froze. Another reboot: same 
stuff. I have rebooted second host and it came back with the same error. 
So in effect I was unable to mount btrfs and read it: no wonder that 
ceph was unable to run. Actually according to mons ceph was OK - all osd 
daemons were in place and running but underlying filesystem gave up 
ghost. Which leads to a suggestion: if osd daemon was unable to obtain 
any data from underlying fs for some period of time (failure to mount, 
disk failure etc) then it perhaps should terminate so rest of ceph would 
not be held up and it will be immediately apparent on ceph health.

But ceph being ceph served its purpose as it should: I have lost two 
osds out of four but because I set replication to 3 I was able to afford 
loss of two osds. After destroying faulty btrfses all VMs started as per 
usual and so far do not have any issues. Ceph rebuilds two osds in the 
mean time.

Looking back at the beginning of the thread I now can conclude what did 
happen:
1. One of our customers ran random write intensive task (MySQL updates + 
a lot of temporary files created/removed)
2. Over period of two days performance of underlying btrfs started to 
deteriorate and I started to see noticeable latency (at this point I 
have emailed the list)
3. While trying to ascertain origin of latency intensive random writes 
continued and so latency continued to increase to the point where ceph 
started to complain about slow requests.
4. And finally state of btrfs when beyond the point where it could run 
and so osds just locked up completely.

Now I have blown away btrfses, made new ones with leafsize of 64K 
(Calvin - this one for you - let's see where it will land me) and 
rebuilding them. I will blow away other two osds to have totally fresh 
btrfses all around (this one goes to Tommi - it looks like I just 
followed his observations).

And of course hats of to Josh and ceph team as now I have clear idea 
what to do when I need to debug latency (and other internal stuff).

But it leaves me with very final question: should we rely on btrfs at 
this point given it is having such major faults? What if I will use well 
tested by time ext4?

Regards,
Vladimir
