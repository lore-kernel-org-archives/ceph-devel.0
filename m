From: Sage Weil <sage@inktank.com>
Subject: Re: Master needs newer version of boost on centos?
Date: Fri, 14 Feb 2014 15:48:09 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1402141547240.17843@cobra.newdream.net>
References: <52FEA949.4090801@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53030 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436AbaBNXsJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Feb 2014 18:48:09 -0500
In-Reply-To: <52FEA949.4090801@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sandon Van Ness <sandon@inktank.com>
Cc: matt@linuxbox.com, ceph-devel@vger.kernel.org

Hey Matt,

This is in the libcephfs code I merged yesterday.  Any ideas?

Thanks!
sage


On Fri, 14 Feb 2014, Sandon Van Ness wrote:

> 
> The last couple builds of master have been failing on the centos gitbuilder.
> here is the build log:
> 
> http://gitbuilder.sepia.ceph.com/gitbuilder-centos6-amd64/log.cgi?log=f47062d8a66b94743888aaea13e0766579379395
> 
> Its running into:
> 
> CXX mds/Capability.lo
> CXX mds/Dumper.lo
> In file included from client/Client.h:38,
> from libcephfs.cc:21:
> 
>      error: client/barrier.h:25:38: boost/icl/interval_set.hpp: No such
>      file or directory 
> 
> It looks like its not effecting fedora gitbuilders that have a newer version
> of boost but on centos/rhel the version is only 1.41.0-18. Is there something
> we can do to get around this without back-porting or will backporting a newer
> boost for rhel/centos be necessary?
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
