From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 01/16] libceph: rename ceph_entity_name_encode() ->
 ceph_auth_entity_name_encode()
Date: Wed, 24 Aug 2016 13:49:07 -0500
Message-ID: <28e3c600-d042-bebc-31d4-2f5223a2de5c@ieee.org>
References: <1472044720-29116-1-git-send-email-idryomov@gmail.com>
 <1472044720-29116-2-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:37754 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755308AbcHXStJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2016 14:49:09 -0400
Received: by mail-it0-f44.google.com with SMTP id f6so50341595ith.0
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 11:49:09 -0700 (PDT)
In-Reply-To: <1472044720-29116-2-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On 08/24/2016 08:18 AM, Ilya Dryomov wrote:
> Clear up EntityName vs entity_name_t confusion.

If I understand what your code does, you're using
"auth_entity_name" to represent whatever "EntityName"
is.  (At this point I'm just looking at the code; I
haven't gone to look at what an entity_name_t or
EntitnyName are...)

In any case, this looks good to me.

Reviewed-by: Alex Elder <elder@linaro.org>

> 
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  include/linux/ceph/auth.h | 2 +-
>  net/ceph/auth.c           | 7 +++++--
>  net/ceph/auth_none.c      | 2 +-
>  3 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/ceph/auth.h b/include/linux/ceph/auth.h
> index 1563265d2097..374bb1c4ef52 100644
> --- a/include/linux/ceph/auth.h
> +++ b/include/linux/ceph/auth.h
> @@ -104,7 +104,7 @@ extern int ceph_auth_build_hello(struct ceph_auth_client *ac,
>  extern int ceph_handle_auth_reply(struct ceph_auth_client *ac,
>  				  void *buf, size_t len,
>  				  void *reply_buf, size_t reply_len);
> -extern int ceph_entity_name_encode(const char *name, void **p, void *end);
> +int ceph_auth_entity_name_encode(const char *name, void **p, void *end);
>  
>  extern int ceph_build_auth(struct ceph_auth_client *ac,
>  		    void *msg_buf, size_t msg_len);
> diff --git a/net/ceph/auth.c b/net/ceph/auth.c
> index 2bc5965fdd1e..78067dda9d3c 100644
> --- a/net/ceph/auth.c
> +++ b/net/ceph/auth.c
> @@ -82,7 +82,10 @@ void ceph_auth_reset(struct ceph_auth_client *ac)
>  	mutex_unlock(&ac->mutex);
>  }
>  
> -int ceph_entity_name_encode(const char *name, void **p, void *end)
> +/*
> + * EntityName, not to be confused with entity_name_t
> + */
> +int ceph_auth_entity_name_encode(const char *name, void **p, void *end)
>  {
>  	int len = strlen(name);
>  
> @@ -124,7 +127,7 @@ int ceph_auth_build_hello(struct ceph_auth_client *ac, void *buf, size_t len)
>  	for (i = 0; i < num; i++)
>  		ceph_encode_32(&p, supported_protocols[i]);
>  
> -	ret = ceph_entity_name_encode(ac->name, &p, end);
> +	ret = ceph_auth_entity_name_encode(ac->name, &p, end);
>  	if (ret < 0)
>  		goto out;
>  	ceph_decode_need(&p, end, sizeof(u64), bad);
> diff --git a/net/ceph/auth_none.c b/net/ceph/auth_none.c
> index 5f836f02ae36..df45e467c81f 100644
> --- a/net/ceph/auth_none.c
> +++ b/net/ceph/auth_none.c
> @@ -46,7 +46,7 @@ static int ceph_auth_none_build_authorizer(struct ceph_auth_client *ac,
>  	int ret;
>  
>  	ceph_encode_8_safe(&p, end, 1, e_range);
> -	ret = ceph_entity_name_encode(ac->name, &p, end);
> +	ret = ceph_auth_entity_name_encode(ac->name, &p, end);
>  	if (ret < 0)
>  		return ret;
>  
> 

