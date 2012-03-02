From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 0/4] rbd: client list locking improvements
Date: Fri, 2 Mar 2012 11:56:18 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1203021156090.6413@cobra.newdream.net>
References: <4F4D9F0E.4080804@dreamhost.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49499 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755698Ab2CBT4T (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Mar 2012 14:56:19 -0500
In-Reply-To: <4F4D9F0E.4080804@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Looks good,

Reviewed-by: Sage Weil <sage@newdream.net>

On Tue, 28 Feb 2012, Alex Elder wrote:

> This series reduces the window during which the client list
> lock is held, gives it a more meaningful name, and moves the
> locking calls closer to the places they're really needed.
> 
> 					-Alex
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
