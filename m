From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] libceph: enable ceph in a non-default network
 namespace
Date: Thu, 9 Jul 2015 08:57:02 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507090856500.29886@cobra.newdream.net>
References: <1436182244-31848-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50533 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbbGIP5D (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Jul 2015 11:57:03 -0400
In-Reply-To: <1436182244-31848-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, Hong Zhiguo <zhiguohong@tencent.com>

On Mon, 6 Jul 2015, Ilya Dryomov wrote:
> Grab a reference on a network namespace of the 'rbd map' (in case of
> rbd) or 'mount' (in case of ceph) process and use that to open sockets
> instead of always using init_net and bailing if network namespace is
> anything but init_net.  Be careful to not share struct ceph_client
> instances between different namespaces and don't add any code in the
> !CONFIG_NET_NS case.
> 
> This is based on a patch from Hong Zhiguo <zhiguohong@tencent.com>.
> 
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Reviewed-by: Sage Weil <sage@redhat.com>

> ---
>  include/linux/ceph/messenger.h |  3 +++
>  net/ceph/ceph_common.c         | 14 +++++++++-----
>  net/ceph/messenger.c           |  9 ++++++++-
>  3 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
> index e15499422fdc..37753278987a 100644
> --- a/include/linux/ceph/messenger.h
> +++ b/include/linux/ceph/messenger.h
> @@ -8,6 +8,7 @@
>  #include <linux/radix-tree.h>
>  #include <linux/uio.h>
>  #include <linux/workqueue.h>
> +#include <net/net_namespace.h>
>  
>  #include <linux/ceph/types.h>
>  #include <linux/ceph/buffer.h>
> @@ -56,6 +57,7 @@ struct ceph_messenger {
>  	struct ceph_entity_addr my_enc_addr;
>  
>  	atomic_t stopping;
> +	possible_net_t net;
>  	bool nocrc;
>  	bool tcp_nodelay;
>  
> @@ -267,6 +269,7 @@ extern void ceph_messenger_init(struct ceph_messenger *msgr,
>  			u64 required_features,
>  			bool nocrc,
>  			bool tcp_nodelay);
> +extern void ceph_messenger_fini(struct ceph_messenger *msgr);
>  
>  extern void ceph_con_init(struct ceph_connection *con, void *private,
>  			const struct ceph_connection_operations *ops,
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index cb7db320dd27..f1a63b17ba95 100644
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@ -17,7 +17,6 @@
>  #include <linux/string.h>
>  #include <linux/vmalloc.h>
>  #include <linux/nsproxy.h>
> -#include <net/net_namespace.h>
>  
>  
>  #include <linux/ceph/ceph_features.h>
> @@ -131,6 +130,13 @@ int ceph_compare_options(struct ceph_options *new_opt,
>  	int i;
>  	int ret;
>  
> +	/*
> +	 * Don't bother comparing options if network namespaces don't
> +	 * match.
> +	 */
> +	if (!net_eq(current->nsproxy->net_ns, read_pnet(&client->msgr.net)))
> +		return -1;
> +
>  	ret = memcmp(opt1, opt2, ofs);
>  	if (ret)
>  		return ret;
> @@ -335,9 +341,6 @@ ceph_parse_options(char *options, const char *dev_name,
>  	int err = -ENOMEM;
>  	substring_t argstr[MAX_OPT_ARGS];
>  
> -	if (current->nsproxy->net_ns != &init_net)
> -		return ERR_PTR(-EINVAL);
> -
>  	opt = kzalloc(sizeof(*opt), GFP_KERNEL);
>  	if (!opt)
>  		return ERR_PTR(-ENOMEM);
> @@ -608,6 +611,7 @@ struct ceph_client *ceph_create_client(struct ceph_options *opt, void *private,
>  fail_monc:
>  	ceph_monc_stop(&client->monc);
>  fail:
> +	ceph_messenger_fini(&client->msgr);
>  	kfree(client);
>  	return ERR_PTR(err);
>  }
> @@ -621,8 +625,8 @@ void ceph_destroy_client(struct ceph_client *client)
>  
>  	/* unmount */
>  	ceph_osdc_stop(&client->osdc);
> -
>  	ceph_monc_stop(&client->monc);
> +	ceph_messenger_fini(&client->msgr);
>  
>  	ceph_debugfs_client_cleanup(client);
>  
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 1679f47280e2..aadebf9c4acf 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -479,7 +479,7 @@ static int ceph_tcp_connect(struct ceph_connection *con)
>  	int ret;
>  
>  	BUG_ON(con->sock);
> -	ret = sock_create_kern(&init_net, con->peer_addr.in_addr.ss_family,
> +	ret = sock_create_kern(read_pnet(&con->msgr->net), paddr->ss_family,
>  			       SOCK_STREAM, IPPROTO_TCP, &sock);
>  	if (ret)
>  		return ret;
> @@ -2944,11 +2944,18 @@ void ceph_messenger_init(struct ceph_messenger *msgr,
>  	msgr->tcp_nodelay = tcp_nodelay;
>  
>  	atomic_set(&msgr->stopping, 0);
> +	write_pnet(&msgr->net, get_net(current->nsproxy->net_ns));
>  
>  	dout("%s %p\n", __func__, msgr);
>  }
>  EXPORT_SYMBOL(ceph_messenger_init);
>  
> +void ceph_messenger_fini(struct ceph_messenger *msgr)
> +{
> +	put_net(read_pnet(&msgr->net));
> +}
> +EXPORT_SYMBOL(ceph_messenger_fini);
> +
>  static void clear_standby(struct ceph_connection *con)
>  {
>  	/* come back from STANDBY? */
> -- 
> 1.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
