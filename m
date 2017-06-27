From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH] ceph: avoid accessing freeing inode in
 ceph_check_delayed_caps()
Date: Tue, 27 Jun 2017 10:23:44 -0400
Message-ID: <1498573424.4830.1.camel@redhat.com>
References: <20170627134344.80072-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35128 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752929AbdF0OYB (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Jun 2017 10:24:01 -0400
Received: by mail-qk0-f181.google.com with SMTP id 16so26271646qkg.2
        for <ceph-devel@vger.kernel.org>; Tue, 27 Jun 2017 07:23:56 -0700 (PDT)
In-Reply-To: <20170627134344.80072-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org

On Tue, 2017-06-27 at 21:43 +0800, Yan, Zheng wrote:
> Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
> ---
>  fs/ceph/caps.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index f555245..7007ae2 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -3809,6 +3809,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
>   */
>  void ceph_check_delayed_caps(struct ceph_mds_client *mdsc)
>  {
> +	struct inode *inode;
>  	struct ceph_inode_info *ci;
>  	int flags = CHECK_CAPS_NODELAY;
>  
> @@ -3824,9 +3825,15 @@ void ceph_check_delayed_caps(struct ceph_mds_client *mdsc)
>  		    time_before(jiffies, ci->i_hold_caps_max))
>  			break;
>  		list_del_init(&ci->i_cap_delay_list);
> +
> +		inode = igrab(&ci->vfs_inode);
>  		spin_unlock(&mdsc->cap_delay_lock);
> -		dout("check_delayed_caps on %p\n", &ci->vfs_inode);
> -		ceph_check_caps(ci, flags, NULL);
> +
> +		if (inode) {
> +			dout("check_delayed_caps on %p\n", inode);
> +			ceph_check_caps(ci, flags, NULL);
> +			iput(inode);
> +		}
>  	}
>  	spin_unlock(&mdsc->cap_delay_lock);
>  }

Reviewed-by: Jeff Layton <jlayton@redhat.com>
