From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH] ceph: don't set st_dev to 0 for stat(2)
Date: Mon, 11 Dec 2017 06:59:47 -0500
Message-ID: <1512993587.3326.5.camel@redhat.com>
References: <20171211084758.3225-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43427 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752616AbdLKL7u (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Dec 2017 06:59:50 -0500
Received: by mail-qt0-f193.google.com with SMTP id w10so37675941qtb.10
        for <ceph-devel@vger.kernel.org>; Mon, 11 Dec 2017 03:59:49 -0800 (PST)
In-Reply-To: <20171211084758.3225-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org

On Mon, 2017-12-11 at 16:47 +0800, Yan, Zheng wrote:
> Zero st_dev confuses ls(1) code. it make 'ls -l' not print '+' sign
> for file/directory with ACL.
> 
> Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
> ---
>  fs/ceph/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index c6ec5aa46100..b5529b0b77a6 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -2244,7 +2244,7 @@ int ceph_getattr(const struct path *path, struct kstat *stat,
>  		if (ceph_snap(inode) != CEPH_NOSNAP)
>  			stat->dev = ceph_snap(inode);
>  		else
> -			stat->dev = 0;
> +			stat->dev = 1; /* the smallest snapid is 2 */
>  		if (S_ISDIR(inode->i_mode)) {
>  			if (ceph_test_mount_opt(ceph_sb_to_client(inode->i_sb),
>  						RBYTES))

This looks wrong to me.

This should be getting filled out with the value of the sb->s_dev field
in generic_fillattr. The right fix would be to ensure that that field
ends up with something valid in it, and that should be happening when we
call set_anon_super.

I think we need to understand why that isn't happening here.

-- 
Jeff Layton <jlayton@redhat.com>
