From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 0/4] rbd: miscellaneous cleanups
Date: Fri, 2 Mar 2012 11:46:49 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1203021146410.6413@cobra.newdream.net>
References: <4F4D9BF6.5070102@dreamhost.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46946 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756203Ab2CBTqu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Mar 2012 14:46:50 -0500
In-Reply-To: <4F4D9BF6.5070102@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

This series looks good!

Reviewed-by: Sage Weil <sage@newdream.net>

On Tue, 28 Feb 2012, Alex Elder wrote:

> This series makes a few small unrelated changes to the rbd code.
> The first is a set of simple cleanups.  The second makes
> ceph_parse_options() return a pointer to make the interface
> a little more obvious.  The third gets rid of a duplicate
> copy of the pointer to a ceph_client held in an rbd_device,
> and the last one makes it so RBD_SNAP_HEAD_NAME is the only
> way used for identifying the head snapshot.
> 
> 					-Alex
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
