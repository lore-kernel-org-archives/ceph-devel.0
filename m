From: Sage Weil <sage@inktank.com>
Subject: Re: [ceph-commit] HEALTH_WARN 192 pgs degraded
Date: Wed, 24 Oct 2012 08:40:22 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210240839280.25958@cobra.newdream.net>
References: <5087F3AE.8080601@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49297 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756308Ab2JXPkW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Oct 2012 11:40:22 -0400
In-Reply-To: <5087F3AE.8080601@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roman Alekseev <rs.alekseev@gmail.com>
Cc: ceph-devel@vger.kernel.org

[moved to ceph-devel]

On Wed, 24 Oct 2012, Roman Alekseev wrote:
> Hi there,
> 
> 
> I've made simple fresh installation of ceph on Debian server with the
> following configuration:
> ************************
> [global]
>     debug ms = 0
> [osd]
>     osd journal size = 1000
>     filestore xattr use omap = true
> 
> [mon.a]
> 
>     host = serv1
>     mon addr = 192.168.0.10:6789
> 
> [osd.0]
>      host = serv1
> 
> [mds.a]
>     host = serv1
> ************************
> 
> Seems everything is working fine but when I perform "ceph health" command I
> receive the next message:
> HEALTH_WARN 192 pgs degraded; 192 pgs stuck unclean; recovery 21/42 degraded
> (50.000%)

This is simply because you only have 1 osd but the default policy is 2x 
replication.  As such, all PGs are 'degraded' because they are only 
replicated once.

If you add another OSD to your cluster the warning will go away.

sage


> 
> Kindly help me to find the reason of this issue.
> Thanks.
> 
> -- 
> Kind regards,
> 
> R. Alekseev
> 
> _______________________________________________
> Ceph-commit mailing list
> Ceph-commit@lists.ceph.newdream.net
> http://lists.ceph.newdream.net/listinfo.cgi/ceph-commit-ceph.newdream.net
> 
> 
