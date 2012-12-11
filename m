From: Sage Weil <sage@inktank.com>
Subject: Re: mounting fuse from fstab
Date: Mon, 10 Dec 2012 16:33:26 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212101622580.17288@cobra.newdream.net>
References: <alpine.DEB.2.00.1212101229540.28411@cobra.newdream.net> <50C65ABE.5010102@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41372 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395Ab2LKAd1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Dec 2012 19:33:27 -0500
In-Reply-To: <50C65ABE.5010102@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sam Lang <sam.lang@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 10 Dec 2012, Sam Lang wrote:
> On 12/10/2012 10:33 AM, Sage Weil wrote:
> > We put together a simple helper script for mounting ceph-fuse via fstab
> > (below).  Some of man pages indicate that the # syntax is deprecated,
> > however, and it's not clear to me that whatever replaces it (mount.fuse)
> > will let us accomplish the same thing (pass something along the mount,
> > control command line options).  Also, it's unclear *when* it was
> > deprecated; if we want this to work on, say, RHEL, the replacement
> > might not be there.
> 
> Would the fuse options fsname and subtype be more portable?

Looking at the subtype stuff a bit more, I finally understand.. if you set 
type to fuse.ceph, it will run /sbin/mount.fuse.ceph with the usual 
arguments (which include the device name).

...and it appears that that support is present in RHEL6, which is probably 
the oldest thing we care about.  I think that's a better route.  Something 
like:

 id=user,foo=bar	/foo	fuse.ceph	defaults	0 0

where the key/value pairs are passed by /sbin/mount.fuse.ceph to ceph-fuse 
on the command line?

sage


> -sam
> 
> > 
> > Anybody know if doing something like the below is a bad idea?
> > 
> > Thanks!
> > sage
> > 
> > ---
> > 
> > #!/bin/sh
> > #
> > # Helper to mount ceph-fuse from /etc/fstab.  To use, add an entry
> > # like:
> > #
> > # # DEVICE                     PATH         TYPE   OPTIONS
> > # /sbin/ceph-fuse-mount#admin  /mnt/ceph    ceph   defaults   0 0
> > #
> > # where 'admin' can be replaced with the client id to use when
> > # authenticating (if it is not client.admin).  This will also control
> > # which section of ceph.conf will be applied to the ceph-fuse process.
> > 
> > set -e
> > id="$1"
> > shift
> > exec ceph-fuse -i $id $@
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
