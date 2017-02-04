From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH v3 6/8] ceph: vet the target and parent inodes before
 updating dentry lease
Date: Sat, 04 Feb 2017 06:37:50 -0500
Message-ID: <1486208270.16508.2.camel@redhat.com>
References: <20170201114914.20808-1-jlayton@redhat.com>
         <20170203180404.31930-1-jlayton@redhat.com>
         <20170203180404.31930-7-jlayton@redhat.com>
         <9F2AA109-8B66-47BE-8432-4AD59C175F1F@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:35999 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753928AbdBDLhy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 4 Feb 2017 06:37:54 -0500
Received: by mail-qk0-f178.google.com with SMTP id 11so15297577qkl.3
        for <ceph-devel@vger.kernel.org>; Sat, 04 Feb 2017 03:37:54 -0800 (PST)
In-Reply-To: <9F2AA109-8B66-47BE-8432-4AD59C175F1F@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, idryomov@gmail.com

On Sat, 2017-02-04 at 11:20 +0800, Yan, Zheng wrote:
> > On 4 Feb 2017, at 02:04, Jeff Layton <jlayton@redhat.com> wrote:
> > 
> > In a later patch, we're going to need to allow ceph_fill_trace to
> > update the dentry's lease when the parent is not locked. This is
> > potentially racy though -- by the time we get around to processing the
> > trace, the parent may have already changed.
> > 
> > Change update_dentry_lease to take a ceph_vino pointer and use that to
> > ensure that the dentry's parent still matches it before updating the
> > lease.
> > 
> > Signed-off-by: Jeff Layton <jlayton@redhat.com>
> > ---
> > fs/ceph/inode.c | 72 ++++++++++++++++++++++++++++++++++++++-------------------
> > 1 file changed, 48 insertions(+), 24 deletions(-)
> > 
> > diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> > index e5c1ca02dbe3..41cbddd22091 100644
> > --- a/fs/ceph/inode.c
> > +++ b/fs/ceph/inode.c
> > @@ -1016,7 +1016,9 @@ static int fill_inode(struct inode *inode, struct page *locked_page,
> > static void update_dentry_lease(struct dentry *dentry,
> > 				struct ceph_mds_reply_lease *lease,
> > 				struct ceph_mds_session *session,
> > -				unsigned long from_time)
> > +				unsigned long from_time,
> > +				struct ceph_vino *tgt_vino,
> > +				struct ceph_vino *dir_vino)
> > {
> > 	struct ceph_dentry_info *di = ceph_dentry(dentry);
> > 	long unsigned duration = le32_to_cpu(lease->duration_ms);
> > @@ -1024,13 +1026,27 @@ static void update_dentry_lease(struct dentry *dentry,
> > 	long unsigned half_ttl = from_time + (duration * HZ / 2) / 1000;
> > 	struct inode *dir;
> > 
> > +	/*
> > +	 * Make sure dentry's inode matches tgt_vino. NULL tgt_vino means that
> > +	 * we expect a negative dentry.
> > +	 */
> > +	if (!tgt_vino && d_really_is_positive(dentry))
> > +		return;
> > +
> > +	if (tgt_vino && (d_really_is_negative(dentry) ||
> > +			!ceph_ino_compare(d_inode(dentry), tgt_vino)))
> > +		return;
> > +
> 
> we may call this function without locked parent. maybe it’s better to move these checks into critical section of dentry->d_lock
> 
> 

d_inode(dentry) is stable even without the parent being locked. We only
need the d_lock to ensure stability of the parent here. Certainly we
could take the lock before checking it, but it's not required here.

> > 	spin_lock(&dentry->d_lock);
> > 	dout("update_dentry_lease %p duration %lu ms ttl %lu\n",
> > 	     dentry, duration, ttl);
> > 
> > -	/* make lease_rdcache_gen match directory */
> > 	dir = d_inode(dentry->d_parent);
> > 
> > +	/* make sure parent matches dir_vino */
> > +	if (!ceph_ino_compare(dir, dir_vino))
> > +		goto out_unlock;
> > +
> > 	/* only track leases on regular dentries */
> > 	if (ceph_snap(dir) != CEPH_NOSNAP)
> > 		goto out_unlock;
> > @@ -1113,7 +1129,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
> > 	struct ceph_mds_session *session = req->r_session;
> > 	struct ceph_mds_reply_info_parsed *rinfo = &req->r_reply_info;
> > 	struct inode *in = NULL;
> > -	struct ceph_vino vino;
> > +	struct ceph_vino tvino, dvino;
> > 	struct ceph_fs_client *fsc = ceph_sb_to_client(sb);
> > 	int err = 0;
> > 
> > @@ -1154,8 +1170,8 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
> > 			dname.name = rinfo->dname;
> > 			dname.len = rinfo->dname_len;
> > 			dname.hash = full_name_hash(parent, dname.name, dname.len);
> > -			vino.ino = le64_to_cpu(rinfo->targeti.in->ino);
> > -			vino.snap = le64_to_cpu(rinfo->targeti.in->snapid);
> > +			tvino.ino = le64_to_cpu(rinfo->targeti.in->ino);
> > +			tvino.snap = le64_to_cpu(rinfo->targeti.in->snapid);
> > retry_lookup:
> > 			dn = d_lookup(parent, &dname);
> > 			dout("d_lookup on parent=%p name=%.*s got %p\n",
> > @@ -1172,8 +1188,8 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
> > 				}
> > 				err = 0;
> > 			} else if (d_really_is_positive(dn) &&
> > -				   (ceph_ino(d_inode(dn)) != vino.ino ||
> > -				    ceph_snap(d_inode(dn)) != vino.snap)) {
> > +				   (ceph_ino(d_inode(dn)) != tvino.ino ||
> > +				    ceph_snap(d_inode(dn)) != tvino.snap)) {
> > 				dout(" dn %p points to wrong inode %p\n",
> > 				     dn, d_inode(dn));
> > 				d_delete(dn);
> > @@ -1187,10 +1203,10 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
> > 	}
> > 
> > 	if (rinfo->head->is_target) {
> > -		vino.ino = le64_to_cpu(rinfo->targeti.in->ino);
> > -		vino.snap = le64_to_cpu(rinfo->targeti.in->snapid);
> > +		tvino.ino = le64_to_cpu(rinfo->targeti.in->ino);
> > +		tvino.snap = le64_to_cpu(rinfo->targeti.in->snapid);
> > 
> > -		in = ceph_get_inode(sb, vino);
> > +		in = ceph_get_inode(sb, tvino);
> > 		if (IS_ERR(in)) {
> > 			err = PTR_ERR(in);
> > 			goto done;
> > @@ -1234,10 +1250,12 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
> > 		BUG_ON(!dn);
> > 		BUG_ON(!dir);
> > 		BUG_ON(d_inode(dn->d_parent) != dir);
> > -		BUG_ON(ceph_ino(dir) !=
> > -		       le64_to_cpu(rinfo->diri.in->ino));
> > -		BUG_ON(ceph_snap(dir) !=
> > -		       le64_to_cpu(rinfo->diri.in->snapid));
> > +
> > +		dvino.ino = le64_to_cpu(rinfo->diri.in->ino);
> > +		dvino.snap = le64_to_cpu(rinfo->diri.in->snapid);
> > +
> > +		BUG_ON(ceph_ino(dir) != dvino.ino);
> > +		BUG_ON(ceph_snap(dir) != dvino.snap);
> > 
> > 		/* do we have a lease on the whole dir? */
> > 		have_dir_cap =
> > @@ -1294,7 +1312,8 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
> > 					d_add(dn, NULL);
> > 				update_dentry_lease(dn, rinfo->dlease,
> > 						    session,
> > -						    req->r_request_started);
> > +						    req->r_request_started,
> > +						    NULL, &dvino);
> > 			}
> > 			goto done;
> > 		}
> > @@ -1317,9 +1336,13 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
> > 			have_lease = false;
> > 		}
> > 
> > -		if (have_lease)
> > +		if (have_lease) {
> > +			tvino.ino = le64_to_cpu(rinfo->targeti.in->ino);
> > +			tvino.snap = le64_to_cpu(rinfo->targeti.in->snapid);
> > 			update_dentry_lease(dn, rinfo->dlease, session,
> > -					    req->r_request_started);
> > +					    req->r_request_started,
> > +					    &tvino, &dvino);
> > +		}
> > 		dout(" final dn %p\n", dn);
> > 	} else if ((req->r_op == CEPH_MDS_OP_LOOKUPSNAP ||
> > 		    req->r_op == CEPH_MDS_OP_MKSNAP) &&
> > @@ -1493,14 +1516,14 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
> > 	/* FIXME: release caps/leases if error occurs */
> > 	for (i = 0; i < rinfo->dir_nr; i++) {
> > 		struct ceph_mds_reply_dir_entry *rde = rinfo->dir_entries + i;
> > -		struct ceph_vino vino;
> > +		struct ceph_vino tvino, dvino;
> > 
> > 		dname.name = rde->name;
> > 		dname.len = rde->name_len;
> > 		dname.hash = full_name_hash(parent, dname.name, dname.len);
> > 
> > -		vino.ino = le64_to_cpu(rde->inode.in->ino);
> > -		vino.snap = le64_to_cpu(rde->inode.in->snapid);
> > +		tvino.ino = le64_to_cpu(rde->inode.in->ino);
> > +		tvino.snap = le64_to_cpu(rde->inode.in->snapid);
> > 
> > 		if (rinfo->hash_order) {
> > 			u32 hash = ceph_str_hash(ci->i_dir_layout.dl_dir_hash,
> > @@ -1529,8 +1552,8 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
> > 				goto out;
> > 			}
> > 		} else if (d_really_is_positive(dn) &&
> > -			   (ceph_ino(d_inode(dn)) != vino.ino ||
> > -			    ceph_snap(d_inode(dn)) != vino.snap)) {
> > +			   (ceph_ino(d_inode(dn)) != tvino.ino ||
> > +			    ceph_snap(d_inode(dn)) != tvino.snap)) {
> > 			dout(" dn %p points to wrong inode %p\n",
> > 			     dn, d_inode(dn));
> > 			d_delete(dn);
> > @@ -1542,7 +1565,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
> > 		if (d_really_is_positive(dn)) {
> > 			in = d_inode(dn);
> > 		} else {
> > -			in = ceph_get_inode(parent->d_sb, vino);
> > +			in = ceph_get_inode(parent->d_sb, tvino);
> > 			if (IS_ERR(in)) {
> > 				dout("new_inode badness\n");
> > 				d_drop(dn);
> > @@ -1587,8 +1610,9 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
> > 
> > 		ceph_dentry(dn)->offset = rde->offset;
> > 
> > +		dvino = ceph_vino(d_inode(parent));
> > 		update_dentry_lease(dn, rde->lease, req->r_session,
> > -				    req->r_request_started);
> > +				    req->r_request_started, &tvino, &dvino);
> > 
> > 		if (err == 0 && skipped == 0 && cache_ctl.index >= 0) {
> > 			ret = fill_readdir_cache(d_inode(parent), dn,
> > -- 
> > 2.9.3
> > 
> 
> 

-- 
Jeff Layton <jlayton@redhat.com>
