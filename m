From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] ceph: fix use-after-free for fsc->mdsc
Date: Thu, 23 Jul 2020 06:41:00 -0400
Message-ID: <11f7ff95dd153e18204a9c23731c222a09f2b196.camel@kernel.org>
References: <20200723073225.340115-1-xiubli@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbgGWKlC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 23 Jul 2020 06:41:02 -0400
In-Reply-To: <20200723073225.340115-1-xiubli@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xiubli@redhat.com
Cc: idryomov@gmail.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org

On Thu, 2020-07-23 at 15:32 +0800, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> If the ceph_mdsc_init() fails, it will free the mdsc already.
> 
> Reported-by: syzbot+b57f46d8d6ea51960b8c@syzkaller.appspotmail.com
> URL: https://tracker.ceph.com/issues/46684
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>  fs/ceph/mds_client.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index af7221d1c610..590822fab767 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -4453,7 +4453,6 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
>  		goto err_mdsc;
>  	}
>  
> -	fsc->mdsc = mdsc;
>  	init_completion(&mdsc->safe_umount_waiters);
>  	init_waitqueue_head(&mdsc->session_close_wq);
>  	INIT_LIST_HEAD(&mdsc->waiting_for_map);
> @@ -4508,6 +4507,8 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
>  
>  	strscpy(mdsc->nodename, utsname()->nodename,
>  		sizeof(mdsc->nodename));
> +
> +	fsc->mdsc = mdsc;
>  	return 0;
>  
>  err_mdsmap:

Looks good, merged into testing.

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>
