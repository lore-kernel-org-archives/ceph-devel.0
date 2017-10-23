From: Sage Weil <sweil@redhat.com>
Subject: Re: [PATCH] ceph: present consistent fsid, regardless of arch
 endianness
Date: Mon, 23 Oct 2017 16:49:59 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1710231649440.16763@piezo.us.to>
References: <20171023162354.6453-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56018 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751548AbdJWQuB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 23 Oct 2017 12:50:01 -0400
In-Reply-To: <20171023162354.6453-1-jlayton@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: zyan@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org

On Mon, 23 Oct 2017, Jeff Layton wrote:
> From: Jeff Layton <jlayton@redhat.com>
> 
> Since its inception, ceph has presented the fsid as an opaque value
> without any sort of endianness conversion. This means that the value
> presented is different on architectures of different endianness.
> 
> While the value that should be stuffed into f_fsid is poorly-defined,
> I think it would be best to strive for consistency here between
> architectures, and clients (we need to present this properly to the
> userland client as well).
> 
> Change ceph_statfs to convert the opaque words to host-endian before
> doing the xor. The value will change between reboots on big-endian
> architectures, but it should not change on little-endian ones.
> 
> Signed-off-by: Jeff Layton <jlayton@redhat.com>

Yeah, sounds good!

Reviewed-by: Sage Weil <sage@redhat.com>

> ---
>  fs/ceph/super.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index e4082afedcb1..fe9fbb3f13f7 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -84,8 +84,9 @@ static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
>  	buf->f_ffree = -1;
>  	buf->f_namelen = NAME_MAX;
>  
> -	/* leave fsid little-endian, regardless of host endianness */
> -	fsid = *(u64 *)(&monmap->fsid) ^ *((u64 *)&monmap->fsid + 1);
> +	/* Must convert the fsid, for consistent values across arches */
> +	fsid = le64_to_cpu(*(__le64 *)(&monmap->fsid)) ^
> +	       le64_to_cpu(*((__le64 *)&monmap->fsid + 1));
>  	buf->f_fsid.val[0] = fsid & 0xffffffff;
>  	buf->f_fsid.val[1] = fsid >> 32;
>  
> -- 
> 2.13.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
