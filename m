From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 0/5] rbd: improve how rbd ids are selected
Date: Fri, 2 Mar 2012 11:54:19 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1203021154060.6413@cobra.newdream.net>
References: <4F4D9DA5.8050101@dreamhost.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49758 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756594Ab2CBTyW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Mar 2012 14:54:22 -0500
In-Reply-To: <4F4D9DA5.8050101@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

This series looks good.

Reviewed-by: Sage Weil <sage@newdream.net>

On Tue, 28 Feb 2012, Alex Elder wrote:

> New rbd devices are granted a unique identifiers based on how many
> devices are already in existence.  This series rearranges how that
> is done, switching from using a spinlock to using an atomic variable
> to select the next rbd id to use.  In the process a bit of the code
> got a bit more isolated.
> 
> 					-Alex
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
