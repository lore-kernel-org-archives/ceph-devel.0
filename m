From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH v2] ceph: clean up unsafe d_parent access in __choose_mds
Date: Wed, 14 Dec 2016 21:21:46 +0800
Message-ID: <4FA752D7-523E-4451-AB82-382FEF125D6A@redhat.com>
References: <1481652253-14780-2-git-send-email-jlayton@redhat.com>
 <1481720156-7286-1-git-send-email-jlayton@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35568 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755424AbcLNNV5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 14 Dec 2016 08:21:57 -0500
In-Reply-To: <1481720156-7286-1-git-send-email-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, David Howells <dhowells@redhat.com>, Al Viro <viro@ZenIV.linux.org.uk>


> On 14 Dec 2016, at 20:55, Jeff Layton <jlayton@redhat.com> wrote:
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
> but the overall parent is _not_, and could change if a concurrent
> rename were to occur.
> 
> Clean this code up and take special care to ensure the validity of
> the entries we're working with. First, hold the rcu_read_lock so we
> can ensure that any d_parent we find won't go away.
> 
> Change get_nonsnap_parent to return an inode, and take a reference to
> that inode before returning (if any). Change the other places where we
> set "inode" in __choose_mds to also take a reference, and then call iput
> on that inode before exiting the function.
> 
> Link: http://tracker.ceph.com/issues/18148
> Signed-off-by: Jeff Layton <jlayton@redhat.com>
> ---
> fs/ceph/mds_client.c | 67 +++++++++++++++++++++++++++++++++++-----------------
> 1 file changed, 45 insertions(+), 22 deletions(-)
> 
> v2: try to use req->r_locked_dir if d_inode_rcu(parent) is NULL
> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 815acd1a56d4..eef772155ab1 100644
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
> 	} else if (req->r_dentry) {
> 		/* ignore race with rename; old or new d_parent is okay */
> -		struct dentry *parent = req->r_dentry->d_parent;
> -		struct inode *dir = d_inode(parent);
> -
> -		if (dir->i_sb != mdsc->fsc->sb) {
> +		struct dentry *parent;
> +		struct inode *dir;
> +
> +		rcu_read_lock();
> +		parent = req->r_dentry->d_parent;
> +		dir = d_inode_rcu(parent);
> +
> +		if (!dir) {
> +			inode = req->r_locked_dir;
> +			if (inode)
> +				ihold(inode);


I prefer to first try using req->r_locked_dir. Because r_locked_dir is non-null in most cases. Use d_inode_rcu(parent) only when r_locked_dir is null.
For the other two patches, I think we also can first try r_locked_dir.

Regards
Yan, Zheng



> +		} else if (dir->i_sb != mdsc->fsc->sb) {
> 			/* not this fs! */
> 			inode = d_inode(req->r_dentry);
> +			ihold(inode);
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

