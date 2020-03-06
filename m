From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] fs/ceph: return errcode in __get_parent().
Date: Fri, 06 Mar 2020 07:13:41 -0500
Message-ID: <f7318d47df2074a7a00ea3a8580bc973a8c0b206.camel@kernel.org>
References: <1583458460-31917-1-git-send-email-hqjagain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1583458460-31917-1-git-send-email-hqjagain@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Qiujun Huang <hqjagain@gmail.com>
Cc: sage@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Fri, 2020-03-06 at 09:34 +0800, Qiujun Huang wrote:
> return real errcode when it's different from ENOENT.
> 
> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> ---
>  fs/ceph/export.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/ceph/export.c b/fs/ceph/export.c
> index b6bfa94..79dc068 100644
> --- a/fs/ceph/export.c
> +++ b/fs/ceph/export.c
> @@ -315,6 +315,11 @@ static struct dentry *__get_parent(struct super_block *sb,
>  
>  	req->r_num_caps = 1;
>  	err = ceph_mdsc_do_request(mdsc, NULL, req);
> +	if (err) {
> +		ceph_mdsc_put_request(req);
> +		return ERR_PTR(err);
> +	}
> +
>  	inode = req->r_target_inode;
>  	if (inode)
>  		ihold(inode);

Looks good! Merged into the ceph-client/testing branch and should make
5.7. Thanks for the patch!
-- 
Jeff Layton <jlayton@kernel.org>
