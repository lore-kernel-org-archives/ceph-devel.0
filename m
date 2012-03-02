From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 0/3] rbd: minor cleanups in rbd_add()
Date: Fri, 2 Mar 2012 13:00:06 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1203021300040.6413@cobra.newdream.net>
References: <4F4DA086.7050601@dreamhost.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54980 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621Ab2CBVAL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Mar 2012 16:00:11 -0500
In-Reply-To: <4F4DA086.7050601@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Also good

On Tue, 28 Feb 2012, Alex Elder wrote:

> This series affects rbd_add().  It calls rbd_get_client(), and by
> making that function return a client pointer it makes it more
> obvious that the client pointer is getting assigned.  It also
> reduces the amount of memory allocated to hold the monitor
> address and options passed from the user.  And it cleans up
> the error handling path in that function.
> 
> 					-Alex
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
