From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH v2] ceph: Mark the file cache as unreclaimable
Date: Tue, 26 Jul 2016 10:24:23 +0800
Message-ID: <0AB9E085-6301-4015-8B99-64EEA425E652@redhat.com>
References: <1469466572-8939-1-git-send-email-n.borisov.lkml@gmail.com> <1469466733-9092-1-git-send-email-n.borisov.lkml@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36678 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752481AbcGZCYa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jul 2016 22:24:30 -0400
In-Reply-To: <1469466733-9092-1-git-send-email-n.borisov.lkml@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nikolay Borisov <n.borisov.lkml@gmail.com>
Cc: Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>, linux-kernel@vger.kernel.org


> On Jul 26, 2016, at 01:12, Nikolay Borisov <n.borisov.lkml@gmail.com> wrote:
> 
> Ceph creates multiple caches with the SLAB_RECLAIMABLE flag set, so
> that it can satisfy its internal needs. Inspecting the code shows that
> most of the caches are indeed reclaimable since they are directly
> related to the generic inode/dentry shrinkers. However, one of the
> cache used to satisfy struct file is not reclaimable since its
> entries are freed only when the last reference to the file is
> dropped. If a heavily loaded node opens a lot of files it can
> introduce non-trivial discrepancies between memory shown as reclaimable
> and what is actually reclaimed when drop_caches is used.
> 
> Fix this by removing the reclaimable flag for the file's cache.
> 
> Signed-off-by: Nikolay Borisov <n.borisov.lkml@gmail.com>
> ---
> 
> Fixed checkpatch warning + missing SOB line
> 
> fs/ceph/super.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index 91e02481ce06..8697cac6add0 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -672,8 +672,8 @@ static int __init init_caches(void)
> 	if (ceph_dentry_cachep == NULL)
> 		goto bad_dentry;
> 
> -	ceph_file_cachep = KMEM_CACHE(ceph_file_info,
> -				      SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD);
> +	ceph_file_cachep = KMEM_CACHE(ceph_file_info, SLAB_MEM_SPREAD);
> +
> 	if (ceph_file_cachep == NULL)
> 		goto bad_file;
> 

Applied, thanks

Yan, Zheng

> -- 
> 2.7.4
> 

