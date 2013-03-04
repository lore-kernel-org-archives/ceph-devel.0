From: Sage Weil <sage@inktank.com>
Subject: Re: "--restart" broken due to bug in init script?
Date: Mon, 4 Mar 2013 12:34:31 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1303041234210.14723@cobra.newdream.net>
References: <201303041832.r24IWN3f029106@ayesha.phys.virginia.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53597 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932185Ab3CDUen (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 15:34:43 -0500
In-Reply-To: <201303041832.r24IWN3f029106@ayesha.phys.virginia.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Bryan K. Wright" <bkw1a@ayesha.phys.virginia.edu>
Cc: ceph-devel@vger.kernel.org

Thanks, fixing this up in the master branch.

sage

On Mon, 4 Mar 2013, Bryan K. Wright wrote:

> Hi folks,
> 
> 	It looks like the "--restart" option in the ceph init script
> is broken.  The flag sets the variable "$docrun", but then
> later, when it's tested, the script looks for "$crun" instead.
> 
> 					Bryan
> 
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
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
