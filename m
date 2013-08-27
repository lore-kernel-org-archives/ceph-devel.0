From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 0/2] Fscache cleanup and fix
Date: Tue, 27 Aug 2013 16:35:08 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308271632300.24783@cobra.newdream.net>
References: <cover.1377644443.git.milosz@adfin.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55804 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522Ab3H0XfI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Aug 2013 19:35:08 -0400
In-Reply-To: <cover.1377644443.git.milosz@adfin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>, david.howells@redhat.com
Cc: ceph-devel@vger.kernel.org, zheng.z.yan@intel.com

Thanks, Milosz!

I've pulled these into the testing branch and squashed them into the 
existing commits.

David, I'm still not sure whether the fscache patches should go in through 
the Ceph tree or via your tree; either way I think they need your ACK.

https://github.com/ceph/ceph-client/commit/e78fae9b8e0e762114df0cbe718a2ad7c49a18e7
https://github.com/ceph/ceph-client/commit/8151f62a34cc01c9de040722aa7eff85f3092156
https://github.com/ceph/ceph-client/commit/341158ee87d950f2bcf73e56d0db7b57bbe500a7

Thanks!
sage


On Tue, 27 Aug 2013, Milosz Tanski wrote:

> Sage,
> 
> These are the changes you requested. I eliminated the use of ifdefs in the C
> code. It's all self contained in cache.[ch] and in the case of it being
> disabled becomes a nop.
> 
> Also, I found a small bug where we would not free the invalidate queue on
> unmount. It's split into it's own commit.
> 
> Finally, I saw that you had a hard time building it without the kernel flag
> enabled. So I made sure to test a config with fscache for Ceph disabled right
> before sping things.
> 
> The commits are from my branch (which is based on top of the main testing
> branch) from my repo:
> 
>     https://adfin@bitbucket.org/adfin/linux-fs.git branch: wip-ceph-fscache
> 
> Best,
> - Milosz
> 
> Milosz Tanski (2):
>   ceph: Do not leak fscache workqueue
>   ceph: fscache cleanup
> 
>  fs/ceph/cache.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++-------
>  fs/ceph/cache.h | 68 +++++++++++++++++++------------------------
>  fs/ceph/inode.c | 61 +-------------------------------------
>  fs/ceph/super.c | 22 ++++----------
>  fs/ceph/super.h |  1 -
>  5 files changed, 115 insertions(+), 127 deletions(-)
> 
> -- 
> 1.8.1.2
> 
> 
