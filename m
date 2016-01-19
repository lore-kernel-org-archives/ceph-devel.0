From: Sage Weil <sage@newdream.net>
Subject: Re: librados option 'conf' and 'cluster'.
Date: Tue, 19 Jan 2016 10:09:13 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1601191007570.28274@cpach.fuggernut.com>
References: <569CB969.8080601@xtaotech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39191 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754328AbcASPJH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jan 2016 10:09:07 -0500
In-Reply-To: <569CB969.8080601@xtaotech.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Javen Wu <javen.wu@xtaotech.com>
Cc: ceph-devel@vger.kernel.org, jdurgin@redhat.com

On Mon, 18 Jan 2016, Javen Wu wrote:
> Hi buddies,
> 
> Recently, I met a problem about librados option 'conf' and 'cluster'.
> I created a CEPH cluster but not name it 'ceph', it triggers a lot of problems
> on my openstack environment.
> I found there are consumers of librados or librados python binding only
> respect
>  'conf' option. However, the option 'cluster' is ignored usually.
> 
> So far, I suffered the problem in:
> 1. librados python binding
> 2. qemu rbd driver
> 3. cinder volume rbd driver
> 
> I saw there is rados_create2() API in librados besides rados_create(), but
> it seems the API is not widedly used by consumers yet.
> 
> I am thinking whether we can do a compromise in librados. If consumers of
> librados does not give an arguments for 'cluster'(cluster name) explicitly,
> Can we use (basename(conffile).split('.conf')[0]) as cluster name by
> default in librados?
> 
> So that all consumers of the librados can tolerate the non-'ceph' cluster name
> without any change.
> 
> How do you guys think? If you agree to the change, I can do the quick fixing.

This would be a bit of a hack, but it seems reasonable enough to me--I 
can't think of anything that would break as a result.

Josh, what do you think?  The logic it could even be restricted to the 
client side only...

sage
