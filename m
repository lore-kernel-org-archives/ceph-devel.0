From: "Guan Jun He" <gjhe@suse.com>
Subject: Re: [PATCH 1/1] client: prevent the race of incoming work
 during teardown
Date: Sun, 08 Jul 2012 21:42:34 -0600
Message-ID: <4FFAC3AA02000016000150A3@soto.provo.novell.com>
References: <Re: [PATCH 1/1] client: prevent the race of incoming work during
 teardown> <1341199901-16730-1-git-send-email-gjhe@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from soto.provo.novell.com ([137.65.250.214]:53403 "EHLO
	soto.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981Ab2GIDmo convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:3:1>);
	Sun, 8 Jul 2012 23:42:44 -0400
In-Reply-To: <1341199901-16730-1-git-send-email-gjhe@suse.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guanjun He <heguanbo@gmail.com>, sage@inktank.com, ceph-devel@vger.kernel.org

Hi Sage,

  I have resubmited the patch with changes we talked in last e_mail.
Please take a view of it and give a reply.
Thank you very much for your time! 	

best,
Guanjun


>>> On 7/2/2012 at 11:31 AM, in message
<1341199901-16730-1-git-send-email-gjhe@suse.com>, Guanjun He
<heguanbo@gmail.com> wrote: 
> Reproduce the patch against the latest source repo.
> 
> 	Add an atomic variable 'stopping' as flag in struct ceph_messenger,
>  set this flag to 1 in function ceph_destroy_client(), and add the condition 
> code
>  in function ceph_data_ready() to test the flag value, if true(1), just 
> return.
> 
> Signed-off-by: Guanjun He <gjhe@suse.com>
> ---
>  include/linux/ceph/messenger.h |    1 +
>  net/ceph/ceph_common.c         |    2 ++
>  net/ceph/messenger.c           |    5 +++++
>  3 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
> index 2521a95..2586f34 100644
> --- a/include/linux/ceph/messenger.h
> +++ b/include/linux/ceph/messenger.h
> @@ -53,6 +53,7 @@ struct ceph_messenger {
>  	struct ceph_entity_inst inst;    /* my name+address */
>  	struct ceph_entity_addr my_enc_addr;
>  
> +	atomic_t stopping;
>  	bool nocrc;
>  
>  	/*
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index ba4323b..478f3a4 100644
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@ -501,6 +501,8 @@ void ceph_destroy_client(struct ceph_client *client)
>  {
>  	dout("destroy_client %p\n", client);
>  
> +	atomic_set(&client->msgr->stopping, 1);
> +
>  	/* unmount */
>  	ceph_osdc_stop(&client->osdc);
>  
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index b332c3d..11ea62e 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -156,6 +156,9 @@ EXPORT_SYMBOL(ceph_msgr_flush);
>  static void ceph_data_ready(struct sock *sk, int count_unused)
>  {
>  	struct ceph_connection *con = sk->sk_user_data;
> +	if (atomic_read(&con->msgr->stopping)) {
> +		return;
> +	}
>  
>  	if (sk->sk_state != TCP_CLOSE_WAIT) {
>  		dout("ceph_data_ready on %p state = %lu, queueing work\n",
> @@ -2285,6 +2288,8 @@ struct ceph_messenger *ceph_messenger_create(struct 
> ceph_entity_addr *myaddr,
>  	get_random_bytes(&msgr->inst.addr.nonce, sizeof(msgr->inst.addr.nonce));
>  	encode_my_addr(msgr);
>  
> +	atomic_set(&msgr->stopping, 0);
> +
>  	dout("messenger_create %p\n", msgr);
>  	return msgr;
>  }


