From: Sage Weil <sage@inktank.com>
Subject: Re: unpackaged files in rpmbuild of 0.48
Date: Fri, 6 Jul 2012 08:41:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1207060841030.25921@cobra.newdream.net>
References: <1E7E28F9-6612-4488-B7C2-0B2E48281765@tchpc.tcd.ie>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55812 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757567Ab2GFPlj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jul 2012 11:41:39 -0400
In-Reply-To: <1E7E28F9-6612-4488-B7C2-0B2E48281765@tchpc.tcd.ie>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jimmy Tang <jtang@tchpc.tcd.ie>
Cc: ceph-devel@vger.kernel.org

On Fri, 6 Jul 2012, Jimmy Tang wrote:
> Hi All,
> 
> I'm not sure if this is intentional or not, but during a rpm build of 0.48 gives the following
> 
> error: Installed (but unpackaged) file(s) found:
>    /sbin/ceph-disk-activate
>    /sbin/ceph-disk-prepare
> 
> 
> RPM build errors:
>     Installed (but unpackaged) file(s) found:
>    /sbin/ceph-disk-activate
>    /sbin/ceph-disk-prepare
> 
> The following will fix the spec file
> 
> diff -u ceph.spec.in.orig ceph.spec.in
> --- ceph.spec.in.orig	2012-07-06 15:38:59.298497719 +0100
> +++ ceph.spec.in	2012-07-06 15:39:45.423560177 +0100
> @@ -326,6 +326,8 @@
>  /usr/sbin/rcceph
>  %{_libdir}/rados-classes/libcls_rbd.so*
>  %{_libdir}/rados-classes/libcls_rgw.so*
> +/sbin/ceph-disk-activate
> +/sbin/ceph-disk-prepare
>  
>  #################################################################################
>  %files fuse

I fixed this up in the stable branch, and it'll be included in the .1 
release.

Thanks!
sage


> 
> I could of course ignore
> 
> Regards,
> Jimmy Tang
> 
> --
> Senior Software Engineer, Digital Repository of Ireland (DRI)
> Trinity Centre for High Performance Computing,
> Lloyd Building, Trinity College Dublin, Dublin 2, Ireland.
> http://www.tchpc.tcd.ie/
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
