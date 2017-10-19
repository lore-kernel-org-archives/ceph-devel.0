From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH] ceph: clean up spinlocking and list handling around
 cleanup_cap_releases
Date: Thu, 19 Oct 2017 21:46:15 +0800
Message-ID: <08ACB3AD-AFFB-4E0A-83D6-99A4678D97FE@redhat.com>
References: <20171019125358.19956-1-jlayton@kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752169AbdJSNqY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 19 Oct 2017 09:46:24 -0400
In-Reply-To: <20171019125358.19956-1-jlayton@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org



> On 19 Oct 2017, at 20:53, Jeff Layton <jlayton@kernel.org> wrote:
> 
> From: Jeff Layton <jlayton@redhat.com>
> 
> Functions that release a lock taken in a parent frame are notoriously
> hard to follow. Split cleanup_cap_releases into two functions, one to
> detach the cap releases from the session (which should be called with
> the spinlock held), and another to dispose of those caps.
> 
> Signed-off-by: Jeff Layton <jlayton@redhat.com>
> ---
> fs/ceph/mds_client.c | 34 +++++++++++++++++++++-------------
> 1 file changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index f23c820daaed..d58cb17ed491 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -1038,22 +1038,23 @@ void ceph_mdsc_open_export_target_sessions(struct ceph_mds_client *mdsc,
>  * session caps
>  */
> 
> -/* caller holds s_cap_lock, we drop it */
> -static void cleanup_cap_releases(struct ceph_mds_client *mdsc,
> -				 struct ceph_mds_session *session)
> -	__releases(session->s_cap_lock)
> +static void detach_cap_releases(struct ceph_mds_session *session,
> +				struct list_head *target)
> {
> -	LIST_HEAD(tmp_list);
> -	list_splice_init(&session->s_cap_releases, &tmp_list);
> +	lockdep_assert_held(&session->s_cap_lock);
> +
> +	list_splice_init(&session->s_cap_releases, target);
> 	session->s_num_cap_releases = 0;
> -	spin_unlock(&session->s_cap_lock);
> +	dout("dispose_cap_releases mds%d\n", session->s_mds);
> +}
> 
> -	dout("cleanup_cap_releases mds%d\n", session->s_mds);
> -	while (!list_empty(&tmp_list)) {
> +static void dispose_cap_releases(struct ceph_mds_client *mdsc,
> +				 struct list_head *dispose)
> +{
> +	while (!list_empty(dispose)) {
> 		struct ceph_cap *cap;
> 		/* zero out the in-progress message */
> -		cap = list_first_entry(&tmp_list,
> -					struct ceph_cap, session_caps);
> +		cap = list_first_entry(dispose, struct ceph_cap, session_caps);
> 		list_del(&cap->session_caps);
> 		ceph_put_cap(mdsc, cap);
> 	}
> @@ -1243,6 +1244,8 @@ static void remove_session_caps(struct ceph_mds_session *session)
> {
> 	struct ceph_fs_client *fsc = session->s_mdsc->fsc;
> 	struct super_block *sb = fsc->sb;
> +	LIST_HEAD(dispose);
> +
> 	dout("remove_session_caps on %p\n", session);
> 	iterate_session_caps(session, remove_session_caps_cb, fsc);
> 
> @@ -1277,10 +1280,12 @@ static void remove_session_caps(struct ceph_mds_session *session)
> 	}
> 
> 	// drop cap expires and unlock s_cap_lock
> -	cleanup_cap_releases(session->s_mdsc, session);
> +	detach_cap_releases(session, &dispose);
> 
> 	BUG_ON(session->s_nr_caps > 0);
> 	BUG_ON(!list_empty(&session->s_cap_flushing));
> +	spin_unlock(&session->s_cap_lock);
> +	dispose_cap_releases(session->s_mdsc, &dispose);
> }
> 
> /*
> @@ -2992,6 +2997,7 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
> 	int s_nr_caps;
> 	struct ceph_pagelist *pagelist;
> 	struct ceph_reconnect_state recon_state;
> +	LIST_HEAD(dispose);
> 
> 	pr_info("mds%d reconnect start\n", mds);
> 
> @@ -3025,7 +3031,9 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
> 	 */
> 	session->s_cap_reconnect = 1;
> 	/* drop old cap expires; we're about to reestablish that state */
> -	cleanup_cap_releases(mdsc, session);
> +	detach_cap_releases(session, &dispose);
> +	spin_unlock(&session->s_cap_lock);
> +	dispose_cap_releases(mdsc, &dispose);
> 
> 	/* trim unused caps to reduce MDS's cache rejoin time */
> 	if (mdsc->fsc->sb->s_root)
> -- 
> 2.13.6
> 

Reviewed-by: "Yan, Zheng" <zyan@redhat.com>


