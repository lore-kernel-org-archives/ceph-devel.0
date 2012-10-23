From: Dan Mick <dan.mick@inktank.com>
Subject: Re: [PATCH] [trivial] fs: ceph: Fix typo in xattr.c
Date: Tue, 23 Oct 2012 13:43:04 -0700
Message-ID: <50870158.5010405@inktank.com>
References: <1350921998-7661-1-git-send-email-standby24x7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42225 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933423Ab2JWUnJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Oct 2012 16:43:09 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so706337pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 23 Oct 2012 13:43:08 -0700 (PDT)
In-Reply-To: <1350921998-7661-1-git-send-email-standby24x7@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Masanari Iida <standby24x7@gmail.com>
Cc: ceph-devel@vger.kernel.org

Thanks!  Making sure this gets incorporated in our next update.

On 10/22/2012 09:06 AM, Masanari Iida wrote:
> Correct spelling typo in debug message
>
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> ---
>   fs/ceph/xattr.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index 2c2ae5b..f4b2c0e 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -813,7 +813,7 @@ retry:
>   		struct ceph_buffer *blob;
>
>   		spin_unlock(&ci->i_ceph_lock);
> -		dout(" preaallocating new blob size=%d\n", required_blob_size);
> +		dout(" preallocating new blob size=%d\n", required_blob_size);
>   		blob = ceph_buffer_new(required_blob_size, GFP_NOFS);
>   		if (!blob)
>   			goto out;
> @@ -909,7 +909,7 @@ retry:
>   		struct ceph_buffer *blob;
>
>   		spin_unlock(&ci->i_ceph_lock);
> -		dout(" preaallocating new blob size=%d\n", required_blob_size);
> +		dout(" preallocating new blob size=%d\n", required_blob_size);
>   		blob = ceph_buffer_new(required_blob_size, GFP_NOFS);
>   		if (!blob)
>   			goto out;
>
