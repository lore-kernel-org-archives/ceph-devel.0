From: Zenon Panoussis <oracle@provocation.net>
Subject: Re: Suicide
Date: Sat, 16 Apr 2011 01:29:51 +0200
Message-ID: <4DA8D4EF.8090006@provocation.net>
References: <4DA85AA6.8050707@provocation.net> <3704E18884CB47E081E09984151ACC7B@gmail.com> <4DA8C8FB.5050106@provocation.net> <161F0A2E50F1465996C6A9075A508C85@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from host-88-80-6-138.cust.prq.se ([88.80.6.138]:36631 "EHLO
	mail.nettheatre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776Ab1DOX3y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Apr 2011 19:29:54 -0400
In-Reply-To: <161F0A2E50F1465996C6A9075A508C85@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


On 04/16/2011 01:06 AM, Gregory Farnum wrote:

> Hmm, that timeline doesn't quite make sense -- node01 takes over the MDS 
> duties at 4:33 and crashes, but then it starts up again at 4:50. But it's 
> possible that node02 took over in the interval there and we just don't see 
> it because the log disk was full (I had erroneously thought that a filled 
> disk would hang the daemon but that turns out not to be the case). So I'd 
> guess you shut everything down sometime after 5:08, and that would make 
> sense.

Indeed, you're probably right.

> Unfortunately what we're really interested in is what caused the assert 
> failure on node01 at 4:35 and the reasons for that aren't available in the 
> logs we have. :(

> This is the second time we've seen that assert but we've not been able to 
> reproduce it or figure out how the invariant that it's checking against got 
> broken. If you like we can come up with a hacky fix that should let your 
> cluster come back up, but it's possible that you'd lose some data and this 
> is a very rare condition so if it's not a big deal I'd just re-create your 
> cluster.

My data has been safe elsewhere all along and I have already re-created the
cluster. In other words I don't need the hacky fix, but someone else might
be desperate for it in the future, so creating it could be a good idea anyway.

However, the cause of the corruption is still an open issue that ought to be
understood and solved. The most likely place to be able to reproduce it at is
right here, so if you think it's useful, I'm willing to try to crash it again.
If you want me to, let's make a plan for it. These are just test boxes and
I have no problem even giving you root on them, if that can help pinpoint
the cause of the corruption.

Z

