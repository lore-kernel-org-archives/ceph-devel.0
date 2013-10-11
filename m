From: Sage Weil <sage@inktank.com>
Subject: Re: can't stop ceph(v0.69) osd daemon on ubuntu13.04
Date: Fri, 11 Oct 2013 08:46:16 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1310110845530.15179@cobra.newdream.net>
References: <01fb01cec66a$af6d1e00$0e475a00$@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55828 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206Ab3JKPqQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Oct 2013 11:46:16 -0400
In-Reply-To: <01fb01cec66a$af6d1e00$0e475a00$@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: hjwsm1989-gmail <hjwsm1989@gmail.com>
Cc: ceph-devel@vger.kernel.org

If you're using ubuntu, you want to do

 stop ceph-osd-all
or
 stop ceph-all

(ceph on ubuntu uses upstart, not sysvinit)

On Fri, 11 Oct 2013, hjwsm1989-gmail wrote:

> Hi,all
> 
> We can't stop osd daemon on Ubuntu 13.04 by using "/ect/init.d/ceph stop
> osd",
> 
> After debug by bashdb, we found that after setup the osd daemon, the pid
> file on /var/run/ceph/osd.N.pid doesn't exists.
> 
> Then try to stop osd by "kill pid-of-osd", the osd daemon was killed but
> then start again.
> 
> 
> Thanks!
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
