From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] include/atomic.h: add stdlib.h for size_t
Date: Tue, 11 Dec 2012 08:45:04 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212110845000.32154@cobra.newdream.net>
References: <1355231108-18168-1-git-send-email-danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48903 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418Ab2LKQpF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Dec 2012 11:45:05 -0500
In-Reply-To: <1355231108-18168-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: ceph-devel@vger.kernel.org, Danny Al-Gaaf <dalgaaf@suse.de>

Applied; thanks!

sage


On Tue, 11 Dec 2012, Danny Al-Gaaf wrote:

> Include missing stdlib.h needed for size_t.
> 
> Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
> ---
>  src/include/atomic.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/src/include/atomic.h b/src/include/atomic.h
> index 0c22b26..3ecbd28 100644
> --- a/src/include/atomic.h
> +++ b/src/include/atomic.h
> @@ -20,6 +20,8 @@
>  # include "acconfig.h"
>  #endif
>  
> +#include <stdlib.h>
> +
>  #ifndef NO_ATOMIC_OPS
>  
>  // libatomic_ops implementation
> -- 
> 1.8.0.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
