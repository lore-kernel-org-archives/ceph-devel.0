From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [PATCH 05/11] rbd: move rbd_opts to struct rbd_device
Date: Thu, 30 Aug 2012 10:07:56 -0700
Message-ID: <CAC-hyiE42C1CahCDAxh0LawehFdY2c2VYiUxWcinqVAf4uJ27A@mail.gmail.com>
References: <5037AB20.4000103@inktank.com>
	<5037ACF3.5000506@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:35925 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997Ab2H3RH5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 13:07:57 -0400
Received: by bkwj10 with SMTP id j10so917789bkw.19
        for <ceph-devel@vger.kernel.org>; Thu, 30 Aug 2012 10:07:56 -0700 (PDT)
In-Reply-To: <5037ACF3.5000506@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Fri, Aug 24, 2012 at 9:33 AM, Alex Elder <elder@inktank.com> wrote:
> The rbd options don't really apply to the ceph client.  So don't
> store a pointer to it in the ceph_client structure, and put them
> (a struct, not a pointer) into the rbd_dev structure proper.
>
> Pass the rbd device structure to rbd_client_create() so it can
> assign rbd_dev->rbdc if successful, and have it return an error code
> instead of the rbd client pointer.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  drivers/block/rbd.c |   49
> ++++++++++++++++---------------------------------
>  1 file changed, 16 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 130dbc2..b40f553 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -98,7 +98,6 @@ struct rbd_options {
>   */
>  struct rbd_client {
>         struct ceph_client      *client;
> -       struct rbd_options      *rbd_opts;
>         struct kref             kref;
>         struct list_head        node;
>  };
> @@ -152,6 +151,7 @@ struct rbd_device {
>         struct gendisk          *disk;          /* blkdev's gendisk and rq */
>         struct request_queue    *q;
>
> +       struct rbd_options      rbd_opts;
>         struct rbd_client       *rbd_client;
>
>         char                    name[DEV_NAME_LEN]; /* blkdev name, e.g. rbd3 */
> @@ -273,8 +273,7 @@ static const struct block_device_operations
> rbd_bd_ops = {
>   * Initialize an rbd client instance.
>   * We own *ceph_opts.
>   */
> -static struct rbd_client *rbd_client_create(struct ceph_options *ceph_opts,
> -                                           struct rbd_options *rbd_opts)
> +static struct rbd_client *rbd_client_create(struct ceph_options *ceph_opts)
>  {
>         struct rbd_client *rbdc;
>         int ret = -ENOMEM;
> @@ -298,8 +297,6 @@ static struct rbd_client *rbd_client_create(struct
> ceph_options *ceph_opts,
>         if (ret < 0)
>                 goto out_err;
>
> -       rbdc->rbd_opts = rbd_opts;
> -
>         spin_lock(&rbd_client_list_lock);
>         list_add_tail(&rbdc->node, &rbd_client_list);
>         spin_unlock(&rbd_client_list_lock);
> @@ -402,42 +399,33 @@ static int parse_rbd_opts_token(char *c, void
> *private)
>   * Get a ceph client with specific addr and configuration, if one does
>   * not exist create it.
>   */
> -static struct rbd_client *rbd_get_client(const char *mon_addr,
> -                                        size_t mon_addr_len,
> -                                        char *options)
> +static int rbd_get_client(struct rbd_device *rbd_dev, const char *mon_addr,
> +                               size_t mon_addr_len, char *options)
>  {
> -       struct rbd_client *rbdc;
> +       struct rbd_options *rbd_opts = &rbd_dev->rbd_opts;
>         struct ceph_options *ceph_opts;
> -       struct rbd_options *rbd_opts;
> -
> -       rbd_opts = kzalloc(sizeof(*rbd_opts), GFP_KERNEL);
> -       if (!rbd_opts)
> -               return ERR_PTR(-ENOMEM);
> +       struct rbd_client *rbdc;
>
>         rbd_opts->notify_timeout = RBD_NOTIFY_TIMEOUT_DEFAULT;
>
>         ceph_opts = ceph_parse_options(options, mon_addr,
>                                         mon_addr + mon_addr_len,
>                                         parse_rbd_opts_token, rbd_opts);
> -       if (IS_ERR(ceph_opts)) {
> -               kfree(rbd_opts);
> -               return ERR_CAST(ceph_opts);
> -       }
> +       if (IS_ERR(ceph_opts))
> +               return PTR_ERR(ceph_opts);
>
>         rbdc = rbd_client_find(ceph_opts);
>         if (rbdc) {
>                 /* using an existing client */
>                 ceph_destroy_options(ceph_opts);

It'll probably be better to use a reference count to control ceph_opts lifecycle

> -               kfree(rbd_opts);
> -
> -               return rbdc;
> +       } else {
> +               rbdc = rbd_client_create(ceph_opts);
> +               if (IS_ERR(rbdc))
> +                       return PTR_ERR(rbdc);
>         }
> +       rbd_dev->rbd_client = rbdc;
>
> -       rbdc = rbd_client_create(ceph_opts, rbd_opts);
> -       if (IS_ERR(rbdc))
> -               kfree(rbd_opts);
> -
> -       return rbdc;
> +       return 0;
>  }
>
>  /*
> @@ -455,7 +443,6 @@ static void rbd_client_release(struct kref *kref)
>         spin_unlock(&rbd_client_list_lock);
>
>         ceph_destroy_client(rbdc->client);
> -       kfree(rbdc->rbd_opts);
>         kfree(rbdc);
>  }
>
> @@ -2526,13 +2513,9 @@ static ssize_t rbd_add(struct bus_type *bus,
>         if (rc)
>                 goto err_put_id;
>
> -       rbd_dev->rbd_client = rbd_get_client(mon_addrs, mon_addrs_size - 1,
> -                                               options);
> -       if (IS_ERR(rbd_dev->rbd_client)) {
> -               rc = PTR_ERR(rbd_dev->rbd_client);
> -               rbd_dev->rbd_client = NULL;
> +       rc = rbd_get_client(rbd_dev, mon_addrs, mon_addrs_size - 1, options);
> +       if (rc < 0)
>                 goto err_put_id;
> -       }
>
>         /* pick the pool */
>         osdc = &rbd_dev->rbd_client->client->osdc;
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
