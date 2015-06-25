From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 1/3] rbd: terminate rbd_opts_tokens with Opt_err
Date: Thu, 25 Jun 2015 09:22:46 -0500
Message-ID: <558C0EB6.20708@ieee.org>
References: <1435223480-35238-1-git-send-email-idryomov@gmail.com> <1435223480-35238-2-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33145 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbbFYOWs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Jun 2015 10:22:48 -0400
Received: by padev16 with SMTP id ev16so50826567pad.0
        for <ceph-devel@vger.kernel.org>; Thu, 25 Jun 2015 07:22:48 -0700 (PDT)
In-Reply-To: <1435223480-35238-2-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On 06/25/2015 04:11 AM, Ilya Dryomov wrote:
> Also nuke useless Opt_last_bool and don't break lines unnecessarily.
>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Good idea.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/block/rbd.c | 24 ++++++++----------------
>   1 file changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index bc88fbcb9715..4de8c9167c4b 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -724,7 +724,7 @@ static struct rbd_client *rbd_client_find(struct ceph_options *ceph_opts)
>   }
>
>   /*
> - * mount options
> + * (Per device) rbd map options
>    */
>   enum {
>   	Opt_last_int,
> @@ -733,8 +733,7 @@ enum {
>   	/* string args above */
>   	Opt_read_only,
>   	Opt_read_write,
> -	/* Boolean args above */
> -	Opt_last_bool,
> +	Opt_err
>   };
>
>   static match_table_t rbd_opts_tokens = {
> @@ -744,8 +743,7 @@ static match_table_t rbd_opts_tokens = {
>   	{Opt_read_only, "ro"},		/* Alternate spelling */
>   	{Opt_read_write, "read_write"},
>   	{Opt_read_write, "rw"},		/* Alternate spelling */
> -	/* Boolean args above */
> -	{-1, NULL}
> +	{Opt_err, NULL}
>   };
>
>   struct rbd_options {
> @@ -761,22 +759,15 @@ static int parse_rbd_opts_token(char *c, void *private)
>   	int token, intval, ret;
>
>   	token = match_token(c, rbd_opts_tokens, argstr);
> -	if (token < 0)
> -		return -EINVAL;
> -
>   	if (token < Opt_last_int) {
>   		ret = match_int(&argstr[0], &intval);
>   		if (ret < 0) {
> -			pr_err("bad mount option arg (not int) "
> -			       "at '%s'\n", c);
> +			pr_err("bad mount option arg (not int) at '%s'\n", c);
>   			return ret;
>   		}
>   		dout("got int token %d val %d\n", token, intval);
>   	} else if (token > Opt_last_int && token < Opt_last_string) {
> -		dout("got string token %d val %s\n", token,
> -		     argstr[0].from);
> -	} else if (token > Opt_last_string && token < Opt_last_bool) {
> -		dout("got Boolean token %d\n", token);
> +		dout("got string token %d val %s\n", token, argstr[0].from);
>   	} else {
>   		dout("got token %d\n", token);
>   	}
> @@ -789,9 +780,10 @@ static int parse_rbd_opts_token(char *c, void *private)
>   		rbd_opts->read_only = false;
>   		break;
>   	default:
> -		rbd_assert(false);
> -		break;
> +		/* libceph prints "bad option" msg */
> +		return -EINVAL;
>   	}
> +
>   	return 0;
>   }
>
>

