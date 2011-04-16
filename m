From: Zenon Panoussis <oracle@provocation.net>
Subject: Re: Suicide
Date: Sat, 16 Apr 2011 11:53:27 +0200
Message-ID: <4DA96717.8090008@provocation.net>
References: <4DA85AA6.8050707@provocation.net> <3704E18884CB47E081E09984151ACC7B@gmail.com> <4DA8C8FB.5050106@provocation.net> <161F0A2E50F1465996C6A9075A508C85@gmail.com> <4DA8D4EF.8090006@provocation.net> <25103BE141804650A169B6444F0D6D21@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from host-88-80-6-138.cust.prq.se ([88.80.6.138]:53894 "EHLO
	mail.nettheatre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755365Ab1DPJxb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Apr 2011 05:53:31 -0400
In-Reply-To: <25103BE141804650A169B6444F0D6D21@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


On 04/16/2011 02:00 AM, Gregory Farnum wrote:

> You'll need to add debug output to your MDS config. At a minimum we will 
> need "debug journaler = 20". You should also add "debug ms = 1" and probably 
> "debug mds = 10". 

http://ceph.newdream.net/wiki/Debugging puts "debug journal" in the osd
section and "debug journaler" in the userspace clients section, but I don't
have any userspace clients; only the kernel modules. Just to make 100% sure
that I get it right, which debug levels should I put in which section(s)?

> Be warned that this will use a LOT of disk space, though. If you ran out before 
> you're going to do so again and we will really need the logs that generated the 
> journal and the logs that were replaying the journal to figure out what happened, 
> so you'll need to come up with some way of handling them (writing to a big NFS 
> disk -- though that'll impact networking, different disk, log rotation, etc). 
> Then try and reproduce your previous conditions as exactly as possible...

The two most probable causes of death were (a) irresponsivness because of
the load and (b) the filling up of the log partition.

Now, if it was the filling up of the logs and I now put them where they won't
fill up, then the error won't be reproduced. Then again, if I put them where
they will fill up, we won't have any node02 logs after they fill up, which is
precisely those we need.

On the other hand, if it was irresponsiveness that caused it, more logging
will lead to more I/O, more trashing of that poor 2,5" drive and yet higher
load, so we might run into the error before the logs fill up.

Z

