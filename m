From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 5/5] libceph: fix error handling in process_one_ticket()
Date: Tue, 23 May 2017 12:47:11 -0500
Message-ID: <14e02ea8-8bf9-c776-6dd5-a0d4275cc24f@ieee.org>
References: <1495557238-1077-1-git-send-email-idryomov@gmail.com>
 <1495557238-1077-6-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:37843 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966381AbdEWRrO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 23 May 2017 13:47:14 -0400
Received: by mail-it0-f54.google.com with SMTP id g126so24600144ith.0
        for <ceph-devel@vger.kernel.org>; Tue, 23 May 2017 10:47:13 -0700 (PDT)
In-Reply-To: <1495557238-1077-6-git-send-email-idryomov@gmail.com>
Content-Language: en-CA
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On 05/23/2017 11:33 AM, Ilya Dryomov wrote:
> Don't leak key internals after new_session_key is populated.
> 
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Hmmm.  This is a good change.  Perhaps ceph_crypto_key_destroy()
could zero the pointed-to ceph_crypto_key?

Anyway, this looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  net/ceph/auth_x.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
> index d0126df33f1f..8757fb87dab8 100644
> --- a/net/ceph/auth_x.c
> +++ b/net/ceph/auth_x.c
> @@ -151,7 +151,7 @@ static int process_one_ticket(struct ceph_auth_client *ac,
>  	struct timespec validity;
>  	void *tp, *tpend;
>  	void **ptp;
> -	struct ceph_crypto_key new_session_key;
> +	struct ceph_crypto_key new_session_key = { 0 };
>  	struct ceph_buffer *new_ticket_blob;
>  	unsigned long new_expires, new_renew_after;
>  	u64 new_secret_id;
> @@ -237,13 +237,13 @@ static int process_one_ticket(struct ceph_auth_client *ac,
>  	     type, ceph_entity_type_name(type), th->secret_id,
>  	     (int)th->ticket_blob->vec.iov_len);
>  	xi->have_keys |= th->service;
> -
> -out:
> -	return ret;
> +	return 0;
>  
>  bad:
>  	ret = -EINVAL;
> -	goto out;
> +out:
> +	ceph_crypto_key_destroy(&new_session_key);
> +	return ret;
>  }
>  
>  static int ceph_x_proc_ticket_reply(struct ceph_auth_client *ac,
> 

