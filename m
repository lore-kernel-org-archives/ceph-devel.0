From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [PATCH 01/11] rbd: handle locking inside __rbd_client_find()
Date: Thu, 30 Aug 2012 09:09:38 -0700
Message-ID: <CAC-hyiGsAw+L2W3=-roXdZ6WO6AQo_V28L+RKp-5W=6J2=rh9Q@mail.gmail.com>
References: <5037AB20.4000103@inktank.com>
	<5037AC8B.6070608@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:34443 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221Ab2H3QJk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 12:09:40 -0400
Received: by bkwj10 with SMTP id j10so891175bkw.19
        for <ceph-devel@vger.kernel.org>; Thu, 30 Aug 2012 09:09:38 -0700 (PDT)
In-Reply-To: <5037AC8B.6070608@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Yehuda Sadeh <yehuda@inktank.com>

On Fri, Aug 24, 2012 at 9:32 AM, Alex Elder <elder@inktank.com> wrote:
>
> There is only one caller of __rbd_client_find(), and it somewhat
> clumsily gets the appropriate lock and gets a reference to the
> existing ceph_client structure if it's found.
>
> Instead, have that function handle its own locking, and acquire the
> reference if found while it holds the lock.  Drop the underscores
> from the name because there's no need to signify anything special
> about this function.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  drivers/block/rbd.c |   29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 8e6e29e..81b5344 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -322,19 +322,28 @@ out_opt:
>  }
>
>  /*
> - * Find a ceph client with specific addr and configuration.
> + * Find a ceph client with specific addr and configuration.  If
> + * found, bump its reference count.
>   */
> -static struct rbd_client *__rbd_client_find(struct ceph_options
> *ceph_opts)
> +static struct rbd_client *rbd_client_find(struct ceph_options *ceph_opts)
>  {
>         struct rbd_client *client_node;
> +       bool found = false;
>
>         if (ceph_opts->flags & CEPH_OPT_NOSHARE)
>                 return NULL;
>
> -       list_for_each_entry(client_node, &rbd_client_list, node)
> -               if (!ceph_compare_options(ceph_opts, client_node->client))
> -                       return client_node;
> -       return NULL;
> +       spin_lock(&rbd_client_list_lock);
> +       list_for_each_entry(client_node, &rbd_client_list, node) {
> +               if (!ceph_compare_options(ceph_opts, client_node->client))
> {
> +                       kref_get(&client_node->kref);
> +                       found = true;
> +                       break;
> +               }
> +       }
> +       spin_unlock(&rbd_client_list_lock);
> +
> +       return found ? client_node : NULL;
>  }
>
>  /*
> @@ -416,22 +425,16 @@ static struct rbd_client *rbd_get_client(const
> char *mon_addr,
>                 return ERR_CAST(ceph_opts);
>         }
>
> -       spin_lock(&rbd_client_list_lock);
> -       rbdc = __rbd_client_find(ceph_opts);
> +       rbdc = rbd_client_find(ceph_opts);
>         if (rbdc) {
>                 /* using an existing client */
> -               kref_get(&rbdc->kref);
> -               spin_unlock(&rbd_client_list_lock);
> -
>                 ceph_destroy_options(ceph_opts);
>                 kfree(rbd_opts);
>
>                 return rbdc;
>         }
> -       spin_unlock(&rbd_client_list_lock);
>
>         rbdc = rbd_client_create(ceph_opts, rbd_opts);
> -
>         if (IS_ERR(rbdc))
>                 kfree(rbd_opts);
>
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
