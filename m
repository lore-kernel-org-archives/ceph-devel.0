From: Sage Weil <sage@inktank.com>
Subject: Re: Urgent Notice to Users on 0.61.1
Date: Fri, 10 May 2013 20:59:12 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1305102057140.16858@cobra.newdream.net>
References: <518DBA97.7030506@scholarstack.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46136 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247Ab3EKD7M (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 May 2013 23:59:12 -0400
In-Reply-To: <518DBA97.7030506@scholarstack.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Dawson <mike.dawson@scholarstack.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

On Fri, 10 May 2013, Mike Dawson wrote:
> Anyone running 0.61.1,
> 
> Watch out for high disk usage due to a file likely located at
> /var/log/ceph/ceph-mon.<mon-name>.tdump. This file contains debugging for
> monitor transactions. This debugging was added in the past week or so to track
> down another anomaly. It is not necessary (or useful unless you are debugging
> monitor transactions).
> 
> Depending on the load of your cluster, the tdump file may become large
> quickly. I've seen it grow over 50GB/day.
> 
> IMHO, the default setting should be "false", but it was merged in prior to
> 0.61.1 with a default of "true". If you are on 0.61.1, you can confirm the
> settings with:
> 
> ceph --admin-daemon /var/run/ceph/ceph-mon.<mon-name>.asok config show | grep
> mon_debug_dump
> 
> To disable it, add "mon debug dump transactions = false" to ceph.conf, and
> restart your monitors. Alternatively, you can inject the argument or add the
> cmdline flag.

You can avoid the restart with

 ceph mon tell \* injectargs '--mon-debug-dump-transactions=false'

Thanks, Mike, for pointing this out!  We'll put together another point 
release shortly.  In the meantime, anyone running .1 should run the above 
to avoid filling your disk.

sage

> 
> dmick has an issue started at:
> http://tracker.ceph.com/issues/5024
> 
> Thanks,
> Mike
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
