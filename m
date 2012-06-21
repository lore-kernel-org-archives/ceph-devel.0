From: Sage Weil <sage@inktank.com>
Subject: Re: filestore flusher = false  , correct my problem of constant
 write (need info on this parameter)
Date: Thu, 21 Jun 2012 09:03:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206210858400.17996@cobra.newdream.net>
References: <29b3d930-1b60-4a88-a98b-ae4cd7e10c21@mailpro>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39201 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756165Ab2FUQDs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jun 2012 12:03:48 -0400
In-Reply-To: <29b3d930-1b60-4a88-a98b-ae4cd7e10c21@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org, Mark Nelson <mark.nelson@inktank.com>, Stefan Priebe <s.priebe@profihost.ag>

Hi Alexandre,

[Sorry I didn't follow up earlier; I didn't understand your question.]

If you turn off the journal compeletely, you will see bursty write commits 
from the perspective of the client, because the OSD is periodically doing 
a sync or snapshot and only acking the writes then.

If you enable the journal, the OSD will reply with a commit as soon as the 
write is stable in the journal.  That's one reason why it is there--file 
system commits of heavyweight and slow.

If we left the file system to its own devices and did a sync every 10 
seconds, the disk would sit idle while a bunch of dirty data accumulated 
in cache, and then the sync/snapshot would take a really long time.  This 
is horribly inefficient (the disk is idle half the time), and useless (the 
delayed write behavior makes sense for local workloads, but not servers 
where there is a client on the other end batching its writes).  To prevent 
this, 'filestore flusher' will prod the kernel to flush out any written 
data to the disk quickly.  Then, when we get around to doing the 
sync/snapshot it is pretty quick, because only fs metadata and 
just-written data needs to be flushed.

So: the behavior you're seeing is normal, and good.

Did I understand your confusion correctly?

Thanks!
sage


On Wed, 20 Jun 2012, Alexandre DERUMIER wrote:

> Hi, 
> I have tried to disabe filestore flusher 
> 
> filestore flusher = false 
> filestore max sync interval = 30 
> filestore min sync interval = 29 
> 
> 
> in osd config. 
> 
> 
> now, I see correct sync each 30s when doing rados bench 
> 
> rados -p pool3 bench 60 write -t 16
> 
> 
> seekwatcher movie: 
> 
> 
> before 
> ------ 
> http://odisoweb1.odiso.net/seqwrite-radosbench-flusherenable.mpg 
> 
> after 
> ----- 
> http://odisoweb1.odiso.net/seqwrite-radosbench-flusherdisable.mpg 
> 
> 
> Shouldn't it be the normal behaviour ? What's exactly is filestore flusher vs syncfs ?
> 
> 
> 
> This seem to works fine with rados bench,
> But when I launch benchmark with fio from my guest vm, I see again constant write.
> (I'll try to debug that today)
> 
> 
> My target is to be able to handle small random write and write them each 30s.
> 
> Regards,
> 
> Alexandre
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
