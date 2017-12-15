From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH 1/3] ceph: map snapid to anonymous bdev ID
Date: Fri, 15 Dec 2017 21:45:16 +0800
Message-ID: <8E3A0F27-EF13-4693-8AB0-033D073A6F32@redhat.com>
References: <20171215092420.7950-1-zyan@redhat.com>
 <1513344155.20336.10.camel@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45346 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932076AbdLONpW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 15 Dec 2017 08:45:22 -0500
In-Reply-To: <1513344155.20336.10.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, idryomov@gmail.com



> On 15 Dec 2017, at 21:22, Jeff Layton <jlayton@redhat.com> wrote:
> 
> On Fri, 2017-12-15 at 17:24 +0800, Yan, Zheng wrote:
>> ceph_getattr() return zero dev ID for head inodes and set dev ID to
>> snapid directly for snaphost inodes. This is not good because userspace
>> utilities may consider device ID of 0 as invalid, snapid may conflict
>> with other device's ID.
>> 
>> This patch introduces "snapids to anonymous bdev IDs" map. we create a
>> new mapping when we see a snapid for the first time. we trim unused
>> mapping after it is ilde for an hour.
>> 
>> Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
>> ---
>> fs/ceph/addr.c       |   4 +-
>> fs/ceph/inode.c      |  31 +++++++----
>> fs/ceph/mds_client.c |   8 +++
>> fs/ceph/mds_client.h |  13 +++++
>> fs/ceph/snap.c       | 148 +++++++++++++++++++++++++++++++++++++++++++++++++++
>> fs/ceph/super.h      |  13 ++++-
>> 6 files changed, 203 insertions(+), 14 deletions(-)
>> 
>> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
>> index dbf07051aacd..6f7f00a35190 100644
>> --- a/fs/ceph/addr.c
>> +++ b/fs/ceph/addr.c
>> @@ -450,8 +450,8 @@ static int ceph_readpages(struct file *file, struct address_space *mapping,
>> 		goto out;
>> 
>> 	max = fsc->mount_options->rsize >> PAGE_SHIFT;
>> -	dout("readpages %p file %p nr_pages %d max %d\n",
>> -	     inode, file, nr_pages, max);
>> +	dout("readpages %p file %p ctx %p nr_pages %d max %d\n",
>> +	     inode, file, rw_ctx, nr_pages, max);
>> 	while (!list_empty(page_list)) {
>> 		rc = start_read(inode, page_list, max);
>> 		if (rc < 0)
>> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
>> index c6ec5aa46100..76a428749981 100644
>> --- a/fs/ceph/inode.c
>> +++ b/fs/ceph/inode.c
>> @@ -542,14 +542,19 @@ void ceph_destroy_inode(struct inode *inode)
>> 	 */
>> 	if (ci->i_snap_realm) {
>> 		struct ceph_mds_client *mdsc =
>> -			ceph_sb_to_client(ci->vfs_inode.i_sb)->mdsc;
>> -		struct ceph_snap_realm *realm = ci->i_snap_realm;
>> -
>> -		dout(" dropping residual ref to snap realm %p\n", realm);
>> -		spin_lock(&realm->inodes_with_caps_lock);
>> -		list_del_init(&ci->i_snap_realm_item);
>> -		spin_unlock(&realm->inodes_with_caps_lock);
>> -		ceph_put_snap_realm(mdsc, realm);
>> +					ceph_inode_to_client(inode)->mdsc;
>> +		if (ceph_snap(inode) == CEPH_NOSNAP) {
>> +			struct ceph_snap_realm *realm = ci->i_snap_realm;
>> +			dout(" dropping residual ref to snap realm %p\n",
>> +			     realm);
>> +			spin_lock(&realm->inodes_with_caps_lock);
>> +			list_del_init(&ci->i_snap_realm_item);
>> +			spin_unlock(&realm->inodes_with_caps_lock);
>> +			ceph_put_snap_realm(mdsc, realm);
>> +		} else {
>> +			ceph_put_snapid_map(mdsc, ci->i_snapid_map);
>> +		}
>> +		ci->i_snap_realm = NULL;
>> 	}
>> 
>> 	kfree(ci->i_symlink);
>> @@ -763,6 +768,9 @@ static int fill_inode(struct inode *inode, struct page *locked_page,
>> 		pool_ns = ceph_find_or_create_string(iinfo->pool_ns_data,
>> 						     iinfo->pool_ns_len);
>> 
>> +	if (ceph_snap(inode) != CEPH_NOSNAP && !ci->i_snapid_map)
>> +		ci->i_snapid_map = ceph_get_snapid_map(mdsc, ceph_snap(inode));
>> +
>> 	spin_lock(&ci->i_ceph_lock);
>> 
>> 	/*
>> @@ -2241,10 +2249,11 @@ int ceph_getattr(const struct path *path, struct kstat *stat,
>> 	if (!err) {
>> 		generic_fillattr(inode, stat);
>> 		stat->ino = ceph_translate_ino(inode->i_sb, inode->i_ino);
>> -		if (ceph_snap(inode) != CEPH_NOSNAP)
>> -			stat->dev = ceph_snap(inode);
>> +		if (ceph_snap(inode) == CEPH_NOSNAP)
>> +			stat->dev = inode->i_sb->s_dev;
>> 		else
>> -			stat->dev = 0;
>> +			stat->dev = ci->i_snapid_map ? ci->i_snapid_map->dev : 0;
>> +
>> 		if (S_ISDIR(inode->i_mode)) {
>> 			if (ceph_test_mount_opt(ceph_sb_to_client(inode->i_sb),
>> 						RBYTES))
>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>> index 251dc44d84a0..b6e62f5d97c1 100644
>> --- a/fs/ceph/mds_client.c
>> +++ b/fs/ceph/mds_client.c
>> @@ -3504,6 +3504,8 @@ static void delayed_work(struct work_struct *work)
>> 	dout("mdsc delayed_work\n");
>> 	ceph_check_delayed_caps(mdsc);
>> 
>> +	ceph_trim_snapid_map(mdsc);
>> +
>> 	mutex_lock(&mdsc->mutex);
>> 	renew_interval = mdsc->mdsmap->m_session_timeout >> 2;
>> 	renew_caps = time_after_eq(jiffies, HZ*renew_interval +
>> @@ -3604,6 +3606,10 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
>> 	ceph_caps_init(mdsc);
>> 	ceph_adjust_min_caps(mdsc, fsc->min_caps);
>> 
>> +	spin_lock_init(&mdsc->snapid_map_lock);
>> +	mdsc->snapid_map_tree = RB_ROOT;
>> +	INIT_LIST_HEAD(&mdsc->snapid_map_lru);
>> +
>> 	init_rwsem(&mdsc->pool_perm_rwsem);
>> 	mdsc->pool_perm_tree = RB_ROOT;
>> 
>> @@ -3797,6 +3803,8 @@ void ceph_mdsc_close_sessions(struct ceph_mds_client *mdsc)
>> 	WARN_ON(!list_empty(&mdsc->cap_delay_list));
>> 	mutex_unlock(&mdsc->mutex);
>> 
>> +	ceph_cleanup_snapid_map(mdsc);
>> +
>> 	ceph_cleanup_empty_realms(mdsc);
>> 
>> 	cancel_delayed_work_sync(&mdsc->delayed_work); /* cancel timer */
>> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
>> index 837ac4b087a0..87506a8fc1c3 100644
>> --- a/fs/ceph/mds_client.h
>> +++ b/fs/ceph/mds_client.h
>> @@ -294,6 +294,15 @@ struct ceph_pool_perm {
>> 	char pool_ns[];
>> };
>> 
>> +struct ceph_snapid_map {
>> +	struct rb_node node;
>> +	struct list_head lru;
>> +	atomic_t ref;
>> +	u64 snap;
>> +	dev_t dev;
>> +	unsigned long last_used;
>> +};
>> +
>> /*
>>  * mds client state
>>  */
>> @@ -368,6 +377,10 @@ struct ceph_mds_client {
>> 	struct list_head  dentry_lru;
>> 	int		  num_dentry;
>> 
>> +	spinlock_t		snapid_map_lock;
>> +	struct rb_root		snapid_map_tree;
>> +	struct list_head	snapid_map_lru;
>> +
>> 	struct rw_semaphore     pool_perm_rwsem;
>> 	struct rb_root		pool_perm_tree;
>> 
>> diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
>> index 8a2ca41e4b97..0af9ea832f03 100644
>> --- a/fs/ceph/snap.c
>> +++ b/fs/ceph/snap.c
>> @@ -979,3 +979,151 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
>> 		up_write(&mdsc->snap_rwsem);
>> 	return;
>> }
>> +
>> +struct ceph_snapid_map* ceph_get_snapid_map(struct ceph_mds_client *mdsc,
>> +					    u64 snap)
>> +{
>> +	struct ceph_snapid_map *sm, *exist;
>> +	struct rb_node **p, *parent;
>> +	int ret;
>> +
>> +	exist = NULL;
>> +	spin_lock(&mdsc->snapid_map_lock);
>> +	p = &mdsc->snapid_map_tree.rb_node;
>> +	while (*p) {
>> +		exist = rb_entry(*p, struct ceph_snapid_map, node);
>> +		if (snap > exist->snap) {
>> +			p = &(*p)->rb_left;
>> +		} else if (snap < exist->snap) {
>> +			p = &(*p)->rb_right;
>> +		} else {
>> +			atomic_inc(&exist->ref);
>> +			list_del_init(&exist->lru);
>> +			break;
>> +		}
>> +		exist = NULL;
>> +	}
>> +	spin_unlock(&mdsc->snapid_map_lock);
>> +	if (exist) {
>> +		dout("found snapid map %llx -> %x\n", exist->snap, exist->dev);
>> +		return exist;
>> +	}
>> +
>> +	sm = kmalloc(sizeof(*sm), GFP_NOFS);
>> +	if (!sm)
>> +		return NULL;
>> +
>> +	ret = get_anon_bdev(&sm->dev);
>> +	if (ret < 0) {
>> +		kfree(sm);
>> +		return NULL;
>> +	}	
>> +
>> +	INIT_LIST_HEAD(&sm->lru);
>> +	atomic_set(&sm->ref, 1);
>> +	sm->snap = snap;
>> +
>> +	exist = NULL;
>> +	parent = NULL;
>> +	p = &mdsc->snapid_map_tree.rb_node;
>> +	spin_lock(&mdsc->snapid_map_lock);
>> +	while (*p) {
>> +		parent = *p;
>> +		exist = rb_entry(*p, struct ceph_snapid_map, node);
>> +		if (snap > exist->snap)
>> +			p = &(*p)->rb_left;
>> +		else if (snap < exist->snap)
>> +			p = &(*p)->rb_right;
>> +		else
>> +			break;
>> +		exist = NULL;
>> +	}
>> +	if (exist) {
>> +		atomic_inc(&exist->ref);
>> +		list_del_init(&exist->lru);
>> +	} else {
>> +		rb_link_node(&sm->node, parent, p);
>> +		rb_insert_color(&sm->node, &mdsc->snapid_map_tree);
>> +	}
>> +	spin_unlock(&mdsc->snapid_map_lock);
>> +	if (exist) {
>> +		free_anon_bdev(sm->dev);
>> +		kfree(sm);
>> +		dout("found snapid map %llx -> %x\n", exist->snap, exist->dev);
>> +		return exist;
>> +	}
>> +		
>> +	dout("create snapid map %llx -> %x\n", sm->snap, sm->dev);
>> +	return sm;
>> +}
>> +
>> +void ceph_put_snapid_map(struct ceph_mds_client* mdsc,
>> +			 struct ceph_snapid_map *sm)
>> +{
>> +	if (!sm)
>> +		return;
>> +	if (atomic_dec_and_lock(&sm->ref, &mdsc->snapid_map_lock)) {
>> +		sm->last_used = jiffies;
>> +		list_add_tail(&sm->lru, &mdsc->snapid_map_lru);
>> +		spin_unlock(&mdsc->snapid_map_lock);
>> +	}
>> +}
>> +
>> +void ceph_trim_snapid_map(struct ceph_mds_client *mdsc)
>> +{
>> +	struct ceph_snapid_map *sm;
>> +	unsigned long now;
>> +	LIST_HEAD(to_free);
>> +
>> +	/* unused map expires after an hour */
>> +	static unsigned timeout = 60 * 60 * HZ;
>> +
>> +	spin_lock(&mdsc->snapid_map_lock);
>> +	now = jiffies;
>> +
>> +	while (!list_empty(&mdsc->snapid_map_lru)) {
>> +		sm = list_first_entry(&mdsc->snapid_map_lru,
>> +				      struct ceph_snapid_map, lru);
>> +		if (time_after(sm->last_used + timeout, now))
>> +			break;
>> +
>> +		rb_erase(&sm->node, &mdsc->snapid_map_tree);
>> +		list_move(&sm->lru, &to_free);
>> +	}
>> +	spin_unlock(&mdsc->snapid_map_lock);
>> +
>> +	while (!list_empty(&to_free)) {
>> +		sm = list_first_entry(&to_free, struct ceph_snapid_map, lru);
>> +		list_del(&sm->lru);
>> +		dout("trim snapid map %llx -> %x\n", sm->snap, sm->dev);
>> +		free_anon_bdev(sm->dev);
>> +		kfree(sm);
>> +	}
>> +}
>> +
>> +void ceph_cleanup_snapid_map(struct ceph_mds_client *mdsc)
>> +{
>> +	struct ceph_snapid_map *sm;
>> +	struct rb_node *p;
>> +	LIST_HEAD(to_free);
>> +
>> +	spin_lock(&mdsc->snapid_map_lock);
>> +	while ((p = rb_first(&mdsc->snapid_map_tree))) {
>> +		sm = rb_entry(p, struct ceph_snapid_map, node);
>> +		rb_erase(p, &mdsc->snapid_map_tree);
>> +		list_move(&sm->lru, &to_free);
>> +	}
>> +	spin_unlock(&mdsc->snapid_map_lock);
>> +
>> +	while (!list_empty(&to_free)) {
>> +		sm = list_first_entry(&to_free, struct ceph_snapid_map, lru);
>> +		list_del(&sm->lru);
>> +		free_anon_bdev(sm->dev);
>> +		if (atomic_read(&sm->ref)) {
>> +			pr_err("snapid map %llx -> %x still in use\n",
>> +			       sm->snap, sm->dev);
>> +			continue;
>> +		}
> 
> This looks problematic. If it's still in use, then you'll call list_del
> and free_anon_bdev on it, but not kfree it. What will eventually clean
> it up, and how will it know not to do the list_del and free_anon_bdev a
> second time?

this is for unexpected condition. don’t have a elegant way to handle. how about:
        
while (list_empty(&to_free)) {
                sm = list_first_entry(&to_free, struct ceph_snapid_map, lru);
                list_del(&sm->lru);
                free_anon_bdev(sm->dev);
                if (WARN_ON_ONCE(atomic_read(&sm->ref))) {
                        pr_err("snapid map %llx -> %x still in use\n",
                               sm->snap, sm->dev);
                }
                kfree(sm);
}

> 
>> +		kfree(sm);
>> +	}
>> +}
>> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
>> index 75701c199b2b..453edca41a37 100644
>> --- a/fs/ceph/super.h
>> +++ b/fs/ceph/super.h
>> @@ -362,7 +362,10 @@ struct ceph_inode_info {
>> 	struct list_head i_unsafe_iops;   /* uncommitted mds inode ops */
>> 	spinlock_t i_unsafe_lock;
>> 
>> -	struct ceph_snap_realm *i_snap_realm; /* snap realm (if caps) */
>> +	union {
>> +		struct ceph_snap_realm *i_snap_realm; /* snap realm (if caps) */
>> +		struct ceph_snapid_map *i_snapid_map; /* snapid -> dev_t */
>> +	};
>> 	int i_snap_realm_counter; /* snap realm (if caps) */
>> 	struct list_head i_snap_realm_item;
>> 	struct list_head i_snap_flush_item;
>> @@ -778,6 +781,14 @@ extern int __ceph_finish_cap_snap(struct ceph_inode_info *ci,
>> 				  struct ceph_cap_snap *capsnap);
>> extern void ceph_cleanup_empty_realms(struct ceph_mds_client *mdsc);
>> 
>> +extern struct ceph_snapid_map *ceph_get_snapid_map(struct ceph_mds_client *mdsc,
>> +						   u64 snap);
>> +extern void ceph_put_snapid_map(struct ceph_mds_client* mdsc,
>> +				struct ceph_snapid_map *sm);
>> +extern void ceph_trim_snapid_map(struct ceph_mds_client *mdsc);
>> +extern void ceph_cleanup_snapid_map(struct ceph_mds_client *mdsc);
>> +
>> +
>> /*
>>  * a cap_snap is "pending" if it is still awaiting an in-progress
>>  * sync write (that may/may not still update size, mtime, etc.).
> 
> -- 
> Jeff Layton <jlayton@redhat.com>

