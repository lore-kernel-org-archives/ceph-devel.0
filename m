From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 15/16] rbd: option symbol renames
Date: Wed, 11 Jul 2012 14:07:02 -0700
Message-ID: <4FFDEAF6.8040400@inktank.com>
References: <4FFD847C.7070205@inktank.com> <4FFD8799.80105@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44227 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754993Ab2GKVHE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jul 2012 17:07:04 -0400
Received: by pbbrp8 with SMTP id rp8so2555948pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 14:07:04 -0700 (PDT)
In-Reply-To: <4FFD8799.80105@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/11/2012 07:03 AM, Alex Elder wrote:
> Use the name "ceph_opts" consistently (rather than just "opt") for
> pointers to a ceph_options structure.
>
> Change the few spots that don't use "rbd_opts" for a rbd_options
> pointer to match the rest.
>
> Signed-off-by: Alex Elder<elder@inktank.com>
> ---
>   drivers/block/rbd.c |   40 ++++++++++++++++++++--------------------
>   1 files changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index d29c864..c99ea08 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -270,9 +270,9 @@ static const struct block_device_operations
> rbd_bd_ops = {
>
>   /*
>    * Initialize an rbd client instance.
> - * We own *opt.
> + * We own *ceph_opts.
>    */
> -static struct rbd_client *rbd_client_create(struct ceph_options *opt,
> +static struct rbd_client *rbd_client_create(struct ceph_options *ceph_opts,
>   					    struct rbd_options *rbd_opts)
>   {
>   	struct rbd_client *rbdc;
> @@ -288,10 +288,10 @@ static struct rbd_client *rbd_client_create(struct
> ceph_options *opt,
>
>   	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
>
> -	rbdc->client = ceph_create_client(opt, rbdc, 0, 0);
> +	rbdc->client = ceph_create_client(ceph_opts, rbdc, 0, 0);
>   	if (IS_ERR(rbdc->client))
>   		goto out_mutex;
> -	opt = NULL; /* Now rbdc->client is responsible for opt */
> +	ceph_opts = NULL; /* Now rbdc->client is responsible for ceph_opts */
>
>   	ret = ceph_open_session(rbdc->client);
>   	if (ret<  0)
> @@ -314,23 +314,23 @@ out_mutex:
>   	mutex_unlock(&ctl_mutex);
>   	kfree(rbdc);
>   out_opt:
> -	if (opt)
> -		ceph_destroy_options(opt);
> +	if (ceph_opts)
> +		ceph_destroy_options(ceph_opts);
>   	return ERR_PTR(ret);
>   }
>
>   /*
>    * Find a ceph client with specific addr and configuration.
>    */
> -static struct rbd_client *__rbd_client_find(struct ceph_options *opt)
> +static struct rbd_client *__rbd_client_find(struct ceph_options *ceph_opts)
>   {
>   	struct rbd_client *client_node;
>
> -	if (opt->flags&  CEPH_OPT_NOSHARE)
> +	if (ceph_opts->flags&  CEPH_OPT_NOSHARE)
>   		return NULL;
>
>   	list_for_each_entry(client_node,&rbd_client_list, node)
> -		if (ceph_compare_options(opt, client_node->client) == 0)
> +		if (!ceph_compare_options(ceph_opts, client_node->client))
>   			return client_node;
>   	return NULL;
>   }
> @@ -346,7 +346,7 @@ enum {
>   	/* string args above */
>   };
>
> -static match_table_t rbdopt_tokens = {
> +static match_table_t rbd_opts_tokens = {
>   	{Opt_notify_timeout, "notify_timeout=%d"},
>   	/* int args above */
>   	/* string args above */
> @@ -355,11 +355,11 @@ static match_table_t rbdopt_tokens = {
>
>   static int parse_rbd_opts_token(char *c, void *private)
>   {
> -	struct rbd_options *rbdopt = private;
> +	struct rbd_options *rbd_opts = private;
>   	substring_t argstr[MAX_OPT_ARGS];
>   	int token, intval, ret;
>
> -	token = match_token(c, rbdopt_tokens, argstr);
> +	token = match_token(c, rbd_opts_tokens, argstr);
>   	if (token<  0)
>   		return -EINVAL;
>
> @@ -380,7 +380,7 @@ static int parse_rbd_opts_token(char *c, void *private)
>
>   	switch (token) {
>   	case Opt_notify_timeout:
> -		rbdopt->notify_timeout = intval;
> +		rbd_opts->notify_timeout = intval;
>   		break;
>   	default:
>   		BUG_ON(token);
> @@ -397,7 +397,7 @@ static struct rbd_client *rbd_get_client(const char
> *mon_addr,
>   					 char *options)
>   {
>   	struct rbd_client *rbdc;
> -	struct ceph_options *opt;
> +	struct ceph_options *ceph_opts;
>   	struct rbd_options *rbd_opts;
>
>   	rbd_opts = kzalloc(sizeof(*rbd_opts), GFP_KERNEL);
> @@ -406,29 +406,29 @@ static struct rbd_client *rbd_get_client(const
> char *mon_addr,
>
>   	rbd_opts->notify_timeout = RBD_NOTIFY_TIMEOUT_DEFAULT;
>
> -	opt = ceph_parse_options(options, mon_addr,
> +	ceph_opts = ceph_parse_options(options, mon_addr,
>   				mon_addr + mon_addr_len,
>   				parse_rbd_opts_token, rbd_opts);

indentation

> -	if (IS_ERR(opt)) {
> +	if (IS_ERR(ceph_opts)) {
>   		kfree(rbd_opts);
> -		return ERR_CAST(opt);
> +		return ERR_CAST(ceph_opts);
>   	}
>
>   	spin_lock(&rbd_client_list_lock);
> -	rbdc = __rbd_client_find(opt);
> +	rbdc = __rbd_client_find(ceph_opts);
>   	if (rbdc) {
>   		/* using an existing client */
>   		kref_get(&rbdc->kref);
>   		spin_unlock(&rbd_client_list_lock);
>
> -		ceph_destroy_options(opt);
> +		ceph_destroy_options(ceph_opts);
>   		kfree(rbd_opts);
>
>   		return rbdc;
>   	}
>   	spin_unlock(&rbd_client_list_lock);
>
> -	rbdc = rbd_client_create(opt, rbd_opts);
> +	rbdc = rbd_client_create(ceph_opts, rbd_opts);
>
>   	if (IS_ERR(rbdc))
>   		kfree(rbd_opts);

