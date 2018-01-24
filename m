From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH] ceph: try to allocate enough memory for reserved caps
Date: Wed, 24 Jan 2018 22:08:47 +0800
Message-ID: <0F6DDFF0-6066-4C46-8618-EB9CFEBE3F15@redhat.com>
References: <1516800273-24017-1-git-send-email-zhang.david2011@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53088 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933829AbeAXOIw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 24 Jan 2018 09:08:52 -0500
In-Reply-To: <1516800273-24017-1-git-send-email-zhang.david2011@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zhi Zhang <zhang.david2011@gmail.com>
Cc: ceph-devel@vger.kernel.org



> On 24 Jan 2018, at 21:24, Zhi Zhang <zhang.david2011@gmail.com> wrote:
> 
> ceph_reserve_caps may not reserve enough caps under high memory
> pressure, but it saved the needed caps number that expected to
> be reserved. When getting caps, crash would happen due to number
> mismatch.
> 
> Now we will try to trim more caps when failing to allocate memory
> for caps need to be reserved, then try again. If still failing to
> allocate memory, return ENOMEM.
> 
> Signed-off-by: Zhi Zhang <zhang.david2011@gmail.com>
> ---
> fs/ceph/caps.c       | 62 +++++++++++++++++++++++++++++++++++++++++++++-------
> fs/ceph/mds_client.c | 24 ++++++++++++++------
> fs/ceph/mds_client.h |  3 +++
> fs/ceph/super.h      |  2 +-
> 4 files changed, 75 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index a14b2c9..c25941b 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -154,13 +154,19 @@ void ceph_adjust_min_caps(struct ceph_mds_client *mdsc, int delta)
> 	spin_unlock(&mdsc->caps_list_lock);
> }
> 
> -void ceph_reserve_caps(struct ceph_mds_client *mdsc,
> +/*
> + * Called under mdsc->mutex.
> + */
> +int ceph_reserve_caps(struct ceph_mds_client *mdsc,
> 		      struct ceph_cap_reservation *ctx, int need)
> {
> -	int i;
> +	int i, j;
> 	struct ceph_cap *cap;
> 	int have;
> 	int alloc = 0;
> +	int max_caps;
> +	bool trimmed = false;
> +	struct ceph_mds_session *s;
> 	LIST_HEAD(newcaps);
> 
> 	dout("reserve caps ctx=%p need=%d\n", ctx, need);
> @@ -179,16 +185,38 @@ void ceph_reserve_caps(struct ceph_mds_client *mdsc,
> 	spin_unlock(&mdsc->caps_list_lock);
> 
> 	for (i = have; i < need; i++) {
> +retry:
> 		cap = kmem_cache_alloc(ceph_cap_cachep, GFP_NOFS);
> -		if (!cap)
> -			break;
> +		if (!cap) {
> +			if (!trimmed) {
> +				for (j = 0; j < mdsc->max_sessions; j++) {
> +					s = __ceph_lookup_mds_session(mdsc, j);
> +					if (!s)
> +						continue;
> +					mutex_unlock(&mdsc->mutex);
> +
> +					// trim needed caps to free memory
> +					mutex_lock(&s->s_mutex);
> +					max_caps = s->s_nr_caps - (need - i);
> +					ceph_trim_caps(mdsc, s, max_caps);
> +					mutex_unlock(&s->s_mutex);
> +
> +					ceph_put_mds_session(s);
> +					mutex_lock(&mdsc->mutex);
> +				}
> +				trimmed = true;
> +				goto retry;
> +			} else {
> +				pr_warn("reserve caps ctx=%p ENOMEM "
> +					"need=%d got=%d\n",
> +					ctx, need, have + alloc);
> +				goto out_nomem;
> +			}
> +		}
> 		list_add(&cap->caps_item, &newcaps);
> 		alloc++;
> 	}
> -	/* we didn't manage to reserve as much as we needed */
> -	if (have + alloc != need)
> -		pr_warn("reserve caps ctx=%p ENOMEM need=%d got=%d\n",
> -			ctx, need, have + alloc);
> +	BUG_ON(have + alloc != need);
> 
> 	spin_lock(&mdsc->caps_list_lock);
> 	mdsc->caps_total_count += alloc;
> @@ -204,6 +232,24 @@ void ceph_reserve_caps(struct ceph_mds_client *mdsc,
> 	dout("reserve caps ctx=%p %d = %d used + %d resv + %d avail\n",
> 	     ctx, mdsc->caps_total_count, mdsc->caps_use_count,
> 	     mdsc->caps_reserve_count, mdsc->caps_avail_count);
> +	return 0;
> +
> +out_nomem:
> +	while (!list_empty(&newcaps)) {
> +		cap = list_first_entry(&newcaps,
> +				struct ceph_cap, caps_item);
> +		list_del(&cap->caps_item);
> +		kmem_cache_free(ceph_cap_cachep, cap);
> +	}
> +
> +	spin_lock(&mdsc->caps_list_lock);
> +	mdsc->caps_avail_count += have;
> +	mdsc->caps_reserve_count -= have;
> +	BUG_ON(mdsc->caps_total_count != mdsc->caps_use_count +
> +					 mdsc->caps_reserve_count +
> +					 mdsc->caps_avail_count);
> +	spin_unlock(&mdsc->caps_list_lock);
> +	return -ENOMEM;
> }
> 
> int ceph_unreserve_caps(struct ceph_mds_client *mdsc,
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 1b46825..8d74472 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -604,10 +604,20 @@ static void __register_request(struct ceph_mds_client *mdsc,
> 			       struct ceph_mds_request *req,
> 			       struct inode *dir)
> {
> +	int ret = 0;
> +
> 	req->r_tid = ++mdsc->last_tid;
> -	if (req->r_num_caps)
> -		ceph_reserve_caps(mdsc, &req->r_caps_reservation,
> -				  req->r_num_caps);
> +	if (req->r_num_caps) {
> +		ret = ceph_reserve_caps(mdsc, &req->r_caps_reservation,
> +					req->r_num_caps);
> +		if (ret) {
> +			pr_err("__register_request %p "
> +			       "failed to reserve caps: %d\n", req, ret);
> +			// set req->r_err to fail early from __do_request
> +			req->r_err = ret;
> +			return;
> +		}
> +	}
> 	dout("__register_request %p tid %lld\n", req, req->r_tid);
> 	ceph_mdsc_get_request(req);
> 	insert_request(&mdsc->request_tree, req);
> @@ -1545,9 +1555,9 @@ static int trim_caps_cb(struct inode *inode, struct ceph_cap *cap, void *arg)
> /*
>  * Trim session cap count down to some max number.
>  */
> -static int trim_caps(struct ceph_mds_client *mdsc,
> -		     struct ceph_mds_session *session,
> -		     int max_caps)
> +int ceph_trim_caps(struct ceph_mds_client *mdsc,
> +		   struct ceph_mds_session *session,
> +		   int max_caps)
> {
> 	int trim_caps = session->s_nr_caps - max_caps;
> 
> @@ -2773,7 +2783,7 @@ static void handle_session(struct ceph_mds_session *session,
> 		break;
> 
> 	case CEPH_SESSION_RECALL_STATE:
> -		trim_caps(mdsc, session, le32_to_cpu(h->max_caps));
> +		ceph_trim_caps(mdsc, session, le32_to_cpu(h->max_caps));
> 		break;
> 
> 	case CEPH_SESSION_FLUSHMSG:
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 837ac4b..71e3b78 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -444,4 +444,7 @@ extern void ceph_mdsc_handle_fsmap(struct ceph_mds_client *mdsc,
> extern void ceph_mdsc_open_export_target_sessions(struct ceph_mds_client *mdsc,
> 					  struct ceph_mds_session *session);
> 
> +extern int ceph_trim_caps(struct ceph_mds_client *mdsc,
> +			  struct ceph_mds_session *session,
> +			  int max_caps);
> #endif
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 2beeec0..e5fee4f 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -648,7 +648,7 @@ static inline int __ceph_caps_wanted(struct ceph_inode_info *ci)
> extern void ceph_caps_init(struct ceph_mds_client *mdsc);
> extern void ceph_caps_finalize(struct ceph_mds_client *mdsc);
> extern void ceph_adjust_min_caps(struct ceph_mds_client *mdsc, int delta);
> -extern void ceph_reserve_caps(struct ceph_mds_client *mdsc,
> +extern int ceph_reserve_caps(struct ceph_mds_client *mdsc,
> 			     struct ceph_cap_reservation *ctx, int need);
> extern int ceph_unreserve_caps(struct ceph_mds_client *mdsc,
> 			       struct ceph_cap_reservation *ctx);
> -- 
> 1.8.3.1
> 

Applied, Thanks

Yan, Zheng


