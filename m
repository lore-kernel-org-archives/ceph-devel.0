From: Sage Weil <sweil@redhat.com>
Subject: Re: why ZFS on ceph is unstable?
Date: Fri, 19 Sep 2014 08:13:44 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409190812310.30467@cobra.newdream.net>
References: <CALZt5jz12FAoSY0B65CohTf10hO9b9929_tKdx_NpZEajpQ75g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44055 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757772AbaISPNo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Sep 2014 11:13:44 -0400
In-Reply-To: <CALZt5jz12FAoSY0B65CohTf10hO9b9929_tKdx_NpZEajpQ75g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nicheal <zay11022@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, zyan@redhat.com

On Fri, 19 Sep 2014, Nicheal wrote:
> Hi developers,
> 
> it mentioned in the source code that OPTION(filestore_zfs_snap,
> OPT_BOOL, false) // zfsonlinux is still unstable. So if we turn on
> filestore_zfs_snap and neglect journal like btrf, it will be unstable?
> 
> As is mentioned on the "zfs on linux community", It is stable enough
> to run a ZFS root filesystem on a GNU/Linux installation for your
> workstation as something to play around with. It is copy-on-write,
> supports compression, deduplication, file atomicity, off-disk caching,
> (encryption not support), and much more.  So it seems that all
> features are supported except for encryption.
> Thus, I am puzzled that the unstable, you mean, is ZFS unstable
> itself. Or it now is already stable on linux, but still unstable when
> used as ceph FileStore filesystem.
> 
> If so, what will happen if we use it, losing data or frequent crash?

At the time the libzfs support was added, zfsonlinux would crash very 
quickly under the ceph-osd workload.  If that has changed, great!  We 
haven't tested it, though, since Zheng added the initial support.

sage
