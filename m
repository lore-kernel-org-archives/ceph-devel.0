From: Sage Weil <sage@newdream.net>
Subject: Re: mount via ceph-fuse is failing
Date: Fri, 9 Mar 2012 08:20:13 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1203090819310.11669@cobra.newdream.net>
References: <loom.20120309T081725-352@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43229 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757137Ab2CIQUP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Mar 2012 11:20:15 -0500
In-Reply-To: <loom.20120309T081725-352@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Madhusudhan <madhusudhana.u.acharya@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 9 Mar 2012, Madhusudhan wrote:
> Hi,
> When i try to mount ceph file systems via fuse, its failing. 
> 
> 
> [root@ceph-node-9 ~]# ceph-fuse -m 10.25.12.123,10.25.12.124,10.25.12.125:/ 
> /mnt/macharya_ceph/
> ceph-fuse[18533]: starting ceph client
> ceph-fuse[18533]: starting fuse
> fuse: unknown option `big_writes'
> 2012-03-08 23:12:52.100276 7ffff7ab3760 fuse_lowlevel_new failed
> ceph-fuse[18533]: fuse finished with error 33
> ceph-fuse[18532]: mount failed: (33) Numerical argument out of domain

What OS are you running, and which version of FUSE is installed?  
'big_writes' is probablay a newish option.  We can probably make it fall 
back to leaving it off if it isn't recognized.

sage


> 
> 
> what can be the issue ? 
> 
> Thanks
> __M
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
