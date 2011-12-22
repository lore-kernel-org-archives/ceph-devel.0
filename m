From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 1/3] interval_set: fix truncation of _size
Date: Thu, 22 Dec 2011 12:16:27 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1112221216180.3284@cobra.newdream.net>
References: <1324550845-8031-1-git-send-email-henry.cy.chang@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45289 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392Ab1LVUQ2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Dec 2011 15:16:28 -0500
In-Reply-To: <1324550845-8031-1-git-send-email-henry.cy.chang@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel@vger.kernel.org

Applied all three of these.  Thanks!

sage


On Thu, 22 Dec 2011, Henry C Chang wrote:

> _size is type of int64_t. Use int to store the value of _size
> will cause value truncation.
> 
> Signed-off-by: Henry C Chang <henry.cy.chang@gmail.com>
> ---
>  src/include/interval_set.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/src/include/interval_set.h b/src/include/interval_set.h
> index ae1c7ff..bfc62a9 100644
> --- a/src/include/interval_set.h
> +++ b/src/include/interval_set.h
> @@ -361,7 +361,7 @@ class interval_set {
>  
>    void swap(interval_set<T>& other) {
>      m.swap(other.m);
> -    int t = _size;
> +    int64_t t = _size;
>      _size = other._size;
>      other._size = t;
>    }    
> -- 
> 1.7.4.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
