From: Sage Weil <sage@inktank.com>
Subject: Re: tmap change breaks rbd test
Date: Tue, 27 Nov 2012 19:58:45 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211271957150.27728@cobra.newdream.net>
References: <50B57522.4060601@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41104 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171Ab2K1D6q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Nov 2012 22:58:46 -0500
In-Reply-To: <50B57522.4060601@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dan.mick@inktank.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org

Ah, crap.

Okay, I think we should take the existing TMAPRM op and re-add the ENOENT 
check, and then change the mds to use a new TMAPRMSLOPPY op that doesn't 
error out.

sage


On Tue, 27 Nov 2012, Dan Mick wrote:

> tmap_rm() no longer fails on nonexistent keys
> (29fae494d0b1459c8bb934d42446e0ada7355402)
> 
> causing rbd_remove of nonexistent image to succeed without error
> (because, in the case that there's no header object, rbd_remove
> keeps trying to clean up other bits like rbd_directory; in so doing, it relies
> on tmap_rm() to fail removing the key from rbd_directory, or else it assumes
> that this was an old-style image that we've just removed the last trace of and
> returns success)
> 
> This breaks test_rbd.test_remove_dne in test/pybind/test_rbd.py
> 
> 
> We could change librbd obviously.  Did you scan for other users,
> though?...maybe there are more lurking
> 
> Thoughts?
> 
> 
> 
