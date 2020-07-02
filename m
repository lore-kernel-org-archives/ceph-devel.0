From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH] ceph: clean up and optimize ceph_check_delayed_caps
Date: Thu, 2 Jul 2020 12:43:47 +0800
Message-ID: <cc37c363-077d-559e-5643-d54674f22260@redhat.com>
References: <20200701133500.26613-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41964 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725994AbgGBEnz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Jul 2020 00:43:55 -0400
In-Reply-To: <20200701133500.26613-1-jlayton@kernel.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org

On 2020/7/1 21:35, Jeff Layton wrote:
> Make this loop look a bit more sane. Also optimize away the spinlock
> release/reacquire if we can't get an inode reference.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/ceph/caps.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 5f4894063a73..55ccccf77cea 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -4189,10 +4189,8 @@ void ceph_check_delayed_caps(struct ceph_mds_client *mdsc)
>   	struct ceph_inode_info *ci;
>   
>   	dout("check_delayed_caps\n");
> -	while (1) {
> -		spin_lock(&mdsc->cap_delay_lock);
> -		if (list_empty(&mdsc->cap_delay_list))
> -			break;
> +	spin_lock(&mdsc->cap_delay_lock);
> +	while (!list_empty(&mdsc->cap_delay_list)) {
>   		ci = list_first_entry(&mdsc->cap_delay_list,
>   				      struct ceph_inode_info,
>   				      i_cap_delay_list);
> @@ -4202,13 +4200,13 @@ void ceph_check_delayed_caps(struct ceph_mds_client *mdsc)
>   		list_del_init(&ci->i_cap_delay_list);
>   
>   		inode = igrab(&ci->vfs_inode);
> -		spin_unlock(&mdsc->cap_delay_lock);
> -
>   		if (inode) {
> +			spin_unlock(&mdsc->cap_delay_lock);
>   			dout("check_delayed_caps on %p\n", inode);
>   			ceph_check_caps(ci, 0, NULL);
>   			/* avoid calling iput_final() in tick thread */
>   			ceph_async_iput(inode);
> +			spin_lock(&mdsc->cap_delay_lock);
>   		}
>   	}
>   	spin_unlock(&mdsc->cap_delay_lock);

Reviewed-by: Xiubo Li <xiubli@redhat.com>
