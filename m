From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [RFC PATCH 8/9] ceph: copy layout, max_size and truncate_size on
 successful sync create
Date: Mon, 13 Jan 2020 11:51:58 +0800
Message-ID: <98bb5af6-415f-e035-2d54-15ed492914b4@redhat.com>
References: <20200110205647.311023-1-jlayton@kernel.org>
 <20200110205647.311023-9-jlayton@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44544 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387415AbgAMDwL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 12 Jan 2020 22:52:11 -0500
In-Reply-To: <20200110205647.311023-9-jlayton@kernel.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org
Cc: sage@redhat.com, idryomov@gmail.com, pdonnell@redhat.com

On 1/11/20 4:56 AM, Jeff Layton wrote:
> It doesn't do much good to do an asynchronous create unless we can do
> I/O to it before the create reply comes in. That means we need layout
> info the new file before we've gotten the response from the MDS.
> 
> All files created in a directory will initially inherit the same layout,
> so copy off the requisite info from the first synchronous create in the
> directory. Save it in the same fields in the directory inode, as those
> are otherwise unsed for dir inodes. This means we need to be a bit
> careful about only updating layout info on non-dir inodes.
> 
> Also, zero out the layout when we drop Dc caps in the dir.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/ceph/caps.c  | 24 ++++++++++++++++++++----
>   fs/ceph/file.c  | 24 +++++++++++++++++++++++-
>   fs/ceph/inode.c |  4 ++--
>   3 files changed, 45 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 7fc87b693ba4..b96fb1378479 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -2847,7 +2847,7 @@ int ceph_get_caps(struct file *filp, int need, int want,
>   			return ret;
>   		}
>   
> -		if (S_ISREG(ci->vfs_inode.i_mode) &&
> +		if (!S_ISDIR(ci->vfs_inode.i_mode) &&
>   		    ci->i_inline_version != CEPH_INLINE_NONE &&
>   		    (_got & (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO)) &&
>   		    i_size_read(inode) > 0) {
> @@ -2944,9 +2944,17 @@ void ceph_put_cap_refs(struct ceph_inode_info *ci, int had)
>   	if (had & CEPH_CAP_FILE_RD)
>   		if (--ci->i_rd_ref == 0)
>   			last++;
> -	if (had & CEPH_CAP_FILE_CACHE)
> -		if (--ci->i_rdcache_ref == 0)
> +	if (had & CEPH_CAP_FILE_CACHE) {
> +		if (--ci->i_rdcache_ref == 0) {
>   			last++;
> +			/* Zero out layout if we lost CREATE caps */
> +			if (S_ISDIR(inode->i_mode) &&
> +			    !(__ceph_caps_issued(ci, NULL) & CEPH_CAP_DIR_CREATE)) {
> +				ceph_put_string(rcu_dereference_raw(ci->i_layout.pool_ns));
> +				memset(&ci->i_layout, 0, sizeof(ci->i_layout));
> +			}
> +		}
> +	}

should do this in __check_cap_issue

>   	if (had & CEPH_CAP_FILE_EXCL)
>   		if (--ci->i_fx_ref == 0)
>   			last++;
> @@ -3264,7 +3272,8 @@ static void handle_cap_grant(struct inode *inode,
>   		ci->i_subdirs = extra_info->nsubdirs;
>   	}
>   
> -	if (newcaps & (CEPH_CAP_ANY_FILE_RD | CEPH_CAP_ANY_FILE_WR)) {
> +	if (!S_ISDIR(inode->i_mode) &&
> +	    (newcaps & (CEPH_CAP_ANY_FILE_RD | CEPH_CAP_ANY_FILE_WR))) {
>   		/* file layout may have changed */
>   		s64 old_pool = ci->i_layout.pool_id;
>   		struct ceph_string *old_ns;
> @@ -3336,6 +3345,13 @@ static void handle_cap_grant(struct inode *inode,
>   		     ceph_cap_string(cap->issued),
>   		     ceph_cap_string(newcaps),
>   		     ceph_cap_string(revoking));
> +
> +		if (S_ISDIR(inode->i_mode) &&
> +		    (revoking & CEPH_CAP_DIR_CREATE) && !ci->i_rdcache_ref) {
> +			ceph_put_string(rcu_dereference_raw(ci->i_layout.pool_ns));
> +			memset(&ci->i_layout, 0, sizeof(ci->i_layout));
> +		}


same here

> +
>   		if (S_ISREG(inode->i_mode) &&
>   		    (revoking & used & CEPH_CAP_FILE_BUFFER))
>   			writeback = true;  /* initiate writeback; will delay ack */
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 1e6cdf2dfe90..d4d7a277faf1 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -430,6 +430,25 @@ int ceph_open(struct inode *inode, struct file *file)
>   	return err;
>   }
>   
> +/* Clone the layout from a synchronous create, if the dir now has Dc caps */
> +static void
> +copy_file_layout(struct inode *dst, struct inode *src)
> +{
> +	struct ceph_inode_info *cdst = ceph_inode(dst);
> +	struct ceph_inode_info *csrc = ceph_inode(src);
> +
> +	spin_lock(&cdst->i_ceph_lock);
> +	if ((__ceph_caps_issued(cdst, NULL) & CEPH_CAP_DIR_CREATE) &&
> +	    !ceph_file_layout_is_valid(&cdst->i_layout)) {
> +		memcpy(&cdst->i_layout, &csrc->i_layout,
> +			sizeof(cdst->i_layout));
> +		rcu_assign_pointer(cdst->i_layout.pool_ns,
> +				   ceph_try_get_string(csrc->i_layout.pool_ns));
> +		cdst->i_max_size = csrc->i_max_size;
> +		cdst->i_truncate_size = csrc->i_truncate_size;
> +	}
> +	spin_unlock(&cdst->i_ceph_lock);
> +}
>   
>   /*
>    * Do a lookup + open with a single request.  If we get a non-existent
> @@ -518,7 +537,10 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
>   	} else {
>   		dout("atomic_open finish_open on dn %p\n", dn);
>   		if (req->r_op == CEPH_MDS_OP_CREATE && req->r_reply_info.has_create_ino) {
> -			ceph_init_inode_acls(d_inode(dentry), &as_ctx);
> +			struct inode *newino = d_inode(dentry);
> +
> +			copy_file_layout(dir, newino);
> +			ceph_init_inode_acls(newino, &as_ctx);
>   			file->f_mode |= FMODE_CREATED;
>   		}
>   		err = finish_open(file, dentry, ceph_open);
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 9cfc093fd273..8b51051b79b0 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -848,8 +848,8 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
>   		ci->i_subdirs = le64_to_cpu(info->subdirs);
>   	}
>   
> -	if (new_version ||
> -	    (new_issued & (CEPH_CAP_ANY_FILE_RD | CEPH_CAP_ANY_FILE_WR))) {
> +	if (!S_ISDIR(inode->i_mode) && (new_version ||
> +	    (new_issued & (CEPH_CAP_ANY_FILE_RD | CEPH_CAP_ANY_FILE_WR)))) {
>   		s64 old_pool = ci->i_layout.pool_id;
>   		struct ceph_string *old_ns;
>   
> 
