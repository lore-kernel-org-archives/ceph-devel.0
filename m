From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 0/3] libceph: clean up some code involving CRCs
Date: Fri, 2 Mar 2012 13:47:42 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1203021347240.6413@cobra.newdream.net>
References: <4F4DAE4E.4000903@dreamhost.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36779 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757330Ab2CBVro (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Mar 2012 16:47:44 -0500
In-Reply-To: <4F4DAE4E.4000903@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

These look good.. but where is the crc bug actually fixed?  Not seeing 
that patch...

Reviewed-by: Sage Weil <sage@newdream.net>

On Tue, 28 Feb 2012, Alex Elder wrote:

> Rename a few variables so it's clearer which indicate that a
> CRC should be computed and which hold an actual CRC value.
> Separate CRC calculation from byte swapping to improve
> readability.  And move some code that runs on only on
> the last pass through a couple of loops outside the loop
> body.
> 
> 					-Alex
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
