From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH v2 12/13] ceph: call update_dentry_lease even when
 r_locked dir is not set
Date: Thu, 2 Feb 2017 16:34:10 +0800
Message-ID: <9C301416-E09E-43E0-B2A3-427FB5009060@redhat.com>
References: <20170130161942.16537-1-jlayton@redhat.com>
 <20170201114914.20808-1-jlayton@redhat.com>
 <20170201114914.20808-13-jlayton@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46644 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750881AbdBBIeQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 2 Feb 2017 03:34:16 -0500
In-Reply-To: <20170201114914.20808-13-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, idryomov@gmail.com


> On 1 Feb 2017, at 19:49, Jeff Layton <jlayton@redhat.com> wrote:
> 
> We don't really require that the parent be locked in order to update the
> lease on a dentry. Lease info is protected by the d_lock. In the event
> that the parent is not locked in ceph_fill_trace, and we have both
> parent and target info, go ahead and update the dentry lease.
> 
> Signed-off-by: Jeff Layton <jlayton@redhat.com>
> ---
> fs/ceph/inode.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
> 
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 15e042a8d71f..87863f962d50 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -1345,6 +1345,16 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
> 			goto done;
> 		}
> 		req->r_dentry = dn;  /* may have spliced */
> +	} else if (rinfo->head->is_dentry && rinfo->head->is_target) {
> +		if ((le32_to_cpu(rinfo->diri.in->cap.caps) & CEPH_CAP_FILE_SHARED) ||
> +		    le32_to_cpu(rinfo->dlease->duration_ms)) {
> +			vino.ino = le64_to_cpu(rinfo->diri.in->ino);
> +			vino.snap = le64_to_cpu(rinfo->diri.in->snapid);
> +			update_dentry_lease(req->r_dentry, rinfo->dlease,
> +				session, req->r_request_started, &vino);
> +		} else {
> +			dout("%s: no dentry lease or dir cap\n", __func__);
> +		}
> 	}

I think checking rinfo->head->is_target is not needed here, because null dentry can also have lease.
Besides, I think we need to check if rinfo->head->is_target matches d_really_is_negative(dn) and if
the target inode matches d_inode(dn).

> 	dout("fill_trace done err=%d\n", err);
> -- 
> 2.9.3
> 

