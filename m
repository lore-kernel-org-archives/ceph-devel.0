From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [RFC PATCH 07/10] ceph: update cap message struct version to 9
Date: Fri, 04 Nov 2016 08:57:30 -0400
Message-ID: <1478264250.27698.1.camel@redhat.com>
References: <1478259273-3471-1-git-send-email-jlayton@redhat.com>
         <1478259273-3471-8-git-send-email-jlayton@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:35013 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933216AbcKDM5e (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Nov 2016 08:57:34 -0400
Received: by mail-qk0-f173.google.com with SMTP id n204so85315813qke.2
        for <ceph-devel@vger.kernel.org>; Fri, 04 Nov 2016 05:57:33 -0700 (PDT)
In-Reply-To: <1478259273-3471-8-git-send-email-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, zyan@redhat.com, sage@redhat.com

On Fri, 2016-11-04 at 07:34 -0400, Jeff Layton wrote:
> The userland ceph has MClientCaps at struct version 9. This brings the
> kernel up the same version.
> 
> With this change, we have to start tracking the btime and change_attr,
> so that the client can pass back sane values in cap messages. The
> client doesn't care about the btime at all, so this is just passed
> around, but the change_attr is used when ceph is exported via NFS.
> 
> For now, the new "sync" parm is left at 0, to preserve the existing
> behavior of the client.
> 
> Signed-off-by: Jeff Layton <jlayton@redhat.com>
> ---
>  fs/ceph/caps.c | 33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 6e99866b1946..452f5024589f 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -991,9 +991,9 @@ struct cap_msg_args {
>  	struct ceph_mds_session	*session;
>  	u64			ino, cid, follows;
>  	u64			flush_tid, oldest_flush_tid, size, max_size;
> -	u64			xattr_version;
> +	u64			xattr_version, change_attr;
>  	struct ceph_buffer	*xattr_buf;
> -	struct timespec		atime, mtime, ctime;
> +	struct timespec		atime, mtime, ctime, btime;
>  	int			op, caps, wanted, dirty;
>  	u32			seq, issue_seq, mseq, time_warp_seq;
>  	kuid_t			uid;
> @@ -1026,13 +1026,13 @@ static int send_cap_msg(struct cap_msg_args *arg)
>  
>  	/* flock buffer size + inline version + inline data size +
>  	 * osd_epoch_barrier + oldest_flush_tid */
> -	extra_len = 4 + 8 + 4 + 4 + 8;
> +	extra_len = 4 + 8 + 4 + 4 + 8 + 4 + 4 + 4 + 8 + 8 + 1;
>  	msg = ceph_msg_new(CEPH_MSG_CLIENT_CAPS, sizeof(*fc) + extra_len,
>  			   GFP_NOFS, false);
>  	if (!msg)
>  		return -ENOMEM;
>  
> -	msg->hdr.version = cpu_to_le16(6);
> +	msg->hdr.version = cpu_to_le16(9);
>  	msg->hdr.tid = cpu_to_le64(arg->flush_tid);
>  
>  	fc = msg->front.iov_base;
> @@ -1068,17 +1068,30 @@ static int send_cap_msg(struct cap_msg_args *arg)
>  	}
>  
>  	p = fc + 1;
> -	/* flock buffer size */
> +	/* flock buffer size (version 2) */
>  	ceph_encode_32(&p, 0);
> -	/* inline version */
> +	/* inline version (version 4) */
>  	ceph_encode_64(&p, arg->inline_data ? 0 : CEPH_INLINE_NONE);
>  	/* inline data size */
>  	ceph_encode_32(&p, 0);
> -	/* osd_epoch_barrier */
> +	/* osd_epoch_barrier (version 5) */
>  	ceph_encode_32(&p, 0);
> -	/* oldest_flush_tid */
> +	/* oldest_flush_tid (version 6) */
>  	ceph_encode_64(&p, arg->oldest_flush_tid);
>  
> +	/* caller_uid/caller_gid (version 7) */
> +	ceph_encode_32(&p, (u32)-1);
> +	ceph_encode_32(&p, (u32)-1);

A bit of self-review...

Not sure if we want to set the above to something else -- maybe 0 or to
current's creds? That may not always make sense though (during e.g.
writeback).

> +
> +	/* pool namespace (version 8) */
> +	ceph_encode_32(&p, 0);
> +

I'm a little unclear on how the above should be set, but I'll look over
the userland code and ape what it does.

> +	/* btime, change_attr, sync (version 9) */
> +	ceph_encode_timespec(p, &arg->btime);
> +	p += sizeof(struct ceph_timespec);
> +	ceph_encode_64(&p, arg->change_attr);
> +	ceph_encode_8(&p, 0);
> +
>  	ceph_con_send(&arg->session->s_con, msg);
>  	return 0;
>  }
> @@ -1189,9 +1202,11 @@ static int __send_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
>  		arg.xattr_buf = NULL;
>  	}
>  
> +	arg.change_attr = inode->i_version;
>  	arg.mtime = inode->i_mtime;
>  	arg.atime = inode->i_atime;
>  	arg.ctime = inode->i_ctime;
> +	arg.btime = ci->i_btime;
>  
>  	arg.op = op;
>  	arg.caps = cap->implemented;
> @@ -1241,10 +1256,12 @@ static inline int __send_flush_snap(struct inode *inode,
>  	arg.max_size = 0;
>  	arg.xattr_version = capsnap->xattr_version;
>  	arg.xattr_buf = capsnap->xattr_blob;
> +	arg.change_attr = capsnap->change_attr;
>  
>  	arg.atime = capsnap->atime;
>  	arg.mtime = capsnap->mtime;
>  	arg.ctime = capsnap->ctime;
> +	arg.btime = capsnap->btime;
>  
>  	arg.op = CEPH_CAP_OP_FLUSHSNAP;
>  	arg.caps = capsnap->issued;

-- 
Jeff Layton <jlayton@redhat.com>
