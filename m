From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 3/3] ceph: make ceph ACL for symlink inheritable
Date: Fri, 14 Feb 2014 07:06:10 -0600
Message-ID: <52FE14C2.7030805@ieee.org>
References: <1392355784-10422-1-git-send-email-lucienchao@gmail.com> <1392355784-10422-4-git-send-email-lucienchao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:48938 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbaBNNGK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Feb 2014 08:06:10 -0500
Received: by mail-ig0-f174.google.com with SMTP id hl1so769897igb.1
        for <ceph-devel@vger.kernel.org>; Fri, 14 Feb 2014 05:06:09 -0800 (PST)
In-Reply-To: <1392355784-10422-4-git-send-email-lucienchao@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guangliang Zhao <lucienchao@gmail.com>, ceph-devel@vger.kernel.org
Cc: sage@inktank.com

On 02/13/2014 11:29 PM, Guangliang Zhao wrote:
> Default ACL couldn't be inherited by the symlink in the
> parent directory. This resolve it.

This looks good to me, and it seems to be consistent
with what other file systems do.

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Guangliang Zhao <lucienchao@gmail.com>
> ---
>  fs/ceph/dir.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 619616d..2650570 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -735,6 +735,10 @@ static int ceph_symlink(struct inode *dir, struct dentry *dentry,
>  	if (!err && !req->r_reply_info.head->is_dentry)
>  		err = ceph_handle_notrace_create(dir, dentry);
>  	ceph_mdsc_put_request(req);
> +
> +	if (!err)
> +		err = ceph_init_acl(dentry, dentry->d_inode, dir);
> +
>  	if (err)
>  		d_drop(dentry);
>  	return err;
> 

