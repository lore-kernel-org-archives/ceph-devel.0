From: Sage Weil <sage@inktank.com>
Subject: Re: stuff for v0.56.4
Date: Thu, 7 Mar 2013 13:27:18 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1303071326430.17054@cobra.newdream.net>
References: <201303072105.r27L5P4E028007@ayesha.phys.virginia.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59924 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932815Ab3CGV1S (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Mar 2013 16:27:18 -0500
In-Reply-To: <201303072105.r27L5P4E028007@ayesha.phys.virginia.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Bryan K. Wright" <bkw1a@ayesha.phys.virginia.edu>
Cc: ceph-devel@vger.kernel.org

On Thu, 7 Mar 2013, Bryan K. Wright wrote:
> 
> sage@inktank.com said:
> > - pg log trimming (probably a conservative subset) to avoid memory bloat 
> 
> Anything that reduces the size of OSD processes would be appreciated.

You can probably do this with just

 log max recent = 1000

By default it's keeping 100k lines of logs in memory, which can eat a lot 
of ram (but is great when debugging issues).

s


> 
> 					Bryan
> -- 
> ========================================================================
> Bryan Wright              |"If you take cranberries and stew them like 
> Physics Department        | applesauce, they taste much more like prunes
> University of Virginia    | than rhubarb does."  --  Groucho 
> Charlottesville, VA  22901|			
> (434) 924-7218            |         bryan@virginia.edu
> ========================================================================
> 
> 
> 
