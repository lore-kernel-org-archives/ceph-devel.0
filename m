From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH v3 1/5] ceph: clean up unsafe d_parent access in
 __choose_mds
Date: Thu, 15 Dec 2016 17:08:52 +0800
Message-ID: <C469B5CD-1854-4826-8E99-B401A751B50B@redhat.com>
References: <1481727270-12666-1-git-send-email-jlayton@redhat.com>
 <1481727270-12666-2-git-send-email-jlayton@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1481727270-12666-2-git-send-email-jlayton@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jeff Layton <jlayton@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, David Howells <dhowells@redhat.com>, viro@ZenIV.linux.org.uk
List-Id: ceph-devel.vger.kernel.org


> On 14 Dec 2016, at 22:54, Jeff Layton <jlayton@redhat.com> wrote:
> 
> __choose_mds exists to pick an MDS to use when issuing a call. Doing
> that typically involves picking an inode and using the authoritative
> MDS for it. In most cases, that's pretty straightforward, as we are
> using an inode to which we hold a reference (usually represented by
> r_dentry or r_inode in the request).
> 
> In the case of a snapshotted directory however, we need to fetch
> the non-snapped parent, which involves walking back up the parents
> in the tree. The dentries in the snapshot dir are effectively frozen
> but the overall parent is _not_, and could vanish if a concurrent
> rename were to occur.
> 
> Clean this code up and take special care to ensure the validity of
> the entries we're working with. First, try to use the inode in
> r_locked_dir if one exists. If not and all we have is r_dentry,
> then we have to walk back up the tree. Use the rcu_read_lock for
> this so we can ensure that any d_parent we find won't go away, and
> take extra care to deal with the possibility that the dentries could
> go negative.
> 
> Change get_nonsnap_parent to return an inode, and take a reference to
> that inode before returning (if any). Change all of the other places
> where we set "inode" in __choose_mds to also take a reference, and then
> call iput on that inode before exiting the function.
> 
> Link: http://tracker.ceph.com/issues/18148
> Signed-off-by: Jeff Layton <jlayton@redhat.com>
> ---
> fs/ceph/mds_client.c | 67 +++++++++++++++++++++++++++++++++++-----------------
> 1 file changed, 45 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 815acd1a56d4..e62b566d3817 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -667,6 +667,27 @@ static void __unregister_request(struct ceph_mds_client *mdsc,
> }
> 
> /*
> + * Walk back up the dentry tree until we hit a dentry representing a
> + * non-snapshot inode. We do this using the rcu_read_lock (which must be held
> + * when calling this) to ensure that the objects won't disappear while we're
> + * working with them. Once we hit a candidate dentry, we attempt to take a
> + * reference to it, and return that as the result.
> + */
> +static struct inode *get_nonsnap_parent(struct dentry *dentry) { struct inode
> +	*inode = NULL;
> +
> +	while (dentry && !IS_ROOT(dentry)) {
> +		inode = d_inode_rcu(dentry);
> +		if (!inode || ceph_snap(inode) == CEPH_NOSNAP)
> +			break;
> +		dentry = dentry->d_parent;
> +	}
> +	if (inode)
> +		inode = igrab(inode);
> +	return inode;
> +}
> +
> +/*
>  * Choose mds to send request to next.  If there is a hint set in the
>  * request (e.g., due to a prior forward hint from the mds), use that.
>  * Otherwise, consult frag tree and/or caps to identify the
> @@ -674,19 +695,6 @@ static void __unregister_request(struct ceph_mds_client *mdsc,
>  *
>  * Called under mdsc->mutex.
>  */
> -static struct dentry *get_nonsnap_parent(struct dentry *dentry)
> -{
> -	/*
> -	 * we don't need to worry about protecting the d_parent access
> -	 * here because we never renaming inside the snapped namespace
> -	 * except to resplice to another snapdir, and either the old or new
> -	 * result is a valid result.
> -	 */
> -	while (!IS_ROOT(dentry) && ceph_snap(d_inode(dentry)) != CEPH_NOSNAP)
> -		dentry = dentry->d_parent;
> -	return dentry;
> -}
> -
> static int __choose_mds(struct ceph_mds_client *mdsc,
> 			struct ceph_mds_request *req)
> {
> @@ -716,30 +724,42 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
> 	inode = NULL;
> 	if (req->r_inode) {
> 		inode = req->r_inode;
> +		ihold(inode);
> +	} else if (req->r_locked_dir) {
> +		inode = req->r_locked_dir;
> +		ihold(inode);


this seems incorrect. how about following incremental patch

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index c834d7d..4abc85f 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -725,9 +725,6 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
        if (req->r_inode) {
                inode = req->r_inode;
                ihold(inode);
-       } else if (req->r_locked_dir) {
-               inode = req->r_locked_dir;
-               ihold(inode);
        } else if (req->r_dentry) {
                /* ignore race with rename; old or new d_parent is okay */
                struct dentry *parent;
@@ -735,7 +732,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 
                rcu_read_lock();
                parent = req->r_dentry->d_parent;
-               dir = d_inode_rcu(parent);
+               dir = req->r_locked_dir ? : d_inode_rcu(parent);
 
                if (!dir || dir->i_sb != mdsc->fsc->sb) {
                        /*  not this fs or parent went negative */


Regards
Yan, Zheng

> 	} else if (req->r_dentry) {
> 		/* ignore race with rename; old or new d_parent is okay */
> -		struct dentry *parent = req->r_dentry->d_parent;
> -		struct inode *dir = d_inode(parent);
> +		struct dentry *parent;
> +		struct inode *dir;
> +
> +		rcu_read_lock();
> +		parent = req->r_dentry->d_parent;
> +		dir = d_inode_rcu(parent);
> 
> -		if (dir->i_sb != mdsc->fsc->sb) {
> -			/* not this fs! */
> +		if (!dir || dir->i_sb != mdsc->fsc->sb) {
> +			/*  not this fs or parent went negative */
> 			inode = d_inode(req->r_dentry);
> +			if (inode)
> +				ihold(inode);
> 		} else if (ceph_snap(dir) != CEPH_NOSNAP) {
> 			/* direct snapped/virtual snapdir requests
> 			 * based on parent dir inode */
> -			struct dentry *dn = get_nonsnap_parent(parent);
> -			inode = d_inode(dn);
> +			inode = get_nonsnap_parent(parent);
> 			dout("__choose_mds using nonsnap parent %p\n", inode);
> 		} else {
> 			/* dentry target */
> 			inode = d_inode(req->r_dentry);
> 			if (!inode || mode == USE_AUTH_MDS) {
> 				/* dir + name */
> -				inode = dir;
> +				inode = igrab(dir);
> 				hash = ceph_dentry_hash(dir, req->r_dentry);
> 				is_hash = true;
> +			} else {
> +				ihold(inode);
> 			}
> 		}
> +		rcu_read_unlock();
> 	}
> 
> 	dout("__choose_mds %p is_hash=%d (%d) mode %d\n", inode, (int)is_hash,
> @@ -768,7 +788,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
> 				     (int)r, frag.ndist);
> 				if (ceph_mdsmap_get_state(mdsc->mdsmap, mds) >=
> 				    CEPH_MDS_STATE_ACTIVE)
> -					return mds;
> +					goto out;
> 			}
> 
> 			/* since this file/dir wasn't known to be
> @@ -783,7 +803,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
> 				     inode, ceph_vinop(inode), frag.frag, mds);
> 				if (ceph_mdsmap_get_state(mdsc->mdsmap, mds) >=
> 				    CEPH_MDS_STATE_ACTIVE)
> -					return mds;
> +					goto out;
> 			}
> 		}
> 	}
> @@ -796,6 +816,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
> 		cap = rb_entry(rb_first(&ci->i_caps), struct ceph_cap, ci_node);
> 	if (!cap) {
> 		spin_unlock(&ci->i_ceph_lock);
> +		iput(inode);
> 		goto random;
> 	}
> 	mds = cap->session->s_mds;
> @@ -803,6 +824,8 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
> 	     inode, ceph_vinop(inode), mds,
> 	     cap == ci->i_auth_cap ? "auth " : "", cap);
> 	spin_unlock(&ci->i_ceph_lock);
> +out:
> +	iput(inode);
> 	return mds;
> 
> random:
> -- 
> 2.7.4
> 

