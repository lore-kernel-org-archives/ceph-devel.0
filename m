From: Sage Weil <sweil@redhat.com>
Subject: Re: [PATCH] libceph: separate multiple ops with commas in debugfs
 output
Date: Wed, 8 Oct 2014 07:56:38 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410080756310.742@cobra.newdream.net>
References: <1412757436-6996-1-git-send-email-idryomov@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46649 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753758AbaJHO4j (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Oct 2014 10:56:39 -0400
In-Reply-To: <1412757436-6996-1-git-send-email-idryomov@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Sage Weil <sage@redhat.com>

On Wed, 8 Oct 2014, Ilya Dryomov wrote:

> For requests with multiple ops, separate ops with commas instead of \t,
> which is a field separator here.
> 
> Signed-off-by: Ilya Dryomov <idryomov@redhat.com>
> ---
>  net/ceph/debugfs.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
> index d1a62c69a9f4..d2d525529f87 100644
> --- a/net/ceph/debugfs.c
> +++ b/net/ceph/debugfs.c
> @@ -169,7 +169,8 @@ static int osdc_show(struct seq_file *s, void *pp)
>  
>  		for (i = 0; i < req->r_num_ops; i++) {
>  			opcode = req->r_ops[i].op;
> -			seq_printf(s, "\t%s", ceph_osd_op_name(opcode));
> +			seq_printf(s, "%s%s", (i == 0 ? "\t" : ","),
> +				   ceph_osd_op_name(opcode));
>  		}
>  
>  		seq_printf(s, "\n");
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
