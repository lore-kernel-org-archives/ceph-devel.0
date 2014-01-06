From: Greg KH <greg@kroah.com>
Subject: Re: Ceph fixes for 3.10.y
Date: Mon, 6 Jan 2014 14:09:17 -0800
Message-ID: <20140106220917.GC4919@kroah.com>
References: <alpine.DEB.2.00.1312310819370.19234@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44544 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754093AbaAFWIx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Jan 2014 17:08:53 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1312310819370.19234@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: stable@vger.kernel.org, ceph-devel@vger.kernel.org

On Tue, Dec 31, 2013 at 08:21:19AM -0800, Sage Weil wrote:
> Hi Greg,
> 
> This is a somewhat long overdue set of fixes for 3.10.y.  Since there 
> are a lot of patches, they can be pulled from
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-stable-3.10.24
> 
> If you prefer, I can send them as separate emails instead.  Note that this 
> branch includes the 2 patches from the 3.12.y series you already picked 
> up.
> 
> They are all reviewed, retested, and reference the original upstream 
> commit (via git cherry-pick -x).

I've applied all of these now, but please be careful when doing these
backports, your "cherrypicked from" lines didn't all match up with real
git ids in Linus's tree (hint look at the patches that had multiple
cherry-pick lines...)

thanks,

greg k-h
