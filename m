From: Sage Weil <sage@inktank.com>
Subject: Re: ceph-deploy mon create / gatherkeys problems
Date: Sun, 18 Aug 2013 17:16:30 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308181715050.1479@cobra.newdream.net>
References: <8D06A68A827BE16-FF0-46E32@webmail-d235.sysops.aol.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40171 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633Ab3HSAQb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 18 Aug 2013 20:16:31 -0400
In-Reply-To: <8D06A68A827BE16-FF0-46E32@webmail-d235.sysops.aol.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric Eastman <eric0e@aol.com>
Cc: ceph-users@ceph.com, ceph-devel@vger.kernel.org

On Sun, 18 Aug 2013, Eric Eastman wrote:
> It may be overkill, but my notes on starting over with loading ceph on
> my test clusters is:
> 
> > From ceph00  (my admin node)
>  ceph-deploy -v purge ceph00 ceph01 ceph02 ceph03 ceph04 ...
> 
> Then on each system
>   rm -rf /var/lib/ceph /etc/ceph

This is what

 ceph-deploy purgedata HOST1 ...

does, FWIW.

> Then reinstall the ceph software and configure it with ceph-deploy.
> 
> With ceph-deploy version 1.0-1 this solved problems with re-installing
> ceph with ceph-deploy, as these directories were not fully cleaned
> with the purge option.  Maybe we need a "distclean" option.

Is that what distclean means in other contexts?  We could make it an alias 
for the same command.

> I am installing my first cluster built with ceph-deploy version 1.2.1
> and I really like debug being the default, so I can see what
> its doing. I will report if I find any issues with it.
> 
> * If you previously had a problem here and then realized you
> were doing something not quite right and got it working, please
> reply and share  what it was so we can make sure others avoid the problem!

Thanks!
sage

