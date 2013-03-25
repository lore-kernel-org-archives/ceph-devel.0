From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 4/6] libceph: wrap auth ops in wrapper functions
Date: Mon, 25 Mar 2013 09:25:04 -0500
Message-ID: <51505E40.9090105@inktank.com>
References: <1363734486-26879-1-git-send-email-sage@inktank.com> <1363734486-26879-4-git-send-email-sage@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f172.google.com ([209.85.210.172]:57086 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756878Ab3CYOZD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Mar 2013 10:25:03 -0400
Received: by mail-ia0-f172.google.com with SMTP id l29so5487911iag.17
        for <ceph-devel@vger.kernel.org>; Mon, 25 Mar 2013 07:25:02 -0700 (PDT)
In-Reply-To: <1363734486-26879-4-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 03/19/2013 06:08 PM, Sage Weil wrote:
> Use wrapper functions that check whether the auth op exists so that callers
> do not need a bunch of conditional checks.  Simplifies the external
> interface.
> 
> Signed-off-by: Sage Weil <sage@inktank.com>

You know I like this...  It kind of modifies one or two
earlier suggestions.

My only minor suggestion is that the wrappers could be
inlined in "ceph/auth.h" since they're just checking
null pointers.

Apparently if a non-existent verify_authorizer_reply method implies
success.  (This answers the question in the deleted XXX comment.)
I suppose this is reasonable, if you don't have a verifier then you
get what you deserve.

Reviewed-by: Alex Elder <elder@inktank.com>

> ---
>  fs/ceph/mds_client.c      |   26 ++++++++++++-------------
>  include/linux/ceph/auth.h |   13 +++++++++++++
>  net/ceph/auth.c           |   47 +++++++++++++++++++++++++++++++++++++++++++++
>  net/ceph/auth_x.c         |    1 -
>  net/ceph/mon_client.c     |    7 +++----
>  net/ceph/osd_client.c     |   26 +++++++++----------------
>  6 files changed, 84 insertions(+), 36 deletions(-)
> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 75cca49..c07ab3c 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -365,9 +365,9 @@ void ceph_put_mds_session(struct ceph_mds_session *s)
>  	     atomic_read(&s->s_ref), atomic_read(&s->s_ref)-1);
>  	if (atomic_dec_and_test(&s->s_ref)) {
>  		if (s->s_auth.authorizer)
> -		     s->s_mdsc->fsc->client->monc.auth->ops->destroy_authorizer(
> -			     s->s_mdsc->fsc->client->monc.auth,
> -			     s->s_auth.authorizer);
> +			ceph_auth_destroy_authorizer(
> +				s->s_mdsc->fsc->client->monc.auth,
> +				s->s_auth.authorizer);
>  		kfree(s);
>  	}
>  }
> @@ -3439,18 +3439,17 @@ static struct ceph_auth_handshake *get_authorizer(struct ceph_connection *con,
>  	struct ceph_auth_handshake *auth = &s->s_auth;
>  
>  	if (force_new && auth->authorizer) {
> -		if (ac->ops && ac->ops->destroy_authorizer)
> -			ac->ops->destroy_authorizer(ac, auth->authorizer);
> +		ceph_auth_destroy_authorizer(ac, auth->authorizer);
>  		auth->authorizer = NULL;
>  	}
> -	if (!auth->authorizer && ac->ops && ac->ops->create_authorizer) {
> -		int ret = ac->ops->create_authorizer(ac, CEPH_ENTITY_TYPE_MDS,
> -						     auth);
> +	if (!auth->authorizer) {
> +		int ret = ceph_auth_create_authorizer(ac, CEPH_ENTITY_TYPE_MDS,
> +						      auth);
>  		if (ret)
>  			return ERR_PTR(ret);
> -	} else if (ac->ops && ac->ops_update_authorizer) {
> -		int ret = ac->ops->update_authorizer(ac, CEPH_ENTITY_TYPE_MDS,
> -						     auth);
> +	} else {
> +		int ret = ceph_auth_update_authorizer(ac, CEPH_ENTITY_TYPE_MDS,
> +						      auth);
>  		if (ret)
>  			return ERR_PTR(ret);
>  	}
> @@ -3466,7 +3465,7 @@ static int verify_authorizer_reply(struct ceph_connection *con, int len)
>  	struct ceph_mds_client *mdsc = s->s_mdsc;
>  	struct ceph_auth_client *ac = mdsc->fsc->client->monc.auth;
>  
> -	return ac->ops->verify_authorizer_reply(ac, s->s_auth.authorizer, len);
> +	return ceph_auth_verify_authorizer_reply(ac, s->s_auth.authorizer, len);
>  }
>  
>  static int invalidate_authorizer(struct ceph_connection *con)
> @@ -3475,8 +3474,7 @@ static int invalidate_authorizer(struct ceph_connection *con)
>  	struct ceph_mds_client *mdsc = s->s_mdsc;
>  	struct ceph_auth_client *ac = mdsc->fsc->client->monc.auth;
>  
> -	if (ac->ops->invalidate_authorizer)
> -		ac->ops->invalidate_authorizer(ac, CEPH_ENTITY_TYPE_MDS);
> +	ceph_auth_invalidate_authorizer(ac, CEPH_ENTITY_TYPE_MDS);
>  
>  	return ceph_monc_validate_auth(&mdsc->fsc->client->monc);
>  }
> diff --git a/include/linux/ceph/auth.h b/include/linux/ceph/auth.h
> index 73e973e..c9c3b3a 100644
> --- a/include/linux/ceph/auth.h
> +++ b/include/linux/ceph/auth.h
> @@ -97,5 +97,18 @@ extern int ceph_build_auth(struct ceph_auth_client *ac,
>  		    void *msg_buf, size_t msg_len);
>  
>  extern int ceph_auth_is_authenticated(struct ceph_auth_client *ac);
> +extern int ceph_auth_create_authorizer(struct ceph_auth_client *ac,
> +				       int peer_type,
> +				       struct ceph_auth_handshake *auth);
> +extern void ceph_auth_destroy_authorizer(struct ceph_auth_client *ac,
> +					 struct ceph_authorizer *a);
> +extern int ceph_auth_update_authorizer(struct ceph_auth_client *ac,
> +				       int peer_type,
> +				       struct ceph_auth_handshake *a);
> +extern int ceph_auth_verify_authorizer_reply(struct ceph_auth_client *ac,
> +					     struct ceph_authorizer *a,
> +					     size_t len);
> +extern void ceph_auth_invalidate_authorizer(struct ceph_auth_client *ac,
> +					    int peer_type);
>  
>  #endif
> diff --git a/net/ceph/auth.c b/net/ceph/auth.c
> index b4bf4ac..a22de54 100644
> --- a/net/ceph/auth.c
> +++ b/net/ceph/auth.c
> @@ -257,3 +257,50 @@ int ceph_auth_is_authenticated(struct ceph_auth_client *ac)
>  		return 0;
>  	return ac->ops->is_authenticated(ac);
>  }
> +EXPORT_SYMBOL(ceph_auth_is_authenticated);
> +
> +int ceph_auth_create_authorizer(struct ceph_auth_client *ac,
> +				int peer_type,
> +				struct ceph_auth_handshake *auth)
> +{
> +	if (ac->ops && ac->ops->create_authorizer)
> +		return ac->ops->create_authorizer(ac, peer_type, auth);
> +	return 0;
> +}
> +EXPORT_SYMBOL(ceph_auth_create_authorizer);
> +
> +void ceph_auth_destroy_authorizer(struct ceph_auth_client *ac,
> +				  struct ceph_authorizer *a)
> +{
> +	if (ac->ops && ac->ops->destroy_authorizer)
> +		ac->ops->destroy_authorizer(ac, a);
> +}
> +EXPORT_SYMBOL(ceph_auth_destroy_authorizer);
> +
> +int ceph_auth_update_authorizer(struct ceph_auth_client *ac,
> +				int peer_type,
> +				struct ceph_auth_handshake *a)
> +{
> +	int ret = 0;
> +
> +	if (ac->ops && ac->ops->update_authorizer)
> +		ret = ac->ops->update_authorizer(ac, peer_type, a);
> +	return ret;
> +}
> +EXPORT_SYMBOL(ceph_auth_update_authorizer);
> +
> +int ceph_auth_verify_authorizer_reply(struct ceph_auth_client *ac,
> +				      struct ceph_authorizer *a, size_t len)
> +{
> +	if (ac->ops && ac->ops->verify_authorizer_reply)
> +		return ac->ops->verify_authorizer_reply(ac, a, len);
> +	return 0;
> +}
> +EXPORT_SYMBOL(ceph_auth_verify_authorizer_reply);
> +
> +void ceph_auth_invalidate_authorizer(struct ceph_auth_client *ac, int peer_type)
> +{
> +	if (ac->ops && ac->ops->invalidate_authorizer)
> +		ac->ops->invalidate_authorizer(ac, peer_type);
> +}
> +EXPORT_SYMBOL(ceph_auth_invalidate_authorizer);
> diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
> index 2d59815..96238ba 100644
> --- a/net/ceph/auth_x.c
> +++ b/net/ceph/auth_x.c
> @@ -562,7 +562,6 @@ static int ceph_x_update_authorizer(
>  {
>  	struct ceph_x_authorizer *au;
>  	struct ceph_x_ticket_handler *th;
> -	int ret;
>  
>  	th = get_ticket_handler(ac, peer_type);
>  	if (IS_ERR(th))
> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> index aef5b10..1fe25cd 100644
> --- a/net/ceph/mon_client.c
> +++ b/net/ceph/mon_client.c
> @@ -737,7 +737,7 @@ static void delayed_work(struct work_struct *work)
>  
>  		__validate_auth(monc);
>  
> -		if (monc->auth->ops->is_authenticated(monc->auth))
> +		if (ceph_auth_is_authenticated(monc->auth))
>  			__send_subscribe(monc);
>  	}
>  	__schedule_delayed(monc);
> @@ -892,8 +892,7 @@ static void handle_auth_reply(struct ceph_mon_client *monc,
>  
>  	mutex_lock(&monc->mutex);
>  	had_debugfs_info = have_debugfs_info(monc);
> -	if (monc->auth->ops)
> -		was_auth = monc->auth->ops->is_authenticated(monc->auth);
> +	was_auth = ceph_auth_is_authenticated(monc->auth);
>  	monc->pending_auth = 0;
>  	ret = ceph_handle_auth_reply(monc->auth, msg->front.iov_base,
>  				     msg->front.iov_len,
> @@ -904,7 +903,7 @@ static void handle_auth_reply(struct ceph_mon_client *monc,
>  		wake_up_all(&monc->client->auth_wq);
>  	} else if (ret > 0) {
>  		__send_prepared_auth_request(monc, ret);
> -	} else if (!was_auth && monc->auth->ops->is_authenticated(monc->auth)) {
> +	} else if (!was_auth && ceph_auth_is_authenticated(monc->auth)) {
>  		dout("authenticated, starting session\n");
>  
>  		monc->client->msgr.inst.name.type = CEPH_ENTITY_TYPE_CLIENT;
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 5ef24e3..7041906 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -666,8 +666,7 @@ static void put_osd(struct ceph_osd *osd)
>  	if (atomic_dec_and_test(&osd->o_ref) && osd->o_auth.authorizer) {
>  		struct ceph_auth_client *ac = osd->o_osdc->client->monc.auth;
>  
> -		if (ac->ops && ac->ops->destroy_authorizer)
> -			ac->ops->destroy_authorizer(ac, osd->o_auth.authorizer);
> +		ceph_auth_destroy_authorizer(ac, osd->o_auth.authorizer);
>  		kfree(osd);
>  	}
>  }
> @@ -2211,17 +2210,16 @@ static struct ceph_auth_handshake *get_authorizer(struct ceph_connection *con,
>  	struct ceph_auth_handshake *auth = &o->o_auth;
>  
>  	if (force_new && auth->authorizer) {
> -		if (ac->ops && ac->ops->destroy_authorizer)
> -			ac->ops->destroy_authorizer(ac, auth->authorizer);
> +		ceph_auth_destroy_authorizer(ac, auth->authorizer);
>  		auth->authorizer = NULL;
>  	}
> -	if (!auth->authorizer && ac->ops && ac->ops->create_authorizer) {
> -		int ret = ac->ops->create_authorizer(ac, CEPH_ENTITY_TYPE_OSD,
> -							auth);
> +	if (!auth->authorizer) {
> +		int ret = ceph_auth_create_authorizer(ac, CEPH_ENTITY_TYPE_OSD,
> +						      auth);
>  		if (ret)
>  			return ERR_PTR(ret);
> -	} else if (ac->ops && ac->ops->update_authorizer) {
> -		int ret = ac->ops->update_authorizer(ac, CEPH_ENTITY_TYPE_OSD,
> +	} else {
> +		int ret = ceph_auth_update_authorizer(ac, CEPH_ENTITY_TYPE_OSD,
>  						     auth);
>  		if (ret)
>  			return ERR_PTR(ret);
> @@ -2238,11 +2236,7 @@ static int verify_authorizer_reply(struct ceph_connection *con, int len)
>  	struct ceph_osd_client *osdc = o->o_osdc;
>  	struct ceph_auth_client *ac = osdc->client->monc.auth;
>  
> -	/*
> -	 * XXX If ac->ops or ac->ops->verify_authorizer_reply is null,
> -	 * XXX which do we do:  succeed or fail?
> -	 */
> -	return ac->ops->verify_authorizer_reply(ac, o->o_auth.authorizer, len);
> +	return ceph_auth_verify_authorizer_reply(ac, o->o_auth.authorizer, len);
>  }
>  
>  static int invalidate_authorizer(struct ceph_connection *con)
> @@ -2251,9 +2245,7 @@ static int invalidate_authorizer(struct ceph_connection *con)
>  	struct ceph_osd_client *osdc = o->o_osdc;
>  	struct ceph_auth_client *ac = osdc->client->monc.auth;
>  
> -	if (ac->ops && ac->ops->invalidate_authorizer)
> -		ac->ops->invalidate_authorizer(ac, CEPH_ENTITY_TYPE_OSD);
> -
> +	ceph_auth_invalidate_authorizer(ac, CEPH_ENTITY_TYPE_OSD);
>  	return ceph_monc_validate_auth(&osdc->client->monc);
>  }
>  
> 

