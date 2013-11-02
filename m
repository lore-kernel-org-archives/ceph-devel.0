From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] osd/erasurecode: Fix memory leak in
 jerasure_matrix_to_bitmatrix()
Date: Sat, 2 Nov 2013 00:03:31 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1311020002280.32481@cobra.newdream.net>
References: <1383375493-2895-1-git-send-email-xinglin@cs.utah.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50091 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263Ab3KBHDb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 2 Nov 2013 03:03:31 -0400
In-Reply-To: <1383375493-2895-1-git-send-email-xinglin@cs.utah.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xing Lin <xinglin@cs.utah.edu>
Cc: ceph-devel@vger.kernel.org

Hi!

On Sat, 2 Nov 2013, Xing Lin wrote:
> Free allocated memory before return because of NULL input
> 
> Signed-off-by: Xing Lin <xinglin@cs.utah.edu>
> ---
>  src/osd/ErasureCodePluginJerasure/jerasure.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/src/osd/ErasureCodePluginJerasure/jerasure.c b/src/osd/ErasureCodePluginJerasure/jerasure.c
> index 9efae02..1bb4b1d 100755
> --- a/src/osd/ErasureCodePluginJerasure/jerasure.c
> +++ b/src/osd/ErasureCodePluginJerasure/jerasure.c
> @@ -276,7 +276,10 @@ int *jerasure_matrix_to_bitmatrix(int k, int m, int w, int *matrix)
>    int rowelts, rowindex, colindex, elt, i, j, l, x;
>  
>    bitmatrix = talloc(int, k*m*w*w);
> -  if (matrix == NULL) { return NULL; }
> +  if (matrix == NULL) {
> +    free(bitmatrix);
> +    return NULL; 
> +  }

I have a feeling the author meant to say if (bitmatrix == NULL), since all 
the other talloc calls in this file tend to be followed by a NULL check?

sage


>  
>    rowelts = k * w;
>    rowindex = 0;
> -- 
> 1.8.3.4 (Apple Git-47)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
