From: Luis Henriques <lhenriques@suse.com>
Subject: Re: [PATCH 2/5] ceph: allow connecting to mds whose rank >=
 mdsmap::m_max_mds
Date: Wed, 5 Apr 2017 23:47:42 +0100
Message-ID: <20170405224742.mgwijfvaxvvvcfdy@hermes.olymp>
References: <20170405013019.5032-1-zyan@redhat.com>
 <20170405013019.5032-2-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47158 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752664AbdDEWrq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 5 Apr 2017 18:47:46 -0400
Content-Disposition: inline
In-Reply-To: <20170405013019.5032-2-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: ceph-devel@vger.kernel.org, jlayton@redhat.com

On Wed, Apr 05, 2017 at 09:30:16AM +0800, Yan, Zheng wrote:
> mdsmap::m_max_mds is the expected count of active mds. It's not the
> max rank of active mds. User can decrease mdsmap::m_max_mds, but does
> not stop mds whose rank >= mdsmap::m_max_mds.
> 
> Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
> ---
>  fs/ceph/debugfs.c           | 23 +++++++++++------------
>  fs/ceph/mds_client.c        | 10 +++++-----
>  fs/ceph/mdsmap.c            | 44 +++++++++++++++++++++++++++++++++++++-------
>  include/linux/ceph/mdsmap.h |  7 ++++---
>  4 files changed, 57 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
> index f2ae393..1ff62ff 100644
> --- a/fs/ceph/debugfs.c
> +++ b/fs/ceph/debugfs.c
> @@ -22,20 +22,19 @@ static int mdsmap_show(struct seq_file *s, void *p)
>  {
>  	int i;
>  	struct ceph_fs_client *fsc = s->private;
> +	struct ceph_mdsmap *mdsmap = fsc->mdsc->mdsmap;
>  
> -	if (fsc->mdsc == NULL || fsc->mdsc->mdsmap == NULL)
> +	if (fsc->mdsc == NULL || mdsmap == NULL)

Checking fsc->mdsc for NULL should be done before initializing mdsmap,
otherwise it's a bit late.

>  		return 0;
> -	seq_printf(s, "epoch %d\n", fsc->mdsc->mdsmap->m_epoch);
> -	seq_printf(s, "root %d\n", fsc->mdsc->mdsmap->m_root);
> -	seq_printf(s, "session_timeout %d\n",
> -		       fsc->mdsc->mdsmap->m_session_timeout);
> -	seq_printf(s, "session_autoclose %d\n",
> -		       fsc->mdsc->mdsmap->m_session_autoclose);
> -	for (i = 0; i < fsc->mdsc->mdsmap->m_max_mds; i++) {
> -		struct ceph_entity_addr *addr =
> -			&fsc->mdsc->mdsmap->m_info[i].addr;
> -		int state = fsc->mdsc->mdsmap->m_info[i].state;
> -
> +	seq_printf(s, "epoch %d\n", mdsmap->m_epoch);
> +	seq_printf(s, "root %d\n", mdsmap->m_root);
> +	seq_printf(s, "root %d\n", mdsmap->m_root);

Duplicated line.

Cheers,
--
Luís


> +	seq_printf(s, "max_mds %d\n", mdsmap->m_max_mds);
> +	seq_printf(s, "session_timeout %d\n", mdsmap->m_session_timeout);
> +	seq_printf(s, "session_autoclose %d\n", mdsmap->m_session_autoclose);
> +	for (i = 0; i < mdsmap->m_num_mds; i++) {
> +		struct ceph_entity_addr *addr = &mdsmap->m_info[i].addr;
> +		int state = mdsmap->m_info[i].state;
>  		seq_printf(s, "\tmds%d\t%s\t(%s)\n", i,
>  			       ceph_pr_addr(&addr->in_addr),
>  			       ceph_mds_state_name(state));
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 820bf0f..163f0d3 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -441,7 +441,7 @@ static struct ceph_mds_session *register_session(struct ceph_mds_client *mdsc,
>  {
>  	struct ceph_mds_session *s;
>  
> -	if (mds >= mdsc->mdsmap->m_max_mds)
> +	if (mds >= mdsc->mdsmap->m_num_mds)
>  		return ERR_PTR(-EINVAL);
>  
>  	s = kzalloc(sizeof(*s), GFP_NOFS);
> @@ -1004,7 +1004,7 @@ static void __open_export_target_sessions(struct ceph_mds_client *mdsc,
>  	struct ceph_mds_session *ts;
>  	int i, mds = session->s_mds;
>  
> -	if (mds >= mdsc->mdsmap->m_max_mds)
> +	if (mds >= mdsc->mdsmap->m_num_mds)
>  		return;
>  
>  	mi = &mdsc->mdsmap->m_info[mds];
> @@ -3127,7 +3127,7 @@ static void check_new_map(struct ceph_mds_client *mdsc,
>  	dout("check_new_map new %u old %u\n",
>  	     newmap->m_epoch, oldmap->m_epoch);
>  
> -	for (i = 0; i < oldmap->m_max_mds && i < mdsc->max_sessions; i++) {
> +	for (i = 0; i < oldmap->m_num_mds && i < mdsc->max_sessions; i++) {
>  		if (mdsc->sessions[i] == NULL)
>  			continue;
>  		s = mdsc->sessions[i];
> @@ -3141,7 +3141,7 @@ static void check_new_map(struct ceph_mds_client *mdsc,
>  		     ceph_mdsmap_is_laggy(newmap, i) ? " (laggy)" : "",
>  		     ceph_session_state_name(s->s_state));
>  
> -		if (i >= newmap->m_max_mds ||
> +		if (i >= newmap->m_num_mds ||
>  		    memcmp(ceph_mdsmap_get_addr(oldmap, i),
>  			   ceph_mdsmap_get_addr(newmap, i),
>  			   sizeof(struct ceph_entity_addr))) {
> @@ -3187,7 +3187,7 @@ static void check_new_map(struct ceph_mds_client *mdsc,
>  		}
>  	}
>  
> -	for (i = 0; i < newmap->m_max_mds && i < mdsc->max_sessions; i++) {
> +	for (i = 0; i < newmap->m_num_mds && i < mdsc->max_sessions; i++) {
>  		s = mdsc->sessions[i];
>  		if (!s)
>  			continue;
> diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
> index 5454e23..1a748cf 100644
> --- a/fs/ceph/mdsmap.c
> +++ b/fs/ceph/mdsmap.c
> @@ -22,11 +22,11 @@ int ceph_mdsmap_get_random_mds(struct ceph_mdsmap *m)
>  	int i;
>  
>  	/* special case for one mds */
> -	if (1 == m->m_max_mds && m->m_info[0].state > 0)
> +	if (1 == m->m_num_mds && m->m_info[0].state > 0)
>  		return 0;
>  
>  	/* count */
> -	for (i = 0; i < m->m_max_mds; i++)
> +	for (i = 0; i < m->m_num_mds; i++)
>  		if (m->m_info[i].state > 0)
>  			n++;
>  	if (n == 0)
> @@ -135,8 +135,9 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end)
>  	m->m_session_autoclose = ceph_decode_32(p);
>  	m->m_max_file_size = ceph_decode_64(p);
>  	m->m_max_mds = ceph_decode_32(p);
> +	m->m_num_mds = m->m_max_mds;
>  
> -	m->m_info = kcalloc(m->m_max_mds, sizeof(*m->m_info), GFP_NOFS);
> +	m->m_info = kcalloc(m->m_num_mds, sizeof(*m->m_info), GFP_NOFS);
>  	if (m->m_info == NULL)
>  		goto nomem;
>  
> @@ -207,9 +208,20 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end)
>  		     ceph_pr_addr(&addr.in_addr),
>  		     ceph_mds_state_name(state));
>  
> -		if (mds < 0 || mds >= m->m_max_mds || state <= 0)
> +		if (mds < 0 || state <= 0)
>  			continue;
>  
> +		if (mds >= m->m_num_mds) {
> +			int new_num = max(mds + 1, m->m_num_mds * 2);
> +			void *new_m_info = krealloc(m->m_info,
> +						new_num * sizeof(*m->m_info),
> +						GFP_NOFS | __GFP_ZERO);
> +			if (!new_m_info)
> +				goto nomem;
> +			m->m_info = new_m_info;
> +			m->m_num_mds = new_num;
> +		}
> +
>  		info = &m->m_info[mds];
>  		info->global_id = global_id;
>  		info->state = state;
> @@ -229,6 +241,14 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end)
>  			info->export_targets = NULL;
>  		}
>  	}
> +	if (m->m_num_mds > m->m_max_mds) {
> +		/* find max up mds */
> +		for (i = m->m_num_mds; i >= m->m_max_mds; i--) {
> +			if (i == 0 || m->m_info[i-1].state > 0)
> +				break;
> +		}
> +		m->m_num_mds = i;
> +	}
>  
>  	/* pg_pools */
>  	ceph_decode_32_safe(p, end, n, bad);
> @@ -270,12 +290,22 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end)
>  
>  		for (i = 0; i < n; i++) {
>  			s32 mds = ceph_decode_32(p);
> -			if (mds >= 0 && mds < m->m_max_mds) {
> +			if (mds >= 0 && mds < m->m_num_mds) {
>  				if (m->m_info[mds].laggy)
>  					num_laggy++;
>  			}
>  		}
>  		m->m_num_laggy = num_laggy;
> +
> +		if (n > m->m_num_mds) {
> +			void *new_m_info = krealloc(m->m_info,
> +						    n * sizeof(*m->m_info),
> +						    GFP_NOFS | __GFP_ZERO);
> +			if (!new_m_info)
> +				goto nomem;
> +			m->m_info = new_m_info;
> +		}
> +		m->m_num_mds = n;
>  	}
>  
>  	/* inc */
> @@ -341,7 +371,7 @@ void ceph_mdsmap_destroy(struct ceph_mdsmap *m)
>  {
>  	int i;
>  
> -	for (i = 0; i < m->m_max_mds; i++)
> +	for (i = 0; i < m->m_num_mds; i++)
>  		kfree(m->m_info[i].export_targets);
>  	kfree(m->m_info);
>  	kfree(m->m_data_pg_pools);
> @@ -357,7 +387,7 @@ bool ceph_mdsmap_is_cluster_available(struct ceph_mdsmap *m)
>  		return false;
>  	if (m->m_num_laggy > 0)
>  		return false;
> -	for (i = 0; i < m->m_max_mds; i++) {
> +	for (i = 0; i < m->m_num_mds; i++) {
>  		if (m->m_info[i].state == CEPH_MDS_STATE_ACTIVE)
>  			nr_active++;
>  	}
> diff --git a/include/linux/ceph/mdsmap.h b/include/linux/ceph/mdsmap.h
> index 8ed5dc5..d5f783f 100644
> --- a/include/linux/ceph/mdsmap.h
> +++ b/include/linux/ceph/mdsmap.h
> @@ -25,6 +25,7 @@ struct ceph_mdsmap {
>  	u32 m_session_autoclose;        /* seconds */
>  	u64 m_max_file_size;
>  	u32 m_max_mds;                  /* size of m_addr, m_state arrays */
> +	int m_num_mds;
>  	struct ceph_mds_info *m_info;
>  
>  	/* which object pools file data can be stored in */
> @@ -40,7 +41,7 @@ struct ceph_mdsmap {
>  static inline struct ceph_entity_addr *
>  ceph_mdsmap_get_addr(struct ceph_mdsmap *m, int w)
>  {
> -	if (w >= m->m_max_mds)
> +	if (w >= m->m_num_mds)
>  		return NULL;
>  	return &m->m_info[w].addr;
>  }
> @@ -48,14 +49,14 @@ ceph_mdsmap_get_addr(struct ceph_mdsmap *m, int w)
>  static inline int ceph_mdsmap_get_state(struct ceph_mdsmap *m, int w)
>  {
>  	BUG_ON(w < 0);
> -	if (w >= m->m_max_mds)
> +	if (w >= m->m_num_mds)
>  		return CEPH_MDS_STATE_DNE;
>  	return m->m_info[w].state;
>  }
>  
>  static inline bool ceph_mdsmap_is_laggy(struct ceph_mdsmap *m, int w)
>  {
> -	if (w >= 0 && w < m->m_max_mds)
> +	if (w >= 0 && w < m->m_num_mds)
>  		return m->m_info[w].laggy;
>  	return false;
>  }
> -- 
> 2.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
