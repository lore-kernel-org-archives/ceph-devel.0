From: Sam Lang <sam.lang@inktank.com>
Subject: Re: mounting fuse from fstab
Date: Mon, 10 Dec 2012 11:57:18 -1000
Message-ID: <50C65ABE.5010102@inktank.com>
References: <alpine.DEB.2.00.1212101229540.28411@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:60489 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474Ab2LJV5W (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Dec 2012 16:57:22 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so2345902pad.19
        for <ceph-devel@vger.kernel.org>; Mon, 10 Dec 2012 13:57:22 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1212101229540.28411@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 12/10/2012 10:33 AM, Sage Weil wrote:
> We put together a simple helper script for mounting ceph-fuse via fstab
> (below).  Some of man pages indicate that the # syntax is deprecated,
> however, and it's not clear to me that whatever replaces it (mount.fuse)
> will let us accomplish the same thing (pass something along the mount,
> control command line options).  Also, it's unclear *when* it was
> deprecated; if we want this to work on, say, RHEL, the replacement
> might not be there.

Would the fuse options fsname and subtype be more portable?
-sam

>
> Anybody know if doing something like the below is a bad idea?
>
> Thanks!
> sage
>
> ---
>
> #!/bin/sh
> #
> # Helper to mount ceph-fuse from /etc/fstab.  To use, add an entry
> # like:
> #
> # # DEVICE                     PATH         TYPE   OPTIONS
> # /sbin/ceph-fuse-mount#admin  /mnt/ceph    ceph   defaults   0 0
> #
> # where 'admin' can be replaced with the client id to use when
> # authenticating (if it is not client.admin).  This will also control
> # which section of ceph.conf will be applied to the ceph-fuse process.
>
> set -e
> id="$1"
> shift
> exec ceph-fuse -i $id $@
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

