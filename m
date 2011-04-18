From: Zenon Panoussis <oracle@provocation.net>
Subject: Re: Suicide
Date: Tue, 19 Apr 2011 00:38:47 +0200
Message-ID: <4DACBD77.9020600@provocation.net>
References: <4DA85AA6.8050707@provocation.net> <3704E18884CB47E081E09984151ACC7B@gmail.com> <4DA8C8FB.5050106@provocation.net> <161F0A2E50F1465996C6A9075A508C85@gmail.com> <4DA8D4EF.8090006@provocation.net> <25103BE141804650A169B6444F0D6D21@gmail.com> <4DAA2B38.1090706@provocation.net> <BANLkTi=rdcyUu_7PwFc0nRbYs-V=tr+V8Q@mail.gmail.com> <CB9E56C259C44656B7B9DD670A548B8A@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from host-88-80-6-138.cust.prq.se ([88.80.6.138]:37379 "EHLO
	mail.nettheatre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752989Ab1DRWiu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2011 18:38:50 -0400
In-Reply-To: <CB9E56C259C44656B7B9DD670A548B8A@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


On 04/18/2011 11:21 PM, Gregory Farnum wrote:

> I looked through your logs a bit and noticed that the OSD on node01 is 
> crashing due to high latencies on disk access (I think the defaults for
> this case are it asserts out if there's no progress after 10 minutes or
> something). 

First of all, thank you for plowing through those huge logs. It's a feat
all and by itself.

Could you please post an example where you found the OSD crashing, so that
I and others know what log entries to look for?

> Based on that, I pretty much have to guess that there's just too much 
> stress on your disk and it's going to cause problems. You can try loosening
> the various configurable timeouts to let it run longer but it seems like
> really you just need beefier disks for the amount of stuff you're doing to
> them. 

My hardware is indeed very primitive, but in order to prevent this from
happening I would have to make sure that the disks always have more capacity
than the network. In a real-world setup, with gigabit or muti-gigabit
networking and multiple applications doing disk I/O simultaneously, this
is unfeasible. Also, I suspect that it would go against the hierarchy of
O/S subsystem layering.

What I mean is this: if an application tries to write data to the file
system and fails, the application should either hang or time out and
bail out; the file system itself should still not crash. The application
is always agnostic about the file system, so therefore the file system
should never acknowledge more data than it can promise to actually
process.

In the case of ceph things get complicated by the fact that ceph appears
as a file system to the applications using it, but depends itself on an
underlying file system for its disk access. As a result, ceph is responsible
for the data it accepts from applications, but has no way to meet this
responsibility if the underlying file system lets it down.

I don't know how this problem can be truly solved, but some trickery with
I/O buffers might go a long way towards mitigating it. Or perhaps some
available capacity calls between the monitor and the client. Every other
networked file system has a similar problem, so looking at how NFS or samba
deal with it could provide ideas or even ready code.

> IIRC you're running a monitor and an OSD on the same 2.5" physical disk, 
> which means they're colliding on stuff like sync() calls.

Indeed, I'm runing the entire system on a dirt cheap 2,5" disk. Still, good
software on bad hardware should run slow or not at all, but not try to run
fast and then crash and corrupt its data.

> This general slowness doesn't explain the mds log corruption, although it 
> might be one of the trigger conditions. I added another assert in the 
> Journaler code which might have caused the problem (though I don't think 
> it could have) but don't have any other new ideas.

I'll test again as soon as 0.27 is out (BTW, is 0.27 blocked by 0.26.1 or
do they run independent of each-other?).

Z

