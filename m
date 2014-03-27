From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 02/33] libceph: do not prefix osd lines with \t in debugfs
 output
Date: Thu, 27 Mar 2014 14:10:48 -0500
Message-ID: <533477B8.4010706@ieee.org>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com> <1395944299-21970-3-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:42500 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755473AbaC0TK1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 15:10:27 -0400
Received: by mail-ie0-f176.google.com with SMTP id rd18so3769979iec.7
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 12:10:26 -0700 (PDT)
In-Reply-To: <1395944299-21970-3-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 03/27/2014 01:17 PM, Ilya Dryomov wrote:
> To save screen space in anticipation of more fields (e.g. primary
> affinity).
> 
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>

Looks good.

If there are lots of these little trivial transformations
they could probably be consolidated into a smaller set
of patches.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  net/ceph/debugfs.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
> index d225842c7b41..112d98edb156 100644
> --- a/net/ceph/debugfs.c
> +++ b/net/ceph/debugfs.c
> @@ -77,7 +77,7 @@ static int osdmap_show(struct seq_file *s, void *p)
>  		int state = map->osd_state[i];
>  		char sb[64];
>  
> -		seq_printf(s, "\tosd%d\t%s\t%3d%%\t(%s)\n",
> +		seq_printf(s, "osd%d\t%s\t%3d%%\t(%s)\n",
>  			   i, ceph_pr_addr(&addr->in_addr),
>  			   ((map->osd_weight[i]*100) >> 16),
>  			   ceph_osdmap_state_str(sb, sizeof(sb), state));
> 

