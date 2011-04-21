From: Christoph Hellwig <hch@lst.de>
Subject: Re: [Qemu-devel] [qemu-iotests][PATCH] Update rbd support
Date: Thu, 21 Apr 2011 08:49:16 +0200
Message-ID: <20110421064916.GA2606@lst.de>
References: <cover.1302653035.git.josh.durgin@dreamhost.com> <1302655665-30101-1-git-send-email-josh.durgin@dreamhost.com> <20110413024339.GA16779@lst.de> <c87587fab7b312c58c7d59ac6117eff5@hq.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:40619 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752286Ab1DUGtR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 21 Apr 2011 02:49:17 -0400
Content-Disposition: inline
In-Reply-To: <c87587fab7b312c58c7d59ac6117eff5@hq.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: Christoph Hellwig <hch@lst.de>, ceph-devel@vger.kernel.org, qemu-devel@nongnu.org, kvm@vger.kernel.org

On Tue, Apr 12, 2011 at 10:42:00PM -0700, Josh Durgin wrote:
> > I suspect we only support the weird writing past size for the
> > file protocol, so we should only run the test for it.
> > 
> > Or does sheepdog do anything special about it?
> 
> Sheepdog supports it by truncating to the right size if a write
> would be past the end. I'm not sure if other protocols support
> it.

I've changed 016 to require the file or sheepdog protocols, and then
applied the rest of your patch.  Thanks a lot!
