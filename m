From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] ceph: initialize pathbase in the !dentry case in
 encode_caps_cb()
Date: Tue, 9 Aug 2016 09:48:02 -0500
Message-ID: <676d9920-5a02-7f92-8b7b-a78c4b1ccc5a@ieee.org>
References: <1470753815-5848-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:38064 "EHLO
	mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188AbcHIOsl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Aug 2016 10:48:41 -0400
Received: by mail-it0-f54.google.com with SMTP id x130so16297546ite.1
        for <ceph-devel@vger.kernel.org>; Tue, 09 Aug 2016 07:48:05 -0700 (PDT)
In-Reply-To: <1470753815-5848-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Cc: Zheng Yan <zyan@redhat.com>

On 08/09/2016 09:43 AM, Ilya Dryomov wrote:
> pathbase is the base inode; set it to 0 if we've got no path.
> 
> Coverity-id: 146348
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

I'm surprised the compiler didn't complain about this.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  fs/ceph/mds_client.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index fa59a85226b2..f72d4ae303b2 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2759,6 +2759,7 @@ static int encode_caps_cb(struct inode *inode, struct ceph_cap *cap,
>  	} else {
>  		path = NULL;
>  		pathlen = 0;
> +		pathbase = 0;
>  	}
>  
>  	spin_lock(&ci->i_ceph_lock);
> 

