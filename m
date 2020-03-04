From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] mds: update dentry lease for async create
Date: Wed, 04 Mar 2020 08:55:34 -0500
Message-ID: <88afc25efd69e9d07df88bb2efbc3e989e14fd9a.camel@kernel.org>
References: <20200304132220.41238-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgCDNzg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 4 Mar 2020 08:55:36 -0500
In-Reply-To: <20200304132220.41238-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org

On Wed, 2020-03-04 at 21:22 +0800, Yan, Zheng wrote:
> Otherwise ceph_d_delete() may return 1 for the dentry, which makes
> dput() prune the dentry and clear parent dir's complete flag.
> 
> Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
> ---
>  fs/ceph/file.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 53321bf517c2..671b141aedfe 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -480,6 +480,9 @@ static int try_prep_async_create(struct inode *dir, struct dentry *dentry,
>  	if (d_in_lookup(dentry)) {
>  		if (!__ceph_dir_is_complete(ci))
>  			goto no_async;
> +		spin_lock(&dentry->d_lock);
> +		di->lease_shared_gen = atomic_read(&ci->i_shared_gen);
> +		spin_unlock(&dentry->d_lock);
>  	} else if (atomic_read(&ci->i_shared_gen) !=
>  		   READ_ONCE(di->lease_shared_gen)) {
>  		goto no_async;

Good catch, merged into testing (with small update to changelog
s/mds:/ceph:/)

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>
