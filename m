From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 0/4] ceph: minor cleanups
Date: Fri, 2 Mar 2012 11:25:24 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1203021125031.6413@cobra.newdream.net>
References: <4F4D96F4.3080707@dreamhost.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50996 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379Ab2CBTZZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Mar 2012 14:25:25 -0500
In-Reply-To: <4F4D96F4.3080707@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

This set looks good,

Reviewed-by: Sage Weil <sage@newdream.net>

On Tue, 28 Feb 2012, Alex Elder wrote:

> These are mostly small cleanups.  Only the second one has any
> significant changes in it--using a masked atomic rather than
> a spinlocked mod operation for determining an index to use
> on a fixed-size array.
> 
> 					-Alex
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
