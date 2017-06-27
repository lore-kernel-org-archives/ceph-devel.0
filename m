From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH] ceph: new mount option that control fscache data are
 indexed
Date: Tue, 27 Jun 2017 11:08:31 -0400
Message-ID: <1498576111.4830.6.camel@redhat.com>
References: <20170627042322.72031-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f179.google.com ([209.85.216.179]:35971 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751693AbdF0PIe (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Jun 2017 11:08:34 -0400
Received: by mail-qt0-f179.google.com with SMTP id i2so26742387qta.3
        for <ceph-devel@vger.kernel.org>; Tue, 27 Jun 2017 08:08:34 -0700 (PDT)
In-Reply-To: <20170627042322.72031-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org
Cc: milosz@adfin.com, anish_gupta@yahoo.com, dhowells@redhat.com

On Tue, 2017-06-27 at 12:23 +0800, Yan, Zheng wrote:
> Current ceph uses FSID as primary index key of fscache data. This
> allows ceph to retain cached data across remount. But this causes
> problem (kernel opps, fscache does not support sharing data) when
> a filesystem get mounted (with fscache enabled) several times.
> 
> The fix is adding a new mount option, which makes ceph use client
> ID as primary index key. Client ID is unique for each mount. For
> the old fscache mount option, only allow one fscache instance for
> each filesystem.
> 
> Signed-off-by: "Yan, Zheng" <zyan@redhat.com>

Yuck. I hope this will be well documented. An admin will have no idea
what this does otherwise.

FWIW, the kernel nfs client solves this by unifying the pagecache
between mounts. You have to explicitly disable cache sharing if you want
different cache objects ("nosharecache").

That could be done with ceph too, but it would take some restructuring.

> ---
>  fs/ceph/cache.c | 117 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
>  fs/ceph/super.c |  32 ++++++++++------
>  fs/ceph/super.h |   5 ++-
>  3 files changed, 131 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
> index 4e7421c..b4956b4 100644
> --- a/fs/ceph/cache.c
> +++ b/fs/ceph/cache.c
> @@ -35,8 +35,17 @@ struct fscache_netfs ceph_cache_netfs = {
>  	.version	= 0,
>  };
>  
> -static uint16_t ceph_fscache_session_get_key(const void *cookie_netfs_data,
> -					     void *buffer, uint16_t maxbuf)
> +static DEFINE_MUTEX(ceph_fscache_fsid_lock);
> +static LIST_HEAD(ceph_fscache_fsid_list);
> +
> +struct ceph_fscache_fsid {
> +	struct list_head list;
> +	struct fscache_cookie *fscache;
> +	struct ceph_fsid fsid;
> +};
> +
> +static uint16_t ceph_fscache_fsid_get_key(const void *cookie_netfs_data,
> +					  void *buffer, uint16_t maxbuf)
>  {
>  	const struct ceph_fs_client* fsc = cookie_netfs_data;
>  	uint16_t klen;
> @@ -52,7 +61,32 @@ static uint16_t ceph_fscache_session_get_key(const void *cookie_netfs_data,
>  static const struct fscache_cookie_def ceph_fscache_fsid_object_def = {
>  	.name		= "CEPH.fsid",
>  	.type		= FSCACHE_COOKIE_TYPE_INDEX,
> -	.get_key	= ceph_fscache_session_get_key,
> +	.get_key	= ceph_fscache_fsid_get_key,
> +};
> +
> +static uint16_t ceph_fscache_client_get_key(const void *cookie_netfs_data,
> +					    void *buffer, uint16_t maxbuf)
> +{
> +	const struct ceph_fs_client* fsc = cookie_netfs_data;
> +	const struct ceph_fsid *fsid = &fsc->client->fsid;
> +	u64 client_id = fsc->client->monc.auth->global_id;
> +	uint16_t fsid_len, key_len;
> +
> +	fsid_len = sizeof(*fsid);
> +	key_len = fsid_len + sizeof(client_id);
> +	if (key_len > maxbuf)
> +		return 0;
> +
> +	memcpy(buffer, fsid, fsid_len);
> +	memcpy(buffer + fsid_len, &client_id, sizeof(client_id));
> +
> +	return key_len;
> +}
> +
> +static const struct fscache_cookie_def ceph_fscache_client_object_def = {
> +	.name		= "CEPH.client",
> +	.type		= FSCACHE_COOKIE_TYPE_INDEX,
> +	.get_key	= ceph_fscache_client_get_key,
>  };
>  
>  int ceph_fscache_register(void)
> @@ -67,13 +101,54 @@ void ceph_fscache_unregister(void)
>  
>  int ceph_fscache_register_fs(struct ceph_fs_client* fsc)
>  {
> -	fsc->fscache = fscache_acquire_cookie(ceph_cache_netfs.primary_index,
> -					      &ceph_fscache_fsid_object_def,
> -					      fsc, true);
> -	if (!fsc->fscache)
> -		pr_err("Unable to register fsid: %p fscache cookie\n", fsc);
> +	const struct ceph_fsid *fsid = &fsc->client->fsid;
> +	struct ceph_fscache_fsid *ent;
> +	int err = 0;
> +
> +	if (fsc->mount_options->flags & CEPH_MOUNT_OPT_TMPFSCACHE) {
> +		fsc->fscache = fscache_acquire_cookie(
> +						ceph_cache_netfs.primary_index,
> +						&ceph_fscache_client_object_def,
> +						fsc, true);
> +		if (!fsc->fscache)
> +			pr_err("Unable to register fsid: %p "
> +			       "fscache cookie\n", fsc);
> +	} else {
> +		mutex_lock(&ceph_fscache_fsid_lock);
> +		list_for_each_entry(ent, &ceph_fscache_fsid_list, list) {
> +			if (!memcmp(&ent->fsid, fsid, sizeof(*fsid))) {
> +				pr_err("fscache cookie already registered "
> +				       "for fsid %pU\n", fsid);
> +				pr_err("  use tmpfsc mount option instead\n");
> +				err = -EBUSY;
> +				goto out_unlock;
> +			}
> +		}
>  
> -	return 0;
> +		ent = kzalloc(sizeof(*ent), GFP_KERNEL);
> +		if (!ent) {
> +			err = -ENOMEM;
> +			goto out_unlock;
> +		}
> +
> +		fsc->fscache = fscache_acquire_cookie(
> +						ceph_cache_netfs.primary_index,
> +						&ceph_fscache_fsid_object_def,
> +						fsc, true);
> +
> +		if (fsc->fscache) {
> +			memcpy(&ent->fsid, fsid, sizeof(*fsid));
> +			ent->fscache = fsc->fscache;
> +			list_add_tail(&ent->list, &ceph_fscache_fsid_list);
> +		} else {
> +			kfree(ent);
> +			pr_err("Unable to register fsid: %p "
> +			       "fscache cookie\n", fsc);
> +		}
> +out_unlock:
> +		mutex_unlock(&ceph_fscache_fsid_lock);
> +	}
> +	return err;
>  }
>  
>  static uint16_t ceph_fscache_inode_get_key(const void *cookie_netfs_data,
> @@ -349,7 +424,29 @@ void ceph_invalidate_fscache_page(struct inode* inode, struct page *page)
>  
>  void ceph_fscache_unregister_fs(struct ceph_fs_client* fsc)
>  {
> -	fscache_relinquish_cookie(fsc->fscache, 0);
> +	if (fscache_cookie_valid(fsc->fscache)) {
> +		if (fsc->fscache->def == &ceph_fscache_fsid_object_def) {
> +			const struct ceph_fsid *fsid = &fsc->client->fsid;
> +			struct ceph_fscache_fsid *ent, *found = NULL;
> +
> +			mutex_lock(&ceph_fscache_fsid_lock);
> +			list_for_each_entry(ent, &ceph_fscache_fsid_list, list) {
> +				if (!memcmp(&ent->fsid, fsid, sizeof(*fsid))) {
> +					found = ent;
> +					break;
> +				}
> +			}
> +			if (found) {
> +				WARN_ON_ONCE(found->fscache != fsc->fscache);
> +				list_del(&found->list);
> +				kfree(found);
> +			} else {
> +				WARN_ON_ONCE(true);
> +			}
> +			mutex_unlock(&ceph_fscache_fsid_lock);
> +		}
> +		__fscache_relinquish_cookie(fsc->fscache, 0);
> +	}
>  	fsc->fscache = NULL;
>  }
>  
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index 14e78dd..bb6dd7f 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -134,6 +134,7 @@ enum {
>  	Opt_ino32,
>  	Opt_noino32,
>  	Opt_fscache,
> +	Opt_tmpfscache,
>  	Opt_nofscache,
>  	Opt_poolperm,
>  	Opt_nopoolperm,
> @@ -170,6 +171,7 @@ static match_table_t fsopt_tokens = {
>  	{Opt_ino32, "ino32"},
>  	{Opt_noino32, "noino32"},
>  	{Opt_fscache, "fsc"},
> +	{Opt_tmpfscache, "tmpfsc"},

Maybe allowing the fsc option to take an optional argument would be
cleaner?

    fsc=tmp

That would also leave open the option to allow other flavors in the
future.


>  	{Opt_nofscache, "nofsc"},
>  	{Opt_poolperm, "poolperm"},
>  	{Opt_nopoolperm, "nopoolperm"},
> @@ -281,6 +283,10 @@ static int parse_fsopt_token(char *c, void *private)
>  	case Opt_fscache:
>  		fsopt->flags |= CEPH_MOUNT_OPT_FSCACHE;
>  		break;
> +	case Opt_tmpfscache:
> +		fsopt->flags |= CEPH_MOUNT_OPT_FSCACHE |
> +				CEPH_MOUNT_OPT_TMPFSCACHE;
> +		break;
>  	case Opt_nofscache:
>  		fsopt->flags &= ~CEPH_MOUNT_OPT_FSCACHE;
>  		break;
> @@ -475,8 +481,12 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
>  		seq_puts(m, ",noasyncreaddir");
>  	if ((fsopt->flags & CEPH_MOUNT_OPT_DCACHE) == 0)
>  		seq_puts(m, ",nodcache");
> -	if (fsopt->flags & CEPH_MOUNT_OPT_FSCACHE)
> -		seq_puts(m, ",fsc");
> +	if (fsopt->flags & CEPH_MOUNT_OPT_FSCACHE) {
> +		if (fsopt->flags & CEPH_MOUNT_OPT_TMPFSCACHE)
> +			seq_puts(m, ",tmpfsc");
> +		else
> +			seq_puts(m, ",fsc");
> +	}
>  	if (fsopt->flags & CEPH_MOUNT_OPT_NOPOOLPERM)
>  		seq_puts(m, ",nopoolperm");
>  
> @@ -597,18 +607,11 @@ static struct ceph_fs_client *create_fs_client(struct ceph_mount_options *fsopt,
>  	if (!fsc->wb_pagevec_pool)
>  		goto fail_trunc_wq;
>  
> -	/* setup fscache */
> -	if ((fsopt->flags & CEPH_MOUNT_OPT_FSCACHE) &&
> -	    (ceph_fscache_register_fs(fsc) != 0))
> -		goto fail_fscache;
> -
>  	/* caps */
>  	fsc->min_caps = fsopt->max_readdir;
>  
>  	return fsc;
>  
> -fail_fscache:
> -	ceph_fscache_unregister_fs(fsc);
>  fail_trunc_wq:
>  	destroy_workqueue(fsc->trunc_wq);
>  fail_pg_inv_wq:
> @@ -626,8 +629,6 @@ static void destroy_fs_client(struct ceph_fs_client *fsc)
>  {
>  	dout("destroy_fs_client %p\n", fsc);
>  
> -	ceph_fscache_unregister_fs(fsc);
> -
>  	destroy_workqueue(fsc->wb_wq);
>  	destroy_workqueue(fsc->pg_inv_wq);
>  	destroy_workqueue(fsc->trunc_wq);
> @@ -820,6 +821,13 @@ static struct dentry *ceph_real_mount(struct ceph_fs_client *fsc)
>  		if (err < 0)
>  			goto out;
>  
> +		/* setup fscache */
> +		if (fsc->mount_options->flags & CEPH_MOUNT_OPT_FSCACHE) {
> +			err = ceph_fscache_register_fs(fsc);
> +			if (err < 0)
> +				goto out;
> +		}
> +
>  		if (!fsc->mount_options->server_path) {
>  			path = "";
>  			dout("mount opening path \\t\n");
> @@ -1042,6 +1050,8 @@ static void ceph_kill_sb(struct super_block *s)
>  	fsc->client->extra_mon_dispatch = NULL;
>  	ceph_fs_debugfs_cleanup(fsc);
>  
> +	ceph_fscache_unregister_fs(fsc);
> +
>  	ceph_mdsc_destroy(fsc);
>  
>  	destroy_fs_client(fsc);
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index f8a0aba..21e5562 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -36,8 +36,9 @@
>  #define CEPH_MOUNT_OPT_INO32           (1<<8) /* 32 bit inos */
>  #define CEPH_MOUNT_OPT_DCACHE          (1<<9) /* use dcache for readdir etc */
>  #define CEPH_MOUNT_OPT_FSCACHE         (1<<10) /* use fscache */
> -#define CEPH_MOUNT_OPT_NOPOOLPERM      (1<<11) /* no pool permission check */
> -#define CEPH_MOUNT_OPT_MOUNTWAIT       (1<<12) /* mount waits if no mds is up */
> +#define CEPH_MOUNT_OPT_TMPFSCACHE      (1<<11) /* use temp fscache */
> +#define CEPH_MOUNT_OPT_NOPOOLPERM      (1<<12) /* no pool permission check */
> +#define CEPH_MOUNT_OPT_MOUNTWAIT       (1<<13) /* mount waits if no mds is up */
>  
>  #define CEPH_MOUNT_OPT_DEFAULT    CEPH_MOUNT_OPT_DCACHE
>  

-- 
Jeff Layton <jlayton@redhat.com>
