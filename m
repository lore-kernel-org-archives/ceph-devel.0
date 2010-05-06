From: Christian Brunner <chb@muc.de>
Subject: Re: [PATCH] ceph: re-enable rados_aio_set_callback
Date: Thu, 6 May 2010 22:41:38 +0200
Message-ID: <20100506204138.GA57773@ncolin.muc.de>
References: <20100505195053.GA50246@ncolin.muc.de> <h2oa37615151005051322z8a2c781ajdfe4f31fef78a8a1@mail.gmail.com> <Pine.LNX.4.64.1005051425180.16467@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ncolin.muc.de ([193.149.48.11]:56426 "EHLO ncolin.muc.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932239Ab0EFUlp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 6 May 2010 16:41:45 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1005051425180.16467@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Wed, May 05, 2010 at 09:40:47PM +0000, Sage Weil wrote:
> 
> I think being able to specify a callback for each would be the most 
> flexible.  Also, to be clear, setting adjusting the completions callback 
> is safe if it happens prior to the completion being used (before calling 
> aio_read or whatever).  After that I don't think we should make any 
> promises.
> 
> The patch below changes the API a bit.  Since I think kvm-rbd is the only 
> aio callback user so far, I'm going to be lazy and skip any compat cruft 
> to maintain compatibility.  Does this look okay?

The patch is looking good and it makes using the callback even simpler.
I will send a patch for qemu in a few minutes.

Christian
