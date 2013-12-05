From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 0/2] ceph: Add clean up if invalid osd reply received
Date: Wed, 4 Dec 2013 22:04:43 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1312042204370.19900@cobra.newdream.net>
References: <cover.1385561919.git.liwang@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43106 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973Ab3LEGEo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Dec 2013 01:04:44 -0500
In-Reply-To: <cover.1385561919.git.liwang@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Li Wang <liwang@ubuntukylin.com>
Cc: ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Yunchuan Wen <yunchuanwen@ubuntukylin.com>

APplied these both to teh testing branch.  Thanks!

On Wed, 27 Nov 2013, Li Wang wrote:

> Signed-off-by: Li Wang <liwang@ubuntukylin.com>
> Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
> 
> Li Wang (2):
>   ceph: Clean up if error occurred in finish_read()
>   ceph: Add necessary clean up if invalid reply received in
>     handle_reply()
> 
>  fs/ceph/addr.c        |    3 +++
>  net/ceph/osd_client.c |    7 +++++++
>  2 files changed, 10 insertions(+)
> 
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
