From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] osd/erasurecode: correct one variable name in
 jerasure_matrix_to_bitmatrix()
Date: Sat, 2 Nov 2013 23:14:26 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1311022314160.5861@cobra.newdream.net>
References: <1383441862-3623-1-git-send-email-xinglin@cs.utah.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56670 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab3KCGO1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 3 Nov 2013 01:14:27 -0500
In-Reply-To: <1383441862-3623-1-git-send-email-xinglin@cs.utah.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xing Lin <xinglin@cs.utah.edu>
Cc: ceph-devel@vger.kernel.org

Applied this to the tree.  Thanks!

On Sat, 2 Nov 2013, Xing Lin wrote:

> When bitmatrix is NULL, this function returns NULL.
> 
> Signed-off-by: Xing Lin <xinglin@cs.utah.edu>
> ---
>  src/osd/ErasureCodePluginJerasure/jerasure.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/osd/ErasureCodePluginJerasure/jerasure.c b/src/osd/ErasureCodePluginJerasure/jerasure.c
> index 9efae02..d5752a8 100755
> --- a/src/osd/ErasureCodePluginJerasure/jerasure.c
> +++ b/src/osd/ErasureCodePluginJerasure/jerasure.c
> @@ -276,7 +276,7 @@ int *jerasure_matrix_to_bitmatrix(int k, int m, int w, int *matrix)
>    int rowelts, rowindex, colindex, elt, i, j, l, x;
>  
>    bitmatrix = talloc(int, k*m*w*w);
> -  if (matrix == NULL) { return NULL; }
> +  if (bitmatrix == NULL) { return NULL; }
>  
>    rowelts = k * w;
>    rowindex = 0;
> -- 
> 1.8.3.4 (Apple Git-47)
> 
> 
