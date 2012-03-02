From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 0/5] rbd: cleanups related to argument parsing
Date: Fri, 2 Mar 2012 13:28:30 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1203021328220.6413@cobra.newdream.net>
References: <4F4DA1EA.3080705@dreamhost.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48090 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755132Ab2CBV2e (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Mar 2012 16:28:34 -0500
In-Reply-To: <4F4DA1EA.3080705@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

These all look good.

Reviewed-by: Sage Weil <sage@newdream.net>

On Tue, 28 Feb 2012, Alex Elder wrote:

> This series affects the way arguments are parsed in rbd_add().
> It first encapsulates the code into its own helper function.
> Then it uses a few simple tokenization functions instead of
> sscanf() to parse the string provided, which makes it possible
> to do a better job of error checking the input.  It makes use
> of the ability to check for certain invariants at build time
> rather than runtime.  And by reworking what information gets
> passed around, eliminates the need to allocate a buffer to
> hold the monitor addresses.
> 
> 					-Alex
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
