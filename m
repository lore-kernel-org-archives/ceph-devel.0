From: Sage Weil <sage@inktank.com>
Subject: Re: How to turn on async write of rbd ?
Date: Sun, 10 Jun 2012 21:07:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206102104070.12679@cobra.newdream.net>
References: <8512670932FB654F81AF0FEF1BE6D49D017E5125@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58956 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699Ab2FKEHt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jun 2012 00:07:49 -0400
In-Reply-To: <8512670932FB654F81AF0FEF1BE6D49D017E5125@WHQBEMAIL1.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wiwynn.com
Cc: ceph-devel@vger.kernel.org, Chris_YT_Huang@wiwynn.com, Victor_CY_Chang@wiwynn.com

On Mon, 11 Jun 2012, Eric_YH_Chen@wiwynn.com wrote:
> Dear All:
> 
>    I saw rbd support "async writes" since 0.36, http://ceph.com/2011/09/
>    But I cannot find related document that how to turn on it.
>    Should I just write "enabled" to /sys/devices/rbd/0/power/async?

This was referring to the ill-conceived 'rbd writeback window' 
functionality in librbd (userspace client only, never implemented in the 
kernel).  It was removed because it was a broken and could lead to data 
loss.

The current librbd has a proper cache with performs better and is actually 
safe to use.  It's enabled with 'rbd cache = true', or (with upstream but 
unreleased qemu) via the qemu cache=writeback or cache=writethrough 
options. 

For kernel rbd, I would layer something on top of it if you want caching.  
Maybe bcache?

>    One more thing, If I want to implement iSCSI multipath with RBD, just
> like http://ceph.com/wiki/ISCSI
>    Can I turn on the async writes under this situation?

No.  The caching will probably also be problematic with any uses where 
more than one client is accessing the device.  Even file systems like gfs2 
or ocfs2 (I presume) assume read-after-write, even without issuing a flush 
to the device.  That won't work with the rbd client cache.

sage
