From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 07/16] libceph: rename ceph_client_id() ->
 ceph_client_gid()
Date: Wed, 24 Aug 2016 15:00:08 -0500
Message-ID: <028df11c-08d0-5972-7f44-e2064696092d@ieee.org>
References: <1472044720-29116-1-git-send-email-idryomov@gmail.com>
 <1472044720-29116-8-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:36243 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752653AbcHXUAX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2016 16:00:23 -0400
Received: by mail-it0-f48.google.com with SMTP id e63so231738927ith.1
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 13:00:10 -0700 (PDT)
In-Reply-To: <1472044720-29116-8-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org


Why?  There must be at least a one-line explanation.

On 08/24/2016 08:18 AM, Ilya Dryomov wrote:
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  drivers/block/rbd.c          | 2 +-
>  include/linux/ceph/libceph.h | 2 +-
>  net/ceph/ceph_common.c       | 7 ++++---
>  3 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 6c6519f6492a..e0585e9040f1 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -3758,7 +3758,7 @@ static ssize_t rbd_client_id_show(struct device *dev,
>  	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);
>  
>  	return sprintf(buf, "client%lld\n",
> -			ceph_client_id(rbd_dev->rbd_client->client));
> +		       ceph_client_gid(rbd_dev->rbd_client->client));
>  }
>  
>  static ssize_t rbd_pool_show(struct device *dev,
> diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
> index 83fc1fff7061..b4cffff70e44 100644
> --- a/include/linux/ceph/libceph.h
> +++ b/include/linux/ceph/libceph.h
> @@ -264,7 +264,7 @@ extern struct ceph_client *ceph_create_client(struct ceph_options *opt,
>  					      void *private,
>  					      u64 supported_features,
>  					      u64 required_features);
> -extern u64 ceph_client_id(struct ceph_client *client);
> +u64 ceph_client_gid(struct ceph_client *client);
>  extern void ceph_destroy_client(struct ceph_client *client);
>  extern int __ceph_open_session(struct ceph_client *client,
>  			       unsigned long started);
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index bddfcf6f09c2..8a7921767308 100644
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@ -566,11 +566,11 @@ int ceph_print_client_options(struct seq_file *m, struct ceph_client *client)
>  }
>  EXPORT_SYMBOL(ceph_print_client_options);
>  
> -u64 ceph_client_id(struct ceph_client *client)
> +u64 ceph_client_gid(struct ceph_client *client)
>  {
>  	return client->monc.auth->global_id;
>  }
> -EXPORT_SYMBOL(ceph_client_id);
> +EXPORT_SYMBOL(ceph_client_gid);
>  
>  /*
>   * create a fresh client instance
> @@ -685,7 +685,8 @@ int __ceph_open_session(struct ceph_client *client, unsigned long started)
>  			return client->auth_err;
>  	}
>  
> -	pr_info("client%llu fsid %pU\n", ceph_client_id(client), &client->fsid);
> +	pr_info("client%llu fsid %pU\n", ceph_client_gid(client),
> +		&client->fsid);
>  	ceph_debugfs_client_init(client);
>  
>  	return 0;
> 

