From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] ceph: present consistent fsid, regardless of arch
 endianness
Date: Mon, 23 Oct 2017 12:33:05 -0400
Message-ID: <1508776385.5859.25.camel@kernel.org>
References: <20171023162354.6453-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751746AbdJWQdH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 23 Oct 2017 12:33:07 -0400
In-Reply-To: <20171023162354.6453-1-jlayton@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: zyan@redhat.com
Cc: sage@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org

On Mon, 2017-10-23 at 12:23 -0400, Jeff Layton wrote:
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

I should probably have sent this as an RFC, and that last sentence was
poorly worded. Let me try again:

"On an upgrade, a big-endian box may see a different fsid than it did
 before, but little-endian arches should see no change with this patch."


> Signed-off-by: Jeff Layton <jlayton@redhat.com>
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

-- 
Jeff Layton <jlayton@kernel.org>
