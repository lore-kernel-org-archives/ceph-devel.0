From: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Subject: Re: Poor read performance in KVM
Date: Fri, 20 Jul 2012 15:01:43 +0930
Message-ID: <5008ED3F.4080203@bashkirtsev.com>
References: <5002C215.108@bashkirtsev.com> <5003B1CC.4060909@inktank.com> <50064DCD.8040904@bashkirtsev.com> <5006D5FB.8030700@inktank.com> <50080D9D.8010306@bashkirtsev.com> <50085518.80507@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.logics.net.au ([150.101.56.178]:54518 "EHLO
	mail.logics.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412Ab2GTFc7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jul 2012 01:32:59 -0400
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
Looks like I hit exactly the same issue as described in "Slow request 
warnings on 0.48" but from different angle. As our client has run mysql 
updates performance started to degrade across the cluster bringing the 
rest of VMs to standstill and producing incredible latency. At some 
point slow request warnings started to pop up and now it seems I cannot 
get rid of them at all: I have shut down all clients, all ceph 
subsystems, restarted everything and it is back to the same behaviour - 
slow request warnings.

Before rebuilding osds I will enable debug as you suggested in attempt 
to find underlying issue. Then will rebuild osds as a measure of last 
resort to make sure that indeed osds causing the issue.
