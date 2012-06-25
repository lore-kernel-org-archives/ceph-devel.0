From: "Guan Jun He" <gjhe@suse.com>
Subject: Re: [PATCH 1/1] client: prevent the race of incoming work
 during teardown
Date: Sun, 24 Jun 2012 23:56:28 -0600
Message-ID: <4FE86E0C0200001600013468@soto.provo.novell.com>
References: <1340266828-26344-1-git-send-email-gjhe@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from soto.provo.novell.com ([137.65.250.214]:33266 "EHLO
	soto.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408Ab2FYF4o convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:3:1>);
	Mon, 25 Jun 2012 01:56:44 -0400
In-Reply-To: <1340266828-26344-1-git-send-email-gjhe@suse.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guanjun He <heguanbo@gmail.com>, sage@inktank.com, ceph-devel@vger.kernel.org

Hi,

  Do you think atomic_t variable is necessary here? 
or a normal bool variable will ok? or others?

thanks a lot for your reply!

thanks,
Guanjun	

>>> On 6/21/2012 at 04:20 PM, in message
<1340266828-26344-1-git-send-email-gjhe@suse.com>, Guanjun He
<heguanbo@gmail.com> wrote: 
> Add an atomic variable 'teardowning' as flag in struct ceph_messenger,
> set this flag to 1 in function ceph_destroy_client(), and add the condition 
> code
> in function ceph_data_ready() to test the flag value, if true(1), just 
> return.
> 
> Signed-off-by: Guanjun He <gjhe@suse.com>
> ---
>  include/linux/ceph/messenger.h |    1 +
>  net/ceph/ceph_common.c         |    5 +++--
>  net/ceph/messenger.c           |    5 +++++
>  3 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
> index 2521a95..70ff3b7 100644
> --- a/include/linux/ceph/messenger.h
> +++ b/include/linux/ceph/messenger.h
> @@ -54,6 +54,7 @@ struct ceph_messenger {
>  	struct ceph_entity_addr my_enc_addr;
>  
>  	bool nocrc;
> +	atomic_t teardowning;
>  
>  	/*
>  	 * the global_seq counts connections i (attempt to) initiate
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index a776f75..7225e42 100644
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@ -501,6 +501,9 @@ void ceph_destroy_client(struct ceph_client *client)
>  {
>  	dout("destroy_client %p\n", client);
>  
> +	atomic_set(&client->msgr->teardowning, 1);
> +	ceph_msgr_flush();
> +
>  	/* unmount */
>  	ceph_osdc_stop(&client->osdc);
>  
> @@ -509,8 +512,6 @@ void ceph_destroy_client(struct ceph_client *client)
>  	 * auth module, which is needed to free those connections'
>  	 * ceph_authorizers.
>  	 */
> -	ceph_msgr_flush();
> -
>  	ceph_monc_stop(&client->monc);
>  
>  	ceph_debugfs_client_cleanup(client);
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 524f4e4..89a96e7 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -156,6 +156,9 @@ EXPORT_SYMBOL(ceph_msgr_flush);
>  static void ceph_data_ready(struct sock *sk, int count_unused)
>  {
>  	struct ceph_connection *con = sk->sk_user_data;
> +	if (atomic_read(&con->msgr->teardowning)) {
> +		return;
> +	}
>  
>  	if (sk->sk_state != TCP_CLOSE_WAIT) {
>  		dout("ceph_data_ready on %p state = %lu, queueing work\n",
> @@ -2281,6 +2284,8 @@ struct ceph_messenger *ceph_messenger_create(struct 
> ceph_entity_addr *myaddr,
>  	get_random_bytes(&msgr->inst.addr.nonce, sizeof(msgr->inst.addr.nonce));
>  	encode_my_addr(msgr);
>  
> +	atomic_set(&msgr->teardowning, 0);
> +
>  	dout("messenger_create %p\n", msgr);
>  	return msgr;
>  }


