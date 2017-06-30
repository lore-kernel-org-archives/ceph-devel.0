From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH] ceph: new mount option that specifies fscache uniquifier
Date: Fri, 30 Jun 2017 06:44:54 -0400
Message-ID: <1498819494.27807.0.camel@redhat.com>
References: <20170628080416.95858-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:36312 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751933AbdF3Ko5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Jun 2017 06:44:57 -0400
Received: by mail-qt0-f176.google.com with SMTP id i2so95351036qta.3
        for <ceph-devel@vger.kernel.org>; Fri, 30 Jun 2017 03:44:57 -0700 (PDT)
In-Reply-To: <20170628080416.95858-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org
Cc: milosz@adfin.com, anish_gupta@yahoo.com, dhowells@redhat.com

On Wed, 2017-06-28 at 16:04 +0800, Yan, Zheng wrote:
> Current ceph uses FSID as primary index key of fscache data. This
> allows ceph to retain cached data across remount. But this causes
> problem (kernel opps, fscache does not support sharing data) when
> a filesystem get mounted several times (with fscache enabled, with
> different mount options).
> 
> The fix is adding a new mount option, which specifies uniquifier
> for fscache.
> 
> Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
> ---
>  fs/ceph/cache.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++------
>  fs/ceph/super.c | 41 +++++++++++++++++--------
>  fs/ceph/super.h |  1 +
>  3 files changed, 113 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
> index 4e7421c..fd11728 100644
> --- a/fs/ceph/cache.c
> +++ b/fs/ceph/cache.c
> @@ -35,18 +35,34 @@ struct fscache_netfs ceph_cache_netfs = {
>  	.version	= 0,
>  };
>  
> +static DEFINE_MUTEX(ceph_fscache_lock);
> +static LIST_HEAD(ceph_fscache_list);
> +
> +struct ceph_fscache_entry {
> +	struct list_head list;
> +	struct fscache_cookie *fscache;
> +	struct ceph_fsid fsid;
> +	size_t uniq_len;
> +	char uniquifier[0];
> +};
> +
>  static uint16_t ceph_fscache_session_get_key(const void *cookie_netfs_data,
>  					     void *buffer, uint16_t maxbuf)
>  {
>  	const struct ceph_fs_client* fsc = cookie_netfs_data;
> -	uint16_t klen;
> +	const char *fscache_uniq = fsc->mount_options->fscache_uniq;
> +	uint16_t fsid_len, uniq_len;
>  
> -	klen = sizeof(fsc->client->fsid);
> -	if (klen > maxbuf)
> +	fsid_len = sizeof(fsc->client->fsid);
> +	uniq_len = fscache_uniq ? strlen(fscache_uniq) : 0;
> +	if (fsid_len + uniq_len > maxbuf)
>  		return 0;
>  
> -	memcpy(buffer, &fsc->client->fsid, klen);
> -	return klen;
> +	memcpy(buffer, &fsc->client->fsid, fsid_len);
> +	if (uniq_len)
> +		memcpy(buffer + fsid_len, fscache_uniq, uniq_len);
> +
> +	return fsid_len + uniq_len;
>  }
>  
>  static const struct fscache_cookie_def ceph_fscache_fsid_object_def = {
> @@ -67,13 +83,54 @@ void ceph_fscache_unregister(void)
>  
>  int ceph_fscache_register_fs(struct ceph_fs_client* fsc)
>  {
> +	const struct ceph_fsid *fsid = &fsc->client->fsid;
> +	const char *fscache_uniq = fsc->mount_options->fscache_uniq;
> +	size_t uniq_len = fscache_uniq ? strlen(fscache_uniq) : 0;
> +	struct ceph_fscache_entry *ent;
> +	int err = 0;
> +
> +	mutex_lock(&ceph_fscache_lock);
> +	list_for_each_entry(ent, &ceph_fscache_list, list) {
> +		if (memcmp(&ent->fsid, fsid, sizeof(*fsid)))
> +			continue;
> +		if (ent->uniq_len != uniq_len)
> +			continue;
> +		if (uniq_len && memcmp(ent->uniquifier, fscache_uniq, uniq_len))
> +			continue;
> +
> +		pr_err("fscache cookie already registered for fsid %pU\n", fsid);
> +		pr_err("  use fsc=%%s mount option to specify a uniquifier\n");
> +		err = -EBUSY;
> +		goto out_unlock;
> +	}
> +
> +	ent = kzalloc(sizeof(*ent) + uniq_len, GFP_KERNEL);
> +	if (!ent) {
> +		err = -ENOMEM;
> +		goto out_unlock;
> +	}
> +
>  	fsc->fscache = fscache_acquire_cookie(ceph_cache_netfs.primary_index,
>  					      &ceph_fscache_fsid_object_def,
>  					      fsc, true);
> -	if (!fsc->fscache)
> -		pr_err("Unable to register fsid: %p fscache cookie\n", fsc);
>  
> -	return 0;
> +	if (fsc->fscache) {
> +		memcpy(&ent->fsid, fsid, sizeof(*fsid));
> +		if (uniq_len > 0) {
> +			memcpy(&ent->uniquifier, fscache_uniq, uniq_len);
> +			ent->uniq_len = uniq_len;
> +		}
> +		ent->fscache = fsc->fscache;
> +		list_add_tail(&ent->list, &ceph_fscache_list);
> +	} else {
> +		kfree(ent);
> +		pr_err("unable to register fscache cookie for fsid %pU\n",
> +		       fsid);
> +		/* all other fs ignore this error */
> +	}
> +out_unlock:
> +	mutex_unlock(&ceph_fscache_lock);
> +	return err;
>  }
>  
>  static uint16_t ceph_fscache_inode_get_key(const void *cookie_netfs_data,
> @@ -349,7 +406,24 @@ void ceph_invalidate_fscache_page(struct inode* inode, struct page *page)
>  
>  void ceph_fscache_unregister_fs(struct ceph_fs_client* fsc)
>  {
> -	fscache_relinquish_cookie(fsc->fscache, 0);
> +	if (fscache_cookie_valid(fsc->fscache)) {
> +		struct ceph_fscache_entry *ent;
> +		bool found = false;
> +
> +		mutex_lock(&ceph_fscache_lock);
> +		list_for_each_entry(ent, &ceph_fscache_list, list) {
> +			if (ent->fscache == fsc->fscache) {
> +				list_del(&ent->list);
> +				kfree(ent);
> +				found = true;
> +				break;
> +			}
> +		}
> +		WARN_ON_ONCE(!found);
> +		mutex_unlock(&ceph_fscache_lock);
> +
> +		__fscache_relinquish_cookie(fsc->fscache, 0);
> +	}
>  	fsc->fscache = NULL;
>  }
>  
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index 14e78dd..aa06a8c 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -121,6 +121,7 @@ enum {
>  	/* int args above */
>  	Opt_snapdirname,
>  	Opt_mds_namespace,
> +	Opt_fscache_uniq,
>  	Opt_last_string,
>  	/* string args above */
>  	Opt_dirstat,
> @@ -158,6 +159,7 @@ static match_table_t fsopt_tokens = {
>  	/* int args above */
>  	{Opt_snapdirname, "snapdirname=%s"},
>  	{Opt_mds_namespace, "mds_namespace=%s"},
> +	{Opt_fscache_uniq, "fsc=%s"},
>  	/* string args above */
>  	{Opt_dirstat, "dirstat"},
>  	{Opt_nodirstat, "nodirstat"},
> @@ -223,6 +225,14 @@ static int parse_fsopt_token(char *c, void *private)
>  		if (!fsopt->mds_namespace)
>  			return -ENOMEM;
>  		break;
> +	case Opt_fscache_uniq:
> +		fsopt->fscache_uniq = kstrndup(argstr[0].from,
> +					       argstr[0].to-argstr[0].from,
> +					       GFP_KERNEL);
> +		if (!fsopt->fscache_uniq)
> +			return -ENOMEM;
> +		fsopt->flags |= CEPH_MOUNT_OPT_FSCACHE;
> +		break;
>  		/* misc */
>  	case Opt_wsize:
>  		fsopt->wsize = intval;
> @@ -317,6 +327,7 @@ static void destroy_mount_options(struct ceph_mount_options *args)
>  	kfree(args->snapdir_name);
>  	kfree(args->mds_namespace);
>  	kfree(args->server_path);
> +	kfree(args->fscache_uniq);
>  	kfree(args);
>  }
>  
> @@ -350,10 +361,12 @@ static int compare_mount_options(struct ceph_mount_options *new_fsopt,
>  	ret = strcmp_null(fsopt1->mds_namespace, fsopt2->mds_namespace);
>  	if (ret)
>  		return ret;
> -
>  	ret = strcmp_null(fsopt1->server_path, fsopt2->server_path);
>  	if (ret)
>  		return ret;
> +	ret = strcmp_null(fsopt1->fscache_uniq, fsopt2->fscache_uniq);
> +	if (ret)
> +		return ret;
>  
>  	return ceph_compare_options(new_opt, fsc->client);
>  }
> @@ -475,8 +488,12 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
>  		seq_puts(m, ",noasyncreaddir");
>  	if ((fsopt->flags & CEPH_MOUNT_OPT_DCACHE) == 0)
>  		seq_puts(m, ",nodcache");
> -	if (fsopt->flags & CEPH_MOUNT_OPT_FSCACHE)
> -		seq_puts(m, ",fsc");
> +	if (fsopt->flags & CEPH_MOUNT_OPT_FSCACHE) {
> +		if (fsopt->fscache_uniq)
> +			seq_printf(m, ",fsc=%s", fsopt->fscache_uniq);
> +		else
> +			seq_puts(m, ",fsc");
> +	}
>  	if (fsopt->flags & CEPH_MOUNT_OPT_NOPOOLPERM)
>  		seq_puts(m, ",nopoolperm");
>  
> @@ -597,18 +614,11 @@ static struct ceph_fs_client *create_fs_client(struct ceph_mount_options *fsopt,
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
> @@ -626,8 +636,6 @@ static void destroy_fs_client(struct ceph_fs_client *fsc)
>  {
>  	dout("destroy_fs_client %p\n", fsc);
>  
> -	ceph_fscache_unregister_fs(fsc);
> -
>  	destroy_workqueue(fsc->wb_wq);
>  	destroy_workqueue(fsc->pg_inv_wq);
>  	destroy_workqueue(fsc->trunc_wq);
> @@ -820,6 +828,13 @@ static struct dentry *ceph_real_mount(struct ceph_fs_client *fsc)
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
> @@ -1042,6 +1057,8 @@ static void ceph_kill_sb(struct super_block *s)
>  	fsc->client->extra_mon_dispatch = NULL;
>  	ceph_fs_debugfs_cleanup(fsc);
>  
> +	ceph_fscache_unregister_fs(fsc);
> +
>  	ceph_mdsc_destroy(fsc);
>  
>  	destroy_fs_client(fsc);
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index f8a0aba..f02a222 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -73,6 +73,7 @@ struct ceph_mount_options {
>  	char *snapdir_name;   /* default ".snap" */
>  	char *mds_namespace;  /* default NULL */
>  	char *server_path;    /* default  "/" */
> +	char *fscache_uniq;   /* default NULL */
>  };
>  
>  struct ceph_fs_client {

Acked-by: Jeff Layton <jlayton@redhat.com>
